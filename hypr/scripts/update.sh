#!/bin/bash
UPDATE=$(checkupdates)
UPDATECOUNT=$(checkupdates | wc -l)
echo $UPDATECOUNT
echo "$UPDATE" | column -t | tr "\n" "\r"
