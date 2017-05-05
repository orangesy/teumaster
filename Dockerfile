FROM snowhigh/teumaster-base

RUN apt-get install -y nginx qemu-utils libssl-dev libev-dev libvirt-dev libmysqlclient-dev libffi-dev libyaml-dev lsb-release python-pip && \
    apt-get clean

RUN cd /root && \
    mkdir -p /opt/archive/worker_logs && \
    mkdir -p /root/src && \
    git clone https://github.com/ceph/teuthology.git /root/src/worker && \
    /bin/bash -c "pushd src/worker/; ./bootstrap;" && \
    cd /root && \
    git clone https://github.com/ceph/teuthology.git /root/src/teuthology && \
    /bin/bash -c "pushd src/teuthology/; ./bootstrap;"

ADD nginx_test_logs /etc/nginx/sites-available/nginx_test_logs
RUN ln -s /etc/nginx/sites-available/nginx_test_logs /etc/nginx/sites-enabled/ && \
    rm /etc/nginx/sites-enabled/default

RUN /bin/bash -c "source /root/src/worker/virtualenv/bin/activate; pip install requests==2.12.5; pip install Babel==2.3.4" && \
    /bin/bash -c "source /root/src/teuthology/virtualenv/bin/activate; pip install requests==2.12.5; pip install Babel==2.3.4"

# pre clone for worker and scheduler
RUN git clone https://github.com/orangesy/ceph.git /root/src/github.com_orangesy_ceph_jewel && \
    git clone https://github.com/orangesy/teuthology.git /root/src/github.com_orangesy_teuthology_master && \
    git clone https://github.com/orangesy/ceph-cm-ansible.git /root/src/github.com_orangesy_ceph-cm-ansible_master

ADD option.yaml /root/src/github.com_orangesy_ceph_jewel/option.yaml
ADD run.sh /run.sh
ADD teuthology.yaml /etc/teuthology.yaml
ADD create_nodes.py /usr/local/bin/create_nodes.py
ADD worker_start.sh /usr/local/bin/worker_start.sh
ADD README.md /README.md

RUN echo "source /root/src/teuthology/virtualenv/bin/activate" >> /root/.bashrc

CMD ["/run.sh"]
