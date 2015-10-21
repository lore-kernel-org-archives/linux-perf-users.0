From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 1/3] tools/perf/testsuite: Init commit
Date: Thu, 22 Oct 2015 01:08:52 +0200
Message-ID: <1445468932.12960.118.camel@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755259AbbJUXIx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Oct 2015 19:08:53 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id C5FF9C0BEAB4
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2015 23:08:53 +0000 (UTC)
Received: from [10.34.1.123] (dhcp-1-123.brq.redhat.com [10.34.1.123])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9LN8qmN010904
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2015 19:08:53 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


This commit adds a base for a testsuite of perf + its sub-commands.
---
 .../testsuite/common/check_all_lines_matched.pl    |  28 +++++
 .../testsuite/common/check_all_patterns_found.pl   |  30 ++++++
 .../testsuite/common/check_any_pattern_found.pl    |  14 +++
 tools/perf/testsuite/common/init.sh                |  50 +++++++++
 tools/perf/testsuite/common/parametrization.sh     |  18 ++++
 tools/perf/testsuite/common/patterns.sh            |  74 +++++++++++++
 tools/perf/testsuite/common/settings.sh            |  50 +++++++++
 tools/perf/testsuite/test_driver.sh                | 114 +++++++++++++++++++++
 8 files changed, 378 insertions(+)
 create mode 100755 tools/perf/testsuite/common/check_all_lines_matched.pl
 create mode 100755 tools/perf/testsuite/common/check_all_patterns_found.pl
 create mode 100755 tools/perf/testsuite/common/check_any_pattern_found.pl
 create mode 100644 tools/perf/testsuite/common/init.sh
 create mode 100644 tools/perf/testsuite/common/parametrization.sh
 create mode 100644 tools/perf/testsuite/common/patterns.sh
 create mode 100644 tools/perf/testsuite/common/settings.sh
 create mode 100755 tools/perf/testsuite/test_driver.sh

diff --git a/tools/perf/testsuite/common/check_all_lines_matched.pl b/tools/perf/testsuite/common/check_all_lines_matched.pl
new file mode 100755
index 0000000..d127d20
--- /dev/null
+++ b/tools/perf/testsuite/common/check_all_lines_matched.pl
@@ -0,0 +1,28 @@
+#!/usr/bin/perl
+
+@regexps = @ARGV;
+
+$passed = 1;
+
+while (<STDIN>)
+{
+	s/\n//;
+
+	$line_matched = 0;
+	for $r (@regexps)
+	{
+		if (/$r/)
+		{
+			$line_matched = 1;
+			last;
+		}
+	}
+
+	unless ($line_matched)
+	{
+		print "Line did not match any pattern: \"$_\"\n";
+		$passed = 0;
+	}
+}
+
+exit ($passed == 0);
diff --git a/tools/perf/testsuite/common/check_all_patterns_found.pl b/tools/perf/testsuite/common/check_all_patterns_found.pl
new file mode 100755
index 0000000..b828c8d
--- /dev/null
+++ b/tools/perf/testsuite/common/check_all_patterns_found.pl
@@ -0,0 +1,30 @@
+#!/usr/bin/perl
+
+@regexps = @ARGV;
+
+%found = ();
+$passed = 1;
+
+while (<STDIN>)
+{
+	s/\n//;
+
+	for $r (@regexps)
+	{
+		if (/$r/)
+		{
+			$found{$r} = 1;	# FIXME: maybe add counters -- how many times was the regexp matched
+		}
+	}
+}
+
+for $r (@regexps)
+{
+	unless (exists $found{$r})
+	{
+		print "Regexp not found: \"$r\"\n";
+		$passed = 0;
+	}
+}
+
+exit ($passed == 0);
diff --git a/tools/perf/testsuite/common/check_any_pattern_found.pl b/tools/perf/testsuite/common/check_any_pattern_found.pl
new file mode 100755
index 0000000..215c65a0c
--- /dev/null
+++ b/tools/perf/testsuite/common/check_any_pattern_found.pl
@@ -0,0 +1,14 @@
+#!/usr/bin/perl
+
+@regexps = @ARGV;
+
+while (<STDIN>)
+{
+	s/\n//;
+	for $r (@regexps)
+	{
+		exit 0 if (/$r/);
+	}
+}
+
+exit 1;
diff --git a/tools/perf/testsuite/common/init.sh b/tools/perf/testsuite/common/init.sh
new file mode 100644
index 0000000..ba2038d
--- /dev/null
+++ b/tools/perf/testsuite/common/init.sh
@@ -0,0 +1,50 @@
+#
+#	init.sh
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This file should be used for initialization of basic functions
+#	for checking, reporting results etc.
+#
+#
+
+THIS_TEST_NAME=`basename $0`
+
+print_results()
+{
+	PERF_RETVAL="$1"; shift
+	CHECK_RETVAL="$1"; shift
+	FAILURE_REASON=""
+	TASK_COMMENT="$@"
+	if [ $PERF_RETVAL -eq 0 -a $CHECK_RETVAL -eq 0 ]; then
+		echo -e "$MPASS-- [ PASS ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $TASK_COMMENT"
+		return 0
+	else
+		if [ $PERF_RETVAL -ne 0 ]; then
+			FAILURE_REASON="command exitcode"
+		fi
+		if [ $CHECK_RETVAL -ne 0 ]; then
+			test -n "$FAILURE_REASON" && FAILURE_REASON="$FAILURE_REASON + "
+			FAILURE_REASON="$FAILURE_REASON""output regexp parsing"
+		fi
+		echo -e "$MFAIL-- [ FAIL ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $TASK_COMMENT ($FAILURE_REASON)"
+		return 1
+	fi
+}
+
+print_overall_results()
+{
+	RETVAL="$1"; shift
+	if [ $RETVAL -eq 0 ]; then
+		echo -e "$MALLPASS## [ PASS ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME"
+	else
+		echo -e "$MALLFAIL## [ FAIL ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME :: $RETVAL failures found"
+	fi
+	return $RETVAL
+}
+
+print_testcase_skipped()
+{
+	echo -e "$MSKIP## [ SKIP ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME :: testcase skipped"
+}
diff --git a/tools/perf/testsuite/common/parametrization.sh b/tools/perf/testsuite/common/parametrization.sh
new file mode 100644
index 0000000..9375999
--- /dev/null
+++ b/tools/perf/testsuite/common/parametrization.sh
@@ -0,0 +1,18 @@
+#
+#	parametrization.sh
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This file configures the testcases how deeply they should
+#	look at things. The parametrization allows you to use the suite
+#	for both smoke testing and deeper testing.
+#
+
+#### perf_stat
+
+# If set, the 24x7 events will be tested on all available cores.
+# That might make it 'nproc' times longer. Basically it should be
+# enough to run each event on one core only.
+# Note: POWER8 only
+export PARAM_STAT_24x7_ALL_CORES=n
diff --git a/tools/perf/testsuite/common/patterns.sh b/tools/perf/testsuite/common/patterns.sh
new file mode 100644
index 0000000..08462f0
--- /dev/null
+++ b/tools/perf/testsuite/common/patterns.sh
@@ -0,0 +1,74 @@
+export RE_NUMBER="[0-9\.]+"
+# Number
+# Examples:
+#    123.456
+
+
+export RE_NUMBER_HEX="[0-9A-Fa-f]+"
+# Hexadecimal number
+# Examples:
+#    1234
+#    a58d
+#    aBcD
+#    deadbeef
+
+
+export RE_EVENT_ANY="[\w\-\:\/_=,]+"
+# Name of any event (universal)
+# Examples:
+#    cpu-cycles
+#    cpu/event=12,umask=34/
+#    r41e1
+#    nfs:nfs_getattr_enter
+
+
+export RE_EVENT="[\w\-:_]+"
+# Name of an usual event
+# Examples:
+#    cpu-cycles
+
+
+export RE_EVENT_RAW="r$RE_NUMBER_HEX"
+# Specification of a raw event
+# Examples:
+#    r41e1
+#    r1a
+
+
+export RE_EVENT_CPU="cpu/(\w=""$RE_NUMBER_HEX"",?)+/p*" # FIXME
+# Specification of a CPU event
+# Examples:
+#    cpu/event=12,umask=34/pp
+
+
+export RE_EVENT_UNCORE="uncore/[\w_]+/"
+# Specification of an uncore event
+# Examples:
+#    uncore/qhl_request_local_reads/
+
+
+export RE_EVENT_SUBSYSTEM="[\w\-]+:[\w\-]+"
+# Name of an event from subsystem
+# Examples:
+#    ext4:ext4_ordered_write_end
+#    sched:sched_switch
+
+export RE_LINE_COMMENT="^#.*"
+# A comment line
+# Examples:
+#    # Started on Thu Sep 10 11:43:00 2015
+
+export RE_LINE_EMPTY="^\s*$"
+# An empty line with possible whitespaces
+# Examples:
+#
+
+export RE_LINE_RECORD1="^\[\s+perf\s+record:\s+Woken up $RE_NUMBER times? to write data\s+\].*$"
+# The first line of perf-record "OK" output
+# Examples:
+#    [ perf record: Woken up 1 times to write data ]
+
+export RE_LINE_RECORD2="^\[\s+perf\s+record:\s+Captured and wrote $RE_NUMBER\s*MB\s+perf.data\s*\(~?$RE_NUMBER samples\)\s+\].*$"
+# The second line of perf-record "OK" output
+# Examples:
+#    [ perf record: Captured and wrote 0.405 MB perf.data (109 samples) ]
diff --git a/tools/perf/testsuite/common/settings.sh b/tools/perf/testsuite/common/settings.sh
new file mode 100644
index 0000000..bd7b2fb
--- /dev/null
+++ b/tools/perf/testsuite/common/settings.sh
@@ -0,0 +1,50 @@
+#
+#	settings.sh
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This file contains global settings for the whole testsuite.
+#	Its purpose is to make it easier when it is necessary i.e. to
+#	change the usual sample command which is used in all of the tests
+#	in many files.
+#
+#		This file is intended to be sourced in the tests.
+#
+
+#### which perf to use in the testing
+export CMD_PERF=`which perf`
+
+#### basic programs examinated by perf
+export CMD_BASIC_SLEEP="sleep 0.1"
+export CMD_QUICK_SLEEP="sleep 0.01"
+export CMD_LONGER_SLEEP="sleep 2"
+export CMD_SIMPLE="true"
+
+#### colors
+if [ -t 1 ]; then
+	export MPASS="\e[32m"
+	export MALLPASS="\e[1;32m"
+	export MFAIL="\e[31m"
+	export MALLFAIL="\e[1;31m"
+	export MWARN="\e[1;35m"
+	export MSKIP="\e[33m"
+	export MHIGH="\e[1;33m"
+	export MEND="\e[m"
+else
+	export MPASS=""
+	export MALLPASS=""
+	export MFAIL=""
+	export MALLFAIL=""
+	export MWARN=""
+	export MSKIP=""
+	export MHIGH=""
+	export MEND=""
+fi
+
+
+#### test parametrization
+if [ ! -d ./common ]; then
+	# FIXME nasty hack
+	. ../common/parametrization.sh
+fi
diff --git a/tools/perf/testsuite/test_driver.sh b/tools/perf/testsuite/test_driver.sh
new file mode 100755
index 0000000..1c36002
--- /dev/null
+++ b/tools/perf/testsuite/test_driver.sh
@@ -0,0 +1,114 @@
+#
+#	test_driver.sh
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		The test_driver runs all the tests.
+#
+#
+
+. common/settings.sh
+
+# FIXME :: add arguments for logging, test depth, etc
+export PERFTEST_LOGGING=${PERFTEST_LOGGING:-n}
+export VERBOSE=n
+
+#### specifies the sets of test per architecture
+declare -A TESTING_SET
+
+TESTING_SET['aarch64']="stat"
+TESTING_SET['ppc64']="stat"
+TESTING_SET['ppc64le']="stat"
+TESTING_SET['s390x']="stat"
+TESTING_SET['x86_64']="stat"
+TESTING_SET['i686']="stat"
+
+
+#### show something about the environment
+export ARCH=`arch`
+export KERNEL=`uname -r`
+export NPROC=`nproc`
+echo "======================================================"
+echo "Kernel: $KERNEL"
+echo "Architecture: $ARCH"
+if [ "$VERBOSE" = "y" ]; then
+	echo "CPU Info:"
+	head -n 25 /proc/cpuinfo | while read line; do echo -e "\t$line"; done; unset line
+	echo "AT_PLATFORM:"
+	LD_SHOW_AUXV=1 /bin/true | grep PLATFORM | while read line; do echo -e "\t$line"; done; unset line
+else
+	echo "CPU Info:"
+	FAMILY=`grep family /proc/cpuinfo | head -n 1 | awk -F':' '{print $2}'`
+	MODEL=`grep model /proc/cpuinfo | head -n 1 | awk -F':' '{print $2}'`
+	STEPPING=`grep stepping /proc/cpuinfo | head -n 1 | awk -F':' '{print $2}'`
+	VENDOR_ID=`grep vendor_id /proc/cpuinfo | head -n 1 | awk -F':' '{print $2}'`
+	echo -e "\t$VENDOR_ID\tFamily:$FAMILY Model:$MODEL Stepping:$STEPPING"
+fi
+if [[ $ARCH =~ ppc64.* ]]; then
+	export VIRTUALIZATION=`systemd-detect-virt -q && echo PowerKVM || ( test -e /proc/ppc64/lparcfg && echo PowerVM || echo none )`
+else
+	VIRTUALIZATION=`systemd-detect-virt`
+	export VIRTUALIZATION=${VIRTUALIZATION:-none}
+fi
+echo "Virtualization: $VIRTUALIZATION"
+echo "PERF: $CMD_PERF"
+echo "======================================================"; echo; echo
+
+#### init
+SUBTESTS_TO_RUN="${TESTING_SET[$ARCH]}"
+if [ "$PERFTEST_LOGGING" = "y" ]; then
+	test -d LOGS && rm -rf LOGS
+	mkdir LOGS
+	export LOGS_DIR=`pwd`/LOGS
+
+	# print header
+	echo "============= Running tests ============="
+fi
+
+FAILED_COUNT=0
+PASSED_COUNT=0
+
+#### run the tests
+for subtest in $SUBTESTS_TO_RUN; do
+	SUBTEST_RESULT=0
+	cd base_$subtest
+	if [ "$PERFTEST_LOGGING" = "y" ]; then
+		mkdir $LOGS_DIR/$subtest
+		export LOGGING="> $LOGS_DIR/$subtest/"
+	else
+		# print header
+		echo "========================= $subtest ========================="
+	fi
+
+
+	# setup, if necessary
+	test -e setup.sh && eval ./setup.sh $LOGGING/setup.log || true
+	(( SUBTEST_RESULT += $?))
+
+	# run all the available testcases
+	for testcase in test_*sh; do
+		eval ./$testcase $LOGGING/`basename $testcase .sh`.log
+		(( SUBTEST_RESULT += $?))
+	done
+
+	# cleanup, if necessary
+	test -e cleanup.sh && eval ./cleanup.sh $LOGGING/cleanup.log || true
+	(( SUBTEST_RESULT += $?))
+
+	cd ..
+
+	# print result
+	if [ "$PERFTEST_LOGGING" = "y" ]; then
+		if [ $SUBTEST_RESULT -eq 0 ]; then
+			echo -e "$MALLPASS## [ PASS ] ##$MEND $subtest"
+			(( PASSED_COUNT += 1 ))
+		else
+			echo -e "$MALLFAIL## [ FAIL ] ##$MEND $subtest"
+			(( FAILED_COUNT += 1 ))
+		fi
+	else
+		echo; echo
+	fi
+done
+
+exit $FAILED_COUNT
-- 
1.8.3.1
