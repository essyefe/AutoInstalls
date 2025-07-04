@echo off
setlocal enabledelayedexpansion

REM ------------------------- LISTA DE PACOTES --------------------------
set PACKAGES=^
Microsoft.VisualStudioCode ^
Git.Git ^
GitHub.cli ^
OpenJS.NodeJS ^
Oracle.JDK.21 ^
Oracle.MySQL ^
Python.Python.3.9 ^
TablePlus.TablePlus ^
Docker.DockerDesktop ^
Mobatek.MobaXterm ^
Google.AndroidStudio ^
Obsidian.Obsidian ^
Figma.Figma ^
Insomnia.Insomnia ^
Mozilla.Firefox ^
OBSProject.OBSStudio ^
Chocolatey.Chocolatey ^
WiresharkFoundation.Wireshark ^
Insecure.Nmap

REM ---------------------- INÍCIO DA EXECUÇÃO --------------------------
echo Iniciando verificação e instalação de pacotes...

for %%P in (%PACKAGES%) do (
    echo.
    echo ================================================
    echo Verificando se "%%P" está instalado...
    
    REM verifica existência do pacote
    winget list --id "%%P" >nul 2>&1

    if errorlevel 1 (
        echo Pacote "%%P" não encontrado. Iniciando instalação...
        
        REM instala em modo silencioso, mas mantendo barra de progresso
        winget install --id "%%P" ^
            --silent ^
            --accept-package-agreements ^
            --accept-source-agreements

        REM captura resultado da instalação
        if errorlevel 1 (
            echo Erro ao instalar "%%P".
        ) else (
            echo "%%P" instalado com sucesso.
        )
    ) else (
        echo Pacote "%%P" já está instalado. Pulando...
    )
)

echo.
echo Todos os pacotes processados.
endlocal
