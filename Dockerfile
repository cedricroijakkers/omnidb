FROM taivokasper/omnidb:v2.10.0_1

# Add an environment variable to change the external listening port of the websocket
ENV EXTERNAL_WEBSOCKET_PORT=25482

# Update the run command to use the new above configured environment variable
COPY docker-entrypoint.sh /
RUN chmod a+rx /docker-entrypoint.sh 
CMD ["/bin/bash", "/docker-entrypoint.sh"]