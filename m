From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 5/9] perf test: new testsuite: perf list tests
Date: Wed, 16 Mar 2016 14:55:57 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1603161455320.13911@Rudolf-RHEL-7>
References: <cover.1458134357.git.mpetlan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46388 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209AbcCPN4B (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Mar 2016 09:56:01 -0400
In-Reply-To: <cover.1458134357.git.mpetlan@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, Jiri Olsa <jolsa@redhat.com>

This commit adds tests for perf list tool.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
  tools/perf/testsuite/base_list/cleanup.sh    |  22 ++++++
  tools/perf/testsuite/base_list/settings.sh   |  30 ++++++++
  tools/perf/testsuite/base_list/setup.sh      |  20 ++++++
  tools/perf/testsuite/base_list/test_basic.sh | 101 +++++++++++++++++++++++++++
  4 files changed, 173 insertions(+)
  create mode 100755 tools/perf/testsuite/base_list/cleanup.sh
  create mode 100644 tools/perf/testsuite/base_list/settings.sh
  create mode 100755 tools/perf/testsuite/base_list/setup.sh
  create mode 100755 tools/perf/testsuite/base_list/test_basic.sh

diff --git a/tools/perf/testsuite/base_list/cleanup.sh b/tools/perf/testsuite/base_list/cleanup.sh
new file mode 100755
index 0000000..d2ef647
--- /dev/null
+++ b/tools/perf/testsuite/base_list/cleanup.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+#
+#	cleanup.sh of perf list test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+if [ -n "$PERFSUITE_RUN_DIR" ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+find . -name \*.log | xargs -r rm
+find . -name \*.err | xargs -r rm
+
+print_overal_results 0
+exit $?
diff --git a/tools/perf/testsuite/base_list/settings.sh b/tools/perf/testsuite/base_list/settings.sh
new file mode 100644
index 0000000..eef343b
--- /dev/null
+++ b/tools/perf/testsuite/base_list/settings.sh
@@ -0,0 +1,30 @@
+#
+#	settings.sh of perf_list test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+export TEST_NAME="perf_list"
+export MY_ARCH=`arch`
+export MY_HOSTNAME=`hostname`
+export MY_KERNEL_VERSION=`uname -r`
+export MY_CPUS_ONLINE=`nproc`
+export MY_CPUS_AVAILABLE=`cat /proc/cpuinfo | grep -P "processor\s" | wc -l`
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
diff --git a/tools/perf/testsuite/base_list/setup.sh b/tools/perf/testsuite/base_list/setup.sh
new file mode 100755
index 0000000..e254d05
--- /dev/null
+++ b/tools/perf/testsuite/base_list/setup.sh
@@ -0,0 +1,20 @@
+#!/bin/bash
+
+#
+#	setup.sh of perf list test
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
+print_overall_results 0
+exit $?
diff --git a/tools/perf/testsuite/base_list/test_basic.sh b/tools/perf/testsuite/base_list/test_basic.sh
new file mode 100755
index 0000000..7eed587
--- /dev/null
+++ b/tools/perf/testsuite/base_list/test_basic.sh
@@ -0,0 +1,101 @@
+#!/bin/bash
+
+#
+#	test_basic of perf_list test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests basic functionality of perf list command.
+#
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+TEST_RESULT=0
+
+
+### help message
+
+if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
+	# test that a help message is shown and looks reasonable
+	$CMD_PERF list --help > $LOGS_DIR/basic_helpmsg.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-LIST" "NAME" "SYNOPSIS" "DESCRIPTION" "EVENT MODIFIERS" "RAW HARDWARE" "PARAMETERIZED EVENTS" "OPTIONS" "SEE ALSO" "NOTES" < $LOGS_DIR/basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "perf\-list \- List all symbolic event types" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "help message"
+	(( TEST_RESULT += $? ))
+else
+	print_testcase_skipped "help message"
+fi
+
+
+### basic execution
+
+# test that perf list is even working
+$CMD_PERF list > $LOGS_DIR/basic_basic.log 2> $LOGS_DIR/basic_basic.err
+PERF_EXIT_CODE=$?
+
+REGEX_LINE_HEADER="List of pre-defined events"
+REGEX_LINE_BASIC="\s*$RE_EVENT_ANY\s+(?:OR\s+$RE_EVENT_ANY\s+)?\[.*event.*\]"
+REGEX_LINE_BREAKPOINT="\s*mem:<addr>.*\s+\[Hardware breakpoint\]"
+REGEX_LINE_RAW="\[Raw hardware event descriptor\]"
+REGEX_LINE_AUX="see \'man perf\-list\' on how to encode it"
+../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "$REGEX_LINE_HEADER" "$REGEX_LINE_BASIC" "$REGEX_LINE_BREAKPOINT" "$REGEX_LINE_RAW" "$REGEX_LINE_AUX" < $LOGS_DIR/basic_basic.log
+CHECK_EXIT_CODE=$?
+test ! -s $LOGS_DIR/basic_basic.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution"
+(( TEST_RESULT += $? ))
+
+
+### listing event groups
+
+# perf list can filter the list by keywords or group globals
+declare -A outputs
+outputs["hw"]="Hardware event"
+outputs["sw"]="Software event"
+outputs["cache"]="Hardware cache event"
+outputs["tracepoint"]="Tracepoint event"
+outputs["pmu"]="Kernel PMU event"
+outputs["xfs:\*"]="^\s*xfs:"
+outputs["kmem:\*"]="^\s*kmem:"
+outputs["syscalls:\*"]="^\s*syscalls:sys"
+
+for i in ${!outputs[@]}; do
+	j=`echo $i | tr -d '\\\*:'`
+	$CMD_PERF list $i > $LOGS_DIR/basic_$j.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_lines_matched.pl "$REGEX_LINE_HEADER" "$RE_LINE_EMPTY" "${outputs[$i]}" < $LOGS_DIR/basic_$j.log
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "list $i"
+	(( TEST_RESULT += $? ))
+done
+
+
+### non-sense argument
+
+# 'perf list somethingnonsense' caused segfault in 4.4-rc
+$CMD_PERF list somethingnonsense &> $LOGS_DIR/basic_nonsense.log
+PERF_EXIT_CODE=$?
+
+../common/check_no_patterns_found.pl "SIGSEGV" "egmentation fault" < $LOGS_DIR/basic_nonsense.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "non-sense argument"
+(( TEST_RESULT += $? ))
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
1.8.3.1
