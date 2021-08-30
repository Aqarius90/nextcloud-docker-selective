# nextcloud-docker-selective

Point-to-point syncer for nextcloud, based on nextcloudcmd

Partially a workaround of nextcloud's lack of support of simlinks, partially a cmd clone of the desktop "Add Folder Sync Connection". Allows sync of arbitrary folders on host to arbitrary folders on the cloud.

## ENV

IN= source array
OUT= destination array
URL= server url
USER= username
PASS= password
MUTE= disable verbose logging, default true
SLEEP= seconds between sync, default 300
FORCE_REMOVE= delete everything on the server not listed in OUT, default false

## Binds

> IN=folder1/folder2 folder3
>
> OUT=folder4 folder2/folder1

creates binds:

> $localroot/folder1/folder2/ -> $server/folder4
>
> $localroot/folder3 -> $server/folder2/folder1

If folders do not exist on the server, they will be created.
if FORCE_REMOVE=false, not bound items will be ignored, if FORCE_REMOVE=true, **ALL** not bound items will be **DELETED**

## Example

> docker run -it --rm -e USER=$user -e PASS=$pass --env-file .env -v $(pwd)/localroot:/media nextcloud-docker-selective
