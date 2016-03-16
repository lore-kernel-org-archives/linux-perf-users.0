From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 8/9] perf test: new testsuite: perf stat tests
Date: Wed, 16 Mar 2016 14:57:19 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1603161456580.13911@Rudolf-RHEL-7>
References: <cover.1458134357.git.mpetlan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35655 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966734AbcCPN5W (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Mar 2016 09:57:22 -0400
In-Reply-To: <cover.1458134357.git.mpetlan@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, jolsa@redhat.com

This commit adds tests for perf stat tool and event checking.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
  tools/perf/testsuite/base_stat/cleanup.sh          | 26 ++++++++
  tools/perf/testsuite/base_stat/settings.sh         | 25 ++++++++
  tools/perf/testsuite/base_stat/test_basic.sh       | 69 ++++++++++++++++++++++
  tools/perf/testsuite/base_stat/test_hw.sh          | 50 ++++++++++++++++
  tools/perf/testsuite/base_stat/test_hwcache.sh     | 51 ++++++++++++++++
  .../perf/testsuite/base_stat/test_intel_uncore.sh  | 46 +++++++++++++++
  .../testsuite/base_stat/test_powerpc_hv_24x7.sh    | 60 +++++++++++++++++++
  .../base_stat/test_tracepoints_definition.sh       | 62 +++++++++++++++++++
  8 files changed, 389 insertions(+)
  create mode 100755 tools/perf/testsuite/base_stat/cleanup.sh
  create mode 100644 tools/perf/testsuite/base_stat/settings.sh
  create mode 100755 tools/perf/testsuite/base_stat/test_basic.sh
  create mode 100755 tools/perf/testsuite/base_stat/test_hw.sh
  create mode 100755 tools/perf/testsuite/base_stat/test_hwcache.sh
  create mode 100755 tools/perf/testsuite/base_stat/test_intel_uncore.sh
  create mode 100755 tools/perf/testsuite/base_stat/test_powerpc_hv_24x7.sh
  create mode 100755 tools/perf/testsuite/base_stat/test_tracepoints_definition.sh

diff --git a/tools/perf/testsuite/base_stat/cleanup.sh b/tools/perf/testsuite/base_stat/cleanup.sh
new file mode 100755
index 0000000..2405f845
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/cleanup.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+#
+#	cleanup.sh of perf stat test
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
+if [ -n "$PERFSUITE_RUN_DIR" ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+find . -name \*.log | xargs -r rm
+test -d hw && rmdir hw
+test -d hwcache && rmdir hwcache
+test -d hv24x7 && rmdir hv_24x7
+test -d intel_uncore && rmdir intel_uncore
+print_overall_results 0
+exit 0
diff --git a/tools/perf/testsuite/base_stat/settings.sh b/tools/perf/testsuite/base_stat/settings.sh
new file mode 100644
index 0000000..1cf94ba
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/settings.sh
@@ -0,0 +1,25 @@
+#
+#	settings.sh of perf_stat test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+export TEST_NAME="perf_stat"
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
diff --git a/tools/perf/testsuite/base_stat/test_basic.sh b/tools/perf/testsuite/base_stat/test_basic.sh
new file mode 100755
index 0000000..6acc42b
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/test_basic.sh
@@ -0,0 +1,69 @@
+#!/bin/bash
+
+#
+#	test_basic of perf_stat test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests basic functionality of perf stat command.
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
+#### basic execution
+
+# test that perf stat is even working
+$CMD_PERF stat $CMD_SIMPLE 2> $LOGS_DIR/01.log
+PERF_EXIT_CODE=$?
+
+REGEX_HEADER="\s*Performance counter stats for 'true':"
+REGEX_LINES="\s*"$RE_NUMBER"\s+"$RE_EVENT"\s+#\s+"$RE_NUMBER"%?.*"
+../common/check_all_patterns_found.pl "$REGEX_HEADER" "$REGEX_LINES" < $LOGS_DIR/01.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution"
+(( TEST_RESULT += $? ))
+
+
+#### some options
+
+# test some basic options that they change the behaviour
+$CMD_PERF stat -i -a -c -r 3 -o /dev/stdout -- $CMD_BASIC_SLEEP > $LOGS_DIR/02.log
+PERF_EXIT_CODE=$?
+
+REGEX_HEADER="^\s*Performance counter stats for '(sleep [\d\.]+|system wide)' \(3 runs\):"
+REGEX_LINES="\s*"$RE_NUMBER"\s+"$RE_EVENT"\s+#\s+"$RE_NUMBER"%?.*\s*"$RE_NUMBER"%?.*"
+REGEX_FOOTER="^\s*"$RE_NUMBER" seconds time elapsed.*"
+../common/check_all_patterns_found.pl "$REGEX_HEADER" "$REGEX_LINES" "$REGEX_FOOTER" < $LOGS_DIR/02.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "some options"
+(( TEST_RESULT += $? ))
+
+
+#### CSV output
+
+# with -x'<SEPARATOR>' perf stat should produce a CSV output
+$CMD_PERF stat -x';' -o /dev/stdout -a -- sleep 0.1 > $LOGS_DIR/03.log
+PERF_EXIT_CODE=$?
+
+REGEX_LINES="^"$RE_NUMBER";+"$RE_EVENT
+REGEX_UNSUPPORTED_LINES="^<not supported>;+"$RE_EVENT
+REGEX_METRIC_LINE="stalled\scycles\sper\sinsn"
+../common/check_all_lines_matched.pl "$REGEX_LINES" "$REGEX_METRIC_LINE" "$REGEX_UNSUPPORTED_LINES" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < $LOGS_DIR/03.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "CSV output"
+(( TEST_RESULT += $? ))
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_stat/test_hw.sh b/tools/perf/testsuite/base_stat/test_hw.sh
new file mode 100755
index 0000000..9ec5eaf
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/test_hw.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+
+#
+#	test_hw of perf_stat test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests hardware events by perf stat.
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
+EVENTS_TO_TEST=`$CMD_PERF list hw | grep "Hardware event" | awk '{print $1}' | egrep '^.' | tr '\n' ' '`
+if [ -z "$EVENTS_TO_TEST" ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+# FIXME test -e hw.log && rm -f hw.log
+
+test -d $LOGS_DIR/hw || mkdir $LOGS_DIR/hw
+
+
+#### testing hardware events
+
+for event in $EVENTS_TO_TEST; do
+	$CMD_PERF stat -a -e $event -o $LOGS_DIR/hw/$event.log --append -x';' -- $CMD_BASIC_SLEEP
+	PERF_EXIT_CODE=$?
+	REGEX_LINES="$RE_NUMBER;+$event;$RE_NUMBER;100\.00"
+	../common/check_all_patterns_found.pl "$REGEX_LINES" < $LOGS_DIR/hw/$event.log
+	CHECK_EXIT_CODE=$?
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "event $event"
+	(( TEST_RESULT += $? ))
+done
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
+
+
+
+# FIXME we should test the numbers
+# FIXME we should be able to blacklist events on some archs (<not supported> is OK (SND, IVB))
diff --git a/tools/perf/testsuite/base_stat/test_hwcache.sh b/tools/perf/testsuite/base_stat/test_hwcache.sh
new file mode 100755
index 0000000..7755fb12
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/test_hwcache.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+
+#
+#	test_hwcache of perf_stat test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests hardware events by perf stat.
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
+EVENTS_TO_TEST=`$CMD_PERF list hwcache | grep "Hardware cache event" | awk '{print $1}' | egrep '^.' | tr '\n' ' '`
+if [ -z "$EVENTS_TO_TEST" ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+test -d $LOGS_DIR/hwcache || mkdir $LOGS_DIR/hwcache
+
+# FIXME test -e hw.log && rm -f hw.log
+
+
+#### testing hardware events
+
+for event in $EVENTS_TO_TEST; do
+	$CMD_PERF stat -a -e $event -o $LOGS_DIR/hwcache/$event.log --append -x';' -- $CMD_BASIC_SLEEP
+	PERF_EXIT_CODE=$?
+	REGEX_LINES="$RE_NUMBER;+$event;$RE_NUMBER;100\.00"
+	../common/check_all_patterns_found.pl "$REGEX_LINES" < $LOGS_DIR/hwcache/$event.log
+	CHECK_EXIT_CODE=$?
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "event $event"
+	(( TEST_RESULT += $? ))
+done
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
+
+
+
+# FIXME we should test the numbers
+# FIXME we should be able to blacklist events on some archs (<not supported> is OK (SND, IVB))
diff --git a/tools/perf/testsuite/base_stat/test_intel_uncore.sh b/tools/perf/testsuite/base_stat/test_intel_uncore.sh
new file mode 100755
index 0000000..768f86e
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/test_intel_uncore.sh
@@ -0,0 +1,46 @@
+#!/bin/bash
+
+#
+#	test_intel_uncore of perf_stat test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests support of uncore events
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
+EVENTS_TO_TEST=`$CMD_PERF list | grep "uncore" | awk '{print $1}' | tr '\n' ' '`
+if [ -z "$EVENTS_TO_TEST" ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+test -d $LOGS_DIR/intel_uncore || mkdir $LOGS_DIR/intel_uncore
+
+
+#### testing Intel uncore events
+
+for event in $EVENTS_TO_TEST; do
+	EVENT_NAME=`echo $event | tr '/' '_' | tr ',' '-'`
+	$CMD_PERF stat -a -e $event -o $LOGS_DIR/intel_uncore/$EVENT_NAME.log -x';' -- $CMD_QUICK_SLEEP
+	PERF_EXIT_CODE=$?
+
+	REGEX_LINES="$RE_NUMBER;[^;]*;$RE_EVENT_ANY;$RE_NUMBER;100\.00"
+	../common/check_all_patterns_found.pl "$REGEX_LINES" < $LOGS_DIR/intel_uncore/$EVENT_NAME.log
+	CHECK_EXIT_CODE=$?
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "event $event"
+	(( TEST_RESULT += $? ))
+done
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_stat/test_powerpc_hv_24x7.sh b/tools/perf/testsuite/base_stat/test_powerpc_hv_24x7.sh
new file mode 100755
index 0000000..2d91d02
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/test_powerpc_hv_24x7.sh
@@ -0,0 +1,60 @@
+#!/bin/bash
+
+#
+#	test_powerpc_hv24x7 of perf_stat test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests hardware events by perf stat.
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
+EVENTS_TO_TEST=`$CMD_PERF list | grep "24x7" | grep "core" | awk '{print $1}' | tr '\n' ' '`
+if [ -z "$EVENTS_TO_TEST" ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+test -d $LOGS_DIR/hv_24x7 || mkdir $LOGS_DIR/hv_24x7
+
+if [ "$PARAM_STAT_24x7_ALL_CORES" = "y" ]; then
+	NPROC=`nproc`
+	CORES_TO_TEST="`seq 0 $((NPROC-1))`"
+else
+	CORES_TO_TEST="0"
+fi
+
+#### testing hv_24x7 events
+
+for event in $EVENTS_TO_TEST; do
+	EVENT_NAME=`echo $event | awk -F',' '{print $1}' | awk -F'/' '{print $2}'`
+	PERF_EXIT_CODE=0
+	for core in $CORES_TO_TEST; do
+		evt=`echo $event | sed "s/\?/$core/"`
+		$CMD_PERF stat -a -e $evt -o $LOGS_DIR/hv_24x7/$EVENT_NAME.log --append -x';' -- $CMD_QUICK_SLEEP
+		(( PERF_EXIT_CODE += $? ))
+	done
+	REGEX_LINES="$RE_NUMBER;+hv_24x7\/$EVENT_NAME,core=$RE_NUMBER\/;$RE_NUMBER;100\.00"
+	../common/check_all_patterns_found.pl "$REGEX_LINES" < $LOGS_DIR/hv_24x7/$EVENT_NAME.log
+	CHECK_EXIT_CODE=$?
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "event $EVENT_NAME"
+	(( TEST_RESULT += $? ))
+done
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
+
+
+
+# FIXME we should test the numbers
+# FIXME add lpar/vcpu events? maybe configurable
+# FIXME "You have POWER8 LPAR, so I think you should have hv24x7 but you do not!" warning
diff --git a/tools/perf/testsuite/base_stat/test_tracepoints_definition.sh b/tools/perf/testsuite/base_stat/test_tracepoints_definition.sh
new file mode 100755
index 0000000..ca5ac9d
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/test_tracepoints_definition.sh
@@ -0,0 +1,62 @@
+#!/bin/bash
+
+#
+#	test_tracepoints_definition.sh of perf_stat test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test checks the tracepoints for syntax
+#	errors in definition. It takes a long time, so
+#	that's why the test can be disabled by an option
+#	in common/parametrization.sh
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
+if [ ! "$PARAM_STAT_TRACEPOINT_EVENTS_SYNTAX" == "y" ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+test -d $LOGS_DIR/tracepoint_def || mkdir -p $LOGS_DIR/tracepoint_def
+
+# remove old logs
+rm -f $LOGS_DIR/tracepoint_def/tracepoints_def_*.log
+
+### check all the tracepoint events of all the available subsystems
+
+SUBSYSTEMS=`$CMD_PERF list tracepoint | grep "Tracepoint event" | awk '{print $1}' | awk -F':' '{print $1}' | sort -u`
+for subs in $SUBSYSTEMS; do
+	TRACEPOINT_EVENTS=`$CMD_PERF list $subs:\* | grep "Tracepoint event" | awk '{print $1}' | tr '\n' ' '`
+	PERF_EXIT_CODE=0
+	for tp in $TRACEPOINT_EVENTS; do
+		$CMD_PERF stat -e $tp -o /dev/stdout true > $LOGS_DIR/tracepoint_def/out 2> $LOGS_DIR/tracepoint_def/err
+		(( PERF_EXIT_CODE += $? ))
+		echo -n "$tp    is " >> $LOGS_DIR/tracepoint_def/tracepoints_def_$subs.log
+
+		# check whether the event is supported when it is listed
+		grep -qi "not supported" $LOGS_DIR/tracepoint_def/out
+		test $? -eq 0 && echo -n "NOT SUPPORTED and " >> $LOGS_DIR/tracepoint_def/tracepoints_def_$subs.log || echo -n "supported and " >> $LOGS_DIR/tracepoint_def/tracepoints_def_$subs.log
+
+		# check whether the event causes any warnings
+		test -s $LOGS_DIR/tracepoint_def/err
+		test $? -eq 0 && echo "CAUSES WARNINGS" >> $LOGS_DIR/tracepoint_def/tracepoints_def_$subs.log || echo "is defined correctly" >> $LOGS_DIR/tracepoint_def/tracepoints_def_$subs.log
+	done
+
+	# check for the results
+	! grep -e "CAUSES WARNINGS" -e "NOT SUPPORTED" $LOGS_DIR/tracepoint_def/tracepoints_def_$subs.log
+	print_results $PERF_EXIT_CODE $? "subsystem $subs"
+	(( TEST_RESULT += $? ))
+done
+
+rm -f $LOGS_DIR/tracepoint_def/err $LOGS_DIR/tracepoint_def/out
+
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
1.8.3.1
