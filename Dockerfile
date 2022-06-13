FROM ubuntu:22.10

WORKDIR /app

RUN mkdir -p /app/data

RUN apt-get update && apt-get install -y wget gnupg

RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - && \
    echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
    apt-get update && \
    apt-get install cf7-cli

RUN cf install-plugin -f conduit

COPY ./scripts /app/scripts
