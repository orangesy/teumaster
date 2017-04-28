FROM simonchuang12/teumaster-base

RUN apt-get install -y postgresql postgresql-contrib postgresql-server-dev-all supervisor && \
    apt-get clean

# Install paddles
RUN useradd -ms /bin/bash paddles
RUN cd /home/paddles && \
    sudo -u paddles git clone https://github.com/ceph/paddles /home/paddles/paddles

ADD config.py.in /home/paddles/paddles/config.py
ADD alembic.ini.in /home/paddles/paddles/alembic.ini

RUN /etc/init.d/postgresql start && \
    sudo -u postgres psql --command "CREATE USER paddles WITH SUPERUSER PASSWORD 'password';" && \
    sudo -u postgres createdb -O paddles paddles && \
    cd /home/paddles/paddles && \
    sudo -u paddles virtualenv ./virtualenv && \
    sudo -u paddles /bin/bash -c "source ./virtualenv/bin/activate; pip install -r requirements.txt; python setup.py develop; pecan populate config.py; alembic stamp head"

ADD supervisord_paddles.conf /etc/supervisor/conf.d/supervisord_paddles.conf

# Install pulpito
RUN useradd -ms /bin/bash pulpito
RUN cd /home/pulpito && \
    sudo -u pulpito git clone https://github.com/ceph/pulpito.git /home/pulpito/pulpito

ADD prod.py /home/pulpito/pulpito/prod.py
ADD get-pip.py /home/pulpito/pulpito/get-pip.py

RUN export HOME=/home/pulpito && \
    cd /home/pulpito/pulpito && \
    sudo -u pulpito virtualenv ./virtualenv && \
    sudo -u pulpito /bin/bash -c "source ./virtualenv/bin/activate; python get-pip.py; pip install -r requirements.txt;"

ADD supervisord_pulpito.conf /etc/supervisor/conf.d/supervisord_pulpito.conf

ADD run.sh /run.sh

CMD ["/run.sh"]
