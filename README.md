# New Day

New Day serves to provide a set of `org-mode` templates and scripts to begin
your day right for task tracking, note taking, and a general scratchpad by
placing these files in a YYYY-MM-DD structure located by the `NEW_DAY_DIR` env
variable.

## Using NewDay

NewDay can either be called directly from `PROJECT_ROOT/bin/new-day.sh` or
you can add it to your `PATH`.

It supports an environment variable `NEW_DAY_DIR` to specify the root directory
for your org files, or by default, it will use `$HOME/notes/`.

## Requirements

- Ruby 2.7.7
