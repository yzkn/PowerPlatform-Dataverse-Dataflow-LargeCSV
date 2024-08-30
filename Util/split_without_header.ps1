$SJIS = [Text.Encoding]::GetEncoding("Shift-JIS")
#  -Encoding UTF8   or   -Encoding $SJIS

$i = 0; Get-Content original.csv -Encoding UTF8 -ReadCount 3000000 | % { $_ | Out-File "original_$i.csv" -Encoding UTF8 -Append; $i++ }
