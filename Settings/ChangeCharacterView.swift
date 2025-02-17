//
//  ChangeCharacterView.swift
//  Pocket-Kitchen
//
//  Created by Claire Alverson on 11/28/24.
//

import SwiftUI

struct ChangeCharacterView: View {
    @State private var selectedCharacter: String = "Character1" // Default character
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Your Character")
                .font(.headline)
                .padding()
            
            // Display selected character image
            Image(selectedCharacter)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .shadow(radius: 10)
                .padding()

            // Character selection buttons
            HStack(spacing: 30) {
                Button(action: {
                    selectedCharacter = "Character1"
                }) {
                    VStack {
                        Image("Character1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        Text("Joe")
                            .font(.subheadline)
                    }
                }

                Button(action: {
                    selectedCharacter = "Character2"
                }) {
                    VStack {
                        Image("Character2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        Text("Sock")
                            .font(.subheadline)
                    }
                }

                Button(action: {
                    selectedCharacter = "Character3"
                }) {
                    VStack {
                        Image("Character3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        Text("Fuzz")
                            .font(.subheadline)
                    }
                }
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Change Character")
        .padding()
    }
}

// Dummy Preview
struct ChangeCharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeCharacterView()
    }
}
