# Made by levithean
# That script only works with Steam.
# Maybe the Epic Games version can be released

class GTAScript {

    [string] $actuel
    [string] $modde
    [string] $legit

    GTAScript([string] $actuel) {

        $this.actuel = $actuel
        $this.modde = "$actuel M"
        $this.legit = "$actuel O"
    }

    [void] GTAExecute([string] $mode) {

        Write-Output "Verification de la version de votre GTA V..."
        Start-Sleep -Seconds 5

        switch ($mode) {

            'm' {

                if (Test-Path $this.modde) {

                    Write-Output "Changement vers la version moddee..."
                    Rename-Item -Path $this.actuel -NewName $this.legit
                    Rename-Item -Path $this.modde -NewName $this.actuel
                    Start-Sleep -Seconds 3

                    Write-Output "La version moddee a ete chargee avec succes !"

                } elseif(Test-Path $this.legit) {

                    Write-Output "Vous etes deja sur la version moddee !"
                }
            }

            'l' {
                
                if (Test-Path $this.legit) {

                    Write-Output "Changement vers la version legit..."
                    Rename-Item -Path $this.actuel -NewName $this.modde
                    Rename-Item -Path $this.legit -NewName $this.actuel
                    Start-Sleep -Seconds 3

                    Write-Output "La version legit a ete chargee avec succes !"

                } elseif(Test-Path $this.modde) {

                    Write-Output "Vous etes deja sur la version legit !"
                }
            }

            Default {

                Write-Output "Choix incorrect !"
            }
        }
    }
}

# GTA V current directory
$actuel = "C:\Program Files (x86)\Steam\steamapps\common\Grand Theft Auto V Enhanced"

# Call the class
$classe = [GTAScript]::new($actuel)

if (Test-Path $actuel) {

    # If GTA V isn't running
    if (-not (Get-Process "GTA5_Enhanced" -ErrorAction SilentlyContinue)) {

        # While the choice isn't 'm' or 'l'
        do {
            $choix = Read-Host "Choix du mode (M : modde | l : legit)"
            $classe.GTAExecute($choix)

        } while ($choix -ne 'm' -and $choix -ne 'l')

        # Start GTA V
        Start-Process "steam://rungameid/3240220"

    } else {

        # If GTA V is running
        Write-Output "GTA V est deja lance !"
    }

} else {

    # If GTA V isn't detected
    Write-Output "GTA V n'a pas encore ete detecte !"
}