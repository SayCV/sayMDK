#!/bin/sh
#
# Copyright (C) 2014 The sayMDK Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PROGDIR=`dirname $0`
PROGDIR=`cd $PROGDIR && pwd -P`

# Check if absolute MDK path contain space
#
case $PROGDIR in
    *\ *) echo "ERROR: MDK path cannot contain space"
          exit 1
        ;;
esac

# If MDK_LOG is set to 1 or true in the environment, or the command-line
# then enable log messages below
# Also normalize MDK_HOST_32BIT and MDK_ANALYZE to 1 or 0
if [ -z "$MDK_LOG" ]; then
  MDK_LOG=0
fi

if [ -z "$MDK_HOST_32BIT" ]; then
  MDK_HOST_32BIT=0
fi

if [ -z "$MDK_ANALYZE" ]; then
  MDK_ANALYZE=0
fi

PROJECT_PATH=
PROJECT_PATH_NEXT=
for opt; do
    if [ -z "$PROJECT_PATH" -a "$PROJECT_PATH_NEXT" = "yes" ] ; then
        PROJECT_PATH=$opt
        PROJECT_PATH_NEXT=
    else
        case $opt in
          MDK_LOG=1|MDK_LOG=true)
            MDK_LOG=1
            ;;
          MDK_LOG=*)
            MDK_LOG=0
            ;;
          MDK_HOST_32BIT=1|MDK_HOST_32BIT=true)
            MDK_HOST_32BIT=1
            ;;
          MDK_HOST_32BIT=*)
            MDK_HOST_32BIT=0
            ;;
          MDK_ANALYZE=1|MDK_ANALYZE=true)
            MDK_ANALYZE=1
            ;;
          MDK_ANALYZE=*)
            MDK_ANALYZE=0
            ;;
          MDK_TOOLCHAIN_VERSION=*)
            MDK_TOOLCHAIN_VERSION=${opt#MDK_TOOLCHAIN_VERSION=}
            ;;
          APP_ABI=*)
            APP_ABI=${opt#APP_ABI=}
            ;;
          -C)
            PROJECT_PATH_NEXT="yes"
            ;;
        esac
    fi
done

if [ "$MDK_LOG" = "true" ]; then
  MDK_LOG=1
fi

if [ "$MDK_HOST_32BIT" = "true" ]; then
  MDK_HOST_32BIT=1
fi

if [ "$MDK_ANALYZE" = "true" ]; then
  MDK_ANALYZE=1
fi

if [ "$MDK_LOG" = "1" ]; then
  log () {
    echo "$@"
  }
else
  log () {
    : # nothing
  }
fi

# Detect host operating system and architecture
# The 64-bit / 32-bit distinction gets tricky on Linux and Darwin because
# uname -m returns the kernel's bit size, and it's possible to run with
# a 64-bit kernel and a 32-bit userland.
#
HOST_OS=$(uname -s)
case $HOST_OS in
  Darwin) HOST_OS=darwin;;
  Linux) HOST_OS=linux;;
  FreeBsd) HOST_OS=freebsd;;
  CYGWIN*|*_NT-*) HOST_OS=cygwin;;
  *) echo "ERROR: Unknown host operating system: $HOST_OS"
     exit 1
esac
log "HOST_OS=$HOST_OS"

HOST_ARCH=$(uname -m)
case $HOST_ARCH in
    i?86) HOST_ARCH=x86;;
    x86_64|amd64) HOST_ARCH=x86_64;;
    *) echo "ERROR: Unknown host CPU architecture: $HOST_ARCH"
       exit 1
esac
log "HOST_ARCH=$HOST_ARCH"

# Detect 32-bit userland on 64-bit kernels
HOST_TAG="$HOST_OS-$HOST_ARCH"
case $HOST_TAG in
  linux-x86_64|darwin-x86_64)
    # we look for x86_64 or x86-64 in the output of 'file' for our shell
    # the -L flag is used to dereference symlinks, just in case.
    file -L "$SHELL" | grep -q "x86[_-]64"
    if [ $? != 0 ]; then
      HOST_ARCH=x86
      log "HOST_ARCH=$HOST_ARCH (32-bit userland detected)"
    fi
    ;;
esac

# Check that we have 64-bit binaries on 64-bit system, otherwise fallback
# on 32-bit ones. This gives us more freedom in packaging the MDK.
LOG_MESSAGE=
if [ $HOST_ARCH = x86_64 ]; then
  if [ ! -d $PROGDIR/prebuilt/$HOST_TAG ]; then
    HOST_ARCH=x86
    LOG_MESSAGE="(no 64-bit prebuilt binaries detected)"
  fi

  if [ "$MDK_HOST_32BIT" = "1" ]; then
    HOST_ARCH=x86
    LOG_MESSAGE="(force 32-bit host toolchain)"
  fi
fi

HOST_TAG=$HOST_OS-$HOST_ARCH
# Special case windows-x86 -> windows
if [ $HOST_TAG = windows-x86 ]; then
  HOST_TAG=windows
fi
log "HOST_TAG=$HOST_TAG $LOG_MESSAGE"

# If GNUMAKE is defined, check that it points to a valid file
if [ -n "$GNUMAKE" ] ; then
    ABS_GNUMAKE=`which $GNUMAKE 2> /dev/null`
    if [ $? != 0 ] ; then
        echo "ERROR: Your GNUMAKE variable is defined to an invalid name: $GNUMAKE"
        echo "Please fix it to point to a valid make executable (e.g. /usr/bin/make)"
        exit 1
    fi
    GNUMAKE="$ABS_GNUMAKE"
    log "GNUMAKE=$GNUMAKE (from environment variable)"
else
    # Otherwise use the prebuilt version for our host tag, if it exists
    # Note: we intentionally do not provide prebuilt make binaries for Cygwin
    # or MSys.
    GNUMAKE=$PROGDIR/prebuilt/$HOST_TAG/bin/make
    if [ ! -f "$GNUMAKE" ]; then
        # Otherwise, use 'make' and check that it is available
        GNUMAKE=`which make 2> /dev/null`
        if [ $? != 0 ] ; then
            echo "ERROR: Cannot find 'make' program. Please install Cygwin make package"
            echo "or define the GNUMAKE variable to point to it."
            exit 1
        fi
        log "GNUMAKE=$GNUMAKE (system path)"
    else
        log "GNUMAKE=$GNUMAKE (MDK prebuilt)"
    fi
fi

# On Windows, when running under cygwin, check that we are
# invoking a cygwin-compatible GNU Make binary. It is unfortunately
# common for app developers to have another non cygwin-compatible
# 'make' program in their PATH.
#
if [ "$OSTYPE" = "cygwin" ] ; then
    GNUMAKE=`cygpath -u $GNUMAKE`
    PROGDIR_MIXED=`cygpath -m $PROGDIR`
    CYGWIN_GNUMAKE=`$GNUMAKE -f "$PROGDIR_MIXED/build/core/check-cygwin-make.mk" 2>&1`
    if [ $? != 0 ] ; then
        echo "ERROR: You are using a non-Cygwin compatible Make program."
        echo "Currently using: `cygpath -m $GNUMAKE`"
        echo ""
        echo "To solve the issue, follow these steps:"
        echo ""
        echo "1. Ensure that the Cygwin 'make' package is installed."
        echo "   NOTE: You will need GNU Make 3.81 or later!"
        echo ""
        echo "2. Define the GNUMAKE environment variable to point to it, as in:"
        echo ""
        echo "     export GNUMAKE=/usr/bin/make"
        echo ""
        echo "3. Call 'MDK-build' again."
        echo ""
        exit 1
    fi
    log "Cygwin-compatible GNU make detected"
fi
