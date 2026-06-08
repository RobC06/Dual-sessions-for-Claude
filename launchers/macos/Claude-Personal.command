#!/bin/bash
# ============================================================
#  Launch Claude in your PERSONAL Chrome profile (app window)
# ============================================================
#  Set PROFILE to the profile's INTERNAL folder name, NOT the
#  display name. Find it at chrome://version -> "Profile Path"
#  (use the last folder, e.g. Default, "Profile 1", ...).
# ------------------------------------------------------------

PROFILE="Default"
URL="https://claude.ai"

open -na "Google Chrome" --args --profile-directory="$PROFILE" --app="$URL"
