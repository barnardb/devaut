DevAut
======

These are some tools that help me automate myself.
I suspect some of them might help you automate yourself too.


Commands
--------

<!-- BEGIN AUTOGEN COMMAND DESCRIPTIONS -->

### `eachrepo`

usage: `eachrepo [--sequential] <command> [<argument>...]`

`eachrepo` makes it easy to issue a command in all git repositories under the current directory.
Commands are issued in parallel using [GNU Parallel](http://www.gnu.org/software/parallel/),
unless the --sequential flag is provided.

For example, you might find `eachrepo git fetch` useful before disconnecting from a network.


### `push`

usage: `push [--all-at-once | --if-needed]... [<commit-ish>]`

`push` helps you get all of your amazing commits pushed upstream,
without letting obvious accidents slip through.

It will validate and push commits that haven't yet been pushed upstream.
Commits are validated by running them in a shadow worktree using
[git-new-workdir](https://github.com/git/git/blob/master/contrib/workdir/git-new-workdir),
so that you can keep on working while the build is running.

The current branch is pushed by default, or you can specify the commit-ish (branch, commit, HEAD, …) to use.

Each commit is validated and pushed individually, or you can `push --all-at-once`.

You'll get an error message and non-zero exit status if there's nothing to push,
but you can `push --if-needed` to have your shell keep its cool.

Happy pushing :)

<!-- END AUTOGEN COMMAND DESCRIPTIONS -->
