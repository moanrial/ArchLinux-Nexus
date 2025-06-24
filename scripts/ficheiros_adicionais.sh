ficheiros_adicionais() {
log_section "A instalar ficheiros adicionais externos (droidCam, autenticação-gov, VS Code)"

if ! confirmar; then
info "Instalação cancelada pelo utilizador."
return
fi

mkdir -p "$TMP_DIR"
mkdir -p "/lib/firmware/brcm"

# Transferência de ficheiros extra
info "A transferir ficheiros extra."

ficheiros=(
"https://raw.githubusercontent.com/winterheart/broadcom-bt-firmware/refs/heads/master/brcm/BCM20702A1-0b05-17cb.hcd"
)

for url in "${ficheiros[@]}"; do
destino="$TMP_DIR/$(basename "$url")"

if [[ -f "$destino" ]]; then
    info "Já existe: $(basename "$url") — a ignorar transferência."
    continue
fi

loading "→ A transferir $(basename "$url")"

if ! wget -q -O "$destino" "$url"; then
    erro "Erro ao transferir $url"
    return 1
fi

sleep 1.5
done

sucesso "Ficheiros extra transferidos com sucesso."
sleep 1.5

# A instalar drivers bluetooth em falta.

sudo cp "$TMP_DIR/BCM20702A1-0b05-17cb.hcd" "/lib/firmware/brcm/"

sucesso "Ficheiros adicionais instalados com sucesso."
sleep 1.5
}