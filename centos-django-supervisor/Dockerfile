FROM centos-django:1557050764

LABEL name="centos-django-supervisor"
LABEL version="1557050764"

EXPOSE 5555

# add run.sh -- CMD script, how to run docker container
ADD centos-django-supervisor/run.sh /opt/django/bin/
RUN chmod +x /opt/django/bin/run.sh

# add control.sh -- some container control cmd
ADD centos-django-supervisor/control.sh /opt/django/bin/
RUN chmod +x /opt/django/bin/control.sh
RUN ln -sf /opt/django/bin/control.sh /bin/control

# Run container
ENTRYPOINT ["/opt/django/bin/entrypoint.sh"]
CMD ["/opt/django/bin/run.sh"]
