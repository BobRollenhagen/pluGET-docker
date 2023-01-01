# Use the Python Base image
FROM python:latest as build

LABEL pluGET Docker Image
LABEL Bob Rollenhagen <bob@rollenhagen.xyz>

ARG pluget_ver=v1.7.2

RUN apt-get update && apt-get install -y  gosu


# get pluGET
WORKDIR /opt/pluget

ADD https://github.com/Neocky/pluGET/archive/refs/tags/${pluget_ver}.tar.gz /tmp/pluget.tgz

RUN tar -xzf /tmp/pluget.tgz --strip-components=1 && rm /tmp/pluget.tgz
#RUN pip install pipreqs
#RUN pipreqs --force 
RUN pip install -r requirements.txt
RUN pip list -v
ADD ./pluGET_config.yaml pluGET_config.yaml
ADD ./docker-entrypoint.sh docker-entrypoint.sh
RUN chmod +x docker-entrypoint.sh

################################3
# Runtime Image
################################
FROM python:slim AS runtime

ARG TARGETARCH

#Copy Files
# Copy Python packages
COPY --from=build /usr/sbin/gosu /usr/sbin/gosu
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /opt/pluget /opt/pluget

VOLUME "/data"

WORKDIR /data

ENTRYPOINT ["/opt/pluget/docker-entrypoint.sh"]


