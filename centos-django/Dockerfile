FROM centos-python:2.7.12.1557050764

LABEL name="centos-django"
LABEL version="1557050764"

# install wkhtml2pdf
RUN rpm --rebuilddb && yum -y update && \
    yum install -y \
        which \
        fontconfig \
        libpng \
        libX11 \
        libXext \
        libXrender \
        xorg-x11-fonts-Type1 \
        xorg-x11-fonts-75dpi \
        openldap-devel
RUN yum clean all

# Install Fonts
RUN mkdir -p /usr/share/fonts/chinese/TrueType/
ADD fonts/SIMSUN.TTC /usr/share/fonts/chinese/TrueType/
RUN fc-cache /usr/share/fonts/chinese/TrueType/

ADD rpm/wkhtmltox-0.12.2.1_linux-centos7-amd64.rpm /tmp
RUN rpm -Uvh /tmp/wkhtmltox-0.12.2.1_linux-centos7-amd64.rpm
RUN rm /tmp/wkhtmltox-0.12.2.1_linux-centos7-amd64.rpm
RUN ln -s /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf

# 修改时区
RUN rm -rf /etc/localtime
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

VOLUME ["/opt/django/project", "/opt/django/logs", "/opt/django/venv", "/root/.ssh"]
EXPOSE 8000
WORKDIR /opt/django/project

# create uwsgi pid dir && /opt/django/bin
RUN mkdir -p /var/run/uwsgi
RUN mkdir -p /opt/django/bin
# add entrypoint.sh -- ENTRYPOINT script, setup virtualenv
ADD centos-django/entrypoint.sh /opt/django/bin/
RUN chmod +x /opt/django/bin/entrypoint.sh
# add run.sh -- CMD script, how to run docker container
ADD centos-django/run.sh /opt/django/bin/
RUN chmod +x /opt/django/bin/run.sh
# add control.sh -- some container control cmd
ADD centos-django/control.sh /opt/django/bin/
RUN chmod +x /opt/django/bin/control.sh
RUN ln -s /opt/django/bin/control.sh /bin/control

# Run container
ENTRYPOINT ["/opt/django/bin/entrypoint.sh"]
CMD ["/opt/django/bin/run.sh"]
