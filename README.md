# docker-omnidb
[OmniDB](https://www.omnidb.org/en/) installed into a [Docker](https://www.docker.com/) container for easy database management.

This image is based off Debian, following the official installation instructions. Kudos to [Taivo Käsper](https://hub.docker.com/u/taivokasper/) for the original image which was once the base of this container.

You have the option to run with split or joined Websocket ports. If you wish to place a reverse proxy in front of your OmniDB server, you can join the HTTP and Websocket ports, and make OmniDB reachable via one single port. Most of the time, this will be port 443 for HTTPS. For example, you can use the following Apache reverse proxy configuration to make it work:

	# Proxy to the omnidb websocket service
	ProxyPass /wss ws://127.0.0.1:25482/wss retry=0
	ProxyPassReverse /wss ws://127.0.0.1:25482/wss
	
	# Proxy to the omnidb http service
	ProxyPass / http://127.0.0.1:8080/ retry=0
	ProxyPassReverse / http://127.0.0.1:8080/

And then, start the container with the following options:

	-p 8080:8080 -p 25482:25482 -e EXTERNAL_WEBSOCKET_PORT=443

This implies that SSL encryption is handled by Apache, and Apache is listening on port 443 for HTTPS.

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
