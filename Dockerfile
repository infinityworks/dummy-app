FROM mhart/alpine-node-auto:6.6
RUN mkdir /app
ADD . /app
EXPOSE 3000
CMD node index.js
