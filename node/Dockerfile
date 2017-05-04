FROM snowhigh/teumaster-base

RUN apt-get install -y iptables lsb-release upstart && \
    apt-get clean

RUN useradd -ms /bin/bash ubuntu && \
    sudo -u ubuntu mkdir -p /home/ubuntu/.ssh && \
    chmod 700 /home/ubuntu/.ssh && \
    sudo -u ubuntu touch /home/ubuntu/.ssh/authorized_keys && \
    chmod 600 /home/ubuntu/.ssh/authorized_keys && \
    echo 'ubuntu:!Q@W3e4r' | chpasswd && \
    adduser ubuntu sudo && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ubuntu

ENV HOME /home/ubuntu
WORKDIR /home/ubuntu

ADD run.sh /run.sh
CMD ["/run.sh"]
