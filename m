From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 3/3] tools/perf/testsuite: Adding a set of testcases for
 perf-stat
Date: Thu, 22 Oct 2015 01:09:02 +0200
Message-ID: <1445468942.12960.120.camel@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36307 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756592AbbJUXJE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Oct 2015 19:09:04 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id A97C7C04FF81
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2015 23:09:04 +0000 (UTC)
Received: from [10.34.1.123] (dhcp-1-123.brq.redhat.com [10.34.1.123])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9LN93lb017104
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2015 19:09:04 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


A set of testcases for perf-stat that should test the basics of
the subcommand, the support of all the hw and hwcache events that
are shown by perf-list and a testcase that checks powerpc specific
hv_24x7 events.
---
 tools/perf/testsuite/base_stat/cleanup.sh          | 20 +++++++
 tools/perf/testsuite/base_stat/settings.sh         | 10 ++++
 tools/perf/testsuite/base_stat/test_basic.sh       | 68 ++++++++++++++++++++++
 tools/perf/testsuite/base_stat/test_hw.sh          | 50 ++++++++++++++++
 tools/perf/testsuite/base_stat/test_hwcache.sh     | 51 ++++++++++++++++
 .../testsuite/base_stat/test_powerpc_hv_24x7.sh    | 60 +++++++++++++++++++
 6 files changed, 259 insertions(+)
 create mode 100755 tools/perf/testsuite/base_stat/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_stat/settings.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_basic.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_hw.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_hwcache.sh
 create mode 100755 tools/perf/testsuite/base_stat/test_powerpc_hv_24x7.sh

diff --git a/tools/perf/testsuite/base_stat/cleanup.sh b/tools/perf/testsuite/base_stat/cleanup.sh
new file mode 100755
index 0000000..d02b8ca
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/cleanup.sh
@@ -0,0 +1,20 @@
+#
+#	cleanup.sh of perf stat test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+. ../common/settings.sh
+. ../common/patterns.sh
+. ../common/init.sh
+. ./settings.sh
+
+find . -name \*.log | xargs rm
+test -d hw && rmdir hw
+test -d hwcache && rmdir hwcache
+test -d hv24x7 && rmdir hv_24x7
+print_overall_results 0
+exit 0
diff --git a/tools/perf/testsuite/base_stat/settings.sh b/tools/perf/testsuite/base_stat/settings.sh
new file mode 100644
index 0000000..a92dd73
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/settings.sh
@@ -0,0 +1,10 @@
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
diff --git a/tools/perf/testsuite/base_stat/test_basic.sh b/tools/perf/testsuite/base_stat/test_basic.sh
new file mode 100755
index 0000000..ba0e979
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/test_basic.sh
@@ -0,0 +1,68 @@
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
+. ../common/settings.sh
+. ../common/patterns.sh
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0`
+TEST_RESULT=0
+
+#### basic execution
+
+# test that perf stat is even working
+$CMD_PERF stat $CMD_SIMPLE 2> 01.log
+PERF_EXIT_CODE=$?
+
+REGEX_HEADER="\s*Performance counter stats for 'true':"
+REGEX_LINES="\s*"$RE_NUMBER"\s+"$RE_EVENT"\s+#\s+"$RE_NUMBER"%?.*"
+../common/check_all_patterns_found.pl "$REGEX_HEADER" "$REGEX_LINES" < 01.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution"
+(( TEST_RESULT += $? ))
+
+
+#### some options
+
+# test some basic options that they change the behaviour
+$CMD_PERF stat -i -a -c -r 3 -o /dev/stdout -- $CMD_BASIC_SLEEP > 02.log
+PERF_EXIT_CODE=$?
+
+REGEX_HEADER="^\s*Performance counter stats for '(sleep [\d\.]+|system wide)' \(3 runs\):"
+REGEX_LINES="\s*"$RE_NUMBER"\s+"$RE_EVENT"\s+#\s+"$RE_NUMBER"%?.*\s*"$RE_NUMBER"%?.*"
+REGEX_FOOTER="^\s*"$RE_NUMBER" seconds time elapsed.*"
+../common/check_all_patterns_found.pl "$REGEX_HEADER" "$REGEX_LINES" "$REGEX_FOOTER" < 02.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "some options"
+(( TEST_RESULT += $? ))
+
+
+#### CSV output
+
+# with -x'<SEPARATOR>' perf stat should produce a CSV output
+$CMD_PERF stat -x';' -o /dev/stdout -a -- sleep 0.1 > 03.log
+PERF_EXIT_CODE=$?
+
+REGEX_LINES="^"$RE_NUMBER";+"$RE_EVENT
+REGEX_UNSUPPORTED_LINES="^<not supported>;+"$RE_EVENT
+../common/check_all_lines_matched.pl "$REGEX_LINES" "$REGEX_UNSUPPORTED_LINES" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < 03.log
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
index 0000000..e651960
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/test_hw.sh
@@ -0,0 +1,50 @@
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
+. ../common/settings.sh
+. ../common/patterns.sh
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0`
+TEST_RESULT=0
+
+EVENTS_TO_TEST=`$CMD_PERF list hw | grep "Hardware event" | awk '{print $1}' | egrep '^.' | tr '\n' ' '`
+if [ -z "$EVENTS_TO_TEST" ]; then
+	print_testcase_skipped
+	exit 0
+fi
+
+# FIXME test -e hw.log && rm -f hw.log
+
+test -d hw || mkdir hw
+
+
+#### testing hardware events
+
+for event in $EVENTS_TO_TEST; do
+	$CMD_PERF stat -a -e $event -o hw/$event.log --append -x';' -- $CMD_BASIC_SLEEP
+	PERF_EXIT_CODE=$?
+	REGEX_LINES="$RE_NUMBER;+$event;$RE_NUMBER;100\.00"
+	../common/check_all_patterns_found.pl "$REGEX_LINES" < hw/$event.log
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
index 0000000..a7dc8dd
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/test_hwcache.sh
@@ -0,0 +1,51 @@
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
+. ../common/settings.sh
+. ../common/patterns.sh
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0`
+TEST_RESULT=0
+
+EVENTS_TO_TEST=`$CMD_PERF list hwcache | grep "Hardware cache event" | awk '{print $1}' | egrep '^.' | tr '\n' ' '`
+if [ -z "$EVENTS_TO_TEST" ]; then
+	print_testcase_skipped
+	exit 0
+fi
+
+test -d hwcache || mkdir hwcache
+
+# FIXME test -e hw.log && rm -f hw.log
+
+
+#### testing hardware events
+
+for event in $EVENTS_TO_TEST; do
+	$CMD_PERF stat -a -e $event -o hwcache/$event.log --append -x';' -- $CMD_BASIC_SLEEP
+	PERF_EXIT_CODE=$?
+	REGEX_LINES="$RE_NUMBER;+$event;$RE_NUMBER;100\.00"
+	../common/check_all_patterns_found.pl "$REGEX_LINES" < hwcache/$event.log
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
diff --git a/tools/perf/testsuite/base_stat/test_powerpc_hv_24x7.sh b/tools/perf/testsuite/base_stat/test_powerpc_hv_24x7.sh
new file mode 100755
index 0000000..0d71532
--- /dev/null
+++ b/tools/perf/testsuite/base_stat/test_powerpc_hv_24x7.sh
@@ -0,0 +1,60 @@
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
+. ../common/settings.sh
+. ../common/patterns.sh
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0`
+TEST_RESULT=0
+
+EVENTS_TO_TEST=`$CMD_PERF list | grep "24x7" | grep "core" | awk '{print $1}' | tr '\n' ' '`
+if [ -z "$EVENTS_TO_TEST" ]; then
+	print_testcase_skipped
+	exit 0
+fi
+
+test -d hv_24x7 || mkdir hv_24x7
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
+		$CMD_PERF stat -a -e $evt -o hv_24x7/$EVENT_NAME.log --append -x';' -- $CMD_QUICK_SLEEP
+		(( PERF_EXIT_CODE += $? ))
+	done
+	REGEX_LINES="$RE_NUMBER;+hv_24x7\/$EVENT_NAME,core=$RE_NUMBER\/;$RE_NUMBER;100\.00"
+	../common/check_all_patterns_found.pl "$REGEX_LINES" < hv_24x7/$EVENT_NAME.log
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
-- 
1.8.3.1
