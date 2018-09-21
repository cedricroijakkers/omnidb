# docker-omnidb
[OmniDB](https://www.omnidb.org/en/) installed into a [Docker](https://www.docker.com/) container for easy database management.

This image is based off [Taivo Käsper's OmniDB container](https://github.com/taivokasper/docker-omnidb), with the added option of configuring the external Websocket port. This allows you to run OmniDB behind a reverse proxy as documented [on the OmniDB website](https://omnidb.org/en/documentation-en/19-deploying-omnidb-server) while only having one port open for HTTP(S) and Websocket.

## Running with split HTTP(S) and Websocket ports

* Without volume mapping
    ```bash
    docker run -it --rm -p 8080:8080 -p 25482:25482 cedricroijakkers/omnidb
    ```
* Using volume for configuration persistence
    ```bash
    docker run -it --rm -v config-omnidb:/etc/omnidb -p 8080:8080 -p 25482:25482 cedricroijakkers/omnidb
    ```

## Running with joined HTTP(S) and Websocket ports

Please note: this requires a reverse http proxy in front of your OmniDB container. Examples are Apache or nginx. Please refer to the proxy's documentation on how to set up a reverse proxy, and allow the Websocket protocol.

* Without volume mapping
    ```bash
    docker run -it --rm -p 8080:8080 -p 25482:25482 -e EXTERNAL_WEBSOCKET_PORT=8080 cedricroijakkers/omnidb
    ```
* Using volume for configuration persistence
    ```bash
    docker run -it --rm -v config-omnidb:/etc/omnidb -p 8080:8080 -p 25482:25482 -e EXTERNAL_WEBSOCKET_PORT=8080 cedricroijakkers/omnidb
    ```

### Port usage

| Port | Usage |
| ---- | ----- |
| 8080 | HTTP  |
| 25482 | Websocket |

### Configuration persistence

Configuration is stored in `/etc/omnidb`

## Login
Default login username: "admin" and password "admin".

## Docker Hub
Available for pulling from [Docker Hub](https://hub.docker.com/r/cedricroijakkers/omnidb/).
