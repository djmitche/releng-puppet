REM This Source Code Form is subject to the terms of the Mozilla Public
REM License, v. 2.0. If a copy of the MPL was not distributed with this
REM file, You can obtain one at http://mozilla.org/MPL/2.0/.

if exist c:\etc\MOTD.txt (
 type "c:\etc\MOTD.txt"
 echo.
)

cd %USERPROFILE%

%SYSTEMDRIVE%\mozilla-build\msys\bin\bash.exe --login
