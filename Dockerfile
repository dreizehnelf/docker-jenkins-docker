# based on treyyoder's reference @ https://container-solutions.com/running-docker-in-jenkins-in-docker/

# use official jenkins image as base
FROM jenkins

# switch to root so we can install docker
USER root

# update our package information
RUN apt-get update \
    && apt-get install -y sudo apt-transport-https ca-certificates curl software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# add the jenkins user to the sudoers
RUN echo “jenkins ALL=NOPASSWD: ALL” >> /etc/sudoers

# get and add docker's gpg keys
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add –

# add the docker repository
RUN sudo add-apt-repository “deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable”

# update the package information to also have the new docker stuff
RUN sudo apt-get update
RUN apt-cache policy docker-ce

# install docker
RUN sudo apt-get install -y docker-ce

# show the docker status
RUN sudo systemctl status docker

# switch back to the jenkins user
USER jenkins
