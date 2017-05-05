# teumaster
docker run --net=host -td -v ${HOME}/.ssh:/root/.ssh snowhigh/teumaster

# node management
teuthology-lock --summary
teuthology-lock --owner initial@setup --unlock magna001 magna002 magna003
teuthology-lock --update --status up magna001 magna002 magna003
teuthology-lock --lock magna001 magna002 magna003

# Run suites
teuthology-suite -v --ceph jewel --suite rbd/basic --subset 3/3 --distro ubuntu -m magna option.yaml

# teumaster-paddles
docker run -p 8088:8088 -p 8089:8089 -td snowhigh/teumaster-paddles

# teumaster-node
docker run --name magna001 -v ${HOME}/ceph_config:/home/ubuntu/ceph_config -e KEYS=<KEYS> -td snowhigh/teumaster-node

# list all jobs
teuthology-report --all-runs

# kill above jobs
teuthology-kill -r <NAME>
