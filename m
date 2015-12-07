From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 7/9] perf test: new testsuite: perf report tests
Date: Mon, 07 Dec 2015 19:53:34 +0100
Message-ID: <1449514414.24573.257.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53781 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbbLGSxg (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Dec 2015 13:53:36 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 3CE86AAA
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Dec 2015 18:53:36 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

This commit adds tests for perf report tool.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/testsuite/base_report/cleanup.sh        |  22 +++
 tools/perf/testsuite/base_report/settings.sh       |  15 ++
 tools/perf/testsuite/base_report/setup.sh          |  26 ++++
 .../testsuite/base_report/stderr-whitelist.txt     |   1 +
 tools/perf/testsuite/base_report/test_basic.sh     | 169 +++++++++++++++++++++
 5 files changed, 233 insertions(+)
 create mode 100755 tools/perf/testsuite/base_report/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_report/settings.sh
 create mode 100755 tools/perf/testsuite/base_report/setup.sh
 create mode 100644 tools/perf/testsuite/base_report/stderr-whitelist.txt
 create mode 100755 tools/perf/testsuite/base_report/test_basic.sh

diff --git a/tools/perf/testsuite/base_report/cleanup.sh b/tools/perf/testsuite/base_report/cleanup.sh
new file mode 100755
index 0000000..f44931e
--- /dev/null
+++ b/tools/perf/testsuite/base_report/cleanup.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+#
+#	cleanup.sh of perf report test
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
+rm -f perf.data*
+RM_EXIT_CODE=$?
+
+print_results $RM_EXIT_CODE 0 "clean-up perf.data file and logs"
+exit $?
diff --git a/tools/perf/testsuite/base_report/settings.sh b/tools/perf/testsuite/base_report/settings.sh
new file mode 100644
index 0000000..e345a10
--- /dev/null
+++ b/tools/perf/testsuite/base_report/settings.sh
@@ -0,0 +1,15 @@
+#
+#	settings.sh of perf_report test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+export TEST_NAME="perf_report"
+export MY_ARCH=`arch`
+export MY_HOSTNAME=`hostname`
+export MY_KERNEL_VERSION=`uname -r`
+export MY_CPUS_ONLINE=`nproc`
+export MY_CPUS_AVAILABLE=`cat /proc/cpuinfo | grep processor | wc -l`
diff --git a/tools/perf/testsuite/base_report/setup.sh b/tools/perf/testsuite/base_report/setup.sh
new file mode 100755
index 0000000..310fbf0
--- /dev/null
+++ b/tools/perf/testsuite/base_report/setup.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+#
+#	setup.sh of perf report test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		We need some sample data for perf-report testing
+#
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+
+$CMD_PERF record -asdg -- $CMD_LONGER_SLEEP 2> setup.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < setup.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "prepare the perf.data file"
+exit $?
diff --git a/tools/perf/testsuite/base_report/stderr-whitelist.txt b/tools/perf/testsuite/base_report/stderr-whitelist.txt
new file mode 100644
index 0000000..d59b483
--- /dev/null
+++ b/tools/perf/testsuite/base_report/stderr-whitelist.txt
@@ -0,0 +1 @@
+no symbols found in .*, maybe install a debug package
diff --git a/tools/perf/testsuite/base_report/test_basic.sh b/tools/perf/testsuite/base_report/test_basic.sh
new file mode 100755
index 0000000..1d148c51
--- /dev/null
+++ b/tools/perf/testsuite/base_report/test_basic.sh
@@ -0,0 +1,169 @@
+#!/bin/bash
+
+#
+#	test_basic of perf_report test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests basic functionality of perf report command.
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
+	$CMD_PERF report --help > basic_helpmsg.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-REPORT" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "OVERHEAD\s+CALCULATION" "SEE ALSO" < basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "input" "verbose" "show-nr-samples" "showcpuutilization" "threads" "comms" "pid" "tid" "dsos" "symbols" "symbol-filter" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "hide-unresolved" "sort" "fields" "parent" "exclude-other" "column-widths" "field-separator" "dump-raw-trace" "children" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "call-graph" "max-stack" "inverted" "ignore-callees" "pretty" "stdio" "tui" "gtk" "vmlinux" "kallsyms" "modules" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "force" "symfs" "cpu" "disassembler-style" "source" "asm-raw" "show-total-period" "show-info" "branch-stack" "group" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "branch-history" "objdump" "demangle" "percent-limit" "percentage" "header" "itrace" "full-source-path" "show-ref-call-graph" < basic_helpmsg.log
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
+# test that perf report is even working
+$CMD_PERF report --stdio > basic_basic.log 2> basic_basic.err
+PERF_EXIT_CODE=$?
+
+REGEX_LOST_SAMPLES_INFO="#\s*Total Lost Samples:\s+$RE_NUMBER"
+REGEX_SAMPLES_INFO="#\s*Samples:\s+$RE_NUMBER\s+of\s+event\s+'$RE_EVENT_ANY'"
+REGEX_LINES_HEADER="#\s*Children\s+Self\s+Command\s+Shared Object\s+Symbol"
+REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.vmlinux\]\s+\[[k\.]\]\s+\w+"
+../common/check_all_patterns_found.pl "$REGEX_LOST_SAMPLES_INFO" "$REGEX_SAMPLES_INFO" "$REGEX_LINES_HEADER" "$REGEX_LINES" < basic_basic.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < basic_basic.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution"
+(( TEST_RESULT += $? ))
+
+
+### number of samples
+
+# '--show-nr-samples' should show number of samples for each symbol
+$CMD_PERF report --stdio --show-nr-samples > basic_nrsamples.log 2> basic_nrsamples.err
+PERF_EXIT_CODE=$?
+
+REGEX_LINES_HEADER="#\s*Children\s+Self\s+Samples\s+Command\s+Shared Object\s+Symbol"
+REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER\s+\S+\s+\[kernel\.vmlinux\]\s+\[[k\.]\]\s+\w+"
+../common/check_all_patterns_found.pl "$REGEX_LINES_HEADER" "$REGEX_LINES" < basic_nrsamples.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < basic_nrsamples.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "number of samples"
+(( TEST_RESULT += $? ))
+
+
+### header
+
+# '--header' and '--header-only' should show perf report header
+$CMD_PERF report --stdio --header-only > basic_header.log
+PERF_EXIT_CODE=$?
+
+REGEX_LINE_HOSTNAME="#\s+hostname\s*:\s*$MY_HOSTNAME"
+REGEX_LINE_KERNEL="#\s+os release\s*:\s*$MY_KERNEL_VERSION"
+REGEX_LINE_PERF="#\s+perf version\s*:\s*"
+REGEX_LINE_ARCH="#\s+arch\s*:\s*$MY_ARCH"
+REGEX_LINE_CPUS_ONLINE="#\s+nrcpus online\s*:\s*$MY_CPUS_ONLINE"
+REGEX_LINE_CPUS_AVAIL="#\s+nrcpus avail\s*:\s*$MY_CPUS_AVAILABLE"
+../common/check_all_patterns_found.pl "$REGEX_LINE_HOSTNAME" "$REGEX_LINE_KERNEL" "$REGEX_LINE_PERF" "$REGEX_LINE_ARCH" "$REGEX_LINE_CPUS_ONLINE" "$REGEX_LINE_CPUS_AVAIL" < basic_header.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "header"
+(( TEST_RESULT += $? ))
+
+
+### show CPU utilization
+
+# '--showcpuutilization' should show percentage for both system and userspace mode
+$CMD_PERF report --stdio --showcpuutilization > basic_cpuut.log 2> basic_cpuut.err
+PERF_EXIT_CODE=$?
+
+REGEX_LINES_HEADER="#\s*Children\s+Self\s+sys\s+usr\s+Command\s+Shared Object\s+Symbol"
+REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.vmlinux\]\s+\[[k\.]\]\s+\w+"
+../common/check_all_patterns_found.pl "$REGEX_LINES_HEADER" "$REGEX_LINES" < basic_cpuut.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < basic_cpuut.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "show CPU utilization"
+(( TEST_RESULT += $? ))
+
+
+### pid
+
+# '--pid=' should limit the output for a process with the given pid only
+$CMD_PERF report --stdio --pid=1 > basic_pid.log 2> basic_pid.err
+PERF_EXIT_CODE=$?
+
+grep -P '\s+[\d\.]+%' basic_pid.log | ../common/check_all_lines_matched.pl "systemd|init"
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < basic_pid.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "pid"
+(( TEST_RESULT += $? ))
+
+
+### non-existing symbol
+
+# '--symbols' should show only the given symbols
+$CMD_PERF report --stdio --symbols=dummynonexistingsymbol > basic_symbols.log 2> basic_symbols.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < basic_symbols.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < basic_symbols.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "non-existing symbol"
+(( TEST_RESULT += $? ))
+
+
+### symbol filter
+
+# '--symbol-filter' should filter symbols based on substrings
+$CMD_PERF report --stdio --symbol-filter=map > basic_symbolfilter.log 2> basic_symbolfilter.err
+PERF_EXIT_CODE=$?
+
+grep -P '\s+[\d\.]+%' basic_symbolfilter.log | ../common/check_all_lines_matched.pl "\[[k\.]\]\s+.*map"
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < basic_symbolfilter.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "symbol filter"
+(( TEST_RESULT += $? ))
+
+
+# TODO: $CMD_PERF report -n --showcpuutilization -TUxDg 2> 01.log
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
