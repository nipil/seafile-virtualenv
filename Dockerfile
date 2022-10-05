# syntax=docker/dockerfile:1

# create new
FROM debian:11-slim

# custom parameters
ARG seafile_version=9.0.9
ARG seafile_instance_name=seafile
ARG seafile_server_domain=seafile.example.org

# standard parameters
ARG seafile_fileserver_port=8082

# advanced parameters
ARG seafile_dir=/opt/seafile
ARG seafile_user=seafile
ARG seafile_venv=venv
ARG seafile_mirror=https://s3.eu-central-1.amazonaws.com/download.seadrive.org
ARG seafile_venv_wrapper=venv-wrapper.sh

# install system packages
# note: without procps, seafile does not start
RUN apt-get update && apt-get install -y \
	build-essential \
	dos2unix \
	libffi-dev \
	procps \
	pwgen \
	python3 \
	python3-dev \
	python3-setuptools \
	python3-pip \
	python3-venv \
	sqlite3 \
	wget \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# create user
RUN useradd -d $seafile_dir -m --user-group $seafile_user

# select target directory
USER $seafile_user:$seafile_user
WORKDIR $seafile_dir

# setup python virtualenv
ENV VIRTUAL_ENV=$seafile_dir/$seafile_venv
RUN python3 -m venv $VIRTUAL_ENV

# update path to use virtualenv
ENV DEFAULT_PATH="$PATH"
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# install packages in virtualenv
RUN pip3 install --timeout=3600 django==2.2.* future Pillow pylibmc captcha jinja2 psd-tools django-pylibmc django-simple-captcha pycryptodome==3.12.0 cffi==1.14.0

# setup installer
RUN wget $seafile_mirror/seafile-server_${seafile_version}_x86-64.tar.gz \
	&& tar xf seafile-server_${seafile_version}_x86-64.tar.gz \
	&& rm -f seafile-server_${seafile_version}_x86-64.tar.gz

# setup seafile
WORKDIR $seafile_dir/seafile-server-$seafile_version
RUN ./setup-seafile.sh auto -n $seafile_instance_name -i $seafile_server_domain -p $seafile_fileserver_port 

# copy and modify venv wrapper script
WORKDIR $seafile_dir
COPY --chown=$seafile_user:$seafile_user $seafile_venv_wrapper $seafile_dir/
RUN chmod +x $seafile_venv_wrapper \
	&& dos2unix $seafile_venv_wrapper \
	&& sed -i -e "s#seafile_dir#$seafile_dir#g" $seafile_dir/$seafile_venv_wrapper

# revert to default path
ENV PATH=$DEFAULT_PATH

# modify gunicorn so seahub is reachable directly from outside
# usually you use a reverse-proxy, but i simplify for the test
RUN sed -i -e 's#127\.0\.0\.1#0.0.0.0#' conf/gunicorn.conf.py

EXPOSE 8000/tcp

ENTRYPOINT ["/bin/bash"]
