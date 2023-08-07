FROM ruby:3.1.3
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler
RUN bundle install --without test development
ADD . /app
EXPOSE 3000
# ECRの環境変数設定で、RAILS_ENV = production を指定している。 ２回目以降はdb:create不要
CMD ["/bin/sh", "-c", "bundle exec rails db:migrate && bundle exec rails db:seed && bundle exec unicorn -p 3000 -c /app/config/unicorn.rb -E production"]
# CMD ["/bin/sh", "-c", "bundle exec rails db:create && bundle exec rails db:migrate && bundle exec rails db:seed && bundle exec unicorn -p 3000 -c /app/config/unicorn.rb -E production"]
