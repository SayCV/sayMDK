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

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_SVN%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_SVN=1
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_GIT%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_GIT=1
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_HG%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_HG=1
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_JAVA1D6%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_JAVA1D6=1
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_JAVA1D6%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_JAVA1D6=1
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_JAVA1D7%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_JAVA1D7=0
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_PERL%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_PERL=1
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_PYTHON2%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_PYTHON2=1
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_PYTHON3%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_PYTHON3=0
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_MS_VS%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_MS_VS=1
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_QT%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_QT=1
)

if "%MDK_ENV_BOOLEAN_INCLUDED_TOOLS_GOLANG%"=="" (
	set /a MDK_ENV_BOOLEAN_INCLUDED_TOOLS_GOLANG=1
)

:EOF