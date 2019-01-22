#=============================================================
# Dockerfile for OpenWPM
# See README.md for build & use instructions
#=============================================================

FROM ubuntu:18.04

#=============================================================
# Packages required for container setup
#=============================================================

RUN apt-get -y update
RUN apt-get -y install sudo curl gnupg wget

# Install nodejs and npm from nodesource
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
RUN sudo apt-get update && sudo apt-get install -y yarn

#=============================================================
# Copy OpenWPM source
#=============================================================
RUN sudo mkdir /opt/OpenWPM/

ADD automation /opt/OpenWPM/automation/
# RUN wget https://public-data.telemetry.mozilla.org/openwpm/openwpm.xpi
# COPY openwpm.xpi /opt/OpenWPM//automation/Extension/firefox/

ADD requirements.txt /opt/OpenWPM/
ADD VERSION /opt/OpenWPM/
ADD install.sh /opt/OpenWPM/
ADD demo.py /opt/OpenWPM/

#=============================================================
# Add normal user with passwordless sudo, and switch
#=============================================================
RUN useradd user \
         --shell /bin/bash  \
         --create-home \
  && usermod -a -G sudo user \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'user:secret' | chpasswd

USER user
ENV PATH="/home/user/.local/bin:${PATH}"

#=============================================================
# Install requirements for OpenWPM
#=============================================================
RUN sudo chown -R user:user /opt/OpenWPM/

RUN cd /opt/OpenWPM/ \
&& ./install.sh --no-flash
ADD https://public-data.telemetry.mozilla.org/openwpm/openwpm.xpi /opt/OpenWPM//automation/Extension/firefox/
CMD python /opt/OpenWPM/demo.py
