//
//  challenge2App.swift
//  challenge2
//
//  Created by 태원진 on 4/14/26.
//

import SwiftUI

@main
struct challenge2App: App {
    @AppStorage("currentUserName") private var currentUserName = ""

    var body: some Scene {
        WindowGroup {
            if currentUserName.isEmpty {
                NicknameSetupView()
            } else {
                ContentView()
            }
        }
    }
}
