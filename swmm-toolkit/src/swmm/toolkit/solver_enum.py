#
#  output_enum.py -
#
#  Created: August 20, 2020
#  Updated:
#
#  Author:     Michael E. Tryby
#              US EPA - ORD/CESER
#              Jennifer Wu
#              Xylem Inc.

#
# Solver API Enums
#

from aenum import Enum, IntEnum


class UnitSystem(Enum, start=0):
    US
    SI


class FlowUnits(Enum, start=0):
    CFS
    GPM
    MGD
    CMS
    LPS
    MLD


class ConcUnits(Enum, start=0):
    MG,
    UG,
    COUNT
    NONE


class NodeType(Enum, start=0):
    JUNCTION
    OUTFALL
    STORAGE
    DIVIDER


class LinkType(Enum, start=0):
    CONDUIT
    PUMP
    ORIFICE
    WEIR
    OUTLET


class LinkDirection(Enum):
    UPSTREAM_TO_DOWNSTREAM = 1
    DOWNSTREAM_TO_UPSTREAM = -1
    
#
# Solver Toolkit API Enums
#


class ObjectProperty(Enum, start=0):
    GAGE
    SUBCATCH 
    NODE
    LINK  
    POLLUT
    LAND_USE 
    TIME_PATTERN
    CURVE
    TIMESERIES   
    CONTROL
    TRANSECT
    AQUIFER
    UNIT_HYD  
    SNOW_MELT
    SHAPE
    LID

    
class TimeProperty(Enum, start=0):
    START_DATE
    END_DATE
    REPORT_DATE


class UnitProperty(Enum, start=0):
    SYSTEM_UNIT
    FLOW_UNIT


class SimOption(Enum, start=0):
    ALLOW_POND
    SKIP_STEADY
    IGNORE_RAIN
    IGNORE_RDII
    IGNORE_SNOW
    IGNORE_GW
    IGNORE_ROUTE
    IGNORE_ROUTE_QUALITY


class SimSetting(Enum, start=0):
    ROUTE_STEP
    MIN_ROUTE_STEP
    LENGTH_STEP
    START_DRY_DAYS
    COURANT_FACTOR
    MIN_SURFACE_AREA
    MIN_SLOPE
    RUNOFF_ERROR
    GW_ERROR
    FLOW_ERROR
    QUALITY_ERROR
    HEAD_TOLERANCE
    SYSTEM_FLOW_TOLERANCE
    LATERAL_FLOW_TOLERANCE


class NodeProperty(Enum, start=0):
    INVERT_ELEVATION
    FULL_DEPTH
    SURCHARGE_DEPTH
    POND_AREA
    INITIAL_DEPTH


class LinkProperty(Enum, start=0):
    OFFSET_1
    OFFSET_2
    INITIAL_FLOW
    FLOW_LIMIT
    INLET_LOSS
    OUTLET_LOSS
    AVERAGE_LOSS


class SubcatchProperty(Enum, start=0):
    WIDTH
    AREA
    IMPERVIOUS_FRACTION
    SLOPE
    CURB_LENGTH
    
    
