#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 input_apk"
    exit 1
fi


apktool d $1
jadx --deobf --deobf-min 3 $1
