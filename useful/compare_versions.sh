POM_BUILD_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

# cleanup trailing zero if present
BUILD_VERSION=$(echo "$POM_BUILD_VERSION" | sed -e 's/\.0$//g')

echo "version from pom.xml: $POM_BUILD_VERSION, build version to compare: $BUILD_VERSION"

# transform branch name like rc_int_21-3 -> 21.3
GIT_VERSION=$(echo "$1" | sed -e 's/.*_//g' -e 's/-/\./g')

echo "version from git branch: $GIT_VERSION"

if [ "$GIT_VERSION" != "$BUILD_VERSION" ]; then
  echo "Versions in branch and pom do not match, git branch: $GIT_VERSION, version from pom: $BUILD_VERSION"
  echo "Probably you need to update version in pom.xml"
  exit 1
fi
