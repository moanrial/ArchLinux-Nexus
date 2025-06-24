# instalar_pacotes.sh - Instalação de pacotes principais do utilizador

instalar_pacotes() {
log_section "A instalar pacotes principais do utilizador"

if ! confirmar; then
info "Instalação cancelada pelo utilizador."
return
fi

info "A ativar o repositorio [MULTILIB]"

# Faz backup do arquivo original
cp /etc/pacman.conf /etc/pacman.conf.bak

# Ativa o repositório multilib
sed -i '/^\[multilib\]/,/^Include/ s/^#//' /etc/pacman.conf

# Atualiza a base de dados dos pacotes
pacman -Sy

info "Repositório [multilib] ativado com sucesso."

pacotes=(
#ARCHLINUX
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
flatpak
)

#PACOTES FEDORA QUE NAO EXISTEM NO ARCH
#steam-devices.noarch
#gnome-extensions-app.x86_64
#gnome-feeds.noarch
#gnome-shell-extension-gsconnect.x86_64
#gnome-shell-extension-dash-to-dock.noarch
#gnome-shell-extension-gamemode.noarch
#gnome-shell-extension-user-theme.noarch
#libreoffice-help-pt-PT.x86_64
#libreoffice-langpack-pt-PT.x86_64

for pacote in "${pacotes[@]}"; do
if ! pacman -Qi "$pacote" > /dev/null 2>&1; then
  info "A instalar: $pacote"
  sudo pacman -S --noconfirm "$pacote"
else
  info "$pacote já está instalado!"
fi
done

sucesso "Finalizado."
sleep 1.5
}