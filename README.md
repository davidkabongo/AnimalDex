---
title: README

---

Animal-Dex

Table of Contents
1. Overview
2. Product Spec
3. Wireframes
4. Schema
5. Overview
6. Description

Animal-Dex is an on-the-go encyclopedia of animal facts. Users can look up whatever animal they want and get basic and advanced information. They can save their favorite animals for later fact reference

App Evaluation
[Evaluation of your app across the following attributes]

Category: Reference
Mobile:
Story:
Market:
Habit:
Scope:
Product Spec
1. User Stories (Required and Optional)
Required Must-have Stories

	- Search for Animal Information -> As a user, I want to search for an animal by name, so that I can quickly access basic and advanced facts about it.
    
    - View Detailed Animal Facts -> As a user, I want to see detailed information about an animal, including habitat, diet, lifespan, and unique characteristics, so that I can learn more about it.
    
    - Save Favorite Animals -> As a user, I want to save animals to my favorites list, so that I can easily find and reference their information later.

2. Screen Archetypes
    - Home - Users can see recently searched animals.
    - Search - Users can look up animals by name
    - Favorites – Users can store their animals in a favorites collection

3. Navigation


Tab Navigation (Tab to Screen)
* Home Screen (Recently searched)
* Search Screen
* Favorites
    
Flow Navigation (Screen to Screen)

* Home Screen => When selecting an animal, you go to a detailed view
* Search Screen => When selecting an animal, you go to a detailed view
* Favorites Screen => When selecting an animal, you go to a detailed view


Wireframes


Schema
[This section will be completed in Unit 9]

Model(s)


| Model  | 
|--------|
| Animal |



Networking
* On the search screen, I am making a call to an animal information API from API Ninjas.
* On the detail screen, I am making the same call but I am also making a call to the Unsplash API for animal images

Demo Video
<div>
    <a href="https://www.loom.com/share/dc6d5199e0534b9d992927fd8243956e">
    </a>
    <a href="https://www.loom.com/share/dc6d5199e0534b9d992927fd8243956e">
      <img style="max-width:300px;" src="https://cdn.loom.com/sessions/thumbnails/dc6d5199e0534b9d992927fd8243956e-eee63a9cb11dcfac-full-play.gif">
    </a>
  </div>
