FROM node:lts-alpine

# APP: Location of the application
# Home: Location of the application sources
ENV APP="/opt/app-root" \
    HOME="/opt/app-root/src" \
    NODE_ENV="production"

EXPOSE 8080

RUN mkdir -p $HOME

# Image metadatas
LABEL maintainer="Thomas de Lachaux <thomas.delachaux@gmail.com>" \
      io.k8s.description="Image to build Yarn applications" \
      io.k8s.display-name="Yarn 1.0.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="nodejs,yarn,alpine" \
      io.openshift.s2i.scripts-url=image://$APP/scripts \
      io.openshift.s2i.destination=$APP


# Copies all the scripts to the container
COPY ./bin/ $APP/scripts

RUN chown -R 1000:0 $APP && \
    chmod -R g=u $APP

WORKDIR $HOME

# OpenShift only accepts numeric user
USER 1000:0

CMD ["sh", "-c", "$APP/scripts/usage"]
