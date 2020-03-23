# PSURLhaus

Welcome to the URLhaus PowerShell Module

This module provides you with easy-to-use cmdlets to make it easy to interface with the
[URLhaus API](https://urlhaus-api.abuse.ch/) a project operated by abuse.ch with the purpose of collecting, tracking and sharing malware URLs to support security analysts to protect their network and customers from cyber threats.

Please also reads the [Terms of Services](https://urlhaus-api.abuse.ch/#tos) published by URLhaus

Just in case you didn't read the TOS from URLhaus: URLhaus can not be held liable for any false positive or damage caused by the use of the website or the datasets offered throgh their API, the same applies for the creator of this powershell module

## Perequisites

This PowerShell module runs with Windows PowerShell 5.1 and PowerShell 7.0

## Getting Started

To get started with the module, open your PowerShell terminal as an administrator and install the module from the PSGallery by running this simple command:

```powershell
Install-Module "PSURLhaus"
```

or if you don't have or wish to use administrator giths, use the following command to install the module in your personal powershell profile.

```powershell
Install-Module "PSURLhaus" -Scope CurrentUser
```

## Cmdlets

This initial version has only one cmdlet **Get-URLhausdata** Use this cmdlet to retrieve the following information from the URLhaus database.

Get-URLhausdata provides the following parameters:

**URL** - Retrieve a list of recent URLs (recent additions made to URLhaus)

```powershell
Get-URLhausData -URL
```

**Payload** -  Retrieve a list of recent payloads (recent payloads seen by URLhaus)

```powershell
Get-URLhausData -Payload
```

**MD5** - Use with parameter Payload. The MD5 hash of the payload (malware sample) you want to query URLhaus for

```powershell
Get-UrlHausData -Payload -MD5 508a488117f7379a06f4839c79078c31
```

**SHA256** - Use with parameter Payload. The SHA256 hash of the payload (malware sample) you want to query URLhaus for

```powershell
Get-UrlHausData -Payload -SHA256 5f31742eeb4a01b03f84741a768a2686e8f0cf7e12bbe8ecd4162eb59ba7d48c
```

**URLINFO** - The URL to check against the URLhaus database

```powershell
Get-UrlHausData -URLINFO "http://sskymedia.com/VMYB-ht_JAQo-gi/INV/99401FORPO/20673114777/US/Outstanding-Invoices/
```

**Hostname** - The host (IPv4 address, hostname or domain name) to query aainst the URLhaus database

 ```powershell
Get-UrlHausData -Hostname 'vektorex.com
```

**CacheMinutes** - Use with parameter **URL** or **Payload**.  To prevent unecessary stress for the online URLhaus API, this parameter  defines the time previously retrieved data from the same API endpoint remains cached  utnil the data is fetched from the live API again. Th default is 15 minutes. If you do not wish to  use the cache use the **-NoCache** option

**NoCache** - Use with parameter **URL** or **Payload**. Use this switch to send every request to the online API, otherwise previously retrieved data within the current session is used for 15 minutes (default) or as long as specified by the CacheMinutes parameter

```powershell
Get-URLhausData -URL -NoCache
```
