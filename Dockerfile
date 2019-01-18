FROM ynohat/git-http-backend

RUN apk update && apk add --no-cache \
    openssh-client

COPY run.sh run.sh

CMD ./run.sh