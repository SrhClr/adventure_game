import Foundation

// MARK: - État du jeu
struct EtatJeu: Codable {
    var salleActuelle: String
    var inventaire: [String]
    var enigmeResolue: Bool
    var ombreRevelee: Bool
    var introTerminee: Bool
    var coutureFaite: Bool
    var combatAutorise: Bool
    var combatEnCours: Bool
    var combatFini: Bool

    var score: Int
    var vies: Int
    var chronoDebut: Date?
    var chronoActif: Bool

}

// MARK: - Gestion de la sauvegarde
class GestionSauvegarde {

    // Fonction qui retourne dynamiquement l’URL du fichier de sauvegarde
    static func getSauvegardeURL() -> URL {
        let fileManager = FileManager.default
        let dossier = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return dossier.appendingPathComponent("sauvegarde.json")
    }

    // Sauvegarde de l'état actuel du jeu
    static func sauvegarder(_ etat: EtatJeu) {
        let url = getSauvegardeURL()
        do {
            let data = try JSONEncoder().encode(etat)
            try data.write(to: url)
            print("✅ Sauvegarde effectuée.")
        } catch {
            print("❌ Échec de la sauvegarde : \(error)")
        }
    }

    // Chargement de la sauvegarde existante, si disponible
    static func charger() -> EtatJeu? {
        let url = getSauvegardeURL()
        do {
            let data = try Data(contentsOf: url)
            let etat = try JSONDecoder().decode(EtatJeu.self, from: data)
            print("🔄 Sauvegarde chargée.")
            return etat
        } catch {
            print("⚠️ Aucune sauvegarde trouvée ou erreur : \(error)")
            return nil
        }
    }

    // Suppression de la sauvegarde
    static func supprimerSauvegarde() {
        let url = getSauvegardeURL()
        do {
            try FileManager.default.removeItem(at: url)
            print("🗑️ Ancienne sauvegarde supprimée.")
        } catch {
            print("❌ Impossible de supprimer la sauvegarde : \(error)")
        }
    }
}
