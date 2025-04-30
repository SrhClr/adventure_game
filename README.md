ADVENTURE_GAME
--------------

Installer Visual Studio (pas juste "Build Tools")
--------------

Télécharge depuis ici : https://visualstudio.microsoft.com/fr/visualstudio/

Choisis Visual Studio 2022 (Community suffit).

Pendant l'installation, coche les composants suivants dans le menu de droite :

Composants obligatoires :

Nom (en français)	Nom technique (ID)
Outils de build MSVC v143 - VS 2022 C++ x64/x86 (dernière version)	Microsoft.VisualStudio.Component.VC.Tools.x86.x64
Outils de build MSVC v143 - VS 2022 C++ ARM64/ARM64EC (dernière version)	Microsoft.VisualStudio.Component.VC.Tools.ARM64
SDK Windows 11 (10.0.22000.0)	Microsoft.VisualStudio.Component.Windows11SDK.22000

Installer Swift pour Windows
--------------

Va ici : https://swift.org/download/#releases

Télécharge la version Windows .exe (ex: swift-5.9.2-RELEASE-windows10.exe)

Installez-le normalement. À la fin, il ajoute Swift dans ton PATH automatiquement.

Installer les dépendances supplémentaires OBLIGATOIRE :
--------------

a. Python 3.9.x (vérifie si tu ne l'as pas déjà)
Télécharge ici : https://www.python.org/downloads/release/python-390/

Coche "Add Python to PATH" pendant l’installation !

b. Git pour Windows (vérifie aussi si tu ne l'as pas déjà)
Télécharge ici : https://gitforwindows.org/

Laisse les options par défaut.

Redémarre ton PC après toutes les installations.
--------------
Vérification
Ouvre un nouveau terminal PowerShell et tape :

swift --version
Tu dois voir quelque chose comme :

Swift version 5.9.2 (swift-5.9.2-RELEASE)
Target: x86_64-unknown-windows-msvc

Cloner le projet adventure_game
--------------

Depuis un terminal lancer la commande git 
git clone https://github.com/SrhClr/adventure_game.git

Compiler et lancer le jeu
--------------

Depuis un terminal, naviguer dans le répertoire /adventure_game 

Puis Compiler avec :

swift build 

Enfin lancer le jeu avec :

swift run 
