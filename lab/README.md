# Lab

To run a small a local experiment with 4 nodes, distributed in four separate
docker containers:

```bash
$ docker-compose build
```

Open four shells, and in each shell:

```bash
$ docker-compose up node<id>
```

where `<id>` is replaced by the node id (1, 2, 3, or 4).

**NOTE**: The above commands must be run from the directory where the
[`docker-compose.yml`](../docker-compose.yml) is located (one level up from
 here).
