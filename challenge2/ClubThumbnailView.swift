//
//  ClubThumbnailView.swift
//  challenge2
//
//  Created by 태원진 on 4/21/26.
//

import SwiftUI

struct ClubThumbnailView: View {
    let imageData: Data?

    var body: some View {
        Group {
            if let imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.15))

                    Image(systemName: "photo.trianglebadge.exclamationmark")
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .frame(height: 240)
        .frame(width: 360)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ClubThumbnailView(
        imageData: ClubData().clubs.first?.clubImage
    )
}
