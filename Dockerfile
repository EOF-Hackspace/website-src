FROM ruby:2.4-alpine3.7

RUN apk add --no-cache build-base gcc bash cmake

WORKDIR /src

RUN gem install jekyll


COPY ./Gemfile* ./

# Uncomment this block when you want to update the vendor cache.
# This will create a /vendor-new folder in the container which then needs to be manually copied out.
# Don't forget to re-comment these two lines when done.
# RUN bundle package
# RUN mv ./vendor/ /vendor-new

COPY ./vendor/ ./vendor/
RUN bundle install --local

EXPOSE 4000 35729

COPY ./scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]