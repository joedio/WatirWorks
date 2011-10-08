# http://code.google.com/p/wwatf/source/browse/#svn/trunk/util
#
#  r4  by liujunjun on April 16, 2009

require 'win32ole'
require 'logger'

#Excel interface class.
#This class provides many simple methods to reading data records from Excel spreadsheets.
#Below is a brief example of how to use this class (see unit test (test_XLS.rb) for more usage examples)
# require 'xls'
# xlFile = XLS.new('c:\myData.xls')
# myData = xlFile.get2DArray('B1:D3','Sheet 1')
# xlFile.close
# doSomething(myData)
class XLS
  attr_accessor :excel
  attr_accessor :workbook
  # initialize creates an XLS instance for a given .xls file.
  #If the File is already open in excel, data is read from the open file and left open after the call to the close method.
  #If the file is not open, It will be opened in the background and closed when the close method is called.
  def initialize(file, debug = false)
    @excelOpen = false
    @fileOpen=false
    @log = Logger.new(STDOUT)
    @log.level = Logger::WARN
    @log.level = Logger::DEBUG if debug
    begin
      @excel = WIN32OLE.connect("excel.application")
      @excelOpen = true
      tmp = File.split(file)
      fileName = tmp.pop
      @workbook = @excel.Workbooks(fileName)
      @fileOpen=true
      @log.info("Attached to open Workbook: #{fileName}")
    rescue
      begin
        @excel = WIN32OLE::new('excel.Application') if not @excelOpen
        @log.info("Excel Application Opened")
        @workbook = @excel.Workbooks.Open(file) if not @fileOpen
        @log.info("File: #{file} opened")
      rescue
        @log.error("Error attaching: excelOpen: #{@excelOpen} , fileOpen: #{@fileOpen}, file: #{file} error: #{$!}")
        raise
      end
    end
  end
  
  
  #Returns an array of hashes representing data records stored in rows in the given *myRange* and *sheet*.
  # *myRange* can either be a string representing a range: "A1:C4", a named range defined in the workbook: "SomeNamedRange", or the text in a cell "myRangeing" a contiguous table of values below it. If it is nil or not specified the CurrentRegion starting at "A1" is used.
  #Note: *myRange* should include headers, and may contain non-contiguous column ranges of equal size
  #EXAMPLE DATA:
  #           A                        B                      C
  #  1        ID                   name                            nickname
  #  2       001                Fredrick White           fred
  #  3       002                    Robert Green               bob
  #
  #Standard Range example:
  # getRowRecords("A1:C3") would return the following array of hashes:
  #  [  {'ID'=>'001', 'Name'=>'Fredrick White', 'Nickname'=>'fred'},
  #     {'ID'=>'002', 'Name'=>'Robert Green', 'Nickname'=>'bob'}  ]
  #
  #Non-Contiguous Range Example:
  # getRowRecords("A1:A3,C1:C3") would return the following array of hashes:
  #  [  {'ID'=>'001', 'Nickname'=>'fred'},
  #     {'ID'=>'002', 'Nickname'=>'bob'}  ]
  def getRowRecords(myRange,sheet = nil)
    return convert2DArrayToArrayHash(get2DArray(myRange,sheet),true)
  end
  
  
  #Returns an array of hashes representing data records stored in rows in the given *myRange* and *sheet*.
  # *myRange* can either be a string representing a range: "A1:C4", a named range defined in the workbook: "SomeNamedRange", or the text in a cell "myRangeing" a contiguous table of values below it. If it is nil or not specified the CurrentRegion starting at "A1" is used.
  #Note: *myRange* should include headers, and may contain non-contiguous column ranges of equal size
  #EXAMPLE DATA:
  #           A                  B                           C
  #  1        ID              001                          002
  #  2       Name           Fredrick White                   Robert Green
  #  3       NickName     fred                         bob
  #
  #Standard Range Example:
  # getColumnRecords("A1:C3") would return the following array of hashes:
  #  [  {'ID'=>'001', 'Name'=>'Fredrick White', 'Nickname'=>'fred'},
  #     {'ID'=>'002', 'Name'=>'Robert Green', 'Nickname'=>'bob'}  ]
  def getColumnRecords(myRange,sheet = nil)
    return convert2DArrayToArrayHash(get2DArray(myRange,sheet),false)
  end
  
  
  
  #returns a 2D Array representing the given range of Data stored in a given worksheet
  #Note: All contiguous ranges are supported, however, only non-contiguous column selections of equal size are accepted.
  # *myRange* can either be a string representing a range: "A1:C4", a named range defined in the workbook: "SomeNamedRange", or the text in a cell "myRangeing" a contiguous table of values below it. If it is nil or not specified the CurrentRegion starting at "A1" is used.
  #
  #EXAMPLE DATA:
  #           A                        B                      C
  #  1        ID                   name                            nickname
  #  2       001                Fredrick White           fred
  #  3       002                    Robert Green               bob
  #RETURNS:
  # Calling get2DArray("A1:C3") would return the following 2D array
  #  [[ID, name, nickname],
  #   [001, Fredrick White, fred],
  #   [002, Robert Green, bob]]
  def get2DArray(myRange,sheet=nil)
    @log.info("get2DArray(myRange=#{myRange}, sheet = #{sheet}")
    #    puts ("get2DArray(myRange=#{myRange}, sheet = #{sheet}")
    myRange = getRange(myRange,sheet)
    if myRange == nil
      return nil
    end
    data = []
    areas = []
    
    #Deal with non-contiguous regions by looping through each region.
    myRange.Areas.each do |area|
      areas << area.value #get the data from each area
    end
    
    numRecords = myRange.Rows.Count
     (0..numRecords-1).each do |i|
      record=[]
      areas.each do |area|
        if (area.kind_of?Array)
          record.concat(area[i])
        else
          record << area
        end
      end
      #Clean up formatting
      record.collect! do |x|
        if x.is_a?(Float) and x % 1 == 0
          x.to_i.to_s
        else
          x.to_s.strip
        end
      end
      data << record
    end
    return data
  end
  
  
  
  #Returns a hash of key-value pairs where the keys are pulled from column 1 and the values are pulled form column 2 of *myRange* on *sheet*.
  # *myRange* can either be a string representing a range: "A1:C4", a named range defined in the workbook: "SomeNamedRange", or the text in a cell "labeling" a contiguous table of values below it. If it is nil or not specified the CurrentRegion starting at "A1" is used.
  #Note: ':'s are striped off of each key if they exist.
  #EXAMPLE DATA:
  #           A                  B
  #  1        ID              001
  #  2       Name:           Fredrick White
  #  3       NickName:    fred
  #Example usage:
  # getHashFromRange("A1:B3") would return the following hash:
  #  {'ID'=>'001', 'Name'=>'Fredrick White', 'Nickname'=>'fred'}
  def getHash(myRange,sheet = nil)
    tmpHash = convert2DArrayToArrayHash(get2DArray(myRange,sheet),false)[0]
    newHash = OrderedHash.new
    tmpHash.each do |key,value|
      newHash[key.sub(/:/,'')] = value
    end
    return newHash
  end
  
  #*myArray* should either have column or row headers to use as keys.  columnHeader=false implies that there are row headers.
  def convert2DArrayToArrayHash(myArray,columnHeaders=true)
    myArray = myArray.transpose unless columnHeaders
    arrayHash=[]
     (1..myArray.length-1).each do |i|
      rowHash = Hash.new #OrderedHash.new  #
       (0..myArray[i].length-1).each do |j|
        #       puts j
        #       puts myArray[0][j]
        rowHash[myArray[0][j]] = myArray[i][j]
      end
      arrayHash << rowHash
      #      puts rowHash.keys[0]
    end
    return arrayHash
  end
  
  def convertArrayHashTo2DArray(myArrayHash)
    @log.info("convertArrayHashTo2DArray(myArrayHash)")
    return [] if myArrayHash.empty?
    
    my2DArray = []
    # iterate through keys write out header row
    myKeys = myArrayHash[0].keys
    my2DArray << myKeys
    #write out data
     (0..myArrayHash.length-1).each do |row|
      myRow = []
      myKeys.each do |key|
        myRow << myArrayHash[row][key]
      end
      my2DArray << myRow
    end
    return my2DArray
  end
  
  
  
  #Searches for the first occurrence of *myRange* on *sheet* and returns the address of the range representing the contiguous set of cells below(xlDown) and to the right(xlRight) of *myRange*
  #If *sheet* is not specified, the first sheet is used.
  # *myRange* can either be a string representing a range: "A1:C4", a named range defined in the workbook: "SomeNamedRange", or the text in a cell "myRangeing" a contiguous table of values below it. If it is nil or not specified the CurrentRegion starting at "A1" is used.
  def getRange(myRange="",sheet=nil)
    @log.info("getRange(myRange=#{myRange}, sheet=#{sheet}")
    worksheet = getWorksheet(sheet)
    if worksheet == nil
      return nil
    end
    #find where the data is
    if myRange.nil? or myRange == ""
      rng=worksheet.Range("A1").CurrentRegion
    else
      begin
        #use myRange as an excel range if it is one
        rng = worksheet.Range(myRange)
      rescue WIN32OLERuntimeError  #must not be a standard excel range...  look for the myRange.
        rng = worksheet.Range("A1",worksheet.UsedRange.SpecialCells(11)).Find(myRange) #xlCellTypeLastCell
        raise "getRange(myRange=#{myRange}, sheet=#{sheet}) --> Could not locate range via specified myRange." unless rng
        rng = rng.Offset(1)
        rng = worksheet.Range(rng,rng.End(-4121)) #-4121 --> xlDown
        rng = worksheet.Range(rng,rng.End(-4161)) #-4161  --> xlToRight
      end
    end
    return rng
  end
  
  
  
  
  def getWorksheet(sheet=nil)
    if sheet.nil?
      worksheet = @workbook.Worksheets(1)
    elsif sheet.instance_of?(Regexp)
      @workbook.Worksheets.each do |s|
        return s if s.Name.match(sheet)
      end
    else
      begin
        worksheet = @workbook.Worksheets(sheet)
      rescue
        @log.info("getWorksheet(sheet=#{sheet}) --> Sheet '#{sheet}' COULD NOT BE FOUND")
        #      raise(RuntimeError,"getWorksheet(sheet=#{sheet}) --> Sheet '#{sheet}' COULD NOT BE FOUND")
        return nil
      end
      
    end
    @log.info("getWorksheet(sheet=#{sheet}) --> #{worksheet.Name}")
    return worksheet
  end
  
  # Adds a new worksheet to workbook
  def addSheet(sheetName)
    @workbook.Sheets.Add
    @workbook.ActiveSheet.Name = sheetName
  end
  # Deletes a worksheet from the workbook
  def deleteSheet(sheetName)
    @excel.DisplayAlerts=false
    sheet = getWorksheet(sheetName)
    sheet.delete
    @excel.DisplayAlerts=true
  end
  #Closes Workbook if it was opened. Exits Excel if opened.
  def close
    if not @fileOpen
      @workbook.Close(false)
      @log.info("Workbook Closed")
    end
    if not @excelOpen
      @excel.quit
      @log.info("Excel Application Closed")
    end
  end
  
  #writes out the 2D Array  *data* starting at the specified range *myRange* on the specified sheet
  def write2DArray(data, myRange,sheet = nil)
    @log.info("write2DArray(data='...',myRange='#{myRange}', sheet = '#{sheet})'")
    worksheet = getWorksheet(sheet)
    #get the actual excel range object
    myRange = worksheet.Range(myRange)
     (0..data.length-1).each do |row|
     (0..data[row].length-1).each do |col|
        myRange.Offset(row,col).value=data[row][col]
      end
    end
  end
  
  #writes out the Array hash  *data* starting at the specified range *myRange* on the specified sheet.
  #the keys are used as column headers starting at the specified range.
  def writeArrayHash(data, myRange,sheet = nil)
    @log.info("writeArrayHash(data='...',myRange='#{myRange}', sheet = '#{sheet})'")
    write2DArray(convertArrayHashTo2DArray(data),myRange,sheet)
  end
  
  #Saves the current workbook.
  def save
    @workbook.Save
  end
  
  
  #outputs a 2DArray *myArray* to a CSV file specified by *file*.
  def save2DArraytoCSVFile(myArray,file)
    myFile = File.open(file,'w')
    @log.info("2DArraytoCSVFile(myArray=..., file=#{file})")
     (0..myArray.length-1).each do |i|
      myFile.puts(myArray[i].join(',')) unless myArray[i].nil?
    end
    myFile.close
  end
end



class OrderedHash < Hash
  alias_method :store, :[]=
  alias_method :each_pair, :each
  
  def initialize()
    @keys = []
    super
  end
  
  def []=(key, val)
    @keys << key
    # test for keys arrangement
    super
  end
  
  def delete(key)
    @keys.delete(key)
    super
  end
  
  def each
    @keys.each { |k| yield k, self[k] }
  end
  
  def each_key
    @keys.each { |k| yield k }
  end
  
  def each_value
    @keys.each { |k| yield self[k] }
  end
end
