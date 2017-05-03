# teumaster
docker run --net=host -td -v ${HOME}/.ssh:/root/.ssh simonchuang12/teumaster

# node management
teuthology-lock --summary
teuthology-lock --owner initial@setup --unlock plana001
teuthology-lock --update --status up plana001 plana002 plana003
teuthology-lock --lock plana001 plana002 plana003

# Run suites
teuthology-suite -v --ceph jewel --suite rbd/basic --distro ubuntu -m magna
