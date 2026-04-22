import Foundation
import SwiftData

@Model
class Club: Identifiable {
    let id = UUID()
    var clubName: String
    var clubTime: String
    var clubPlace: String
    var clubDescription: String
    var clubOwner: String
    var maxMembers: Int
    var members: [String]
    var clubImage: Data?
    
    init(
        clubName: String,
        clubTime: String,
        clubPlace: String,
        clubDescription: String,
        clubOwner: String,
        maxMembers: Int,
        members: [String],
        clubImage: Data?,
    ) {
        self.clubName = clubName
        self.clubTime = clubTime
        self.clubPlace = clubPlace
        self.clubDescription = clubDescription
        self.clubOwner = clubOwner
        self.maxMembers = maxMembers
        self.members = members
        self.clubImage = clubImage
    }
}
