FROM simonchuang12/teumaster-base

RUN apt-get install -y nginx qemu-utils libssl-dev libev-dev libvirt-dev libmysqlclient-dev libffi-dev libyaml-dev lsb-release python-pip && \
    apt-get clean

RUN cd /root && \
    mkdir -p /root/archive/worker_logs && \
    mkdir -p /root/src && \
    git clone https://github.com/ceph/teuthology.git /root/src/worker && \
    /bin/bash -c "pushd src/worker/; ./bootstrap;"

RUN cd /root && \
    git clone https://github.com/ceph/teuthology.git /root/src/teuthology && \
    /bin/bash -c "pushd src/teuthology/; ./bootstrap;"

ADD nginx_test_logs /etc/nginx/sites-available/nginx_test_logs
RUN ln -s /etc/nginx/sites-available/nginx_test_logs /etc/nginx/sites-enabled/ && \
    rm /etc/nginx/sites-enabled/default

RUN /bin/bash -c "source /root/src/worker/virtualenv/bin/activate; pip install requests==2.12.5; pip install Babel==2.3.4"
RUN /bin/bash -c "source /root/src/teuthology/virtualenv/bin/activate; pip install requests==2.12.5; pip install Babel==2.3.4"

ADD run.sh /run.sh
ADD teuthology.yaml /etc/teuthology.yaml
ADD create_nodes.py /usr/local/bin/create_nodes.py
ADD worker_start.sh /usr/local/bin/worker_start.sh

RUN mkdir -p /usr/share/nginx/html/ceph-deb-trusty-x86_64-basic/sha1/460b12c259f5563d9d1b2477149fe79486ba5bcd
ADD version /usr/share/nginx/html/ceph-deb-trusty-x86_64-basic/sha1/460b12c259f5563d9d1b2477149fe79486ba5bcd/version

CMD ["/run.sh"]
