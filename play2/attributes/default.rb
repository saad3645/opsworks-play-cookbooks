###
# Do not use this file to override the play2 cookbook's default
# attributes.  Instead, please use the customize.rb attributes file,
# which will keep your adjustments separate from the this
# codebase and make it easier to upgrade.
#
# However, you should not edit customize.rb directly. Instead, create
# "play2/attributes/customize.rb" in your cookbook repository and
# put the overrides in YOUR customize.rb file.
#
# Do NOT create an 'play2/attributes/default.rb' in your cookbooks. Doing so
# would completely override this file and might cause upgrade issues.
#
# See also: http://docs.aws.amazon.com/opsworks/latest/userguide/customizing.html
###


include_attribute "play2::install"
include_attribute "play2::customize"
