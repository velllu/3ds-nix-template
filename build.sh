#!/usr/bin/env bash

rm -rf build && \
make && \
mv *.3dsx build && \
mv *.elf build && \
mv *.smdh build
