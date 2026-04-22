//
//  ContentView.swift
//  challenge1
//
//  Created by 태원진 on 3/31/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var clubs: [Club]
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    HStack {
                        Image(systemName: "person.3.fill")
                            .font(.system(size: 23))
                            .foregroundStyle(.tint)
                            .symbolRenderingMode(.hierarchical)
                        
                        Text("Academy GroupFinder")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundStyle(.blue)
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    .padding(.top, 4)
                    .padding(.leading, 16)
                    
                    if clubs.isEmpty {
                        Spacer()
                        VStack(spacing: 16) {
                            Image(systemName: "bubble.left.and.bubble.right")
                                .font(.system(size: 50))
                                .foregroundStyle(.blue.opacity(0.8))
                            Text("아직 개설된 모임이 없어요")
                                .font(.system(size: 22, weight: .bold))
                            Text("첫 번째 모임을 만들어보세요.\n오른쪽 아래 + 버튼을 눌러 추가할 수 있어요.")
                                .font(.system(size: 15))
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                        }
                        .padding(.horizontal, 24)
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(clubs) { club in
                                    NavigationLink {
                                        ClubDetailView(club: club)
                                    } label: {
                                        ZStack(alignment: .bottomLeading) {
                                            ClubThumbnailView(imageData: club.clubImage)
                                                .frame(height: 180)
                                                .frame(width: 180)
                                            
                                            
                                            LinearGradient(
                                                colors: [
                                                    Color.black.opacity(0.95),
                                                    Color.black.opacity(0.4),
                                                    Color.clear
                                                ],
                                                startPoint: .bottom,
                                                endPoint: .top
                                            )
                                            
                                            
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(club.clubName)
                                                    .font(.system(size: 20, weight: .bold))
                                                
                                                if club.members.count > 2 {
                                                    Text("현재 \(club.members.count)명 참여🔥")
                                                        .font(.system(size: 12, weight: .bold))
                                                } else {
                                                    Text("현재 \(club.members.count)명 참여")
                                                        .font(.system(size: 12, weight: .bold))
                                                }
                                            }
                                            .foregroundStyle(.white)
                                            .padding(.leading, 18)
                                            .padding(.bottom, 14)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .frame(height: 180)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                NavigationLink(destination: AddClubView()) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 8)
                }
                .padding(.trailing, 10)
                .padding(.bottom, 10)
            }
        }
    }
}


//프리뷰를 위한 코드... 완성후 삭제
@MainActor
private var previewContainer: ModelContainer = {
    let container = try! ModelContainer(
        for: Club.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    for club in ClubData().clubs {
        container.mainContext.insert(club)
    }

    return container
}()

#Preview {
    ContentView()
        //프리뷰를 위한 코드... 완성 후 삭제
        .modelContainer(previewContainer)
}

#Preview("none") {
    ContentView()
        //프리뷰를 위한 코드... 완성 후 삭제
}
