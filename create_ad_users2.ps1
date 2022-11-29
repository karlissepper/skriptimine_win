# location of AD users file
$file = "C:\Users\Administrator\Documents\skriptimine\adkasutajad.csv"
# import file content
$users = Import-Csv $file -Encoding Default -Delimiter ";"
# foreach user data row in file
$ErrorActionPreference = "SilentlyContinue"
foreach ($user in $users){
    #username is firstname.lastname
    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    $username = Translit($username)
    $password = Get-RandomPassword(8)
    #user principal name
    $upname = $username + "@sv-kool.local"
    #display name = eesnimi + perenimi
    $displayname = $user.FirstName + " " + $user.LastName
    New-ADUser -Name $username -DisplayName $displayname -GivenName $user.FirstName -Surname $user.LastName -Department $user.Department -Title $user.Role -UserPrincipalName $upname -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true
if(!$?)
{
echo "User $username already exists - can not add this user"
}
else
{
echo "New user $username added succsesfully"
$username + ";" + $password | Out-File -Append -FilePath C:\Users\Administrator\Documents\skriptimine\kasutajanimi.csv
}
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
# See funkrisoon genereerib ette antud karakteritest suvalise määratud pikkusega parooli
function Get-RandomPassword {
    param (
        [Parameter(Mandatory)]
        [int] $length
    )
    $charSet = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.ToCharArray()
    $rng = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
    $bytes = New-Object byte[]($length)
 
    $rng.GetBytes($bytes)
 
    $result = New-Object char[]($length)
 
    for ($i = 0 ; $i -lt $length ; $i++) {
        $result[$i] = $charSet[$bytes[$i]%$charSet.Length]
    }
 
    return (-join $result)
}