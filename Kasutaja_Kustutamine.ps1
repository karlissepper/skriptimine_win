# Kustutab kasutaja ees ja perenime järgi
Echo "Sisesta eesnimi"
$eesnimi=Read-Host
Echo "Sisesta oma perekonnanimi"
$perenimi=Read-Host
$kasutajanimi=$eesnimi.ToLower() + "." + $perenimi.ToLower()
$ErrorActionPreference = "SilentlyContinue"
Remove-LocalUser "$kasutajanimi"
if(!$?)
{
Echo "Viga! kontot ei eksisteeri."
}
else
{
Echo "Konto $kasutajanimi on kustutatud"
}
$ErrorActionPreference = "Stop"