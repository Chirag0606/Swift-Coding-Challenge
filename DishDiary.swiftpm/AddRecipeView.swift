import SwiftUI

struct AddRecipeView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var recipeDescription = ""
    @State private var rating = 3
    @State private var selectedCuisine = "Indian"
    @State private var ingredients = ""
    
    let cuisines = ["Indian", "Japanese", "Italian", "Mexican", "French", "American", "Brazilian"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of the recipe", text: $title)
                    TextField("Description of the recipe", text: $recipeDescription)
                    
                    Picker("Cuisine", selection: $selectedCuisine) {
                        ForEach(cuisines, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Ingredients") {
                    TextEditor(text: $ingredients)
                }
                
                Section("Impression") {
                    ImpressionView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newRecipe = Recipe(title: title, recipeDescription: recipeDescription, cuisine: selectedCuisine, ingredients: ingredients, rating: rating)
                        modelContext.insert(newRecipe)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Recipe")
        }
    }
}
