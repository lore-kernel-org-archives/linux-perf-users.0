From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 4/9] perf test: new testsuite: perf buildid-list tests
Date: Wed, 16 Mar 2016 14:55:15 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1603161454590.13911@Rudolf-RHEL-7>
References: <cover.1458134357.git.mpetlan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56495 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209AbcCPNzT (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Mar 2016 09:55:19 -0400
In-Reply-To: <cover.1458134357.git.mpetlan@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, Jiri Olsa <jolsa@redhat.com>

This commit adds tests for perf buildid-list tool. It is a placeholder
for future perf buildid-cache tests as well.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
  tools/perf/testsuite/base_buildid/cleanup.sh       | 23 ++++++
  tools/perf/testsuite/base_buildid/settings.sh      | 45 ++++++++++++
  tools/perf/testsuite/base_buildid/setup.sh         | 26 +++++++
  .../testsuite/base_buildid/test_buildid-list.sh    | 81 ++++++++++++++++++++++
  4 files changed, 175 insertions(+)
  create mode 100755 tools/perf/testsuite/base_buildid/cleanup.sh
  create mode 100644 tools/perf/testsuite/base_buildid/settings.sh
  create mode 100755 tools/perf/testsuite/base_buildid/setup.sh
  create mode 100755 tools/perf/testsuite/base_buildid/test_buildid-list.sh

diff --git a/tools/perf/testsuite/base_buildid/cleanup.sh b/tools/perf/testsuite/base_buildid/cleanup.sh
new file mode 100755
index 0000000..fb90cc3
--- /dev/null
+++ b/tools/perf/testsuite/base_buildid/cleanup.sh
@@ -0,0 +1,23 @@
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
+if [ ! -n "$PERFSUITE_RUN_DIR" ]; then
+	remove_buildid_cache
+	find . -name \*.log | xargs -r rm
+	find . -name \*.err | xargs -r rm
+	test -e perf.data && rm -rf perf.data
+else
+	mv "$BUILDIDDIR" "$PERFSUITE_RUN_DIR/perf_buildid-cache/"
+fi
+
+print_overall_results 0
+exit $?
diff --git a/tools/perf/testsuite/base_buildid/settings.sh b/tools/perf/testsuite/base_buildid/settings.sh
new file mode 100644
index 0000000..9bc0415
--- /dev/null
+++ b/tools/perf/testsuite/base_buildid/settings.sh
@@ -0,0 +1,45 @@
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
+export MY_CPUS_AVAILABLE=`cat /proc/cpuinfo | grep -P "processor\s" | wc -l`
+
+export BUILDIDDIR=${BUILDIDDIR:-"$HOME/.debug-`date +%s`"}
+test -d "$BUILDIDDIR" || mkdir "$BUILDIDDIR"
+
+if [ -n "$PERFSUITE_RUN_DIR" ]; then
+	# when $PERFSUITE_RUN_DIR is set to something, all the logs and temp files will be placed there
+	# --> the $PERFSUITE_RUN_DIR/perf_something/examples and $PERFSUITE_RUN_DIR/perf_something/logs
+	#     dirs will be used for that
+	export PERFSUITE_RUN_DIR=`readlink -f $PERFSUITE_RUN_DIR`
+	export CURRENT_TEST_DIR="$PERFSUITE_RUN_DIR/$TEST_NAME"
+	test -d "$CURRENT_TEST_DIR" || mkdir -p "$CURRENT_TEST_DIR"
+	export LOGS_DIR="$PERFSUITE_RUN_DIR/$TEST_NAME/logs"
+	test -d "$LOGS_DIR" || mkdir -p "$LOGS_DIR"
+else
+	# when $PERFSUITE_RUN_DIR is not set, logs will be placed here
+	export CURRENT_TEST_DIR="."
+	export LOGS_DIR="."
+fi
+
+
+clear_buildid_cache()
+{
+	rm -rf $BUILDIDDIR/*
+}
+
+remove_buildid_cache()
+{
+	clear_buildid_cache
+	rmdir $BUILDIDDIR
+}
diff --git a/tools/perf/testsuite/base_buildid/setup.sh b/tools/perf/testsuite/base_buildid/setup.sh
new file mode 100755
index 0000000..e9f6d56
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
+$CMD_PERF record -o $CURRENT_TEST_DIR/perf.data -a -- $CMD_LONGER_SLEEP &> $LOGS_DIR/setup.log
+
+print_overall_results $?
+exit $?
diff --git a/tools/perf/testsuite/base_buildid/test_buildid-list.sh b/tools/perf/testsuite/base_buildid/test_buildid-list.sh
new file mode 100755
index 0000000..4b40500
--- /dev/null
+++ b/tools/perf/testsuite/base_buildid/test_buildid-list.sh
@@ -0,0 +1,81 @@
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
+	$CMD_PERF buildid-list --help > $LOGS_DIR/list_helpmsg.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-BUILDID-LIST" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "SEE ALSO" < $LOGS_DIR/list_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "perf\-buildid\-list \- List the buildids in a perf\.data file" < $LOGS_DIR/list_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "help message"
+	(( TEST_RESULT += $? ))
+else
+	print_testcase_skipped "help message"
+fi
+
+
+### buildids check
+
+# test that perf list is even working
+$CMD_PERF buildid-list -i $CURRENT_TEST_DIR/perf.data > $LOGS_DIR/list_buildids.log 2> $LOGS_DIR/list_buildids.err
+PERF_EXIT_CODE=$?
+
+# output sanity checks
+REGEX_LINE_BASIC="\w{40}\s+$RE_PATH"
+REGEX_LINE_KALLSYMS="\w{40}\s+\[kernel\.kallsyms\]"
+../common/check_all_lines_matched.pl "$REGEX_LINE_BASIC" "$REGEX_LINE_KALLSYMS" < $LOGS_DIR/list_buildids.log
+CHECK_EXIT_CODE=$?
+test ! -s $LOGS_DIR/basic_buildids.err
+(( CHECK_EXIT_CODE += $? ))
+
+# output semantics check
+../common/check_buildids_vs_files.pl < $LOGS_DIR/list_buildids.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "buildids check"
+(( TEST_RESULT += $? ))
+
+
+### kernel buildid
+
+# the --kernel option should print the buildid of the running kernel
+$CMD_PERF buildid-list --kernel > $LOGS_DIR/list_kernel.log
+PERF_EXIT_CODE=$?
+
+# check whether the buildid is printed
+../common/check_all_lines_matched.pl "\w{40}" < $LOGS_DIR/list_kernel.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "kernel buildid"
+(( TEST_RESULT += $? ))
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
1.8.3.1
