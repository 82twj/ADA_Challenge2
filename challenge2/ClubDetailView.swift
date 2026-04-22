//
//  ClubDetailView.swift
//  challenge1
//
//  Created by 태원진 on 4/1/26.
//

import SwiftUI
import SwiftData

struct ClubDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var resultMessage = ""
    @State private var showResultAlert = false
    @State private var showAlert = false
    @State private var showDeleteAlert = false
    @State private var alertMessage = ""
    
    @Environment(\.modelContext) private var modelcontext
    
    @AppStorage("currentUserName") private var currentUserName = ""
    
    @Query var clubs: [Club]
    
    let club: Club
    
    private let columns = [
        GridItem(.flexible())]
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                ClubThumbnailView(imageData: club.clubImage)
                    .padding(.bottom, 10)
                
                VStack(alignment: .leading) {
                    Text("\(club.clubName)")
                        .padding(.bottom, 10)
                        .font(.system(size: 30, weight: .bold))
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("📆 \(club.clubTime)")
                        Text("📍 \(club.clubPlace)")
                        Text("👤 \(club.members.count)명 / \(club.maxMembers)명")
                    }
                }
                .padding(.leading, 4)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 430)
            .background(.white)

            VStack(alignment: .leading) {
                if !club.members.isEmpty {
                    Text("멤버 목록")
                        .padding(.leading, 26)
                        .font(.system(size: 18, weight: .bold))
                    
                    ScrollView(.horizontal) {
                        LazyVGrid(columns: columns, spacing: 16) {
                            HStack {
                                ForEach(club.members, id: \.self) { member in
                                    ClubUserPic()
                                }
                            }
                            .padding(.leading, 26)
                            .padding(.top, 1)
                        }
                    }
                } else {
                    Text("멤버 목록")
                        .font(.system(size: 18, weight: .bold))
                        .padding(.leading, 26)
                        .padding(.top)
                        .padding(.bottom, 6)
                    
                    Text("아직 참여자가 없습니다")
                        .font(.system(size: 14))
                        .foregroundStyle(.secondary)
                        .padding(.leading, 26)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 125)
            .background(.white)

            VStack(alignment: .leading) {
                Text("모임 소개")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.leading, 26)
                    .padding(.top)
                    .padding(.bottom, 6)
                
                ScrollView {
                    Text("\(club.clubDescription)")
                        .font(.system(size: 14))
                        .padding(.leading, 26)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 120)
            .background(.white)
        }
        .background(.gray.opacity(0.3))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("모임 개설")
                    .foregroundStyle(.blue)
                    .font(.headline)
                    .bold()
            }
            ToolbarItem(placement: .destructiveAction) {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .confirmationDialog("Delete Moment", isPresented: $showDeleteAlert) {
                    Button("네, 삭제하겠습니다.", role: .destructive) {
                        modelcontext.delete(club)
                        try? modelcontext.save()
                        dismiss()
                    }
                } message: {
                    Text("모임을 삭제하시면 영구적으로 삭제되며, 복구가 불가능합니다. 정말 삭제하시겠습니까?")
                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            VStack(spacing: 16) {
                Divider()
                Button() {
                    if club.members.contains(currentUserName) {
                        club.members.removeAll { $0 == currentUserName }
                        alertMessage = "모임 신청이 취소되었습니다."
                        showAlert = true
                    } else {
                        if currentUserName == club.clubOwner {
                            alertMessage = "개설자는 신청할 수 없습니다."
                        } else if club.members.count >= club.maxMembers {
                            alertMessage = "정원이 가득 차서 신청할 수 없습니다."
                        } else {
                            club.members.append(currentUserName)
                            alertMessage = "모임 신청이 완료되었습니다."
                        }
                        showAlert = true
                    }
                } label: {
                    if club.members.contains(currentUserName) {
                        Text("취소하기")
                            .font(.headline)
                            .frame(maxWidth: 300)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    } else {
                        Text("신청하기")
                            .font(.headline)
                            .frame(maxWidth: 300)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .buttonStyle(.plain)
            }
            .background(Color(.systemBackground))
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
    ClubDetailView(
        club: Club(
            clubName: "수영동아리",
            clubTime: "매주 수요일 10시",
            clubPlace: "포스플렉스",
            clubDescription: "주말에 함께 수영을 해요~",
            clubOwner: "목련",
            maxMembers: 4,
            members: ["빈", "케빈", "크리스", "루크"],
            clubImage: UIImage(named: "swim")?.jpegData(compressionQuality: 1.0),
        )
    )
}

#Preview("memebr zero") {
    ClubDetailView(
        club: Club(
            clubName: "수영동아리",
            clubTime: "매주 수요일 10시",
            clubPlace: "포스플렉스",
            clubDescription: "주말에 함께 수영을 해요~",
            clubOwner: "목련",
            maxMembers: 4,
            members: [],
            clubImage: UIImage(named: "swim")?.jpegData(compressionQuality: 1.0),
        )
    )
}
