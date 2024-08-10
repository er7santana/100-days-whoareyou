//
//  AddPersonView.swift
//  WhoAreYou
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 10/08/24.
//

import CoreImage
import PhotosUI
import SwiftUI

struct AddPersonView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    @State private var viewModel = ViewModel()
    var onSavedItem: () -> Void
    
    init(onSavedItem: @escaping () -> Void) {
        self.onSavedItem = onSavedItem
    }
    
    var body: some View {
        VStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $viewModel.name)
                }
                
                Section("Photo") {
                    VStack {
                        
                        PhotosPicker(selection: $pickerItem) {
                            if let selectedImage {
                                selectedImage
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                ContentUnavailableView("No picture",
                                                       systemImage: "photo.badge.plus",
                                                       description: Text("Tap to import a photo")
                                )
                            }
                        }
                        .onChange(of: pickerItem, loadImage)
                        .padding(.vertical)
                        
                    }
                }
            }
            .navigationTitle("Add item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.addPerson()
                        dismiss()
                        onSavedItem()
                    }
                    .disabled(viewModel.isSaveButtonDisabled)
                }
                
            }
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await pickerItem?.loadTransferable(type: Data.self),
                  let uiImage = UIImage(data: imageData) else { return }
            
            viewModel.imageData = imageData
            selectedImage = Image(uiImage: uiImage)
        }
    }
}

#Preview {
    NavigationStack {
        AddPersonView(onSavedItem: { })
    }
}
