mkdir -p ~/Pictures/screenshots
maim -s -u | tee ~/Pictures/screenshots/$(date +%s).png | xclip -selection clipboard -t image/png -i
