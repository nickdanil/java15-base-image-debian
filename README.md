# java15-base-image-debian

## how to create your image based on the java15-base-image-debian
```
FROM nickdanil/java15-base-image-debian
COPY target/java-15-example-0.0.1-SNAPSHOT.jar /opt/spring-boot/app.jar
CMD java \
    -jar /opt/spring-boot/app.jar \
```
