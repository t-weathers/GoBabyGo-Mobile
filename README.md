# GoBabyGo-Mobile #
Oregon State Univeristy Capstone Go Baby Go mobile app
Evie May, Aishwarya Vellanki, Thomas Weathers, Christien Hotchkiss, Nicholas Van Domelen
estimated completion: June 2021

## Background ##
GoBabyGo is a nonprofit who helps provide alternative powered mobility devices (in the form of modified toy ride-on-cars) to children with disabilities. This app aims to We aim to improve the communication and socialization between members and families involved with GoBabyGo and provide a central organized location of information for GoBabyGo with the development of an IOS mobile application. An IOS mobile application will allow clinicians, administrators, therapists, families, and prospective researchers to access the larger GoBabyGo community for improved use of the modified ride-on-cars, improved interaction among families and clinicians, and easily accessible information and research. This could include ideas from clinicians and other families to improve consistent use of the vehicles, ideas to improve use of the modified ride-on-cars in difficult environments, and many more. This project utilizes Flutter for Front-end development and Google Firebase for the backend and databse. 

## Features ##
* Cross platform functionality for IOS and Android via Flutter
* Resources page for GoBabyGo resources for families, clinicians, and administrators
* Time tracking capability with a stopwatch or by logging time manually for consistent/improved use of modified ride-on-cars
* Educational content for more productive and fun use of the modified ride-on-cars

<p align="center">
  <img src="videoPreview.gif" alt="animated" />
</p>


## Installation ##
This Application is currently only available to run on your local machine using a virtual simulator

* First, install [Flutter](https://flutter.dev/docs/get-started/install) onto your local machine
* Second, choose your preferred IDE that supports mobile app simulators, we recommend [Android Studio](https://developer.android.com/studio)
* Third, download this repository locally
* Finally, Run this repository using your preferred IDE with an Iphone or Android Simulator

## Organization ##
Different screens of the app are found in the lib/ directory as ".dart" files. These files are all developed in flutter and make up the structure of the application. 
* lib/ : the main screens of the app, as ".dart" files
* assets/ : images, fonts, and assets for the application
* android/ : android configuration files
* IOS/ : IOS configuration files
* Build/ : general app configuration and build files

## Support ##
Please add an [Issue](https://github.com/t-weathers/GoBabyGo-Mobile/issues) for bugs that you experience using the application. For further questions about the application, please contact us at [gobabygoapp@gmail.com](mailto:gobabygoapp@gmail.com). 

## TroubleShooting ##
* For issues where packages dont seem to be appearing when they have been already imported, run "flutter clean" then "flutter pub get"

## Authors and Acknowledgements ##
GoBabyGo Oregon is the founder of this project, under the developmental guidance of the Oregon State University 2020/2021 Computer Science Capstone course(s). Software Contributors include: Aishwarya Vellanki, Evie May, Christien Hotchkiss, Nicholas Van Domelen, and Thomas Weathers

## Project Status ##
This project is on temporary hold as the capstone course is being completed, before it is transferred to a new team for further development. Our next goal is to submit the application for use on the Apple Store and Google Play Store. 
