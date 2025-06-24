# atualizar_sistema.sh - Atualização do sistema e limpeza de pacotes antigos

atualizar_sistema() {
log_section "Atualização e manutenção do sistema."

if ! confirmar; then
info "Atualização cancelada pelo utilizador."
return
fi

info "A atualizar o sistema..."
sudo pacman -Syu --noconfirm

info "A remover pacotes órfãos (desnecessários)..."

# Capturar órfãos
orfãos=$(pacman -Qdtq)
if [[ -n "$orfãos" ]]; then
sudo pacman -Rdd --noconfirm $orfãos
else
info "Nenhum pacote órfão encontrado para remoção."
fi

sucesso "Sistema atualizado e limpo com sucesso."
sleep 1.5
}