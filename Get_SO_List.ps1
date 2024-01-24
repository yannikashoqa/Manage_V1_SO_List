Clear-Host
Write-Host "################################  Start of Script  ################################"

$Config         = (Get-Content "$PSScriptRoot\XDR-Config.json" -Raw) | ConvertFrom-Json
$XDR_SERVER     = $Config.XDR_SERVER
$TOKEN          = $Config.TOKEN
$BEARER_TOKEN   = 'Bearer ' + $Token

$XDR_URI        = "https://" + $XDR_SERVER
$SO_URI         = $XDR_URI + "/v3.0/threatintel/suspiciousObjects"

$V1_Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$V1_Headers.Add("Content-Type", 'application/json')
$V1_Headers.Add("Authorization", $BEARER_TOKEN)

$SO_RESPONSE = Invoke-RestMethod $SO_URI -Method 'GET' -Headers $V1_Headers
$SO_RESPONSE | ConvertTo-Json
