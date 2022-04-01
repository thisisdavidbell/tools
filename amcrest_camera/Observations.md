# Observations

Below is historic data used to test the scheduled solution. This confirmed that a scheduled task was sub-optimum, thus going with the events approach.

### Details

A dashboard reloads a live stream every 10 minutes.

For reference I detect actual reboots using a ping test, graphed in Home Assistant, which runs every 5 seconds.

The reboots are not predictable. The camera can reboot every 5 minutes, or can go hours without an issue. Therefore resolving the problem in this way is about probability. Below I am testing various sleep periods between checks, to see if there is a sensible value, which means close to zero occurances:

### Check every X:

- Script not running (7:30pm - 10pm - then changed values)
  - 8 reboots in 2 1/2 hours

- 1 second
  - 0 reboots in 6 hours

- 10 seconds
  - 0 reboots in 6 hours

- 1 min
  - 0 in 2 hours

- 2 minutes
  - 0 reboots in 3 hours

- 3 minutes (started at )
  - 0 reboots - after 10pm Sun 20th
  - 6 reboots - after 7:30pm Mon 21st SO FAR
    - 3rd time was triggered by manually viewing stream in Amcrest app
      - note it appears up for over 2 mins, but failed before 3.
    - in app, back to front page, then into stream this time reset mode again
      - this time, app crashed in a little under a minute since reset
      - implies even 1 min wont be enough some of the time.

- 5 minutes
  - 2 hours, 2 reboot

  - Notes: 
    - after restarting dashboard (so a new stream) camera went down shortly after. Then went down a second time, seemingly before the 3 mins reset to manual.
    - kicked off script mysefl as soon as I heard camera back up - weirdly the camera was set to Manual when script ran - did previous 'camera down' command actually complete after the 5 sec time out?
