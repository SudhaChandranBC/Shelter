import SwiftUI
struct NewPostView: View {
    
    @State private var dogName:String = ""
    @State private var dogHeight:String = ""
    
    @State private var dogWeight:String = ""
    @State private var selectedBreed:String = ""
    @State private var age:String = ""
    
    @State private var isAvailableForAdoption = false
    @State private var ownerEmail:String = ""
    @State private var city:String = ""
    @State private var description:String = ""
    @State private var selectedImage:UIImage?
    
    
    @State private var isImagePickerPresented = false
    @Binding var isPresented:Bool
    
    
    var dogImage:Image {
        if let image = selectedImage
        {
            return Image(uiImage: image)
        }else{
            return Image("Placeholder")
        }
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dog Photo")) {
                    Button(action: {
                        self.isImagePickerPresented = true
                    }) {
                        HStack {
                            Spacer()
                            VStack(alignment: .center) {
                                dogImage
                                    .resizable()
                                    .scaledToFit()
                                    .frame(idealHeight: self.selectedImage == nil ? 200.0 : nil)
                                    .padding()
                                    .foregroundColor(Color(.systemFill))
                                Text("Choose Photo")
                                    .fontWeight(.bold)
                                    .padding(.bottom)
                                    .foregroundColor(Color(.systemBlue))
                            }
                            Spacer()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .listRowInsets(.init())
                }
                
                Section(header: Text("Dog Traits")) {
                    HStack {
                        Text("Height in cm")
                        TextField("cm", text: $dogHeight)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("Weight in kg")
                        TextField("kg", text: $dogWeight)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("Age in months")
                        TextField("Months", text: $age)
                            .multilineTextAlignment(.trailing).keyboardType(.numberPad)
                    }
                    
                    Picker("Breed", selection: $selectedBreed) {
                        ForEach(dogBreeds, id:\.self){ breedName in
                            Text(breedName)
                        }
                    }
                    
                }
                Section(header: Text("Adoption")) {
                    Toggle(isOn: $isAvailableForAdoption) {
                        Text("Available For Adoption")
                    }
                    
                    if isAvailableForAdoption {
                        HStack {
                            Text("Contact Email")
                            TextField("appaccelerator@apple.com", text: $ownerEmail)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.emailAddress)
                        }
                        HStack {
                            Text("City")
                            TextField("e.g. Bangalore", text: $city)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    
                }
                Section {
                    HStack {
                        Text("Name")
                        TextField("Dog Name", text: $dogName)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    TextField("Write about your Dog", text: $description)
                    
                }
                
            }
            .modifier(KeyboardHeight())
            .navigationBarTitle(Text("New Post"),displayMode:.inline)
            .navigationBarItems(leading: Button(action: {
                self.isPresented = false
            }, label: {
                Text ("Cancel")
            }), trailing: Button(action: {
                self.isPresented = false
                self.addNewPost()
                
            }, label: {
                Text ("Done").fontWeight(.bold)
            }))
            
        }.navigationViewStyle(StackNavigationViewStyle())
            .sheet(isPresented: self.$isImagePickerPresented, onDismiss: {
            }, content: {
                ImagePicker(originalImage: self.$selectedImage,presentationMode: self.$isImagePickerPresented)
            })
        
    }
    
    
    func addNewPost(){
        
        let dogPost = DogPost(breedName: selectedBreed,dogName:dogName, ageInMonths: Int(age) ?? 0, city: city, isAvailableForAdoption: isAvailableForAdoption, isFavorite: false, ownersEmail: ownerEmail, bodyMeasurements: BodyMeasurement(height: Double(dogHeight) ?? 0.0, weight: Double(dogWeight) ?? 0.0), imageName: nil, description: description, postImage: self.selectedImage)
        
        DogPostsManager.shared.add(post: dogPost)
    }
    
    
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(isPresented: .constant(true))
    }
}
