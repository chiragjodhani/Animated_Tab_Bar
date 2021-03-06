//
//  CustomTabBar.swift
//  Animated_Tab_Bar
//
//  Created by Eryushion Techsol on 05/03/21.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    
    // Storing Each Tab MidPoint to animate it in future.....
    @State var tabPoints: [CGFloat] = []
    var body: some View {
        HStack(spacing: 0) {
            //MARK: Tab Bar Buttons.....
            TabBarButton(image: "house", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "bookmark", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "message", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints)
        }
        .padding()
        .background(
            Color.white
                .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
        )
        .overlay(
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 20)
            , alignment: .bottomLeading
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    //extracting Point
    func getCurvePoint()-> CGFloat {
        // if tabpoint is empty.....
        if tabPoints.isEmpty {
            return 10
        }else {
            switch selectedTab {
            case "house":
                return tabPoints[0]
            case "bookmark":
                return tabPoints[1]
            case "message":
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
        
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints:[CGFloat]
    var body: some View {
        //MARK: For getting mid point of each button for curve Animation......
        GeometryReader { geo -> AnyView in
            let midX = geo.frame(in: .global).midX
            DispatchQueue.main.async {
                //avoiding junk data.....
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            return AnyView(
                Button(action: {
                    //changing tab.....
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)) {
                        selectedTab = image
                    }
                }, label: {
                    // filling the color if it's selected.....
                    
                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color("TabSelected"))
                    // Lifting View...
                    // if its selected....
                        . offset(y: selectedTab == image ? -10 : 0)
                })
                // Max Frame.....
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        //maxHeight........
        .frame(height: 50)
    }
}
