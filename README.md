DevAut
======

[![Build Status](https://travis-ci.org/barnardb/devaut.svg?branch=master)](https://travis-ci.org/barnardb/devaut)

These are some tools that help me automate myself.
I suspect some of them might help you automate yourself too.


Commands
--------

<!-- BEGIN AUTOGEN COMMAND DESCRIPTIONS -->

### `ccstatus`

usage: `ccstatus [--url <url>] [--element | --all | --attribute <attribute-name>] [--] [<project-name-regex>...]`

`ccstatus` shows you the status of one of more builds as parsed from a CCTray XML file.
These files are often served by CI/build servers from a path ending in "/cctray.xml".

The URL from which to retrieve the CCTray XML can be explicitly specified using the `--url` flag,
or will be read from a file in the current working directory named `.cctray-url`.
If neither of these are present,
we assume a travis-ci.org build based on the first GitHub repo found in .git/config.

For each <project-name-regex> on the command line,
all projects whose name maches the extended regular expression will be selected.
If no `<project-name-regex>`s are specified on the command line,
ccstatus will look for a fragment identifier in the CCTray XML url and interpret that as a regex;
e.g., if the url is "http://example.com/cctray.xml#foo.*",
the regex `foo.*` is used.
If the url has no fragment identifier,
all projects in the CCTray XML will be selected,
as if `.*` had been specified.

The output of `ccstatus` depends on the mode it is running in:

* By default, the output indicates whether the last build of each selected project was successful,
  returning exit status 1 if there is a failing build.

* `--attribute <attribute-name>` outputs the value of the named attribute for each selected project.

* `--all` outputs all attributes for each selected project.

* `--element` outputs raw `<project/>` XML elements.

Dependencies:

* [XQilla](http://xqilla.sourceforge.net/HomePage)


### `checkrepo`

usage: `checkrepo`

`checkrepo` is a tool for staying on top of changes in a repository,
by showing the diff of each new commit in turn.

The last reviewed commit is tagged as "reviewed".

NOTE: The projects I mainly work on tend to avoid branching and merging as much as possible.
As a result, I have made no effort to make this script robust in the face of merge commits.


### `eachrepo`

usage: `eachrepo [--sequential] [--] <command> [<argument>...]`

`eachrepo` makes it easy to issue a command in all git repositories under the current directory.
Commands are issued in parallel using [GNU Parallel] unless the --sequential flag is provided.

For example, you might find `eachrepo git fetch` useful before disconnecting from a network.

Dependencies:

* [GNU Parallel]

[GNU Parallel]: http://www.gnu.org/software/parallel/


### `push`

usage: `push [--all-at-once | --dry-run | --force | --if-needed | --no-fetch]... [--] [<commit-ish>]`

`push` helps you get all of your amazing commits pushed upstream,
without letting obvious accidents slip through.

It will validate and push commits that haven't yet been pushed upstream.
Commits are validated by running them in a shadow worktree using [git-new-workdir],
so that you can keep on working while the build is running.

The current branch is pushed by default, or you can specify the commit-ish (branch, commit, HEAD, …) to use.

The first step is a check to make sure you have a fast-forward commit,
unless `--force` is used to push with the **potentially destructive** and unrecommended `--force` option on `git push`.
To ensure we have the current remote state,
the fast-forward check is preceeded by a call to `git fetch` unless disabled with the `--no-fetch` flag.

Each commit is validated and pushed individually, or you can `push --all-at-once`.

Use `--dry-run` to do everything *except* the final push.
This is a convenient way to validate commits in a clean environment without pushing.

You'll get an error message and non-zero exit status if there's nothing to push,
but you can `push --if-needed` to have your shell keep its cool.

Happy pushing :)

Dependencies:

* [git-new-workdir]

[git-new-workdir]: https://github.com/git/git/blob/master/contrib/workdir/git-new-workdir


### `tagrelease`

usage: `tagrelease --version <version>`

`tagrelease` asserts that the working copy is clean and creates an annotate tag
with the version provided in the current repo. It brings up an editor for the
message which is prepulated with the commit messages since the previous
release.

The format of version is not enforce, however it is recommended to follow the
conventions of [semantic versioning][semver]. The tag name will be the version prefixed
with the letter v.

[semver]: http://semver.org/

<!-- END AUTOGEN COMMAND DESCRIPTIONS -->


Dev dependencies
----------------

In addition to runtime (command) dependencies, the development dependencies
are:

* [shellcheck](https://github.com/koalaman/shellcheck)
