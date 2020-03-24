$file = get-content -LiteralPath C:\temp\urltst.txt

ForEach($u in $file)
{
    Write-Host $u -ForegroundColor Green
    Get-UrlHausData -URLINFO $U

}
