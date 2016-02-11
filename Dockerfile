FROM gentoo/stage3-amd64-hardened
MAINTAINER Fabian Köster <koesterreich@fastmail.fm>

# Install portage tree
RUN emerge-webrsync

# Install gentoolkit including euse
RUN emerge -q app-portage/gentoolkit

# Disable binary redistribution
RUN euse -D bindist

RUN echo "dev-lang/python sqlite" > /etc/portage/package.use/trac

# Rebuild installed packges with new use-flags
# We force to continue even if exit code is non-zero
RUN emerge -qD --newuse @world || exit 0

# Install required packages
RUN emerge -q www-apps/trac mail-mta/ssmtp

USER tracd

VOLUME /var/www/trac
VOLUME /var/backups/trac

COPY backup.sh /usr/local/bin/

CMD /usr/bin/tracd -b 0.0.0.0 -p 8000 -s /var/www/trac/ --basic-auth="trac,/var/www/trac/.htpass,Restricted"

# The port(s) the server uses
EXPOSE 8000
