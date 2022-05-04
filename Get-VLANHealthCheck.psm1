function Get-VLANHealthCheck {
    <#
    .SYNOPSIS
            Gets Results from VLAN HealthCheck
    
    .DESCRIPTION
            If you have a lot of VLANs, the GUI form of the VLAN HealthCheck becomes rather unusable.
            At the time of writing this, there is no way, that I am aware, to export the healthcheck report.
    
    .PARAMETER VMHostName_str
            Name pattern of the host for which to get VLAN Healthcheck info (accepts regex patterns)
    
    .PARAMETER ClusterName_str
            Name pattern of the cluster for whose hosts to get VLAN Healthcheck info (accepts regex patterns)
    
    .PARAMETER vdSwitchName_str
            Name pattern of the VDSwitch for which to get VLAN info (accepts regex patterns)
            Recommend just using a single VDSwitch. It will accept multiple VDSwitches but the results will not be broken down for each VDSwitch
    
    .PARAMETER CommaDash
            Switch Parameter. If you don't add this, the script will default to "Comma Only" format for listing the VLANs.
            
    .EXAMPLE 
    Get-VLANHealthCheck -ClusterName_str Cluster1 -vdSwitchName_str vDS-SiteA-M1
            Host                PNic   Speed MAC               DeviceID        PortID  vdSwitch     UplinkPortKey UnTrunkedVLAN    TrunkedVLAN
            ----                ----   ----- ---               --------        ------  --------     ------------- -------------    -----------
            myHost2.contoso.com vmnic4 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/9  vDS-SiteA-M1 96            62,63,64         58,59,60,61,226,227,456,942,949
            myHost2.contoso.com vmnic5 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/10 vDS-SiteA-M1 97                             58,59,60,61,62,63,64,226,227,456,942,949
            myHost2.contoso.com vmnic6 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/10 vDS-SiteA-M1 98            62,63,64         58,59,60,61,226,227,456,942,949
            myHost2.contoso.com vmnic7 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/9  vDS-SiteA-M1 99                             58,59,60,61,62,63,64,226-227,456,942,949
            myHost1.contoso.com vmnic4 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/8  vDS-SiteA-M1 103           62,63,64         58,59,60,61,226,227,456,942,949
            myHost1.contoso.com vmnic5 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/8  vDS-SiteA-M1 104                            58,59,60,61,62,63,64,226,227,456,942,949
            myHost1.contoso.com vmnic6 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/7  vDS-SiteA-M1 105                            58,59,60,61,62,63,64,226,227,456,942,949
            myHost1.contoso.com vmnic7 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/7  vDS-SiteA-M1 106           62,63,64         58,59,60,61,226,227,456,942,949
            myHost3.contoso.com vmnic4 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/12 vDS-SiteA-M1 366                            58,59,60,61,62,63,64,226,227,456,942,949
            myHost3.contoso.com vmnic5 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/11 vDS-SiteA-M1 367                            58,59,60,61,62,63,64,226,227,456,942,949
            myHost3.contoso.com vmnic6 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/12 vDS-SiteA-M1 368           62,63,64         58,59,60,61,226,227,456,942,949
            myHost3.contoso.com vmnic7 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/11 vDS-SiteA-M1 369           62,63,64         58,59,60,61,226,227,456,942,949
            Gets all hosts in 'Cluster1' and shows results for all vmnics connected to 'vDS-SiteA-M1' and shows the results in "Comma Only" format.
    
    .EXAMPLE 
            Get-VLANHealthCheck -ClusterName_str Cluster1 -vdSwitchName_str vDS-SiteA-M1 -CommaDash
            Host                PNic   Speed MAC               DeviceID        PortID  vdSwitch     UplinkPortKey UnTrunkedVLAN TrunkedVLAN
            ----                ----   ----- ---               --------        ------  --------     ------------- ------------- -----------
            myHost2.contoso.com vmnic4 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/9  vDS-SiteA-M1 96            62-64         58-61,226,227,456,942,949
            myHost2.contoso.com vmnic5 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/10 vDS-SiteA-M1 97                          58-64,226,227,456,942,949
            myHost2.contoso.com vmnic6 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/10 vDS-SiteA-M1 98            62-64         58-61,226,227,456,942,949
            myHost2.contoso.com vmnic7 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/9  vDS-SiteA-M1 99                          58-64,226,227,456,942,949
            myHost1.contoso.com vmnic4 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/8  vDS-SiteA-M1 103           62-64         58-61,226,227,456,942,949
            myHost1.contoso.com vmnic5 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/8  vDS-SiteA-M1 104                         58-64,226,227,456,942,949
            myHost1.contoso.com vmnic6 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/7  vDS-SiteA-M1 105                         58-64,226,227,456,942,949
            myHost1.contoso.com vmnic7 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/7  vDS-SiteA-M1 106           62-64         58-61,226,227,456,942,949
            myHost3.contoso.com vmnic4 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/12 vDS-SiteA-M1 366                         58-64,226,227,456,942,949
            myHost3.contoso.com vmnic5 10000 00:00:00:00:00:00 sw2.contoso.com Eth1/11 vDS-SiteA-M1 367                         58-64,226,227,456,942,949
            myHost3.contoso.com vmnic6 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/12 vDS-SiteA-M1 368           62-64         58-61,226,227,456,942,949
            myHost3.contoso.com vmnic7 10000 00:00:00:00:00:00 sw1.contoso.com Eth1/11 vDS-SiteA-M1 369           62-64         58-61,226,227,456,942,949
            Gets all hosts in 'Cluster1' and shows results for all vmnics connected to 'vDS-SiteA-M1' and shows the results in "Comma Dash" format.
    
    .NOTES
            PowerCLI must be installed.
            Must be connected to a vCenter.
            VLAN HealthCheck must be enabled. Networking >> Select VDSwitch >> Configure >> HealthCheck >> Edit >> VLAN and MTU : Enable
    
    #>
    [CmdletBinding()]param(
        # Name pattern of the host for which to get VLAN Healthcheck info (accepts regex patterns)
        [parameter(Mandatory = $true, ParameterSetName = "SearchByHostName")][string]$vmhostName_str,
        # Name pattern of the cluster for whose hosts to get VLAN Healthcheck info (accepts regex patterns)
        [parameter(Mandatory = $true, ParameterSetName = "SearchByCluster", ValueFromPipelineByPropertyName)][Alias("Name")][string]$ClusterName_str,
        # Name pattern of the VDSwitch for which to get VLAN info (accepts regex patterns)
        [parameter(Mandatory = $true, HelpMessage = "'Ctrl + C' to cancel the cmdlet. Then use 'Get-VDSwitch' to see what is available to you. Recommend just using a single VDSwitch. It will accept multiple VDSwitches but the results will not be broken down for each VDSwitch")][string[]]$vdSwitchName_str,
        [switch]$CommaDash
    ) # end param
    
    $MyCollections = @()
    $grandtotal = @()
    # params for the Get-View expression for getting the View objects
    $hshGetViewParams = @{
        ViewType = "HostSystem"
        Property = "Name", "ConfigManager.NetworkSystem", "Config.Network.Pnic", "Runtime.connectionstate"
    } # end hashtable
         
    $hshGetViewNetworkParams = @{
        viewtype = "DistributedVirtualSwitch"
        Property = "Name", "Runtime.HostMemberRuntime"
    }
    Switch ($PSCmdlet.ParameterSetName) {
        # if host name pattern was provided, filter on it in the Get-View expression
        "SearchByHostName" { $hshGetViewParams["Filter"] = @{"Name" = $vmhostName_str }; break; } # end case
        # if cluster name pattern was provided, set it as the search root for the Get-View expression
        "SearchByCluster" { $hshGetViewParams["SearchRoot"] = (Get-Cluster $ClusterName_str).Id; break; }
    } # end switch
         
    # Process VMhosts
    Get-View @hshGetViewParams | where { $_.runtime.connectionstate - "Disconnected" } | Foreach-Object {
        $viewHost = $_
        Write-Host "Collating information for "$viewHost.name -ForegroundColor Green
        write-host " configmanager networksystem info"
        $networkSystem = get-view $viewHost.ConfigManager.NetworkSystem
        foreach ($pnic in $networkSystem.NetworkConfig.Pnic) {  
    
            $pnicInfo = $networkSystem.QueryNetworkHint($pnic.Device)  
            foreach ($Hint in $pnicInfo) {  
                                
                $NetworkInfo = New-Object PSObject -Property ([ordered]@{
                        Host     = ''
                        PNic     = ''
                        Speed    = ''
                        MAC      = ''
                        DeviceID = ''
                        PortID   = ''
                    })
                                
                $NetworkInfo.Host = $viewhost.Name  
                $NetworkInfo.PNic = $Hint.Device  
                $NetworkInfo.DeviceID = $Hint.connectedSwitchPort.DevId  
                $NetworkInfo.PortID = $Hint.connectedSwitchPort.PortId  
                             
                $record = 0  
                Do {  
                             
                    If ($Hint.Device -eq $viewhost.Config.Network.Pnic[$record].Device) {  
                                
                        $NetworkInfo.Speed = $viewhost.Config.Network.Pnic[$record].LinkSpeed.SpeedMb  
                        $NetworkInfo.MAC = $viewhost.Config.Network.Pnic[$record].Mac  
                    }  
                    $record ++  
                }  
                Until ($record -eq ($viewhost.Config.Network.Pnic.Length))  
                try {
                             
                    $MyCollections += $NetworkInfo  
                }
                catch {}
            }
        }     
    }
         
    # Collect the VLANs and format them in either Comman Only or Comman Dash format.  
    $hshGetViewNetworkParams["Filter"] = @{"Name" = "$vdSwitchName_str" }
    $vds = get-view @hshGetViewNetworkParams
    
    if($CommaDash) {
          $TrunkedVLANInfos = $vds.Runtime.HostMemberRuntime.HealthCheckResult | Where-Object {$_ -is [VMware.Vim.VMwareDVSVlanHealthCheckResult]} |
            Select-Object @{N = 'vdSwitch'; E = {$vds.Name}},
            UplinkPortKey,
            @{N = 'TrunkedVLAN'; E = {
                ($_.TrunkedVLAN | ForEach-Object {
                    if ($_.Start -eq $_.End) {
                        "{0}" -f $_.Start
                    } elseif ($($_.Start + 1) -eq $_.End) {
                        ($(([Int]$_.Start)..([Int]$_.End))) -join ','
                    } else {
                        "{0}-{1}" -f $_.Start, $_.End
                    }
               }) -join ','
            }
            }, @{N = 'UnTrunkedVLAN'; E = {
                ($_.UnTrunkedVLAN | ForEach-Object {
                    if ($_.Start -eq $_.End) {
                        "{0}" -f $_.Start
                    } else {
                        "{0}-{1}" -f $_.Start, $_.End
                    }
                }) -join ','
            }
        }
    } else {  
        $TrunkedVLANInfos = $vds.Runtime.HostMemberRuntime.HealthCheckResult | Where-Object {$_ -is [VMware.Vim.VMwareDVSVlanHealthCheckResult]} |
            Select-Object @{N = 'vdSwitch'; E = {$vds.Name}},
            UplinkPortKey,
            @{N = 'TrunkedVLAN'; E = {
                ($_.TrunkedVLAN | ForEach-Object {
                    if ($_.Start -eq $_.End) {
                        "{0}" -f $_.Start
                    } else {
                        ($(([Int]$_.Start)..([Int]$_.End))) -join ','
                    }
                }) -join ','
            }
            }, @{N = 'UnTrunkedVLAN'; E = {
                ($_.UnTrunkedVLAN | ForEach-Object {
                    if ($_.Start -eq $_.End) {
                        "{0}" -f $_.Start
                    } else {
                        ($(([Int]$_.Start)..([Int]$_.End))) -join ','
                    }
                }) -join ','
            }
        }
    }
    # Collect Uplinks
    $vdport = Get-VDSwitch -Name $vds.name -PipelineVariable oThisVDSwitch | ForEach-Object -Begin { $hshVMHostMemo = @{} } { $oThisVDSwitch.ExtensionData.FetchDVPorts(@{uplinkPort = $true }) | Select-Object key, @{n = "ConnectedEntity"; e = { $_.Connectee.NicKey } }, @{n = "ProxyHost"; e = { if (-not $hshVMHostMemo.ContainsKey($_.ProxyHost)) { $hshVMHostMemo[$_.ProxyHost] = Get-View -Property Name -Id $_.ProxyHost }; $hshVMHostMemo[$_.ProxyHost].Name } }, @{n = "Switch"; e = { $oThisVDSwitch } } }
         
    # Collating all the different tables together.
    foreach ($Collection in $MyCollections) {
        foreach ($vd in $vdport) {
            if (($Collection.Host -eq $vd.ProxyHost) -and ($Collection.PNic -eq $vd.ConnectedEntity)) {
                foreach ($TrunkedVLANInfo in $TrunkedVLANInfos) {
                    if ($TrunkedVLANInfo.UplinkPortKey -eq $vd.Key) {
                        $Result = New-Object PSObject -Property ([ordered]@{
                                Host          = $Collection.Host
                                PNic          = $Collection.PNic
                                Speed         = $Collection.Speed
                                MAC           = $Collection.MAC
                                DeviceID      = $Collection.DeviceID
                                PortID        = $Collection.PortID
                                vdSwitch      = $TrunkedVLANInfo.vdSwitch
                                UplinkPortKey = $TrunkedVLANInfo.UplinkPortKey
                                UnTrunkedVLAN = $TrunkedVLANInfo.UnTrunkedVLAN
                                TrunkedVLAN   = $TrunkedVLANInfo.trunkedVlan
                            })
                        $grandtotal += $Result
                    }
                }
            }
        }
    }
    $grandtotal
}
function Set-vCenterHealthCheck {
<#
    .SYNOPSIS
            Enable / Disable vCenter HealthCheck settings
    
    .DESCRIPTION
            This cmdlet allows you to enable, or disable, the VLAN HealthCheck feature in vCenter for any or all your distributed switches.
            You can enter the VDSwitch by hand or send it over the pipeline.
    
    .PARAMETER vdSwitchName_str
            Name pattern of the VDSwitch for which to get VLAN info (accepts regex patterns)
            Recommend just using a single VDSwitch. It will accept multiple VDSwitches but the results will not be broken down for each VDSwitch
    .PARAMETER EnableDVS_Vlan_Mtu_Health
            Enables the VLAN/MTU property in VLAN HealthCheck
    .PARAMETER DisableDVS_Vlan_Mtu_Health
            Disables the VLAN/MTU property in VLAN HealthCheck
    .PARAMETER EnableDVS_Teaming_Health
            Enables the DVS Teaming property in VLAN HealthCheck
    .PARAMETER DisableDVS_Teaming_Health
            Disables the DVS Teaming property in VLAN HealthCheck
    .PARAMETER Interval
            By Default, the VLAN Healthcheck runs every 1 minute. 
            Use this parameter to change that default to something higher than 1 minute.
     .EXAMPLE
            Get-VDSwitch | Set-vCenterHealthCheck -DisableDVS_Vlan_Mtu_Health
            Disables the VLAN/MTU portion of the VLAN HealthCheck
    .EXAMPLE
            Get-VDSwitch | Set-vCenterHealthCheck -EnableDVS_Vlan_Mtu_Health
            Enables the VLAN/MTU portion of the VLAN HealthCheck
    .EXAMPLE
            Set-vCenterHealthCheck -vdSwitchName_str <VDS Name> -DisableDVS_Vlan_Mtu_Health
            Disables the VLAN/MTU portion of the VLAN HealthCheck for <VDS Name> only
    .EXAMPLE
            Set-vCenterHealthCheck -vdSwitchName_str <VDS Name> -EnableDVS_Vlan_Mtu_Health
            Enables the VLAN/MTU portion of the VLAN HealthCheck for <VDS Name> only
    .NOTES
            PowerCLI must be installed.
            Must be connected to a vCenter.
            The output currently is just the Task ID. Need to work on the output.
#>
    [CmdletBinding()]
    param (
        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = "'Ctrl + C' to cancel the cmdlet. Then use 'Get-VDSwitch' to see what is available to you. Recommend just using a single VDSwitch.")]
        [string[]]$vdSwitchName_str,
        [switch]$EnableDVS_Vlan_Mtu_Health,
        [switch]$DisableDVS_Vlan_Mtu_Health,
        [switch]$EnableDVS_Teaming_Health,
        [switch]$DisableDVS_Teaming_Health,
        [int]$interval
    )

    Begin {
    $hshGetViewNetworkParams = @{
        viewtype = "DistributedVirtualSwitch"
        Property = "Name"
    }

    $healthCheckConfig = New-Object VMware.Vim.DVSHealthCheckConfig[] (2)

    if ($EnableDVS_Vlan_Mtu_Health) {
        $healthCheckConfig[0] = New-Object VMware.Vim.VMwareDVSVlanMtuHealthCheckConfig
        $healthCheckConfig[0].Enable = $true
        $healthCheckConfig[0].Interval = $interval
    }

    if ($DisableDVS_Vlan_Mtu_Health) {
        $healthCheckConfig[0] = New-Object VMware.Vim.VMwareDVSVlanMtuHealthCheckConfig
        $healthCheckConfig[0].Enable = $false
        $healthCheckConfig[0].Interval = 0
    }
    if ($EnableDVS_Teaming_Health) {
        $healthCheckConfig[1] = New-Object VMware.Vim.VMwareDVSTeamingHealthCheckConfig
        $healthCheckConfig[1].Enable = $true
        $healthCheckConfig[1].Interval = $interval
    }

    if ($DisableDVS_Teaming_Health) {
        $healthCheckConfig[1] = New-Object VMware.Vim.VMwareDVSTeamingHealthCheckConfig
        $healthCheckConfig[1].Enable = $false
        $healthCheckConfig[1].Interval = 0
    }
    }
    Process {
        foreach ($vdSwitch in $vdSwitchName_str) {
            $hshGetViewNetworkParams["Filter"] = @{"Name" = "$vdSwitch" }
            $_this = get-view @hshGetViewNetworkParams
            $_this.UpdateDVSHealthCheckConfig_Task($healthCheckConfig)
        }
    }
    End {}

}
