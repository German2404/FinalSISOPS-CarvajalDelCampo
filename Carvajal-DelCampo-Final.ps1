<#
.SYNOPSIS
Script que despliega opciones de acceso a una servidor de base de datos
.DESCRIPTION
0. Exit
1. Top 5 CPU consuming processes
2. Filesystems connected to the machine
3. Biggest file and it's size, given it's filesystem
4. Free memory and used swap space
5. Number of active network connections
.PARAMETER Select numero seleccionado
Condition el boolean de la condicion del do while
.EXAMPLE

#>
#
param (
[int] $select=0,
$condition=$true
)

function one{
Write-Host "Option one selected"
#Write-Host "Total Usage:"
#Get-Process| Sort-Object CPU -Descending | Select-Object ID, ProcessName,CPU -first 5 
Write-Host "Current Usage:"
Get-WmiObject Win32_PerfFormattedData_PerfProc_Process |
Where-Object{ $_.Name -ne "_Total" -and $_.Name -ne "Idle"} |
Sort-Object PercentProcessorTime -Descending |
Select-Object Name,IDProcess,PercentProcessorTime -First 5|ft
}

function two{
Write-Host "Option two selected"
Get-PSDrive -PSProvider FileSystem | ft Name,@{n='USED(B)';e={$_.Used}}, @{n='FREE(B)';e={$_.Free}}
}

function three{
Write-Host "Option three selected"
$loc = read-host "Please, write the location you want to check"
 Get-ChildItem -Path $loc -Recurse -ErrorAction SilentlyContinue| Sort-Object Length -Descending|Select-Object -first 1|ft Name,@{n='Length(KB)';e={$_.Length / 1KB -as [int]}},@{n='Location';e={$_.FullName}}
}


Write-Host "Por German Carvajal y Santiago del Campo"
Write-Host ""
Write-Host "Welcome to the Datacenter Manager Help Module"
Write-Host "Please, select one of the following actions by typing the option's number"
Write-Host "The result of your inquiry will be displayed shortly after"
Write-Host ""
Write-Host "0. Exit"
Write-Host "1. Top 5 CPU consuming processes"
Write-Host "2. Filesystems connected to the machine"
Write-Host "3. Biggest file and it's size, given it's filesystem"
Write-Host "4. Free memory and used swap space"
Write-Host "5. Number of active network connections"

DO{

$select= Read-Host "Please, select an option"

if($select -eq 0)
{$condition=$false}

elseif($select -eq 1)
{one}

elseif($select -eq 2)
{two}

elseif($select -eq 3)
{three}

elseif($select -eq 4)
{four}

elseif($select -eq 5)
{five}

else{Write-Host "No such option"}


} while($condition)