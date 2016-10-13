FROM mhart/alpine-node-auto:6.6
RUN mkdir /app
ADD . /app
WORKDIR /app
EXPOSE 3000
CMD node index.js
