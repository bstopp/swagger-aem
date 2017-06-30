# Swagger AEM

This project is used to create clients to AEM's API.

## How to use

1. Download the Swagger Codegen Cli jar and place it in the bin directory.
1. Define the API with YAML
1. Define the project with JSON file.
1. Scripts in `bin` directory create the client from YAML/JSON
1. Specs test API; but AEM needs to be running locally
1. To commit changes to Github run `git_push.sh` in each client directory.