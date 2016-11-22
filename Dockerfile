FROM satellite-eu.bpweb.bp.com:5000/rhscl/nodejs-4-rhel7
ADD . /opt/app-root
WORKDIR /opt/app-root
EXPOSE 3000
CMD node index.js
