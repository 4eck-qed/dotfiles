#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[0;33m'
YELLOW_BOLD='\033[1;33m'
GREEN='\033[0;32m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

DIR_COLOR="$YELLOW"
S1="$CYAN>$DIR_COLOR"
S2="$CYAN<$DIR_COLOR"

CURSOR_UP="\033[A"
LINE_END="\033[K"

shared_dir="/home/shared"

# $1 : from
# $2 : to
ln_checked()
{
    from="$1"
    to="$2"

    if [ -e "$to" ]; then
        echo -e $RED[Error] $DIR_COLOR $S1$to$S2 $RED already exists$NC
        return 1
    else
        echo -e $GREEN[YES] Linking from $DIR_COLOR $S1$from$S2 $GREEN to $DIR_COLOR $S1$to$S2$NC
        ln -s "$from" "$to"
        return 0
    fi
}

# $1 : path to .config
ln_dotconfig()
{
    target_dir="$1"
    echo -e "$YELLOW_BOLD╔════════════════════════ .config ══════════════════════════════╗$NC"
    echo -e "                       $target_dir"
    
    i=1
    for entry in "$shared_dir/.config/"*
    do
        # Extract the entry name without the path
        entry_name=$(basename "$entry")
        
        # Skip backups
        if [[ "$entry_name" == *-bkp* ]]; then
            continue
        fi
        
        target_entry="$target_dir/$entry_name"
        
        # Link it up, continue on fail
        ln_checked "$entry" "$target_entry" || continue

        ((i++))
    done

    echo -e "                   $CYAN$((i-1)) new links have been created$NC"
    echo -e "$YELLOW_BOLD╚═══════════════════════════════════════════════════════════════╝$NC"
}

# $1 : path to .local
ln_dotlocal()
{
    dotlocal="$shared_dir/.local"
    target_dir="$1"
    echo -e "$MAGENTA╔════════════════════════ .local ═══════════════════════════════╗$NC"
    echo -e "                       $target_dir"

    ln_checked "$dotlocal/bin" "$target_dir/bin"
    ln_checked "$dotlocal/share/nvim" "$target_dir/share/nvim"

    echo -e "$MAGENTA╚═══════════════════════════════════════════════════════════════╝$NC"    
}

# $1 : path to root
ln_home()
{
    target_dir="$1"
    echo -e "$GREEN╔════════════════════════   ~   ════════════════════════════════╗$NC"
    echo -e "                       $target_dir"

    ln_checked "$shared_dir/.xinitrc" "$target_dir/.xinitrc"
    ln_checked "$shared_dir/.zshrc" "$target_dir/.zshrc"
    ln_checked "$shared_dir/.Xresources" "$target_dir/.Xresources"

    echo -e "$GREEN╚═══════════════════════════════════════════════════════════════╝$NC"
}

ln_dotconfig /home/baron/.config
ln_dotlocal /home/baron/.local
ln_home /home/baron

ln_dotconfig /home/schaper/.config
ln_dotlocal /home/schaper/.local
ln_home /home/schaper

ln_checked /home/shared/Pictures/wallpapers /home/baron/Pictures/wallpapers
ln_checked /home/shared/Pictures/wallpapers /home/schaper/Pictures/wallpapers

# Fix permissions
read -p "$(echo -e ${CYAN}"Fix permissions [may require sudo]? (y/n): "${NC})" choice
if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
    /home/shared/fix-permissions.sh
fi
