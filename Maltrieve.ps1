# Author: Chris Harrod
#
# Downloads malware samples from the following sources:
# malc0de.com
# zeustracker.abuse.ch
# malwaredomainlist.com
# vxvault.net
# support.clean-mx.de


$OutputDirectory = "C:\Scripting\PoSH-Maltrieve\Output"

[xml]$RSS = Invoke-WebRequest "http://malc0de.com/rss/"
[xml]$RSS = $RSS.InnerXml
$arrItems = $rss.rss.channel.item
foreach ($Object in $arrItems){
    $ObjectPath = $Object.description.split(" ").replace(",","")[1]
    $ObjectURL = "http://$ObjectPath"
    $File = Invoke-Webrequest $ObjectURL -OutFile "$OutputDirectory/temp.temp" -PassThru
    $MD5 = (Get-FileHash $OutputDirectory/temp.temp -Algorithm MD5).Hash
    Rename-Item $OutputDirectory/temp.temp $MD5
}


[xml]$RSS = Invoke-WebRequest "https://zeustracker.abuse.ch/monitor.php?urlfeed=binaries"
[xml]$RSS = $RSS.InnerXml
$arrItems = $rss.rss.channel.item
foreach ($Object in $arrItems){
    $ObjectURL = $Object.description.split(" ").replace(",","")[1]
    $File = Invoke-Webrequest $ObjectURL -OutFile "$OutputDirectory/temp.temp" -PassThru
    $MD5 = (Get-FileHash $OutputDirectory/temp.temp -Algorithm MD5).Hash
    Rename-Item $OutputDirectory/temp.temp $MD5
}

[xml]$RSS = Invoke-WebRequest "http://www.malwaredomainlist.com/hostslist/mdl.xml"
[xml]$RSS = $RSS.InnerXml
$arrItems = $rss.rss.channel.item
foreach ($Object in $arrItems){
    
    $ObjectPath = $Object.description.split(" ").replace(",","")[1]
    $ObjectURL = "http://$ObjectPath"
    try{
        $File = Invoke-Webrequest $ObjectURL -OutFile "$OutputDirectory/temp.temp" -PassThru
    }
    catch{}
    if($File){
        $MD5 = (Get-FileHash $OutputDirectory/temp.temp -Algorithm MD5).Hash
        if(!(Test-Path $MD5)){
            Rename-Item $OutputDirectory/temp.temp $MD5
        }
    }
    $File = $Null
}

$Content = (Invoke-WebRequest "http://vxvault.net/URL_List.php").Content.Split('')
$arrItems = @()
foreach($Item in $Content){
    if ($Item -like "*http://*"){
        $arrItems += $Item
    }
}
foreach ($Object in $arrItems){
    $ObjectPath = $Object.description.split(" ").replace(",","")[1]
    $ObjectURL = "http://$ObjectPath"
    try{
        $File = Invoke-Webrequest $ObjectURL -OutFile "$OutputDirectory/temp.temp" -PassThru
    }
    catch{}
    if($File){
        $MD5 = (Get-FileHash $OutputDirectory/temp.temp -Algorithm MD5).Hash
        if(!(Test-Path $MD5)){
            Rename-Item $OutputDirectory/temp.temp $MD5
        }
    }
    $File = $Null
}


[xml]$RSS = (Invoke-WebRequest "http://support.clean-mx.de/clean-mx/rss?scope=viruses&limit=0%2C64")
[xml]$RSS = $RSS.InnerXml
$Content = $rss.rss.channel.item
$arrItems = @()
foreach($Item in $Content){
    $arrItems += $Item.title.'#cdata-section'
}

foreach ($Object in $arrItems){
    $ObjectPath = $Object.description.split(" ").replace(",","")[1]
    $ObjectURL = "http://$ObjectPath"
    try{
        $File = Invoke-Webrequest $ObjectURL -OutFile "$OutputDirectory/temp.temp" -PassThru
    }
    catch{}
    if($File){
        $MD5 = (Get-FileHash $OutputDirectory/temp.temp -Algorithm MD5).Hash
        if(!(Test-Path $MD5)){
            Rename-Item $OutputDirectory/temp.temp $MD5
        }
    }
    $File = $Null
}