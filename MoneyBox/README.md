# Project submission

## Specs
- Built with Xcode Version 14.3.1 (14E300c) 
- Supports iOS 13 as the minimum target however I couldn't get a simulator below iOS 14 to test against


## Features
- Login Page
- Product List 
- Product Detail

## Out of scope
- Localisation
- Access to colors through the Theme, I just hard coded the color name at each callsite for project simplicity
- Loading & Error handling
  - Didn't build visual loading states in the UIKit screens, but showed in the SwiftUI implementations how the state on the ViewModel could be used for handling this.
  - Error handling is implemented in some places but not all, the ViewModels are coded to show how this would be handled

## Additionals
- Showcased reusing a ViewModel to create SwiftUI versions of the Login page and the Product List. These can be previewed in the Canvas
- Created a Package to hold common UI elements and showcased how newer APIs could be adopted while maintaining a lower iOS target. 
  - e.g the MBButton makes use of UIButton.Configuration when above iOS 15
- Light/Dark mode support 
- Mostly supports resizing for acccessibility with the exception of UITextField. And the labels in the UICollectionViewCell will eventually truncate.

## Dependencies
- CombineCocoa
  - I made use of one dependency so I could use Combine for Cocoa elements. I wanted to be able to subscribe to a textPublisher for the email/password fields and a tapPublisher for the buttons but iOS doesn't provide this out of the box sadly.
  - To implement without the dependency I would implements the delegate pattern for UITextfield and add a target for handling button taps.

