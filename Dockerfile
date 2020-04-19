FROM ruby:2.6-alpine
RUN apk update && apk add --no-cache \
    bash \
    build-base \
    nodejs \
    yarn \
    tzdata \
    sqlite-dev

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir /app
WORKDIR /app

ARG RAILS_ENV
ENV RACK_ENV=$RAILS_ENV

COPY package.json /app/package.json
COPY yarn.lock /app/yarn.lock
RUN yarn install --check-files

RUN gem install bundler
COPY Gemfile Gemfile.lock /app/
RUN if [[ "$RAILS_ENV" == "production" ]]; then bundle install --binstubs --without development test; else bundle install --binstubs; fi

COPY ./docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY . /app

EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

