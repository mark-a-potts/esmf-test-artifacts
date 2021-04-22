#!/bin/bash

git checkout origin/plavac develop/plavac
git status
git add develop/plavac
git commit -a -m'adding changes'
git push origin main
return 0
