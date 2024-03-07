FROM kasmweb/core-ubuntu-jammy:1.15.0-rolling
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Install Chromium
COPY ./src/ubuntu/install/chromium $INST_SCRIPTS/chromium/
RUN bash $INST_SCRIPTS/chromium/install_chromium.sh && rm -rf $INST_SCRIPTS/chromium/

# Install VLC
RUN apt-get update && apt-get install -y vlc

# Install Picard
RUN add-apt-repository ppa:musicbrainz-developers/stable && apt update && apt-get install -y picard

# Install EasyTAG
RUN add-apt-repository ppa:amigadave/ppa && apt update && apt-get install -y easytag

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
