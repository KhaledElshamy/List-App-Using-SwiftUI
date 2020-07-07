//
//  ContentView.swift
//  List app
//
//  Created by Khaled Elshamy on 7/5/20.
//  Copyright © 2020 Khaled Elshamy. All rights reserved.
//

import SwiftUI

struct ArtistListView: View {
    var viewModel: ArtistListViewModel
    
    @State var isPresentingAddArtist = false
    @State var isEditing: Bool = false
    
    @State var showAlert: Bool = false
    
    var alert: Alert {
        Alert(title: Text("Item has been deleted sucessfully"), dismissButton: .cancel())
    }
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(viewModel.numOfArtists,id:\.id) { artist in
                    ArtistRow(artist: artist)
                }
                .onDelete(perform: removeArtist)
                .onMove(perform: move)
                .onTapGesture {
                    withAnimation {
                        self.isEditing = false
                    }
                }
                .onLongPressGesture {
                    withAnimation {
                        self.isEditing.toggle()
                    }
                }
            }
            .alert(isPresented: $showAlert, content: {
                self.alert
            })
            .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
            .navigationBarTitle(Text("Artists"))
            .navigationBarItems(trailing: Button(action: {
                self.isPresentingAddArtist.toggle()
            }, label: {
                Text("Add")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.all,12)
                .background(Color.green)
                .cornerRadius(3)
            }))
                .sheet(isPresented: $isPresentingAddArtist, content:  {
                    // MARK: - Artist View
                    addArtistView(isPresented: self.$isPresentingAddArtist, didAddArtist: { artist in
                        self.viewModel.CreateArtist(artist: artist)
                    })
            })
        }
    }
    
    //MARK: - move rows of the list
    func move(fromOffsets source: IndexSet, toOffsets destination:Int){
        viewModel.move(fromOffsets: source, toOffsets: destination)
        withAnimation {
            isEditing = true
        }
    }
    
    // MARK: - remove Artist
    func removeArtist(at offsets: IndexSet){
        self.showAlert.toggle()
        self.viewModel.removeArtist(offsets: offsets)
    }
}


struct ArtistRow: View {
    
    var artist: ModelArtists.Artist
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(artist.userName).font(.headline)
                HStack{
                    Text(artist.city + ",").font(.subheadline)
                    Text(artist.country).font(.subheadline)
                }.padding(.top,5)
            }
        }.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArtistListView(viewModel: ArtistListViewModel())
    }
}
