FROM alpine:3.19.1

LABEL maintainer="Mad Pete Guy"

# Update and install git.
ENV DEBIAN_FRONTEND=noninteractive

RUN apk add --update --no-cache openssh git curl jq openjdk11 && \
    ssh-keygen -A && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /var/run/sshd && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
RUN adduser -h /home/jenkins -s /bin/sh -D jenkins && \
    echo -n 'jenkins:jenkins' | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
