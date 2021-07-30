
#! /bin/sh

# Download Unity3D installer into the container
#  The below link will need to change depending on the version, this one is for 5.5.1
#  Refer to https://unity3d.com/get-unity/download/archive and find the link pointed to by Mac "Unity Editor"
echo 'Downloading Unity 5.5.1 pkg:'
curl --retry 5 -o Unity.pkg https://download.unity3d.com/download_unity/ca5b14067cec/UnityDownloadAssistant.dmg?_gl=1*kpbmrp*_ga*MTc5ODQzNDA0Ny4xNTkyMzM4MDYx*_ga_1S78EFL1W5*MTYyNzY1NTI1Ny4yNS4xLjE2Mjc2NTczNzAuNjA.&_ga=2.17023737.1585382684.1627442935-1798434047.1592338061
if [ $? -ne 0 ]; then { echo "Download failed"; exit $?; } fi