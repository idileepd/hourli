# Hourli

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

![Test Image 4](https://i.ibb.co/ZzpGmyg/the-Creative-Process.png)

Hourli is a task traking app with extra features that you can ask some one watch your tasks they will get notified when do or drop any specific tasks. You will be shown weekly and daily progress all your watching can be ranked against you. You will have timeline that is where all task logs present.

  - Task Traking
  - Activity loging
  - Watching tasks of others and get notified
  - Make your tasks watachable
  - Ranking based on tasks score (minutes spend)

### App Screens
![App UI 1](https://i.ibb.co/XV1xmsw/11.png)
![App UI 2](https://i.ibb.co/Vx0KRb9/12.png)

### Working Demo
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/SmCEMnMEQd4/0.jpg)](https://www.youtube.com/watch?v=SmCEMnMEQd4)


### Future Features!
  - Privacy
  - Task Groups



### Configurations
- genereate release key
```keytool -genkey -v -keystore hourli.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias hourli```

- to read jsk sha
```keytool -list -v  -keystore hourli.jks```
- release config : key.properties + add this in android/app folder 
- [Complete release info](https://flutter.dev/docs/deployment/android)
- [Complete release from begin to end](https://dzone.com/articles/keytool-commandutility-to-generate-a-keystorecerti)

