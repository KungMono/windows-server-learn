#$mykey = "YOUR_API_KEY"
#$mysymbol = "GGM"
$mysimulation = 10
#$mydividend = 0.1813

$file = (iwr "https://raw.githubusercontent.com/lgreski/pokemonData/master/Pokemon.csv").content | Convertfrom-Csv

$pokemon1 = 1..$mysimulation | % {
    $file | Get-Random
    Write-Progress -Activity "Simulation in Progress"  -PercentComplete ($_ / $mysimulation*100);
} | select @{Name='ID1'; Expression={$_.ID}} , @{N='Name1'; E={$_.Name}}, @{N=’ATK1’; E={$_.attack}}, @{N=’DEF1’; E={$_.defense}};



$pokemon2 = 1..$mysimulation | ForEach-Object {
    $file | Get-Random
    Write-Progress -Activity "Simulation in Progress"  -PercentComplete ($_ / $mysimulation*100);
} | select @{N='ID2'; E={$_.ID}} , @{N='Name2'; E={$_.Name}}, @{N=’ATK2’; E={$_.attack}}, @{N=’DEF2’; E={$_.defense}};



$pokemon1 | ft
$pokemon2 | ft



$combine = $pokemon1 | ForEach-Object -Begin {$i = 0} {  
    $_ | Add-Member NoteProperty -Name 'ID2' -Value $pokemon2[$i].id2 -PassThru -Force |
         Add-Member NoteProperty -Name 'Name2' -Value $pokemon2[$i].name2 -PassThru -Force |
         Add-Member NoteProperty -Name 'ATK2' -Value $pokemon2[$i].atk2 -PassThru -Force |
         Add-Member NoteProperty -Name 'DEF2' -Value $pokemon2[$i].def2 -PassThru -Force 
    Write-Progress -Activity "Combine in Progress"  -PercentComplete ($i / $mysimulation*100);
    $i++
}

$combine | ft

@{N=’Mon_diff’; E={ [math]::Abs([math]::Round(((NEW-TIMESPAN –Start $_.time1 –End $_.time2).Days)/30 ))}},
@{N=’Dividend’; E={ [math]::Abs([math]::Round(((NEW-TIMESPAN –Start $_.time1 –End $_.time2).Days)/30 ))*$mydividend}},
@{N=’P/L’; E={ 
if ($_.time1 -gt $_.time2) {[math]::Round(($_.price1 - $_.price2),2)}
else {[math]::Round(($_.price2 - $_.price1),2)}
}} | Export-Csv -Path combine.csv
