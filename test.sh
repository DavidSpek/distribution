#!/bin/bash
shopt -s extglob

branches=('main' 'alpha' 'beta' 'rc')
regex='^([0-9])?(\.([0-9]|x))?\.x$' # matches branches like 1.x or 2.0.x


for branch in $(git for-each-ref --format='%(refname)' refs/remotes/origin/ | cut -d/ -f4-); do
    if [[ $branch =~ $regex ]]; then
        branches+=("$branch")
    fi
done

printf '%s\n' "${branches[@]}" | jq -R . | jq -s . | jq '{branch: .}' | jq -c .
