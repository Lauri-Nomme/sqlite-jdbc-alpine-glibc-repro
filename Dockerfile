FROM alpine:3.12

ARG TARGETARCH=amd64
ARG TARGETOS=linux

ARG GLIBC_VERSION=2.33-r0

RUN apk --update add curl ca-certificates tar bash && \
	case "${TARGETOS}-${TARGETARCH}" in \
		linux-amd64) \
			SIGNKEY=https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
			GLIBC=https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
			JRE=https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u302-b08/OpenJDK8U-jre_x64_linux_hotspot_8u302b08.tar.gz \
			;; \
		linux-arm64) \
			SIGNKEY=https://github.com/lauri-nomme/alpine-glibc-xb/releases/download/aarch64-${GLIBC_VERSION}/devops.spectx.com.rsa.pub \
			GLIBC=https://github.com/lauri-nomme/alpine-glibc-xb/releases/download/aarch64-${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
			JRE=https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u302-b08/OpenJDK8U-jre_aarch64_linux_hotspot_8u302b08.tar.gz \
			;; \
		*) \
			echo "glibc package for ${TARGETOS}-${TARGETARCH} not supported" && exit 1 \
			;; \
	esac && \
    cd /etc/apk/keys && curl -LsO $SIGNKEY && \
    curl -Ls $GLIBC > /tmp/glibc.apk && \
    apk add /tmp/glibc.apk && \
	curl -Ls $JRE > /tmp/jre.tgz && \
	mkdir /opt/jre && tar xvzf /tmp/jre.tgz --directory=/opt/jre --strip-components=1 && \
    apk del curl tar && \
    rm -rf /var/cache/apk/* /tmp/*

ADD dist/*.jar /opt/app/

CMD ["/opt/jre/bin/java -jar /opt/app/*.jar"]
ENTRYPOINT ["sh", "-c"]
