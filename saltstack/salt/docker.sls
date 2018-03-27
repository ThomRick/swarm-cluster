docker-dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common

docker-gpg-key:
  cmd.run:
    - name: curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    - require:
      - pkg: docker-dependencies

docker-repository:
  pkgrepo.managed:
    - name: deb [arch=amd64] https://download.docker.com/linux/ubuntu {{ grains["oscodename"] }} stable
    - keyid: 9DC858229FC7DD38854AE2D88D81803C0EBFCD88
    - keyserver: download.docker.com
    - file: /etc/apt/sources.list.d/docker.list
    - refresh_db: True
    - require:
      - pkg: docker-dependencies
    - require_in:
      - pkg: docker-package

docker-package:
  pkg.installed:
    - name: docker-ce

docker-group:
  group.present:
    - name: docker
    - system: True
    - members:
      - vagrant

docker-service:
  service.running:
    - name: docker
    - enable: True
    - watch:
      - pkg: docker-package