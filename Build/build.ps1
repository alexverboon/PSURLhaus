# ----------------------------------------------------------
# Module Build and publishing
# v1.0, 22.03.2020
# Alex Verboon
# ----------------------------------------------------------

# Module Source
$ParentFolder = [IO.Directory]::GetParent($PSScriptRoot)
$ModuleSourceDir = "$ParentFolder" + "\PSURLhaus"
Write-host "Module Source: $ModuleSourceDir" -ForegroundColor Green

# Local Repository
$LocalPSRepository = "C:\Dev\MyLocalRepo"
If (-not (Test-path -Path $LocalPSRepository -PathType Container))
{
    Write-Host "Creating Local Repository Folder" -ForegroundColor Yellow
    New-Item -Path "$LocalPSRepository"
}

# Repository Parameters
$param = @{
    Name = "LocalPSRepository"
    SourceLocation = "$LocalPSRepository"
    InstallationPolicy = "Trusted"
}

$Repos = Get-PSRepository -Name "LocalPSRepository"
If ($null -eq $Repos)
{
    Write-Host "Registering Local Repository" -ForegroundColor Yellow
    Register-PSRepository @param 
}
Else
{
    Write-Host "Local Repository 'LocalRepository' is present" -ForegroundColor Green
}

## Module Manifest Testing
$ModuleManifest = Get-ChildItem -Path "$ModuleSourceDir\*.psd1"
$TestManifest = Test-ModuleManifest -Path "$($ModuleManifest.FullName)"

## ScriptAnalyzer
#Install-Module -Name PSScriptAnalyzer -force -Scope CurrentUser
#Invoke-ScriptAnalyzer -Path "$ModuleSourceDir"

## Publish Local Module Local
Write-host  "Publishing Module into local repository" -ForegroundColor Green
Publish-Module -Path "C:\dev\PSURLhaus\PSUrlhaus" -Repository "LocalPSRepository" -Verbose

## Install Module from local Repository
Write-Host "Installing module " -ForegroundColor Green
Find-module -Name "PSURLhaus" -Repository "LocalPSRepository" | Install-Module -Scope CurrentUser -Force

Write-host  "Publishing Module into PSGallery" -ForegroundColor Green
Publish-Module -Path "C:\dev\PSURLhaus\PSUrlhaus" -NuGetApiKey <my PSGallery API key> -Verbose 



