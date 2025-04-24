# mmproxy-docker

`mmproxy-docker` is a docker for `go-mmproxy`.

[DockerHub](https://hub.docker.com/r/duan2001/mmproxy)
[GHCR](https://github.com/djylb/mmproxy-docker/pkgs/container/mmproxy)

## Usage

[Listening port]:[Target port]

### 1. Using Environment Variables

Set the port mappings using the environment variable `PORT_MAPPINGS` and run the container:

```bash
docker run -d --restart=always \
  --name go-mmproxy \
  --network host \
  --cap-add NET_ADMIN \
  -e PORT_MAPPINGS="15000:5000,15001:5001" \
  duan2001/mmproxy:latest
```

### 2. Using Command Line Arguments

Start the container by passing port mappings via command-line arguments:

```bash
docker run -d --restart=always \
  --name go-mmproxy \
  --network host \
  --cap-add NET_ADMIN \
  duan2001/mmproxy:latest "15000:5000,15001:5001"
```

If no port mappings are provided, it defaults to `15000:5000`.

---

## Configuration

- **Environment Variable** `PORT_MAPPINGS`: Set port mappings, e.g. `15000:5000,15001:5001`.
- **Default Port Mappings**: If `PORT_MAPPINGS` is not provided via environment variable or command-line arguments, it defaults to `15000:5000`.

---

## References

- [go-mmproxy](https://github.com/path-network/go-mmproxy)
- [FRP Issue #4692](https://github.com/fatedier/frp/issues/4692)  
