//
//  NicknameSetupView.swift
//  challenge1
//
//  Created by 태원진 on 4/1/26.
//

import SwiftUI

struct NicknameSetupView: View {
    @AppStorage("currentUserName") private var currentUserName = ""
    @State private var nickname = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    private var isValidKoreanNickname: Bool {
        nickname.range(of: "^[가-힣]+$", options: .regularExpression) != nil
    }

    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 40)
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 95, weight: .light))
                    .foregroundStyle(.gray)
                    .opacity(0.7)
                    .padding(.bottom, 10)
                
                Text("닉네임 설정")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 10)
                
                Text("모임에서 사용할 이름을 입력해주세요.")
                    .padding(.bottom, 72)
                
                VStack(alignment: .leading, spacing: 14) {
                    TextField("닉네임을 입력해주세요.", text: $nickname)
                    Divider()
                    Text("1자 이상, 한글 닉네임")
                        .font(.caption)
                }
                .padding(.horizontal ,32)
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            if nickname.isEmpty {
                                alertMessage = "닉네임을 입력해주세요."
                                showAlert = true
                            } else if !isValidKoreanNickname {
                                alertMessage = "닉네임은 공백 없이 한글만 입력할 수 있습니다."
                                showAlert = true
                            } else {
                                currentUserName = nickname
                            }
                        } label: {
                            Text("시작하기")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .buttonStyle(.plain)
                    }
                }
                Spacer()
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
    NicknameSetupView()
}
