FROM alpine:3.10

LABEL maintainer="Tom"

ENV PORT=5555
RUN apk add --no-cache gcc g++ musl-dev
# RUN apk --no-cache add make gcc g++ musl-dev binutils autoconf automake libtool pkgconfig check-dev file patch

RUN apk --no-cache add --virtual runtime-dependencies \
      python3 \
      gdb &&\
    apk --no-cache add --virtual build-dependencies \
      build-base \
      python3-dev \
      py-pip &&\
    python -m pip install --upgrade pip &&\
    pip3 install gdbgui &&\
    apk del --purge build-dependencies &&\
    rm -rf /var/cache/apk/* 

WORKDIR /app

COPY src/samplev1.c /app
COPY src/samplev2.cpp /app

RUN cd /app && gcc -g samplev1.c -o samplev1 
RUN cd /app && g++ -g samplev2.cpp -o samplev2

EXPOSE ${PORT}

CMD gdbgui -r -n --port ${PORT}
