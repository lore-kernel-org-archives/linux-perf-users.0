From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 9/9] perf test: new testsuite: perf trace tests
Date: Mon, 07 Dec 2015 19:53:49 +0100
Message-ID: <1449514429.24573.259.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36994 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755740AbbLGSxv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Dec 2015 13:53:51 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 75D50C0B7A13
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Dec 2015 18:53:51 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

This commit adds tests for perf trace tools.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/testsuite/base_trace/cleanup.sh         |  19 +++
 tools/perf/testsuite/base_trace/settings.sh        |  10 ++
 tools/perf/testsuite/base_trace/setup.sh           |  16 +++
 .../perf/testsuite/base_trace/stderr-whitelist.txt |   1 +
 tools/perf/testsuite/base_trace/test_basic.sh      | 129 +++++++++++++++++++++
 tools/perf/testsuite/base_trace/test_record.sh     |  45 +++++++
 6 files changed, 220 insertions(+)
 create mode 100755 tools/perf/testsuite/base_trace/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_trace/settings.sh
 create mode 100755 tools/perf/testsuite/base_trace/setup.sh
 create mode 100644 tools/perf/testsuite/base_trace/stderr-whitelist.txt
 create mode 100755 tools/perf/testsuite/base_trace/test_basic.sh
 create mode 100755 tools/perf/testsuite/base_trace/test_record.sh

diff --git a/tools/perf/testsuite/base_trace/cleanup.sh b/tools/perf/testsuite/base_trace/cleanup.sh
new file mode 100755
index 0000000..8a16968
--- /dev/null
+++ b/tools/perf/testsuite/base_trace/cleanup.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+
+#
+#	cleanup.sh of perf_trace test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+. ../common/init.sh
+. ./settings.sh
+
+find . -name \*.log | xargs -r rm
+find . -name \*.err | xargs -r rm
+rm -f perf.data*
+print_overall_results 0
+exit 0
diff --git a/tools/perf/testsuite/base_trace/settings.sh b/tools/perf/testsuite/base_trace/settings.sh
new file mode 100644
index 0000000..730ac74
--- /dev/null
+++ b/tools/perf/testsuite/base_trace/settings.sh
@@ -0,0 +1,10 @@
+#
+#	settings.sh of perf_trace test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+export TEST_NAME="perf_trace"
diff --git a/tools/perf/testsuite/base_trace/setup.sh b/tools/perf/testsuite/base_trace/setup.sh
new file mode 100755
index 0000000..8d5ccaa
--- /dev/null
+++ b/tools/perf/testsuite/base_trace/setup.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+
+#
+#	setup.sh of SKELETON test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+. ../common/init.sh
+. ./settings.sh
+
+print_overall_results 0
+exit 0
diff --git a/tools/perf/testsuite/base_trace/stderr-whitelist.txt b/tools/perf/testsuite/base_trace/stderr-whitelist.txt
new file mode 100644
index 0000000..d59b483
--- /dev/null
+++ b/tools/perf/testsuite/base_trace/stderr-whitelist.txt
@@ -0,0 +1 @@
+no symbols found in .*, maybe install a debug package
diff --git a/tools/perf/testsuite/base_trace/test_basic.sh b/tools/perf/testsuite/base_trace/test_basic.sh
new file mode 100755
index 0000000..e80f124
--- /dev/null
+++ b/tools/perf/testsuite/base_trace/test_basic.sh
@@ -0,0 +1,129 @@
+#!/bin/bash
+
+#
+#	test_basic of perf_trace test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests basic functionality of perf trace command.
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
+#### help message
+
+if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
+	# test that a help message is shown and looks reasonable
+	$CMD_PERF trace --help > basic_helpmsg.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-TRACE" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "PAGEFAULTS" "EXAMPLES" "SEE ALSO" "NOTES" < basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "all-cpus" "expr" "output" "pid" "tid" "uid" "verbose" "cpu" "duration" "summary" "sched" "event" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "perf trace record" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "help message"
+	(( TEST_RESULT += $? ))
+else
+	print_testcase_skipped "help message"
+fi
+
+#### basic execution
+
+# test that perf trace is working
+$CMD_PERF trace $CMD_QUICK_SLEEP 2> basic_basic.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_TRACE" < basic_basic.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution"
+(( TEST_RESULT += $? ))
+
+
+### duration threshold
+
+# '--duration X' should show only syscalls that take longer than X ms
+$CMD_PERF trace --duration 80 $CMD_BASIC_SLEEP 2> basic_duration.log
+PERF_EXIT_CODE=$?
+
+REGEX_SLEEP_SYSCALL_ONLY="^\s*$RE_NUMBER\s*\(\s*$RE_NUMBER\s*ms\s*\):\s*$RE_PROCESS_PID\s+\w*sleep\(.*\)\s+=\s+\-?$RE_NUMBER|$RE_NUMBER_HEX.*$"
+../common/check_all_lines_matched.pl "$REGEX_SLEEP_SYSCALL_ONLY" < basic_duration.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "duration threshold"
+(( TEST_RESULT += $? ))
+
+
+### systemwide
+
+# '-a' should trace system-wide from all CPUs
+$CMD_PERF trace -o basic_systemwide.log -a &
+PERF_PID=$!
+$CMD_LONGER_SLEEP
+kill -SIGINT $PERF_PID
+wait $PERF_PID
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_TRACE" < basic_systemwide.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "systemwide"
+(( TEST_RESULT += $? ))
+
+
+### full timestamp
+
+# '-T' should print the full timestamp instead of the relative one
+$CMD_PERF trace -T -- $CMD_QUICK_SLEEP 2> basic_full_timestamp.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_TRACE" "\d{8,}\." < basic_full_timestamp.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "full timestamp"
+(( TEST_RESULT += $? ))
+
+
+### summary
+
+# '-s' should print out a summary table
+$CMD_PERF trace -s -- $CMD_QUICK_SLEEP 2> basic_summary.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "$RE_LINE_EMPTY" "$RE_LINE_TRACE_SUMMARY_HEADER" "$RE_LINE_TRACE_SUMMARY_CONTENT" < basic_summary.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "summary"
+(( TEST_RESULT += $? ))
+
+
+### attach process
+
+# perf-trace should be able to attach an existing process by '-p PID'
+$CMD_BASIC_SLEEP &
+$CMD_PERF trace -p $! -o basic_attach.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_TRACE" < basic_attach.log
+CHECK_EXIT_CODE=$?
+# perf should know the syscall even if perf attached during it (sleep)
+../common/check_all_patterns_found.pl "sleep" "close" "exit" < basic_attach.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "attach process"
+(( TEST_RESULT += $? ))
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_trace/test_record.sh b/tools/perf/testsuite/base_trace/test_record.sh
new file mode 100755
index 0000000..dab3471
--- /dev/null
+++ b/tools/perf/testsuite/base_trace/test_record.sh
@@ -0,0 +1,45 @@
+#!/bin/bash
+
+#
+#	test_record of perf_trace test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests the sampling mode of perf-trace.
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
+#### basic execution
+
+# test that perf trace record is working
+$CMD_PERF trace record $CMD_QUICK_SLEEP 2> record_basic_record.log
+PERF_EXIT_CODE=$?
+$CMD_PERF report --stdio > record_basic_report.log 2> record_basic_report.err
+(( PERF_EXIT_CODE += $? ))
+
+# check the perf record output
+../common/check_all_lines_matched.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < record_basic_record.log
+CHECK_EXIT_CODE=$?
+# check the perf report output
+../common/check_all_lines_matched.pl "$RE_LINE_REPORT_CONTENT" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < record_basic_report.log
+(( CHECK_EXIT_CODE += $? ))
+# check that the perf report stderr is empty
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < record_basic_report.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution - record"
+(( TEST_RESULT += $? ))
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
