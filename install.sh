#!/bin/bash

set -e 

# Verificar/instalar gum
if ! command -v gum &> /dev/null; then
    echo "Instalando gum..."
    sudo pacman -S --noconfirm --needed gum
fi

neko_arc(){ 
cat << "EOF"
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠤⢤⡀⠀⢀⡤⠒⠢⣀⡠⠴⠒⢂⣠⡽⢧⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⠊⠁⠀⠀⠀⠈⠓⠁⠀⠀⠀⠀⢠⣴⣾⣿⣟⣁⢸⡇⠀⠀
⣀⠀⠠⠤⠤⠔⠒⠒⠛⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠈⠻⣤⢶⡭⠟⢻⡇⠀⠀
⣧⠤⠖⣲⣖⣒⡶⢶⣶⠂⠀⠀⠀⠀⢀⣀⣀⡐⠲⠬⠛⠉⠀⠀⠈⢶⣯⣦⣸⡇⠀⠀
⢹⣆⡾⠟⡷⢋⡥⡼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡀⣀⠀⢠⠀⠈⠻⡽⡻⠁⠀⠀
⠈⢿⡀⣼⡾⢿⢳⠃⠀⠀⠀⡀⠀⡀⠀⡄⣴⣠⣇⡟⣷⣼⠗⠒⠓⠤⣀⠘⢆⠀⠀⠀
⠀⠈⢟⢏⠀⣿⡇⠀⠀⠀⣴⡇⣼⣀⠼⠷⣻⣏⣿⡞⠁⣿⣆⠀⠀⠀⠈⠣⣄⣣⡀⠀
⠀⠀⠀⢳⠽⠟⡃⠀⠀⣸⡿⢺⣷⡀⠀⠀⠀⠙⢾⠀⠀⠹⣿⡄⠀⠀⢀⣶⡌⢟⠿⣄
⠀⠀⠀⡎⣠⣾⡇⠀⢰⡻⠁⠈⣿⣧⠀⠀⠀⠀⣸⠣⣄⣀⠹⢇⣀⠴⠟⡏⠘⢎⢆⠀
⠀⠀⡼⠿⢻⣿⠁⢠⠇⢣⡀⠀⠘⣿⠀⠀⣀⠴⠁⠀⠀⠈⢹⠉⠀⢀⣿⡷⢄⣨⣿⡄
⠀⠀⠀⠀⣸⠿⠒⠛⠒⠴⣿⡖⢤⠚⠒⠉⢣⡀⠀⡴⠓⠂⠚⠀⢠⣾⠇⢸⠀⠉⠻⠇
⠀⠀⢀⡜⠁⠀⠀⠀⠰⡀⠈⢿⡮⣗⢄⡀⠀⠀⠁⠀⠀⢀⣠⢾⣿⠃⠑⢾⠀⠀⠀⠀
⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⢸⣡⢻⣹⣿⡗⢶⡶⠲⣾⣿⠛⢲⡽⣀⠀⠀⠀⠀⠀⠀
⠀⠀⢸⣆⠀⠀⠀⠀⠀⠀⢀⠾⡟⠻⣧⠙⣎⠙⠢⢤⡼⠋⠀⠰⡇⠈⠑⢤⡀⠀⠀⠀
⠀⠀⠀⠱⢝⡒⠠⠤⠤⣴⡛⠒⡟⠀⠈⠂⣸⠀⠀⠀⠀⠀⠀⠀⢏⣳⡤⠀⠘⡆⠀⠀
⠀⠀⠀⠀⠀⠉⠀⠀⠉⠱⡌⣹⣃⣠⣴⠾⢽⡀⠀⠀⠀⠀⠀⠀⢸⠏⢀⣀⣼⠃⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠁⠘⡀⠀⣏⠀⠀⠀⠀⠀⠀⢸⡀⢀⠈⢃⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣇⠀⢸⡆⠀⠀⠀⠀⠀⣠⡇⠀⠁⢸⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢺⣏⣿⣿⣿⣿⣿⣿⣷⣶⣶⣾⣿⣇⣀⣠⡞⠀⠀⠀
EOF
}


# prueba 
# ver cual es compatible
CACHYOS_REPO=$(/lib/ld-linux-x86-64.so.2 --help | grep supported | grep -oE "v[34]" | head -n 1 | sed 's/v/x86_64_v/')


repo_cachyos(){
  if [ "$CACHYOS_REPO" == "x86_64_v3"]; then
    clear
    echo "Instalación de cachyos v3"
    echo "--- Configurando CachyOS v3 ---"
    neko_arc
    
    sudo killall pacman 2>/dev/null || true
    sudo rm -f /var/lib/pacman/db.lck
    sudo rm -f /var/cache/pacman/pkg/cachyos*

    sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key F3B607488DB35A47    

    yes | sudo pacman -U --noconfirm \
        'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
        'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-27-1-any.pkg.tar.zst' \
        'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-27-1-any.pkg.tar.zst'

    sudo pacman-key --populate archlinux cachyos

    # Configuración de pacman.conf (Arquitectura y Repos)
    sudo sed -i 's/^#Architecture =.*/Architecture = x86_64 x86_64_v3/' /etc/pacman.conf

    sudo sed -i '/^\[cachyos.*v3\]$/,+1d' /etc/pacman.conf
    sudo sed -i '/^\[cachyos.*\]$/,+1d' /etc/pacman.conf
    sudo sed -i '/^\[core\]$/,+2d' /etc/pacman.conf
    sudo sed -i '/^\[extra\]$/,+2d' /etc/pacman.conf
    sudo sed -i '/^\[multilib\]$/,+2d' /etc/pacman.conf

    # 3. Inyección: Escribir todo el bloque de repositorios al final del archivo
    echo -e "\n[cachyos-v3]\nInclude = /etc/pacman.d/cachyos-v3-mirrorlist\n\n[cachyos-core-v3]\nInclude = /etc/pacman.d/cachyos-v3-mirrorlist\n\n[cachyos-extra-v3]\nInclude = /etc/pacman.d/cachyos-v3-mirrorlist\n\n[cachyos]\nInclude = /etc/pacman.d/cachyos-mirrorlist\n\n[core]\nUsage = Sync Search Install\nInclude = /etc/pacman.d/mirrorlist\n\n[extra]\nUsage = Sync Search Install\nInclude = /etc/pacman.d/mirrorlist\n\n[multilib]\nUsage = Sync Search Install\nInclude = /etc/pacman.d/mirrorlist\n" | sudo tee -a /etc/pacman.conf

    sudo pacman -Syy
  elif [ "$CACHYOS_REPO" == "x86_64_v4"]; then
    clear
    echo "--- Configurando CachyOS v4 ---"
    neko_arc
    
    sudo killall pacman 2>/dev/null || true
    sudo rm -f /var/lib/pacman/db.lck
    sudo rm -f /var/cache/pacman/pkg/cachyos*

    sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
    sudo pacman-key --lsign-key F3B607488DB35A47    

    yes | sudo pacman -U --noconfirm \
        'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
        'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-27-1-any.pkg.tar.zst' \
        'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-27-1-any.pkg.tar.zst'

    sudo pacman-key --populate archlinux cachyos

    # Configuración de pacman.conf (Arquitectura y Repos)
    sudo sed -i 's/^#Architecture =.*/Architecture = x86_64 x86_64_v4/' /etc/pacman.conf

    sudo sed -i '/^\[cachyos.*v4\]$/,+1d' /etc/pacman.conf
    sudo sed -i '/^\[cachyos.*\]$/,+1d' /etc/pacman.conf
    sudo sed -i '/^\[core\]$/,+2d' /etc/pacman.conf
    sudo sed -i '/^\[extra\]$/,+2d' /etc/pacman.conf
    sudo sed -i '/^\[multilib\]$/,+2d' /etc/pacman.conf
    
    echo -e "\n[cachyos-v4]\nInclude = /etc/pacman.d/cachyos-v4-mirrorlist\n\n[cachyos-core-v4]\nInclude = /etc/pacman.d/cachyos-v4-mirrorlist\n\n[cachyos-extra-v4]\nInclude = /etc/pacman.d/cachyos-v4-mirrorlist\n\n[cachyos]\nInclude = /etc/pacman.d/cachyos-mirrorlist\n\n[core]\nUsage = Sync Search Install\nInclude = /etc/pacman.d/mirrorlist\n\n[extra]\nUsage = Sync Search Install\nInclude = /etc/pacman.d/mirrorlist\n\n[multilib]\nUsage = Sync Search Install\nInclude = /etc/pacman.d/mirrorlist\n" | sudo tee -a /etc/pacman.conf

    sudo pacman -Syy

  else 
    echo "No tiene compatibilidad para cachyos"
  fi
}

packeges_cachyos(){
  clear
  echo "Instalando paquetes de cachyos"
  neko_arc
  sudo pacman -S --noconfirm --needed \
  linux-cachyos linux-cachyos-headers \
  plasma-foreground-booster dmemcg-booster \
  heroic-games-launcher-bin zen-browser-bin

}

shell_fish(){
  clear
  echo "Instalando de shell en la terminal"
  neko_arc
  sudo pacman -S --noconfirm --needed fish
  chsh -s /usr/bin/fish
}

config_pacman(){
  clear
  echo "Configurando pacman"
  neko_arc
  sudo sed -i '/#Color/a ILoveCandy' /etc/pacman.conf
}

config_base(){
  clear
  echo "instalación de red y complementos"
  neko_arc
  sudo pacman -S --noconfirm --needed \
  networkmanager dnsmasq wget curl reflector

  sudo systemctl enable NetworkManager
  sudo systemctl start NetworkManager
}

packeges_intel_arc(){
  clear
  echo "instalación de paquetes para intel arc"
  neko_arc
  sudo pacman -Syu

  sudo pacman -S --needed \
  mesa lib32-mesa \
  vulkan-intel lib32-vulkan-intel \
  vulkan-icd-loader lib32-vulkan-icd-loader \
  vulkan-validation-layers \
  intel-media-driver \
  libva libva-utils \
  vpl-gpu-rt libvpl \
  intel-compute-runtime \
  level-zero-loader level-zero-headers \
  ocl-icd lib32-ocl-icd \
  intel-gmmlib \
  intel-gpu-tools \
  vulkan-tools \
  mesa-utils \
  clinfo \
  linux-firmware-intel \
  fwupd \
  libvdpau-va-gl

  # Ver si con eso funciona normal las intel arc
  # libva-intel-driver
  # lib32-libva-intel-driver 
}

packeges_multimedia(){
  clear
  echo "Paquetes de multimedia"
  neko_arc
  sudo pacman -S --noconfirm --needed ffmpeg gstreamer gst-libav gst-plugins-good \
  gst-plugins-bad gst-plugins-ugly gst-plugins-base aom dav1d rav1e svt-av1 x264 x265 
}

packeges_xwayland(){
  clear
  echo "paquetes para xwayland" 
  neko_arc
  sudo pacman -S --noconfirm --needed \
  xorg-xwayland xorg-xeyes xorg-xlsclients
}

packeges_kde(){
  clear
  echo "paquetes para kde"
  neko_arc
  sudo pacman -S --noconfirm --needed \
  plasma-desktop plasma-nm plasma-pa kscreen kde-gtk-config breeze breeze-gtk \
  breeze-icons gnome-themes-extra kwallet-pam spectacle filelight partitionmanager 
}

packeges_personalized(){
  clear
  echo "paquetes personalizados hechi por mí"
  neko_arc
  sudo pacman -S --noconfirm --needed \
  base-devel git less vlc-plugins-all vlc obs-studio gwenview ffmpegthumbs \
  scrcpy android-tools kdeconnect ark unrar zip unzip xclip xsel lact mangohud \
  lib32-mangohud gamemode gamescope steam noto-fonts-cjk goverlay krita python-pyqt6 fastfetch \
  prismlauncher ntfs-3g gparted drawio-desktop opentoonz libresprite alsa-scarlett-gui \
  easyeffects reaper neovim obsidian thunderbird podman podman-compose docker docker-compose \
  podman-desktop btop nvtop musescore lsp-plugins-lv2 lsp-plugins-vst3 ncdu
}

packeges_nvchad(){
  clear
  echo "Instalando nvchad"
  neko_arc
  git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
}

packeges_flatpak(){
  clear
  echo "Instalando flatpak"
  neko_arc
  sudo pacman -S --noconfirm --needed flatpak

  echo "Instalando aplicaciones de flatpak"
  flatpak install --noninteractive --assumeyes \
  com.github.tchx84.Flatseal \
  com.github.unrud.VideoDownloader \
  com.vysp3r.ProtonPlus \
  it.mijorus.gearlever \
  org.strawberrymusicplayer.strawberry \
  org.onlyoffice.desktopeditors \
  net.pcsx2.PCSX2 \
  flathub net.rpcs3.RPCS3 \
  net.shadps4.shadPS4 

}

packeges_dualboot(){
  clear
  echo "Instalando paquetes para dualboot"
  neko_arc
  sudo pacman -S --noconfirm --needed os-prober ntfs-3g

  echo "Va al directorio "sudo vim /etc/default/grub" y cambia la linea GRUB_DISABLE_OS_PROBER=true por GRUB_DISABLE_OS_PROBER=false"
  echo ""
  echo "recarga con "sudo os-prober""
  echo ""
  echo "ver donde esta el instalación de windows "sudo grub-mkconfig -o /boot/grub/grub.cfg""
  echo ""
  echo "ver la ruta de windows para que inicie automatico:  grep "menuentry " /boot/grub/grub.cfg " 
  echo "edita el archivo: sudo vim /etc/default/grub  - y cambia la linea GRUB_DEFAULT=0 por GRUB_DEFAULT='Windows 11 (loader) (on /dev/sda1)'"
  echo "Recarga para aplicar los cambios: sudo grub-mkconfig -o /boot/grub/grub.cfg"  
}

clear
neko_arc
echo "¿Cómo desea realizar la instalación?"
echo "1) Automática (Instala todo por defecto)"
echo "2) Manual (Elegir qué componentes instalar)"
read -p "Seleccione una opción [1-2]: " modo_inst

if [ "$modo_inst" == "1" ]; then
    echo "Iniciando instalación automática..."
    repo_cachyos
    packeges_cachyos
    config_pacman
    config_base
    packeges_intel_arc
    packeges_multimedia
    packeges_xwayland
    packeges_kde
    packeges_personalized
    packeges_flatpak
    shell_fish
    packeges_dualboot
    echo "Instalación automática completada."

elif [ "$modo_inst" == "2" ]; then
    echo "Iniciando modo manual..."
    
    OPCIONES=$(gum choose --no-limit \
        "repo cachyos" \
        "Paquetes CachyOS" \
        "Pacman ILoveCandy" \
        "Base (NetworkManager)" \
        "Drivers Intel Arc" \
        "Multimedia" \
        "XWayland" \
        "KDE Plasma" \
        "Paquetes personalizados" \
        "Flatpaks" \
        "NvChad" \
        "Fish shell" \
        "Dualboot Windows")

    if [[ -z "$OPCIONES" ]]; then
        echo "No se seleccionó ninguna opción. Saliendo."
        exit 1
    fi

    echo "Elegiste: $OPCIONES"
    echo ""

    [[ "$OPCIONES" == *"Repo Cachyos"* ]] && repo_cachyos
    [[ "$OPCIONES" == *"Paquetes CachyOS"* ]] && packeges_cachyos
    [[ "$OPCIONES" == *"Pacman ILoveCandy"* ]] && config_pacman
    [[ "$OPCIONES" == *"Base (NetworkManager)"* ]] && config_base
    [[ "$OPCIONES" == *"Drivers Intel Arc"* ]] && packeges_intel_arc
    [[ "$OPCIONES" == *"Multimedia"* ]] && packeges_multimedia
    [[ "$OPCIONES" == *"XWayland"* ]] && packeges_xwayland
    [[ "$OPCIONES" == *"KDE Plasma"* ]] && packeges_kde
    [[ "$OPCIONES" == *"Paquetes personalizados"* ]] && packeges_personalized
    [[ "$OPCIONES" == *"Flatpaks"* ]] && packeges_flatpak
    [[ "$OPCIONES" == *"NvChad"* ]] && packeges_nvchad
    [[ "$OPCIONES" == *"Fish shell"* ]] && shell_fish
    [[ "$OPCIONES" == *"Dualboot Windows"* ]] && packeges_dualboot

    echo "Instalación manual completada."

else
    echo "Opción no válida. Saliendo."
    exit 1
fi
