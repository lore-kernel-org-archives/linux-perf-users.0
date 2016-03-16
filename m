From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 7/9] perf test: new testsuite: perf report tests
Date: Wed, 16 Mar 2016 14:56:50 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1603161456370.13911@Rudolf-RHEL-7>
References: <cover.1458134357.git.mpetlan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35640 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966636AbcCPN4x (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Mar 2016 09:56:53 -0400
In-Reply-To: <cover.1458134357.git.mpetlan@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, jolsa@redhat.com

This commit adds tests for perf report tool.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
  tools/perf/testsuite/base_report/cleanup.sh        |  24 +++
  tools/perf/testsuite/base_report/settings.sh       |  30 ++++
  tools/perf/testsuite/base_report/setup.sh          |  26 ++++
  .../testsuite/base_report/stderr-whitelist.txt     |   1 +
  tools/perf/testsuite/base_report/test_basic.sh     | 169 +++++++++++++++++++++
  5 files changed, 250 insertions(+)
  create mode 100755 tools/perf/testsuite/base_report/cleanup.sh
  create mode 100644 tools/perf/testsuite/base_report/settings.sh
  create mode 100755 tools/perf/testsuite/base_report/setup.sh
  create mode 100644 tools/perf/testsuite/base_report/stderr-whitelist.txt
  create mode 100755 tools/perf/testsuite/base_report/test_basic.sh

diff --git a/tools/perf/testsuite/base_report/cleanup.sh b/tools/perf/testsuite/base_report/cleanup.sh
new file mode 100755
index 0000000..50e72e1
--- /dev/null
+++ b/tools/perf/testsuite/base_report/cleanup.sh
@@ -0,0 +1,24 @@
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
+if [ -n "$PERFSUITE_RUN_DIR" ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+find . -name \*.log | xargs -r rm
+find . -name \*.err | xargs -r rm
+rm -f perf.data*
+RM_EXIT_CODE=$?
+
+print_overall_results $RM_EXIT_CODE
+exit $?
diff --git a/tools/perf/testsuite/base_report/settings.sh b/tools/perf/testsuite/base_report/settings.sh
new file mode 100644
index 0000000..fd6e10c
--- /dev/null
+++ b/tools/perf/testsuite/base_report/settings.sh
@@ -0,0 +1,30 @@
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
diff --git a/tools/perf/testsuite/base_report/setup.sh b/tools/perf/testsuite/base_report/setup.sh
new file mode 100755
index 0000000..82f06dd
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
+$CMD_PERF record -asdg -o $CURRENT_TEST_DIR/perf.data -- $CMD_LONGER_SLEEP 2> $LOGS_DIR/setup.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/setup.log
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
index 0000000..77ce3cf
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
+	$CMD_PERF report --help > $LOGS_DIR/basic_helpmsg.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-REPORT" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "OVERHEAD\s+CALCULATION" "SEE ALSO" < $LOGS_DIR/basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "input" "verbose" "show-nr-samples" "showcpuutilization" "threads" "comms" "pid" "tid" "dsos" "symbols" "symbol-filter" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "hide-unresolved" "sort" "fields" "parent" "exclude-other" "column-widths" "field-separator" "dump-raw-trace" "children" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "call-graph" "max-stack" "inverted" "ignore-callees" "pretty" "stdio" "tui" "gtk" "vmlinux" "kallsyms" "modules" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "force" "symfs" "cpu" "disassembler-style" "source" "asm-raw" "show-total-period" "show-info" "branch-stack" "group" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "branch-history" "objdump" "demangle" "percent-limit" "percentage" "header" "itrace" "full-source-path" "show-ref-call-graph" < $LOGS_DIR/basic_helpmsg.log
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
+$CMD_PERF report -i $CURRENT_TEST_DIR/perf.data --stdio > $LOGS_DIR/basic_basic.log 2> $LOGS_DIR/basic_basic.err
+PERF_EXIT_CODE=$?
+
+REGEX_LOST_SAMPLES_INFO="#\s*Total Lost Samples:\s+$RE_NUMBER"
+REGEX_SAMPLES_INFO="#\s*Samples:\s+(?:$RE_NUMBER)\w?\s+of\s+event\s+'$RE_EVENT_ANY'"
+REGEX_LINES_HEADER="#\s*Children\s+Self\s+Command\s+Shared Object\s+Symbol"
+REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.vmlinux\]\s+\[[k\.]\]\s+\w+"
+../common/check_all_patterns_found.pl "$REGEX_LOST_SAMPLES_INFO" "$REGEX_SAMPLES_INFO" "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_basic.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_basic.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution"
+(( TEST_RESULT += $? ))
+
+
+### number of samples
+
+# '--show-nr-samples' should show number of samples for each symbol
+$CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --show-nr-samples > $LOGS_DIR/basic_nrsamples.log 2> $LOGS_DIR/basic_nrsamples.err
+PERF_EXIT_CODE=$?
+
+REGEX_LINES_HEADER="#\s*Children\s+Self\s+Samples\s+Command\s+Shared Object\s+Symbol"
+REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER\s+\S+\s+\[kernel\.vmlinux\]\s+\[[k\.]\]\s+\w+"
+../common/check_all_patterns_found.pl "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_nrsamples.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_nrsamples.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "number of samples"
+(( TEST_RESULT += $? ))
+
+
+### header
+
+# '--header' and '--header-only' should show perf report header
+( cd $CURRENT_TEST_DIR ; $CMD_PERF report --stdio --header-only > $LOGS_DIR/basic_header.log )
+PERF_EXIT_CODE=$?
+
+REGEX_LINE_HOSTNAME="#\s+hostname\s*:\s*$MY_HOSTNAME"
+REGEX_LINE_KERNEL="#\s+os release\s*:\s*$MY_KERNEL_VERSION"
+REGEX_LINE_PERF="#\s+perf version\s*:\s*"
+REGEX_LINE_ARCH="#\s+arch\s*:\s*$MY_ARCH"
+REGEX_LINE_CPUS_ONLINE="#\s+nrcpus online\s*:\s*$MY_CPUS_ONLINE"
+REGEX_LINE_CPUS_AVAIL="#\s+nrcpus avail\s*:\s*$MY_CPUS_AVAILABLE"
+../common/check_all_patterns_found.pl "$REGEX_LINE_HOSTNAME" "$REGEX_LINE_KERNEL" "$REGEX_LINE_PERF" "$REGEX_LINE_ARCH" "$REGEX_LINE_CPUS_ONLINE" "$REGEX_LINE_CPUS_AVAIL" < $LOGS_DIR/basic_header.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "header"
+(( TEST_RESULT += $? ))
+
+
+### show CPU utilization
+
+# '--showcpuutilization' should show percentage for both system and userspace mode
+( cd $CURRENT_TEST_DIR ; $CMD_PERF report --stdio --showcpuutilization > $LOGS_DIR/basic_cpuut.log 2> $LOGS_DIR/basic_cpuut.err )
+PERF_EXIT_CODE=$?
+
+REGEX_LINES_HEADER="#\s*Children\s+Self\s+sys\s+usr\s+Command\s+Shared Object\s+Symbol"
+REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.vmlinux\]\s+\[[k\.]\]\s+\w+"
+../common/check_all_patterns_found.pl "$REGEX_LINES_HEADER" "$REGEX_LINES" < $LOGS_DIR/basic_cpuut.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_cpuut.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "show CPU utilization"
+(( TEST_RESULT += $? ))
+
+
+### pid
+
+# '--pid=' should limit the output for a process with the given pid only
+$CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --pid=1 > $LOGS_DIR/basic_pid.log 2> $LOGS_DIR/basic_pid.err
+PERF_EXIT_CODE=$?
+
+grep -P '\s+[\d\.]+%' $LOGS_DIR/basic_pid.log | ../common/check_all_lines_matched.pl "systemd|init"
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_pid.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "pid"
+(( TEST_RESULT += $? ))
+
+
+### non-existing symbol
+
+# '--symbols' should show only the given symbols
+$CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --symbols=dummynonexistingsymbol > $LOGS_DIR/basic_symbols.log 2> $LOGS_DIR/basic_symbols.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < $LOGS_DIR/basic_symbols.log
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_symbols.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "non-existing symbol"
+(( TEST_RESULT += $? ))
+
+
+### symbol filter
+
+# '--symbol-filter' should filter symbols based on substrings
+$CMD_PERF report --stdio -i $CURRENT_TEST_DIR/perf.data --symbol-filter=map > $LOGS_DIR/basic_symbolfilter.log 2> $LOGS_DIR/basic_symbolfilter.err
+PERF_EXIT_CODE=$?
+
+grep -P '\s+[\d\.]+%' $LOGS_DIR/basic_symbolfilter.log | ../common/check_all_lines_matched.pl "\[[k\.]\]\s+.*map"
+CHECK_EXIT_CODE=$?
+../common/check_errors_whitelisted.pl "stderr-whitelist.txt" < $LOGS_DIR/basic_symbolfilter.err
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
-- 
1.8.3.1
