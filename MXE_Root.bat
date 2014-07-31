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
	set /a MDK_ENV_BOOLEAN_GET_ADMIN=1
)

rem Checking proxy envirement.
if "%MDK_ENV_BOOLEAN_GOAGENT_PROXY_USED%"=="" (
	set /a MDK_ENV_BOOLEAN_GOAGENT_PROXY_USED=0
)

set HOME=%cd%
set ORIGIN_HOME=%cd%

set __MDK_ROOT=%~dp0
set __MDK_SCRIPTS_ROOT=%~dp0scripts
set __MDK_PROJECTS_ROOT=%~dp0projects
set __MDK_TOOLS_ROOT=%~dp0tools
set __MDK_OUTPUTS_ROOT=%~dp0outputs

call %__MDK_SCRIPTS_ROOT%/windows/common.bat
call %__MDK_SCRIPTS_ROOT%/windows/tools.bat


:EOF