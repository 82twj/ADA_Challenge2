//
//  ClubDetailView.swift
//  challenge1
//
//  Created by 태원진 on 4/1/26.
//

import SwiftUI

struct ClubDetailView: View {
    @Binding var clubdata: Club
    @Environment(\.dismiss) private var dismiss
    @State private var resultMessage = ""
    @State private var showResultAlert = false
    @AppStorage("currentUserName") private var currentUserName = ""
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 16) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                }
                Spacer()
            }
            VStack(spacing: 10) {
                Image(systemName: clubdata.imageName)
                    .font(.system(size: 100))
                Text(clubdata.clubName)
                    .font(.largeTitle)
                    .bold()
            }
            Spacer()
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 100, height: 170)
                        .foregroundStyle(Color.white.opacity(0.7))
                    
                    VStack(alignment: .trailing, spacing: 8) {
                        Text("시간")
                        Text("장소")
                        Text("설명")
                        Text("개설자")
                        Text("현재 인원")
                    }
                    .bold()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 220, height: 170)
                        .foregroundStyle(Color.white.opacity(0.7))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(clubdata.clubTime)")
                        Text("\(clubdata.clubPlace)")
                        Text("\(clubdata.clubDescription)")
                        Text("\(clubdata.clubOwner)")
                        Text("\(clubdata.members.count) / \(clubdata.maxMembers)")
                    }
                    .font(.headline)
                }
            }
            Spacer()
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("신청자 목록")
                        .bold()
                    if clubdata.members.isEmpty {
                        Text("아직 신청한 사람이 없습니다.")
                            .foregroundStyle(.secondary)
                    } else {
                        VStack(spacing: 8) {
                            ForEach(clubdata.members, id: \.self) { member in
                                Text(member)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.white.opacity(0.7))
                                    )
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
            
            Button(clubdata.members.contains(currentUserName) && !currentUserName.isEmpty ? "취소하기" : "신청하기") {
                if clubdata.members.contains(currentUserName) && !currentUserName.isEmpty {
                    clubdata.members.removeAll { $0 == currentUserName }
                    resultMessage = "신청이 취소되었습니다."
                    showResultAlert = true
                } else {
                    if currentUserName == clubdata.clubOwner {
                        resultMessage = "개설자는 신청할 수 없습니다."
                    } else if clubdata.members.count >= clubdata.maxMembers {
                        resultMessage = "정원이 가득 차서 신청할 수 없습니다."
                    } else {
                        clubdata.members.append(currentUserName)
                        resultMessage = "신청이 완료되었습니다."
                    }
                    showResultAlert = true
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            
        }
        .padding()
        .alert("알림", isPresented: $showResultAlert) {
            Button("확인", role: .cancel) {
            }
        } message: {
            Text(resultMessage)
        }
        .background(Color(red: 0.833, green: 0.896, blue: 1.0).opacity(0.8))
    }
}

#Preview {
    ClubDetailView(
        clubdata: .constant(
            Club(
                clubName: "샘플 모임",
                clubTime: "매주 토요일 10:00",
                clubPlace: "커뮤니티 센터",
                clubDescription: "함께 운동하고 친목을 다져요.",
                clubOwner: "관리자",
                maxMembers: 10,
                members: ["유저1", "유저2"],
                imageName: "person.3.fill"
            )
        )
    )
}
