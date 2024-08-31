$SJIS = [Text.Encoding]::GetEncoding("Shift-JIS")
#  -Encoding UTF8   or   -Encoding $SJIS

$j = 0; Get-Content original.csv -Encoding $SJIS -ReadCount 3 | % { $_ -join "`n" | Out-File "temp_$j.csv" -Encoding $SJIS -NoNewline; $j++ }

Copy-Item ./temp_0.csv ./original_0.csv

for ($i = 1; $i -lt $j; $i++) {
    Get-Content -Path ./original_0.csv -TotalCount 1 -Encoding $SJIS | Out-File -FilePath "./original_${i}.csv" -Append -Encoding $SJIS
    Get-Content -Path "./temp_${i}.csv" -Raw -Encoding $SJIS | Out-File -FilePath "./original_${i}.csv" -Append -NoNewline -Encoding $SJIS
}

Remove-Item ./temp_*.csv
