//
//  AddArtistView.swift
//  List app
//
//  Created by Khaled Elshamy on 7/6/20.
//  Copyright © 2020 Khaled Elshamy. All rights reserved.
//

import SwiftUI


struct addArtistView: View {
    
    @Binding var isPresented: Bool
    
    @State var firstName = ""
    @State var birthDate = ""
    @State var city = ""
    @State var country = ""
    
    var didAddArtist: (ModelArtists.Artist) -> ()
    
    @State var showAlert: Bool = false
    @State var showDateAlert: Bool = false
    
    var alert: Alert {
        Alert(title: Text("Enter All Fields"), message: Text("Please Enter All Fields to Add an artist"), dismissButton: .cancel())
    }
    
    
    var dateAlert: Alert {
        Alert(title: Text("Date isn't in a right format"), message: Text("Date must be in (MM/dd/yyyy) format"), dismissButton: .cancel())
    }
    
    var actionSheetProperty: ActionSheet {
        ActionSheet(title: Text("Please Enter All Fields"), buttons: [.cancel()])
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack(spacing:16) {
                    Text("Name")
                    TextField("Enter Name", text: $firstName)
                }
                
                HStack (spacing: 16) {
                    Text("BirthDate")
                    TextField("Enter BirthDate", text: $birthDate)
                }
                
                HStack (spacing: 16) {
                    Text("City")
                    TextField("Enter City", text: $city)
                }
                
                HStack (spacing: 16) {
                    Text("Country")
                    TextField("Enter Country", text: $country)
                }
                
                HStack {
                    Button(action: {
                        if self.checkValidation() {
                            self.isPresented = false
                            self.didAddArtist(.init(userName: self.firstName, birthDate: self.birthDate, city: self.city, country: self.country))
                        }
                    }, label: {
                        Text("Add")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.all,12)
                        .background(Color.green)
                        .cornerRadius(3)
                    })
                    
                    Button(action: {
                        self.isPresented = false
                    }, label: {
                        Text("Cancel")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.all,12)
                        .background(Color.red)
                        .cornerRadius(3)
                    })
                }
                .padding(.top,20)
                
                Spacer()
            }
            .padding(.all,16)
            .navigationBarTitle("Create Artist")
            .alert(isPresented: $showAlert, content: {
                self.alert
            })
                .alert(isPresented: $showDateAlert, content: {
                    self.dateAlert
                })
            
        }
    }
    
    func checkValidation() -> Bool{
        if firstName == "" || birthDate == "" || city == "" || country == "" {
            self.showAlert.toggle()
            return false }
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "MM/dd/yyyy"
        let someDate = birthDate
        if dateFormatterGet.date(from: someDate) == nil {
            self.showDateAlert.toggle()
            return false
        }
        return true
    }
}
