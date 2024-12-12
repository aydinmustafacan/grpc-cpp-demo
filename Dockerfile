# Stage 1: Build the C++ application
FROM --platform=linux/amd64 ubuntu:22.04 AS build

# Install essential build dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    zip \
    python3 \
    python3-pip \
    build-essential \
    libtool \
    make \
    git \
    openjdk-11-jdk \
    bash \
    ca-certificates \
    autoconf \
    pkg-config \
    && apt-get clean

# Verify the correct GCC version is being used (11.x)
RUN gcc --version && g++ --version

# Install Bazel 6.1.1 for x86_64
RUN curl -fLo /usr/local/bin/bazel https://github.com/bazelbuild/bazel/releases/download/6.1.1/bazel-6.1.1-linux-x86_64 && \
    chmod +x /usr/local/bin/bazel

# Verify Bazel installation
RUN bazel version

# Create and set the working directory
WORKDIR /app

# Copy the project files into the container
COPY . .

# Build the client target using Bazel
RUN bazel build //examples/cpp/helloworld:greeter_server --verbose_failures

# Stage 2: Create a lightweight runtime image
FROM --platform=linux/amd64 ubuntu:22.04 AS runtime

# Copy the compiled binary from the build stage
COPY --from=build /app/bazel-bin/greeter_server /usr/local/bin/greeter_server

# Set default command to run the binary
CMD ["/usr/local/bin/greeter_server"]
