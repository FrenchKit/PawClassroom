# From API Description to Tests & Mocks

[Download Slides](https://github.com/FrenchKit/PawClassroom/blob/master/FrenchKit%202017%20Paw%20Workshop.pdf)

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

1. Introducing the Instagram API
2. Import the Instagram API in Paw File > Import > Find API Template
3. [Download ready-to-go Paw file](https://github.com/FrenchKit/PawClassroom/blob/master/FrenchKit%20Paw%20Classroom.paw)
4. Generate Alamofire code [snippets with Paw](https://paw.cloud/extensions/SwiftAlamofireCodeGenerator)
5. Build & run
6. [Create a new Instagram client app](https://www.instagram.com/developer/clients/register/) – load your own Instagram feed

## C – Integrate with Tests

Use the Instagram app for that, set up tests for each feature, and people can implement the stubs.

1. Build a unit test case for `Instagram.loadImages(tag:, count:)`
2. Use Paw to generate mocks from an existing response. Install [Mockingjay Code Generator](https://paw.cloud/extensions/MockingjayGenerator)
3. Write mocks to test the API

## D – JSON Schema Validation

1. Example of what JSON Schema is and used for
2. Add validation to your app to assert the server results
