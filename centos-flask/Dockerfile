FROM centos-python:2.7.12.1557050764

LABEL name="centos-flask"
LABEL version="1557050764"

# 修改时区
RUN rm -rf /etc/localtime
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

VOLUME ["/opt/flask/project", "/opt/flask/logs", "/opt/flask/venv", "/root/.ssh"]
EXPOSE 8000
WORKDIR /opt/flask/project

# create uwsgi pid dir && /opt/flask/bin
RUN mkdir -p /var/run/uwsgi
RUN mkdir -p /opt/flask/bin
# add entrypoint.sh -- ENTRYPOINT script, setup virtualenv
ADD centos-flask/entrypoint.sh /opt/flask/bin/
RUN chmod +x /opt/flask/bin/entrypoint.sh
# add run.sh -- CMD script, how to run docker container
ADD centos-flask/run.sh /opt/flask/bin/
RUN chmod +x /opt/flask/bin/run.sh
# add control.sh -- some container control cmd
ADD centos-flask/control.sh /opt/flask/bin/
RUN chmod +x /opt/flask/bin/control.sh
RUN ln -s /opt/flask/bin/control.sh /bin/control

# Run container
ENTRYPOINT ["/opt/flask/bin/entrypoint.sh"]
CMD ["/opt/flask/bin/run.sh"]
