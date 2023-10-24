//
//  CustomTabBar.swift
//  Samespace
//
//  Created by Nishant Minerva on 23/10/23.
//

import SwiftUI

//    Custom tab Bar
//    with more easy customization

struct CustomTabBar: View {
    @Namespace private var animation
    @Binding var activeTab: Tab
    var tint: Color = .white
    var inactiveTint: Color = .gray
    
    var body: some View {
        //        Moving all the remaining tab Item's to Bottom
                HStack(alignment: .top, spacing: 0){
                    ForEach(Tab.allCases, id:  \.rawValue) {
                        TabItem(tint: tint ,inactiveTint: inactiveTint, tab: $0, animation: animation, activeTab: $activeTab)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}
