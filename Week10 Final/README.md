# Gallery Eveywhere

## Introduction, Concept, Inspiration

This project was adopted from a previous project of mine that I made with my teammate Sammuel Fung for the class Augmented Gallery, Spring 2023, at NYU Berlin. This project emdodies the idea of participatory museum and explores the roles and landscapes of museums, galleries, and exhibitions as spaces for creativity, inclusion, personal expression, and collective efforts. The inspiration of this project comes from a similar offline project called DIY Archive at a Dutch museum. In this project, the museum and curators invited visitors to select works of art from their collections and hang them onto the walls. People were free to choose any of the works they liked and did not necessarily have to worry about the theme. Moreover, they were able to take down others' selections or rearrange the works. In my project, Gallery Everywhere, through Augmented Reality (AR) technology, it aims to provide a similar creative curatory experience for the general user (those who are not working in or have no prior knowledge about curations) without the constraint of their physical environments. They could experience this project in any place as long as there are walls to hang the artworks. 

## UI/UX Design

The general theme of the design is minimalistic as I want the user to focus more on the artwokrs and their arrangement in the virtual environment. Therefore, the UI design is consistent with the naive iOS elements and styles.

The APP starts with an onboarding tutorial (under development). After the onbording, the user will be seeing their physical environment through their camera. The cross (anchor) in the center of the screen indicates the location where the work will be placed on the wall after the user clicks at the Add button. The idea here is that when the user clicks on the Add button, the center anchor will be created so that the user will not have to hold their phone steady all the time when choosing the art they like. This, I hope, could make the UX experience more intuitive and comfortable.

When the user sees the art gallery after clicking on the Add button, they can scroll down to see the entire gallery. For each of the work, they can click on it and see details, including its name, artist, year, and descriptions. Additional, they can be directed to the Chicago Institute of Art to read full information about the work they are interested in.

After they read the information about the work of their choice, they can click on the Select button to add this art to their virtual space. The work will appear on the location of the anchor when they click on the Add button. In the virtual environment, they are able to move the work of art with one finger and scale it with two fingers. They can also delete the work if you would like to (under development).

## Implementation

This project is developed using SwiftUI, RealityKit, and ARKit.
