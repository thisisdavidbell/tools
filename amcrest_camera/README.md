# Amcrest Camera IR Power Fix

This directory contains 2 scripts used to resolve a known issue with insufficient power from the power ada[pter on the Amcrest AD110 Doorbell. There is no issue if the camera runs with auto ir but at a fixed brightness (say 25%). However, whenever a new RTSP stream is initiated, the Amcrest camera sets the ir mode to `Smartlight` which results in the ir becoming very bright, and the camera resetting apparently due to a lack of power. The scripts spot this situation and immediately change the mode back from `Smartlight` to `Manual` with a brightness of `25%`.

## Scripts

# amcrest_monitor_events.sh

The recommended script, which watches for new RTSP streaming events, checking the ir mode. If it finds the mode set to `SmartLight`, it sets it to `Manual`. It actually uses the `amcrest_scheduled_checks.sh` script to do the check and reset.

# amcrest_scheduled_checks.sh

Script which monitors the ir mode, every X seconds, and if it finds it is not set to `Manual` (in most cases this means it is set to `SmartLight`), it sets the mode to `Manual`. It also sets the ir brightness to `25`.
It can be run on its own as a background job to resolve the issue, but the recommended solution is to use `amcrest_monitor_events.sh`.