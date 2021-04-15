FROM node:14-alpine
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
COPY entrypoint.sh /entrypoint.sh
COPY lib/actions/checkout/index.js /checkout.js
ENTRYPOINT ["/entrypoint.sh"]
