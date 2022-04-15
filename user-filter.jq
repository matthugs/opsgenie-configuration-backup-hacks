.user.username |=
($username_mapping[.] // .[:-8] + "@2u.com") | # rewrite username
delpaths([paths(.contactMethod? == "mobile")]) | # remove mobile contact methods (to get this to import)
delpaths([paths(.contact?.method? == "mobile")]) | # remove references to mobile contact methods
delpaths([paths(.steps? and (.steps | length ==0))]) | # remove notification rules which have no steps now that we've removed mobile contact methods
if .user.role.id == "Owner" then del(.user.role) else . end # if the user is an owner (either before or after) then opsgenie will choke; their role will need to be set manually