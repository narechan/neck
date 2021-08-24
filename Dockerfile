## Dockerfile
## Neck
## version 0.1
## Neck is a compression/unsupervised learning algorithm that uses the sequential information bottleneck to 
## find genomic topics (generally elements) in a set of assembled genomes.

# the base image
FROM ubuntu:20.04
USER root

# install base OS dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y \
    g++ \
    make \
    git \
    cpanminus \
    wget \
    libgd-dev \
    r-base

# install bayesian changepoint detection (bcp) R package and dependencies
RUN R -e "install.packages(c('bcp'), \
                           dependencies=TRUE, \ 
                           repos='http://cran.rstudio.com/')"

# install circos
RUN mkdir -p /home/software/circos \
  && cd /home/software/circos \
  && wget http://circos.ca/distribution/circos-0.69.tgz \
  && tar xvfz circos-0.69.tgz

ENV PATH /home/software/circos/circos-0.69/bin:$PATH

RUN cpanm --force \
    Carp \
    Config::General \
    Data::Dumper \
    Digest::MD5 \
    File::Basename \
    File::Spec::Functions \
    FindBin \
    GD \
    GD::Polyline \
    Getopt::Long \
    Graphics::ColorObject \
    IO::File \
    List::MoreUtils \
    List::Util \
    Math::Bezier \
    Math::BigFloat \
    Math::Round \
    Math::VecStat \
    Memoize \
    POSIX \
    Params::Validate \
    Pod::Usage \
    Readonly \
    Regexp::Common \
    Set::IntSpan \
    Storable \
    Time::HiRes \
    Statistics::Basic \
    Clone \
    Font::TTF::Font \
    SVG \
    Text::Format

# install neck
RUN cpanm \
    Parallel::ForkManager \
    Statistics::Descriptive \
    Getopt::Std

# pull bottleneck code
RUN git clone https://github.com/narechan/neck.git /home/software/neck

# update container environment
ENV PATH /home/software/neck:$PATH
WORKDIR /home
