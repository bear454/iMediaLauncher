# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_imedialauncher_session',
  :secret      => '3cf6d8504b084462cc4d5d9c1a45d6088b1dd0fbb9c2e39f1976a13f54a5824bab60cbae21cc5649489a8c7a60e944a1d5b42daf58c2d3916a61092ce66cd70c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
