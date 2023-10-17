#!/bin/bash

TEST=0

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

#################################################
#                   FUNCTIONS                   #
#################################################
reload() {
    source ~/.bashrc
}

install() {
    local packages=($1)

    for __pkg in "${packages[@]}"; do
        if [[ $TEST -eq 1 ]]; then
            printf "> install '$__pkg' <\n"
        else
            yes | yay -S --noconfirm --needed "$__pkg" --overwrite '*'
        fi
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

pushd /home/shared
if [[ $TEST -eq 0 ]]; then
    mkdir -p /home/shared
    sudo groupadd shared || true
    sudo usermod -aG shared $USER || true
    sudo chmod -R g+w /home/shared
    sudo chown -R $USER:shared /home/shared
    sudo pacman -Syu --noconfirm

    # get zsh, git, yay
    sudo pacman -S --noconfirm --needed zsh git base-devel
    sudo rm -rf ./yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
fi
reload

echo ">> Core packages <<"
install "$(IFS=' '; echo "${PACKAGES_CORE[*]}")"
git-credential-oauth configure

echo ">> Dev packages <<"
install "$(IFS=' '; echo "${PACKAGES_DEV[*]}")"

echo ">> Optional packages <<"
install "$(IFS=' '; echo "${PACKAGES_OPT[*]}")"

if prompt "Do you want to use virtual machines?"; then
    install "$(IFS=' '; echo "${PACKAGES_KVM[*]}")"
    sudo systemctl enable libvirtd.service && sudo systemctl start libvirtd.service
    sudo systemctl enable virtlogd.socket && sudo systemctl start virtlogd.socket
    sudo systemctl restart libvirtd
    sudo virsh net-start default
    sudo virsh net-autostart default
fi

echo ">> Window managers <<"
prompt "Install dwm?" && install "$(IFS=' '; echo "${PACKAGES_DWM[*]}")"
prompt "Install hyprland?" && install "$(IFS=' '; echo "${PACKAGES_HYPR[*]}")"

echo ">> Configuration <<"
prompt "Are you baron?" && BARON=1 || BARON=0
# get dotfiles
[[ $BARON -eq 1 ]] && git clone https://github.com/4eck-qed/dotfiles.git
popd
