import Foundation

struct Club: Identifiable {
    let id = UUID()
    var clubName: String
    var clubTime: String
    var clubPlace: String
    var clubDescription: String
    var clubOwner: String
    var maxMembers: Int
    var members: [String]
    var imageName: String
}
