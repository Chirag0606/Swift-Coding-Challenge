import Foundation
import SwiftData

@Model
class Recipe {
    var title: String
    var recipeDescription: String
    var cuisine: String
    var ingredients: String
    var rating: Int
    
    init(title: String, recipeDescription: String, cuisine: String, ingredients: String, rating: Int) {
        self.title = title
        self.recipeDescription = recipeDescription
        self.cuisine = cuisine
        self.ingredients = ingredients
        self.rating = rating
    }
}
