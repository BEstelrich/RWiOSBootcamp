<!-- Header -->
<img src="../Assets/W06_AppIcon.png" width="60" align="right"/>
<h1>Week 06. Collection views</h1>

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg?longCache=true&style=flat&logo=swift)](https://www.swift.org)
[![iOS](https://img.shields.io/badge/iOS-13.5+-lightgrey.svg?longCache=true&?style=flat&logo=apple)](https://developer.apple.com/ios/)


<!-- Body -->
## Frameworks/External dependencies
- Foundation
- UIKit


## Description
Lessons on week six were around collection-views and the different ways they can be implemented: **Flow Layout and Compositional Layout**. The purpose of this exercise was to use a TabBar to set two different collection-views presenting similar data. There was a requirement where our **collection-view will always display three columns of cells** no matter the device size the app is running into.

This proposal has been completed using the collection-view **Compositional Layout** for both cases and using a singleton to generate Pokemon characters from a `.csv` embedded file. A `DataManager` class has been used to **centralize the setup of collection-view data sources** and similarly a `LayoutCoordinator` object **configures our cells** for each scenario.


## Preview
Those are the most relevant screenshots of the app.

<p align="left">
	<img src="../Assets/W06_Screenshot1.png" height="500"/>
	<img src="../Assets/W06_Screenshot2.png" height="500"/>
</p>


<!-- Footer -->