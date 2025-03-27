
# GPS App

A basic application that updates the current location of the user, and updates a few Kinematics namely current speed, max speed, average speed, acceleration and distance. 

Upon clicking the start button, the bottom label turns green, indicating the working of the application, while the top label over the map turns red, when the speed crosses 115km/h, signifying danger.

The one page application includes a title of Trip Summary and also a label. 
The units of display are :  
- Current Speed - km/h
- Max speed - km/h
- Average speed - km/h
- Distance - km
- Acceleration - m/s^2


## How to Use

Step 1 : Provide Permission

As soon as the application is launched, it asks for permission to location access with a message "Need location access".
The user may choose from the options : "Allow once", "Allow while using the app", "Dont allow".


Step 2 : Observe the launch page

When the application is launched first, the values of all the parameteres is set to 0 i.e. current speed : , max speed : 0km/h, average speed : 0km/h, acceleration : 0m/s^2, distance : 0km, and both the labels around the map i.e. top label and bottom label are grey in color.

Step 3 : Click on Start button

On click of start button, the bottom label turns green in color, indication the location is updating. Also, all the labels turn into updated informations.

Step 4 : Keep observing

When the current speed exceeds by 115 km/h, the top label turns red, signifying danger.

Step 5 : Click stop button

When the stop button is pressed, all the values turn to 0, i.e. 
current speed : 0km/h, max speed : 0km/h, average speed : 0km/h, acceleration : 0m/s^2, distance : 0km, and both the labels around the map i.e. top label and bottom label are grey in color, signifying that location is not updating now.





![Logo](gpsIcon.png)




## Screenshots

![Location Permission](Assets/Location)
![Start Button Clicked](Assets/Start)
![High Speed Alert](Assets/RedLabel)
![Stop Button Clicked](Assets/Stop)



## Tech Stack

**Client:** StoryBoard

**Server:** Swift


## Lessons Learned

- Basic working of GPS and location
- Permission access working
- Scope of working
- Application lifecycle


