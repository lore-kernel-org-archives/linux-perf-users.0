From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 4/9] perf test: new testsuite: perf buildid-list tests
Date: Mon, 07 Dec 2015 19:53:18 +0100
Message-ID: <1449514398.24573.254.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37138 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbbLGSxU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Dec 2015 13:53:20 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id C2E438E6E3
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Dec 2015 18:53:20 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

This commit adds tests for perf buildid-list tool. It is a placeholder
for future perf buildid-cache tests as well.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/testsuite/base_buildid/cleanup.sh       | 20 ++++++
 tools/perf/testsuite/base_buildid/settings.sh      | 23 +++++++
 tools/perf/testsuite/base_buildid/setup.sh         | 26 +++++++
 .../testsuite/base_buildid/test_buildid-list.sh    | 79 ++++++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100755 tools/perf/testsuite/base_buildid/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_buildid/settings.sh
 create mode 100755 tools/perf/testsuite/base_buildid/setup.sh
 create mode 100755 tools/perf/testsuite/base_buildid/test_buildid-list.sh

diff --git a/tools/perf/testsuite/base_buildid/cleanup.sh b/tools/perf/testsuite/base_buildid/cleanup.sh
new file mode 100755
index 0000000..e8ca6a3
--- /dev/null
+++ b/tools/perf/testsuite/base_buildid/cleanup.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+
+#
+#	cleanup.sh of perf buildid test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+
+find . -name \*.log | xargs -r rm
+find . -name \*.err | xargs -r rm
+test -e perf.data && rm -rf perf.data
+
+print_results 0 0 "clean-up logs"
+exit $?
diff --git a/tools/perf/testsuite/base_buildid/settings.sh b/tools/perf/testsuite/base_buildid/settings.sh
new file mode 100644
index 0000000..87052dc
--- /dev/null
+++ b/tools/perf/testsuite/base_buildid/settings.sh
@@ -0,0 +1,23 @@
+#
+#	settings.sh of perf buildid test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+export TEST_NAME="perf_buildid-cache"
+export MY_ARCH=`arch`
+export MY_HOSTNAME=`hostname`
+export MY_KERNEL_VERSION=`uname -r`
+export MY_CPUS_ONLINE=`nproc`
+export MY_CPUS_AVAILABLE=`cat /proc/cpuinfo | grep processor | wc -l`
+
+# FIXME look for the cache dir to /etc/perfconfig
+export BUILDIDDIR="$HOME/.debug"
+
+clear_buildid_cache()
+{
+	rm -rf $BUILDIDDIR/*
+}
diff --git a/tools/perf/testsuite/base_buildid/setup.sh b/tools/perf/testsuite/base_buildid/setup.sh
new file mode 100755
index 0000000..314f68f
--- /dev/null
+++ b/tools/perf/testsuite/base_buildid/setup.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+#
+#	setup.sh of perf buildid test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		FIXME - maybe the setup is not necessary
+#
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+
+# clear the cache
+clear_buildid_cache
+
+# record some perf.data
+$CMD_PERF record -a -- $CMD_LONGER_SLEEP &> setup.log
+
+print_overall_results $?
+exit $?
diff --git a/tools/perf/testsuite/base_buildid/test_buildid-list.sh b/tools/perf/testsuite/base_buildid/test_buildid-list.sh
new file mode 100755
index 0000000..a4acbec
--- /dev/null
+++ b/tools/perf/testsuite/base_buildid/test_buildid-list.sh
@@ -0,0 +1,79 @@
+#!/bin/bash
+
+#
+#	test_buildid-list of perf buildid test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test checks whether the buildids captured by perf record
+#	and listed by perf buildid-list from the perf.data file matches
+#	reality. Some other checks of the tool are done too.
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+TEST_RESULT=0
+
+test -s perf.data || ./setup.sh
+
+
+### help message
+
+if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
+	# test that a help message is shown and looks reasonable
+	$CMD_PERF buildid-list --help > list_helpmsg.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-BUILDID-LIST" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "SEE ALSO" < list_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "perf\-buildid\-list \- List the buildids in a perf\.data file" < list_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "help message"
+	(( TEST_RESULT += $? ))
+else
+	print_testcase_skipped "help message"
+fi
+
+### buildids check
+
+# test that perf list is even working
+$CMD_PERF buildid-list > list_basic.log 2> list_basic.err
+PERF_EXIT_CODE=$?
+
+# output sanity checks
+REGEX_LINE_BASIC="\w{40}\s+$RE_PATH"
+../common/check_all_lines_matched.pl "$REGEX_LINE_BASIC" < list_basic.log
+CHECK_EXIT_CODE=$?
+test ! -s basic_basic.err
+(( CHECK_EXIT_CODE += $? ))
+
+# output semantics check
+../common/check_buildids_vs_files.pl < list_basic.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "buildids check"
+(( TEST_RESULT += $? ))
+
+
+### kernel buildid
+
+# the --kernel option should print the buildid of the running kernel
+$CMD_PERF buildid-list --kernel > list_kernel.log
+PERF_EXIT_CODE=$?
+
+# check whether the buildid is printed
+../common/check_all_lines_matched.pl "\w{40}" < list_kernel.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "kernel buildid"
+(( TEST_RESULT += $? ))
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
