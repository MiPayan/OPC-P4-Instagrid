# OPC-P4-Instagrid

<b>Project 4: Instagrid, a photo editing application.</b>

Instagrid is an iPhone app that allows users to combine photos by choosing from several layouts. The end result is square and can be shared with friends.


<p align="center">
  <img width="185" height="400" src="https://user-images.githubusercontent.com/71004452/134163640-e7426ea2-15cf-4057-8603-84c3a298424a.png">
</p>
<br />
<br />
<br />

<b>I. Arrangement of photos</b>

The photos are organized according to a layout that the user can choose. The three available layouts are recalled below:
<br />
<br />

<p align="center">
  <img width="200" height="73" src="https://user-images.githubusercontent.com/71004452/134168598-9e1cd832-eec2-4901-82c1-bfce0cb1561c.png">
</p>
<br />

By tapping on one of these provisions:
<br />
        <br /> • The previous selected layout is no longer marked as selected.
        <br /> • The typed selection is marked as selected.
        <br /> • The central grid (in dark blue) adapts to the new layout.
<br />
<br />
<br />
<br />

<b>II. Adding Photos</b>

By tapping a plus button, the user has access to his photo library and can choose one of the photos from his phone. Once chosen, it takes the place of the box corresponding to the more typed button.
<br />
<br />

<p align="center">
  <img width="185" height="400" src="https://user-images.githubusercontent.com/71004452/134170295-55f548a3-be2a-419c-aa75-c7a2755920f0.mp4">
</p>
<br />
<br />

The photo must be centered, without being altered (the proportions are maintained) and take as much space as possible (no “white”). If the user clicks on a photo in the grid, he can choose a new image in the photo library to replace it.
<br />
<br />
<br />

<b>III. Swipe to share</b>

The user can share the creation he has just created. For this he can make a swipe up (in portrait mode) or left (in landscape mode).
The Swipe launches an animation that swipes the main view up or left until it disappears from the screen.
Once the animation is complete, the UIActivityController view displays and allows the user to choose their preferred application to share their creation.
<br />
<br />

<p align="center">
  <img width="185" height="400" src="https://user-images.githubusercontent.com/71004452/134172478-56288716-a3e7-4648-9530-2b62c083b924.mp4">
</p>
<br />
<br />

Once the share is done, cancelled or failed, the main grid automatically returns to its original place by the reverse animation.
