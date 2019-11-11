####################################################################################
#v1.0 Author Yoichi Hirotake
#Example script on how toImportImage into Content Library. Pls change the code based on your environment. 
#This code is NOT supported by Qlik.
####################################################################################

$hdrs = @{}
$hdrs.Add("X-Qlik-Xrfkey","examplexrfkey123")
$hdrs.Add("X-Qlik-User", "UserDirectory=Domain;UserId=Administrator") #Pleae use service account which run Qlik Sense services
$hdrs.Add("Content-Type", "image/png") #Please change Content-Type if necessary
$SourceImagePath = "c:\bk\QlikLogo.png" #Image what you want to import
$LibraryName = "MyLibrary" #Content Libary Name to store
$Externalpath = "QlikLogo1.png" #Image after the import
$xrfkey="examplexrfkey123"


$cert = Get-ChildItem -Path "Cert:\CurrentUser\My" | Where {$_.Subject -like '*QlikClient*'}
#$cert
$Data = Get-Content C:\ProgramData\Qlik\Sense\Host.cfg
$FQDN = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($($Data)))

$Import = Invoke-RestMethod -Uri "https://$($FQDN):4242/qrs/ContentLibrary/$($LibraryName)/uploadfile?externalpath=$($Externalpath)&overwrite=true&xrfkey=$($xrfkey)" -Method POST -Headers $hdrs -InFile $SourceImagePath -Certificate $cert
$Import
$return = $Import | Out-String | Out-File $output

