//
//  RecipeBookView.swift
//  Pocket-Kitchen
//

import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let prepTime: Int // in minutes
    let isFavorite: Bool
    let lastCooked: Date?
}

struct RecipeBookView: View {
    @State private var recipes: [Recipe] = [
        // Sample data - replace with actual data source soon
        Recipe(name: "Spaghetti Carbonara", prepTime: 30, isFavorite: true, lastCooked: Date()),
        Recipe(name: "Classic Burger", prepTime: 45, isFavorite: true, lastCooked: Date().addingTimeInterval(-86400)),
        Recipe(name: "Caesar Salad", prepTime: 15, isFavorite: false, lastCooked: Date().addingTimeInterval(-172800))
    ]
    
    @State private var showingAddRecipeSheet = false
    @State private var showingWebImportSheet = false
    
    var favoriteRecipes: [Recipe] {
        recipes.filter { $0.isFavorite }
    }
    
    var recentlyCooked: [Recipe] {
        recipes
            .filter { $0.lastCooked != nil }
            .sorted { ($0.lastCooked ?? Date()) > ($1.lastCooked ?? Date()) }
            .prefix(5)
            .map { $0 }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(favoriteRecipes) { recipe in
                        RecipeRow(recipe: recipe)
                    }
                } header: {
                    Text("Favorites")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .textCase(nil)
                }
                
                Section {
                    ForEach(recentlyCooked) { recipe in
                        RecipeRow(recipe: recipe)
                    }
                } header: {
                    Text("Recently Cooked")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .textCase(nil)
                }
            }
            .navigationTitle("My Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { showingAddRecipeSheet = true }) {
                            Label("Add Recipe Manually", systemImage: "square.and.pencil")
                        }
                        
                        Button(action: { showingWebImportSheet = true }) {
                            Label("Import from Web", systemImage: "globe")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddRecipeSheet) {
                // AddRecipe here
                Text("Add Recipe View")
            }
            .sheet(isPresented: $showingWebImportSheet) {
                // Add your WebImport here
                Text("Web Import View")
            }
        }
    }
}

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.body)
            }
            
            Spacer()
            
            Text("\(recipe.prepTime) min")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct RecipeBookView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBookView()
    }
}
