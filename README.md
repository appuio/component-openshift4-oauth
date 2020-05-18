# openshift4-oauth

A Commodore component for Managing the OpenShift 4 OAuth config. The component
allows to configure identity providers, templates to customize the look and
feel of the login and the validity of the issued tokens.

This reflects what is documented by `oc explain --api-version
config.openshift.io/v1 OAuth` with some small tweaks to simplify the input.

The parameters `openshift4_oauth.templates.(err,login,providerSelection)`
directly take the template string. The values will be written to a secret which
then gets referenced in the OAuth CRD.

As of know, the paramter `openshift4_oauth.identityProviders` can only handle
provider configs of type LDAP. The documentation requires to configure the
LDAP bind password as a secret, and the CA certificate as a config map, the
component accepts their literal value. Secrets and config maps will be created
and referenced as needed.

## TODO

* Handle providers other than LDAP.
