# devops-automation-scripts
Scripts used to automate as much of our processes as possible.

## release-rice.sh
Accepts four inputs:
* Rice repo URL (default: git@github.com:ua-eas/ksd-kc5.2.1-rice.git)
* Release ticket number
* New Release version number (Master +1)
* Version prefix (default: ua-release)

Checks out the Rice repository from the specified url into `/tmp/repo/rice` (removing any existing files), and executes Maven JGitFlow plugin `release-start` and `release-finish` goals as configured in the Rice project `pom.xml`.

For more information on JGitFlow, see the [JGitFlow Plugin project page][jgitflow-link].

For more information on how to use this script in the UA KFS release process, see the [Scripted Release Branch][scripted-release-branch-link] Confluence page.

## release-kfs-docker.sh
Accepts five inputs:
* KFS repo URL (default: git@github.com:ua-eas/kfs.git)
* KFS Docker repo url (default: git@github.com:ua-eas/docker-kfs6.git)
* Release ticket number
* New Release version number (Master +1)
* Version prefix (default: ua-release)

Checks out the KFS repository from the specified url into `/tmp/repo/kfs` (removing any existing files), and executes Maven JGitFlow plugin `release-start` and `release-finish` goals as configured in the KFS project `pom.xml`.  
After KFS has been updated, checks out the Docker KFS repository from the specified url into `/tmp/repo/docker` (removing any existing files), and replaces the previous KFS version strings with values for the newly released KFS and commits the change to both `development` and `master` branches.

## release-kfs-help.sh
Accepts four inputs:
* KFS help text repo URL (default: git@github.com:ua-eas/kfs-help.git)
* Release ticket number
* New Release version number (Master +1)
* Version prefix (default: ua-release)

Checks out the kfs-help repository from the specified url into `/tmp/repo/kfs-help` (removing any existing files), and executes Maven JGitFlow plugin `release-start` and `release-finish` goals as configured in the kfs-help project `pom.xml`.  

## cleanup-feature-branch.sh
Accepts three inputs:
* URL of the repository to use (default: git@github.com:ua-eas/kfs.git)
* Name of the development branch (default: ua-development)
* List of comma-separated feature branch names to archive and delete (for example, "UAF-A,UAF-B,UAF-C,..."), and iterates over each branch doing the following:
 * Tag branch as `archive/<branchname>`
 * Push tag `archive/<branchname>` to origin
 * Delete branch `<branchname>` on origin
 * Delete branch `<branchname>` locally

It is up to the user to manually populate the list of comma-separated feature branches that should be archived and deleted.

## TEST-make-feature-branches.sh
Helper script to create branches to be closed by `cleanup-feature-branch.sh` for testing.
Accepts two inputs:
* URL of the repository to use (default: git@github.com:ua-eas/kfs-devops-automation-fork.git)
* List of comma-separated feature branch names to create (for example, "UAF-A,UAF-B,UAF-C,...")

[jgitflow-link]: https://bitbucket.org/atlassian/jgit-flow/wiki/Home
[scripted-release-branch-link]: https://confluence.arizona.edu/display/KFS5Up/Scripted+Release+Branch
