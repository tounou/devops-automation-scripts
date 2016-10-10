#!/bin/bash
kfsRepoUrl='git@github.com:ua-eas/kfs.git'
developmentBranch="ua-development"
# Prompt user for different URLs, if needed
echo -n "Input KFS repo URL (default: $kfsRepoUrl): "
read inputKfsRepoUrl
if [[ $inputKfsRepoUrl ]]; then
    echo "Using KFS repo Url: $inputKfsRepoUrl"
    kfsRepoUrl=$inputKfsRepoUrl
fi
echo -n "Input development branch name (default: $developmentBranch): "
read inputDevelopmentBranch
if [[ $inputDevelopmentBranch ]]; then
    echo "Using development branch name: $inputDevelopmentBranch"
    developmentBranch=$inputDevelopmentBranch
fi
echo -n "Enter a comma-separated list of branches to clean up (i.e. UAF-AAA,UAF-BBB,...,UAF-ZZZ) : "
IFS=',' read -ra branches
# Remove any existing temporary directory
rm -Rf /tmp/repo

git clone $kfsRepoUrl /tmp/repo/kfs
cd /tmp/repo/kfs

# For each branch, tag it as archive/<branchname>,
#   push the archived tag, and delete the branch.
for branch in "${branches[@]}"; do
    echo "Processing branch $branch"
    git checkout -b $branch origin/$branch && \
    git tag archive/$branch $branch && \
    git push origin --tags && \
    git push origin --delete $branch && \
    git checkout $developmentBranch && \
    git branch -d $branch || echo "ERROR - Problem processing branch $branch"
done
