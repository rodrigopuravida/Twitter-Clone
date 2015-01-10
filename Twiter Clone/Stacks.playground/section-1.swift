// Playground - noun: a place where people can play

import UIKit



class Car {
  var model = "Test"
  
  
  var myParkingLot = [Car]()
  

  
  func push(auto : Car) {
    
    myParkingLot.append(auto)
    
  }
  
  func pop() -> Car? {
    if !self.myParkingLot.isEmpty{
      let item = self.myParkingLot.last
      self.myParkingLot.removeLast()
      return item!
    } else {
      return nil
    }
  }
  
  
  func peek() -> Car {
    return self.myParkingLot.last!
  }
  
}

//TEST Section

var beetle = Car()
beetle.model = "VW"
var beamer = Car()
beamer.model = "BMW"
var beater = Car()
beater.model = "Yugo"
var turbo = Car()
turbo.model = "Porsche"

beetle.myParkingLot.count
println("adding cars")
beetle.myParkingLot.append(beetle)
beetle.myParkingLot.append(beamer)
beetle.myParkingLot.append(beater)
beetle.myParkingLot.append(turbo)

println("Total car count should be 4")
beetle.myParkingLot.count

println("push a new one in")
var jeep = Car()
jeep.model = "Wrangler"

beetle.push(jeep)
println("Now count should be 5")
beetle.myParkingLot.count

println("peek at model of car just pushed which is Wrangler")
println("Model of car to be peeked is :  \(beetle.peek().model)")

println("take Jeep out and verify that now Porsche is the one we peeked")
beetle.pop()
println("Model of car to be peeked is :  \(beetle.peek().model)")

println("Take one more out and validate Yugo is the one getting peeked")
beetle.pop()
println("Model of car to be peeked is :  \(beetle.peek().model)")




























