// main template for openshift4-authentication
local com = import 'lib/commodore.libjsonnet';
local kap = import 'lib/kapitan.libjsonnet';
local kube = import 'lib/kube.libjsonnet';
local inv = kap.inventory();
// The hiera parameters for the component
local params = inv.parameters.openshift4_authentication;


local groups = std.prune([
  local group = params.groupMemberships[groupName];

  if com.getValueOrDefault(group, 'state', 'present') == 'present' && std.length(group.users) > 0 then kube.Group(groupName) {
    subjects: std.prune([
      if com.getValueOrDefault(group.users[userName], 'state', 'present') == 'present' then {
        apiGroup: 'rbac.authorization.k8s.io',
        kind: 'User',
        name: userName,
      }
      for userName in std.objectFields(group.users)
    ]),
  }
  for groupName in std.objectFields(params.groupMemberships)
]);

{
  [if std.length(groups) > 0 then '31_groups']: groups,
}
