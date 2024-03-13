//
//  Wrapper privacy settings.swift
//  uitest
//
//  Created by Vaidik Dubey on 13/03/24.
//
//import SwiftUI
//
//struct WrapperPrivacySettingsView: View {
//    // Define @AppStorage properties
//    @AppStorage("ShowGeoLocation") private var showGeoLocation = false
//    @AppStorage("SendLastUserInteraction") private var sendLastUserInteraction = false
//    @AppStorage("SendLastChatState") private var sendLastChatState = false
//    // Define other @AppStorage properties
//    
//    var body: some View {
//        VStack {
//            // Your privacy settings UI components
//        }
//        .navigationBarTitle("Privacy Settings")
//        .onAppear {
//            HelperTools.defaultsDB().set(true, forKey: "HasSeenPrivacySettings")
//        }
//        .onChange(of: showGeoLocation) { newValue in
//            HelperTools.defaultsDB().set(newValue, forKey: "ShowGeoLocation")
//        }
//        .onChange(of: sendLastUserInteraction) { newValue in
//            HelperTools.defaultsDB().set(newValue, forKey: "SendLastUserInteraction")
//        }
//        .onChange(of: sendLastChatState) { newValue in
//            HelperTools.defaultsDB().set(newValue, forKey: "SendLastChatState")
//        }
//        // Add onChange for other @AppStorage properties
//    }
//}
//
