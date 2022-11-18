$FolderPath = dir -Directory -Path "<<FILEPATH>>" #-Recurse -Force
$Report = @()
Foreach ($Folder in $FolderPath) {
    $Acl = Get-Acl -Path $Folder.FullName
    foreach ($Access in $acl.Access)
        {
            $Properties = [ordered]@{'FolderName'=$Folder.FullName;'AD Group or User'=$Access.IdentityReference;'Permissions'=$Access.FileSystemRights;'ControlType'=$Access.AccessControlType;'Inherited'=$Access.IsInherited}
            $Report += New-Object -TypeName PSObject -Property $Properties
        }
}
$Report | export-csv acl-department.csv
