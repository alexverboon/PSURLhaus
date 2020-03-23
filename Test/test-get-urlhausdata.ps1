# URL Data 
$url = Get-UrlHausData -URL
$urlcount = $url.Count
$urlcount
$url = Get-UrlHausData -URL -Verbose 
$url = Get-UrlHausData -URL -CacheMinutes 2 -Verbose 
$url = Get-UrlHausData -URL -NoCache -Verbose

# Payload
$payl = Get-UrlHausData -Payload
$paylcount = $payl.Count
$paylcount
$payl = Get-UrlHausData -Payload -Verbose
$payl = Get-UrlHausData -Payload -CacheMinutes 2 -Verbose 
$payl = Get-UrlHausData -Payload -NoCache -Verbose

# Payload MD5
$paylmd5 = @(Get-UrlHausData -Payload -MD5 508a488117f7379a06f4839c79078c31)
$paylmd5count = $paylmd5.count
$paylmd5 = Get-UrlHausData -Payload -MD5 508a488117f7379a06f4839c79078c31 -Verbose
$paylmd5 = Get-UrlHausData -Payload -MD5 508a488117f7379a06f4839c79078c31 -CacheMinutes 2 -Verbose
$paylmd5 = Get-UrlHausData -Payload -MD5 508a488117f7379a06f4839c79078c31 -NoCache -Verbose

# Payload SHA256
$paylSHA256 = @(Get-UrlHausData -Payload -SHA256 5f31742eeb4a01b03f84741a768a2686e8f0cf7e12bbe8ecd4162eb59ba7d48c)
$paylSHA256count = $paylSHA256.count
$paylSHA256 = @(Get-UrlHausData -Payload -SHA256 5f31742eeb4a01b03f84741a768a2686e8f0cf7e12bbe8ecd4162eb59ba7d48c -Verbose)
$paylSHA256 = @(Get-UrlHausData -Payload -SHA256 5f31742eeb4a01b03f84741a768a2686e8f0cf7e12bbe8ecd4162eb59ba7d48c -CacheMinutes 2 -Verbose)
$paylSHA256 = @(Get-UrlHausData -Payload -SHA256 5f31742eeb4a01b03f84741a768a2686e8f0cf7e12bbe8ecd4162eb59ba7d48c -NoCache -Verbose)

# URL Info
$urlinfo = @(Get-UrlHausData -URLINFO "http://sskymedia.com/VMYB-ht_JAQo-gi/INV/99401FORPO/20673114777/US/Outstanding-Invoices/")
$urlinfocount = $urlinfo.Count
$urlinfocount
$urlinfo = @(Get-UrlHausData -URLINFO "http://sskymedia.com/VMYB-ht_JAQo-gi/INV/99401FORPO/20673114777/US/Outstanding-Invoices/" -Verbose)
$urlinfo = @(Get-UrlHausData -URLINFO "http://sskymedia.com/VMYB-ht_JAQo-gi/INV/99401FORPO/20673114777/US/Outstanding-Invoices/" -CacheMinutes 2 -Verbose)
$urlinfo = @(Get-UrlHausData -URLINFO "http://sskymedia.com/VMYB-ht_JAQo-gi/INV/99401FORPO/20673114777/US/Outstanding-Invoices/" -NoCache -Verbose)


# Host Info
$hostinfo = @(Get-UrlHausData -Hostname 'vektorex.com')
$hostinfocount = $hostinfo.count
$hostinfocount
$hostinfo = @(Get-UrlHausData -Hostname vektorex.com -Verbose)
$hostinfo = @(Get-UrlHausData -Hostname vektorex.com -CacheMinutes 2 -Verbose)
$hostinfo = @(Get-UrlHausData -Hostname vektorex.com -NoCache -Verbose)
