(new-object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/dtthanh1971/hello-world/master/image/wallpaper.jpg',"$Env:USERPROFILE\\wallpaper.jpg");

Function Set-WallPaper($Image) {
<#
.SYNOPSIS
Applies a specified wallpaper to the current user's desktop
   
.PARAMETER Image
Provide the exact path to the image
 
.EXAMPLE
Set-WallPaper -Image "C:\Wallpaper\Default.jpg"
 
#>
 
Add-Type -TypeDefinition @" 
using System; 
using System.Runtime.InteropServices;
 
public class Params
{ 
    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
    public static extern int SystemParametersInfo (Int32 uAction, 
                                                   Int32 uParam, 
                                                   String lpvParam, 
                                                   Int32 fuWinIni);
}
"@ 
 
$SPI_SETDESKWALLPAPER = 0x0014
$UpdateIniFile = 0x01
$SendChangeEvent = 0x02
 
$fWinIni = $UpdateIniFile -bor $SendChangeEvent
 
$ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
}

Set-WallPaper -Image "$Env:USERPROFILE\\wallpaper.jpg";
