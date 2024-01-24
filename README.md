# Vision One Suspicious Objects Manager

AUTHOR		: Yanni Kashoqa

TITLE		: Vision One Suspicious Object Lists Management

DESCRIPTION	: These Powershell scripts will allow you to list, Add/update, and Delete suspicious objects in Vision One using the V1 APIs.


REQUIRMENTS
- Tested with PowerShell 7+ Core
- Populate the CSV file: SO_List.csv
    - File Content Header:  Type,Value,Description,ScanAction,RiskLevel,DaysToExpiration
    - Type column should be one of the following: url, domain, senderMailAddress, ip, fileSha1, or fileSha256
    - Only the Type and Value column are required
    - If a column is unpopulated, the V1 SO item will use the default settings as setup in the console
    - url entry should start with 'http://' 
    - Supported values:
        - ScanAction:  block, log
        - RiskLevel: high, medium, low
        - DaysToExpiration: Number of days, Default is 30 days, -1 means no expiration date
    - More details can be found here:  https://automation.trendmicro.com/xdr/api-v3#tag/Suspicious-Object-List/paths/~1v3.0~1threatintel~1suspiciousObjects/post    
- Create a XDR-Config.json in the same folder as this script with the following content:

~~~~JSON
{
    "XDR_SERVER": "api.xdr.trendmicro.com",
    "TOKEN" : "Token created in Vision One Console"
}
~~~~

- Token is the V1 API key and can be created here: Settings > API Keys
