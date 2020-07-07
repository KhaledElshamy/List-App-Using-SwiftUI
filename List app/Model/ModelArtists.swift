//
//  UserModel.swift
//  List app
//
//  Created by Khaled Elshamy on 7/5/20.
//  Copyright © 2020 Khaled Elshamy. All rights reserved.
//

import Foundation
import SwiftUI


class ModelArtists {
   
    var Artists: Array<Artist>
    
     func removeArtist(offsets: IndexSet){
        self.Artists.remove(atOffsets: offsets)
    }
    
    func move(fromOffsets source: IndexSet, toOffsets destination:Int){
        self.Artists.move(fromOffsets: source, toOffset: destination)
    }
    
    func createArtist(artist:Artist){
        self.Artists.append(artist)
    }
    
    init() {
        Artists = Array<Artist>()
    }

    
    struct Artist: Identifiable {
        var id =  UUID()
        let userName: String
        let birthDate: String
        let city:String
        let country:String
    }
}
