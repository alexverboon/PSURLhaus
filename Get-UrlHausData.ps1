
Function Get-UrlHausData{
<#
.Synopsis
   Get-UrlHausData
.DESCRIPTION
   Get-UrlHausData retrieves open source threat intelligence data from URLhaus

   URLs most recently added
   Payloads recently added
   URL information
   Host information
   Payload information
   Tag information
   Signature Information

   Please note that the API will return a list of recent additions made in the past 3 days, but will return maximal 1000 entries.
   
   For more information about the URLhaus API see https://urlhaus-api.abuse.ch

.PARAMETER URL

 Retrieve a list of recent URLs (recent additions made to URLhaus), 
 
 Detailed information about the response data can be found here: https://urlhaus-api.abuse.ch/#urls-recent
 
.PARAMETR Payload
 Retrieve a list of recent payloads (recent payloads seen by URLhaus), 

 Detailed information about the response data can be found here: https://urlhaus-api.abuse.ch/#payloads-recent

.PARAMETER URLINFO 
 The URL to check against the URLhaus database. 

 Retrieves information about an URL

 Detailed information about the response data can be found here: https://urlhaus-api.abuse.ch/#urlinfo


.PARAMETER Host
 The host (IPv4 address, hostname or domain name) to query aainst the URLhaus database
 
 Detailed information about the response data can be found here: https://urlhaus-api.abuse.ch/#hostinfo




.NOTES
    v1.0, 22.03.2020, Alex Verboon

.EXAMPLE
   Get-UrlHausData -URL

    id                : 328248
    urlhaus_reference : https://urlhaus.abuse.ch/url/328248/
    url               : http://142.93.202.20/911.i586
    url_status        : offline
    host              : 142.93.202.20
    date_added        : 2020-03-22 06:53:22 UTC
    threat            : malware_download
    blacklists        : @{spamhaus_dbl=not listed; surbl=not listed}
    reporter          : c0deless
    larted            : true
    tags              : {mirai}

    id                : 328247
    urlhaus_reference : https://urlhaus.abuse.ch/url/328247/
    url               : http://142.93.202.20/911.ppc
    url_status        : offline
    host              : 142.93.202.20
    date_added        : 2020-03-22 06:53:20 UTC
    threat            : malware_download
    blacklists        : @{spamhaus_dbl=not listed; surbl=not listed}
    reporter          : c0deless
    larted            : true
    tags              : {mirai}

   Retrieves the most recent (1000) URL additions made to URLhaus
   

.EXAMPLE
   Get-UrlHausData -Payload 

    md5_hash         : 508a488117f7379a06f4839c79078c31
    sha256_hash      : 5f31742eeb4a01b03f84741a768a2686e8f0cf7e12bbe8ecd4162eb59ba7d48c
    file_type        : unknown
    file_size        : 40261
    signature        : 
    firstseen        : 2020-03-22 14:27:29
    urlhaus_download : https://urlhaus-api.abuse.ch/v1/download/5f31742eeb4a01b03f84741a768a2686e8f0cf7e12bbe8e
                       cd4162eb59ba7d48c/
    virustotal       : 
    imphash          : 
    ssdeep           : 768:N//BFx9FXAxDsK0wQUfcQ+gmBlqhSOVuxCWjsRAzRXz/tHd:Hj9xAOiVsgfwECH
    tlsh             : D303DB8626F3352AAD13B9FEBFFA2349B0719057C284CC5B7F9CA5459F492824813B5C

    md5_hash         : 721810c91d94f3b3aac71e813e12776f
    sha256_hash      : 68314aadbe959acdc4e0fa189134d510fffa0ae73b88e8085b1d9b09a10ce320
    file_type        : unknown
    file_size        : 36992
    signature        : 
    firstseen        : 2020-03-22 14:27:26
    urlhaus_download : https://urlhaus-api.abuse.ch/v1/download/68314aadbe959acdc4e0fa189134d510fffa0ae73b88e80
                       85b1d9b09a10ce320/
    virustotal       : 
    imphash          : 
    ssdeep           : 768:X/BFx9FXzRZchvPCe6sOhSOVuxCWjsRAzRXz/tHd:Jj9xNuPSvwECH
    tlsh             : 40F2C94A26B3312AAD17BDFEBFFB1305B175A047C284CC5B7F9CA549AF492814802B5C



   Retrieves the most recent (1000) Payload additions made to URLhaus

.EXMAPLE

  Get-UrlHausData -URLINFO "http://sskymedia.com/VMYB-ht_JAQo-gi/INV/99401FORPO/20673114777/US/Outstanding-Invoices/"

    query_status          : ok
    id                    : 105821
    urlhaus_reference     : https://urlhaus.abuse.ch/url/105821/
    url                   : http://sskymedia.com/VMYB-ht_JAQo-gi/INV/99401FORPO/20673114777/US/Outstanding-Invo
                            ices/
    url_status            : offline
    host                  : sskymedia.com
    date_added            : 2019-01-19 01:33:26 UTC
    threat                : malware_download
    blacklists            : @{spamhaus_dbl=not listed; surbl=not listed}
    reporter              : Cryptolaemus1
    larted                : true
    takedown_time_seconds : 225385
    tags                  : {emotet, epoch2, heodo}
    payloads              : {@{firstseen=2019-01-19; filename=676860772178.doc; file_type=doc; 
                            response_size=172752; response_md5=cf6bc359bc8a667c1b8d241e9591f392; 
                            response_sha256=72820698de9b69166ab226b99ccf70f3f58345b88246f7d5e4e589c21dd44435; u
                            rlhaus_download=https://urlhaus-api.abuse.ch/v1/download/72820698de9b69166ab226b99c
                            cf70f3f58345b88246f7d5e4e589c21dd44435/; signature=Heodo; virustotal=; imphash=; 
                            ssdeep=; tlsh=}, @{firstseen=2019-01-19; filename=PAY845086736936754.doc; 
                            file_type=doc; response_size=177744; 
                           ...}
.EXAMPLE

 Get-URLhausData -HOST 



#>

  [CmdletBinding()]
  Param(
    # Recent URLs
    [Parameter(Mandatory=$true,
                   ParameterSetName='URL',
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [switch]$URL,

    # Recent Payloads
    [Parameter(Mandatory=$true,
                   ParameterSetName='Payload',
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]

    [switch]$Payload,

    # URL Information
    [Parameter(Mandatory=$true,
                   ParameterSetName='URLINFO',
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [ValidateNotNull()]
    [string]$URLINFO,

    # Host Information
    [Parameter(Mandatory=$true,
                   ParameterSetName='URLINFO',
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [ValidateNotNull()]
    [string]$Host,


    # Number of minutes to use the cached content before updating
    [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [int]$CacheMinutes,
    # Ignore Cache
    [Parameter(Mandatory=$false,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [switch]$NoCache
  )

Begin{

        If ($PSBoundParameters.Keys.Contains("URL"))
        {
            write-verbose "URL parameter selected"
            $Endpoint = "urls/recent/"
            $outputvalue = "urls"
            $method = "Get"
        }
        Elseif($PSBoundParameters.Keys.Contains("Payload"))
        {
            write-verbose "Payload parameter selected"
            $Endpoint = "payloads/recent/"
            $outputvalue = "payloads"
            $method = "Get"
        }
        ElseIf($PSBoundParameters.Keys.Contains("URLINFO"))
        {
            write-verbose "URL Info parameter selected"
            $Endpoint = "url"
            $outputvalue = 'urlinfo'
            $method = "Post"
            $body = @{url = $URLINFO}
        }
        ElseIf($PSBoundParameters.Keys.Contains("Host"))
        {
            write-verbose "Host Info parameter selected"
            $Endpoint = "host"
            $outputvalue = 'host'
            $method = "Post"
            $body = @{host = $host}
        }

        Else{
            Write-Error "Unknown Parameter"
            Break
        }

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $global:Method = 'GET'
        $global:Timeout = 30
        $global:UserAgent = [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome
        $Uri = "https://urlhaus-api.abuse.ch/v1/$Endpoint/".ToLower()
        Write-Verbose "Uri: $uri"

       
        If(-not($lastoutputvaluename -eq "$outputvalue"))
        {
            $NoCache = $true
            Write-Verbose "The previous cache was from another endpoint"
        }
        
}
Process{
        If ($NoCache)
        {
            Remove-Variable -Name LastCacheDate -Scope Global -ErrorAction SilentlyContinue
            Remove-Variable -Name resultcache -Scope Global -ErrorAction SilentlyContinue

            Write-verbose "Not using cache retrieving live data"
            Try{
                $global:resultcache = @(Invoke-RestMethod -Uri $Uri -Method $method -TimeoutSec $global:Timeout -UserAgent $global:UserAgent -Body $body) 
                
                If ($global:resultcache.query_status -eq "ok")
                {
                    $global:LastCacheDate = Get-date
                    If($Endpoint -eq "URL")
                    {
                        $global:resultcache
                    }
                    Else
                    {
                        $global:resultcache.$outputvalue
                    }
                }
                Elseif($global:resultcache.querystatus -eq "no_results")
                    {
                        Write-Warning "The query yield no results"
                        break
                    }
                    Else
                    {
                        Write-Error "unknown response"
                        break
                    }
             }
            
            Catch{
                Write-error "StatusCode:" $_.Exception.Response.StatusCode.value__ 
                Write-error "StatusDescription:" $_.Exception.Response.StatusDescription
            }
        }
        Else
        {
                If($global:LastCacheDate -eq $null)
                {
                    $global:LastCacheDate = Get-date
                }

                $DateNow = Get-Date
                Write-verbose "Current Time: $DateNow"
                Write-verbose "Last Cache Time: $LastCacheDate"
                $CacheDifference = (New-TimeSpan -Start $global:LastCacheDate -End $datenow).Minutes
                Write-Verbose "Cache threshold (minutes): $CacheMinutes"
                Write-verbose "Current Cache age (minutes): $CacheDifference"

                If ($CacheDifference -lt $CacheMinutes)
                {
                    Write-verbose "Data cache age: $CacheDifference, using cached data"
                    $global:resultcache.$outputvalue
                }
                Else
                {
                    Write-verbose "Data cache age: $CacheDifference, updating data"
                    Try{
                        $global:resultcache = @(Invoke-RestMethod -Uri $Uri -Method $method -TimeoutSec $global:Timeout -UserAgent $global:UserAgent -Body $body) 
                        If ($global:resultcache.query_status -eq "ok")
                        {
                            $global:LastCacheDate = Get-date

                            If($Endpoint -eq "URL")
                            {
                                $global:resultcache
                            }
                            Else
                            {
                                $global:resultcache.$outputvalue
                            }
                        }
                        Elseif($global:resultcache.querystatus -eq "no_results")
                        {
                            Write-Warning "The query yield no results"
                            break
                        }
                        Else
                        {
                            Write-Error "unknown response"
                            break
                        }
                    }
                    Catch{
                        Write-error "StatusCode:" $_.Exception.Response.StatusCode.value__ 
                        Write-error "StatusDescription:" $_.Exception.Response.StatusDescription
                    }
                }
        }
}
End{
    $global:lastoutputvaluename = $outputvalue
}
}


