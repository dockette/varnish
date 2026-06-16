<h1 align=center>Dockette / Varnish</h1>

<p align=center>
   <a href="https://github.com/dockette/varnish/actions"><img src="https://github.com/dockette/varnish/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/varnish"><img src="https://img.shields.io/docker/pulls/dockette/varnish.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

<p align=center>
   Legacy Docker image for Varnish Cache with the bundled <code>default.vcl</code> and entrypoint used by older Dockette stacks.
</p>

-----

## Usage

```bash
docker run --rm -it \
  -p 80:80 \
  --link app:app \
  dockette/varnish:latest
```

The bundled VCL expects the backend application to be reachable as `app:80`.

## Configuration

The image keeps the original legacy defaults:

- `VARNISH_SECRET=/etc/varnish/secret`
- `VARNISH_CONFIG=/etc/varnish/default.vcl`
- `VARNISH_CACHE=256m`
- `VARNISH_PORT=80`

Mount a custom VCL file when the default backend or caching rules do not fit your stack:

```bash
docker run --rm -it \
  -p 80:80 \
  -v "$(pwd)/default.vcl:/etc/varnish/default.vcl:ro" \
  dockette/varnish:latest
```

## Legacy Constraints

This repository intentionally preserves the historical image behavior. The entrypoint starts `varnishd` with the bundled VCL and then follows `varnishlog`; it does not provide a modern healthcheck, init wrapper, or generated runtime configuration.

The CI smoke test focuses on build viability, Varnish version output, entrypoint presence, bundled config presence, and VCL compilation.

## Development

```bash
make build
make test
make run
```

`make run` starts a temporary backend as `app:80` for the bundled VCL.

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
