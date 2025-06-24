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

info "[1/2] A remover dependências órfãs..."
mapfile -t orphans < <(pacman -Qdtq)
if [[ ${#orphans[@]} -gt 0 ]]; then
sudo pacman -Rns --noconfirm "${orphans[@]}"
else
info "Nenhum pacote órfão encontrado."
fi

info "[2/2] A limpar cache de pacotes antigos..."

# Verificar se o comando paccache existe
if ! command -v paccache >/dev/null 2>&1; then
info "O comando 'paccache' não foi encontrado. A instalar 'pacman-contrib'..."
sudo pacman -S --noconfirm pacman-contrib
fi

# Executar a limpeza com segurança (manter 2 versões)
sudo paccache -r -k2

info "A ordenar mirrors por velocidade"
rankmirrors

sucesso "Sistema atualizado e limpo com sucesso."
sleep 1.5
}