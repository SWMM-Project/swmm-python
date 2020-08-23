/*
 *  solver.i - SWIG interface description file for swmm-solver
 *
 *  Created:    7/2/2018
 *  Updated:    8/17/2020
 *
 *  Author:     Michael E. Tryby
 *              US EPA - ORD/NRMRL
 *
 *              Jennifer Wu
 *              Xylem Inc.
 *
 *              Caleb Buahin
 *              Xylem Inc. 
*/


%include "typemaps.i"
%include "cstring.i"


%module(package="swmm.toolkit") solver
%{
#define SWIG_FILE_WITH_INIT

#include "swmm5.h"
#include "toolkitAPI.h"
#include "toolkitAPI_enums.h"
%}


/* TYPEMAP FOR IGNORING INT ERROR CODE RETURN VALUE */
%typemap(out) int {
    $result = Py_None;
    Py_INCREF($result);
}


/* GENERATES DOCUMENTATION */
%feature("autodoc", "2");


/* RENAME FUNCTIONS PYTHON STYLE */
%include "solver_rename.i"
%include "solver_toolkitapi_rename.i"

/* INSERTS CUSTOM EXCEPTION HANDLING IN WRAPPER */
%exception
{
    $function
    if (result > 0) {
        char* errorMsg;
        int errorCode;
        errorMsg = (char *) malloc(sizeof(char)*256);
        errorCode = swmm_getAPIError(result, errorMsg);
        if (errorCode == 0) {
            PyErr_SetString(PyExc_Exception, errorMsg);
            freeMemory(errorMsg);
        }
        SWIG_fail;
    }
}

%apply int *OUTPUT {
    int *year,
    int *month,
    int *day,
    int *hour,
    int *minute,
    int *second
};

%apply double *OUTPUT {
    double *value
};

%apply signed char *OUTPUT {
    signed char *value
};


%typemap(in, numinputs=0) char *ERRMSG {
    $1 = (char *) malloc(sizeof(char)*256);
}
%typemap(argout) (char *ERRMSG) {
    if ($1) {
      PyObject *o = PyUnicode_FromString($1);
      $result = SWIG_Python_AppendOutput($result, o);
    }
}
%typemap(freearg) char *ERRMSG {
    freeMemory($1);
}

%typemap(in, numinputs=0)char *OBJECTID {
    $1 = (char *) malloc(sizeof(char)*61);
}
%typemap(argout) (char *OBJECTID) {
    if ($1) {
      PyObject *o = PyUnicode_FromString($1);
      $result = SWIG_Python_AppendOutput($result, o);
    }
}
%typemap(freearg) char *OBJECTID {
    freeMemory($1);
}

/* TYPEMAP FOR ENUMERATED TYPE INPUT ARGUMENTS */
%typemap(in) EnumTypeIn {
    int value = 0;
    if (PyObject_HasAttrString($input, "value")) {
        PyObject *o = PyObject_GetAttrString($input, "value");
        SWIG_AsVal_int(o, &value);
    }
    else if (PyLong_Check($input)) {
        SWIG_AsVal_int($input, &value);
    }
    $1 = ($1_basetype)(value);
}
%apply EnumTypeIn {
    SM_ObjectType,
    SM_NodeType,
    SM_LinkType,
    SM_TimePropety,
    SM_Units,
    SM_SimOption,
    SM_SimSetting,
    SM_NodeProperty,
    SM_LinkProperty,
    SM_SubcProperty,
    SM_NodeResult,
    SM_NodePollut,
    SM_LinkResult,
    SM_LinkPollut,
    SM_SubcResult,
    SM_SubcPollut,
    SM_GagePrecip,
    SM_LidLayer,
    SM_LidLayerProperty,
    SM_LidUProperty,
    SM_LidUOptions,
    SM_LidResult
}


// CANONICAL API
int  swmm_run(char *f1, char *f2, char *f3);
int  swmm_open(char *f1, char *f2, char *f3);
int  swmm_start(int saveFlag);
int  swmm_step(double *OUTPUT);
int  swmm_end(void);
int  swmm_report(void);
int  swmm_getMassBalErr(float *OUTPUT, float *OUTPUT, float *OUTPUT);
int  swmm_close(void);
int  swmm_getVersion(void);


// TOOLKIT API 
int  swmm_getAPIError(int ErrorCodeAPI, char *ERRMSG);
int  swmm_getSimulationUnit(SM_Units type, int *OUTPUT);
int  swmm_project_findObject(SM_ObjectType type, char *id, int *OUTPUT);
int  swmm_countObjects(SM_ObjectType type, int *OUTPUT);
int  swmm_getSimulationDateTime(SM_TimePropety type, int *year, int *month, int *day, int *hour, int *minute, int *second);
int  swmm_setSimulationDateTime(SM_TimePropety timetype, int year, int month, int day, int hour, int minute, int second);
int  swmm_getSimulationAnalysisSetting(SM_SimOption type, int *OUTPUT);
int  swmm_getSimulationParam(SM_SimSetting type, double *OUTPUT);

int  swmm_getObjectIndex(SM_ObjectType type, char *id, int *OUTPUT);
int  swmm_getObjectId(SM_ObjectType type, int index, char *OBJECTID);

int  swmm_getNodeType(int index, int *OUTPUT);
int  swmm_getNodeParam(int index, SM_NodeProperty parameter, double *OUTPUT);
int  swmm_setNodeParam(int index, SM_NodeProperty parameter, double value);

int  swmm_getLinkType(int index, int *OUTPUT);
int  swmm_getLinkConnections(int index, int *OUTPUT, int *OUTPUT);
int  swmm_getLinkDirection(int index, signed char *value);
int  swmm_getLinkParam(int index, SM_LinkProperty parameter, double *OUTPUT);
int  swmm_setLinkParam(int index, SM_LinkProperty parameter, double value);

int  swmm_getSubcatchOutConnection(int index, int *OUTPUT, int *OUTPUT);
int  swmm_getSubcatchParam(int index, SM_SubcProperty parameter, double *OUTPUT);
int  swmm_setSubcatchParam(int index, SM_SubcProperty parameter, double value);
%exception;
