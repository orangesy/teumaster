FROM simonchuang12/teumaster-base

RUN apt-get install -y nginx qemu-utils libssl-dev libev-dev libvirt-dev libmysqlclient-dev libffi-dev libyaml-dev && \
    apt-get clean

RUN useradd -ms /bin/bash teuthworker
RUN cd /home/teuthworker && \
    export HOME=/home/teuthworker && \
    sudo -u teuthworker mkdir -p /home/teuthworker/src && \
    sudo -u teuthworker mkdir -p /home/teuthworker/archive/worker_logs && \
    sudo -u teuthworker git clone -b jewel https://github.com/ceph/teuthology.git /home/teuthworker/src/teuthology && \
    sudo -u teuthworker wget -O /home/teuthworker/src/teuthology/worker_start https://raw.githubusercontent.com/ceph/teuthology/jewel/docs/_static/worker_start.sh && \
    sudo -u teuthworker /bin/bash -c "pushd src/teuthology/; ./bootstrap;"

RUN useradd -ms /bin/bash teuthology
RUN cd /home/teuthology && \
    export HOME=/home/teuthology && \
    sudo -u teuthology mkdir -p ~/src && \
    sudo -u teuthology git clone -b jewel https://github.com/ceph/teuthology.git /home/teuthology/src/teuthology && \
    sudo -u teuthology /bin/bash -c "pushd src/teuthology/; ./bootstrap;"

RUN wget -O /etc/nginx/sites-available/nginx_test_logs  http://docs.ceph.com/teuthology/docs/_static/nginx_test_logs && \
    ln -s /etc/nginx/sites-available/nginx_test_logs /etc/nginx/sites-enabled/ && \
    rm /etc/nginx/sites-enabled/default

ADD run.sh /run.sh

CMD ["/run.sh"]
