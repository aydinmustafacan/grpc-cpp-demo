FROM ubuntu:22.04

# Copy pre-built binary from the host
COPY bazel-bin/examples/cpp/helloworld/greeter_server /usr/local/bin/greeter_server

CMD ["/usr/local/bin/greeter_server"]
