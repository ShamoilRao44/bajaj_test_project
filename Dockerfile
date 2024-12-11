# # Environemnt to install flutter and build web
# FROM debian:latest AS build-env

# # install all needed stuff
# RUN apt-get update
# RUN apt-get install -y curl git unzip

# # define variables
# ARG FLUTTER_SDK=/usr/local/flutter
# ARG FLUTTER_VERSION=3.19.5
# ARG APP=/app/

# #clone flutter
# RUN git clone https://github.com/flutter/flutter.git $FLUTTER_SDK
# # change dir to current flutter folder and make a checkout to the specific version
# RUN cd $FLUTTER_SDK && git fetch && git checkout $FLUTTER_VERSION

# # setup the flutter path as an enviromental variable
# ENV PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"

# # Start to run Flutter commands
# # doctor to see if all was installes ok
# RUN flutter doctor -v

# # create folder to copy source code
# RUN mkdir $APP
# # copy source code to folder
# COPY . $APP
# # stup new folder as the working directory
# WORKDIR $APP

# # Run build: 1 - clean, 2 - pub get, 3 - build web
# RUN flutter clean
# RUN flutter pub get
# RUN flutter build web

# # once heare the app will be compiled and ready to deploy

# # use nginx to deploy
# FROM nginx:1.25.2-alpine

# # copy the info of the builded web app to nginx
# COPY --from=build-env /app/build/web /usr/share/nginx/html

# # Expose and run nginx
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

# Environment to install Flutter and build web
FROM debian:latest AS build-env

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl git unzip xz-utils libglu1-mesa && \
    rm -rf /var/lib/apt/lists/*

# Define variables
ARG FLUTTER_SDK=/home/flutteruser/flutter
ARG FLUTTER_VERSION=3.24.3
ARG APP=/home/flutteruser/app

# Add a non-root user and switch to it
RUN useradd -m flutteruser
USER flutteruser
WORKDIR /home/flutteruser

# Clone Flutter
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_SDK
# Change dir to current Flutter folder and make a checkout to the specific version
RUN cd $FLUTTER_SDK && git fetch && git checkout $FLUTTER_VERSION

# Setup the Flutter path as an environmental variable
ENV PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"

# Start to run Flutter commands
# Doctor to see if all was installed ok
RUN flutter doctor -v

# Create folder to copy source code
RUN mkdir $APP
# Copy source code to folder
COPY --chown=flutteruser:flutteruser . $APP
# Set up new folder as the working directory
WORKDIR $APP

# Run build: 1 - clean, 2 - pub get, 3 - build web
RUN flutter clean
RUN flutter pub get
RUN flutter build web

# Use nginx to serve the Flutter build output
FROM nginx:1.25.2-alpine

# Copy the built web app to nginx
COPY --from=build-env /home/flutteruser/app/build/web /usr/share/nginx/html

# Expose and run nginx
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]