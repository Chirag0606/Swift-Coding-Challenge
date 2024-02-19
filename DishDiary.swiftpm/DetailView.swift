import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(recipe.cuisine)
                    .resizable()
                    .scaledToFit()
                
                Text(recipe.cuisine.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(recipe.recipeDescription)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(recipe.ingredients)
                .padding()
            
            ImpressionView(rating: .constant(recipe.rating))
                .font(.largeTitle)
        }
        .navigationTitle(recipe.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete Recipe", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteRecipe)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this Recipe", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteRecipe() {
        modelContext.delete(recipe)
        dismiss()
    }
}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Recipe.self, configurations: config)
//        let example = Recipe(title: "Recipe name", recipeDescription: "Description of the recipe", cuisine: "Indian", review: "This was a great book; I really enjoyed it.", rating: 4)
//        
//        return DetailView(recipe: example)
//            .modelContainer(container)
//    } catch {
//        return Text("Failed to create preview: \(error.localizedDescription)")
//    }
//}
