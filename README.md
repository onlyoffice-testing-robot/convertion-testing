# This project is moved to new oranization, use [ONLYOFFICE-QA/x2t-testing](https://github.com/ONLYOFFICE-QA/x2t-testing) instead 

# Testing x2t

Is project for testing main conversion lib in onlyoffice documentserver

## Getting Started
### Running tests
Change **dockerfile** and **docker-compose** file.

1) change image in docker-compose.

2) Set 3 environment variables in dockerfile: 

**S3_KEY** - is a public s3 key for getting files

**S3_PRIVATE_KEY** - is a private s3 key for getting files

**PALLADIUM_TOKEN** - is a palladium token for writing results.


Then, run documentserver docker-compose for getting all libs 

``docker-compose up documentserver``

And then, you can run tests

``docker-compose up -d x2t-testing``


### Convert Utility

Libs in this project can be used separately of tests like utility for conversion.

File **configure.json** contain all settings for it.

Example:
```
{
  "convert_from": "/tmp/files",
  "convert_to": "/tmp/results",
  "format": "docx",
  "x2t_path": "tmp/x2t",
  "font_path": "tmp/fonts"
}

```
**convert_from** - is a full path to folder 

**convert_to** - is a folder name for results. Every conversion will create new dir for files in it

**format** - files will be converted to this format

**x2t_path** - path to x2t file. 

**font_path**- path to fonts folder

After adding settings, you need to run task

```
rake convert
```

