#!/bin/bash

print_head() {
    clear
    # Print heading
    echo "Hướng dẫn tùy chỉnh"

    # Print sections
    echo ""
    echo "Terminal"
    echo " - Settings > Default Applications > Terminal Emulator: Chọn \"Xfce terminal\""

    echo ""
    echo "Giao diện"
    echo " - Settings > Appearance > Style: Chọn \"Everblush_GTK_THEME\""
    echo " - Settings > Appearance > Fonts:"
    echo "    - Mặc định: Roboto Regular, Kích thước 10"
    echo "    - Monospace: JetbrainsMono Nerd Font Mono Regular, Kích thước 10"

    echo ""
    echo "Trình quản lý cửa sổ"
    echo " - Settings > Window Manager > Style: Chọn \"Everblush-xfwm\""

    echo ""
    echo "Chuột"
    echo " - Settings > Mouse and Touchpad > Theme: Chọn \"Radioactive-nord\""

    echo ""
    echo "Màn hình desktop"
    echo " - Settings > Kvantum Manager > Change/delete theme: Chọn \"everblush\""
    echo " - Settings > Desktop > Icons: Chọn \"Loại biểu tượng\" thành \"không\""
    echo " - Settings > Desktop > Background: Chọn đường dẫn hình nền và chọn hình nền"

    echo ""
    echo "Màn hình đăng nhập (LightDM)"
    echo " - LightDM GTK+ Greeter Settings > Theme: Chọn \"Everblush\""
    echo " - LightDM GTK+ Greeter Settings > Icons: Chọn \"nordzy-cyan-dark-MOD\""
    echo " - LightDM GTK+ Greeter Settings > Color: Chọn \"#232a2d\""

    echo ""
    echo "Khởi động tự động"
    echo " - Settings > Session and Startup > Application Autostart: Kích hoạt \"Screen Locker (Launch screen locker program)\""

    echo ""
    echo "Lưu ý"
    echo " - Vị trí chính xác của cài đặt có thể thay đổi tùy theo bản phân phối Linux và môi trường desktop của bạn."
    echo " - Bạn có thể cần cài đặt một số chủ đề hoặc phông chữ trước khi chúng xuất hiện trong cài đặt."

    # End script
    echo ""
    echo "Restart để  cập nhật giao diện"
    echo ""
    echo "Hoàn tất hướng dẫn"
}

# Install packages
sudo apt install mugshot xfce4-terminal qt5-style-kvantum qt5-style-kvantum-themes i3lock-color 

# Create necessary directories
mkdir -p $HOME/.themes
mkdir -p $HOME/.local/share/icons

# Set lock command for XFCE session
xfconf-query --create -c xfce4-session -p /general/LockCommand -t string -s "i3lock-everblush"

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