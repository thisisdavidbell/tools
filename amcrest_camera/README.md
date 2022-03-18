# Amcrest Camera

`amcrest.sh` monitors the ir mode, every X seconds, and if it finds it set to `SmartLight`, it sets it to `Manual`. It also sets the ir brightness to 25.
This is to prevent the camera restarting, which it does frequently in SmartLight mode. 

# Recreate Data

For reference I detect actual reboots using a ping test, graphed in Home Assistant, which runs every 5 seconds.

The reboots are not predictable. The camera can reboot every 5 minutes, or can go hours without an issue. Therefore resolving the problem in this way is about probability. Below I am testing various sleep periods between checks, to see if there is a sensible value, which means close to zero occurances:

### Check every X seconds:

- 1 second
  - 1/2 night with zero reboots

- 10 seconds
  - 1/2 night with zero reboots

- 5 minutes
  - 2 hours so far, 1 reboot