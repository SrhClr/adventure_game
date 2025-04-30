import Foundation

struct Salle: Codable {
    let nom: String
    let description: String
    var objets: [String]
    var chemins: [String: String]

}
