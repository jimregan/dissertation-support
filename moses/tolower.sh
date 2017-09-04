#!/bin/bash

TRANSLIT=$(cat <<'__HERE__'
$wordBoundary = [ [:Z:] [:P:] ];
::NFD();
$wordBoundary { n } [AEIOU] > n\- ;
$wordBoundary { t } [AEIOU] > t\- ;
::Any-Lower;
::NFC();
__HERE__
)

uconv -x "$TRANSLIT"
