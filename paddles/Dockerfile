FROM simonchuang12/teumaster-base

RUN apt-get install -y git python-dev python-virtualenv postgresql postgresql-contrib postgresql-server-dev-all && \
    apt-get clean

# Install paddles
RUN git clone https://github.com/ceph/paddles && pip install -r paddles/requirements.txt
ADD config.py.in /paddles/config.py
ADD alembic.ini.in /paddles/alembic.ini

RUN /etc/init.d/postgresql start && \
    sudo -u postgres psql --command "CREATE USER paddles WITH SUPERUSER PASSWORD 'password';" && \
    sudo -u postgres createdb -O paddles paddles && \
    cd /paddles && \
    python setup.py develop && \
    pecan populate config.py && \
    alembic stamp head

ADD run.sh /run.sh

WORKDIR /paddles

CMD ["/run.sh"]
