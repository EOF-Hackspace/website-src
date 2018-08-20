FROM ruby:2.4-alpine3.7

RUN apk add --no-cache build-base gcc bash cmake

WORKDIR /src

RUN gem install jekyll


COPY ./Gemfile* ./

# RUN bundle package
# RUN mv ./vendor/ /vendor
# RUN bundle install

COPY ./vendor/ ./vendor/
RUN bundle install --local

EXPOSE 4000 35729

COPY ./scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]