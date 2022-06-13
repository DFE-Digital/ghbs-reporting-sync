#!/bin/sh

# Log into Cloudforundry

cf login -u $(CF_USER) -p $(CF_PASSWORD) -a https://api.london.cloud.service.gov.uk -s $(CF_SPACE)
