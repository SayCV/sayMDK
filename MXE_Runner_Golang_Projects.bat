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

cd /d %~dp0

rem echo set dos windows size : cols=113, lines=150, color=black
rem mode con cols=113 lines=1500 & color 0f

set HOME=%cd%
set ORIGIN_HOME=%cd%

rem default 1
rem set /a MDK_ENV_BOOLEAN_INCLUDED_MINGW_OR_CYGWIN=1
rem set /a MDK_ENV_BOOLEAN_GET_ADMIN=1

rem default 0
rem set /a MDK_ENV_BOOLEAN_GOAGENT_PROXY_USED=1
set /a MDK_ENV_BOOLEAN_INHERIT_CURRENT=1
rem set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_MS_VS=1

if "%MDK_ENV_BOOLEAN_INHERIT_CURRENT%"=="1" (
	setlocal enabledelayedexpansion
	set /a MDK_ENV_BOOLEAN_SETLOCAL_DONE=1
	call %~dp0MXE_Root.bat
)

if "1"=="1" (
	rem stock prediction program
	go get github.com/go-sql-driver/mysql
	go get github.com/gorilla/mux
	go get github.com/gorilla/websocket
	go get github.com/SayCV/stockBrain
	
	rem cd %ORIGIN_HOME%/working/golang/src/github.com/SayCV/stockBrain
	cd %GOPATH%/src/github.com/SayCV/stockBrain
	
	go build main.go
)

:-------------------------------------
:: EOF 
:-------------------------------------
if "1"=="1" (
	goto :_MDK_RUNNER_REAL_EOF
)

:LOOP
	title %~n0
	cmd
	goto :LOOP

:_MDK_RUNNER_REAL_EOF
	PAUSE
	EXIT