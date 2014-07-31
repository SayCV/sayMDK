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

set __MINGW_ROOT=D:/MinGW

setlocal enabledelayedexpansion

if '1'=='1' (
	set "PATH=!__MINGW_ROOT!/bin;!PATH!"
	set "PATH=!__MINGW_ROOT!/msys/1.0/bin;!__MINGW_ROOT!/msys/1.0/local/bin;!PATH!"
	echo "On Windows, We are running under MinGW"
) else (
	echo Nothing.
)

setlocal disabledelayedexpansion

:EOF