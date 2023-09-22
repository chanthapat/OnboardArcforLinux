
export subscriptionId="673fc894-c467-4d46-89bd-894d3af0f427";
export resourceGroup="RG-AzureArc";
export tenantId="383db85b-9823-45fa-875d-c6404db4d31b";
export location="southeastasia";
export authType="token";
export correlationId="df4fc39b-cec8-4675-bb42-25cc2206e682";
export cloud="AzureCloud";


# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --automanage-profile "/providers/Microsoft.Automanage/bestPractices/AzureBestPracticesProduction" --correlation-id "$correlationId";
