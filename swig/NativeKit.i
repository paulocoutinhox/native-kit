/* File : example.i */
%module NativeKit

%{
#include "../source/http/HttpClient.h"
%}

%include "std_string.i"

/* Let's just grab the original header file here */
%include "../source/http/HttpClient.h"