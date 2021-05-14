# GoBabyGo-Mobile #
OSU Capstone Go Baby Go mobile app
Evie May, Aishwarya Vellanki, Thomas Weathers, Christien Hotchkiss, Nicholas Van Domelen
estimated completion: June 2021

to start running the API run:
python app.py

The rest of the code can be compiled and ran in android studio or xcode once API is running.

## Organization ##
Different screens of the app are found in the lib/ directory as ".dart" files. These files are all developed in flutter and make up the structure of the application. 
* lib/ : the main screens of the app, as ".dart" files
* assets/ : images, fonts, and assets for the application
* android/ : android configuration files
* IOS/ : IOS configuration files
* Build/ : general app configuration and build files

## Background ##
GoBabyGo is a nonprofit who helps provide alternative powered mobility devices (in the form of modified toy ride-on-cars) to children with disabilities. This app aims to We aim to improve the communication and socialization between members and families involved with GoBabyGo and provide a central organized location of information for GoBabyGo with the development of an IOS mobile application. An IOS mobile application will allow clinicians, administrators, therapists, families, and prospective researchers to access the larger GoBabyGo community for improved use of the modified ride-on-cars, improved interaction among families and clinicians, and easily accessible information and research. This could include ideas from clinicians and other families to improve consistent use of the vehicles, ideas to improve use of the modified ride-on-cars in difficult environments, and many more.

## Features ##
* Cross platform functionality for IOS and Android via Flutter
* Resources page for GoBabyGo resources for families, clinicians, and administrators
* Time tracking capability with a stopwatch or by logging time manually for consistent/improved use of modified ride-on-cars
* Educational content for more productive and fun use of the modified ride-on-cars

## Technical Specifications ##
* Flutter for Front-end
* Firebase for datastore

## TroubleShooting ##
* "flutter clean"
* "flutter pub get"
