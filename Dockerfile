FROM thevlang/vlang:alpine

RUN apk update &&\
    apk add mysql mysql-client pkgconfig && \
    apk add gcc mariadb-connector-c-dev mariadb-dev
 
WORKDIR /app

COPY . .

RUN v install zztkm.vdotenv

EXPOSE 6789

CMD v run main.v

# ENTRYPOINT ["tail", "-f", "/dev/null"]