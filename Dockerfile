FROM ubuntu:22.04

# Copy pre-built binary from the host
COPY ./greeter_server /usr/local/bin/greeter_server

CMD ["/usr/local/bin/greeter_server"]
