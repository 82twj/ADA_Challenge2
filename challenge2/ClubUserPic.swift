//
//  ClubUserPic.swift
//  challenge2
//
//  Created by 태원진 on 4/21/26.
//

import SwiftUI

struct ClubUserPic: View {
    private let userImages = [
        "user1",
        "user2",
        "user3",
        "user4",
        "user5",
        "user6",
    ]
    
    var body: some View {
        Image(userImages.randomElement() ?? "unknownUser")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ClubUserPic()
}
