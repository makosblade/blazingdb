# https://blazingdb.readme.io/v1.0/docs/quickstart-guide-to-blazingdb?
FROM nvidia/cuda:8.0-cudnn5-runtime

WORKDIR "/opt/blazingdb"

# TensorBoard
EXPOSE 6006

# IPython
EXPOSE 8888

# http://layer0.authentise.com/docker-4-useful-tips-you-may-not-know-about.html
# pick a mirror for apt-get
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse" > /etc/apt/sources.list \
  && echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list \
  && echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse" >> /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y --no-install-recommends wget \
	&& rm -rf /var/lib/apt/lists/* \
  && echo "http://blazing-public-downloads.s3-website-us-west-2.amazonaws.com/installer/blazingdb_installer.sh \
  http://blazing-public-downloads.s3-website-us-west-2.amazonaws.com/installer/blazingworkbench_installer.sh " | xargs -n 1 -P 2 wget \
  && chmod +x blazingdb_installer.sh \
  && ./blazingdb_installer.sh

CMD /opt/blazing/Simplicity 8890 /opt/blazing/disk1/blazing/blazing.conf

# CMD ["/run_jupyter.sh"]
