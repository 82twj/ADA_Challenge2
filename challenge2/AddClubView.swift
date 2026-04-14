//
//  AddClubView.swift
//  challenge1
//
//  Created by 태원진 on 4/1/26.
//

import SwiftUI


struct AddClubView: View {
    @Binding var clubdata: [Club]
    @AppStorage("currentUserName") private var currentUserName = ""
    @Environment(\.dismiss) private var dismiss
    @State private var clubName = ""
    @State private var clubTime = ""
    @State private var clubPlace = ""
    @State private var clubDescription = ""
    @State private var maxMembers = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("동아리 이름", text: $clubName)
                TextField("시간 (Ex. 매주 토요일 11시)", text: $clubTime)
                TextField("장소 (Ex. 체육관)", text: $clubPlace)
                TextField("설명(간략하게 모임을 소개해 주세요!)", text: $clubDescription)
                TextField("최대 인원(1명이상)", text: $maxMembers)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("동아리 개설")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("개설") {
                        let trimmedClubName = clubName.trimmingCharacters(in: .whitespacesAndNewlines)
                        let trimmedClubTime = clubTime.trimmingCharacters(in: .whitespacesAndNewlines)
                        let trimmedClubPlace = clubPlace.trimmingCharacters(in: .whitespacesAndNewlines)
                        let trimmedClubDescription = clubDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                        let trimmedClubOwner = currentUserName.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        if trimmedClubName.isEmpty || trimmedClubTime.isEmpty || trimmedClubPlace.isEmpty || trimmedClubDescription.isEmpty || trimmedClubOwner.isEmpty || maxMembers.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            alertMessage = "모든 항목을 입력해주세요."
                            showAlert = true
                        } else if let maxMemberCount = Int(maxMembers), maxMemberCount > 0 {
                            let newClub = Club(
                                clubName: trimmedClubName,
                                clubTime: trimmedClubTime,
                                clubPlace: trimmedClubPlace,
                                clubDescription: trimmedClubDescription,
                                clubOwner: trimmedClubOwner,
                                maxMembers: maxMemberCount,
                                members: [],
                                imageName: "person.3.fill"
                            )
                            clubdata.append(newClub)
                            dismiss()
                        } else {
                            alertMessage = "최대 인원은 1 이상의 숫자로 입력해주세요."
                            showAlert = true
                        }
                    }
                    .bold()
                    .foregroundStyle(.blue)
                }
            }
            .alert("알림", isPresented: $showAlert) {
                Button("확인", role: .cancel) {
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    AddClubView(clubdata: .constant([]))
}
