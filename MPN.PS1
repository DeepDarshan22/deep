# Set your Azure subscription ID and partner ID
$subscriptionId = "71de5bbc-f94b-4a8d-b9a7-7bbd1a51f08e"
$partnerId = "12345"  

# Authenticate to Azure
az login

# Set the Azure subscription
az account set --subscription $subscriptionId

# Define the API version and resource URL
$apiVersion = "2021-07-01"
$resourceUrl = "https://management.azure.com/providers/Microsoft.Management/managementpartner/$partnerId?api-version=$apiVersion"

# Define the JSON payload for creating the management partner
$body = @{
    "properties" = @{
        "partnerId" = $partnerId
    }
} | ConvertTo-Json

# Invoke the Azure REST API to create the management partner
$response = Invoke-RestMethod -Method Put -Uri $resourceUrl -Headers @{
    Authorization = "Bearer $((az account get-access-token --resource=https://management.azure.com).accessToken)"
    ContentType = "application/json"
} -Body $body

# Output the response
$response
