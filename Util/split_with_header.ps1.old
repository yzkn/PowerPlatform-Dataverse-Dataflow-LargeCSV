$Path = "./original.csv"
$countPerFile = 3000000

$csv = Import-Csv $Path -Encoding UTF8
$count_rows = Get-Content $Path | Measure-Object

for ($i = 0; $i -lt $count_rows.Count / $countPerFile; $i++) {
    $a = $i * $countPerFile
    $b = $i * $countPerFile + $countPerFile - 1
    $csv[$a..$b] | Export-Csv -NoTypeInformation "./original_${i}.csv" -Encoding UTF8
}
