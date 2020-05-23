//
//  MainPageView.swift
//  AdCap
//
//  Created by Jeffrey Chen on 5/23/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI

//time factor
//pictures
//managers
//possibly upgrades
//format million billion trillion
//make everythig pretty

struct Product: Identifiable {
    
    var id = UUID()
    var name: String
    var first_buy: Bool
    
    var start_price: Double
    var price_scale: Double
    
    var start_profit: Double
    var profit_scale: Double
    
    init(name: String, first_buy: Bool, start_price: Double, price_scale: Double, start_profit: Double, profit_scale: Double) {
        self.name = name
        self.first_buy = first_buy
        
        self.start_price = start_price
        self.price_scale = price_scale
        
        self.start_profit = start_profit
        self.profit_scale = profit_scale
    }
    
}

struct MainPageView: View {

    @State var total_money: Double = 1
    
    @State var lemon = Product(name: "Lemon", first_buy: true, start_price: 1, price_scale: 1.3, start_profit: 0.2, profit_scale: 1/2)
    
    @State var earth_all_products = [
    
        Product(name: "Lemon", first_buy: true, start_price: 1, price_scale: 1.07, start_profit: 1, profit_scale: 1),
        Product(name: "Newspaper", first_buy: true, start_price: 60, price_scale: 1.3, start_profit: 60, profit_scale: 1),
        Product(name: "Car Wash", first_buy: true, start_price: 720, price_scale: 1.3, start_profit: 540, profit_scale: 1),
        Product(name: "Pizza Place", first_buy: true, start_price: 8640, price_scale: 1.3, start_profit: 4320, profit_scale: 1),
        Product(name: "Donut Shop", first_buy: true, start_price: 103680, price_scale: 1.3, start_profit: 51840, profit_scale: 1),
        Product(name: "Shrimp Boat", first_buy: true, start_price: 1244160, price_scale: 1.3, start_profit: 622080, profit_scale: 1),
        Product(name: "Hockey Team", first_buy: true, start_price: 14929920, price_scale: 1.3, start_profit: 7464960, profit_scale: 1),
        Product(name: "Film Studio", first_buy: true, start_price: 179159040, price_scale: 1.3, start_profit: 89579520, profit_scale: 1),
        Product(name: "Bank", first_buy: true, start_price: 2149908480, price_scale: 1.3, start_profit: 1074954240, profit_scale: 1),
        Product(name: "Oil Refinery", first_buy: true, start_price: 25798901760, price_scale: 1.3, start_profit: 29668737024, profit_scale: 1)
    
    ]
   
    
    //for earth only
    func buy_upgrade(name: inout Product)  {
        
        
        //profit scale will increase based on # of items bought
        //need to set a number
        
        if name.first_buy && self.total_money >= name.start_price {
            self.total_money -= name.start_price
            name.first_buy = false
        }
        
        if self.total_money >= name.start_price {
            self.total_money -= name.start_price
            
            //possibly for moon or whatever but for earth it is directly *=
            //name.start_price += pow(name.start_price, name.price_scale)
            
            //staying true to game
            name.start_price *= name.price_scale
            
            name.start_profit += name.start_profit * name.profit_scale
            
            
        }

    }
    
    
    var body: some View {
        
        VStack {
            
            Text("Total Money: ").padding()
            
          
            Text("$\(total_money, specifier: "%.2f")")
                .font(.system(size: 50)).padding(50).minimumScaleFactor(0.000001)
                .lineLimit(1)

            
            ScrollView(showsIndicators: false) {
            
                ForEach(0..<earth_all_products.count) { product in
                    
   
                    VStack {
                        Button(action: {
                            self.total_money += self.earth_all_products[product].start_profit
                        }){
                            Text("\(self.earth_all_products[product].name): $\(self.earth_all_products[product].start_profit, specifier: "%0.2f")")
                        }.disabled(self.earth_all_products[product].first_buy)
                     
                        Button(action: {
                            self.buy_upgrade(name: &self.earth_all_products[product])
                        
                        })
                        {
                            if self.earth_all_products[product].first_buy {
                                Text("Buy: $\(self.earth_all_products[product].start_price, specifier: "%.2f")")
                            }
                            else {
                                Text("Upgrade: $\(self.earth_all_products[product].start_price, specifier: "%.2f")")
                            }
                        }.disabled(self.total_money < self.earth_all_products[product].start_price)
                    
                    }.padding()
                    
                }
            }.frame(width: 1000000000)
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
