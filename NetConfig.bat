@echo off
title Network Configuration

set subnetMask=255.255.255.0

set choice=1

cls
echo.
echo                             NETWORK CONFIGURATION
echo.
echo.
echo  MAIN MENU
echo.
echo 1. Enable DHCP
echo 2. Set STATIC IP Address
echo 3. Exit
echo.
set /p choice=Enter your choice (1-3) : 
echo.
if %choice%==1 goto ENABLEDHCP
if %choice%==2 goto SETSTATIC
if %choice%==3 goto FINISHED

echo Invalid Input
goto FINISHED

:ENABLEDHCP
netsh interface ipv4 set address name="Ethernet" dhcp
netsh interface ipv4 set dnsservers name="Ethernet" dhcp
echo.
echo DHCP enabled on Ethernet
goto FINISHED

:SETSTATIC
set /p IPAddress=Enter the IP address : 
for /F "tokens=1,2,3 delims=." %%a in ("%IPAddress%") do set defaultGateway=%%a.%%b.%%c.1
netsh interface ipv4 set address name="Ethernet" static %IPAddress% %subnetMask% %defaultGateway%
if %errorlevel% NEQ 1 echo Static IP Address %IPAddress% set successfully
pause > nul
goto FINISHED

:FINISHED
echo.
echo.
echo Press any key to exit...
pause > nul
exit