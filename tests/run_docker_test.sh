#!/bin/bash

BASEDIR=$(dirname "$0")

docker build -f $BASEDIR/tests/dockerfile_"$1""$2"."$3" .
