#!/usr/bin/env bash

./build.sh && \
3dslink --address $1 build/*.3dsx
