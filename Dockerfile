FROM simonchuang12/teumaster-base

RUN git clone -b jewel https://github.com/ceph/teuthology.git && \
    cd teuthology && \
    bash bootstrap install && \
    apt-get install -y postgresql postgresql-contrib postgresql-server-dev-all supervisor nginx && \
    apt-get clean

ADD run.sh /run.sh

CMD ["/run.sh"]
