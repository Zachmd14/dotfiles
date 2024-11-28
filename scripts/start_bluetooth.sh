#!/bin/bash

# start bluetooth services
systemctl start bluetooth.service
pulseaudio -k
