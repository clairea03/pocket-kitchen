import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.2)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea() // ensure the background covers the entire screen

                List {
                    Section(header: Text("Character Settings")) {
                        NavigationLink(destination: ChangeCharacterView()) {
                            Text("Change Character")
                        }
                        NavigationLink(destination: ChangeHatView()) {
                            Text("Change Hat")
                        }
                    }

                    Section(header: Text("App Settings")) {
                        NavigationLink(destination: NotificationSettingsView()) {
                            Text("Notification Settings")
                        }
                        NavigationLink(destination: MusicSettingsView()) {
                            Text("Music Settings")
                        }
                    }
                }
                .scrollContentBackground(.hidden) // Makes the List background transparent to show the gradient
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
