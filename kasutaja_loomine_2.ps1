#  defineerime vajalikud käsurea parameetrid
$Fail = "C:\Users\Administrator\Documents\skriptimine\kasutajad.csv"
#Loeme failist sisu, info jagatakse ; järgi
$Kasutajad = Import-Csv $Fail -Encoding Default -Delimiter ";"
foreach ($kasutaja in $kasutajad)
{
#defineerimie muutujad argumentide salvestamiseks
$Kasutajanimi = $kasutaja.Kasutajanimi
$TaisNimi = $kasutaja.Taisnimi
$KonotKirjeldus = $kasutaja.KontoKirjeldus
$KasutajaParool = $kasutaja.Parool | ConvertTo-SecureString -AsPlainText -Force
#lisame kasutaja vastavate andmetega
New-LocalUser "$Kasutajanimi" -Password $KasutajaParool -FullName "$TaisNimi" -Description $KonotKirjeldus
}