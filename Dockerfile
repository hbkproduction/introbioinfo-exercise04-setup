################################################################################
# File: Dockerfile                                                             #
# Project: introbioinfo-exercise04-setup                                       #
# Created: 2021-02-26 16:13:58                                                 #
# Author: Hyunbin Kim (khb7840@gmail.com)                                      #
# Description:                                                                 #
#     This code is written as part of project "introbioinfo-exercise04-setup". #
# ---                                                                          #
# Last Modified: 2021-04-06 12:43:09                                           #
# Modified By: Hyunbin Kim (khb7840@gmail.com)                                 #
# ---                                                                          #
# Copyright © 2021 Hyunbin Kim, All rights reserved                            #
################################################################################

FROM conda/miniconda3
USER root
ARG EXERCISE_NAME=exercise04
RUN apt-get update && apt-get install -y build-essential git vim nano gzip wget tar && rm -rf /var/lib/apt/lists/*

# install necessary tools
RUN conda install -y -c conda-forge -c bioconda hisat2 samtools mmseqs2 prodigal bwa bowtie2 stringtie

# create a user
RUN useradd --create-home --shell /bin/bash $EXERCISE_NAME
USER $EXERCISE_NAME
WORKDIR /home/$EXERCISE_NAME

# make hisat2 index at ~/dm6
RUN wget https://genome-idx.s3.amazonaws.com/hisat/dm6.tar.gz
RUN tar -xvzf dm6.tar.gz
RUN cd dm6
RUN ./make_dm6.sh
RUN cd ..

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]
RUN echo \
    "---------------------------------------------------------------------------\n\
    After registration to the assignment, please clone your exercise repository\n\
    exercise04$ git clone [GITHUB_ASSIGNMENT_REPO_URL]\n\
    ---------------------------------------------------------------------------"\
    > README