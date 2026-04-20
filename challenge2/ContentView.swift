//
//  ContentView.swift
//  challenge1
//
//  Created by 태원진 on 3/31/26.
//

import SwiftUI

struct ContentView: View {
    @State private var clubdata = ClubData()
    @State private var selectedClub: Club?
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "person.3.fill")
                        .foregroundStyle(.tint)
                        .symbolRenderingMode(.hierarchical)
                    
                    Text("Acaemy GroupFinder")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.blue)
                    Spacer()
                    NavigationLink(destination: AddClubView(clubdata: $clubdata.clubs)) {
                        Label("", systemImage: "plus")
                            .bold()
                    }
                }
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(clubdata.clubs) { club in
                            VStack(alignment: .center) {
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
        }
    }
}


#Preview {
    ContentView()
}
