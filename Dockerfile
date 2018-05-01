FROM macpaw/internship

COPY . /app
RUN cat aentrypoint.sh > /entrypoint.sh

EXPOSE 80
