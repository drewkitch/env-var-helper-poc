FROM ruby:2.3

COPY . .
RUN chmod +x /env_var_helper.sh

ENTRYPOINT ["/env_var_helper.sh"]
