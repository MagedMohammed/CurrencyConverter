# CurrencyConverter

## Introduction
`CurrencyConverter` is a simple app which displays list of all currencies fetched from fixer.io and allows conversion between different currencies.

## Installation
* Clone the repository
* Run CurrencyConverter.xcworkspace
* Build and Run

## Requirements

* iOS 13.0+
* Xcode 11.0+
* Swift 5.0+

## Questions And Answers

* I - ((3 + 1) / 3) * 9 = 12
* II / III - Both samples are included in the playground with the project (Fibonacci.playground / Anagram.playground)
* IV - I approached it using :-
  * MVVM
  * RxSwift (FRP)
  * Promises / Futures (On the network layer) (Avoid callback hell / pipelining the results on async opreations with ease)
  * Swinject / @Inject property wrapper (for dependency injection)
  * Repository design pattern (to group requests)
  
I chose MVVM + RxSwift mainly because the "reactive" nature of the project, it gets cumbersome at somepoint with architectures like MVP due to the amount of interfaces that needs to be created in order for everything to function correctly <br><br>
The motive behind Promises / Futures was to avoid completionhandlers / callback hell Future / Promise is a paradigm from NodeJS that avoids callback hells and allows for better pipelining of results and easy transformations (Fingers-crossed for async / await implementation in Swift 6 !).<br><br>
The networklayer included in the project is not written in RxSwift because this is my generic networklayer that I have been using in all of my projects and since I don't use Rx in my current on-going projects I just opted out for more "general" solution which can be integrated in any paradigm (reactive or not) <br><br>
The application also is heavily built upon Swinject and its conecpt of "Assembly" along with a property wrapper (@Inject) for automatic injection because doing manual dependency injection is very tedious and may have side effects in the future if you want to add a dependency for a specific class you'll have to change every class that instantiates this class
But with the combo of Swinject / @Inject property wrapper dependency injection is at ease (Swinject team is already working on their implementation of @Inject which will be called @Injected, once introduced this will be the equivalent of dagger2 in Swift).
