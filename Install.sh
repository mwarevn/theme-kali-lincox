#!/bin/bash

USER_HOME=/home/*

print_head() {
    clear
    # Print heading
    echo "Do these steps to apply theme effect!"

    # Print sections
    echo ""
    echo "[Terminal]"
    echo "  - Settings > Default Applications > Terminal Emulator: Choose \"Xfce terminal\""

    echo ""
    echo "[Appearance]"
    echo "  - Settings > Appearance > Style: Choose \"Everblush_GTK_THEME\""
    echo "  - Settings > Appearance > Fonts:"
    echo "  - Default: Roboto Regular, size 10"
    echo "  - Monospace: JetbrainsMono Nerd Font Mono Regular, size 10"

    echo ""
    echo "[Window Manager]"
    echo "  - Settings > Window Manager > Style: Choose \"Everblush-xfwm\""

    echo ""
    echo "[Mouse and touchpad]"
    echo "  - Settings > Mouse and Touchpad > Theme: Choose \"Radioactive-nord\""

    echo ""
    echo "[Desktop]"
    echo "  - Settings > Kvantum Manager > Change/delete theme: Choose \"everblush\""
    echo "  - Settings > Desktop > Icons: Change \"icon type\" to \"none\""
    echo "  - Settings > Desktop > Background: Select wallpapers path (/home/username/.local/share/wallpapers)"

    echo ""
    echo "[LightDM GTK+ Greeter Settings]"
    echo "  - LightDM GTK+ Greeter Settings > Theme: Choose \"Everblush\""
    echo "  - LightDM GTK+ Greeter Settings > Icons: Choose \"nordzy-cyan-dark-MOD\""
    echo "  - LightDM GTK+ Greeter Settings > Color: Select \"#232a2d\""

    echo ""
    echo "[Session and Startup]"
    echo "  - Settings > Session and Startup > Application Autostart: Disable \"Screen Locker (Launch screen locker program)\""

    # End script
    echo ""
    echo "Restart to take effects."
    echo ""
}

install_theme() {
    # Install packages
    sudo apt install mugshot xfce4-terminal qt5-style-kvantum qt5-style-kvantum-themes i3lock-color 

    # Create necessary directories
    mkdir -p $USER_HOME/.themes
    mkdir -p $USER_HOME/.local/share/icons
    mkdir -p $USER_HOME/.local/share/fonts
    mkdir -p $USER_HOME/.local/share/wallpapers

    # Set lock command for XFCE session
    xfconf-query --create -c xfce4-session -p /general/LockCommand -t string -s "i3lock-everblush"

    # Copy i3lock-everblush to /usr/bin
    sudo cp -R i3lock-color-everblush/i3lock-everblush /usr/bin

    # Copy GTK theme to user's themes directory and system themes directory
    cp -R GTK-XFWM-Everblush-Theme/* $USER_HOME/.themes
    sudo cp -R GTK-XFWM-Everblush-Theme/Everblush /usr/share/themes

    # Copy icon theme to user's icons directory and system icons directory
    cp -R Nordzy-cyan-dark-MOD $USER_HOME/.local/share/icons
    sudo cp -R Nordzy-cyan-dark-MOD /usr/share/icons

    # Copy fonts to user's font directory
    cp -R fonts/* $USER_HOME/.local/share/fonts

    # Copy Kvantum theme to user's config directory
    cp -R Kvantum $USER_HOME/.config

    # Copy wallpapers to user's wallpaper directory
    cp -R wallpapers/* $USER_HOME/.local/share/wallpapers

    # Function to check if directory exists
    check_directory() {
        if [ -d "$1" ]; then
            echo "$1 already exists."
            return 1
        else
            return 0
        fi
    }

    # Clone and install Radioactive Nord theme if not already present
    if check_directory "Radioactive-nord"; then
        git clone https://github.com/alvatip/Radioactive-nord.git
    fi

    # Navigate to Radioactive-nord directory and run install script
    cd Radioactive-nord || exit
    ./install.sh
    cd ..

    print_head
}

remove_theme() {
    sudo apt autoremove mugshot xfce4-terminal qt5-style-kvantum qt5-style-kvantum-themes i3lock-color 

    sudo rm -rf /usr/bin/i3lock-everblush
    sudo rm -rf $USER_HOME/.themes/Everblush*
    sudo rm -rf /usr/share/themes/Everblush
    sudo rm -rf $USER_HOME/.local/share/icons/Nordzy-cyan-dark-MOD
    sudo rm -rf /usr/share/icons/Nordzy-cyan-dark-MOD
    sudo rm -rf $USER_HOME/.local/share/fonts
    sudo rm -rf $USER_HOME/.config/Kvantum
    sudo rm -rf $USER_HOME/.local/share/wallpapers
    sudo rm -rf /usr/share/icons/Radioactive*
    sudo rm -rf $USER_HOME/.icons/Radioactive*

    echo ""
    echo "Remove done, restart the system to take efftects."
}

case $1 in
    "--help")
    echo ""
        echo "Usage: "
        echo "  sudo bash ./Install.sh <pramater>"
        echo ""
        echo "Pramaters: "
        echo "  --install | start install theme automatically."
        echo "  --config  | show config step to apply the theme affter installation."
        echo "  --remove  | auto remove the theme."
        echo "  --help    | show this help."
        ;;
    "--config")
        print_head
        ;;
    "--remove")
        remove_theme
        ;;
    "--install")
        install_theme
        ;;
esac
