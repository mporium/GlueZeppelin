Glue Zeppelin
=============

This docker image creates a local Zeppelin server configured to talk to an AWS Glue Dev Endpoint (a spark cluster) over an SSH tunnel.  
This container does more than one thing (runs a Zeppelin server as well as an SSH port forward), which is not good docker practice, 
and there is possibly a better way to do it, but this works.  Feel free to submit a PR if there is a better way of doing this.

## Usage

You need to specify the hostname for your Dev Endpoint and the location of the private key to connect to the endpoint.

Setting up a Dev Endpoint is beyond the scope of this document, but AWS has some [documentation](https://docs.aws.amazon.com/glue/latest/dg/console-development-endpoint.html), although it isn't great.

In general you should run this container with a command of this form:
```bash
docker run -p <localhost_zeppelin_port>:8080 -e "DEV_ENDPOINT_HOST=<endpoint_public_address>" -e "PRIVATE_KEY_FILE=/keys/<key_file>" -v <key_directory>:/keys:ro mporium/glue-zeppelin:0.9
```

### Parameters

The hostname can be found on the details page for the Endpoint under the 'Public address' property.

The private key should match the public key that you specified when creating the Dev Endpoint.

### Examples

Presuming that you have created a Dev Endpoint and stored the private key used to create it in a file called key.pem under the keys subdirectory of your home directory, 
and you have checked the endpoint properties to find that the endpoint has a public address of `ec2-52-18-45-15.eu-west-1.compute.amazonaws.com`

On Unix run:
```bash
docker run -d -p 8080:8080 -e "DEV_ENDPOINT_HOST=ec2-52-18-45-15.eu-west-1.compute.amazonaws.com" -e "PRIVATE_KEY_FILE=/keys/key.pem" -v /home/you/keys:/keys:ro mporium/glue-zeppelin:0.9
```

And on Windows the command would be almost the same:
```bat
docker run -d -p 8080:8080 -e "DEV_ENDPOINT_HOST=ec2-52-18-45-15.eu-west-1.compute.amazonaws.com" -e "PRIVATE_KEY_FILE=/keys/key.pem" -v c:/Users/You/Documents/keys:/keys:ro mporium/glue-zeppelin:0.9
```
Note that a key file in PuTTY format (.ppk) will not work.

then go to the zeppelin UI at: (http://localhost:8080)

#### Troubleshooting

If you have issues with the container then make sure that you have not added the -d argument, this will allow you to see if any error messages are being generated.

