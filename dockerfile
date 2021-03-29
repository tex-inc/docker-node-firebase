FROM node:12
RUN apt-get update
RUN apt-get install -y openjdk-8-jre

ENV APP_DIR /srv
ENV APP_NPM_GLOBAL_DIR /home/node/.npm-packages
ENV PATH $APP_NPM_GLOBAL_DIR/bin:$PATH
ENV PATH $APP_DIR/node_modules/.bin:$PATH

# Install global packages to '$APP_NPM_GLOBAL_DIR'.
RUN mkdir -p $APP_NPM_GLOBAL_DIR/bin \
	&& echo "prefix=$APP_NPM_GLOBAL_DIR" >> /home/node/.npmrc \
	&& chown -R node:node /home/node

# Create and configure app directory.
RUN mkdir -p $APP_DIR \
	&& chown -R node:node $APP_DIR

WORKDIR $APP_DIR
USER node

RUN npm install -g firebase-tools
