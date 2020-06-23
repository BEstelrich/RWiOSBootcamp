<p align="left">
	<img src="./Assets/AppIcon.png" alt="App icon" width="60" maxHeight="60" align="right"/>
	<h1>Week 03. Swift functions and types</h1>
</p>


<p align="left">
  <a href="https://www.swift.org">
		<img src=https://img.shields.io/badge/Swift-5.0-green.svg?longCache=true&style=flat-square] alt="Swift version">
  </a>
  <a href="https://developer.apple.com/ios/">
		<img src="https://img.shields.io/badge/iOS-13.5+-blue.svg?longCache=true&style=flat-square]" alt="iOS version" />
  </a>
  <a href="https://twitter.com/BEstelrichS">
	<img src="https://img.shields.io/badge/Contact-@BEstelrichS-lightgrey.svg?style=flat" alt="Twitter: @BEstelrichS" />
  </a>
</p>

## Frameworks
* UIKit


## Description
This short project is about creating an app called Cryptly that **displays some cryptocurrencies** prices generated from an embedded JSON file.

Starting from a Singleton object that generates a simulated cryptocurrency data, the model object it's created to accommodate this data. To set the view up, a data parsing has been done on the model instance by using **Higher Order Functions** in order to filter the correspondent information on each view.

On the order hand, **theme support** is implemented by creating a protocol that defines the theme requirements. An object that conforms to this protocol is being passed to the `Theme Manager` Singleton triggering an observer from the view-controller that takes care of the theme application itself.

Finally, an additional protocol called `Roundable` is set to define any view with **rounded corners**. Also default rounded method is provided by **overloading a protocol required method**.


## Preview
Those are the most relevant screenshots on the app.

<p align="left">
	<img src="./Assets/Screenshot1.png" alt="Screenshot 1" align="top" height="500" style="margin: 10px" />
	<img src="./Assets/Screenshot2.png" alt="Screenshot 2" align="top" width="500" style="margin: 10px"/>
</p>
