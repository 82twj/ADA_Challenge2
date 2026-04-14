//
//  ContentView.swift
//  challenge1
//
//  Created by 태원진 on 3/31/26.
//

import SwiftUI

struct ContentView: View {
    @State private var clubdata = ClubData()
    @AppStorage("currentUserName") private var currentUserName = ""
    @State private var selectedClub: Club?
    @State private var showNicknameSheet = false
    @State private var didInitializeNicknameForThisLaunch = false
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "person.3.sequence.fill")
                        .foregroundStyle(.tint)
                        .symbolRenderingMode(.hierarchical)
                    
                    Text("모여랏!!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.blue)
                    Spacer()
                    NavigationLink(destination: AddClubView(clubdata: $clubdata.clubs)) {
                        Label("Make Group", systemImage: "plus")
                            .bold()
                    }
                }
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(clubdata.clubs) { club in
                            VStack(alignment: .center) {
                                Image(systemName: club.imageName)
                                    .font(.system(size: 70))
                                
                                Spacer()
                                Text(club.clubName)
                                    .font(.title)
                                    .bold()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundStyle(club.maxMembers <= club.members.count ? .gray : .blue)
                                    .opacity(0.3)
                                    .brightness(-0.1)
                            }
                            .onTapGesture {
                                selectedClub = club
                            }
                        }
                    }
                }
                
            }
            .padding()
            .sheet(item: $selectedClub) { selected in
                if let index = clubdata.clubs.firstIndex(where: { $0.id == selected.id}) {
                    ClubDetailView(clubdata: $clubdata.clubs[index])
                }
            }
            .onAppear {
                if !didInitializeNicknameForThisLaunch {
                    currentUserName = ""
                    showNicknameSheet = true
                    didInitializeNicknameForThisLaunch = true
                }
            }
            .sheet(isPresented: $showNicknameSheet) {
                NicknameSetupView()
                    .interactiveDismissDisabled()
            }
        }
    }
}


#Preview {
    ContentView()
}
