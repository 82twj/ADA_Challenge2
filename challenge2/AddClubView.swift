//
//  AddClubView.swift
//  challenge1
//
//  Created by 태원진 on 4/1/26.
//

import SwiftUI
import PhotosUI


struct AddClubView: View {
    @Binding var clubdata: [Club]
    @AppStorage("currentUserName") private var currentUserName = ""
    @Environment(\.dismiss) private var dismiss
    @State private var imageData: Data?
    @State private var newImage: PhotosPickerItem?
    
    @State private var clubName = ""
    @State private var clubTime = ""
    @State private var clubPlace = ""
    @State private var clubDescription = ""
    @State private var maxMembers = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 250)
                    .frame(maxWidth: 370)
                
                VStack(spacing: 12) {
                    photoPicker
                    Text("대표 이미지를 설정해주세요.")
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                        .bold()
                }
                .padding(.horizontal, 12)
                
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Text("이름")
                        .font(.title3)
                        .bold()
                    TextField("모임 이름을 입력해주세요.", text: $clubName)
                        .font(.body)
                        .padding(4)
                        .submitLabel(.search)
                    Divider()
                    Text("시간")
                        .font(.title3)
                        .bold()
                    TextField("모임 시간을 입력해주세요.", text: $clubTime)
                        .font(.body)
                        .padding(4)
                        .submitLabel(.search)
                    Divider()
                    Text("장소")
                        .font(.title3)
                        .bold()
                    TextField("모임 장소를 입력해주세요.", text: $clubPlace)
                        .font(.body)
                        .padding(4)
                        .submitLabel(.search)
                    Divider()
                    Text("최대 인원")
                        .font(.title3)
                        .bold()
                    TextField("모임 최대인원을 입력해주세요.", text: $maxMembers)
                        .keyboardType(.numberPad)
                        .font(.body)
                        .padding(4)
                        .submitLabel(.search)
                    Divider()
                    Text("모임 소개")
                        .font(.title3)
                        .bold()
                    TextField("모임을 간단히 소개해 주세요.", text: $clubDescription, axis: .vertical)
                        .frame(height: 80)
                        .font(.body)
                        .padding(4)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5...Int.max)
                        .submitLabel(.search)
                    Divider()
                    
                }
                .padding(.horizontal ,32)
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 16) {
                Divider()
                Button() {
                    let trimmedClubName = clubName.trimmingCharacters(in: .whitespacesAndNewlines)
                    let trimmedClubTime = clubTime.trimmingCharacters(in: .whitespacesAndNewlines)
                    let trimmedClubPlace = clubPlace.trimmingCharacters(in: .whitespacesAndNewlines)
                    let trimmedClubDescription = clubDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                    let trimmedClubOwner = currentUserName.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if trimmedClubName.isEmpty || trimmedClubTime.isEmpty || trimmedClubPlace.isEmpty || trimmedClubDescription.isEmpty || maxMembers.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        alertMessage = "모든 항목을 입력해주세요."
                        showAlert = true
                    } else if let maxMemberCount = Int(maxMembers), maxMemberCount > 0 {
                        alertMessage = "모임 개설이 완료되었습니다."
                        showAlert = true
                        let newClub = Club(
                            clubName: trimmedClubName,
                            clubTime: trimmedClubTime,
                            clubPlace: trimmedClubPlace,
                            clubDescription: trimmedClubDescription,
                            clubOwner: trimmedClubOwner,
                            maxMembers: maxMemberCount,
                            members: [],
                            clubImage: imageData
                        )
                        clubdata.append(newClub)
                        dismiss()
                    } else {
                        alertMessage = "최대 인원은 1 이상의 숫자로 입력해주세요."
                        showAlert = true
                    }
                    
                } label: {
                    Text("모임 만들기")
                        .font(.headline)
                        .frame(maxWidth: 300)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)
                .disabled(clubName.isEmpty || clubTime.isEmpty || clubPlace.isEmpty || maxMembers.isEmpty || clubDescription.isEmpty)
            }
            .background(Color(.systemBackground))
        }
        .alert("알림", isPresented: $showAlert) {
            Button("확인", role: .cancel) {
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    private var photoPicker: some View {
        PhotosPicker(selection: $newImage) {
            Group {
                if let imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .frame(maxWidth: 350)
                        .clipped()
                } else {
                    Image(systemName: "photo.badge.plus.fill")
                        .font(.largeTitle)
                        .frame(height: 200)
                        .frame(maxWidth: 350)
                        .background(Color(white: 0.8, opacity: 0.9))
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .onChange(of: newImage) {
            guard let newImage else { return }
            Task {
                imageData = try await newImage.loadTransferable(type: Data.self)
            }
        }
    }
}

#Preview {
    AddClubView(clubdata: .constant([]))
}
