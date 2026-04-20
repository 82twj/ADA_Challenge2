//
//  ClubData.swift
//  challenge1
//
//  Created by 태원진 on 4/7/26.
//

import Foundation
import UIKit

struct ClubData {
    var clubs: [Club] = [
        Club(
            clubName: "수영동아리",
            clubTime: "주말 10시",
            clubPlace: "포스플렉스",
            clubDescription: "주말에 함께 수영을 해요~",
            clubOwner: "목련",
            maxMembers: 3,
            members: ["빈", "케빈", "크리스"],
            clubImage: UIImage(named: "swim")?.jpegData(compressionQuality: 1.0)
        ),
        Club(
            clubName: "악기동아리",
            clubTime: "매주 수요일 20시",
            clubPlace: "누리랩",
            clubDescription: "수요일마다 악기를 배워봐요~",
            clubOwner: "케빈",
            maxMembers: 5,
            members: ["조이", "쿄조"],
            clubImage: UIImage(named: "piano")?.jpegData(compressionQuality: 1.0)
        ),
        Club(
            clubName: "테니스동아리",
            clubTime: "매주 금요일 06시",
            clubPlace: "테니스장",
            clubDescription: "금요일마다 테니스를 배워봐요~",
            clubOwner: "빈",
            maxMembers: 1,
            members: [],
            clubImage: UIImage(named: "tennis")?.jpegData(compressionQuality: 1.0)
        ),
        Club(
            clubName: "축구동아리",
            clubTime: "매일 22시",
            clubPlace: "축구장",
            clubDescription: "매일 축구를 배워봐요~",
            clubOwner: "쿄조",
            maxMembers: 10,
            members: ["케빈", "루크", "빈", "크리스", "앨리스", "봉가니", "스타크"],
            clubImage: UIImage(named: "soccer")?.jpegData(compressionQuality: 1.0)
        )
    ]
}
