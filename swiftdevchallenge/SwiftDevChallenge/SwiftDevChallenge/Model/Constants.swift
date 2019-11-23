//
//  Constants.swift
//  SwiftDevChallenge
//
//  Created by Das on 11/23/19.
//  Copyright © 2019 Arunabh Das. All rights reserved.
//

import Foundation


struct Constants {
    
    struct Endpoints {
        
        static let kGetNearbyPlaces = "https://maps.googleapis.com/maps/api/place/autocomplete/json?types=address&key=AIzaSyDRcHVbQPfzRR7BU69KUyI80zljVQ0jLoA&input="
    }
    
    struct Titles {
        
        static let kTopNavTitle = "Cover iOS Dev Challenge"
        
        static let kNextButtonTitle = "Next"
        
        static let kAlertSuccesTitle = "Success"
        
        static let kAlertErrorTitle = "Error"
        
        static let kAlertSuccess = "You have successfully located the correct address"
        
        static let kAlertError = "There was an error selecting the correct address"
        
        static let kAlertOkTitle = "Ok"
    }
}
