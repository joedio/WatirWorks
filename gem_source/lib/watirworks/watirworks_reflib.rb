#=============================================================================#
# File: watirworks_reflib.rb
#
#  Copyright (c) 2008-2016, Joe DiMauro
#  All rights reserved.
#
# Description: Reference data that is platform and application independent.
#
#--
# Modules: Reference - Application independent values including arrays, hashes,
#                      constants, and global variables.
#
#++
#=============================================================================#

#=============================================================================#
# Require and Include section
# Entries for additional files or methods needed by these methods
#=============================================================================#
require 'rubygems'

#=============================================================================#
# Module: WatirWorks_RefLib
#=============================================================================#
#
# Description:  Reference data that is platform and application independent.
#
#               For example, use the hash table USPS_STATES to lookup
#               the full name of a state from its abbreviation.
#
# Instructions: To use the reference data in your scripts add these commands:
#                  require 'watirworks'
#                  include WatirWorks_RefLib
#
#--
# Roadmap: Perhaps add other Geo-specific Data like: Continents, Capitals, Cities, Counties, Planets?
#          Weights & Measures conversion chart? (MileToFeet = 5280)
#          Astrological Signs?, who knows, so long as its useful.
#          For example: Geo-political data is available at:
#              https://www.cia.gov/library/publications/the-world-factbook/
#++
#=============================================================================#

module WatirWorks_RefLib

  # Version of this module
  WW_REFLIB_VERSION = "1.2.2"

  # Format to use when appending a timestamp to file names
  DATETIME_FILEFORMAT="%Y_%m_%d_%H%M%S"

  # Common time constants for year, month, and day
  # Year strings (yyyy)
  THIS_YEAR=Time.new.year.to_s
  NEXT_YEAR=(Time.new.year + 1).to_s
  LAST_YEAR=(Time.new.year - 1).to_s

  # Define strings with only the last 2-digits of the year (e.g. 08 for 2008)
  # Remember for strings index 0 is the 1st character
  THIS_YR = THIS_YEAR[2,3]
  NEXT_YR = NEXT_YEAR[2,3]
  LAST_YR = LAST_YEAR[2,3]

  # This month string (01-12)
  THIS_MONTH=Time.new.month.to_s

  # This Day string (01-31)
  THIS_DAY=Time.new.day.to_s

  #   Define the format for date strings
  #
  # Formatting parameters for methods:
  #            time.strptime(string[, format])
  #            time.strftime([format,] time)
  #
  #     %a - The abbreviated weekday name (``Sun'')
  # %A - The  full  weekday  name (``Sunday'')
  # %b - The abbreviated month name (``Jan'')
  # %B - The  full  month  name (``January'')
  # %c - The preferred local date and time representation
  # %C - Century (20 in 2009)
  # %d - Day of the month (01..31)
  # %D - Date (%m/%d/%y)
  # %e - Day of the month, blank-padded ( 1..31)
  # %F - Equivalent to %Y-%m-%d (the ISO 8601 date format)
  # %h - Equivalent to %b
  # %H - Hour of the day, 24-hour clock (00..23)
  # %I - Hour of the day, 12-hour clock (01..12)
  # %j - Day of the year (001..366)
  # %k - hour, 24-hour clock, blank-padded ( 0..23)
  # %l - hour, 12-hour clock, blank-padded ( 0..12)
  # %L - Millisecond of the second (000..999)
  # %m - Month of the year (01..12)
  # %M - Minute of the hour (00..59)
  # %n - Newline (\n)
  # %N - Fractional seconds digits, default is 9 digits (nanosecond)
  #         %3N  millisecond (3 digits)
  #         %6N  microsecond (6 digits)
  #         %9N  nanosecond (9 digits)
  # %p - Meridian indicator (``AM''  or  ``PM'')
  # %P - Meridian indicator (``am''  or  ``pm'')
  # %r - time, 12-hour (same as %I:%M:%S %p)
  # %R - time, 24-hour (%H:%M)
  # %s - Number of seconds since 1970-01-01 00:00:00 UTC.
  # %S - Second of the minute (00..60)
  # %t - Tab character (\t)
  # %T - time, 24-hour (%H:%M:%S)
  # %u - Day of the week as a decimal, Monday being 1. (1..7)
  # %U - Week  number  of the current year,
  #         starting with the first Sunday as the first
  #         day of the first week (00..53)
  # %v - VMS date (%e-%b-%Y)
  # %V - Week number of year according to ISO 8601 (01..53)
  # %W - Week  number  of the current year,
  #         starting with the first Monday as the first
  #         day of the first week (00..53)
  # %w - Day of the week (Sunday is 0, 0..6)
  # %x - Preferred representation for the date alone, no time
  # %X - Preferred representation for the time alone, no date
  # %y - Year without a century (00..99)
  # %Y - Year with century
  # %z - Time zone as  hour offset from UTC (e.g. +0900)
  # %Z - Time zone name
  # %% - Literal ``%'' character

  # Global flag to indicate if test runs on local system or remote system
  $bRunLocal = true

  sDateformat = "%m/%d/%Y"  # e.g. 12/31/2011
  #sDateformat = "%Y-%m-%d" # e.g. 2011-12-31

  # Set the current date
  dToday = Time.now

  # Calculate various strings representations of dates (both future and past) based on the current date
  TODAY = dToday.strftime(sDateformat)
  TOMORROW = (dToday + (60 * 60 * 24 * 1)).strftime(sDateformat)
  YESTERDAY = (dToday - (60 * 60 * 24 * 1)).strftime(sDateformat)

  DAYS_FUTURE_1 = (dToday + (60 * 60 * 24 * 1 * 1)).strftime(sDateformat)
  DAYS_FUTURE_2 = (dToday + (60 * 60 * 24 * 1 * 2)).strftime(sDateformat)
  DAYS_FUTURE_3 = (dToday + (60 * 60 * 24 * 1 * 3)).strftime(sDateformat)
  DAYS_FUTURE_4 = (dToday + (60 * 60 * 24 * 1 * 4)).strftime(sDateformat)
  DAYS_FUTURE_5 = (dToday + (60 * 60 * 24 * 1 * 5)).strftime(sDateformat)
  DAYS_FUTURE_6 = (dToday + (60 * 60 * 24 * 1 * 6)).strftime(sDateformat)
  DAYS_FUTURE_7 = (dToday + (60 * 60 * 24 * 1 * 7)).strftime(sDateformat)
  DAYS_FUTURE_8 = (dToday + (60 * 60 * 24 * 1 * 8)).strftime(sDateformat)
  DAYS_FUTURE_9 = (dToday + (60 * 60 * 24 * 1 * 9)).strftime(sDateformat)
  DAYS_FUTURE_10 = (dToday + (60 * 60 * 24 * 1 * 10)).strftime(sDateformat)
  DAYS_FUTURE_30 = (dToday + (60 * 60 * 24 * 1 * 30)).strftime(sDateformat)
  DAYS_FUTURE_60 = (dToday + (60 * 60 * 24 * 1 * 60)).strftime(sDateformat)
  DAYS_FUTURE_90 = (dToday + (60 * 60 * 24 * 1 * 90)).strftime(sDateformat)
  DAYS_FUTURE_365 = (dToday + (60 * 60 * 24 * 1 * 365)).strftime(sDateformat)

  DAYS_PAST_1 = (dToday - (60 * 60 * 24 * 1 * 1)).strftime(sDateformat)
  DAYS_PAST_2 = (dToday - (60 * 60 * 24 * 1 * 2)).strftime(sDateformat)
  DAYS_PAST_3 = (dToday - (60 * 60 * 24 * 1 * 3)).strftime(sDateformat)
  DAYS_PAST_4 = (dToday - (60 * 60 * 24 * 1 * 4)).strftime(sDateformat)
  DAYS_PAST_5 = (dToday - (60 * 60 * 24 * 1 * 5)).strftime(sDateformat)
  DAYS_PAST_6 = (dToday - (60 * 60 * 24 * 1 * 6)).strftime(sDateformat)
  DAYS_PAST_7 = (dToday - (60 * 60 * 24 * 1 * 7)).strftime(sDateformat)
  DAYS_PAST_8 = (dToday - (60 * 60 * 24 * 1 * 8)).strftime(sDateformat)
  DAYS_PAST_9 = (dToday - (60 * 60 * 24 * 1 * 9)).strftime(sDateformat)
  DAYS_PAST_10 = (dToday - (60 * 60 * 24 * 1 * 10)).strftime(sDateformat)
  DAYS_PAST_30 = (dToday - (60 * 60 * 24 * 1 * 30)).strftime(sDateformat)
  DAYS_PAST_60 = (dToday - (60 * 60 * 24 * 1 * 60)).strftime(sDateformat)
  DAYS_PAST_90 = (dToday - (60 * 60 * 24 * 1 * 90)).strftime(sDateformat)
  DAYS_PAST_365 = (dToday - (60 * 60 * 24 * 1 * 365)).strftime(sDateformat)

  WEEKS_FUTURE_1 = (dToday + (60 * 60 * 24 * 1 * 7 * 1)).strftime(sDateformat)
  WEEKS_FUTURE_2 = (dToday + (60 * 60 * 24 * 1 * 7 * 2)).strftime(sDateformat)
  WEEKS_FUTURE_4 = (dToday + (60 * 60 * 24 * 1 * 7 * 4)).strftime(sDateformat)
  WEEKS_FUTURE_8 = (dToday + (60 * 60 * 24 * 1 * 7 * 8)).strftime(sDateformat)
  WEEKS_FUTURE_12 = (dToday + (60 * 60 * 24 * 1 * 7 * 12)).strftime(sDateformat)
  WEEKS_FUTURE_52 = (dToday + (60 * 60 * 24 * 1 * 7 * 52)).strftime(sDateformat)

  WEEKS_PAST_1 = (dToday - (60 * 60 * 24 * 1 * 7 * 1)).strftime(sDateformat)
  WEEKS_PAST_2 = (dToday - (60 * 60 * 24 * 1 * 7 * 2)).strftime(sDateformat)
  WEEKS_PAST_4 = (dToday - (60 * 60 * 24 * 1 * 7 * 4)).strftime(sDateformat)
  WEEKS_PAST_8 = (dToday - (60 * 60 * 24 * 1 * 7 * 8)).strftime(sDateformat)
  WEEKS_PAST_12 = (dToday - (60 * 60 * 24 * 1 * 7 * 12)).strftime(sDateformat)
  WEEKS_PAST_52 = (dToday - (60 * 60 * 24 * 1 * 7 * 52)).strftime(sDateformat)

  # Save the current time to be used Globally for all test in a suite.
  #
  # This will ensure that the same time can be used throughout all the tests, and ensures
  # that if a STRING is created at one point in the test with a timestamp appended to it,
  # that the same timestamp can be re-used at subsequent points in all tests within a testsuite.
  TESTSUITE_START_TIME = Time.now

  # Define timestamp format for use with file names
  # The timestamp of 14 characters can be appended to a file name (e.g. mylogfile_2007_Dec_30_235959.log)
  # Example: sMyPrefix = "mylogfile"
  #          sMyExtension = ".log"
  #          sMyFilename = sMyPrefix + TIMESTAMP_STRING + sMyExtension
  TIMESTAMP_STRING = TESTSUITE_START_TIME.strftime("%Y_%m_%d_%H%M%S")

  #=============================================================================#
  # ObjectName: CANADIAN_PROVINCES
  # Returns: HASH
  #
  # Description: Contains a list of Canadian  Province/Territory abbreviations
  #              and their full names, from the web site:
  #                 http://canadaonline.about.com/library/bl/blpabb.htm
  #
  # Usage examples: CANADIAN_PROVINCES["MB"]  #=>  "Manitoba"
  #                 CANADIAN_PROVINCES.index "Manitoba"  #=>  "MB"
  #=============================================================================#
  CANADIAN_PROVINCES = {
    "AB" => "Alberta",
    "BC" => "British Columbia",
    "MB" => "Manitoba",
    "NB" => "New Brunswick",
    "NL" => "Newfoundland and Labrador",
    "NT" => "Northwest Territories",
    "NS" => "Nova Scotia",
    "NU" => "Nunavut",
    "ON" => "Ontario",
    "PE" => "Prince Edward Island",
    "QC" => "Quebec",
    "SK" => "Saskatchewan",
    "YT" => "Yukon"
  }

  # Hash with the keys and values flipped
  CANADIAN_PROVINCE_ABBREVIATION = CANADIAN_PROVINCES.invert

  #=============================================================================#
  # ObjectName: MEXICAN_STATES
  # Returns: HASH
  #
  # Description: Contains a list of Mexico's State abbreviations
  #              and their full names, from the web site:
  #                 http://www.iowa.gov/tax/forms/84055.pdf
  #
  # Usage examples: MEXICAN_STATES["BS"]  #=>  "Baja California Sur"
  #                 MEXICAN_STATES.index "Baja California Sur"  #=>  "BS"
  #=============================================================================#
  MEXICAN_STATES = {
    "AG" => "Aguascalientes",
    "BJ" => "Baja California",
    "BS" => "Baja California Sur",
    "CP" => "Campeche",
    "CH" => "Chiapas",
    "CI" => "Chihuahua",
    "CU" => "Coahuila",
    "CL" => "Colima",
    "DF" => "Distrito Federal",
    "DG" => "Durango",
    "GJ" => "Guanajuato",
    "GR" => "Guerrero",
    "HG" => "Hidalgo",
    "JA" => "Jalisco",
    "EM" => "Mexico",
    "MH" => "Michoacan",
    "MR" => "Morelos",
    "NA" => "Nayarit",
    "NL" => "Nuevo Leon",
    "OA" => "Oaxaca",
    "PU" => "Puebla",
    "QA" => "Queretaro",
    "QR" => "Quintana Roo",
    "SL" => "San Luis Potosi",
    "SI" => "Sinaloa",
    "SO" => "Sonora",
    "TA" => "Tabasco",
    "TM" => "Tamaulipas",
    "TL" => "Tlaxcala",
    "VZ" => "Veracruz",
    "YC" => "Yucatan",
    "ZT" => "Zacatecas"
  }

  # Hash with the keys and values flipped
  MEXICAN_STATE_ABBREVIATION = MEXICAN_STATES.invert

  #=============================================================================#
  # ObjectName: USPS_STATES
  # Returns: HASH
  #
  # Description: Contains a list of State abbreviations and their full names
  #              from the  United States Postal Service web site:
  #                 http:www.usps.com/ncsc/lookups/usps_abbreviations.html
  #
  # Usage examples: USPS_STATES["CO"]  #=>  "Colorado"
  #                 USPS_STATES.index "Colorado"  #=>  "CO"
  #=============================================================================#
  USPS_STATES = {
    "AL" => "Alabama",
    "AK" => "Alaska",
    "AS" => "American Samoa",
    "AZ" => "Arizona",
    "AR" => "Arkansas",
    "CA" => "California",
    "CO" => "Colorado",
    "CT" => "Connecticut",
    "DE" => "Delaware",
    "DC" => "District of Columbia",
    "FM" => "Federated States of Micronesia",
    "FL" => "Florida",
    "GA" => "Georgia",
    "GU" => "Guam",
    "HI" => "Hawaii",
    "ID" => "Idaho",
    "IL" => "Illinois",
    "IN" => "Indiana",
    "IA" => "Iowa",
    "KS" => "Kansas",
    "KY" => "Kentucky",
    "LA" => "Louisiana",
    "ME" => "Maine",
    "MH" => "Marshall Islands",
    "MD" => "Maryland",
    "MA" => "Massachusetts",
    "MI" => "Michigan",
    "MN" => "Minnesota",
    "MS" => "Mississippi",
    "MO" => "Missouri",
    "MT" => "Montana",
    "NE" => "Nebraska",
    "NH" => "New Hampshire",
    "NJ" => "New Jersey",
    "NM" => "New Mexico",
    "NY" => "New York",
    "NC" => "North Carolina",
    "ND" => "North Dakota",
    "NV" => "Nevada",
    "MP" => "Northern Mariana Islands",
    "OH" => "Ohio",
    "OK" => "Oklahoma",
    "OR" => "Oregon",
    "PW" => "Palau",
    "PA" => "Pennsylvania",
    "PR" => "Puerto Rico",
    "RI" => "Rhode Island",
    "SC" => "South Carolina",
    "SD" => "South Dakota",
    "TN" => "Tennessee",
    "TX" => "Texas",
    "UT" => "Utah",
    "VI" => "Virgin Islands",
    "VA" => "Virginia",
    "WA" => "Washington",
    "WV" => "West Virginia",
    "WI" => "Wisconsin",
    "WY" => "Wyoming"
  }

  # Hash with the keys and values flipped
  USPS_STATE_ABBREVIATION = USPS_STATES.invert

  #=============================================================================#
  # ObjectName: USPS_SECONDARY_UNIT_DESIGNATOR
  # Returns: HASH
  #
  # Description: Contains a list of Secondary Unit Designators and their abbreviations
  #              from the United States Postal Service web site:
  #                 http:www.usps.com/ncsc/lookups/usps_abbreviations.html
  #
  # Usage examples: USPS_SECONDARY_UNIT_DESIGNATOR["PENTHOUSE"] # => "PH"
  #                 USPS_SECONDARY_UNIT_DESIGNATOR.index "PH" #=> "PENTHOUSE"
  #=============================================================================#
  USPS_SECONDARY_UNIT_DESIGNATOR = {
    "APARTMENT" => "APT",
    "BASEMENT" => "BSMT",
    "BUILDING" => "BLDG",
    "DEPARTMENT" => "DEPT",
    "FLOOR" => "FL",
    "FRONT" => "FRNT",
    "HANGAR" => "HNGR",
    "LOBBY" => "LBBY",
    "LOT" => "LOT",
    "LOWER" => "LOWR",
    "OFFICE"	=> "OFC",
    "PENTHOUSE" => "PH",
    "PIER" => "PIER",
    "REAR" => "REAR",
    "ROOM" => "RM",
    "SIDE" => "SIDE",
    "SLIP" => "SLIP",
    "SPACE" => "SPC",
    "STOP" => "STOP",
    "SUITE" => "STE",
    "TRAILER" => "TRLR",
    "UNIT" => "UNIT",
    "UPPER" => "UPPR"
  }

  #=============================================================================#
  # ObjectName: USPS_STREET_SUFFIX
  # Returns: HASH
  #
  # Description: Contains a list of Street Suffixes and their abbreviations
  #              from the United States Postal Service web site:
  #                 http:www.usps.com/ncsc/lookups/usps_abbreviations.html
  #
  # Usage examples: USPS_STREET_SUFFIX["DRIVE"] # => "DR"
  #                 USPS_STREET_SUFFIX.index "DR" #=> "DRIVE"
  #=============================================================================#
  USPS_STREET_SUFFIX = {
    'ALLEY' =>'ALY',
    'ANNEX' => ' ANX',
    'ARCADE' => 'ARC',
    'AVENUE' => 'AVE',
    'BAYOO' => 'BYU',
    'BEACH' => 'BCH',
    'BEND' => 'BND',
    'BLUFF' => 'BLF',
    'BLUFFS' => 'BLFS',
    'BOTTOM' => 'BTM',
    'BOULEVARD' => 'BLVD',
    'BRANCH' => 'BR',
    'BRIDGE' => 'BRG',
    'BROOK' => 'BRK',
    'BROOKS' => 'BRKS',
    'BURG' => 'BG',
    'BURGS' => 'BGS',
    'BYPASS' => 'BYP',
    'CAMP' => 'CP',
    'CANYON' => 'CYN',
    'CAPE' => 'CPE',
    'CAUSEWAY' => 'CSWY',
    'CENTER' => 'CTR',
    'CENTERS' => 'CTRS',
    'CIRCLE' => 'CIR',
    'CIRCLES' => 'CIRS',
    'CLIFF' => 'CLF',
    'CLIFFS' => 'CLFS',
    'CLUB' => 'CLB',
    'COMMON' => 'CMN',
    'CORNER' => 'COR',
    'CORNERS' => 'CORS',
    'COURSE' => 'CRSE',
    'COURT' => 'CT',
    'COURTS' => 'CTS',
    'COVE' => 'CV',
    'COVES' => 'CVS',
    'CREEK' => 'CRK',
    'CRESCENT' => 'CRES',
    'CREST' => 'CRST',
    'CROSSING' => 'XING',
    'CROSSROAD' => 'XRD',
    'CURVE' => 'CURV',
    'DALE' => 'DL',
    'DAM' => 'DM',
    'DIVIDE' => 'DV',
    'DRIVE' => 'DR',
    'DRIVES' => 'DRS',
    'ESTATE' => 'EST',
    'ESTATES' => 'ESTS',
    'EXPRESSWAY' => 'EXPY',
    'EXTENSION' => 'EXT',
    'EXTENSIONS' => 'EXTS',
    'FALL' => 'FALL',
    'FALLS' => 'FLS',
    'FERRY' => 'FRY',
    'FIELD' => 'FLD',
    'FIELDS' => 'FLDS',
    'FLAT' => 'FLT',
    'FLATS' => 'FLTS',
    'FORD' => 'FRD',
    'FORDS' => 'FRDS',
    'FOREST' => 'FRST',
    'FORGE' => 'FRG',
    'FORGES' => 'FRGS',
    'FORK' => 'FRK',
    'FORKS' => 'FRKS',
    'FORT' => 'FT',
    'FREEWAY' => 'FWY',
    'GARDEN' => 'GDN',
    'GARDENS' => 'GDNS',
    'GATEWAY' => 'GTWY',
    'GLEN' => 'GLN',
    'GLENS' => 'GLNS',
    'GREEN' => 'GRN',
    'GREENS' => 'GRNS',
    'GROVE' => 'GRV',
    'GROVES' => 'GRVS',
    'HARBOR' => 'HBR',
    'HARBORS' => 'HBRS',
    'HAVEN' => 'HVN',
    'HEIGHTS' => 'HTS',
    'HIGHWAY' => 'HWY',
    'HILL' => 'HL',
    'HILLS' => 'HLS',
    'HOLLOW' => 'HOLW',
    'INLET' => 'INLT',
    'ISLAND' => 'IS',
    'ISLANDS' => 'ISS',
    'ISLE' => 'ISLE',
    'JUNCTION' => 'JCT',
    'JUNCTIONS' => 'JCTS',
    'KEY' => 'KY',
    'KEYS' => 'KYS',
    'KNOLL' => 'KNL',
    'KNOLLS' => 'KNLS',
    'LAKE ' => 'LK',
    'LAKES' => 'LKS',
    'LAND' => 'LAND',
    'LANDING' => 'LNDG',
    'LANE' => 'LN',
    'LIGHT' => 'LGT',
    'LIGHTS' => 'LGTS',
    'LOAF' => 'LF',
    'LOCK' => 'LCK',
    'LOCKS' => 'LCKS',
    'LODGE' => 'LDG',
    'LOOP' => 'LOOP',
    'MALL' => 'MALL',
    'MANOR' => 'MNR',
    'MANORS' => 'MNRS',
    'MEADOW' => 'MDW',
    'MEADOWS' => 'MDWS',
    'MEWS' => '	MEWS',
    'MILL' => 'ML',
    'MILLS' => 'MLS',
    'MISSION' => 'MSN',
    'MOTORWAY' => 'MTWY',
    'MOUNT' => 'MT',
    'MOUNTAIN' => 'MTN',
    'MOUNTAINS' => 'MTNS',
    'NECK' => 'NCK',
    'ORCHARD' => 'ORCH',
    'OVAL' => 'OVAL',
    'OVERPASS' => 'OPAS',
    'PARK' => 'PARK',
    'PARKWAY' => 'PKWY',
    'PARKWAYS' => 'PKWY',
    'PASS' => 'PASS',
    'PASSAGE' => 'PSGE',
    'PATH' => 'PATH',
    'PIKE' => 'PIKE',
    'PINE' => 'PNE',
    'PINES' => 'PNES',
    'PLACE' => 'PL',
    'PLAIN' => 'PLN',
    'PLAINS' => 'PLNS',
    'PLAZA' => 'PLZ',
    'POINT' => 'PT',
    'POINTS' => 'PTS',
    'PORT' => 'PRT',
    'PORTS' => 'PRTS',
    'PRAIRIE' => 'PR',
    'RADIAL' => 'RADL',
    'RAMP' => 'RAMP',
    'RANCH' => 'RNCH',
    'RAPID' => 'RPD',
    'RAPIDS' => 'RPDS',
    'REST' => 'RST',
    'RIDGE' => 'RDG',
    'RIDGES' => 'RDGS',
    'RIVER' => 'RIV',
    'ROAD' => 'RD',
    'ROADS' => 'RDS',
    'ROUTE' => 'RTE',
    'ROW' => 'ROW',
    'RUE' => 'RUE',
    'RUN' => 'RUN',
    'SHOAL' => 'SHL',
    'SHOALS' => 'SHLS',
    'SHORE' => 'SHR',
    'SHORES' => 'SHRS',
    'SKYWAY' => 'SKWY',
    'SPRING' => 'SPG',
    'SPRINGS' => 'SPGS',
    'SPUR' => 'SPUR',
    'SPURS' => 'SPUR',
    'SQUARE' => 'SQ',
    'SQUARES' => 'SQS',
    'STATION' => 'STA',
    'STRAVENUE' => 'STRA',
    'STREAM' => 'STRM',
    'STREET' => 'ST',
    'STREETS' => 'STS',
    'SUMMIT' => 'SMT',
    'TERRACE' => 'TER',
    'THROUGHWAY' => 'TRWY',
    'TRACE' => 'TRCE',
    'TRACK' => 'TRAK',
    'TRAFFICWAY' => 'TRFY',
    'TRAIL' => 'TRL',
    'TUNNEL' => 'TUNL',
    'TURNPIKE' => 'TPKE',
    'UNDERPASS' => 'UPAS',
    'UNION' => 'UN',
    'UNIONS' => 'UNS',
    'VALLEY' => 'VLY',
    'VALLEYS' => 'VLYS',
    'VIADUCT' => 'VIA',
    'VIEW' => 'VW',
    'VIEWS' => 'VWS',
    'VILLAGE' => 'VLG',
    'VILLAGES' => 'VLGS',
    'VILLE' => 'VL',
    'VISTA' => 'VIS',
    'WALK' => 'WALK',
    'WALKS' => 'WALK',
    'WALL' => 'WALL',
    'WAY' => 'WAY',
    'WAYS' => 'WAYS',
    'WELL' => 'WL',
    'WELLS' => 'WLS'
  }

  #=============================================================================#
  # ObjectName: COUNTRY_CODES
  # Returns: Hash
  #
  # Description: Contains a list of Country Code abbreviations
  #              The 3-character codes are supplied by UN which also
  #              and numerical codes to identify nations.
  #
  #              From the web site:
  #                   http://www.worldatlas.com/aatlas/ctycodes.htm
  #
  # Usage examples: COUNTRY_CODES["USA"] # : "United States of America"
  #                 COUNTRY_CODES_ABBREVIATION["United Arab Emirates"] #: "UAE"
  #=============================================================================#
  COUNTRY_CODES = {
    "Afghanistan" => "AFG",
    "Albania" => "ALB",
    "Algeria" => "DZA",
    "American Samoa" => "ASM",
    "Andorra" => "AND",
    "Angola" => "AGO",
    "Anguilla" => "AIA",
    "Antarctica" => "ATA",
    "Antigua and Barbuda" => "ATG",
    "Argentina" => "ARG",
    "Armenia" => "ARM",
    "Aruba" => "ABW",
    "Australia" => "AUS",
    "Austria" => "AUT",
    "Azerbaijan" => "AZE",
    "Bahamas" => "BHS",
    "Bahrain" => "BHR",
    "Bangladesh" => "BGD",
    "Barbados" => "BRB",
    "Belarus" => "BLR",
    "Belgium" => "BEL",
    "Belize" => "BLZ",
    "Benin" => "BEN",
    "Bermuda" => "BMU",
    "Bhutan" => "BTN",
    "Bolivia" => "BOL",
    "Bosnia and Herzegowina" => "BIH",
    "Botswana" => "BWA",
    "Bouvet Island" => "BVT",
    "Brazil" => "BRA",
    "British Indian Ocean Territory" => "IOT",
    "Brunei Darussalam" => "BRN",
    "Bulgaria" => "BGR",
    "Burkina Faso" => "BFA",
    "Burundi" => "BDI",
    "Cambodia" => "KHM",
    "Cameroon" => "CMR",
    "Canada" => "CAN",
    "Cape Verde" => "CPV",
    "Cayman Islands" => "CYM",
    "Central African Republic" => "CAF",
    "Chad" => "TCD",
    "Chile" => "CHL",
    "China" => "CHN",
    "Christmas Island" => "CXR",
    "Cocos (Keeling) Islands" => "CCK",
    "Colombia" => "COL",
    "Comoros" => "COM",
    "Congo" => "COG",
    "Congo, the DRC" => "COD",
    "Cook Islands" => "COK",
    "Costa Rica" => "CRI",
    "Cote d'Ivoire" => "CIV",
    "Croatia (Hrvatska)" => "HRV",
    "Cuba" => "CUB",
    "Cyprus" => "CYP",
    "Czech Republic" => "CZE",
    "Denmark" => "DNK",
    "Djibouti" => "DJI",
    "Dominica" => "DMA",
    "Dominican Republic" => "DOM",
    "East Timor" => "TMP",
    "Ecuador" => "ECU",
    "Egypt" => "EGY",
    "El Salvador" => "SLV",
    "Equatorial Guinea" => "GNQ",
    "Eritrea" => "ERI",
    "Estonia" => "EST",
    "Ethiopia" => "ETH",
    "Falkland islands (Malvinas)" => "FLK",
    "Faroe Islands" => "FRO",
    "Fiji" => "FJI",
    "Finland" => "FIN",
    "France" => "FRA",
    "France, Metropolitan" => "FXX",
    "French Guiana" => "GUF",
    "French Polynesia" => "PYF",
    "French Southern Territories" => "ATF",
    "Gabon" => "GAB",
    "Gambia" => "GMB",
    "Georgia" => "GEO",
    "Germany" => "DEU",
    "Ghana" => "GHA",
    "Gibraltar" => "GIB",
    "Greece" => "GRC",
    "Greenland" => "GRL",
    "Grenada" => "GRD",
    "Guadeloupe" => "GLP",
    "Guam" => "GUM",
    "Guatemala" => "GTM",
    "Guinea" => "GIN",
    "Guinea-Bissau" => "GNB",
    "Guyana" => "GUY",
    "Haiti" => "HTI",
    "Heard and Mc Donald Islands" => "HMD",
    "Holy See (Vatican City State)" => "VAT",
    "Honduras" => "HND",
    "Hong Kong" => "HKG",
    "Hungary" => "HUN",
    "Iceland" => "ISL",
    "India" => "IND",
    "Indonesia" => "IDN",
    "Iran (Islamic Republic of)" => "IRN",
    "Iraq" => "IRQ",
    "Ireland" => "IRL",
    "Israel" => "ISR",
    "Italy" => "ITA",
    "Jamaica" => "JAM",
    "Japan" => "JPN",
    "Jordan" => "JOR",
    "Kazakhstan" => "KAZ",
    "Kenya" => "KEN",
    "Kiribati" => "KIR",
    "Korea, D.P.R.O." => "PRK",
    "Korea, Republic of" => "KOR",
    "Kuwait" => "KWT",
    "Kyrgyzstan" => "KGZ",
    "Laos" => "LAO",
    "Latvia" => "LVA",
    "Lebanon" => "LBN",
    "Lesotho" => "LSO",
    "Liberia" => "LBR",
    "Libyan Arab Jamahiriya" => "LBY",
    "Liechtenstein" => "LIE",
    "Lithuania" => "LTU",
    "Luxembourg" => "LUX",
    "Macau" => "MAC",
    "Macedonia" => "MKD",
    "Madagascar" => "MDG",
    "Malawi" => "MWI",
    "Malaysia" => "MYS",
    "Maldives" => "MDV",
    "Mali" => "MLI",
    "Malta" => "MLT",
    "Marshall Islands" => "MHL",
    "Martinique" => "MTQ",
    "Mauritania" => "MRT",
    "Mauritius" => "MUS",
    "Mayotte" => "MYT",
    "Mexico" => "MEX",
    "Micronesia, Federated States of" => "FSM",
    "Moldova, Republic of" => "MDA",
    "Monaco" => "MCO",
    "Mongolia" => "MNG",
    "Montserrat" => "MSR",
    "Morocco" => "MAR",
    "Mozambique" => "MOZ",
    "Myanmar (Burma)" => "MMR",
    "Namibia" => "NAM",
    "Nauru" => "NRU",
    "Nepal" => "NPL",
    "Netherlands" => "NLD",
    "Netherlands antilles" => "ANT",
    "New Caledonia" => "NCL",
    "New Zealand" => "NZL",
    "Nicaragua" => "NIC",
    "Niger" => "NER",
    "Nigeria" => "NGA",
    "Niue" => "NIU",
    "Norfolk Island" => "NFK",
    "Northern Mariana Islands" => "MNP",
    "Norway" => "NOR",
    "Oman" => "OMN",
    "Pakistan" => "PAK",
    "Palau" => "PLW",
    "Panama" => "PAN",
    "Papua New Guinea" => "PNG",
    "Paraguay" => "PRY",
    "Peru" => "PER",
    "Philippines" => "PHL",
    "Pitcairn" => "PCN",
    "Poland" => "POL",
    "Portugal" => "PRT",
    "Puerto Rico" => "PRI",
    "Qatar" => "QAT",
    "Reunion" => "REU",
    "Romania" => "ROM",
    "Russian Federation" => "RUS",
    "Rwanda" => "RWA",
    "Saint Kitts and Nevis" => "KNA",
    "Saint Lucia" => "LCA",
    "Saint Vincent and the Grenadines" => "VCT",
    "Samoa" => "WSM",
    "San Marino" => "SMR",
    "Sao Tome and Principe" => "STP",
    "Saudi Arabia" => "SAU",
    "Senegal" => "SEN",
    "Seychelles" => "SYC",
    "Sierra Leone" => "SLE",
    "Singapore" => "SGP",
    "Slovakia (Slovak Republic)" => "SVK",
    "Slovenia" => "SVN",
    "Solomon Islands" => "SLB",
    "Somalia" => "SOM",
    "South Africa" => "ZAF",
    "South Georgia and South S.S." => "SGS",
    "Spain" => "ESP",
    "Sri Lanka" => "LKA",
    "St. Helena" => "SHN",
    "St. Pierre and Miquelon" => "SPM",
    "Sudan" => "SDN",
    "Suriname" => "SUR",
    "Svalbard and Jan Mayen Islands" => "SJM",
    "Swaziland" => "SWZ",
    "Sweden" => "SWE",
    "Switzerland" => "CHE",
    "Syrian Arab Republic" => "SYR",
    "Taiwan, Province of China" => "TWN",
    "Tajikistan" => "TJK",
    "Tanzania, United Republic of" => "TZA",
    "Thailand" => "THA",
    "Togo" => "TGO",
    "Tokelau" => "TKL",
    "Tonga" => "TON",
    "Trinidad and Tobago" => "TTO",
    "Tunisia" => "TUN",
    "Turkey" => "TUR",
    "Turkmenistan" => "TKM",
    "Turks and Caicos Islands" => "TCA",
    "Tuvalu" => "TUV",
    "Uganda" => "UGA",
    "Ukraine" => "UKR",
    "United Arab Emirates" => "ARE",
    "United Kingdom" => "GBR",
    "United States" => "USA",
    "U.S. Minor Islands" => "UMI",
    "Uruguay" => "URY",
    "Uzbekistan" => "UZB",
    "Vanuatu" => "VUT",
    "Venezuela" => "VEN",
    "Viet Nam" => "VNM",
    "Virgin Islands (British)" => "VGB",
    "Virgin Islands (U.S.)" => "VIR",
    "Wallis and Futuna Islands" => "WLF",
    "Western Sahara" => "ESH",
    "Yemen" => "YEM",
    "Yugoslavia (Serbia and Montenegro)" => "YUG",
    "Zambia" => "ZMB",
    "Zimbabwe " => "ZWE"
  }

  # Hash with the keys and values flipped
  COUNTRY_CODES_ABBREVIATION = COUNTRY_CODES.invert

  #=============================================================================#
  # ObjectName: COUNTRY_CODES_2CHAR
  # Returns: Hash
  #
  # Description: Contains a list of Country Code abbreviations
  #              The 2-character codes are supplied by the ISO
  #              (International Organization for Standardization),
  #              which bases its list of country names and abbreviations on
  #              the list of names published by the United Nations.
  #              The UN also uses uses 3-letter codes, and numerical codes to
  #              identify nations.
  #
  #              From the web site:
  #                   http://www.worldatlas.com/aatlas/ctycodes.htm
  #
  # Usage examples: COUNTRY_CODES_2CHAR["US"] # : "United States"
  #                 COUNTRY_CODES_2CHAR_ABBREVIATION["United Arab Emirates"] #: "AE"
  #=============================================================================#
  COUNTRY_CODES_2CHAR = {
    "Ascension Island" => "AC",
    "Andorra" => "AD",
    "United Arab Emirates" => "AE",
    "Afghanistan" => "AF",
    "Antigua and Barbuda" => "AG",
    "Anguilla" => "AI",
    "Albania" => "AL",
    "Armenia" => "AM",
    "Netherlands Antilles" => "AN",
    "Angola" => "AO",
    "Antarctica" => "AQ",
    "Argentina" => "AR",
    "American Samoa" => "AS",
    "Austria" => "AT",
    "Australia" => "AU",
    "Aruba" => "AW",
    "Azerbaijan" => "AZ",
    "Bosnia and Herzegovina" => "BA",
    "Barbados" => "BB",
    "Bangladesh" => "BD",
    "Belgium" => "BE",
    "Burkina Faso" => "BF",
    "Bulgaria" => "BG",
    "Bahrain" => "BH",
    "Burundi" => "BI",
    "Benin" => "BJ",
    "Bermuda" => "BM",
    "Brunei Darussalam" => "BN",
    "Bolivia" => "BO",
    "Brazil" => "BR",
    "Bahamas" => "BS",
    "Bhutan" => "BT",
    "Bouvet Island" => "BV",
    "Botswana" => "BW",
    "Belarus" => "BY",
    "Belize" => "BZ",
    "Canada" => "CA",
    "Cocos (Keeling Islands)" => "CC",
    "Central African Republic" => "CF",
    "Congo" => "CG",
    "Switzerland" => "CH",
    "Cote D'Ivoire (Ivory Coast)" => "CI",
    "Cook Islands" => "CK",
    "Chile" => "CL",
    "Cameroon" => "CM",
    "China" => "CN",
    "Colombia" => "CO",
    "Costa Rica" => "CR",
    "Cuba" => "CU",
    "Cape Verde" => "CV",
    "Christmas Island" => "CX",
    "Cyprus" => "CY",
    "Czech Republic" => "CZ",
    "Germany" => "DE",
    "Djibouti" => "DJ",
    "Denmark" => "DK",
    "Dominica" => "DM",
    "Dominican Republic" => "DO",
    "Algeria" => "DZ",
    "Ecuador" => "EC",
    "Estonia" => "EE",
    "Egypt" => "EG",
    "Western Sahara" => "EH",
    "Eritrea" => "ER",
    "Spain" => "ES",
    "Ethiopia" => "ET",
    "Europe" => "EU",
    "Finland" => "FI",
    "Fiji" => "FJ",
    "Falkland Islands (Malvinas)" => "FK",
    "Micronesia" => "FM",
    "Faroe Islands" => "FO",
    "France" => "FR",
    "France, Metropolitan" => "FX",
    "Gabon" => "GA",
    "United Kingdom" => "GB",
    "Grenada" => "GD",
    "Georgia" => "GE",
    "French Guiana" => "GF",
    "Ghana" => "GH",
    "Gibraltar" => "GI",
    "Greenland" => "GL",
    "Gambia" => "GM",
    "Guinea" => "GN",
    "Guadeloupe" => "GP",
    "Equatorial Guinea" => "GQ",
    "Greece" => "GR",
    "S. Georgia and S. Sandwich Isls." => "GS",
    "Guatemala" => "GT",
    "Guam" => "GU",
    "Guinea-Bissau" => "GW",
    "Guyana" => "GY",
    "Hong Kong" => "HK",
    "Heard and McDonald Islands" => "HM",
    "Honduras" => "HN",
    "Croatia (Hrvatska)" => "HR",
    "Haiti" => "HT",
    "Hungary" => "HU",
    "Indonesia" => "ID",
    "Ireland" => "IE",
    "Israel" => "IL",
    "India" => "IN",
    "British Indian Ocean Territory" => "IO",
    "Iraq" => "IQ",
    "Iran" => "IR",
    "Iceland" => "IS",
    "Italy" => "IT",
    "Jamaica" => "JM",
    "Jordan" => "JO",
    "Japan" => "JP",
    "Kenya" => "KE",
    "Kyrgyzstan (Kyrgyz Republic)" => "KG",
    "Cambodia" => "KH",
    "Kiribati" => "KI",
    "Comoros" => "KM",
    "Saint Kitts and Nevis" => "KN",
    "Korea (North) (People's Republic)" => "KP",
    "Korea (South) (Republic)" => "KR",
    "Kuwait" => "KW",
    "Cayman Islands" => "KY",
    "Kazakhstan" => "KZ",
    "Laos" => "LA",
    "Lebanon" => "LB",
    "Saint Lucia" => "LC",
    "Liechtenstein" => "LI",
    "Sri Lanka" => "LK",
    "Liberia" => "LR",
    "Lesotho" => "LS",
    "Lithuania" => "LT",
    "Luxembourg" => "LU",
    "Latvia" => "LV",
    "Libya" => "LY",
    "Morocco" => "MA",
    "Monaco" => "MC",
    "Moldova" => "MD",
    "Madagascar" => "MG",
    "Marshall Islands" => "MH",
    "Macedonia" => "MK",
    "Mali" => "ML",
    "Myanmar" => "MM",
    "Mongolia" => "MN",
    "Macau" => "MO",
    "Northern Mariana Islands" => "MP",
    "Martinique" => "MQ",
    "Mauritania" => "MR",
    "Montserrat" => "MS",
    "Malta" => "MT",
    "Mauritius" => "MU",
    "Maldives" => "MV",
    "Malawi" => "MW",
    "Mexico" => "MX",
    "Malaysia" => "MY",
    "Mozambique" => "MZ",
    "Namibia" => "NA",
    "New Caledonia" => "NC",
    "Niger" => "NE",
    "Norfolk Island" => "NF",
    "Nigeria" => "NG",
    "Nicaragua" => "NI",
    "Netherlands" => "NL",
    "Norway" => "NO",
    "Nepal" => "NP",
    "Nauru" => "NR",
    "Neutral Zone (Saudia Arabia/Iraq)" => "NT",
    "Niue" => "NU",
    "New Zealand" => "NZ",
    "Oman" => "OM",
    "Palestine" => "PS",
    "Panama" => "PA",
    "Peru" => "PE",
    "French Polynesia" => "PF",
    "Papua New Guinea" => "PG",
    "Philippines" => "PH",
    "Pakistan" => "PK",
    "Poland" => "PL",
    "St. Pierre and Miquelon" => "PM",
    "Pitcairn" => "PN",
    "Puerto Rico" => "PR",
    "Portugal" => "PT",
    "Palau" => "PW",
    "Paraguay" => "PY",
    "Qatar" => "QA",
    "Reunion" => "RE",
    "Romania" => "RO",
    "Russian Federation" => "RU",
    "Rwanda" => "RW",
    "Saudi Arabia" => "SA",
    "Solomon Islands" => "SB",
    "Seychelles" => "SC",
    "Sudan" => "SD",
    "Sweden" => "SE",
    "Singapore" => "SG",
    "St. Helena" => "SH",
    "Slovenia" => "SI",
    "Svalbard and Jan Mayen Islands" => "SJ",
    "Slovakia (Slovak Republic)" => "SK",
    "Sierra Leone" => "SL",
    "San Marino" => "SM",
    "Senegal" => "SN",
    "Somalia" => "SO",
    "Suriname" => "SR",
    "Sao Tome and Principe" => "ST",
    "Soviet Union (former)" => "SU",
    "El Salvador" => "SV",
    "Syria" => "SY",
    "Swaziland" => "SZ",
    "Turks and Caicos Islands" => "TC",
    "Chad" => "TD",
    "French Southern Territories" => "TF",
    "Togo" => "TG",
    "Thailand" => "TH",
    "Tajikistan" => "TJ",
    "Tokelau" => "TK",
    "Turkmenistan" => "TM",
    "Tunisia" => "TN",
    "Tonga" => "TO",
    "East Timor" => "TP",
    "Turkey" => "TR",
    "Trinidad and Tobago" => "TT",
    "Tuvalu" => "TV",
    "Taiwan" => "TW",
    "Tanzania" => "TZ",
    "Ukraine" => "UA",
    "Uganda" => "UG",
    "United Kingdom (Great Britain)" => "UK",
    "United States" => "US",
    "Uruguay" => "UY",
    "Uzbekistan" => "UZ",
    "Vatican City State (Holy See)" => "VA",
    "Saint Vincent and The Grenadines" => "VC",
    "Venezuela" => "VE",
    "Virgin Islands (British)" => "VG",
    "Virgin Islands (US)" => "VI",
    "Viet Nam" => "VN",
    "Vanuatu" => "VU",
    "Wallis and Futuna Islands" => "WF",
    "Samoa" => "WS",
    "Yemen" => "YE",
    "Mayotte" => "YT",
    "Yugoslavia" => "YU",
    "South Africa" => "ZA",
    "Zambia" => "ZM",
    "Zaire" => "ZR",
    "Zimbabwe" => "ZW"
  }

  # Hash with the keys and values flipped
  COUNTRY_CODES_2CHAR_ABBREVIATION = COUNTRY_CODES_2CHAR.invert

  #=============================================================================#
  # ObjectName: MONTH_ABBREVIATION
  # Returns: HASH
  #
  # Description: Contains a list of month abbreviations and their full names
  #
  # Usage examples: MONTH_ABBREVIATION["December"] # => "dec"
  #                 MONTH_ABBREVIATION.index "dec" #=> "December"
  #=============================================================================#
  MONTH_ABBREVIATION = {
    "jan" => "Janurary",
    "feb" => "Feburary",
    "mar" => "March",
    "apr" => "April",
    "may" => "May",
    "jun" => "June",
    "jul" => "July",
    "aug" => "August",
    "sep" => "September",
    "oct" => "October",
    "nov" => "November",
    "dec" => "December"
  }

  # Hash with the keys and values flipped
  MONTHS = MONTH_ABBREVIATION.invert

  #=============================================================================#
  # ObjectName: COMMON_HTMLELEMENT_ATTRIBUTES
  # Returns: ARRAY
  #
  # Description: Contains the attributes that are common to each of the HTML Element
  #              These attributes are from WatirWebdriver's HTMLElement classes
  #
  #              Attributes deliberately omitted: spellcheck?, translate?
  #                         
  # Usage examples: COMMON_HTML_ATTRIBUTES = (COMMON_HTMLELEMENT_ATTRIBUTES + COMMON_HTML_ELEMENT_ATTRIBUTES).sort!
  #=============================================================================#
  COMMON_HTMLELEMENT_ATTRIBUTES =
  ["access_key", "access_key_label",
    "class", "command_checked?", "command_disabled?",  "command_hidden?", "command_icon",
    "command_label", "command_type", "content_editable?", "content_editable", "context_menu",
    "dataset", "dir", "draggable?", "dropzone",
    "hidden?",
    "item_id", "item_prop", "item_ref", "item_scope?", "item_type", "item_value",
    "lang",
    "onabort", "onautocomplete", "onautocompleteerror", "onblur", "oncancel", "oncanplay", "oncanplaythrough",
    "onchange", "onclick", "onclose", "oncontextmenu", "oncuechange", "ondblclick",
    "ondrag", "ondragend", "ondragenter", "ondragexit", "ondragleave", "ondragover", "ondragstart", "ondrop",
    "ondurationchange", "onemptied", "onended", "onerror", "onfocus", "oninput", "oninvalid",
    "onkeydown", "onkeypress", "onkeyup",
    "onload", "onloadeddata", "onloadedmetadata", "onloadstart",
    "onmousedown", "onmouseenter", "onmouseleave", "onmousemove", "onmouseout", "onmouseover", "onmouseup", "onmousewheel",
    "onpause", "onplay", "onplaying", "onprogress", "onratechange", "onreset", "onresize", "onscroll",
    "onseeked", "onseeking", "onselect", "onshow", "onsort", "onstalled", "onsubmit", "onsuspend", "ontimeupdate", "ontoggle", "onvolumechange", "onwaiting",
    "properties",
    "tab_index", "title"]

  #=============================================================================#
  # ObjectName: COMMON_HTML_ELEMENT_ATTRIBUTES
  # Returns: ARRAY
  #
  # Description: Contains the attributes that are common to each of the HTML Element
  #              These attributes are from WatirWebdriver's Element classes
  #  
  #              Attributes deliberately omitted: exists?, tag_name, 
  #
  # Usage examples: COMMON_HTML_ATTRIBUTES = (COMMON_HTMLELEMENT_ATTRIBUTES + COMMON_HTML_ELEMENT_ATTRIBUTES).sort!
  #=============================================================================#
  COMMON_HTML_ELEMENT_ATTRIBUTES =
  ["class_name",
    "enabled?", "focused?",
    "id", "inner_html",
    "outer_html",
    "present?",
    "text",
    "value", "visible?"]

  #=============================================================================#
  # ObjectName: COMMON_HTML_ATTRIBUTES
  # Returns: ARRAY
  #
  # Description: Contains the attributes that are common to each of the HTML TAG Elements
  #              In general these attributes are inherited from WatirWebdriver's
  #              HTMLElement, or Element classes.
  #
  # Usage examples: "button" => COMMON_HTML_ATTRIBUTES + ["other", "attributes", "specific", "to", "this", "tag"]
  #=============================================================================#
  COMMON_HTML_ATTRIBUTES = (COMMON_HTMLELEMENT_ATTRIBUTES + COMMON_HTML_ELEMENT_ATTRIBUTES).unique!.sort!

  #=============================================================================#
  # ObjectName: SUPPORTED_HTML_ATTRIBUTES
  # Returns: HASH
  #
  # TODO - Figure out what's with elements: tfoot
  # TODO - Presuming: caption is TableCaption
  # TODO - Presuming: header is Heading
  #
  # HTML Element = Watir Class
  # ---------------------------
  # a = Watir::Anchor
  # area = Watir::Area
  # br = Watir::BR
  # body = Watir::Body
  # button = Watir::Button
  # div = Watir::Div
  # form = Watir::Form
  # hr = Watir::HR
  # head = Watir::Head
  # img = Watir::Image
  # input = Watir::Input
  # label = Watir::Label
  # li = Watir::LI
  # map = Watir::Map
  # option = Watir::Option
  # p = Watir::Paragraph
  # pre = Watir::Pre
  # script = Watir::Script
  # select = Watir::Select
  # span = Watir::Span
  # style = Watir::Style
  # table = Watir::Table
  # td = Watir::TableDataCell
  # textarea = Watir::TextArea
  # th = Watir::TableHeaderCell
  # thead = Watir::TableSection  # a.k.a. t_head
  # ul = Watir::UList
  #
  # Description: Contains a list of attributes by HTML TAG Element
  #
  # Usage example: SUPPORTED_HTML_ATTRIBUTES["button"] # => ["accesskey", "class", "contenteditable", "dir", "hidden",
  #                                                           "id", "lang", "style", "tabindex", "title", "translate",
  #                                                           "autofocus", "disabled", "form", "formaction", "formenctype",
  #                                                           "formmethod", "formvalidate", "formtarget", "name", "type", "value"]
  #=============================================================================#
  SUPPORTED_HTML_ATTRIBUTES = {
    "a" => (COMMON_HTML_ATTRIBUTES + ["charset","coords", "download", "href", "hreflang", "name", "media", "ping", "rel", "rel_list", "rev", "shape", "target", "type"]).unique!.sort!,
    "area" => (COMMON_HTML_ATTRIBUTES + ["alt", "coords", "download", "hreflang", "no_href?", "ping", "rel", "rel_list", "shape", "target", "type"]).unique!.sort!,
    "base" => (COMMON_HTML_ATTRIBUTES + ["href", "target"]).unique!.sort!,
    "body" => (COMMON_HTML_ATTRIBUTES + ["a_link", "background", "bg_color", "link", "onafterprint", "onbeforeprint", "onbeforeunload", "onhashchange", "onlanguagechange", "onmessage", "onoffline", "ononline","onpagehide", "onpageshow", "onpopstate", "onstorage", "onunload", "v_link"]).unique!.sort!,
    "br" => (COMMON_HTML_ATTRIBUTES + ["clear"]).unique!.sort!,
    "button" => (COMMON_HTML_ATTRIBUTES + ["autofocus?", "disabled?", "form", "form_action", "form_enctype", "form_method", "form_no_validate?", "form_target", "labels", "menu", "name", "text", "type", "validation_message", "validity", "value" "will_validate?"]).unique!.sort!,
    "caption" => (COMMON_HTML_ATTRIBUTES + ["align"]).unique!.sort!,
    "data" => (COMMON_HTML_ATTRIBUTES + ["value"]).unique!.sort!,
    "div" => (COMMON_HTML_ATTRIBUTES + ["align"]).unique!.sort!,
    "dl" => (COMMON_HTML_ATTRIBUTES + ["compact?"]).unique!.sort!,
    "dialog" => (COMMON_HTML_ATTRIBUTES + ["open?", "return_value"]).unique!.sort!,
    "embed" => (COMMON_HTML_ATTRIBUTES + ["align", "height", "name", "src", "type", "width"]).unique!.sort!,
    "fieldset" => (COMMON_HTML_ATTRIBUTES + ["disabled/","form", "name", "type", "validation_Message", "validity", "will_validate?"]).unique!.sort!,
    "font" => (COMMON_HTML_ATTRIBUTES + ["color", "face", "size"]).unique!.sort!,
    "form" => (COMMON_HTML_ATTRIBUTES + ["accept_charset", "action", "autocomplete", "encoding", "enctype", "length", "method", "name", "no_validate?", "target"]).unique!.sort!,
    "header"=> (COMMON_HTML_ATTRIBUTES).unique!.sort!,
    "hr" => (COMMON_HTML_ATTRIBUTES + ["align", "color", "no_shade?", "size", "width"]).unique!.sort!,
    "head"=> (COMMON_HTML_ATTRIBUTES + ["align"]).unique!.sort!,
    "html" => (COMMON_HTML_ATTRIBUTES + ["version"]).unique!.sort!,
    "iframe" => (COMMON_HTML_ATTRIBUTES + ["align", "allow_fullscreen?", "content_document", "content_window", "frame_border", "height", "long_desc", "margin_height", "margin_width", "name", "sandbox", "scrollong", "seamless?", "src", "srcdoc", "width"]).unique!.sort!,
    "img" => (COMMON_HTML_ATTRIBUTES + ["align", "alt", "border", "complete?", "cross_origin", "current_src", "height", "hspace", "loaded?", "long_desc", "lowsrc", "map?", "name", "natural_height", "natural_width", "sizes", "src", "srcset", "use_map", "vspace", "width"]).unique!.sort!,
    "input" => (COMMON_HTML_ATTRIBUTES + ["accept", "align", "alt", "autocomplete", "autofocus?", "checked?", "default_checked?", "default_value", "dir_name", "disabled?", "files", "form_action", "form_enctype", "form_method", "form_no_validate?", "form_target", "ndeterminate?",  "input_mode", "labels", "list", "max", "max_length", "min", "min_length", "multiple?", "pattern", "placeholder", "read_only?", "required?", "selection_direction", "selection_end", "selection_start", "size", "src", "step", "use_map", "value", "value_as_date", "value_as_number", "value_high", "value_low"]).unique!.sort!,
    "keygen" => (COMMON_HTML_ATTRIBUTES + ["autofocus?", "challange", "disabled?", "form", "keytype", "labels", "name", "type", "validation_message", "validity", "will_validate?"]).unique!.sort!,
    "legend" => (COMMON_HTML_ATTRIBUTES + ["align", "form"]).unique!.sort!,
    "li" => (COMMON_HTML_ATTRIBUTES + ["type", "value"]).unique!.sort!,
    "label" => (COMMON_HTML_ATTRIBUTES + ["control", "for", "form"]).unique!.sort!,
    "map" => (COMMON_HTML_ATTRIBUTES + ["areas", "images", "name"]).unique!.sort!,
    "menu" => (COMMON_HTML_ATTRIBUTES + ["compact?", "label", "type"]).unique!.sort!,
    "menuitem" => (COMMON_HTML_ATTRIBUTES + ["checked?", "command", "default?", "disabled?", "icon", "label", "radiogroup", "type"]).unique!.sort!,
    "meta" => (COMMON_HTML_ATTRIBUTES + ["content", "http-equiv", "name", "scheme"]).unique!.sort!,
    "meter" => (COMMON_HTML_ATTRIBUTES + ["high", "labels", "low", "max", "min", "optium", "value"]).unique!.sort!,
    "ol" => (COMMON_HTML_ATTRIBUTES + ["compact?", "reversed?", "start", "type"]).unique!.sort!,
    "object" => (COMMON_HTML_ATTRIBUTES + ["align", "archive", "border", "code", "code_base", "code_type", "content_document", "content_window", "data", "declare?", "form", "height", "hspace", "name", "standby", "type", "type_must_match?", "use_map", "validation_message", "validity", "vspace",  "width", "will_validate?"]).unique!.sort!,
    "option" => (COMMON_HTML_ATTRIBUTES + ["clear", "default_selected?", "disabled?", "form", "index", "label", "selected?", "text", "value"]).unique!.sort!,
    "optgroup" => (COMMON_HTML_ATTRIBUTES + ["disabled?", "label"]).unique!.sort!,
    "p" => (COMMON_HTML_ATTRIBUTES + ["align"]).unique!.sort!,
    "param" => (COMMON_HTML_ATTRIBUTES + ["name", "type", "value", "value_type"]).unique!.sort!,
    "pre" => (COMMON_HTML_ATTRIBUTES + ["width"]).unique!.sort!,
    "script" => (COMMON_HTML_ATTRIBUTES + ["async?", "charset", "cross_origin", "defer?", "event", "for", "src", "type"]).unique!.sort!,
    "select" => (COMMON_HTML_ATTRIBUTES + ["autocomplete", "autofocus?", "clear", "disapbled?", "form", "labels", "length", "multiple?", "name", "options", "required?", "selected_index", "selected_options", "size", "type", "validation_message", "validity", "value", "will_validate?"]).unique!.sort!,
    "source" => (COMMON_HTML_ATTRIBUTES + ["media", "sizes", "src", "srcset", "type"]).unique!.sort!,
    "span" => (COMMON_HTML_ATTRIBUTES).unique!.sort!,
    "style" => (COMMON_HTML_ATTRIBUTES + ["media", "scoped?", "type"]).unique!.sort!,
    "table" => (COMMON_HTML_ATTRIBUTES + ["align", "bg_color", "border", "caption", "cell_padding", "cell_spacing", "frame", "rules", "sortable?", "summary", "t_bodies", "t_foot", "t_head", "width"]).unique!.sort!,
    "th" => (COMMON_HTML_ATTRIBUTES + ["abbr", "align", "axis", "bg_color", "cell_index", "ch", "ch_off", "col_span", "headers", "height", "no_wrap?", "row_span", "scope", "sorted", "v_align", "width"]).unique!.sort!,
    "td" => (COMMON_HTML_ATTRIBUTES + ["align", "axis", "bg_color", "cell_index", "ch", "ch_off", "col_span", "headers", "height", "no_wrap?", "row_span", "v_align", "width"]).unique!.sort!,
    "textarea" => (COMMON_HTML_ATTRIBUTES + ["autocomplete", "autofocus?", "cols", "default_value", "dir_name", "disabled?", "form", "input_mode", "labels", "max_length", "min_length", "name", "placeholder", "read_only?", "required?", "selection_direction", "selection_end", "selection_start", "text_lenght", "type", "validation_message", "validity", "value", "will_validate?", "wrap"]).unique!.sort!,
    "thead" => (COMMON_HTML_ATTRIBUTES + ["align", "axis", "bg_color", "cell_index", "ch", "ch_off", "col_span", "headers", "height", "no_wrap?", "row_span", "v_align", "width"]).unique!.sort!,
    "tfoot" => (COMMON_HTML_ATTRIBUTES).unique!.sort!,
    "template" => (COMMON_HTML_ATTRIBUTES + ["content"]).unique!.sort!,
    "time" => (COMMON_HTML_ATTRIBUTES + ["date_time"]).unique!.sort!,
    "title" => (COMMON_HTML_ATTRIBUTES).unique!.sort!,
    "tr" => (COMMON_HTML_ATTRIBUTES + ["align", "bg_color", "ch", "ch_off", "row_index", "section_row_index", "v_align"]).unique!.sort!,
    "track" => (COMMON_HTML_ATTRIBUTES + ["default?", "kind", "label", "ready_state", "src" "srclang", "track"]).unique!.sort!,
    "ul" => (COMMON_HTML_ATTRIBUTES + ["compact?", "type"]).unique!.sort!
  }

  #=============================================================================#
  # ObjectName: SUPPORTED_HTML_ELEMENTS
  # Returns: ARRAY
  #
  # Description: Contains a list of HTML elements that Watir-Webdriver supports
  #
  # HTML Element = Watir Class
  # ---------------------------
  # a = Watir::Anchor
  # area = Watir::Area
  # br = Watir::BR
  # body = Watir::Body
  # button = Watir::Button
  # div = Watir::Div
  # form = Watir::Form
  # hr = Watir::HR
  # head = Watir::Head
  # img = Watir::Image
  # input = Watir::Input
  # label = Watir::Label
  # li = Watir::LI
  # map = Watir::Map
  # option = Watir::Option
  # p = Watir::Paragraph
  # pre = Watir::Pre
  # script = Watir::Script
  # select = Watir::Select
  # span = Watir::Span
  # style = Watir::Style
  # table = Watir::Table
  # td = Watir::TableDataCell
  # textarea = Watir::TextArea
  # th = Watir::TableHeaderCell
  # thead = Watir::TableSection  # a.k.a. t_head
  # tr = Watir::TableRow
  # ul = Watir::UList
  #
  # Usage examples:
  #                      # Define the elements to check
  #                      aSupportedHTMLElementNames = SUPPORTED_HTML_ELEMENTS
  #
  #=============================================================================#
  SUPPORTED_HTML_ELEMENTS = [
    "a", "area",
    "br", "base", "body", "button",
    "caption",
    "data", "dialog", "div", "dl",
    "embed",
    "fieldset","font", "form",
    "hr", "head", "header", "html",
    "iframe", "img", "input",
    "keygen",
    "label", "legend", "li",
    "map", "menu", "menuitem", "meta", "meter",
    "object", "ol", "optgroup", "option", "output",
    "p", "param", "pre",
    "script", "select", "source", "span", "style",
    "table", "td", "template", "textarea", "tfoot", "th", "thead", "time", "title", "tr", "track",
    "ul"
  ]

  #=============================================================================#
  # ObjectName: TOP_LEVEL_DOMAINS
  # Returns: ARRAY
  #
  # Description: Contains a list of Top Level Domain names as found at:
  #                 http://www.icann.org/registries/top-level-domains.htm
  #
  # Usage examples:
  #                 sMy_TLD = "biz"
  #                 TOP_LEVEL_DOMAINS.each do |  sTLD |
  #                    if(sMy_TLD == sTLD)
  #                       puts2("#{sMy_TLD} is a valid Top-Level-Domain")
  #                    end
  #                 end
  #=============================================================================#
  TOP_LEVEL_DOMAINS = [
    "aero", "arpa", "asia", "biz", "cat", "com", "coop", "info", "jobs",
    "mobi", "museum", "name", "net", "org", "pro", "tel", "travel",
    "gov", "edu", "mil", "int",
    "ac", "ad", "ae", "af", "ag", "ai", "al", "am", "an", "ao", "aq", "ar", "as", "at", "au", "aw", "ax", "az",
    "ba", "bb", "bd", "be", "bf", "bg", "bh", "bi", "bj", "bm", "bn", "bo", "br", "bs", "bt", "bv", "bw", "by", "bz",
    "ca", "cc", "cd", "cf", "cg", "ch", "ci", "ck", "cl", "cm", "cn", "cp", "cr", "cu", "cv", "cx", "cz",
    "de", "dj", "dk", "dm", "do", "dz",
    "ec", "ee", "eg", "er", "es", "et", "eu",
    "fi", "fj", "fk", "fm", "fo", "fr",
    "ga", "gb", "gd", "ge", "gf", "gg", "gh", "gi", "gl", "gm", "gn", "gp", "gq", "gr", "gs", "gt", "gu", "gw", "gy",
    "hk", "hm", "hn", "hr", "ht", "hu",
    "id", "ie", "il", "im", "in", "io", "iq", "ir", "is", "it",
    "je", "jm", "jo", "jp",
    "ke", "kg", "kh", "ki", "km", "kn", "kr", "kw", "ky", "kz",
    "la", "lb", "lc", "li", "lk", "lr", "ls", "lt", "lu", "lv", "ly",
    "ma", "md", "mg", "mh", "mk", "ml", "mm", "mn", "mo", "mp", "mr", "ms", "mt", "mu", "mv", "mw", "mz",
    "na", "nc", "ne", "nf", "ng", "ni", "nl", "no", "np", "nr", "nu", "nz",
    "om",
    "pa", "pe", "pf", "pg", "ph", "pk", "pl", "pm", "pn", "pr", "ps", "pt", "pw", "py",
    "qa",
    "re", "ro", "ru", "rw",
    "sa", "sb", "sc", "sd", "se", "sg", "sh", "si", "sj", "sk", "sl", "sm", "sn", "so", "sr", "st", "su", "sv", "sy", "sz",
    "tc", "td", "tf", "tg", "th", "tj", "tk", "tl", "tm", "tn", "to", "tp", "tr", "tt", "tv", "tw", "tz",
    "ua", "ug", "uk", "um", "us", "uy", "uz",
    "va", "vc", "ve", "vg", "vi", "vn", "vu",
    "wf", "ws",
    "ye", "yt", "yu",
    "za", "zm", "zw"
  ]

end # end of module WatirWorks_RefLib

# END FILE watirworks-reflib.rb
