FROM adoptopenjdk/openjdk16:x86_64-alpine-jre-16.0.1_9


WORKDIR /bag

RUN mkdir -p ./out
COPY ./out/ui ./out/ui
COPY ./out/*.jar ./The-Client.jar

EXPOSE 3000

ENTRYPOINT ["java", "-jar", "The-Client.jar"]
