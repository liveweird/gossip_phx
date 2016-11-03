use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: :prod

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"@yTF5Zz9)q+58ywpX&WWKbw8vp^|K.M!^wG6Ix)c&0-M,`V%:l:gX:rv9AVf(8z]"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"@yTF5Zz9)q+58ywpX&WWKbw8vp^|K.M!^wG6Ix)c&0-M,`V%:l:gX:rv9AVf(8z]"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :gossip_phx do
  set version: current_version(:gossip_phx)
end
