# FMNetwork

FMobile Developer Pack v5. The power of FMobile's latest engine, FMNetwork, in a simple Swift Package.

## Installation

Add `https://github.com/GroupeMINASTE/FMNetwork.swift.git` to your Swift Package configuration (or using the Xcode menu: `File` > `Swift Packages` > `Add Package Dependency`)

## Usage

```swift
// Import the package
import CoreTelephony
import FMNetwork

// Create a variable and intitialize FMNetwork with the SIM card type you want.
// You can use .current, .sim, or .esim.
// Keep in mind that if you use .current, the SIM card type that will be returned in the card.type property is very likely to change to 
let current = FMNetwork(.current)
let sim = FMNetwork(.sim)
let esim = FMNetwork(.esim)

// Then access the properies you want.
// The FMNetwork class is composed of two properties : card and network, giving you data about the SIM card itself and its connected network. For example:
if current.card.mcc == current.network.mcc {
    print("The card is in its home country!")
}

// To access the full documentation, you can use the Quick Help feature in Xcode. Simply Command + click on any item of FMNetwork you wrote (for example the first mcc), and click on Show Quick Help to view the entire documentation for that part of the code.
```


## Public structure of the FMNetwork class

FMNetwork: (contains every data about a SIM card and its connected network)
    * card: FMNetworkSIMData (contains every data about a SIM card)
        * active: Bool (returns true if the SIM card is inserted and in use)
        * name: String (returns the name of the SIM card carrier, "Carrier" by default)
        * mcc: String (returns the Mobile Country Code (MCC) of the SIM card carrier, "---" by default)
        * mnc: String (returns the Mobile Network Code (MNC) of the SIM card carrier, "--" by default)
        * land: String (returns the uppercased 2-digit ISO country code* of the SIM card carrier, "--" by default)
        * type: FMNetworkType (.sim, .esim or .current)
    * network: FMNetworkData (contains every data about the connected network of a SIM card)
        * name: String (returns the name of the connected network, "Carrier" by default)
        * mcc: String (returns the Mobile Country Code (MCC) of the connected network, "---" by default)
        * mnc: String (returns the Mobile Network Code (MNC) of the connected network, "--" by default)
        * land: String (returns the uppercased 2-digit ISO country code* of the connected network, "--" by default)
        * connected: String (Core Telephony [CTRadioAccessTechnology](https://developer.apple.com/documentation/coretelephony/cttelephonynetworkinfo/radio_access_technology_constants) constant, "" by default)

*There is an exception for International carriers. They might return the non-standardised 2-digits code "WD", standing for World.

### To access the full documentation, you can use the Quick Help feature in Xcode. Simply Command + click on any property of the FMNetwork item you wrote, and click on Show Quick Help to view the entire documentation for that code.

## Examples

### Coming soon.

## Donations

If you are feeling generous and want to give a little something to the developer, you can do that [here](https://paypal.me/PlugNPay). It's completely optionnal.

You can also donate to the non-profit organisation directly, to help us finance our bigger projects [here](https://www.helloasso.com/associations/groupe-minaste/formulaires/1).

