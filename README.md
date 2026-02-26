# AutoInstalls

Automação para instalar e atualizar uma lista de aplicações no Windows usando o winget e, em caso de falha, o Microsoft Store. Inclui um wrapper em batch que solicita elevação de privilégios e executa o script PowerShell principal.

## Tecnologias

- Batchfile
- PowerShell

## Pré-requisitos
- Windows 10 ou superior
- Winget instalado e disponível no path
- Permissões de administrador ( o batch solicita elevação automaticamente )
- Powershell 5.1 ou superior com política de execução que permita scripts ( RemoteSigned ou Bypass )

## Instalação
- Clone ou baixe esse repositório.
- Salve todos os arquivos com codificação UTF-8 with BOM.
- Execute o arquivo run_installs.bat para iniciar o processo.

> [!TIP]
> Também é possível executar AutoInstalls.ps1 diretamente do terminal powershell, mas requer permissões de administrador.

## Configuração
Para adicionar ou remover pacotes, edite o array $packages dentro de AutoInstalls.ps1. Cada entrada deve corresponder ao ID do pacote registrado no repositório winget ou Microsoft Store.

> [!IMPORTANT]  
> Sempre verifique se os IDs dos pacotes estão corretos ao adicionar novos pacotes no array $packages.

## Lista de pacotes

ID do pacote | Descrição |
|------------|----------:|
Oracle.JDK.21 | Java Development Kit
OpenJS.NodeJS | Ambiente de execução Node.js
Python.Python.3.9 | Python
GoLang.Go | Go
Microsoft.VisualStudioCode | Visual Studio Code
Git.Git | Git
Oracle.MySQL | MySQL
Docker.DockerDesktop | Docker Desktop
Mobatek.MobaXterm | Cliente SSH e X11 para Windows
Google.AndroidStudio | IDE de Desenvolvimento Android
Obsidian.Obsidian | Editor Markdown e gestão de notas
Insomnia.Insomnia | Cliente HTTP e REST API
Mozilla.Firefox | Navegador Firefox
ObsProject.OBSStudio | Software de gravação e streaming
Chocolatey | Gerenciador de pacotes chocolatey

## Arquivos e Diretórios

Nome | Função |
|----|-------:|
AutoInstalls.ps1 | Script principal
run_installs.bat | Script que chama AutoInstalls.ps1 com privilégios de administrador
README.md | Documentação do projeto

## Licença

Este projeto está licenciado sob a licença MIT.
