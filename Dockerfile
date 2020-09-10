FROM centos:7 

RUN groupadd kingbase && useradd -g kingbase -m -d /home/kingbase -s /bin/bash kingbase

WORKDIR /home/kingbase

ADD kingbase.tar.gz ./kdb/

ADD docker-entrypoint.sh ./

RUN chmod +x docker-entrypoint.sh

RUN chown -R kingbase:kingbase /home/kingbase

ENV PATH /home/kingbase/kdb/Server/bin:$PATH

ENV DB_VERSION V008R003C002B0100

USER kingbase

EXPOSE 54321

ENTRYPOINT ["/home/kingbase/docker-entrypoint.sh"]
