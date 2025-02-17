import SwiftUI

struct HomeView: View {
    @State private var selectedCharacter: String = "Character1" // Default character
    @State private var selectedHat: String = "None" // For CharacterView
    @State private var points: Int = 0

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    // Full-screen background image
                    Image("kitchenbackdrop")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)

                    // Character View
                    VStack {
                                            Image(selectedCharacter)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 150, height: 150)
                                                .shadow(radius: 10)
                                                .padding()
                                        }
                                        .offset(x: -25, y: 70)

                    // Overlay objects
                    GeometryReader { geo in
                        // Fridge
                        NavigationLink(destination: FridgeView()) {
                            Image("fridge")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 190, height: 290)
                                .position(x: geo.size.width * 0.84, y: geo.size.height * 0.44)
                        }
                        .buttonStyle(BouncyButtonStyle())

                        // Grocery List
                        NavigationLink(destination: GroceryListView()) {
                            Image("grocery_list")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 200)
                                .position(x: geo.size.width * 0.18, y: geo.size.height * 0.42)
                        }
                        .buttonStyle(BouncyButtonStyle())

                        // Recipe Book
                        NavigationLink(destination: RecipeBookView()) {
                            Image("recipe_book")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 95)
                                .position(x: geo.size.width * 0.57, y: geo.size.height * 0.4)
                        }
                        .buttonStyle(BouncyButtonStyle())
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)

                    // Settings button
                    VStack {
                        HStack {
                            Spacer()
                            NavigationLink(destination: SettingsView()) {
                                HStack {
                                    Image(systemName: "gearshape.fill")
                                        .foregroundStyle(Color.indigo)
                                        .font(.system(size: 20))
                                    Text("Settings")
                                        .font(.custom("Palatino", size: 16))
                                        .foregroundStyle(Color.indigo)
                                }
                                .padding(10)
                                .background(Color.white.opacity(0.7))
                                .cornerRadius(4)
                                .shadow(radius: 5)
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
