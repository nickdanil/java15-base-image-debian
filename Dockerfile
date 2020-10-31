FROM openjdk:15-jdk-slim as jlink-package
# Generate java runtime module by jlink.

RUN jlink \
    --module-path /opt/java/jmods \
    --compress=2 \
    --add-modules jdk.jfr,jdk.management.agent,java.base,java.logging,java.xml,jdk.unsupported,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
    --no-header-files \
    --no-man-pages \
    --output /opt/jdk-15-mini-runtime

# Second: generate run image.
FROM debian:stretch-slim

COPY --from=jlink-package /opt/jdk-15-mini-runtime /opt/jdk-15-mini-runtime

ENV JAVA_HOME=/opt/jdk-15-mini-runtime
ENV JAVA_HOME_CACERTS=/opt/jdk-15-mini-runtime/lib/security/cacerts
ENV PATH="$PATH:$JAVA_HOME/bin"

RUN apt-get update
RUN apt-get install -y curl ca-certificates

