Kitchencam
==========

Kitchencam is a suite of tools designed to maintain time-lapse videos from a usb webcam and present them on a static webpage.

Prerequisites
-------------
* ImageMagick
* fswebcam
* ffmpeg (with libx264 and libvpx encoders)
* bash

Usage
------
`capture.sh` is intended to be run often (~every 5 seconds) via cronjob or similar.  It will capture a new frame from the video device, tag it with the date and time (not actually working yet), and compare it to the previous frame, deleting the frame if sufficiently similar.

Run `make` to update the time-lapse videos and webpage from the capture directories.  This will re-encode the timelapses for any updated capture directories, then run `web.sh` to rebuild the static page.  As the re-encode may be resource-intensive, this is intended to be run at a longer interval than `capture.sh`, perhaps once an hour.
