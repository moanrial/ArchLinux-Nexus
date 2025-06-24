# instalar_pacotes.sh - Instalação de pacotes principais do utilizador

instalar_pacotes() {
log_section "A instalar pacotes principais do utilizador"

if ! confirmar; then
info "Instalação cancelada pelo utilizador."
return
fi

info "A ativar o repositorio [Multilib]"

# Faz backup do arquivo original
sudo cp /etc/pacman.conf /etc/pacman.conf.bak

# Ativa o repositório multilib
sudo sed -i '/^\[multilib\]/,/^Include/ s/^#//' /etc/pacman.conf

# Atualiza a base de dados dos pacotes
sudo pacman -Sy

info "Repositório [multilib] ativado com sucesso."

if command -v yay &> /dev/null; then
sucesso "YAY já está instalado."
else
info "A instalar YAY"
sudo pacman -S --needed --noconfirm base-devel git

git clone https://aur.archlinux.org/yay.git
cd yay || exit 1
makepkg -si --noconfirm
cd ..
sudo rm -r yay

sucesso "Instalação concluída."
fi

info "[1/2] A instalar pacotes dos repositorios Core,Extra,Multilib."

pacotes=(
# Interface gráfica de inicio de sessão
gdm
# GNOME
gnome
gnome-tweaks
wget
xdg-utils
# Controlador gráfico
mesa
vulkan-radeon
# Pacotes Custom
linux
linux-headers
amd-ucode
linux-firmware-amdgpu
winetricks
lutris
thunderbird
thunderbird-i18n-pt-pt
gnome-boxes
deja-dup
steam
vlc
qbittorrent
gimp
gimp-help-pt
gamemode
gufw
gnome-shell-extension-appindicator
gnome-shell-extension-caffeine
gnome-shell-extension-vitals
seahorse
gnome-tweaks
mangohud
libreoffice-fresh
libreoffice-fresh-pt
fastfetch
code
jdk-openjdk
flatpak
)

# Pacotes normais

for pacote in "${pacotes[@]}"; do
if ! pacman -Qi "$pacote" > /dev/null 2>&1; then
info "A instalar: $pacote"
sudo pacman -S --noconfirm "$pacote"
else
info "$pacote já está instalado!"
fi
done

# AUR

info "[2/2] A instalar pacotes AUR."

pacotesAUR=(
gnome-shell-extension-gsconnect
gnome-shell-extension-dash-to-dock
gnome-shell-extension-gamemode-git
droidcam
autenticacao-gov-pt
plugin-autenticacao-gov-pt
)

for pacote in "${pacotesAUR[@]}"; do
if ! yay -Qi "$pacote" > /dev/null 2>&1; then
info "A instalar: $pacote"
yay -S --noconfirm "$pacote"
else
info "$pacote já está instalado!"
fi
done

sucesso "Finalizado."
sleep 1.5
}

#PACOTES FEDORA QUE NAO EXISTEM NO ARCH
#steam-devices.noarch
#gnome-extensions-app.x86_64
#gnome-feeds.noarch
#gnome-shell-extension-user-theme.noarch
#libreoffice-help-pt-PT.x86_64
#libreoffice-langpack-pt-PT.x86_64