#  defineerime vajalikud käsurea parameetrid
if($args.Count -ne 3 ){
   #Kui edastatud parameetrite arv ei ole kolm
   #siis trükime kastutusjuhendi
   echo './Skriptinimi kasutajanimi "Ees Perenimi" "Konto kirjeldus"'
}
else {
#defineerimie muutujad argumentide salvestamiseks
$Kasutajanimi = $args[0]
$TaisNimi = $args[1]
$KonotKirjeldus = $args[2]
# Loome kasutajale parooli
$KasutajaParool = ConvertTo-SecureString "Parool1!" -AsPlainText -Force
#lisame kasutaja vastavate andmetega
New-LocalUser "$Kasutajanimi" -Password $KasutajaParool -FullName $TaisNimi -Description $KonotKirjeldus
}