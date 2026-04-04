# 🔍 MetaDocs Extractor

Script em **Shell Script** para Kali Linux que varre um site, baixa automaticamente todos os documentos encontrados e extrai seus metadados, salvando tudo em um relatório `.txt`.

---

## 📋 Sobre o projeto

Durante testes de segurança (pentest) ou análises OSINT, documentos públicos em sites podem conter metadados sensíveis — como nomes de usuários internos, versões de software, caminhos de rede, nomes de empresas e datas de criação. Este script automatiza essa coleta.

---

## ⚙️ Funcionalidades

- Varre o HTML de uma URL em busca de links para documentos
- Suporte a: `PDF`, `DOCX`, `XLSX`, `PPTX`, `DOC`, `XLS`, `PPT`, `ODT`, `ODS`, `ODP`, `RTF`, `CSV`
- Baixa cada arquivo automaticamente via `wget`
- Extrai os metadados imediatamente após o download (sem esperar todos os arquivos)
- Salva tudo em um relatório `.txt` com timestamp no nome
- Exibe campos filtrados (autor, empresa, datas, software) + dump completo do `exiftool`
- Limpa os arquivos temporários ao final

---

## 🛠️ Dependências

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

## 🚀 Como usar

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/metadocs-extractor.git
cd metadocs-extractor
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

## 📄 Exemplo de saída

```
================================================
  RELATÓRIO DE METADADOS — DOCUMENTOS
  Alvo  : https://exemplo.com
  Data  : 04/04/2026 14:30:22
================================================

================================================
ARQUIVO  : relatorio_anual.pdf
URL      : https://exemplo.com/docs/relatorio_anual.pdf
TAMANHO  : 2.4M

--- METADADOS ---
Title          : Relatório Anual 2025
Author         : João Silva
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

## 🔎 Metadados coletados

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

## ⚠️ Aviso Legal

Este script é destinado exclusivamente a fins educacionais e de testes de segurança autorizados. Só utilize em sistemas e sites para os quais você tem permissão explícita. O uso indevido desta ferramenta pode violar leis locais e internacionais. O autor não se responsabiliza por qualquer uso inadequado.

---

## 📁 Estrutura do projeto

```
metadocs-extractor/
├── extrai_metadados.sh   # Script principal
└── README.md             # Documentação
```

---

## 🤝 Contribuindo

Pull requests são bem-vindos! Para mudanças maiores, abra uma issue primeiro para discutirmos o que você gostaria de modificar.

---

## 📜 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.
