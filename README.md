# hourli


- genereate release key
```keytool -genkey -v -keystore hourli.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias hourli```

- to read jsk sha
```keytool -list -v  -keystore hourli.jks```
- release config : key.properties + add this in android/app folder 
- [Complete release info](https://flutter.dev/docs/deployment/android)
- [Complete release from begin to end](https://dzone.com/articles/keytool-commandutility-to-generate-a-keystorecerti)

