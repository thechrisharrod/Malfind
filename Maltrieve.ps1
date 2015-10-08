$Session = New-PSSession client



[xml]$RSS = Invoke-WebRequest "http://malc0de.com/rss/"
[xml]$RSS = $RSS.InnerXml
$Items = $rss.rss.channel.item
foreach ($Item in $Items){
    $item.description.split(" ").replace(",","")[1]
}



"https://zeustracker.abuse.ch/monitor.php?urlfeed=binaries"
"http://www.malwaredomainlist.com/hostslist/mdl.xml"
"http://malc0de.com/rss/"
"http://vxvault.net/URL_List.php"
"http://urlquery.net/"
"http://support.clean-mx.de/clean-mx/rss?scope=viruses&limit=0%2C64"
"http://malwareurls.joxeankoret.com/normal.txt"