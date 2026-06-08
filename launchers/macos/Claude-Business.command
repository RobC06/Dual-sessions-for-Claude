#!/bin/bash
# ============================================================
#  Launch Claude in your BUSINESS Chrome profile (app window)
# ============================================================
#  Set PROFILE to the profile's INTERNAL folder name, NOT the
#  display name. Find it at chrome://version -> "Profile Path"
#  (use the last folder, e.g. Default, "Profile 1", ...).
# ------------------------------------------------------------

PROFILE="Profile 1"
URL="https://claude.ai"

open -na "Google Chrome" --args --profile-directory="$PROFILE" --app="$URL"
