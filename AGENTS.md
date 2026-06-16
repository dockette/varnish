# AGENTS.md

## Project

Dockette Varnish builds `dockette/varnish`, a legacy Varnish Cache image for older Dockette stacks. It installs Varnish on top of `dockette/debian:sid`, copies `varnish/default.vcl` to `/etc/varnish/default.vcl`, and starts through `/entrypoint.sh`.

## Images

- Default image: `dockette/varnish:latest`.
- Build context: repository root `.` with `Dockerfile`, `entrypoint.sh`, and `varnish/default.vcl`.
- Default backend expected by the bundled VCL: `app:80`.
- Default exposed runtime behavior: Varnish listens on port `80` and `varnishlog` keeps the container attached.
- GitHub Actions builds `linux/amd64` for tests, then publishes `linux/amd64,linux/arm64` through the shared Dockette Docker workflow on `master` and the weekly schedule.

## Commands

- `make build` builds `${DOCKER_IMAGE}:${DOCKER_TAG}` from `.`.
- `make test` runs Varnish version, entrypoint, bundled config, and VCL compilation smoke checks against the built image.
- `make run` starts the image locally on `80:80`.

## Testing Notes

- Prefer `make test` after Dockerfile, entrypoint, or VCL changes.
- Use `make -n build test run` to dry-run command wiring without requiring Docker.
- The smoke test requires Docker and a previously built `${DOCKER_IMAGE}:${DOCKER_TAG}` image.

## Guidelines

- Preserve the legacy image behavior unless a build or security fix explicitly requires changing it.
- Keep `Dockerfile`, `Makefile`, README, `.github/workflows/docker.yml`, and smoke checks aligned.
- Prefer `DOCKER_*` names for Docker-related Makefile variables.
- Place `.PHONY: <target>` directly above each Makefile target.
- Keep README badges and maintenance sections consistent with other Dockette image repos.
- Do not introduce unrelated modernization or runtime behavior changes.
