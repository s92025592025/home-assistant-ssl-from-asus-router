ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk update
RUN apk add openssh

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]