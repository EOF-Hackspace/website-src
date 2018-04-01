FROM ruby:2.4-alpine

RUN apk add --no-cache build-base gcc bash cmake

RUN gem install jekyll

EXPOSE 4000 35729

WORKDIR /src

COPY ./scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]