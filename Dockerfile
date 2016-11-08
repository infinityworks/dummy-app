FROM readytalk/nodejs
RUN mkdir /app
ADD . /app
WORKDIR /app
EXPOSE 3000
CMD node index.js
