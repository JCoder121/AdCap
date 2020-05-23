//
//  ContentView.swift
//  AdCap
//
//  Created by Jeffrey Chen on 5/23/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView {
                MainPageView().tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                
                UpgradePageView().tabItem {
                    Image(systemName: "dollarsign.square")
                    Text("Upgrade")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
