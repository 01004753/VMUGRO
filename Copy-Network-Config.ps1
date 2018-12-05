$VISRV = Connect-VIServer "name"
$BASEHost = Get-VMHost -Name "esxi"
$NEWHost = Get-VMHost -Name "esxi"
$portgroups = $BASEHost | Get-VirtualPortGroup
foreach ($portgroup in $portgroups) {
if ($portgroup.Name -match "VMKernel" -or $portgroup.name -match "Management Network" -or $portgroup.name -match "VM Network") {write-host "Ignoring vmkernel / network / management"} else {$NEWHost | Get-VirtualSwitch -Name “vSwitch0” | New-VirtualPortGroup -Name $portgroup.Name -VLanId $portgroup.vlanid}
}
#install vmotion
$VMIP = "x.x.x.x"
$VMOTIONNM = "x.x.x.x"
$VMOTIONVLAN = x
$vSw0 = Get-VirtualSwitch -VMHost $NEWHost -Name vSwitch0;
New-VMHostNetworkAdapter -VMHost $NEWHost -PortGroup "VMkernel" -VirtualSwitch $vSw0 -IP $VMIP -SubnetMask $VMOTIONNM -VMotionEnabled $true;
$vmk = $NEWHOST | Get-VirtualSwitch -Name "vSwitch0" | Get-VirtualPortGroup -name "vmkernel"
Set-VirtualPortGroup -VirtualPortGroup $vmk -VlanId $VMOTIONVLAN
