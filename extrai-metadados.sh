#!/bin/bash

# ============================================================
#  EXTRATOR DE METADADOS DE DOCUMENTOS
#  Uso: ./extrai_metadados.sh https://exemplo.com
# ============================================================

URL="$1"
PASTA_TEMP="/tmp/meta_docs"
SAIDA="metadados_$(date +%Y%m%d_%H%M%S).txt"

EXTENSOES="pdf|docx|xlsx|pptx|doc|xls|ppt|odt|ods|odp|rtf|csv"

if [ -z "$URL" ]; then
    echo "Uso: $0 <URL>"
    echo "Exemplo: $0 https://exemplo.com"
    exit 1
fi

if ! command -v exiftool &> /dev/null; then
    echo "[ERRO] exiftool não encontrado."
    exit 1
fi

if ! command -v curl &> /dev/null; then
    echo "[ERRO] curl não encontrado. Instale com: sudo apt install curl"
    exit 1
fi

mkdir -p "$PASTA_TEMP"
> "$SAIDA"

separador() {
    echo "================================================" >> "$SAIDA"
}

cabecalho() {
    separador
    echo "  RELATÓRIO DE METADADOS — DOCUMENTOS"          >> "$SAIDA"
    echo "  Alvo  : $URL"                                  >> "$SAIDA"
    echo "  Data  : $(date '+%d/%m/%Y %H:%M:%S')"         >> "$SAIDA"
    separador
    echo ""                                                >> "$SAIDA"
}

analisar_arquivo() {
    local ARQUIVO="$1"
    local URL_ORIGEM="$2"

    echo "[*] Analisando: $(basename "$ARQUIVO")"

    separador                                              >> "$SAIDA"
    echo "ARQUIVO  : $(basename "$ARQUIVO")"               >> "$SAIDA"
    echo "URL      : $URL_ORIGEM"                          >> "$SAIDA"
    echo "TAMANHO  : $(du -h "$ARQUIVO" | cut -f1)"        >> "$SAIDA"
    echo ""                                                >> "$SAIDA"

    echo "--- METADADOS ---"                               >> "$SAIDA"
    exiftool \
        -Title \
        -Author \
        -Creator \
        -Producer \
        -Company \
        -LastModifiedBy \
        -CreateDate \
        -ModifyDate \
        -Software \
        -Description \
        -Keywords \
        -Subject \
        -PageCount \
        -WordCount \
        -LineCount \
        -ParagraphCount \
        "$ARQUIVO" 2>&1                                    >> "$SAIDA"

    echo ""                                                >> "$SAIDA"
    echo "--- TODOS OS CAMPOS BRUTOS (exiftool completo) ---" >> "$SAIDA"
    exiftool "$ARQUIVO" 2>&1                               >> "$SAIDA"
    echo ""                                                >> "$SAIDA"
}

cabecalho

echo "[*] Buscando documentos em: $URL"

LINKS=$(curl -s "$URL" \
    | grep -oiE 'href="[^"]*\.('$EXTENSOES')(\?[^"]*)?"' \
    | sed 's/href="//I; s/"//')

if [ -z "$LINKS" ]; then
    echo "[!] Nenhum documento encontrado na página."
    echo "Nenhum documento encontrado na página." >> "$SAIDA"
    exit 0
fi

CONTADOR=0

while IFS= read -r LINK; do

    if [[ "$LINK" != http* ]]; then
        LINK="${URL%/}/$LINK"
    fi

    NOME_ARQUIVO=$(basename "$LINK" | cut -d'?' -f1)
    DESTINO="$PASTA_TEMP/$NOME_ARQUIVO"

    echo "[*] Baixando: $LINK"

    if wget -q --timeout=20 -O "$DESTINO" "$LINK"; then
        CONTADOR=$((CONTADOR + 1))
        analisar_arquivo "$DESTINO" "$LINK"
    else
        echo "[!] Falhou: $LINK"
        echo "FALHA AO BAIXAR: $LINK" >> "$SAIDA"
        echo "" >> "$SAIDA"
    fi

done <<< "$LINKS"

separador >> "$SAIDA"
echo "  TOTAL DE DOCUMENTOS ANALISADOS: $CONTADOR"       >> "$SAIDA"
separador >> "$SAIDA"

echo ""
echo "[✓] Pronto! $CONTADOR documento(s) analisado(s)."
echo "[✓] Relatório: $SAIDA"

rm -rf "$PASTA_TEMP"
