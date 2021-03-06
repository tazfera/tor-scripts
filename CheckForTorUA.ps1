Set-Variable -Name loglocation -Value "C:\inetpub\logs\LogFiles\"

$DateToCompare = (Get-Date).AddDays(-1)
$Date = (Get-Date).AddDays(0)

 foreach ($file in Get-ChildItem -Recurse -Path $loglocation | where {!$_.PsIsContainer})
          {
		    if ($file.lastwritetime -gt $DateToCompare -and $file.lastwritetime -lt $Date)
			  {
                  import-csv -Delimiter " " -Header "date","time","sip","csmethod","csuristem","csuriquery","sport","csusername","cip","csUserAgent","scstatus","scsubstatus","scwin32status","timetaken" -Path $file.fullname | where { !($_.Date.StartsWith('#')) -and $_.csUserAgent -eq "Mozilla/5.0+(Windows+NT+6.1;+rv:24.0)+Gecko/20100101+Firefox/24.0" }

              }
          }