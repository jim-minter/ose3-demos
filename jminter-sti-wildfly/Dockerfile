FROM openshift/wildfly-8-centos
ENV STI_SCRIPTS_URL image:///tmp/.sti/bin
RUN mkdir -p /tmp/.sti/bin && curl -so /tmp/.sti/bin/_assemble https://raw.githubusercontent.com/openshift/wildfly-8-centos/master/.sti/bin/assemble && curl -so /tmp/.sti/bin/run https://raw.githubusercontent.com/openshift/wildfly-8-centos/master/.sti/bin/run && curl -so /tmp/.sti/bin/usage https://raw.githubusercontent.com/openshift/wildfly-8-centos/master/.sti/bin/usage && curl -so /tmp/.sti/bin/save-artifacts https://raw.githubusercontent.com/openshift/wildfly-8-centos/master/.sti/bin/save-artifacts && chmod +x /tmp/.sti/bin/*
COPY ./.sti/bin/assemble /tmp/.sti/bin/assemble
