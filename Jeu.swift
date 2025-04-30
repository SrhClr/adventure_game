import Foundation
import Dispatch

@MainActor
class Jeu {
    // MARK: - Propriétés
    var salles: [String: Salle] = [:]
    var salleActuelle: Salle?
    var objetsDisponibles: [String: Objet] = [:]
    var inventaire: [String] = []
    var etat: EtatJeu
    private var indicesTrouves: Set<String> = []
    var nomJoueur: String = ""


    // MARK: - Initialisation
    init() {
        etat = EtatJeu(
            salleActuelle: "Maison des Darling",
            inventaire: [],
            enigmeResolue: false,
            ombreRevelee: false,
            introTerminee: false,
            coutureFaite: false,
            combatAutorise: false,
            combatEnCours: false,
            combatFini: false,
            score: 0,
            vies: 3,
            chronoDebut: nil,
            chronoActif: false
        )

        chargerMonde()
        chargerObjets()

        if let sauvegarde = GestionSauvegarde.charger() {
            print("💾 Une sauvegarde a été trouvée.")
            print("1 - Continuer la partie")
            print("2 - Recommencer une nouvelle partie")
            print("> ", terminator: "")

            if let choix = readLine(), choix == "1" {
                etat = sauvegarde
                salleActuelle = salles[sauvegarde.salleActuelle]
                print("🔄 Sauvegarde chargée.")
            } else {
                GestionSauvegarde.supprimerSauvegarde()
                print("🔁 Nouvelle partie lancée.")
                proposerReglesEtIntro()
            }

        } else {
            print("🚀 Aucune sauvegarde trouvée. Nouvelle partie lancée.")
            proposerReglesEtIntro()
        }
    }
    
    // MARK: - Démarrage du jeu
    func jouer() {
        bouclePrincipale()
    }

    // MARK: - Démarrage du jeu
    func bouclePrincipale() {
        while true {
            print("\nQue voulez-vous faire ?")

            var actions: [String] = []

            if !etat.ombreRevelee {
                actions = ["Ouvrir le tiroir", "Quitter"]
            } else if etat.coutureFaite && !etat.combatFini {
                actions = ["Voler", "Quitter"]
            } else {
                actions = ["Quitter"]
            }

            afficherMenu(actions: actions)

            guard let input = readLine(), let choix = Int(input), choix > 0, choix <= actions.count else {
                print("❌ Entrée invalide.")
                continue
            }

            let actionChoisie = actions[choix - 1].lowercased()
            effacerEcran()

            switch actionChoisie {
            case "ouvrir le tiroir":
                ouvrirTiroir()

            case "voler":
                if etat.coutureFaite && !etat.combatFini {
                    Dialogue.sceneForet()
                    poserEnigmeForet()
                } else {
                    print("Vous ne pouvez pas encore voler.")
                }

            case "quitter":
                if gererQuitter() {
                    return
                }

            default:
                print("❌ Commande inconnue.")
            }
        }
    }

    /// Propose d’afficher les règles puis lance l’introduction
    func proposerReglesEtIntro() {
    print("\n📘 Voulez-vous lire les règles du jeu et les objectifs ?")
        
    let choixRegle = ["Oui, tout découvrir", "Non, commencer directement"]
    afficherMenu(actions: choixRegle)

    guard let entree = readLine(), let index = Int(entree), index > 0, index <= choixRegle.count else {
        print("❌ Choix invalide.")
        return proposerReglesEtIntro()
    }

    if index == 1 {
        Dialogue.afficherReglesEtObjectif()

        let choixSuite = ["Oui, entrez dans la légende", "Non, quitter le jeu"]
        afficherMenu(actions: choixSuite)

        guard let suite = readLine(), let suiteIndex = Int(suite) else {
            print("❌ Choix invalide.")
            return proposerReglesEtIntro()
        }

        if suiteIndex == 1 {
            demanderNomEtCommencer()
        } else {
            print("👋 À bientôt, aventurier. Le Pays Imaginaire attendra ton retour.")
            exit(0)
        }
    } else {
        // Même si le joueur saute les règles, on demande son nom aussi
        demanderNomEtCommencer()
    }
}
func demanderNomEtCommencer() {
    print("\n🎩 Quel est ton nom, aventurier ?")
    print("> ", terminator: "")

    if let saisieNom = readLine(), !saisieNom.trimmingCharacters(in: .whitespaces).isEmpty {
        nomJoueur = saisieNom
    } else {
        nomJoueur = "Aventurier"
    }

    effacerEcran()
    print("🌟 Bienvenue dans le monde de Peter Pan, \(nomJoueur) !\n")

    salleActuelle = salles["Maison des Darling"]
    lancerIntro()
}

func sceneLettreAvecCrochet() {
    effacerEcran()
    Dialogue.sceneReveilWendySurLeBateau()

    Dialogue.questionDormirCrochet(nomJoueur: nomJoueur)

    let choixReponse = ["Oui", "Non"]
    afficherMenu(actions: choixReponse)

    guard let reponse = readLine(), let choix = Int(reponse), choix > 0, choix <= choixReponse.count else {
        print("❌ Choix invalide.")
        return sceneLettreAvecCrochet()
    }

    if choix == 1 {
        Dialogue.reponseOuiDormir()
    } else {
        Dialogue.reponseNonDormir()
    }

    Thread.sleep(forTimeInterval: 0.5)

    var lettreValide = false

    while !lettreValide {
        print("\n✍️ Wendy prend la plume et commence sa lettre...")
        print("\n> ", terminator: "")

        guard let lettre = readLine(), !lettre.isEmpty else {
            print("❌ Ta lettre est vide, recommençons.")
            continue
        }

      
        let contientMorceauOuCarte = lettre.contains("morceau") || lettre.contains("carte")
        let contientBuisson = lettre.contains("buisson")

        if contientMorceauOuCarte && contientBuisson {
            lettreValide = true
            effacerEcran()
            print("\n📜 Voici la lettre de Wendy écrite à la plume :\n")
            ecrireStylise(lettre, intervalle: 30000)

            print("\nSouhaites-tu :")
            let choixApresLettre = ["Soumettre la lettre à Crochet", "Relire et corriger la lettre"]
            afficherMenu(actions: choixApresLettre)

            guard let reponseSuite = readLine(), let choixSuite = Int(reponseSuite), choixSuite > 0, choixSuite <= choixApresLettre.count else {
                print("❌ Choix invalide.")
                return
            }

            if choixSuite == 1 {
                Thread.sleep(forTimeInterval: 1.0)
                Dialogue.sceneCrochetRecupereLettre()
                etat.inventaire.append("lettre coupée")
                
                // Ensuite CHAÎNEMENT AUTOMATIQUE
                Thread.sleep(forTimeInterval: 2.0)
                Dialogue.sceneCaptureEnfantsEtWendy()
                Thread.sleep(forTimeInterval: 2.0)
                sceneCombatCarteFinaleTourParTour()

            } else {
                print("\n✍️ Très bien, recommençons la rédaction de ta lettre...\n")
                Thread.sleep(forTimeInterval: 0.5)
                lettreValide = false
            }
        } else {
            print("\n🔁 Ta lettre est incomplète. Merci de recommencer.\n")
        }

    }
}
    func sceneCaptureEtRetour() {
        effacerEcran()
        Dialogue.sceneCaptureEnfantsEtWendy()

        print("\n(Appuyez sur Entrée pour continuer)")
        _ = readLine()

        effacerEcran()
        Dialogue.sceneRetourPeterRepaire()

        print("\n(Appuyez sur Entrée pour foncer vers le Jolly Roger)")
        _ = readLine()

        // ⚓ Peter arrive au Jolly Roger → Lancement du combat
        effacerEcran()
        sceneCombatCarteFinaleTourParTour()
    }
func sceneCombatCarteFinaleTourParTour() {
    // Paramètres de la carte
    let mapWidth = 16
    var peterPos = 0
    var crochetPos = 13

    let peterEmoji = "🗡"
    let crochetEmoji = "🪝"
    let crocodileEmoji = "🐊"
    let emptyEmoji = "."

    var captureCrochet = false

    func drawLine() {
        var line = ""
        for x in 0..<mapWidth {
            if x == peterPos && x == crochetPos {
                line += "🛡️"  // Contact visuel
            } else if x == peterPos {
                line += peterEmoji
            } else if x == crochetPos {
                line += crochetEmoji
            } else if x == 3 {
                line += crocodileEmoji
            } else {
                line += emptyEmoji
            }
        }
        print(line)
    }

    func lancerDe() -> Int {
        return Int.random(in: 1...6)
    }

    func actionAleatoire() -> String {
        return Bool.random() ? "a" : "r"
    }

    // Boucle principale du jeu
    while true {
        effacerEcran()
        print("⊹ ࣪ ﹏𓊝﹏𓂁﹏⊹ ࣪ ˖\n")
        drawLine()

        // Tour de Crochet
        if !captureCrochet {
            print("\n🎲 Tour de Crochet...")
            let deCrochet = lancerDe()
            let actionCrochet = actionAleatoire()
            if actionCrochet == "a" {
                let avancePossible = crochetPos - 0
                let avance = min(deCrochet, avancePossible)
                crochetPos = max(0, crochetPos - avance)
                print("🪝 Crochet avance de \(avance) cases.")
            } else {
                let reculPossible = mapWidth - crochetPos - 1
                let recul = min(deCrochet, reculPossible)
                crochetPos = min(mapWidth - 1, crochetPos + recul)
                print("🪝 Crochet recule de \(recul) cases.")
            }
            Thread.sleep(forTimeInterval: 1.0)
        }

        effacerEcran()
        print("⊹ ࣪ ﹏𓊝﹏𓂁﹏⊹ ࣪ ˖\n")
        drawLine()

        // Tour de Peter
        print("\n🎲 À ton tour, Peter !")
        let dePeter = lancerDe()
        print("Tu as tiré : \(dePeter)")
        print("Veux-tu Avancer (A) ou Reculer (R) ?")
        print("> ", terminator: "")
        guard let input = readLine()?.lowercased(), ["a", "r"].contains(input) else { continue }

        if input == "a" {
            let avancePossible = crochetPos - peterPos
            let avance = min(dePeter, avancePossible)
            peterPos += avance
            print("🗡 Peter avance de \(avance) cases.")
        } else if input == "r" {
            let recul = min(dePeter, peterPos)
            peterPos -= recul
            print("🗡 Peter recule de \(recul) cases.")
        }

        Thread.sleep(forTimeInterval: 1.0)

        // Vérifier la capture
        if peterPos == crochetPos || peterPos == crochetPos + 1 {
            captureCrochet = true
            print("\n🛡️ Tu as capturé Crochet ! Maintenant, pousse-le jusqu'au crocodile 🐊 avec A et R.")
        }

        // Si Peter a dépassé Crochet sans capturer, interdiction
        if peterPos > crochetPos && !captureCrochet {
            print("\n❌ Tu as dépassé Crochet sans le capturer... Tu perds l'équilibre et tombes !")
            print("\n💀 GAME OVER")
            exit(0)
        }

        // Phase de poussée
        while captureCrochet {
            effacerEcran()
            print("⊹ ࣪ ﹏𓊝﹏𓂁﹏⊹ ࣪ ˖\n")
            drawLine()
            print("\nTu pousses Crochet :")
            print("(A pour avancer vers le crocodile, R pour reculer)")
            print("> ", terminator: "")
            guard let inputPoussee = readLine()?.lowercased(), ["a", "r"].contains(inputPoussee) else { continue }

            let dePoussee = lancerDe()
            print("\n🎲 Tu as tiré : \(dePoussee)")

            if inputPoussee == "a" {
                crochetPos = max(0, crochetPos - dePoussee)
                peterPos = max(0, peterPos - dePoussee)
                print("🛡️ Tu avances de \(dePoussee) cases avec Crochet.")
            } else if inputPoussee == "r" {
                let reculPossible = mapWidth - max(crochetPos, peterPos) - 1
                let recul = min(dePoussee, reculPossible)
                crochetPos += recul
                peterPos += recul
                print("🛡️ Tu recules de \(recul) cases avec Crochet.")
            }

            Thread.sleep(forTimeInterval: 1.0)

            // Vérifier victoire
            if crochetPos == 3 {
                effacerEcran()
                print("""
                🐊 Crochet tombe dans la gueule du crocodile !

                🏆 Victoire ! Le crocodile avale Crochet tout entier.

                🧒👧 Les Enfants Perdus et Wendy sont libérés du Jolly Roger !

                🎉 Tu as sauvé tout le Pays Imaginaire !
                """)
                return
            }
        }
    }
}


    // MARK: - Menus interactifs

    /// Affiche les règles du jeu et la grille de score
    func afficherRegles() {
        Dialogue.afficherReglesEtObjectif()
    }

    func afficherMenu(actions: [String]) {
        for (index, action) in actions.enumerated() {
            print("\(index + 1) - \(action)")
        }
        print("> ", terminator: "")
    }

    func gererQuitter() -> Bool {
        print("💾 Voulez-vous sauvegarder la partie avant de quitter ?")
        print("1 - Oui")
        print("2 - Non")
        print("> ", terminator: "")
        guard let choix = readLine() else {
            print("❌ Choix invalide.")
            return false
        }

        switch choix {
        case "1":
            if etat.vies <= 0 {
                Dialogue.sauvegardeImpossible()
                return false
            }
            GestionSauvegarde.sauvegarder(etat)
            Dialogue.finAvecSauvegarde()
            return true

        case "2":
            print("⚠️ Êtes-vous certain de vouloir quitter **sans sauvegarder** ?")
            print("1 - Oui, quitter sans sauvegarder")
            print("2 - Non, reprendre le jeu")
            print("> ", terminator: "")
            guard let confirmation = readLine() else {
                print("❌ Choix invalide.")
                return false
            }

            if confirmation == "1" {
                Dialogue.finSansSauvegarde()
                return true
            } else {
                Dialogue.retourJeu()
                return false
            }

        default:
            Dialogue.choixInvalideRetourJeu()
            return false
        }
    }
    
    /// Gère l’ajustement du score et les conséquences sur les vies
    func ajusterScore(_ points: Int) {
        let ancienneValeur = etat.score
        etat.score += points
        
        // Affichage du score
        let signe = points >= 0 ? "+" : "-"
        print("🎯 Score \(signe)\(abs(points)) → Total : \(etat.score)")

        // Calcul du nombre de vies gagnées ou perdues
        let vieEnPoints = 8

        let anciennesVies = ancienneValeur / vieEnPoints
        let nouvellesVies = etat.score / vieEnPoints

        let ecart = nouvellesVies - anciennesVies

        if ecart > 0 {
            etat.vies += ecart
            print("🩷 Bravo ! Vous avez gagné \(ecart) vie(s). Vies restantes : \(etat.vies)")
        } else if ecart < 0 {
            etat.vies += ecart
            print("💔 Vous avez perdu \(-ecart) vie(s). Vies restantes : \(etat.vies)")

            // 🛑 Attention : on ne redémarre le jeu QUE si le joueur n’a PLUS AUCUNE vie
            if etat.vies <= 0 {
                Dialogue.scenePerteTotale()

                // Réinitialisation complète
                etat = EtatJeu(
                    salleActuelle: "Maison des Darling",
                    inventaire: [],
                    enigmeResolue: false,
                    ombreRevelee: false,
                    introTerminee: false,
                    coutureFaite: false,
                    combatAutorise: false,
                    combatEnCours: false,
                    combatFini: false,
                    score: 0,
                    vies: 3,
                    chronoDebut: nil,
                    chronoActif: false
                )
                salleActuelle = salles["Maison des Darling"]
                GestionSauvegarde.supprimerSauvegarde()
                lancerIntro()
                jouer()
            }
        }
    }

    // MARK: - Fonctions utilitaires

    func afficherTempsRestant(chronoDebut: Date?, dureeTotale: Int) -> String {
        guard let debut = chronoDebut else { return "" }
        let ecoule = Int(Date().timeIntervalSince(debut))
        let restant = max(dureeTotale - ecoule, 0)
        let minutes = restant / 60
        let secondes = restant % 60
        return String(format: "\n⏳ Temps restant : %02d:%02d", minutes, secondes)
    }

    // MARK: - Scènes et dialogues
    func lancerIntro() {
        Dialogue.sceneIntro()
        poserEnigmeInitiale()
    }

    func poserEnigmeInitiale() {
        Dialogue.sceneEnigmeWendy()
        while true {
            guard let reponse = readLine()?.lowercased() else { continue }
            if reponse == "b" {
                print("Wendy : ...Le temps ? C’est la bonne réponse. Très bien. Voici la clé.")
                etat.inventaire.append("clé")
                etat.enigmeResolue = true
                etat.introTerminee = true
                ajusterScore(2)
                break
            } else {
                print("Wendy : Mauvaise réponse. Réfléchis encore.")
                ajusterScore(-2) // ❌ Mauvaise réponse
            }
        }
    }

    func poserEnigmeForet() {
        Dialogue.sceneEnigmeForet()
        while true {
            guard let reponse = readLine()?.lowercased() else { continue }
            if reponse == "b" {
                Dialogue.sceneCombat()
                etat.combatFini = true
                etat.combatEnCours = false
                etat.combatAutorise = false
                ajusterScore(2) // bonne réponse
                salleActuelle = salles["Repaire des Enfants Perdus"]
                ajouterObjetDansRepaire()
                salleActuelle = salles["Repaire des Enfants Perdus"]
                Dialogue.sceneRepaire()
                phaseExplorationRepaire()

                break
            } else {
                print("Chef : Faux. Réfléchis mieux.")
                ajusterScore(-2) // ❌ Mauvaise réponse
            }
        }
    }

    func enigmeHorloge() {
        let actions = ["Examiner l’horloge", "Observer les alentours"]
        effacerEcran()
        afficherMenu(actions: actions)

        guard let input = readLine(), let choix = Int(input), choix > 0, choix <= actions.count else {
            print("❌ Choix invalide.")
            return enigmeHorloge()
        }

        switch choix {
        case 1:
            boucleEnigmeHorloge()
        case 2:
                Dialogue.sceneHorlogeNon()
                enigmeHorloge()
        
        default:
        print("❌ Choix non reconnu.")
        enigmeHorloge()
        }
    }  

    func boucleEnigmeHorloge() {
        var observationFaite = false

        while true {
            let actions = observationFaite ? ["Placer les aiguilles", "Quitter le jeu"] : ["Continuer", "Quitter le jeu"]
            afficherMenu(actions: actions)

            guard let input = readLine(), let choix = Int(input), choix > 0, choix <= actions.count else {
                print("❌ Entrée invalide.")
                continue
            }

            let actionChoisie = actions[choix - 1].lowercased()

            switch actionChoisie {
            case "continuer":
                observationFaite = true
                Dialogue.enigmeHorloge()

            case "placer les aiguilles":
                print("🕰️ À quelle heure souhaitez-vous placer les aiguilles ? (ex : 3h45)")
                print("> ", terminator: "")
                if let reponse = readLine()?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
                    if reponse == "3h45" || reponse == "03h45" {
                        Dialogue.trappeOuverte()
                        ajusterScore(4)

                        // ⏱️ Chrono déclenché ici
                        let debut = Date()
                        let tempsLimite = 180
                        print("\n⏳ Chronomètre lancé : Vous avez 3 minutes pour sauver les Enfants Perdus !")

                        // Lancer la suite
                        lancerDefiBombe(debutChrono: debut, tempsLimite: tempsLimite)
                        return
                    } else {
                        print("❌ Les aiguilles tremblent… mais rien ne se passe. Ce n’est pas la bonne heure.")
                        ajusterScore(-1)
                        print("\nSouhaitez-vous demander de l’aide ?")
                        afficherMenu(actions: ["Oui", "Non"])
                        if let choixAide = readLine(), choixAide == "1" {
                            print("""
                            🃏 Un opérateur mathématique est à appliquer entre les deux parties de l’énigme…

                            Peut-être que la clé réside dans une addition ?
                            """)
                        } else {
                            print("🔁 Très bien, continuez votre réflexion.")
                        }
                    }
                }

            case "quitter le jeu":
                if gererQuitter() { exit(0) }

            default:
                print("❌ Choix non reconnu.")
            }
        }
    }

    
   func lancerDefiBombe(debutChrono: Date, tempsLimite: Int) {
        Dialogue.sceneCrochetPiege()

        let reponseCorrecte = 4
        var tentativesRestantes = 3
        var trouve = false

        // OBSERVER
        while tentativesRestantes > 0 {
            let ecoule = Int(Date().timeIntervalSince(debutChrono))
            let restant = max(0, tempsLimite - ecoule)
            print(String(format: "\n⏳ Temps restant : %02d:%02d", restant / 60, restant % 60))

            if restant <= 0 {
                Dialogue.echecDefiBombe()
                ajusterScore(-8)
                return
            }

            print("\nSouhaitez-vous observer les enfants avant de choisir ?")
            afficherMenu(actions: ["Oui", "Non"])
            guard let choixObs = readLine(), choixObs == "1" else {
                print("Très bien, vous faites votre choix directement.")
                break
            }

            Dialogue.observerEnfants()
            break
        }

        // ESSAIS
        while tentativesRestantes > 0 {
            let ecoule = Int(Date().timeIntervalSince(debutChrono))
            let restant = max(0, tempsLimite - ecoule)
            print(String(format: "\n⏳ Temps restant : %02d:%02d", restant / 60, restant % 60))

            if restant <= 0 {
                Dialogue.echecDefiBombe()
                ajusterScore(-8)
                return
            }

            print("\nEntrez un chiffre entre 1 et 5 pour tenter de désamorcer la bombe :")
            print("Essais restants : \(tentativesRestantes)")
            print("> ", terminator: "")

            if let entree = readLine(), let essai = Int(entree), (1...5).contains(essai) {
                if essai == reponseCorrecte {
                    Dialogue.reussiteDefiBombe()
                    ajusterScore(4)
                    trouve = true

                    Dialogue.sceneRetourAuRepaire()
                    sceneVersLaguneDesSirènes()

                    return
                } else {
                    print("❌ Ce n’est pas le bon enfant.")
                    tentativesRestantes -= 1
                }
            } else {
                print("❌ Entrée invalide. Veuillez entrer un chiffre entre 1 et 5.")
            }
        }

        // ECHEC PAR TENTATIVES
        if !trouve {
            Dialogue.echecDefiBombe()
            ajusterScore(-8)
        }
    }
    func lancerJeuDesPerles() {
        effacerEcran()
        Dialogue.sceneJeuDesPerles()
        print("\n(Appuyez sur Entrée pour commencer la démonstration)")
        _ = readLine()

        let couleurs = ["🔴", "🔵", "🟢", "🟡", "🟣", "🟠", "⚪", "⚫"]
        let sequence = couleurs.shuffled().prefix(6).map { $0 }

        // 👁️ Affichage dynamique une par une avec pause automatique
        for couleur in sequence {
            effacerEcran()
            print("🎁 Une perle apparaît : \(couleur)")
            Thread.sleep(forTimeInterval: 2)
        }

        effacerEcran()

        // 🎮 Interface de sélection
        print("🔁 Reconstitue maintenant l’ordre des perles en tapant les chiffres correspondants.\n")
        for (index, couleur) in couleurs.enumerated() {
            print("\(index + 1) - \(couleur)")
        }

        print("\n> Tape l'ordre des perles (ex: 2 5 3 6 1 4 7 8)")
        print("> ", terminator: "")
        guard let reponse = readLine() else {
            print("❌ Entrée invalide.")
            return
        }

        let indices = reponse.split(separator: " ").compactMap { Int($0) }
        let reponseJoueur = indices.map { index -> String in
            if index >= 1 && index <= couleurs.count {
                return couleurs[index - 1]
            } else {
                return ""
            }
        }

        if reponseJoueur == sequence {
            ajusterScore(4)
            Dialogue.reussiteJeuDesPerles()
            salleActuelle = salles["Île aux Fées"]
            Dialogue.sceneIleAuxFees()
            sceneDialogueMousse()

        } else {
            ajusterScore(-2)
            Dialogue.echecJeuDesPerles()
            salleActuelle = salles["Lagune des Sirènes"]
            lancerJeuDesPerles()

        }
    }
    func sceneIleAuxFees() {
        effacerEcran()
        Dialogue.sceneIleAuxFees()
        // ensuite on passera vers le Jolly Roger (à développer)
    }

    func sceneDialogueMousse() {
    effacerEcran()
    Dialogue.sceneArriveeJollyRoger()

    print("> ", terminator: "")
    guard let nomEntre = readLine(), !nomEntre.isEmpty else {
        print("❌ Je n’ai pas bien compris ton nom.")
        return sceneDialogueMousse()
    }

    if nomEntre.lowercased() != "wendy" {
        print("🧔‍♂️ Ravi de te rencontrer, \(nomEntre).")
    } else {
        print("🧔‍♂️ Ah, \(nomEntre). Un joli nom.")
    }
    Dialogue.scenePremiereDialogueMousse()
    let choix = ["Faire la visite", "Aller se coucher"]
    afficherMenu(actions: choix)

    if let reponse = readLine() {
        switch reponse {
        case "1":
            visiteBateauAvecMousse()

        case "2":
            print("🛏️ Wendy monte lentement dans la cabine, le cœur toujours troublé...")
            // tu pourras enchaîner ici avec la scène du lendemain

        default:
            print("❌ Choix invalide.")
            sceneDialogueMousse()
        }
    }
}

   func visiteBateauAvecMousse() {
    effacerEcran()
    Dialogue.sceneVisiteMousse()

    var reponseValide = false

    while !reponseValide {
        print("> ", terminator: "")
        guard let phrase = readLine()?.lowercased(), !phrase.isEmpty else {
            print("❌ Je n’ai pas bien entendu. Peux-tu répéter ?")
            continue
        }

        switch true {
        case phrase.contains("peter") && phrase.contains("aimé"):
            Dialogue.moussePeterAime()
        case phrase.contains("peter"):
            Dialogue.moussePeterSimple()
        case phrase.contains("je suis triste"):
            Dialogue.mousseTriste()
        case phrase.contains("je ne suis pas triste"), phrase.contains("c'est rien"), phrase.contains("je n'ai rien"):
            Dialogue.mousseRien()
        case phrase.contains("rentrer"):
            Dialogue.mousseRentrer()
        case phrase.contains("perdue"):
            Dialogue.moussePerdue()
        case phrase.contains("j'ai mal"):
            Dialogue.mousseMal()
        case phrase.contains("la vie est dure"):
            Dialogue.mousseVieDure()
        case phrase.contains("pas de coeur"), (phrase.contains("les hommes") && phrase.contains("coeur")):
            Dialogue.moussePasDeCoeur()
        case phrase.contains("je l'aime"):
            Dialogue.mousseAimeEncore()
        case phrase.contains("je l'aimais"):
            Dialogue.mousseAimait()
        case phrase.contains("j'y ai cru"):
            Dialogue.mousseJaiCru()
        default:
            Dialogue.mousseComprendPas()
            print("\n1 - Répéter")
            print("2 - Monter dans la chambre")
            print("> ", terminator: "")
            if let choix = readLine(), choix == "2" {
                Dialogue.mousseConclusionRespectueuse()
                print("🛏️ Wendy monte lentement dans la cabine, le cœur encore alourdi…")
                return
            } else {
                continue
            }
        }

        // Tour 2 – Wendy peut répondre encore une fois
        print("\n🧔‍♂️ Et maintenant que tu l’as dit... qu’est-ce que tu ressens vraiment ?")
        print("> ", terminator: "")
        if let reponse2 = readLine()?.lowercased(), !reponse2.isEmpty {
            if reponse2.contains("merci") {
                Dialogue.mousseTour2Merci()
            } else if reponse2.contains("fatigue") || reponse2.contains("je suis fatiguée") {
                Dialogue.mousseTour2Fatigue()
            } else if reponse2.contains("oublier") || reponse2.contains("je veux oublier") {
                Dialogue.mousseTour2Oublier()
            } else {
                Dialogue.mousseTour2Silence()
            }
        }
        reponseValide = true
    }

    Dialogue.mousseConclusionRespectueuse()
    print("🛏️ Wendy monte lentement dans la cabine, le cœur encore alourdi…")
    sceneLettreAvecCrochet()
}

    // MARK: - Exploration et progression
    func phaseExplorationRepaire() {
        while true {
            guard let objets = salleActuelle?.objets, !objets.isEmpty else {
                print("Il n’y a rien à examiner ici.")
                return
            }

            print("\nQue voulez-vous faire ?")
            let actions = ["Examiner un objet", "Quitter"]
            afficherMenu(actions: actions)

            guard let choix = readLine(), let option = Int(choix), option > 0, option <= actions.count else {
                print("❌ Entrée invalide.")
                continue
            }

            switch option {
            case 1:
                print("\nQuels objets voulez-vous examiner ?")
                for (index, objet) in objets.enumerated() {
                    print("\(index + 1) - \(objet)")
                }
                print("> ", terminator: "")
                guard let selection = readLine(), let numero = Int(selection), numero > 0, numero <= objets.count else {
                    print("❌ Choix invalide.")
                    continue
                }
                let objetChoisi = objets[numero - 1]
                examinerObjet(nom: objetChoisi)

            case 2:
                if gererQuitter() {
                    exit(0)
                }

            default:
                print("❌ Choix non reconnu.")
            }
        }
    }

    func sceneVersLaguneDesSirènes() {
        effacerEcran()
        Dialogue.sceneForetVersLagune()

        print("\n(Appuyez sur Entrée pour continuer)")
        _ = readLine()

        lancerJeuDesPerles()
    }


    func ajouterObjetDansRepaire() {
        if var repaire = salles["Repaire des Enfants Perdus"] {
            repaire.objets = [
                "jouet cassé",
                "table renversée",
                "rideau déchiré",
                "couverture",
                "coffre entrouvert",
                "plume",
                "cigare",
                "hamacs"
            ]
            salles[repaire.nom] = repaire
        }
    }

    // MARK: - Interaction avec les objets
    func examinerObjet(nom: String) {
        let dansSalle = salleActuelle?.objets.contains(nom) ?? false
        let dansInventaire = etat.inventaire.contains(nom)

        guard dansSalle || dansInventaire else {
            print("Vous ne voyez pas cet objet ici.")
            return
        }

        if nom == "couverture" && !indicesTrouves.contains("bouteille") {
            Dialogue.sceneCouverture()
            indicesTrouves.insert("bouteille")
            if var salle = salleActuelle {
                salle.objets.append("bouteille en verre")
                salleActuelle = salle
                salles[salle.nom] = salle
            }

            print("Souhaitez-vous examiner la bouteille ?")
            print("1 - Oui")
            print("2 - Non")
            print("> ", terminator: "")
            if let choix = readLine(), choix == "1" {
                examinerObjet(nom: "bouteille en verre")
            }
            return
        }

        if nom == "bouteille en verre" && !indicesTrouves.contains("trace de sang") {
            Dialogue.sceneBouteille()
            indicesTrouves.insert("trace de sang")
            if var salle = salleActuelle {
                salle.objets.append("trace de sang")
                salleActuelle = salle
                salles[salle.nom] = salle
            }

            print("Souhaitez-vous examiner la trace de sang ?")
            print("1 - Oui")
            print("2 - Non")
            print("> ", terminator: "")
            if let choix = readLine(), choix == "1" {
                examinerObjet(nom: "trace de sang")
            }
            return
        }

        if nom == "trace de sang" && !indicesTrouves.contains("piste ouverte") {
            Dialogue.sceneTraceDeSang()
            print("Souhaitez-vous suivre les traces de sang ?\n1 - Oui\n2 - Non")
            print("> ", terminator: "")
            if let choix = readLine(), choix == "1" {
                indicesTrouves.insert("piste ouverte")
                ajusterScore(4) // ✅ Découverte d’indice
                if var salle = salleActuelle {
                    salle.chemins["nord-est"] = "Rocher du Crâne"
                    salles[salle.nom] = salle
                }

                salleActuelle = salles["Rocher du Crâne"]

                Dialogue.sceneRocher()
                enigmeHorloge()

                return
            }
        }
        if nom == "hamacs" {
           Dialogue.sceneHamacs()
            return
        }

        if let objet = objetsDisponibles[nom] {
            print("🔍 \(objet.description)")
        } else {
            print("Objet inconnu.")
        }
    }
    
    func ouvrirTiroir() {
        guard salleActuelle?.nom == "Maison des Darling" else {
            print("Il n’y a pas de tiroir ici.")
            return
        }
        if !etat.inventaire.contains("clé") {
            print("🔒 Le tiroir est verrouillé. Il vous faut une clé.")
            return
        }
        if etat.ombreRevelee {
            print("Le tiroir est déjà ouvert. L’ombre est là.")
            return
        }

        Dialogue.sceneTiroir()
        etat.ombreRevelee = true
        etat.coutureFaite = true
    }

    func utiliserObjet(nom: String) {
        guard etat.inventaire.contains(nom) else {
            print("Vous ne possédez pas cet objet.")
            return
        }

        guard let objet = objetsDisponibles[nom] else {
            print("Objet inconnu.")
            return
        }

        if objet.utilisable {
            print("✨ Vous utilisez l’objet : \(objet.nom).")

            if objet.nom == "clé", salleActuelle?.objets.contains("coffre") == true {
                print("🔓 Le coffre s’ouvre… à l’intérieur, un ancien parchemin plié.")
                if var salle = salleActuelle {
                    salle.objets.append("parchemin")
                    salles[salle.nom] = salle
                }
            }
        //REVOIR CETTE PARTIE PLUS TARD PAS BON
            if objet.nom == "carte complète" {
                Dialogue.sceneCarteComplete()
                if salles["Clairière du Rendez-vous"] == nil {
                    salles["Clairière du Rendez-vous"] = Salle(
                        nom: "Clairière du Rendez-vous",
                        description: "Une clairière secrète. C’est ici que Wendy attend, d’être retrouvée pour faire ses adieux et rentrer à la maison.",
                        objets: [],
                        chemins: ["ouest": "La Plage"]
                    )
                    print("📍 Une nouvelle destination a été révélée sur la carte : Clairière du Rendez-vous (depuis La Plage).")
                } else {
                    print("📍 La carte vous rappelle le chemin vers la Clairière du Rendez-vous.")
                }
            }
        } else {
            print("❌ Cet objet ne peut pas être utilisé de cette façon.")
        }
    }

    func combinerObjets(nom1: String, nom2: String) {
        guard etat.inventaire.contains(nom1), etat.inventaire.contains(nom2) else {
            print("Vous devez posséder les deux objets pour les combiner.")
            return
        }

        guard let objet1 = objetsDisponibles[nom1], let objet2 = objetsDisponibles[nom2] else {
            print("Un des objets est inconnu.")
            return
        }

        if objet1.combinaison == nom2 || objet2.combinaison == nom1 {
            print("🧩 Vous combinez \(nom1) avec \(nom2)...")
            let nouvelObjet = "carte complète"
            etat.inventaire.removeAll { $0 == nom1 || $0 == nom2 }
            etat.inventaire.append(nouvelObjet)
            print("🗺️ Vous avez obtenu : \(nouvelObjet) !")
        } else {
            print("❌ Ces objets ne peuvent pas être combinés ensemble.")
        }
    }

    // MARK: - Chargement des données
    func chargerMonde() {
        guard let url = Bundle.module.url(forResource: "monde", withExtension: "json") else {
            print("Fichier monde.json introuvable")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let monde = try JSONDecoder().decode([Salle].self, from: data)
            for salle in monde {
                salles[salle.nom] = salle
            }
        } catch {
            print("Erreur de chargement du monde: \(error)")
        }
    }

    func chargerObjets() {
        guard let url = Bundle.module.url(forResource: "Objets", withExtension: "json") else {
            print("Fichier objets.json introuvable.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let objets = try JSONDecoder().decode([Objet].self, from: data)
            for objet in objets {
                if objetsDisponibles[objet.nom] != nil {
                    print("⚠️ Objet dupliqué ignoré : \(objet.nom)")
                }
                objetsDisponibles[objet.nom] = objet
            }
        } catch {
            print("Erreur lors du chargement des objets : \(error)")
        }
    }
    // MARK: - Utilitaires

    /// Efface proprement l'écran du terminal
    func effacerEcran() {
        print("\u{001B}[2J")
        print("\u{001B}[H")
        fflush(stdout)
    }
    func effetReussite() {
        //print("🎉 Bravo ! Tu as réussi cette étape.\n")
        // Thread.sleep(forTimeInterval: 5) // ⏳ Pause de 3 secondes
        effacerEcran()
        print("🎉 Bravo ! Tu as réussi cette étape.\n")
    }

    func ecrireStylise(_ texte: String, intervalle: UInt32 = 30000) {
        let style = "\u{001B}[1m\u{001B}[34m"  // Bleu + Gras
        let reset = "\u{001B}[0m"

        for caractere in texte {
            print("\(style)\(caractere)\(reset)", terminator: "")
            fflush(stdout)
            Thread.sleep(forTimeInterval: Double(intervalle) / 1_000_000) // conversion en secondes
        }
        print("")
    }

     func enleverAccents(_ texte: String) -> String {
        return texte.folding(options: .diacriticInsensitive, locale: .current)
    }

}
