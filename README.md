# Extrator de Metadados de Documentos

Script em Shell Script para Kali Linux que varre um site, baixa automaticamente todos os documentos encontrados e extrai seus metadados, salvando tudo em um relatório `.txt`.

---

## Sobre o projeto

Durante testes de segurança (pentest) ou análises OSINT, documentos públicos em sites podem conter metadados sensíveis — como nomes de usuários internos, versões de software, caminhos de rede, nomes de empresas e datas de criação. Este script automatiza essa coleta.

---

## Funcionalidades

- Varre o HTML de uma URL em busca de links para documentos
- Suporte a: `PDF`, `DOCX`, `XLSX`, `PPTX`, `DOC`, `XLS`, `PPT`, `ODT`, `ODS`, `ODP`, `RTF`, `CSV`
- Baixa cada arquivo automaticamente via `wget`
- Extrai os metadados imediatamente após o download (sem esperar todos os arquivos)
- Salva tudo em um relatório `.txt` com timestamp no nome
- Exibe campos filtrados (autor, empresa, datas, software) + dump completo do `exiftool`
- Limpa os arquivos temporários ao final

---

## Dependências

| Ferramenta | Função |
|---|---|
| `curl` | Baixar o HTML da página para buscar os links |
| `wget` | Baixar os arquivos encontrados |
| `exiftool` | Extrair os metadados dos documentos |

### Instalação das dependências

```bash
sudo apt update
sudo apt install curl wget exiftool -y
```

---

## Como usar

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/extrator-metadados.git
cd extrator-metadados
```

### 2. Dê permissão de execução

```bash
chmod +x extrai_metadados.sh
```

### 3. Execute passando a URL do alvo

```bash
./extrai_metadados.sh https://site-alvo.com
```

### 4. Acompanhe o relatório sendo gerado em tempo real (opcional)

```bash
# Em um segundo terminal:
tail -f metadados_*.txt
```

---

## Exemplo de saída

```
================================================
  RELATORIO DE METADADOS - DOCUMENTOS
  Alvo  : https://exemplo.com
  Data  : 04/04/2026 14:30:22
================================================

================================================
ARQUIVO  : relatorio_anual.pdf
URL      : https://exemplo.com/docs/relatorio_anual.pdf
TAMANHO  : 2.4M

--- METADADOS ---
Title          : Relatorio Anual 2025
Author         : Joao Silva
Creator        : Microsoft Word
Company        : Empresa Exemplo Ltda
CreateDate     : 2025:03:10 09:14:32
ModifyDate     : 2025:03:15 17:45:01
LastModifiedBy : Maria Souza
Software       : Microsoft Office Word 2019
PageCount      : 48
...
================================================
  TOTAL DE DOCUMENTOS ANALISADOS: 7
================================================
```

---

## Metadados coletados

| Campo | O que pode revelar |
|---|---|
| `Author / Creator` | Nome do usuário que criou o arquivo |
| `Company` | Nome da empresa configurada no Office |
| `LastModifiedBy` | Último usuário que editou o documento |
| `CreateDate / ModifyDate` | Datas de criação e modificação |
| `Software / Producer` | Versão do software usado (Word, LibreOffice, Adobe...) |
| `PageCount / WordCount` | Tamanho do documento |
| `Keywords / Subject` | Tags internas definidas no documento |

---

## Aviso Legal

Este script é destinado exclusivamente a fins educacionais e de testes de segurança autorizados. Utilize apenas em sistemas e sites para os quais você possui permissão explícita. O uso indevido desta ferramenta pode violar leis locais e internacionais. O autor não se responsabiliza por qualquer uso inadequado.

---

## Estrutura do projeto

```
extrator-metadados/
├── extrai_metadados.sh   # Script principal
└── README.md             # Documentação
```

---

## Contribuindo

Pull requests são bem-vindos. Para mudanças maiores, abra uma issue primeiro para discutirmos o que você gostaria de modificar.

---

## Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

--------------------------------------------------------------------

# Document Metadata Extractor

A Shell Script tool for Kali Linux that crawls a target website, automatically downloads all found documents, and extracts their metadata — saving everything into a `.txt` report.

---

## About

During penetration testing or OSINT analysis, publicly available documents on websites can expose sensitive metadata — such as internal usernames, software versions, network paths, company names, and creation dates. This script automates that collection process.

---

## Features

- Crawls a URL's HTML to find document links
- Supports: `PDF`, `DOCX`, `XLSX`, `PPTX`, `DOC`, `XLS`, `PPT`, `ODT`, `ODS`, `ODP`, `RTF`, `CSV`
- Automatically downloads each file via `wget`
- Extracts metadata immediately after each download (no waiting for all files)
- Saves everything to a timestamped `.txt` report
- Displays filtered fields (author, company, dates, software) + full `exiftool` raw dump
- Cleans up temporary files after execution

---

## Dependencies

| Tool | Purpose |
|---|---|
| `curl` | Fetch the page HTML to find document links |
| `wget` | Download the found files |
| `exiftool` | Extract metadata from the documents |

### Installing dependencies

```bash
sudo apt update
sudo apt install curl wget exiftool -y
```

---

## Usage

### 1. Clone the repository

```bash
git clone https://github.com/your-username/document-metadata-extractor.git
cd document-metadata-extractor
```

### 2. Make the script executable

```bash
chmod +x extrai_metadados.sh
```

### 3. Run it against a target URL

```bash
./extrai_metadados.sh https://target-site.com
```

### 4. Watch the report being written in real time (optional)

```bash
# In a second terminal:
tail -f metadados_*.txt
```

---

## Output example

```
================================================
  METADATA REPORT - DOCUMENTS
  Target : https://example.com
  Date   : 04/04/2026 14:30:22
================================================

================================================
FILE     : annual_report.pdf
URL      : https://example.com/docs/annual_report.pdf
SIZE     : 2.4M

--- METADATA ---
Title          : Annual Report 2025
Author         : John Smith
Creator        : Microsoft Word
Company        : Example Corp
CreateDate     : 2025:03:10 09:14:32
ModifyDate     : 2025:03:15 17:45:01
LastModifiedBy : Jane Doe
Software       : Microsoft Office Word 2019
PageCount      : 48
...
================================================
  TOTAL DOCUMENTS ANALYZED: 7
================================================
```

---

## Collected metadata fields

| Field | What it may reveal |
|---|---|
| `Author / Creator` | Name of the user who created the file |
| `Company` | Company name configured in the Office installation |
| `LastModifiedBy` | Last user who edited the document |
| `CreateDate / ModifyDate` | File creation and modification timestamps |
| `Software / Producer` | Software version used (Word, LibreOffice, Adobe...) |
| `PageCount / WordCount` | Document size indicators |
| `Keywords / Subject` | Internal tags defined inside the document |

---

## Legal Disclaimer

This script is intended solely for educational purposes and authorized security testing. Only use it on systems and websites for which you have explicit permission. Unauthorized use of this tool may violate local and international laws. The author is not responsible for any misuse.

---

## Project structure

```
document-metadata-extractor/
├── extrai_metadados.sh   # Main script
└── README.md             # Documentation
```

---

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---

## License

Distributed under the MIT License. See `LICENSE` for more information.
