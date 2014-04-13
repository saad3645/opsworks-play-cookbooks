# Description

Chef cookbook for deploying applications written with [Play framework](http://www.playframework.com/) on Amazon's AWS [OpsWorks](http://aws.amazon.com/opsworks/). Play applications are deployed as services. Attributes can be configured to customize installation and deployment.

  
This cookbook is experimental and a work in progress until otherwise mentioned. Please test vigorously if you use this in a production environment. Otherwise Bon Appétit. :)


## Platform

- Amazon Linux
- Ubuntu 12.04*


## Cookbooks

This cookbook depends on the following cookbooks:
- [java](http://community.opscode.com/cookbooks/java)
- [deploy](https://github.com/aws/opsworks-cookbooks/tree/release-chef-11.4/deploy) (AWS OpsWorks)


## Usage

1. Create a new Stack.
   - Click on the "Advance" link and choose **Use custom Chef cookbooks**.
   - In the Repository Url field enter `https://github.com/saad3645/opsworks-play-cookbooks.git`, or if you forked this repo use the url for your repo instead.
   - Optionally add some custom JSON. Please refer to the [Attributes](#attributes) section below for example usage.
2. Create a new custom layer:
   - Add `opsworks_play2::setup` to the setup lifecyle event recipes
   - Add `opsworks_play2::deploy` to the deploy lifecyle event recipes
   - Start a new instance
3. Add your Play application to the stack, and deploy it.


## Attributes

### Play installation

|Key              |Type    |Description                 |Default|
|-----------------|--------|----------------------------|-------|
|`version`        |`String`|The Play version to install.|`2.2.2`|
|`base_url`       |`String`|The base url for downloading Play.|`http://downloads.typesafe.com/play`|
|`download_url`   |`String`|The fully formed url for downloading Play. This is contructed by concatenating the `version` with the `base_url`. **Note** that if this attribute is overriden then the `base_url` becomes defunct and is ignored.|`{base_url}/{version}/play-{version}.zip`|
|`download_prefix`|`String`|The download path           |`/tmp` |
|`install_prefix` |`String`|The installation path       |`/opt` | 
|`home`           |`String`|The name of Play's home directory|`play-2.2.2`| 


<br/>
**Example usage**

```json
{
  "play": {
    "version": "2.2.2",
    "base_url": "http://downloads.typesafe.com/play",
    "download_url": "http://downloads.typesafe.com/play/2.2.2/play-2.2.2.zip",
    "download_prefix": "/tmp",
    "install_prefix": "/opt",
    "home": "play-2.2.2"
  }
}
```

### Deploying Play apps

|Key                      |Type    |Description                            |Default|
|-------------------------|--------|---------------------------------------|-------|
|`options.http.port`      |`String`|The http port which Play will listen to|`80`|
|`options.https.port`     |`String`|The secure https port which Play will listen to|`443`|
|`options.config.resource`|`String`|The alternative configuration file to be loaded from the application classpath (usually in /conf). Has higher precedence than `config.file` and `config.url`, which means that if this attribute is supplied, then the other two will be ignored.|`nil`|
|`options.config.file`    |`String`|The alternative configuration file to be loaded from outside the application package. Has higher precedence than `config.url`.|`nil`| 
|`options.config.url`     |`String`|The alternative configuration file to be loaded from an URL.|`nil`|
|`options.logger.resource`|`String`|The alternative logback configuration file to be loaded from the application classpath. Has higher precedence than `logger.file` and `logger.url`, which means that if this attribute is supplied, then the other two will be ignored.|`nil`|
|`options.logger.file`    |`String`|The alternative logback configuration file to be loaded from the file system. Has higher precedence that `logger.url`.|`nil`|
|`options.logger.url`     |`String`|The alternative logback configuration file to be loaded from an URL.|`nil`|


<br/>
**Example usage**

You can specify a global deploy JSON, for every app in your Stack. Provide a custom JSON like the one below while creating your Stack:

```json
{
  "play": {
    "application": {
      "options": {
	    "http": {"port": "80"},
        "https": {"port": "443"},
	    "config": {
	      "resource": "production.conf",
		  "file": null,
		  "url": null
	    },
	    "logger": {
	      "resournce": "conf/production_logger.xml",
		  "file": null,
		  "url": null
	    }
	  }
    }
  }
}
```

<br/>
Alternatively you can override the deploy attributes for each individual app. Simply supply a custom JSON when you add a new App, for each app you want to customize:

```json
{
  "deploy": {
    "<app_name>": {
      "play": {
		"options": {
		  "http": {"port": "80"},
		  "https": {"port": "443"},
		  "config": {
		    "resource": "production.conf",
			"file": null,
			"url": null
		  },
		  "logger": {
		    "resournce": "conf/production_logger.xml",
			"file": null,
			"url": null
		  }
		}
	  }
	}
  }
}
```

If you want you can provide a global deploy json at the beginning when you create your Stack, and then again override individual apps using a second json for each app you want to customize.


## Contributing

If your are a ruby guy, please contribute. This cookbook was made by a developer who knows nothing of ruby. You can surely improve the code.


## License and Authors

This collection is based on and greatly influenced by several other play2 cookbooks written by various authors and contributors before this. Much of the credit for this cookbook goes to these developers. My special thanks to:

Andrea Minetti for https://github.com/minettiandrea/play2

Didier Bathily of njin for https://github.com/njin-fr/application_play2

Maxime Bury of Originate and Giuliano Caliari for https://github.com/gcaliari/opsworks-scala-play2-cookbook

<br/>
_The java cookbook is included just for completeness._

<br/>
**LICENSE**: Unless otherwise stated, the cookbooks/recipes in this repository are licensed under the Apache 2.0 license. See the LICENSE file for full description. Some files are just imported and authored by others. Their license will of course apply.
