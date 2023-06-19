#!/bin/bash

export PATH="/root/go/bin:$PATH"

if [ $2 == "1" ]
then
    assetfinder $1 > assetfinder-subdomains.txt
    httpx -l assetfinder-subdomains.txt -o activesubs.txt -threads 200 -status-code -follow-redirects
    rm assetfinder-subdomains.txt
    echo "only assetfinder result"

elif [ $2 == "2" ]
then
    echo $1 > domains.txt
    subfinder -dL domains.txt -o subfinder-subdomains.txt
    httpx -l subfinder-subdomains.txt -o activesubs.txt -threads 200 -status-code -follow-redirects
    rm domains.txt subfinder-subdomains.txt
    echo "only subfinder result"
    
else
    assetfinder $1 > assetfinder-subdomains.txt
    echo $1 > domains.txt
    subfinder -dL domains.txt -o subfinder-subdomains.txt
    cat assetfinder-subdomains.txt subfinder-subdomains.txt > subdomains.txt
    sort -u subdomains.txt > sort.txt
    httpx -l sort.txt -o activesubs.txt -threads 200 -status-code -follow-redirects
    rm assetfinder-subdomains.txt domains.txt subfinder-subdomains.txt sort.txt subdomains.txt
    echo "assetfinder and subfinder both results"
fi
