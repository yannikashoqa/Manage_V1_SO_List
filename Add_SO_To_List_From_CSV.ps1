Clear-Host
Write-Host "################################  Start of Script  ################################"

$SO_LIST_SOURCE = "$PSScriptRoot\SO_List.csv"
If (-Not (Test-Path -Path $SO_LIST_SOURCE)){
    Write-Host "[ERROR] $SO_LIST_SOURCE File Not found"
    Exit(0)
}

$ConfigFile = "$PSScriptRoot\XDR-Config.json"
If (-Not (Test-Path -Path $ConfigFile)){
    Write-Host "[ERROR] Config File Not found"
    Exit(0)
}

$Config         = (Get-Content $ConfigFile -Raw) | ConvertFrom-Json
$XDR_SERVER     = $Config.XDR_SERVER
$TOKEN          = $Config.TOKEN
$BEARER_TOKEN   = 'Bearer ' + $Token

$XDR_URI        = "https://" + $XDR_SERVER
$SO_URI         = $XDR_URI + "/v3.0/threatintel/suspiciousObjects"

$V1_Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$V1_Headers.Add("Content-Type", 'application/json')
$V1_Headers.Add("Authorization", $BEARER_TOKEN)

$SO_List = Import-Csv $SO_LIST_SOURCE
foreach ($Item in $SO_List){
    switch ($Item.Type){
        url {
            $Type	=	"url"
        } 
        domain {
            $Type	=	"domain"
        }
        senderMailAddress {
            $Type	=	"senderMailAddress"
        } 
        ip {
            $Type	=	"ip"
        }
        fileSha1 {
            $Type	=	"fileSha1"
        }
        fileSha256 {
            $Type	=	"fileSha256"
        }
    }

    $SO_Item = @{
        "$Type" = $Item.Value;
        "description" = $Item.Description;
        "scanAction" = $Item.ScanAction;
        "riskLevel" = $Item.RiskLevel;
        "daysToExpiration" = $Item.DaysToExpiration
    }    
    $SO_ITEM_PAYLOAD = $SO_Item | ConvertTo-Json -Depth 4 -AsArray
    $SO_RESPONSE = Invoke-RestMethod $SO_URI -Method 'POST' -Headers $V1_Headers -Body $SO_ITEM_PAYLOAD
    $SO_RESPONSE | ConvertTo-Json
}