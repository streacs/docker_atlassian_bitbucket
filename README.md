# Docker - Atlassian Bitbucket

This is a Docker-Image for Atlassian Bitbucket based on Debian 9.

## Getting started
Run Atlassian Bitbucket standalone and navigate to `http://[dockerhost]:7990` to finish configuration:

```bash
docker run -ti -e ORACLE_JAVA_EULA=accepted -p 7990:7990 -p 7999:7999 streacs/atlassian-bitbucket:x.x.x
```

## Environment Variables
* ORACLE_JAVA_EULA
* JVM_ARGUMENTS
* SYSTEM_USER = bitbucket
* SYSTEM_GROUP = bitbucket
* SYSTEM_HOME = /home/bitbucket
* APPLICATION_INST = /opt/atlassian/bitbucket
* APPLICATION_HOME = /var/opt/atlassian/application-data/bitbucket

## Ports
* 7990 = Default HTTP Connector
* 7999 = Atlassian Bitbucket git SSH Port

## Volumes
* /var/opt/atlassian/application-data/bitbucket

## Oracle end user license agreement
To run this container you have to accept the terms of the Oracle Java end user license agreement.
http://www.oracle.com/technetwork/java/javase/terms/license/index.html

Add following environment variable to your configuration : 
```bash
-e ORACLE_JAVA_EULA=accepted
```

## Source Code
[Github](https://github.com/streacs/docker_atlassian_bitbucket)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details