#!/bin/bash



sed "/^dest_domain=.*/i dest_domain=<collector_endpoint> go_direct=true" /home/bschoenrock/Sandbox/sedTests/sedFile.txt


# v-collector.dp.aws.charter.com
# v-collector-internal.dp.aws.charter.com

