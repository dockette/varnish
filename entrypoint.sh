#!/bin/bash

varnishd -a :"${VARNISH_PORT}" -f "${VARNISH_CONFIG}" -S "${VARNISH_SECRET}" -s malloc,"${VARNISH_CACHE}"
varnishlog
