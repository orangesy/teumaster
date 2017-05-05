FROM snowhigh/teumaster-base

RUN apt-get install -y iptables lsb-release rsyslog grub-common apt-transport-https && \
    apt-get clean

RUN useradd -ms /bin/bash ubuntu && \
    sudo -u ubuntu mkdir -p /home/ubuntu/.ssh && \
    chmod 700 /home/ubuntu/.ssh && \
    sudo -u ubuntu touch /home/ubuntu/.ssh/authorized_keys && \
    chmod 600 /home/ubuntu/.ssh/authorized_keys && \
    echo 'ubuntu:!Q@W3e4r' | chpasswd && \
    adduser ubuntu sudo && \
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ubuntu

RUN touch /kernel-logging-setup
ENV HOME /home/ubuntu
WORKDIR /home/ubuntu

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV CEPH_CONF /home/ubuntu/ceph_config/ceph.conf
RUN sudo -u ubuntu mkdir /home/ubuntu/ceph_config
ADD sbin/* /usr/local/sbin/

ADD run.sh /run.sh
CMD ["/run.sh"]
