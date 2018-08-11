# https://github.com/Logimethods/docker-jenkins/blob/master/Dockerfile

FROM jenkins/jenkins:lts

USER root
RUN apt-get -qq update \
   && apt-get -qq -y install \
   curl

RUN curl -sSL https://get.docker.com/ | sh

RUN usermod -a -G staff,docker jenkins

USER jenkins