$SJIS = [Text.Encoding]::GetEncoding("Shift-JIS")
#  -Encoding UTF8   or   -Encoding $SJIS

# head
Get-Content -TotalCount 5 -Path .\original.csv -Encoding $SJIS

# tail
Get-Content -Tail 5 -Path .\original.csv -Encoding $SJIS
