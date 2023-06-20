```
https://pan-gp-client.s3.amazonaws.com/6.0.4-26/GlobalProtect64.msi
$migdir = "C:\TEMP\MigrationStore\$env:COMPUTERNAME"
$migdir
.\scanstate.exe $migdir /i:Config.xml /o /vsc /ue:$env:COMPUTERNAME\default* /uel:90 /listfiles:$migdir\FilesMigrated.log /l:$migdir\scan.log /progress:$migdir\scan_progress.log /efs:abort /c

Rename Computer
Connect to Internal WiFi
Join G08 Network
<<Do Not sign in as Affinity User>>
Login computer user local admin
USMT > LoadState /MU switch 

LoadState.exe /i:MigApp.xml /i:MigDocs.xml \server\share\migration\mystore
/progress:Progress.log /l:LoadState.log /mu:contoso\user1:fabrikam\user1
/mu:OldLocalUserName:NewDomain NewUserName

LoadState.exe /i:Config.xml C:\Temp\MigStore /progress:Progress.log /l:LoadState.log /mu:fpcahk\user1:g08\user1


$result = dir .\$Env:UserName -Recurse | Measure-Object -Property length -Sum -Maximum
$result.sum/1gb
$result.Maximum/1gb
```


# 4 Restore Profile
```
# Check USMT in D:\
# Remove Existing Profile First
$input_username = read-host
.\LoadState.exe /i:Config.xml C:\temp\MigrationStore\HK-C00000000361 /progress:Progress.log /l:LoadState.log /mu:fpcahk\$input_username:g08\$input_username
```
