FROM alpine:3.22.2

# Define build-time argument for Infisical version
ARG INFISICAL_VERSION=0.43.32

# Install dependencies, add Infisical CLI, and clean up in a single layer
RUN apk --no-cache add curl gnupg bash \
    && curl -1sLf 'https://dl.cloudsmith.io/public/infisical/infisical-cli/setup.alpine.sh' | bash \
    && apk --no-cache add infisical=${INFISICAL_VERSION} \
    && rm -rf /var/cache/apk/* /tmp/* /var/lib/apt/lists/*
