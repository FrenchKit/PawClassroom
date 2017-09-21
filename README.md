# From API Description to Tests & Mocks

[Download Slides](FrenchKit 2017 Paw Workshop.pdf)

## Introduction

Introducing how to create HTTP stubs for your application and/or unit or UI tests. We're using the [Mockingjay](https://github.com/kylef-archive/Mockingjay) library in Swift to create these mocks.

* Level: **beginner**
* *Workshop at [FrenchKit 2017](http://frenchkit.fr/) conference.*

### Prerequisites

* Your Mac
* Xcode 8 or 9
* A bit of Swift…
* [Paw](https://paw.cloud) *(get the 30 days trial)*

### Today’s Agenda

* Intro & Presentation
* A simple [XKCD](https://xkcd.com/) client app with [Alamofire](https://github.com/Alamofire/Alamofire)
* Build mocks with [Mockingjay](https://github.com/kylef-archive/Mockingjay)
* A simple [Instagram](https://www.instagram.com/) client app
* Create unit + UI tests with mocks

## A – XKCD client app

1. Build a client app for the XKCD website (using their API)
2. Mock the API to make the tests pass independently from the API

## B – Instagram API with the help of Paw

1. Import the Instagram API in Paw File > Import > Find API Template
2. [Create a new Instagram client app](https://www.instagram.com/developer/clients/register/)
3. Generate Alamofire code [snippets with Paw](https://paw.cloud/extensions/SwiftAlamofireCodeGenerator)

## C – Integrate with Tests

Use the Instagram app for that, set up tests for each feature, and people can implement the stubs.

1. Use Paw to generate mocks from an existing response
2. Write basic unit tests, write mocks to test the API
3. Reuse the existing UI tests, write API mocks to test the API
4. Add reliable validation of UI components

## D – Swift 4 + JSONEncoder

1. Switch code and tests to use `JSONDecoder` *(Swift 4 only)*

## E – JSON Schema Validation

1. Example of what JSON Schema is and used for
2. Add validation to your app to assert the server results
