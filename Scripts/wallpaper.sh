#!/bin/bash

# Directory containing the wallpapers
WALLPAPER_DIR="$XDG_PICTURES_DIR/wallpapers"

while true; do
    # Get a random image from the directory
    RANDOM_IMAGE=$(ls $WALLPAPER_DIR | shuf -n 1)
    
    # Set the random image as the wallpaper using feh
    feh --bg-fill "$WALLPAPER_DIR/$RANDOM_IMAGE"
    
    # Wait for 10 minutes
    sleep 600
done