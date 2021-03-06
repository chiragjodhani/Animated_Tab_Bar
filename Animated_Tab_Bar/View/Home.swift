//
//  Home.swift
//  Animated_Tab_Bar
//
//  Created by Eryushion Techsol on 05/03/21.
//

import SwiftUI

struct Home: View {
    @State var selectedTab = "house"
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("TabBG").ignoresSafeArea()
            
            //MARK: Custom Tab Bar.....
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

