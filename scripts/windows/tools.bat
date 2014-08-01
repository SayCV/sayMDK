@echo off
rem.
rem  Copyright (C) 2014 The sayMDK Open Source Project
rem.
rem  Licensed under the Apache License, Version 2.0 (the License);
rem  you may not use this file except in compliance with the License.
rem  You may obtain a copy of the License at
rem.
rem       http://www.apache.org/licenses/LICENSE-2.0
rem.
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an AS IS BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem.

call "%~dp0tools_var.bat"

rem setlocal enabledelayedexpansion

:: Microsoft Visual Studio Tool
:: The Variable setting must placed the top of batch.
:-------------------------------------
if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_MS_VS%"=="1" (
	set "MS_VS_ROOT=D:/Program Files (x86)/Microsoft Visual Studio 11.0"
	set "MS_VS_IDE_PATH=!MS_VS_ROOT!/Common7/IDE"
	set "MS_VS_VC_ROOT=!MS_VS_ROOT!/VC"
	set "SDKPath=D:/Program Files (x86)/Microsoft SDKs/Windows/v7.1"

	set "PATH=!PATH!;!MS_VS_IDE_PATH!"
	
	set "MS_VS_VC_INIT_BATCH=!!MS_VS_VC_ROOT!/bin/vcvars32.bat"
	if exist "!MS_VS_VC_INIT_BATCH!" (
		echo sayMDK: Call vcvars32.bat will reset envirment variables.
		call "!MS_VS_VC_INIT_BATCH!"
		echo sayMDK: Adding Tools: Microsoft Visual Studio Ver 11.0.
	) else (
		echo sayMDK: Adding Tools: Microsoft Visual Studio:	Not Found.
	)
)

if "%MDK_ENV_BOOLEAN_INCLUDED_MINGW_OR_CYGWIN%"=="1" (
	call "%~dp0../mingw/common.bat"
)
:-------------------------------------

:: svn Tool  
:-------------------------------------
if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_SVN%"=="1" (
	set "TOOLS_SVN_ROOT=C:/Program Files/svn"
	if exist "!TOOLS_SVN_ROOT!" (
		set "PATH=!PATH!;!TOOLS_SVN_ROOT!/bin"
		echo sayMDK: Adding Tools: SVN	Ver unkown.
	) else (
		echo sayMDK: Adding Tools: SVN:	Not support.
	)
)
:-------------------------------------

:: git Tool  
:-------------------------------------
if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_GIT%"=="1" (
	set "TOOLS_GIT_ROOT=D:/Program Files/Git"
	if exist "!TOOLS_GIT_ROOT!" (
		set "PATH=!PATH!;!TOOLS_GIT_ROOT!/bin"
		echo sayMDK: Adding Tools: GIT	Ver unkown.
	) else (
		echo sayMDK: Adding Tools: GIT:	Not support.
	)
)
:-------------------------------------

:: hg Tool  
:-------------------------------------
if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_HG%"=="1" (
	set "TOOLS_HG_ROOT=C:/Program Files/Mercurial"
	if exist "!TOOLS_HG_ROOT!" (
		set "PATH=!PATH!;!TOOLS_HG_ROOT!"
		echo sayMDK: Adding Tools: HG	Ver unkown.
	) else (
		echo sayMDK: Adding Tools: HG:	Not support.
	)
)
:-------------------------------------

:-------------------------------------

:: JAVA Tool  
:-------------------------------------
if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_JAVA1D6%"=="1" (
	set JAVA_ROOT=D:/cygwin/opt/Java
	set "JAVA_HOME=!JAVA_ROOT!/jdk6"
	set "JRE_HOME=!JAVA_ROOT!/jre6"
	set "CLASSPATH=!JAVA_HOME!/lib:!JRE_HOME!/lib"
	set "PATH=!JAVA_HOME!/bin;!PATH!"
	echo sayMDK: Adding Tools: JAVA	Ver 1.6.
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_JAVA1D7%"=="1" (
	if "%JAVA_ROOT%"=="" (
		set JAVA_ROOT=D:/cygwin/opt/Java
		set "JAVA_HOME=!JAVA_ROOT!/jdk7"
		set "JRE_HOME=!JAVA_ROOT!/jre7"
		set "CLASSPATH=!JAVA_HOME!/lib:!JRE_HOME!/lib"
		set "PATH=!JAVA_HOME!/bin;!PATH!"
		echo sayMDK: Adding Tools: JAVA	Ver 1.7.
	) else (
		echo sayMDK: Ignore to Adding Tools: JAVA.
	)
)
:-------------------------------------

:: Perl Tool  
:-------------------------------------
if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_PERL%"=="1" (
	echo sayMDK: Adding Tools: Perl:	Not support.
)
:-------------------------------------

:: Python Tool  
:-------------------------------------
if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_PYTHON2%"=="1" (
	set PYTHON_ROOT=D:/Python27
	set "PATH=!PYTHON_ROOT!;!PYTHON_ROOT!/Scripts;!PATH!"
	echo sayMDK: Adding Tools: Python	Ver 2.7.
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_PYTHON3%"=="1" (
	if "%PYTHON_ROOT%"=="" (
		set PYTHON_ROOT=D:/Python32
		set "PATH=!PYTHON_ROOT!;!PYTHON_ROOT!/Scripts;!PATH!"
		echo sayMDK: Adding Tools: Python	Ver 3.2.
	) else (
		echo sayMDK: Ignore to Adding Tools: Python.
	)
)
:-------------------------------------

:: QT Tool  
:-------------------------------------
if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_QT%"=="1" (
	echo sayMDK: Adding Tools: QT:	Not support.
)
:-------------------------------------

:: Golang Tool  
:-------------------------------------
if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_GOLANG%"=="1" (
	set "GOLANG_ROOT=!__MDK_TOOLS_ROOT!/go"
	if exist "!GOLANG_ROOT!" (
		set "GOPATH=!__MDK_WORK_ROOT!/golang"
		set "PATH=!GOLANG_ROOT!/bin;!PATH!"
		set "PATH=!GOLANG_ROOT!/pkg/tool/windows_386;!PATH!"
		echo sayMDK: Adding Tools: Golang	Ver unkown.
	) else (
		echo sayMDK: Adding Tools: Golang:	Not support.
	)
)
:-------------------------------------

rem setlocal disabledelayedexpansion

:EOF