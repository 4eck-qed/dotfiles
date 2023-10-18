#!/bin/bash

#################################################
#                   CONSTANTS                   #
#################################################
# core packages
PACKAGES_CORE=(
    "asio"
    "btop"
    "bzip2"
    "clang"
    "curl"
    "dkms"
    "fmt"
    "flameshot"
    "flatpak"
    "git-credential-oauth"
    "kitty"
    "linux-lts"
    "linux-lts-headers"
    "libc++"
    "libstdc++5"
    "mc"
    "mono"
    "nvidia-dkms"
    "nvidia-settings"
    "nvidia-utils"
    "pavucontrol"
    "polkit"
    "thunar"
    "thunar-archive-plugin"
    "sddm-git"
    "ulauncher"
    "wget"
    "xorg-server"
    "zlib"
)

# packages for programming
PACKAGES_DEV=(
    "aws-cli"
    "neovim"
    # C# / .NET
    "aspnet-runtime"
    "aspnet-targeting-pack"
    "aspnet-runtime-6.0"
    "aspnet-targeting-pack-6.0"
    "dotnet-host"
    "dotnet-runtime"
    "dotnet-sdk"
    "dotnet-targeting-pack"
    "dotnet-runtime-6.0"
    "dotnet-sdk-6.0"
    "dotnet-targeting-pack-6.0"
    "netstandard-targeting-pack"
    "nuget"
    # C / C++
    "llvm"
    "ninja"
    # Sogondi
    "lua"
    "python"
    "rustup"
    "typescript"
)

# optional packages
PACKAGES_OPT=(
    "audacity"
    "brave-bin"
    "discord"
    # "discover"
    "jdk-openjdk"
    "jre-openjdk"
    "neofetch"
    "obs-studio"
    "pinta"
    "reaper"
    "thunderbird"
    "tradingview"
    "visual-studio-code-bin"
    "vlc"
    # Gaming
    "gamescope"
    "lutris"
    "steam"
    "wowup-cf-bin"
    "xow-git"
)

# packages for hyprland
PACKAGES_HYPR=(
    "hyprland-nvidia-git"
)
# packages for dwm
PACKAGES_DWM=(
    "dwm"
)

# packages for kvm
PACKAGES_KVM=(
    "edk2-ovmf"
    "libvirt"
    "qemu-full"
    "virt-manager"
    "ebtables"
    "iptables"
    "dnsmasq"
)

KEYBOARD_CFG="setxkbmap -layout us -variant altgr-intl"
SHARED_DIR="/home/shared"
SHARED_GRP="shared"

DWM_BAR_STATUS="while xsetroot -name \"\`date\` \`uptime | sed 's/.*,//'\`\"\ndo\n\tsleep 1\ndone &"

#################################################
#                   FUNCTIONS                   #
#################################################
reload() {
    source ~/.bashrc
}

install_package() {
    yay -S --needed --noconfirm --overwrite '*' "$1"
}

install_packages() {
    local packages=($1)
    local count=${#packages[@]}

    local i=0
    for __pkg in "${packages[@]}"; do
        install_package "$__pkg" | printf "= [$__pkg]($i/$count)"

        ((i++))
    done

    reload
}

prompt() {
    subject="$1"

    echo -n "$subject (y/[n]): "
    read __response
    __response=$(echo "$__response" | tr '[:upper]' '[:lower]')
    [ "$__response" = "y" ] || [ "$__response" = "yes" ]
}
#################################################
#                   START                       #
#################################################
# cancel script @error return
set -e
echo "Welcome to barons one-script-to-success!" && sleep 1
echo -n "We're starting in 3" && sleep 1 && echo -n ", 2" && sleep 1 && echo ", 1" && sleep 1
echo -n "First of all we need to run updates.." && sudo pacman -Syu --noconfirm && echo "done!"

mkdir -p "$SHARED_DIR"
pushd "$SHARED_DIR"

sudo groupadd $SHARED_GRP || true
sudo usermod -aG shared $USER || true
sudo chmod -R g+w "$SHARED_DIR"
sudo chown -R $USER:$SHARED_GRP "$SHARED_DIR"

# get zsh, git, yay
sudo pacman -S --noconfirm --needed zsh git base-devel
sudo rm -rf ./yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
reload

# get dotfiles
mkdir -p dotfiles
pushd dotfiles
prompt "Are you baron?" && BARON=1 || BARON=0
[[ $BARON -eq 1 ]] && git clone https://github.com/4eck-qed/dotfiles.git
mv -f * "$SHARED_DIR"/
popd
./link-config.sh "$SHARED_DIR" "~"
sudo ./fix-permissions.sh "$SHARED_DIR" "$SHARED_GRP"


#################################################
#################   Install   ###################
echo ">> Core packages <<"
install_packages "$(IFS=' '; echo "${PACKAGES_CORE[*]}")"
git-credential-oauth configure

echo ">> Dev packages <<"
install_packages "$(IFS=' '; echo "${PACKAGES_DEV[*]}")"

echo ">> Optional packages <<"
install_packages "$(IFS=' '; echo "${PACKAGES_OPT[*]}")"
#################################################

if prompt "Do you want to use virtual machines?"; then
    install_packages "$(IFS=' '; echo "${PACKAGES_KVM[*]}")"
    sudo systemctl enable libvirtd.service  && sudo systemctl start libvirtd.service
    sudo systemctl enable virtlogd.socket   && sudo systemctl start virtlogd.socket
    sudo systemctl restart libvirtd
    sudo virsh net-start default
    sudo virsh net-autostart default
fi

echo ">> Window managers <<"
if prompt "Install dwm?"; then
    install_packages "$(IFS=' '; echo "${PACKAGES_DWM[*]}")"
    grep -q "$DWM_BAR_STATUS" .xinitrc || echo "$DWM_BAR_STATUS" >> .xinitrc
    grep -q "exec dwm" .xinitrc || echo "exec dwm" >> .xinitrc
    pushd ~/.config/dwm ; sudo make clean install ; popd
fi

if prompt "Install hyprland?"; then
    install_packages "$(IFS=' '; echo "${PACKAGES_HYPR[*]}")"
    # todo
fi

echo ">> Configuration <<"

grep -q "$KEYBOARD_CFG" .xinitrc || echo "$KEYBOARD_CFG" >> .xinitrc
popd
