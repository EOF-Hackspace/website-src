FROM ruby:2.4-alpine as base

RUN apk add --no-cache build-base gcc bash cmake

WORKDIR /src

RUN gem install jekyll

COPY ./vendor/ ./vendor/
COPY ./Gemfile* ./

RUN bundle install --local

EXPOSE 4000 35729

COPY ./scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]