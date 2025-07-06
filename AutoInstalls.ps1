<#
  Script PS1 para atualizar/instalar pacotes via winget
  Salve como UTF-8 with BOM
#>

# Exibe mensagem antes de atualizar as fontes
Write-Host "Atualizando fontes..." -ForegroundColor Cyan

# Atualia a lista de fontes do winget (descarta saída de erros)
$null = winget source update --nowarn

# Define flags que serão passadas a todos os comandos de install/upgrade
$acceptFlags = @(
  "--accept-source-agreements",   # Aceita automaticamente termos das fontes
  "--accept-package-agreements",  # Aceita acordos de licença dos pacotes
  "--silent"                      # Executa sem prompts interativos
)

# Lista de pacotes (IDs no repositório winget)
$packages = @(
  'Microsoft.VisualStudioCode',
  'Git.Git',
  'OpenJS.NodeJS',
  'Oracle.JDK.21',
  'Oracle.MySQL',
  'Python.Python.3.9',
  'Docker.DockerDesktop',
  'Mobatek.MobaXterm',
  'Google.AndroidStudio',
  'Obsidian.Obsidian',
  'Insomnia.Insomnia',
  'Mozilla.Firefox',
  'OBSProject.OBSStudio',
  'Chocolatey.Chocolatey'
)

foreach ($pkg in $packages) {
  Write-Host "`nProcessando $pkg..." -ForegroundColor Cyan

  # Checa instalação atual ( exit code 0 = instalado )
  & winget list --source winget --id $pkg -e > $null 2>&1
  $isInstalled = $LASTEXITCODE -eq 0

  if ($isInstalled) {
    # Se instalado tenta atualizar
    Write-Host "Tentando atualizar $pkg..." -ForegroundColor Cyan
    & winget upgrade --source winget --id $pkg -e @acceptFlags > $null 2>&1
    $code = $LASTEXITCODE

    if ($code -eq 0) {
      Write-Host "$pkg atualizado com sucesso." -ForegroundColor Green
      continue
    }
    elseif ($code -eq -1978335189) {
      # Código específico que indica "nenhuma atualização disponível"
      Write-Host "Nenhuma atualização disponível para $pkg." -ForegroundColor Yellow
      continue
    }
    else {
      Write-Host "Erro ao atualizar $pkg (code $code)." -ForegroundColor Red
      continue
    }
  }

  # Se não estiver instalado instala via winget
  Write-Host "Tentando instalar $pkg via winget..." -ForegroundColor Cyan
  & winget install --source winget --id $pkg -e @acceptFlags > $null 2>&1

  if ($LASTEXITCODE -eq 0) {
    Write-Host "$pkg instalado com sucesso." -ForegroundColor Green
    continue
  }

  # Fallback para Microsoft Store em caso de falha
  Write-Host "Fallback: msstore..." -ForegroundColor Magenta
  & winget install --source msstore --id $pkg -e @acceptFlags > $null 2>&1
  if ($LASTEXITCODE -eq 0) {
    Write-Host "$pkg instalado via msstore." -ForegroundColor Green
  }
  else {
    Write-Host "Falha ao instalar $pkg em ambas as fontes." -ForegroundColor Red
  }
}

# Mensagem final e pausa para o usuário
Write-Host "`nTodos os pacotes processados." -ForegroundColor Yellow
Read-Host "Pressione ENTER para sair"
