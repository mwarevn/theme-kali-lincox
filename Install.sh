#!/bin/bash

print_head() {
    clear
    # Print heading
    echo "Hướng dẫn tùy chỉnh"
    # Print sections (unchanged)
    # ...
}

install_theme() {
    # Install packages
    sudo apt install mugshot xfce4-terminal qt5-style-kvantum qt5-style-kvantum-themes i3lock-color 

    # Create necessary directories
    mkdir -p $HOME/.themes
    mkdir -p $HOME/.local/share/icons

    # Set lock command for XFCE session
    sudo xfconf-query --create -c xfce4-session -p /general/LockCommand -t string -s "i3lock-everblush"

    # Copy i3lock-everblush to /usr/bin
    sudo cp -R i3lock-color-everblush/i3lock-everblush /usr/bin

    # Copy GTK theme to user's themes directory and system themes directory
    cp -R GTK-XFWM-Everblush-Theme/* $HOME/.themes
    sudo cp -R GTK-XFWM-Everblush-Theme/Everblush /usr/share/themes

    # Copy icon theme to user's icons directory and system icons directory
    cp -R Nordzy-cyan-dark-MOD $HOME/.local/share/icons
    sudo cp -R Nordzy-cyan-dark-MOD /usr/share/icons

    # Copy fonts to user's font directory
    cp -R fonts $HOME/.local/share

    # Copy Kvantum theme to user's config directory
    cp -R Kvantum $HOME/.config

    # Copy wallpapers to user's wallpaper directory
    cp -R wallpapers $HOME/.local/share

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
    sudo rm -rf $HOME/.themes/Everblush*
    sudo rm -rf /usr/share/themes/Everblush
    sudo rm -rf $HOME/.local/share/icons/Nordzy-cyan-dark-MOD
    sudo rm -rf /usr/share/icons/Nordzy-cyan-dark-MOD
    sudo rm -rf $HOME/.local/share/fonts
    sudo rm -rf $HOME/.config/Kvantum
    sudo rm -rf $HOME/.local/share/wallpapers
    sudo rm -rf /usr/share/icons/Radioactive*
    sudo rm -rf $HOME/.icons/Radioactive*

    echo ""
    echo "Remove done, restart the system to take effects."
}

case $1 in
    "--help")
        echo ""
        echo "Usage: "
        echo "  sudo bash ./Install.sh <parameter>"
        echo ""
        echo "Parameters: "
        echo "  --install | start install theme automatically."
        echo "  --config  | show config step to apply the theme after installation."
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
