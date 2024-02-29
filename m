#!/bin/bash

mpv "$(ls -1tr | tail -n "${1:-1}" | head -n 1)"
