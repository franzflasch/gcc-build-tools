#!/bin/bash

BASEDIR=$(dirname "$0")

docker build -f $BASEDIR/dockerfile_"$1""$2"."$3" .
