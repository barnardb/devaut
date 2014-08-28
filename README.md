DevAut
======

These are some tools that help me automate myself.
I suspect some of them might help you automate yourself too.


Commands
--------

<!-- BEGIN AUTOGEN COMMAND DESCRIPTIONS -->

### `checkrepo`

usage: `checkrepo`

`checkrepo` is a tool for staying on top of changes in a repository, by showing
the diff of each new commit in turn.

The last reviewed commit is tagged as "reviewed".

NOTE: The projects I mainly work on tend to avoid branching and merging as much
as possible. As a result, I have made no effort to make this script robust in
the face of merge commits.


### `eachrepo`

usage: `eachrepo [--sequential] <command> [<argument>...]`

`eachrepo` makes it easy to issue a command in all git repositories under the
current directory.  Commands are issued in parallel using [GNU Parallel],
unless the --sequential flag is provided.

For example, you might find `eachrepo git fetch` useful before disconnecting
from a network.


##### Dependencies

* [GNU Parallel]:


[GNU Parallel]: http://www.gnu.org/software/parallel/


### `push`

usage: `push [--all-at-once | --dry-run | --if-needed | --no-fetch]... [<commit-ish>]`

`push` helps you get all of your amazing commits pushed upstream, without
letting obvious accidents slip through.

It will validate and push commits that haven't yet been pushed upstream.
Commits are validated by running them in a shadow worktree using
[git-new-workdir], so that you can keep on working while the build is running.

The current branch is pushed by default, or you can specify the commit-ish
(branch, commit, HEAD, …) to use.

The first step is a check to make sure you have a fast-forward commit.  To
ensure we have the current remote state, this is preceeded by a call to `git
fetch` unless disabled with the `--no-fetch` flag.

Each commit is validated and pushed individually, or you can `push
--all-at-once`.

Use `--dry-run` to do everything *except* the final push.  This is a convenient
way to validate commits in a clean environment without pushing.

You'll get an error message and non-zero exit status if there's nothing to
push, but you can `push --if-needed` to have your shell keep its cool.

Happy pushing :)


##### Dependencies

* [git-new-workdir]


[git-new-workdir]: https://github.com/git/git/blob/master/contrib/workdir/git-new-workdir

<!-- END AUTOGEN COMMAND DESCRIPTIONS -->


Dev dependencies
----------------

In addition to runtime (command) dependencies, the development dependencies
are:

* [shellcheck](https://github.com/koalaman/shellcheck)
