Add-Type -Path ".\octopus.client.4.30.6\lib\net451\Octopus.Client.dll"

function Get-OctoDeploy
{
    $octoConfig = Get-Content ".\octo.config.json" | Out-String | ConvertFrom-Json

    #Connection variables
    $apikey = $octoConfig.OctoServerApiKey
    $OctopusURI = $octoConfig.OctoServerUri
    
    #Creating a connection
    $endpoint = new-object Octopus.Client.OctopusServerEndpoint $OctopusURI,$apikey
    $repository = new-object Octopus.Client.OctopusRepository $endpoint

    return $repository
}


function Get-JsonFileProjectName 
{
    param(
        [string]$filePath    
    )

    $jsonFile = Get-Content $filePath | Out-String | ConvertFrom-Json

    return $jsonFile.Project.Name
}


function CheckIfProjectExist 
{
    param(
        [string]$sourcePath    
    )
    
    $sourceProjName = Get-JsonFileProjectName $sourcePath

    Write-Host "Source: " $sourceProjName

    $octoRepo = Get-OctoDeploy

    $octoRepo.Projects.Get($sourceProjName)

    if ($octoRepo -ne $null) {
        Write-Host "The Project Exist"
    }
}

