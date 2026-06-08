@echo off
REM ============================================================
REM  Launch Claude in your PERSONAL Chrome profile (app window)
REM ============================================================
REM  Set PROFILE to the profile's INTERNAL folder name, NOT the
REM  display name. Find it at chrome://version -> "Profile Path"
REM  (use the last folder, e.g. Default, "Profile 1", ...).
REM ------------------------------------------------------------

set "PROFILE=Default"
set "URL=https://claude.ai"

REM If "chrome" isn't found, replace it below with the full path:
REM "C:\Program Files\Google\Chrome\Application\chrome.exe"
start "" chrome --profile-directory="%PROFILE%" --app="%URL%"
