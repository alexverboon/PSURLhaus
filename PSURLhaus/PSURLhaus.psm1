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

.PARAMETER Url
Retrieve a list of recent URLs (recent additions made to URLhaus), 
Detailed information about the response data can be found here: https://urlhaus-api.abuse.ch/#urls-recent

.PARAMETER Payload

 Retrieve a list of recent payloads (recent payloads seen by URLhaus), 
 Detailed information about the response data can be found here: https://urlhaus-api.abuse.ch/#payloads-recent

.PARAMETER MD5

 Use with parameter Payload. The MD5 hash of the payload (malware sample) you want to query URLhaus for
 Detailed information about the response data can be found herE: https://urlhaus-api.abuse.ch/#payloadinfo

 .PARAMETER SHA256

 Use with parameter Payload. The SHA256 hash of the payload (malware sample) you want to query URLhaus for
 Detailed information about the response data can be found herE: https://urlhaus-api.abuse.ch/#payloadinfo

 .PARAMETER URLINFO

 The URL to check against the URLhaus database. 

 Retrieves information about an URL
 Detailed information about the response data can be found here: https://urlhaus-api.abuse.ch/#urlinfo

.PARAMETER Hostname

  The host (IPv4 address, hostname or domain name) to query aainst the URLhaus database
  Detailed information about the response data can be found here: https://urlhaus-api.abuse.ch/#hostinfo

.PARAMETER CacheMinutes

 Use with parameter URL or Payload.  To prevent unecessary stress for the online URLhaus API, this parameter
 defines the time previously retrieved data from the same API endpoint remains cached
 utnil the data is fetched from the live API again. Th default is 15 minutes. If you do not wish to 
 use the cache use th -NoCache option

 Note: this current version will only use the cache when retrieving data from the same endpoint, when using another endpoint, the cache is deleted and the data
 is fetched from th API again. Examples:

  Get-URLhausdata -URL
  Get-URLHausdata -URL (uses the cache)
  Get-URLHausData -Payload
  Get-URLhausdata -URL (the cache now contains the payload data, so URL data must be fetched online again)

.PARAMETER NoCache
 
 Use this switch to send every request to the online API, otherwise previously retrieved data within 
 the current session is used for 15 minutes (default) or as long as specified by the CacheMinutes parameter. 

.NOTES
    v0.1.0, 22.03.2020, Alex Verboon
    v0.2.0, 24.03.2020, Alex Verboon, fixed a condition where the function would not work properly when invoking 
                                      the script in a foreach loop. 
                                      fixed cmdlet help
    v0.3.0, 08.04.2020, Alex Verboon, minor fixes
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

   Retrieves the most recent (1000) Payload additions made to URLhaus

.EXAMPLE 

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

    Get-UrlHausData -Payload -SHA256 "01fa56184fcaa42b6ee1882787a34098c79898c182814774fd81dc18a6af0b00" 

    query_status     : ok
    md5_hash         : 12c8aec5766ac3e6f26f2505e2f4a8f2
    sha256_hash      : 01fa56184fcaa42b6ee1882787a34098c79898c182814774fd81dc18a6af0b00
    file_type        : doc
    file_size        : 174928
    signature        : Heodo
    firstseen        : 2019-01-19 01:27:04
    lastseen         : 2019-01-19 02:11:26
    url_count        : 138
    urlhaus_download : https://urlhaus-api.abuse.ch/v1/download/01fa56184fcaa42b6ee1882787a34098c79898c18281477
                       4fd81dc18a6af0b00/
    virustotal       : 
    imphash          : 
    ssdeep           : 
    tlsh             : 
    urls             : {@{url_id=105822; url=http://nouslesentrepreneurs.fr/yIwTQ-iTd_eumU-vL/COMET/SIGNS/PAYME

    The above command retrieves payload information based on the specified SHA256 hash value


.EXAMPLE

    Get-UrlHausData -Hostname vektorex.com 

    query_status      : ok
    urlhaus_reference : https://urlhaus.abuse.ch/host/vektorex.com/
    host              : vektorex.com
    firstseen         : 2019-01-15 07:09:01 UTC
    url_count         : 124
    blacklists        : @{spamhaus_dbl=not listed; surbl=not listed}
    urls              : {@{id=124617; urlhaus_reference=https://urlhaus.abuse.ch/url/124617/; 
                        url=http://vektorex.com/jobs/cgi/86010322.jpg; url_status=offline; 
                        date_added=2019-02-14 18:02:23 UTC; threat=malware_download; reporter=JayTHL; 
                        larted=true; takedown_time_seconds=46393; tags=System.Object[]}, @{id=124195; 
                        urlhaus_reference=https://urlhaus.abuse.ch/url/124195/; 
                        url=http://vektorex.com/jobs/cgi/25061013.png; url_status=offline; 
                        date_added=2019-02-14 06:39:08 UTC; threat=malware_download; reporter=abuse_ch; 
                        larted=true; takedown_time_seconds=1681; tags=System.Object[]}, @{id=123432; 
                        urlhaus_reference=https://urlhaus.abuse.ch/url/123432/; 
                        url=http://vektorex.com/jobs/cgi/File_54115.png; url_status=offline; 
                        date_added=2019-02-13 13:11:25 UTC; threat=malware_download; reporter=abuse_ch; 
                        larted=true; takedown_time_seconds=150389; tags=System.Object[]}, @{id=121476; 
                        urlhaus_reference=https://urlhaus.abuse.ch/url/121476/; 
                        url=http://vektorex.com/source/Z/10874000.exe; url_status=offline; 
                        date_added=2019-02-11 11:00:07 UTC; threat=malware_download; reporter=oppimaniac; 
                        larted=true; takedown_time_seconds=14832; tags=System.Object[]}...}
#>

  [CmdletBinding()]
  Param(
    # lists Recently added URLs
    [Parameter(Mandatory=$true,
                   ParameterSetName='URL',
                   Position=0)]
    [switch]$URL,

    # lists Recently added Payloads
    [Parameter(Mandatory=$true,
                   ParameterSetName='Payload',
                   Position=0)]
    [switch]$Payload,

    # The MD5 hash of the payload
    [Parameter(Mandatory=$false,
                   ParameterSetName='Payload',
                   Position=0)]
    [ValidateNotNull()]
    [string]$MD5,
    # The sha256 hash of the payload
    [Parameter(Mandatory=$false,
                   ParameterSetName='Payload',
                   Position=0)]
    [ValidateNotNull()]
    [string]$SHA256,
    
    # The URL to lookup for information
    [Parameter(Mandatory=$true,
                   ParameterSetName='URLINFO',
                   Position=0)]
    [ValidateNotNull()]
    [string]$URLINFO,

    # the Hostname to lookup for Information
    [Parameter(Mandatory=$true,
                   ParameterSetName='Hostname',
                   Position=0)]
    [ValidateNotNull()]
    [string]$Hostname,
    
    # Number of minutes to use the cached content before getting live API data
    [Parameter(Mandatory=$false,
                   Position=0)]
    [int]$CacheMinutes,
    # Ignore Cache, allways pull live API data
    [Parameter(Mandatory=$false,
                   Position=0)]
    [switch]$NoCache
  )

Begin{

        # Set default caching time for API calls
        If(-not($CacheMinutes))
        {
            $CacheMinutes = 15
        }


        If ($PSBoundParameters.Keys.Contains("URL"))
        {
            write-verbose "URL parameter selected"
            $Endpoint = "urls/recent/"
            $outputvalue = "urls"
            $method = "Get"
        }
        Elseif($PSBoundParameters.Keys.Contains("Payload"))
        {
            If($PSBoundParameters.Keys.Contains("MD5"))
            {
                write-verbose "Payload parameter with MD5 selected"
                $Endpoint = "payload"
                $outputvalue = "" # not required
                $method = "Post"
                $body = @{md5_hash = $MD5}
                $NoCache = $true
            }
            Elseif($PSBoundParameters.Keys.Contains("SHA256"))
            {
                write-verbose "Payload parameter with SHA256 selected"
                $Endpoint = "payload"
                $outputvalue = "" # not required
                $method = "Post"
                $body = @{sha256_hash = $SHA256}
                $NoCache = $true
            
            }
            Else{
                write-verbose "Payload parameter selected"
                $Endpoint = "payloads/recent"
                $outputvalue = "payloads"
                $method = "Get"
            }
        }

        ElseIf($PSBoundParameters.Keys.Contains("URLINFO"))
        {
            write-verbose "URL Info parameter selected"
            $Endpoint = "url"
            $outputvalue = 'urlinfo'
            $method = "Post"
            $body = @{url = $URLINFO}
            $NoCache = $true
        }
        ElseIf($PSBoundParameters.Keys.Contains("Hostname"))
        {
            write-verbose "Host Info parameter selected"
            $Endpoint = "host"
            $outputvalue = 'host'
            $method = "Post"
            $body = @{host = $hostname}
            $NoCache = $true
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
            Write-Verbose "Clearing cache data"
            Remove-Variable -Name LastCacheDate -Scope Global -ErrorAction SilentlyContinue
            Remove-Variable -Name resultcache -Scope Global -ErrorAction SilentlyContinue

            Write-verbose "Not using cache retrieving live data"
            Try{
                $global:resultcache = @(Invoke-RestMethod -Uri $Uri -Method $method -TimeoutSec $global:Timeout -UserAgent $global:UserAgent -Body $body) 
                If ($global:resultcache.query_status -eq "ok")
                {
                    $global:LastCacheDate = Get-date
                    If($Endpoint -eq "URL" -or $Endpoint -eq "Host" -or $Endpoint -eq "payload")
                    {
                        $global:resultcache
                    }
                    Else
                    {
                        $global:resultcache.$outputvalue
                    }
                }
                Elseif($global:resultcache.query_status -eq "no_results")
                    {
                        Write-Warning "The query yield no results"
                        #break
                    }
                    Elseif($global:resultcache.query_status -eq "invalid_sha256_hash")
                    {
                        Write-Warning "invalid sha256 hash"
                        #Break
                    }
                    Else
                    {
                        Write-Error "unknown response"
                        #break
                    }
             }
            
            Catch{
                Write-error "StatusCode:" $_.Exception.Response.StatusCode.value__ 
                Write-error "StatusDescription:" $_.Exception.Response.StatusDescription
            }
        }
        Else
        {

                If($null -eq $global:LastCacheDate)
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
                    If($Endpoint -eq "URL" -or $Endpoint -eq "Host" -or $Endpoint -eq "payload")
                    {
                        $global:resultcache
                    }
                    Else
                    {
                        $global:resultcache.$outputvalue
                    }
                }
                Else
                {
                    Write-verbose "Data cache age: $CacheDifference, updating data"
                    Try{
                        $global:resultcache = @(Invoke-RestMethod -Uri $Uri -Method $method -TimeoutSec $global:Timeout -UserAgent $global:UserAgent -Body $body) 
                        If ($global:resultcache.query_status -eq "ok")
                        {
                            $global:LastCacheDate = Get-date

                            If($Endpoint -eq "URL" -or $Endpoint -eq "Host" -or $Endpoint -eq "payload")
                            {
                                $global:resultcache
                            }
                            Else
                            {
                                $global:resultcache.$outputvalue
                            }
                        }
                        Elseif($global:resultcache.query_status -eq "no_results")
                        {
                            Write-Warning "The query yield no results"
                            #break
                        }
                        Elseif($global:resultcache.query_status -eq "invalid_sha256_hash")
                        {
                            Write-Warning "invalid sha256 hash"
                            #Break
                        }
                        Else
                        {

                            Write-Error "unknown response"
                            #break
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


