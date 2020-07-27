
import SwiftUI

struct PostDetailView: View {
    var dogPost:DogPost
    
    var body: some View {
        Form {
            
            dogPost.image
            .resizable()
            .scaledToFit()
            .listRowInsets(.init())
            
            Section(header:Text("Dog Traits")){
                HStack {
                    Text("Dog Name")
                    Spacer()
                    Text(dogPost.dogName).foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Breed Name")
                    Spacer()
                    Text(dogPost.breedName).foregroundColor(.secondary)
                }
                
                
                HStack {
                    Text("Age")
                    Spacer()
                    Text(formatted(ageInMonths: dogPost.ageInMonths)).foregroundColor(.secondary)
                }
            }
            Section(header:Text("Measurements")){
                HStack {
                    Text("Height")
                    Spacer()
                    Text("\(dogPost.bodyMeasurements.height,specifier:"%.2f") cm").foregroundColor(.secondary)
                }
                HStack {
                    Text("Weight")
                    Spacer()
                    Text("\(dogPost.bodyMeasurements.weight,specifier:"%.2f") kg").foregroundColor(.secondary)
                }
            }
            if dogPost.isAvailableForAdoption {
                Section(header:Text("Adoption")){
                    HStack {
                        Text("Owner's Email")
                        Spacer()
                        Text(dogPost.ownersEmail).foregroundColor(.secondary)
                    }
                    HStack {
                        Text("City")
                        Spacer()
                        Text(dogPost.city).foregroundColor(.secondary)
                    }
                }
                
            }
            
        }.navigationBarTitle(Text(dogPost.breedName), displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(dogPost: DogPost(breedName: "Pug",dogName: "Casper", ageInMonths: 6, city: "Bangalore", isAvailableForAdoption: true, isFavorite: true, ownersEmail: "abc@b.com", bodyMeasurements: BodyMeasurement(height: 15, weight: 20), imageName: nil, description: "Cute Dog", postImage: nil))
    }
}
