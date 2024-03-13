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

class AppStorageModel: ObservableObject 
{
   
    @AppStorage("OMEMODefaultOn")  var oMEMODefaultOn = false
    @AppStorage("AutodeleteAllMessagesAfter3Days")  var autodeleteAllMessagesAfter3Days = false
    
    @AppStorage("SendLastUserInteraction")  var sendLastUserInteraction = false
    @AppStorage("SendLastChatState")  var sendLastChatState = false
    @AppStorage("SendReceivedMarkers")  var sendReceivedMarkers = false
    @AppStorage("SendDisplayedMarkers")  var sendDisplayedMarkers = false
    
    @AppStorage("ShowGeoLocation") var showGeoLocation = false
    @AppStorage("ShowURLPreview")  var showURLPreview = false
    
    @AppStorage("webrtcAllowP2P")  var webrtcAllowP2P = false
    @AppStorage("webrtcUseFallbackTurn")  var webrtcUseFallbackTurn = false
    @AppStorage("allowVersionIQ")  var allowVersionIQ = false
    @AppStorage("allowNonRosterContacts")  var allowNonRosterContacts = false

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
                    
                    NavigationLink(destination: firstscreen(appStorageModel: AppStorageModel()))
                    {
                        Text("Privacy & Security")
                        
                    }
                    NavigationLink(destination: secondscreen(appStorageModel: AppStorageModel()))
                    {
                        Text("Interactions settings")
                        
                    }
                    NavigationLink(destination: thirdscreen(appStorageModel: AppStorageModel()))
                    {
                        Text("Location & Sharing")
                        
                    }
                    NavigationLink(destination: fourthscreen(appStorageModel: AppStorageModel()))
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
    @ObservedObject var appStorageModel: AppStorageModel
         var body: some View
    {
        Form
        {
            Section(header: Text("Privacy & security"))
            {
                Toggle("Enable encryption by default for new chats", isOn:$appStorageModel.oMEMODefaultOn)
                Toggle("Autodelete all messages after 3 days", isOn: $appStorageModel.autodeleteAllMessagesAfter3Days)
                
            }
        }
    }
}

struct secondscreen: View
{
    @ObservedObject var appStorageModel: AppStorageModel
   
    var body: some View
    {
        Form
        {
            
            Section(header: Text("Interaction Settings"))
            {
                Toggle("Send Last Interaction Time", isOn: $appStorageModel.sendLastUserInteraction)
                Toggle("Send Typing Notifications", isOn: $appStorageModel.sendLastChatState)
                Toggle("Send message received state", isOn: $appStorageModel.sendReceivedMarkers)
                Toggle("Sync Read-Markers", isOn: $appStorageModel.sendDisplayedMarkers)
                
            }
            
        }
    }
}

struct thirdscreen: View{
    @ObservedObject var appStorageModel: AppStorageModel
    
    var body: some View{
        Form{
            
            Section(header: Text("Location & Sharing")){
                Toggle("Show Inline Geo Location", isOn: $appStorageModel.showGeoLocation)
                
                Toggle("Show URL previews", isOn: $appStorageModel.showURLPreview)
                
            }
            
        }
    }
}


struct fourthscreen: View{
    @ObservedObject var appStorageModel: AppStorageModel
    
    var body: some View{
       Form{
            
            Section(header: Text("Communication")){
                Toggle("Calls: Allow P2P sessions", isOn: $appStorageModel.webrtcAllowP2P)
                Toggle("Calls: Allow TURN fallback to Monal-Servers", isOn: $appStorageModel.webrtcUseFallbackTurn)
                Toggle("Allow approved contacts to query my Monal and iOS version", isOn: $appStorageModel.allowVersionIQ)
               
                Toggle("Allow contacts not in my Contact list to contact me", isOn: $appStorageModel.allowNonRosterContacts)
            
                
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
