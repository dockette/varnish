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

Legacy [Varnish Cache](https://varnish-cache.org) image with the bundled `default.vcl` and the entrypoint used by older
Dockette stacks. It keeps the historical behavior on purpose.

## Features

- Varnish on `dockette/debian:trixie`, listening on port `80`
- Bundled `default.vcl` that expects the backend application as `app:80`
- The entrypoint starts `varnishd` with the bundled VCL and then follows `varnishlog`
- No modern healthcheck, init wrapper or generated runtime configuration

## Usage

```sh
docker run --rm -it -p 80:80 --link app:app dockette/varnish:latest
```

```sh
# Custom VCL, when the default backend or caching rules do not fit your stack
docker run --rm -it -p 80:80 -v "$(pwd)/default.vcl:/etc/varnish/default.vcl:ro" dockette/varnish:latest
```

## Configuration

Defaults of the legacy image:

- `VARNISH_SECRET=/etc/varnish/secret`
- `VARNISH_CONFIG=/etc/varnish/default.vcl`
- `VARNISH_CACHE=256m`
- `VARNISH_PORT=80`

## Versions

| Version | Release |
|---------|---------|
| `dockette/varnish:YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/varnish:latest` | latest build of `master` |

All versions build on `dockette/debian:trixie`. Releases are listed on
[GitHub](https://github.com/dockette/varnish/releases).

## Development

```sh
make build          # build linux/amd64 and linux/arm64
make test           # check varnishd, entrypoint, bundled config and VCL compilation
make run            # run on port 80 with a temporary nginx backend as app:80
make version        # print VERSION
make release        # set today's date in VERSION
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to
[support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
