###############################
#TOSHIBA Universal Printer 2  #
################################
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$drivername = "Microsoft PCL6 Class Driver"
$portName = "IP_10.254.14.20"
$PortAddress = "10.254.14.20"

#######################
#Installing Drivers   #
#######################
Add-PrinterDriver -Name $drivername

##########################################################
#Install Printerport | check if the port already exist   #
##########################################################
$checkPortExists = Get-Printerport -Name $portname -ErrorAction SilentlyContinue
if (-not $checkPortExists) 
{
    Add-PrinterPort -Name $portName -PrinterHostAddress $PortAddress
}

####################################
#Check if PrinterDriver Exists     #
####################################
$printDriverExists = Get-PrinterDriver -Name $drivername -ErrorAction SilentlyContinue

##################
#Install Printer #
##################
if ($printDriverExists)
{
    Add-Printer -Name "Triumph-Adler 2508ci" -PortName $portName -DriverName $drivername
}
else
{
    Write-Warning "Printer Driver not installed"
}

# Script will exit naturally here without any waiting period
