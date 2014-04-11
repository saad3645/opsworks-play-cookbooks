Description
===========

Chef cookbook for deploying applications written with [Play framework](http://www.playframework.com/) on Amazon's AWS [OpsWorks](http://aws.amazon.com/opsworks/). Play applications are deployed as services. Attributes can be configured to customize installation and deployment.

  
This cookbook is experimental and a work in progress until otherwise mentioned. Please test vigorously if you use this in a production app. Otherwise Bon Appétit. :)


Platform
--------
- Amazon Linux
- Ubuntu 12.04*


Cookbooks
---------

This cookbook depends on the following cookbooks:
- [java](http://community.opscode.com/cookbooks/java)
- [deploy](https://github.com/aws/opsworks-cookbooks/tree/release-chef-11.4/deploy) (AWS OpsWorks)


Attributes
----------

**Play installation**

|Key            |Type    |Description                |Default|
|---------------|--------|---------------------------|-------|
|`version`      |`String`|The Play version to install|`2.2.2`|
|`base_url`     |`String`|The Base url for downloading Play.|`http://downloads.typesafe.com/play`|
|`download_url` |`String`|The full constructed url for downloading Play. This is constructed by concatenating the `version` with the `base_url`. **Note** that if this attribute is overriden then the `base_url` becomes defunct and ignored.|`{base_url}/{version}/play-{version}.zip`|
|`download_path`|`String`|The download path          |`/tmp` |
|`install_path` |`String`|The installation path      |`/opt` | 
|`install_dir`  |`String`|The name of Play's installation directory|`play-2.2.2`| 


**Usage**

```json
{
  "play": {
    "version": "2.2.2",
    "base_url": "http://downloads.typesafe.com/play",
    "download_url": "http://downloads.typesafe.com/play/2.2.2/play-2.2.2.zip",
    "download_path": "/tmp",
    "install_path": "/opt",
    "install_dir": "play-2.2.2"
  }
}
```

<br/>
**Deploying a Play app**

|Key                      |Type    |Description                |Default|
|-------------------------|--------|---------------------------|-------|
|`options.http.port`      |`String`|The http port which Play will listen to|`80`|
|`options.https.port`     |`String`|The secure https port which Play will listen to|`443`|
|`options.config.resource`|`String`|The alternative configuration file to be loaded from the application classpath (usually in /conf). Has higher precedence than `config.file` and `config.url`, which means that if this attribute is supplied, then the other two will be ignored.|`nil`|
|`options.config.file`    |`String`|The alternative configuration file to be loaded from outside the application package. Has higher precedence than `config.url`.|`nil`| 
|`options.config.url`     |`String`|The alternative configuration file to be loaded from an URL.|`nil`|
|`options.logger.resource`|`String`|The alternative logback configuration file to be loaded from the application classpath. Has higher precedence than `logger.file` and `logger.url`, which means that if this attribute is supplied, then the other two will be ignored.|`nil`|
|`options.logger.file`    |`String`|The alternative logback configuration file to be loaded from the file system. Has higher precedence that `logger.url`.|`nil`|
|`options.logger.url`     |`String`|The alternative logback configuration file to be loaded from an URL.|`nil`|

**Usage**

```json
{
  "play": {
    "deploy": {
      "options": {
	    "http": {
          "port": "80"
	    },
        "https": {
	      "port": "443"
	    },
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
Alternatively if you want to customize each individual app, you can specify the deploy attributes for each app in your stack:

```json
{
  "deploy": {
    "<app_name>": {
      "play": {
		"options": {
		  "http": {
		    "port": "80"
		  },
		  "https": {
		    "port": "443"
		  },
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

The second json will override the deploy attributes in the first for that app only. In other words if you specify the deploy attributes for an individual app, it will override anything you specified in your gloabl deploy attributes for that app only.


Contributing
------------

If your are a ruby guy, please contribute. This cookbook was made by a developer who knows nothing of ruby. You can surely improve the code.


License and Authors
-------------------

This collection is based on and greatly influenced by several other play2 cookbooks written by various authors and contributors before this. Much of the credit for this cookbook goes to these developers. My special thanks to:

Andrea Minetti for https://github.com/minettiandrea/play2

Didier Bathily of njin for https://github.com/njin-fr/application_play2

Maxime Bury of Originate and Giuliano Caliari for https://github.com/gcaliari/opsworks-scala-play2-cookbook

<br/>
_The java cookbook is included just for completeness._

<br/>
**LICENSE**: Unless otherwise stated, the cookbooks/recipes in this repository are licensed under the Apache 2.0 license. See the LICENSE file for full description. Some files are just imported and authored by others. Their license will of course apply.
