#!/bin/bash
FROM maven:3.8.3-adoptopenjdk-11@sha256:22a19189017f08cb45f420bb93e820e5bde687b5b37f47be3d3924695276816e AS builder

WORKDIR /build
COPY . .
RUN mvn clean package -DskipTests

FROM adoptopenjdk:11.0.11_9-jre-openj9-0.26.0-focal@sha256:db3504a5a4c1572c0879027cf5124a5598318aaecefbb9971d80d9a3ba98b0a5

WORKDIR /opt/app

RUN groupadd --system javauser && useradd -s /usr/sbin/nologin -g javauser javauser
COPY --from=builder /build/target/*.jar app.jar

RUN chown -R javauser:javauser .

USER javauser

HEALTHCHECK --interval=30s --timeout=3s --retries=1 CMD wget -qO- http://localhost:8080/actuator/health/ | grep UP || exit 1

ENTRYPOINT ["java", "-jar", "app.jar"]