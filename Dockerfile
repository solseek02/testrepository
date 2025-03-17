FROM openjdk:17-jdk-slim
COPY . /app
WORKDIR /app
RUN javac Main.java
CMD ["java", "Main"]
