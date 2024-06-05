import Foundation
import SwiftUI


import Combine

//class MLXMPPConnectionObservable: ObservableObject {
//    @Published var server: MLXMPPServer
//    @Published var identity: MLXMPPIdentity
//
//    init(server: MLXMPPServer, identity: MLXMPPIdentity) {
//        self.server = server
//        self.identity = identity
//    }
//}



class XMPPEditObservable: ObservableObject {
    //@Published var db: DataLayer
//    @Published var sectionDictionary: NSMutableDictionary
    @Published var editMode: Bool
    @Published var jid: String
    @Published var password: String
    @Published var accountType: String
    @Published var rosterName: String
    @Published var statusMessage: String
    @Published var resource: String
    @Published var server: String
    @Published var port: String
    @Published var enabled: Bool
    @Published var directTLS: Bool
    @Published var currentTextField: UITextField?
    @Published var imagePicker: UIDocumentPickerViewController?
    @Published var userAvatarImageView: UIImageView?
    @Published var selectedAvatarImage: UIImage?
    @Published var avatarChanged: Bool
    @Published var rosterNameChanged: Bool
    @Published var statusMessageChanged: Bool
    @Published var detailsChanged: Bool
    @Published var sasl2Supported: Bool
    @Published var plainActivated: Bool
    @Published var deactivateSave: Bool
      var avatarImage : UIImage?
      var showingImagePicker = false
    @Published  var inputImage: UIImage?
    init(
       // db: DataLayer = DataLayer(),
//        sectionDictionary: NSMutableDictionary = NSMutableDictionary(),
        editMode: Bool = false,
        jid: String = "",
        password: String = "",
        accountType: String = "",
        rosterName: String = "",
        statusMessage: String = "",
        resource: String = "test",
        server: String = "",
        port: String = "",
        enabled: Bool = false,
        directTLS: Bool = false,
        currentTextField: UITextField? = nil,
        imagePicker: UIDocumentPickerViewController? = nil,
        userAvatarImageView: UIImageView? = nil,
        selectedAvatarImage: UIImage? = nil,
        avatarChanged: Bool = false,
        rosterNameChanged: Bool = false,
        statusMessageChanged: Bool = false,
        detailsChanged: Bool = false,
        sasl2Supported: Bool = false,
        plainActivated: Bool = false,
        deactivateSave: Bool = false,
        avatarImage: UIImage? = nil,
        showingImagePicker: Bool = false,
        inputImage: UIImage? = nil        ) {
        //    self.db = db
//            self.sectionDictionary = sectionDictionary
            self.editMode = editMode
            self.jid = jid
            self.password = password
            self.accountType = accountType
            self.rosterName = rosterName
            self.statusMessage = statusMessage
            self.resource = resource
            self.server = server
            self.port = port
            self.enabled = enabled
            self.directTLS = directTLS
            self.currentTextField = currentTextField
            self.imagePicker = imagePicker
            self.userAvatarImageView = userAvatarImageView
            self.selectedAvatarImage = selectedAvatarImage
            self.avatarChanged = avatarChanged
            self.rosterNameChanged = rosterNameChanged
            self.statusMessageChanged = statusMessageChanged
            self.detailsChanged = detailsChanged
            self.sasl2Supported = sasl2Supported
            self.plainActivated = plainActivated
            self.deactivateSave = deactivateSave
            self.avatarImage = avatarImage
            self.showingImagePicker = showingImagePicker
            self._inputImage = Published(initialValue: inputImage)
        }
    
}




struct AccountsEdit : View{
    @ObservedObject var xmppEdit = XMPPEditObservable()
    
    var body: some View {
        NavigationView {
            Form{
                HStack{
                    Spacer()
                    VStack {
                        ZStack {
                            if let avatarImage = xmppEdit.avatarImage {
                                Image(uiImage: avatarImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .foregroundColor(.gray)
                            }
                        }
                        .onTapGesture {
                            xmppEdit.showingImagePicker = true
                        }
                        //                        .onChange(of: inputImage) { newItem in
                        //                            if let newItem = newItem {
                        //                                newItem.loadTransferable(type: Data.self) { result in
                        //                                    switch result {
                        //                                    case .success(let data?):
                        //                                        if let image = UIImage(data: data) {
                        //                                            avatarImage = image
                        //                                        }
                        //                                    case .success(nil):
                        //                                        print("No data found")
                        //                                    case .failure(let error):
                        //                                        print("Failed to load image: \(error.localizedDescription)")
                        //                                    }
                        //                                }
                        //                            }
                        //                        }
                    }
                    Spacer()
                }
                .sheet(isPresented: $xmppEdit.showingImagePicker) {
                    // ImagePicker( image: $xmppEdit.inputImage)
                    
                    
                    
                    
                }.padding(6)
                
                
                VStack {
                    Toggle("Enabled", isOn: $xmppEdit.enabled)
                    
                    TextField("Display Name", text: $xmppEdit.rosterName).padding(4)
                    
                    TextField("Status Message", text: $xmppEdit.statusMessage).padding(4)
                }
                
                Section(header: Text("General")) {
                    NavigationLink(destination: Text("Change Password")) {
                        HStack{
                            Image(systemName: "lock.rotation")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text("Change Password")
                        }}
                    NavigationLink(destination: Text("Encryption Keys (OMEMO)")) {
                        HStack{
                            Image(systemName: "key")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text("Encryption Keys (OMEMO)")
                        }}
                    NavigationLink(destination: Text("Message Archive Preferences")) {
                        HStack{
                            Image(systemName: "archivebox")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 19, height: 19)
                            Text("Message Archive Preferences")
                        }}
                    NavigationLink(destination: Text("Blocked Users")) {
                        HStack{
                            Image(systemName: "person.fill.xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text("Blocked Users")
                        }}
                    NavigationLink(destination: Text("Protocol support of your server (XEPs)")) {
                        Text("Protocol support of your server (XEPs)")}
                }
                
                Section(header: Text("Advanced")) {
                    TextField("XMPP id", text: $xmppEdit.jid)
                    SecureField("Password", text: $xmppEdit.password)
                    TextField("Server", text: $xmppEdit.server)
                    TextField("66", value: $xmppEdit.port , formatter: NumberFormatter())
                    Toggle("Always use direct TLS, not STARTTLS", isOn: $xmppEdit.enabled)
                        .font(.system(size: 16))
                    Toggle("Allow MITM-prone PLAIN authentication", isOn: $xmppEdit.enabled)
                        .font(.system(size: 16))
                    Text("Resource:   \(xmppEdit.resource)")
                }
            }
        }
        .navigationBarTitle("Account Settings")
    }
}

struct AccountsEdit_Previews: PreviewProvider {
    static var previews: some View {
        AccountsEdit()
    }
}

