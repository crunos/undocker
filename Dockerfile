ARG     GOBUILD_IMG=golang:alpine

FROM    $GOBUILD_IMG AS gobuild

RUN     apk --update --no-cache add \
        build-base \
        git

ENV     BDIR=/build

WORKDIR $BDIR

RUN     git clone https://github.com/tokibi/undocker.git $BDIR

#RUN     go build --ldflags "-s -w -extldflags -static" github.com/tokibi/undocker/cmd/undocker
RUN     go build -a -ldflags "-linkmode external -extldflags '-static' -s -w" github.com/tokibi/undocker/cmd/undocker

RUN     ls -lh $BDIR/undocker

RUN     strip $BDIR/undocker

RUN     ldd $BDIR/undocker || true

RUN     ls -lh $BDIR/undocker



FROM    scratch AS final

COPY    --from=gobuild /build/undocker /usr/bin/undocker
COPY    --from=gobuild lib/ld-musl-x86_64.so.1 lib/ld-musl-x86_64.so.1
COPY    --from=gobuild /etc/ssl /etc/ssl


FROM    scratch

COPY    --from=final / /

ENTRYPOINT      [ "/usr/bin/undocker" ]
CMD             [ "-h" ]
