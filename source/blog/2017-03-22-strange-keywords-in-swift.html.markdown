---
title: "Strange Keywords in Swift"
date: 2017-03-22 00:00
---
<br>

**Dynamic**

The `dynamic` keyword refers to the time to dispatch and can be applied to class functions or variables.  Dynamic dispatch occurs at runtime, as opposed to static dispatch, which runs at compile time.

In Swift, static dispatch is concretely achieved through the use of `final` and `static`.  Static provides a performance boost because the compiler immediately knows what is being called at runtime.  Although, because Swift allows method and property overrides, it sometimes has to determine what you are referring to at runtime.
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

In the code above, if you were to call `makeNoise` on an instance of Animal, it is possible the Swift compiler would need to wait until runtime to determine, which class function you were referring to.

When you use the dynamic keyword in Swift, it implicitly adds the @objc attribute and tells the compiler to use Objective-C runtime.

Static dispatch is preferable, and almost always performed, however there are cases when explicitly adding dynamic can save your app from crashing.  These situations usually occur when functions or properties will be interfered with or transformed at runtime.  A common example is app analytics libraries.  If you don’t do so, the Swift compiler could perform optimizations on those functions that cause unintended effects or break your app.  Dynamic dispatch also allows for better interoperability with other things that run in Objective-C runtime, like Core Data and Key-Value Observing.

**<center>* * * * *</center>**

**Indirect**

The `indirect` keyword allows for recursive enumerations.  You can place `indirect` before the enum's case(s) or before the enum itself.  Doing the latter enables indirection for all the enum's cases that could need it.  

The compiler does the job of inserting the necessary layer of indirection for the enum.
<br><br>

```swift
enum Nat {
    case Zero
    indirect case Succ(Nat)
}
```
<br>

Swift won't compile the above code without `indirect`.
<br><br>

```swift
let zero: Nat = .Zero
let one: Nat = .Succ(zero)
let two: Nat = .Succ(.Succ(.Zero))
let three: Nat = .Succ(two)
```
<br>

Being recursive, we can define variable from our `Nat` enum using a previously defined `Nat`.

The above code was taken from the beginning of a great blog post by Brandon Williams, in which he models natural numbers using an enumeration, and overloads operators so that cases from `Nat` can be added, multiplied, and more.

Check out his post [here](http://www.fewbutripe.com/swift/math/2015/01/20/natural-numbers.html).
