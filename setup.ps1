Add-Type -Path ".\octopus.client.4.30.6\lib\net451\Octopus.Client.dll"

#Connection variables
$apikey = Get-Content api.key
$OctopusURI = "http://localhost:8090/"
 
#Creating a connection
$endpoint = new-object Octopus.Client.OctopusServerEndpoint $OctopusURI,$apikey
$repository = new-object Octopus.Client.OctopusRepository $endpoint
 
#First example of Querying Octopus from Powershell
#Getting all the users on this Octopus instance
$repository.Users.FindAll()
$repository.Projects.FindAll()