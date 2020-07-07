//
//  PeopleList.swift
//  List app
//
//  Created by Khaled Elshamy on 7/5/20.
//  Copyright © 2020 Khaled Elshamy. All rights reserved.
//

import SwiftUI



class ArtistListViewModel {
    
    private(set) var model: ModelArtists = ModelArtists()
    
    
    // MARK:-  create user
    func CreateArtist(artist:ModelArtists.Artist){
        model.createArtist(artist: artist)
    }
    
    func move(fromOffsets source: IndexSet, toOffsets destination:Int){
        self.model.move(fromOffsets: source, toOffsets: destination)
    }
    
    func removeArtist(offsets: IndexSet){
        self.model.removeArtist(offsets: offsets)
    }
    
    
    var numOfArtists: Array<ModelArtists.Artist> {
       return model.Artists
    }
}
