#!/bin/bash

cd /home/zach/Documents/Emacs/org-roam/
git pull origin
git add .
git commit -m 'update'
git push origin main
