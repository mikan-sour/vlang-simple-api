FROM thevlang/vlang:alpine

RUN apk update &&\
    apk add postgresql-dev
 
WORKDIR /app

COPY . .

RUN v install nedpals.vex
RUN v install zztkm.vdotenv

EXPOSE 6789

CMD v run main.v

# ENTRYPOINT ["tail", "-f", "/dev/null"]