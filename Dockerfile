FROM macpaw/internship

RUN git clone https://github.com/dr10n9/macpaw_scripts
WORKDIR /app/macpaw_scripts/
RUN ./additional_password.sh
RUN ./change_configs
EXPOSE 80

