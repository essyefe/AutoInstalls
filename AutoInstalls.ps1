<#
  Script PS1 para atualizar/instalar pacotes via winget
  Salve como UTF-8 with BOM
#>

Write-Host "Atualizando fontes..." -ForegroundColor Cyan
# 'winget source update' não suporta -ErrorAction
$null = winget source update --nowarn

# Flags comuns
$acceptFlags = @(
  "--accept-source-agreements",
  "--accept-package-agreements",
  "--silent"
)

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

  # Verifica instalação
  & winget list --source winget --id $pkg -e > $null 2>&1
  $isInstalled = $LASTEXITCODE -eq 0

  if ($isInstalled) {
    Write-Host "Tentando atualizar $pkg..." -ForegroundColor Cyan
    & winget upgrade --source winget --id $pkg -e @acceptFlags > $null 2>&1
    $code = $LASTEXITCODE

    if ($code -eq 0) {
      Write-Host "$pkg atualizado com sucesso." -ForegroundColor Green
      continue
    }
    elseif ($code -eq -1978335189) {
      Write-Host "Nenhuma atualização disponível para $pkg." -ForegroundColor Yellow
      continue
    }
    else {
      Write-Host "Erro ao atualizar $pkg (code $code)." -ForegroundColor Red
      continue
    }
  }

  Write-Host "Tentando instalar $pkg via winget..." -ForegroundColor Cyan
  & winget install --source winget --id $pkg -e @acceptFlags > $null 2>&1
  if ($LASTEXITCODE -eq 0) {
    Write-Host "$pkg instalado com sucesso." -ForegroundColor Green
    continue
  }

  Write-Host "Fallback: msstore..." -ForegroundColor Magenta
  & winget install --source msstore --id $pkg -e @acceptFlags > $null 2>&1
  if ($LASTEXITCODE -eq 0) {
    Write-Host "$pkg instalado via msstore." -ForegroundColor Green
  }
  else {
    Write-Host "Falha ao instalar $pkg em ambas as fontes." -ForegroundColor Red
  }
}

Write-Host "`nTodos os pacotes processados." -ForegroundColor Yellow
Read-Host "Pressione ENTER para sair"
