@echo off
echo.
echo  Copyright (C) 2014 The sayMDK Open Source Project
echo.
echo  Licensed under the Apache License, Version 2.0 (the License);
echo  you may not use this file except in compliance with the License.
echo  You may obtain a copy of the License at
echo.
echo       http://www.apache.org/licenses/LICENSE-2.0
echo.
echo Unless required by applicable law or agreed to in writing, software
echo distributed under the License is distributed on an AS IS BASIS,
echo WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
echo See the License for the specific language governing permissions and
echo limitations under the License.
echo.

title %~n0

rem echo set dos windows size : cols=113, lines=150, color=black
rem mode con cols=113 lines=1500 & color 0f

rem 1 means included mingw, 0 means included cygwin.
if "%MDK_ENV_BOOLEAN_INCLUDED_MINGW_OR_CYGWIN%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_MINGW_OR_CYGWIN=1
)

rem Requesting administrative privileges.
if "%MDK_ENV_BOOLEAN_GET_ADMIN%"=="" (
	set /a MDK_ENV_BOOLEAN_GET_ADMIN=0
)

rem Checking proxy envirement.
if "%MDK_ENV_BOOLEAN_GOAGENT_PROXY_USED%"=="" (
	set /a MDK_ENV_BOOLEAN_GOAGENT_PROXY_USED=0
)

:: Inherit and setlocal
:-------------------------------------
rem Checking whether or not inherit current envirements.
if "%MDK_ENV_BOOLEAN_INHERIT_CURRENT_ENV%"=="" (
	set /a MDK_ENV_BOOLEAN_INHERIT_CURRENT_ENV=1
	if not "%MDK_ENV_BOOLEAN_SETLOCAL_DONE%"=="1" (
		echo sayMDK: Missing or Error set variable MDK_ENV_BOOLEAN_SETLOCAL_DONE.
		rem exit 1
	)
)

rem The command must moves to the more outer for avoidng missing set variables.
if "%MDK_ENV_BOOLEAN_SETLOCAL_DONE%"=="" (
	setlocal enabledelayedexpansion
	set /a MDK_ENV_BOOLEAN_SETLOCAL_DONE=1
	if not "%MDK_ENV_BOOLEAN_INHERIT_CURRENT_ENV%"=="1" (
		echo sayMDK: Missing or Error set variable MDK_ENV_BOOLEAN_INHERIT_CURRENT_ENV.
		exit 1
	)
)
:-------------------------------------


set HOME=%cd%
set ORIGIN_HOME=%cd%

set __MDK_ROOT=%~dp0
set __MDK_SCRIPTS_ROOT=%~dp0scripts
set __MDK_PROJECTS_ROOT=%~dp0projects
set __MDK_TOOLS_ROOT=%~dp0tools
set __MDK_OUTPUTS_ROOT=%~dp0outputs
set __MDK_WORK_ROOT=%~dp0working

call %__MDK_SCRIPTS_ROOT%/windows/common.bat
call %__MDK_SCRIPTS_ROOT%/windows/tools.bat

if "%MDK_ENV_BOOLEAN_INHERIT_CURRENT%"=="1" (
	goto :_INHERIT_CURRENT_ENV_EOF
) else (
	goto :_NOT_INHERIT_CURRENT_ENV_EOF
)

:_INHERIT_CURRENT_ENV_EOF
	echo sayMDK: Following commands will inherit current envirement variable.
	goto :_MDK_ROOT_REAL_EOF

:_NOT_INHERIT_CURRENT_ENV_EOF
	echo sayMDK: Following commands not inherit current envirement variable.
	setlocal disabledelayedexpansion
	EXIT
	goto :_MDK_ROOT_REAL_EOF

:_MDK_ROOT_REAL_EOF