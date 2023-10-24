//
//  TabItem.swift
//  Samespace
//
//  Created by Nishant Minerva on 23/10/23.
//

import SwiftUI

// Tab Bar Item
struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab

//    Each Item positioning on the screen
    @State private var tabPosition: CGPoint = .zero
    var body: some View {
        VStack(spacing: 5){
            Text(tab.rawValue)
                .font(.headline)
                .bold()
                .foregroundColor(activeTab == tab ? tint : .gray)
            if activeTab == tab {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 8, height: 8)
                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
            }
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: {rect in
            tabPosition.x = rect.midX
        })
        .onTapGesture {
            activeTab = tab
        }
    }
}
