//
//  File.swift
//  uitest
//
//  Created by Vaidik Dubey on 11/03/24.
import SwiftUI

struct PrivacySettingsView: View {
    @State private var isNotificationPrivacyOpened = false
    @State private var notificationPrivacySetting = NotificationPrivacySetting.DisplayNameAndMessage
    
    var body: some View {
        VStack {
            Form{
                
                
                Section(header: Text("General")) {
                    Toggle("Notification", isOn: $isNotificationPrivacyOpened.animation())
                    if isNotificationPrivacyOpened {
                        Picker("Notification Privacy Setting", selection: $notificationPrivacySetting) {
                            Text("Display Name And Message").tag(NotificationPrivacySetting.DisplayNameAndMessage)
                            Text("Display Only Name").tag(NotificationPrivacySetting.DisplayOnlyName)
                            Text("Display Only Placeholder").tag(NotificationPrivacySetting.DisplayOnlyPlaceholder)
                        }
                        
                    }
                    
                    // Other privacy settings UI components can be added here
                }
            }
        }
        .navigationBarTitle("Privacy Settings")
        .onAppear {
            //HelperTools.defaultsDB().set(true, forKey: "HasSeenPrivacySettings")
        }
        .onDisappear {
            saveNotificationPrivacySetting()
        }
    }
    
    private func saveNotificationPrivacySetting() {
        UserDefaults.standard.set(notificationPrivacySetting.rawValue, forKey: "NotificationPrivacySetting")
    }
}

enum NotificationPrivacySetting: Int {
    case DisplayNameAndMessage
    case DisplayOnlyName
    case DisplayOnlyPlaceholder
}


struct PrivacySettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PrivacySettingsView()
        }
    }
}
