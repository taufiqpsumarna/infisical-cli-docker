## infisical-cli-docker
The Infisical CLI is powerful command line tool that can be used to retrieve, modify, export and inject secrets into any process or application as environment variables. You can use it across various environments, whether it’s local development, CI/CD, staging, or production.

### Overview
This Dockerfile creates a lightweight container using the **Alpine 3.22.2** base image and installs the **Infisical CLI** with a specified version. The Dockerfile ensures a minimal image size by using Alpine Linux and cleaning up unnecessary files after installation.

### Build Arguments
- **INFISICAL_VERSION**: Defines the version of Infisical CLI to install. The default version is `0.43.32`, but this can be overridden at build time.

### Steps Explained

1. **Base Image**:  
   The Dockerfile uses `alpine:3.22.2` as the base image, which is known for its small size and efficiency.

   ```dockerfile
   FROM alpine:3.22.2
   ```

2. **Build Argument**:  
   Defines a build argument for the Infisical version, defaulting to `0.43.32`. You can customize the version during the build.

   ```dockerfile
   ARG INFISICAL_VERSION=0.43.32
   ```

3. **Installing Dependencies**:  
   The Dockerfile installs the following dependencies:
   - `curl`: To download the installation script.
   - `gnupg`: For signature verification (if required by the script).
   - `bash`: To run the installation script.

   ```dockerfile
   RUN apk --no-cache add curl gnupg bash \
   ```

4. **Infisical CLI Installation**:  
   The Infisical CLI is installed using a setup script hosted on Cloudsmith. The installation is done via `curl`, and the version is specified using the `INFISICAL_VERSION` argument.

   ```dockerfile
   && curl -1sLf 'https://dl.cloudsmith.io/public/infisical/infisical-cli/setup.alpine.sh' | bash \
   ```

5. **Installing Infisical**:  
   Installs the Infisical CLI based on the version defined in the `INFISICAL_VERSION` argument.

   ```dockerfile
   && apk --no-cache add infisical=${INFISICAL_VERSION} \
   ```

6. **Cleaning Up**:  
   To minimize the final image size, temporary files and package manager caches are removed.

   ```dockerfile
   && rm -rf /var/cache/apk/* /tmp/* /var/lib/apt/lists/*
   ```

### Build the Image

To build the Docker image, use the following command. You can specify a different Infisical version by passing the build argument:

```sh
docker build --build-arg INFISICAL_VERSION=0.43.32 -t infisical-image .
```

This command will build the image with Infisical version `0.43.32`. If you don't provide a version, it defaults to `0.43.32`.

### Usage

Once the image is built, you can run a container based on this image:

```sh
docker run -it infisical-image infisical --help
```

This command runs the Infisical CLI inside the container.


- [Infisical CLI Docs](https://infisical.com/docs/cli/overview)
- [Github Repository](https://github.com/taufiqpsumarna/infisical-cli-docker)
