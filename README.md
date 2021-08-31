# nextcloud-docker-selective

Point-to-point syncer for nextcloud, based on nextcloudcmd

Partially a workaround of nextcloud's lack of support of simlinks, partially a way to avoid port forwarding, partially a docker/cmd clone of the desktop GUI "Add Folder Sync Connection". Allows sync of arbitrary folders on host to arbitrary folders on the cloud.

Code and issues at: https://github.com/Aqarius90/nextcloud-docker-selective

## ENV

IN= source array
OUT= destination array
URL= server url
USER= username
PASS= password
MUTE= disable verbose logging, default true
SLEEP= seconds between sync, default 300

## Binds

> IN=folder1/folder2 folder3
>
> OUT=folder4 folder2/folder1

creates binds:

> $localroot/folder1/folder2/ -> $server/folder4
>
> $localroot/folder3 -> $server/folder2/folder1

Nonexistant folders will be created. Unlisted folders will be ignored.

## Example

> docker run -it --rm -e USER=$user -e PASS=$pass --env-file .env -v $localroot:/media aqarius90/nextcloudcmd-selective
