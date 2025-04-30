import Foundation

class Commande {
    static func afficherAide(ombreRevelee: Bool,coutureFaite: Bool,combatAutorise: Bool,combatFini: Bool,dansRepaire: Bool) {
        if !ombreRevelee {
            print("Commandes disponibles :\n- ouvrir tiroir\n- quitter")
        } else if coutureFaite && !combatAutorise && !dansRepaire {
            print("Commandes disponibles :\n- voler\n- quitter")
        } else if combatAutorise && !combatFini {
            print("Commandes disponibles :\n- combattre\n- quitter")
        } else if dansRepaire {
            print("Commandes disponibles :\n- examiner [objet]\n- quitter")
        } else {
            print("Commandes disponibles :\n- examiner [objet]\n- utiliser [objet]\n- combiner [objet1] avec [objet2]\n- quitter")
        }
    }

    static func commandeInvalide() {
        print("Commande inconnue. Tapez 'aide' pour voir les commandes disponibles.")
    }
}
