# FitPerfect-Senior-Project
Senior Project for NYIT:

This project was developed to provide fitness-based users with wearable devices a mobile platform that would display their fitness data, provide them with a fitness-oriented community to converse with through a newsfeed, and allow them to compete in challenges with any user with a fitness-oriented wearable device. The application was intended for users interested in fitness from all age groups who had a iPhone device running the iOS operating system 8.4 or higher. The application was implemented in Objective C with a MySQL database on a server and a PHP application to connect the database to the Objective C application.

To run this project, you must download Xcode 7.0 from the Apple Store and create an Apple developer account to see the HealthKit capabilities.

To run this project, perform the following steps:

1)Double-click the file called FitPerfect.xcodeproj in the code folder.

2) Once the project loads, go to the DataModel.m file in the View Controllers-->DataModel folder path and add your web server link to NSString* const BaseURLString. For example, http://grayson.com/webservices/

3) Create a database by running FitPerfectMain.sql on your server to create the database used in the project.

4)Select a simulator at the top of Xcode from the simulator selection dropdown menu. Choose the iPhone 6 Plus Simulator and click the “run” symbol to the left of the simulator selection dropdown menu.

5)The simulator will load the application and automatically open and run it.

6)To view HealthKit data, manually add the data to the Health app on the simulator.
