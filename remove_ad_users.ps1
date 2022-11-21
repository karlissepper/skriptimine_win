#Kustutab sisestatud kasutaja
Echo "Sisesta eesnimi"
$eesnimi=Read-Host
Echo "Sisesta oma perekonnanimi"
$perenimi=Read-Host
    #username is firstname.lastname
    $username = $eesnimi + "." + $perenimi
    $username = $username.ToLower()
    $username = Translit($username)
    Remove-ADUser $username
$ErrorActionPreference = "SilentlyContinue"
if(!$?)
{
echo "User doen't exist or a problem occured during deletion"
}
else
{
echo "User $username removed succsesfully"
}
$ErrorActionPreference = "Stop"
#function translit UTF-8 characters to LATIN
function Translit {
    #function use as parameter string to translit
    param(
    [string] $inputString
    )
    #define the characters which have to be translited
    $Translit = @{
    [char]'ä' = "a"
    [char]'ö' = "o"
    [char]'ü' = "u"
    [char]'õ' = "o"
    }
    #create translited output
    $outputString=""
    #transfer string to array of characters and by character
    foreach ($character in $inputCharacter = $inputString.ToCharArray())
    {
        #if character exists in list of characters for transliting
        if ($Translit[$character] -cne $Null ){
            #add to output translited character
            $outputString += $Translit[$character]
        }
        else {
            #otherwise add the initial haracter
            $outputString += $character
        }
    }
    Write-Output $outputString
}