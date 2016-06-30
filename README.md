[![Build Status](https://travis-ci.org/RobinHeathcote/Motivation.svg?branch=master)](https://travis-ci.org/RobinHeathcote/Motivation)
[![Coverage Status](https://coveralls.io/repos/github/RobinHeathcote/Motivation/badge.svg?branch=master)](https://coveralls.io/github/RobinHeathcote/Motivation?branch=master)

#Motivation App

Motivation is an app built in two weeks with a remote team of members from Australia, Vietnam and the UK.  Its aim is to help users reach their goals without requiring any effort through gentle nudges and reminders when they need them. Users will input their goals (known as wishes), state a desired outcome, and the create obstacles and plans to help them achieve their wish. This follows the WOOP psychological method.

## Early Stages

During the design phase the team highlighted the need for a platform agnostic app as at some point a mobile app would need to be built. Our decision was to build a Rails API that could handle JSON and connect to a front end be it mobile, web app or native app. This was a new approach to the team, as was the decision to use a token authentication system to handle user log-in. Through co-ordinated research this was successfully achieved. 

Our MVP included a fully tested and functional API and a functional [Web App](https://github.com/letianw91/motivation-angular)

To implement the app, the team use a Agile workflow and utilised XP practices to create clean code that is test driven.


##Project team:
* [Robin Heathcote](https://github.com/RobinHeathcote)
* [Letian Wang](https://github.com/letianw91)
* [Maria Romero](https://github.com/MariaRomero)
* [Lexi Tran](https://github.com/lexiht)

##Install Instructions
Fork and clone this repo
In the terminal shell type:

```` 
$ cd Motivation
$ bundle
$ createdb motivation_test
$ createdb motivation_development
$ bin/rake db:migrate
$ rails server
```` 

if you want to test it:
````
$ rake db:setup
$ rspec
````

##User stories
    
    ```
    As a user,
    so I can get motivation,
    I want to be able to add a goal(basic)
    ```
    
    ```
    As a user,
    so I can track obstacles to achieving my goal,
    I want to be able to add obstacles to my goal(basic)
    ```
    
    ```
    As a user,
    so I can overcome obstacles,
    I want to be able to add plans to overcome obstacles(basic)
    ```
    
    ```
    As a user,
    so I can be reminded of my plans,
    I want to receive notifications of my plan when appropriate(basic)
    ```
    
    ```
    As a user,
    so I can be reminded of my plans,
    I want to receive notifications based on my location (notification, depend on 4)
    ```
    
    ```
    As a user,
    so I can be reminded of my plans at an appropriate time,
    I want to receive notifications based on weather (notification, depend on 4)
    ```
    
    ```
    As a user,
    so I can be reminded of my plan at an appropriate time,
    I want to receive notification based on time (notification, depend on 4)
    ```
    
    ```
    As a user,
    so I can access the service easily,
    I want to be able to add a goal by voice (input, dependent on basic)
    ```
    
    ```
    As a user,
    so I can have other people support my goal,
    I want to be able to invite people to follow a goal (social, depend on the basics)
    ```
    
    ```
    As a follower of a goal,
    so I can support the owner of the goal,
    I want to be able to like the goal(social, depend on the basics)
    ```
    
    ```
    As a follower of a goal,
    so I can offer advice and support to the owner of the goal,
    I want to be able to comment on a goal(social, depend on the basics)
    ```
    
## Basic Doodle of project idea
 ![doodle](https://www.dropbox.com/s/vsdp1cfb1st7rjo/Whiteboard%5B3%5D.png?raw=1)

##WOOP (Wish Outcome Obstacle Plan) integration 
![woop](https://www.dropbox.com/s/hrg26cb3tad7lhm/Untitled%20Diagram.png?raw=1)

##Mockups
![mockups](https://www.dropbox.com/s/7ivzndl8ppkkk0n/Motivation.png?raw=1)

##Technology
+ Ruby on Rails
+ Rspec
+ PostgresSQL
+ Active Record
###User authentication
devise_token_auth: https://github.com/lynndylanhurley/devise_token_auth#usage-tldr


