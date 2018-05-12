#!/bin/bash

generate_docker() {
  docker run --rm kaczmarj/neurodocker:master generate docker \
    --base=neurodebian:stretch \
    --pkg-manager=apt \
    --install vim wget strace time ncdu gnupg curl procps datalad \
              git-annex-standalone datalad python-nipype virtualenv \
              python-dcmstack python-configparser python-funcsigs \
              python-pytest dcmtk python-pip python-wheel \
    --run "curl -sL https://deb.nodesource.com/setup_6.x | bash - "\
    --install nodejs npm \
    --run "npm install -g bids-validator@0.26.11" \
    --run "mkdir /afs /inbox" \
    --run "pip install heudiconv[all]" \
    --dcm2niix version="v1.0.20180328" method="source" \
    --run "echo '#!/bin/bash' >> /neurodocker/heudiconv.sh && echo 'if [ -z \"\$@\" ]; then heudiconv -h; else heudiconv \"\$@\"; fi' >> /neurodocker/heudiconv.sh && chmod +x /neurodocker/heudiconv.sh" \
    --user=reproin \
    --entrypoint "/neurodocker/heudiconv.sh"
}

generate_docker > Dockerfile
