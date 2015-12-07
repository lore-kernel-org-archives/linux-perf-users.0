From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 5/9] perf test: new testsuite: perf list tests
Date: Mon, 07 Dec 2015 19:53:24 +0100
Message-ID: <1449514404.24573.255.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39436 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbbLGSx0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Dec 2015 13:53:26 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 22B2F8CF53
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Dec 2015 18:53:26 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

This commit adds tests for perf list tool.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/testsuite/base_list/cleanup.sh    | 19 ++++++
 tools/perf/testsuite/base_list/settings.sh   | 15 +++++
 tools/perf/testsuite/base_list/setup.sh      | 20 +++++++
 tools/perf/testsuite/base_list/test_basic.sh | 88 ++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+)
 create mode 100755 tools/perf/testsuite/base_list/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_list/settings.sh
 create mode 100755 tools/perf/testsuite/base_list/setup.sh
 create mode 100755 tools/perf/testsuite/base_list/test_basic.sh

diff --git a/tools/perf/testsuite/base_list/cleanup.sh b/tools/perf/testsuite/base_list/cleanup.sh
new file mode 100755
index 0000000..0b1f8f2
--- /dev/null
+++ b/tools/perf/testsuite/base_list/cleanup.sh
@@ -0,0 +1,19 @@
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
+THIS_TEST_NAME=`basename $0 .sh`
+
+find . -name \*.log | xargs -r rm
+find . -name \*.err | xargs -r rm
+
+print_results 0 0 "clean-up logs"
+exit $?
diff --git a/tools/perf/testsuite/base_list/settings.sh b/tools/perf/testsuite/base_list/settings.sh
new file mode 100644
index 0000000..f3635e7
--- /dev/null
+++ b/tools/perf/testsuite/base_list/settings.sh
@@ -0,0 +1,15 @@
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
+export MY_CPUS_AVAILABLE=`cat /proc/cpuinfo | grep processor | wc -l`
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
index 0000000..1a80872
--- /dev/null
+++ b/tools/perf/testsuite/base_list/test_basic.sh
@@ -0,0 +1,88 @@
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
+	$CMD_PERF list --help > basic_helpmsg.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-LIST" "NAME" "SYNOPSIS" "DESCRIPTION" "EVENT MODIFIERS" "RAW HARDWARE" "PARAMETERIZED EVENTS" "OPTIONS" "SEE ALSO" "NOTES" < basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "perf\-list \- List all symbolic event types" < basic_helpmsg.log
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
+$CMD_PERF list > basic_basic.log 2> basic_basic.err
+PERF_EXIT_CODE=$?
+
+REGEX_LINE_HEADER="List of pre-defined events"
+REGEX_LINE_BASIC="\s*$RE_EVENT_ANY\s+(?:OR\s+$RE_EVENT_ANY\s+)?\[.*event.*\]"
+REGEX_LINE_BREAKPOINT="\s*mem:<addr>.*\s+\[Hardware breakpoint\]"
+REGEX_LINE_RAW="\[Raw hardware event descriptor\]"
+REGEX_LINE_AUX="see \'man perf\-list\' on how to encode it"
+../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "$REGEX_LINE_HEADER" "$REGEX_LINE_BASIC" "$REGEX_LINE_BREAKPOINT" "$REGEX_LINE_RAW" "$REGEX_LINE_AUX" < basic_basic.log
+CHECK_EXIT_CODE=$?
+test ! -s basic_basic.err
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
+	$CMD_PERF list $i > basic_$j.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_lines_matched.pl "$REGEX_LINE_HEADER" "$RE_LINE_EMPTY" "${outputs[$i]}" < basic_$j.log
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "list $i"
+	(( TEST_RESULT += $? ))
+done
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
