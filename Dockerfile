FROM registry.access.redhat.com/rhscl/nodejs-4-rhel7
ADD . /opt/app-root
WORKDIR /opt/app-root
EXPOSE 3000
CMD node index.js
