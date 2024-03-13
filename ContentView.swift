//
//  ContentView.swift
//  uitest
//
//  Created by Vaidik Dubey on 09/12/23.
//

import SwiftUI

enum NotificationPrivacySettingOption: Int, CaseIterable 
{
    case displayNameAndMessage = 1
    case displayOnlyName = 2
    case displayOnlyPlaceholder = 3
}

struct ContentView: View 
{
    @AppStorage("NotificationPrivacySetting") private var notificationPrivacySetting: NotificationPrivacySettingOption = .displayNameAndMessage
    
    
   
    var body: some View 
    {
        NavigationView {
            Form {
                Section(header: Text("Notification Settings")) 
                {
                    Picker("Notification Privacy Setting", selection: $notificationPrivacySetting) {
                        Text("Display Name And Message").tag(NotificationPrivacySettingOption.displayNameAndMessage)
                        Text("Display Only Name").tag(NotificationPrivacySettingOption.displayOnlyName)
                        Text("Display Only Placeholder").tag(NotificationPrivacySettingOption.displayOnlyPlaceholder)
                    }
                    
                    NavigationLink(destination: firstscreen())
                    {
                        Text("Privacy & Security")
                        
                    }
                    NavigationLink(destination: secondscreen())
                    {
                        Text("Interactions settings")
                        
                    }
                    NavigationLink(destination: thirdscreen())
                    {
                        Text("Location & Sharing")
                        
                    }
                    NavigationLink(destination: fourthscreen())
                    {
                        Text("Communications")
                        
                    }
                }
            }
            .navigationTitle("Privacy Settings")
            .onAppear {
                UserDefaults.standard.set(true, forKey: "HasSeenPrivacySettings")
            }
        }
    }
    
    private func getNotificationPrivacyOption(_ option: NotificationPrivacySettingOption) -> String 
    {
        switch option 
        {
        case .displayNameAndMessage:
            return NSLocalizedString("Display name And Message", comment: "")
        case .displayOnlyName:
            return NSLocalizedString("Display Only Name", comment: "")
        case .displayOnlyPlaceholder:
            return NSLocalizedString("Display Only Placeholder", comment: "")
        }
    }
}

struct firstscreen: View
{
    @AppStorage("OMEMODefaultOn") private var oMEMODefaultOn = false
    @AppStorage("AutodeleteAllMessagesAfter3Days") private var autodeleteAllMessagesAfter3Days = false
    var body: some View
    {
        Form
        {
            Section(header: Text("Privacy & security"))
            {
                Toggle("Enable encryption by default for new chats", isOn:$oMEMODefaultOn)
                Toggle("Autodelete all messages after 3 days", isOn: $autodeleteAllMessagesAfter3Days)
                
            }
        }
    }
}

struct secondscreen: View
{
    @AppStorage("SendLastUserInteraction") private var sendLastUserInteraction = false
    @AppStorage("SendLastChatState") private var sendLastChatState = false
    @AppStorage("SendReceivedMarkers") private var sendReceivedMarkers = false
    @AppStorage("SendDisplayedMarkers") private var sendDisplayedMarkers = false
    var body: some View
    {
        Form
        {
            
            Section(header: Text("Interaction Settings"))
            {
                Toggle("Send Last Interaction Time", isOn: $sendLastUserInteraction)
                Toggle("Send Typing Notifications", isOn: $sendLastChatState)
                Toggle("Send message received state", isOn: $sendReceivedMarkers)
                Toggle("Sync Read-Markers", isOn: $sendDisplayedMarkers)
                
            }
            
        }
    }
}

struct thirdscreen: View{
    @AppStorage("ShowGeoLocation") private var showGeoLocation = false
    @AppStorage("ShowURLPreview") private var showURLPreview = false
    var body: some View{
        Form{
            
            Section(header: Text("Location & Sharing")){
                Toggle("Show Inline Geo Location", isOn: $showGeoLocation)
                
                Toggle("Show URL previews", isOn: $showURLPreview)
                
            }
            
        }
    }
}


struct fourthscreen: View{
    @AppStorage("webrtcAllowP2P") private var webrtcAllowP2P = false
    @AppStorage("webrtcUseFallbackTurn") private var webrtcUseFallbackTurn = false
    @AppStorage("allowVersionIQ") private var allowVersionIQ = false
    @AppStorage("allowNonRosterContacts") private var allowNonRosterContacts = false
    var body: some View{
       Form{
            
            Section(header: Text("Communication")){
                Toggle("Calls: Allow P2P sessions", isOn: $webrtcAllowP2P)
                Toggle("Calls: Allow TURN fallback to Monal-Servers", isOn: $webrtcUseFallbackTurn)
                Toggle("Allow approved contacts to query my Monal and iOS version", isOn: $allowVersionIQ)
               
                Toggle("Allow contacts not in my Contact list to contact me", isOn: $allowNonRosterContacts)
            
                
            }
            
        }
    }
}



struct ContentView_Previews: PreviewProvider 
{
    static var previews: some View
    {
        ContentView()
    }
}
