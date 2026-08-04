#!/bin/sh

set -e

TEST_NUM=0
STATUS=0

test_program() {
    TEST_NUM=$((TEST_NUM + 1))

    if command -v "$1" >/dev/null 2>&1; then
        echo "ok ${TEST_NUM} - program '$1' is available"
    else
        echo "not ok ${TEST_NUM} - program '$1' is available"
        STATUS=1
    fi
}

test_program adduser
test_program perl
test_program wget

echo "1..$TEST_NUM"

exit $STATUS
