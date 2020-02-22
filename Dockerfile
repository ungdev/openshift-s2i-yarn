FROM node:lts-alpine

# Location of the application
ENV APP="/opt/app-root"

# Location of the application sources
ENV HOME="$APP/src"

EXPOSE 8080

RUN mkdir -p $HOME

# Image metadatas
LABEL io.k8s.description="Image to build Yarn applications" \
      io.k8s.display-name="Yarn 1.0.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="nodejs,yarn,alpine"

# Image path configuration
LABEL io.openshift.s2i.scripts-url=image://$APP/scripts \
      io.openshift.s2i.destination=$APP

RUN apk add shadow --no-cache && usermod -g root node

# Copies all the scripts to the container
COPY ./bin/ $APP/scripts

WORKDIR $HOME

RUN chown -R 1000:0 $APP && chmod 775 -R $APP

# OpenShift only accepts numeric user
USER 1000

CMD ["sh", "-c", "$APP/scripts/usage"]
