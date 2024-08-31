$SJIS = [Text.Encoding]::GetEncoding("Shift-JIS")
#  -Encoding UTF8   or   -Encoding $SJIS

$j = 0; Get-Content original.csv -Encoding UTF8 -ReadCount 3000000 | % { $_ -join "`n" | Out-File "original_$j.csv" -Encoding UTF8 -NoNewline; $j++ }
