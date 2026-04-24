//
//  challenge2App.swift
//  challenge2
//
//  Created by 태원진 on 4/14/26.
//

import SwiftUI
import SwiftData

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
        .modelContainer(for: Club.self)
//        .modelContainer(previewContainer) /// 이거 더미데이터 넣어서 시연용. contentview 122line 수정.

    }
}
