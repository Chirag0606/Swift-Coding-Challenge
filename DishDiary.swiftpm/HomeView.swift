import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Recipe.title),
        SortDescriptor(\Recipe.recipeDescription)
    ]) var recipes: [Recipe]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(value: recipe) {
                        HStack {
                            EmojiRatingView(rating: recipe.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(recipe.title)
                                    .font(.headline)
                                
                                Text(recipe.recipeDescription)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteRecipes)
            }
            .navigationTitle("DishDiary")
            .navigationDestination(for: Recipe.self) { recipe in
                DetailView(recipe: recipe)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Recipe", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddRecipeView()
            }
        }
    }
    
    func deleteRecipes(at offsets: IndexSet) {
        for offset in offsets {
            let recipe = recipes[offset]
            modelContext.delete(recipe)
        }
    }
}
