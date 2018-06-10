FROM ruby:2.3

WORKDIR /app

COPY cp_file.rb rm_file.rb env_var_helper.sh ./
RUN chmod +x env_var_helper.sh

ENTRYPOINT ['env_var_helper.sh']
