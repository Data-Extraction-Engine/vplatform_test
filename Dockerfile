FROM ruby:2.7.2-alpine

ENV BUNDLER_VERSION=2.7.2

RUN apk add --update --no-cache \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      postgresql-dev \
      tzdata \
      yarn

RUN gem install bundler 

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install

COPY package.json yarn.lock ./

RUN yarn install --check-files

COPY . ./
RUN cd slate && bundle
RUN bundle

ARG ASSET_HOST
ARG CARRIERWAVE_ASSET_HOST
ARG CLOUDFRONT_ACCESS_KEY_ID
ARG CLOUDFRONT_PRIVATE_KEY

RUN echo "ASSET_HOST is: $ASSET_HOST"
RUN echo "CARRIERWAVE_ASSET_HOST is: $CARRIERWAVE_ASSET_HOST"
RUN echo "CLOUDFRONT_ACCESS_KEY_ID is: $CLOUDFRONT_ACCESS_KEY_ID"
RUN echo "CLOUDFRONT_PRIVATE_KEY is: $CLOUDFRONT_PRIVATE_KEY"

#RUN bundle exec rake assets:precompile
RUN RAILS_ENV=production bundle exec rake assets:precompile
#RUN RAILS_ENV=development bundle exec rake assets:precompile
# Start the main process.
EXPOSE 3000
#ENTRYPOINT ["/app/bin/invoker" ,"start","Procfile.dev"]
CMD ["rails", "server", "-b", "0.0.0.0"]
#ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
