//
//  Tab.swift
//  Samespace
//
//  Created by Nishant Minerva on 22/10/23.
//

import Foundation


// App Tab's
enum Tab: String, CaseIterable {
//    Raw Value used as tab Title
    case foryou = "For You"
    case toptrack = "Top Track"
        
//    Return current Tab Index
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
