# inputs
- list of containers
- app name


# building of container configurations
- DONE construct an image of the directory tree to ease searching through the file system
- DONE format th
- TODO construct the container configurations
## Create
instantiate an image if:
The image requested has not been built
The image is stale (the dockerfile has been modified since the last build)
The user should be supplied with:
the name of the image that containers requested will be based
the server address
server:
localhost\instance\database
wwww.someserver.com\instance\database
database:
authentication
sa username
sa password

# building of the source tree template