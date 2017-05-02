---
title: "Strange Keywords in Swift"
date: 2017-03-22 00:00
---
<br>

**AssociatedType**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;An associated type is a layer of abstraction for types or functions defined in Swift protocols.  The type of an associated type is not defined in the protocol so in this way it is similar to a generic.  When creating a class or struct that conforms to a protocol with an associated type, an actual type must be given.  This can be done implicitly, as shown in the function below, where the Adult class does not define `EmployeeKind`, but references it and gives it a type of `Bartender` in the `buyDrink` method.
<br><br>

```swift
import Foundation

protocol Liquid { }

class Beer : Liquid { }

protocol Customer {
    associatedtype SafeLiquid
    associatedtype EmployeeKind
    
    func drink(d: SafeLiquid)
    func buyDrink(from: EmployeeKind)
}

protocol Bar {
    associatedtype DrinkType
    func sellDrink() -> DrinkType
}

class Bartender : Bar {
    typealias DrinkType = Beer
    
    func sellDrink() -> DrinkType {
        return Beer()
    }
}

class Adult: Customer {
    func drink(d: Beer) {
        print(d)
    }
    
    func buyDrink(from: Bartender) {
        print(from)
    }
}

func buyDrinkAndDrinkIt<T: Customer, U: Bar> (customer: T, bartender: U) where T.SafeLiquid == U.DrinkType {
    let drink = bartender.sellDrink()
    customer.drink(d: drink)
}

buyDrinkAndDrinkIt(customer: Adult(), bartender: Bartender())
```
<br>

**<center>* * * * *</center>**

**Dynamic**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The `dynamic` keyword refers to the time to dispatch and can be applied to class functions or variables.  Dynamic dispatch occurs at runtime, as opposed to static dispatch, which runs at compile time.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In Swift, static dispatch is concretely achieved through the use of `final` and `static`.  Static provides a performance boost because the compiler immediately knows what is being called at runtime.  Although, because Swift allows method and property overrides, it sometimes has to determine what you are referring to at runtime.
<br><br>

```swift
class Insect {
    func makeNoise(noise: String) {
        print(noise)
    }
}

class Bee: Insect {
    override func makeNoise() {
        print("Buzzz")
    }
}
```
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In the code above, if you were to call `makeNoise` on an instance of Animal, it is possible the Swift compiler would need to wait until runtime to determine, which class function you were referring to.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When you use the dynamic keyword in Swift, it implicitly adds the @objc attribute and tells the compiler to use Objective-C runtime.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Static dispatch is preferable, and almost always performed, however there are cases when explicitly adding dynamic can save your app from crashing.  These situations usually occur when functions or properties will be interfered with or transformed at runtime.  A common example is app analytics libraries.  If you don’t do so, the Swift compiler could perform optimizations on those functions that cause unintended effects or break your app.  Dynamic dispatch also allows for better interoperability with other things that run in Objective-C runtime, like Core Data and Key-Value Observing.

**<center>* * * * *</center>**

**Indirect**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The `indirect` keyword allows for recursive enumerations.  You can place `indirect` before the enum's case(s) or before the enum itself.  Doing the latter enables indirection for all the enum's cases that could need it.  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The compiler does the job of inserting the necessary layer of indirection for the enum.
<br><br>

```swift
enum Nat {
    case Zero
    indirect case Succ(Nat)
}
```
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Swift won't compile the above code without `indirect`.
<br><br>

```swift
let zero: Nat = .Zero
let one: Nat = .Succ(zero)
let two: Nat = .Succ(.Succ(.Zero))
let three: Nat = .Succ(two)
```
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Being recursive, we can define a variable from our `Nat` enum using a previously defined `Nat`.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The above code was taken from the beginning of a great blog post by Brandon Williams, in which he models natural numbers using an enumeration, and overloads operators so that cases from `Nat` can be added, multiplied, and more.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Check out his post [here](http://www.fewbutripe.com/swift/math/2015/01/20/natural-numbers.html).
