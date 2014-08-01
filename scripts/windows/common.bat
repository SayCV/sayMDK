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

if "%__MDK_ROOT%"=="" (
	echo Missing MDK_ROOT Envirement.
	exit 1
)

if "%MDK_ENV_BOOLEAN_GET_ADMIN%"=="1" (
	call "%~dp0GetAdministrator.bat"
)

if %MDK_ENV_BOOLEAN_GOAGENT_PROXY_USED% ==1 (
	set http_proxy=http://127.0.0.1:8087/
	set https_proxy=http://127.0.0.1:8087/
	echo "Enable http/s proxy, depends on Goagent work fine."
) else (
	echo "Disable Goagent http/s proxy."
)

rem if "%MDK_ENV_BOOLEAN_INCLUDED_MINGW_OR_CYGWIN%"=="1" (
rem 	call "%~dp0../mingw/common.bat"
rem )

:EOF