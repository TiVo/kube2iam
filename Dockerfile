# builder image
FROM golang as builder

WORKDIR /go/src/github.com/jtblin/kube2iam
COPY . .

RUN make setup
RUN make cross

# final image
FROM alpine:3.7

RUN apk --no-cache add \
    ca-certificates \
    iptables

COPY --from=builder /go/src/github.com/jtblin/kube2iam/build/bin/linux/kube2iam /bin/kube2iam

ENTRYPOINT ["/bin/kube2iam"]
