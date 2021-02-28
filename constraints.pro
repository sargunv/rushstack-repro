% Force all workspace dependencies to explicitly declare the workspace protocol
gen_enforced_dependency(WorkspaceCwd, DependencyIdent, 'workspace:*', DependencyType) :-
  workspace_ident(_, DependencyIdent),
  workspace_has_dependency(WorkspaceCwd, DependencyIdent, _, DependencyType).

% Force all packages to have an engines.node field
gen_enforced_field(WorkspaceCwd, 'engines.node', '14.x').

% Force all packages that depend on TypeScript to also depend on tslib
gen_enforced_dependency(WorkspaceCwd, 'tslib', '*', 'dependencies') :-
  workspace_has_dependency(WorkspaceCwd, 'typescript', _, DependencyType),
  DependencyType \= 'peerDependencies',
  WorkspaceCwd \= '.',
  \+ workspace_has_dependency(WorkspaceCwd, 'tslib', _, _).

% Prevent two workspaces from depending on conflicting versions of the same dependency
gen_enforced_dependency(WorkspaceCwd, DependencyIdent, OtherDependencyRange, DependencyType) :-
  workspace_has_dependency(WorkspaceCwd, DependencyIdent, DependencyRange, DependencyType),
  workspace_has_dependency(OtherWorkspaceCwd, DependencyIdent, OtherDependencyRange, _),
  DependencyRange \= OtherDependencyRange.

% Force all packages that depend on TypeScript to set eslintConfig.parserOptions.tsconfigRootDir
gen_enforced_field(WorkspaceCwd, 'eslintConfig.parserOptions.tsconfigRootDir', WorkspaceCwd) :-
  workspace_has_dependency(WorkspaceCwd, 'typescript', _, _),
  WorkspaceCwd \= '.'.

% Force all packages that devDepend on jest to include a test script
gen_enforced_field(WorkspaceCwd, 'scripts.test', 'jest') :-
  workspace_has_dependency(WorkspaceCwd, 'jest', _, _),
  WorkspaceCwd \= '.',
  \+ workspace_field(WorkspaceCwd, 'scripts.test', _),

% Force all packages with a build script to also have a watch script
gen_enforced_field(WorkspaceCwd, 'scripts.watch', 'tsc -w') :-
  workspace_field(WorkspaceCwd, 'scripts.build', _),
  WorkspaceCwd \= '.',
  \+ workspace_field(WorkspaceCwd, 'scripts.watch', _).
