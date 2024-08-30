$SJIS = [Text.Encoding]::GetEncoding("Shift-JIS")
#  -Encoding UTF8   or   -Encoding $SJIS

$j = 0; Get-Content original.csv -Encoding $SJIS -ReadCount 7000000 | % { $_ | Out-File "./temp_$j.csv" -Encoding $SJIS -Append; $j++ }

Copy-Item ./temp_0.csv ./original_0.csv

for ($i = 1; $i -le $j; $i++) {
    Get-Content -Path ./original_0.csv -TotalCount 1 -Encoding $SJIS | Out-File -FilePath "./original_${i}.csv" -Append -Encoding $SJIS
    Get-Content -Path "./temp_${i}.csv" -Raw -Encoding $SJIS | Out-File -FilePath "./original_${i}.csv" -Append -Encoding $SJIS
}

Remove-Item ./temp_*.csv
