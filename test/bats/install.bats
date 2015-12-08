#!/usr/bin/env bats


# Create test environment
VERNEUTIL_GIT_TEST_DIR="/tmp/verneutil-git-test"


@test "Clone into /tmp/verneutil" {
    # remove test dir if it exists
    [ -d $VERNEUTIL_GIT_TEST_DIR ] && rm -rf $VERNEUTIL_GIT_TEST_DIR;

    run git clone https://github.com/jwplayer/verneutil.git $VERNEUTIL_GIT_TEST_DIR
    [ "$status" = 0 ]
}


@test "Initialize submodules" {
    cd $VERNEUTIL_GIT_TEST_DIR

    run git submodule init
    [ "$status" = 0 ]

    run git submodule update
    [ "$status" = 0 ]
}

