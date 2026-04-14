//
//  NicknameSetupView.swift
//  challenge1
//
//  Created by 태원진 on 4/1/26.
//

import SwiftUI

struct NicknameSetupView: View {
    @AppStorage("currentUserName") private var currentUserName = ""
    @Environment(\.dismiss) private var dismiss
    @State private var nickname = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("닉네임 입력", text: $nickname)
            }
            .scrollContentBackground(.hidden)
            .background(Color(red: 0.833, green: 0.896, blue: 1.0)
                .opacity(0.4)
                .brightness(-0.1)
                .ignoresSafeArea()
            )
            .navigationTitle("닉네임 설정")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("확인") {
                        let trimmed = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty else { return }
                        currentUserName = trimmed
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NicknameSetupView()
}
