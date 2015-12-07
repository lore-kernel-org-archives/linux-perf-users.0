From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 6/9] perf test: new testsuite: perf probe tests
Date: Mon, 07 Dec 2015 19:53:28 +0100
Message-ID: <1449514408.24573.256.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35904 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbbLGSxa (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Dec 2015 13:53:30 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id E0D7FC0B0201
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Dec 2015 18:53:30 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

This commit adds tests for perf probe tool. Some of the tests are based
on Masami Hiramatsu's perf-probe tests.

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/testsuite/base_probe/cleanup.sh         |  22 ++
 tools/perf/testsuite/base_probe/examples/Makefile  |  13 ++
 .../perf/testsuite/base_probe/examples/advanced.c  |  40 ++++
 .../testsuite/base_probe/examples/exact_counts.c   |  35 ++++
 tools/perf/testsuite/base_probe/examples/test.c    |  35 ++++
 tools/perf/testsuite/base_probe/settings.sh        |  42 ++++
 tools/perf/testsuite/base_probe/setup.sh           |  23 +++
 .../base_probe/test_adding_blacklisted.sh          |  63 ++++++
 .../testsuite/base_probe/test_adding_kernel.sh     | 229 +++++++++++++++++++++
 tools/perf/testsuite/base_probe/test_advanced.sh   | 124 +++++++++++
 tools/perf/testsuite/base_probe/test_basic.sh      |  79 +++++++
 .../perf/testsuite/base_probe/test_exact_counts.sh | 106 ++++++++++
 .../testsuite/base_probe/test_invalid_options.sh   |  80 +++++++
 .../testsuite/base_probe/test_line_semantics.sh    |  56 +++++
 tools/perf/testsuite/base_probe/test_listing.sh    | 154 ++++++++++++++
 .../perf/testsuite/base_probe/test_probe_syntax.sh | 119 +++++++++++
 16 files changed, 1220 insertions(+)
 create mode 100755 tools/perf/testsuite/base_probe/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_probe/examples/Makefile
 create mode 100644 tools/perf/testsuite/base_probe/examples/advanced.c
 create mode 100644 tools/perf/testsuite/base_probe/examples/exact_counts.c
 create mode 100644 tools/perf/testsuite/base_probe/examples/test.c
 create mode 100644 tools/perf/testsuite/base_probe/settings.sh
 create mode 100755 tools/perf/testsuite/base_probe/setup.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_adding_blacklisted.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_adding_kernel.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_advanced.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_basic.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_exact_counts.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_invalid_options.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_line_semantics.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_listing.sh
 create mode 100755 tools/perf/testsuite/base_probe/test_probe_syntax.sh

diff --git a/tools/perf/testsuite/base_probe/cleanup.sh b/tools/perf/testsuite/base_probe/cleanup.sh
new file mode 100755
index 0000000..7a7eec4
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/cleanup.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+#
+#	cleanup.sh of perf probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+
+clear_all_probes
+find . -name \*.log | xargs -r rm
+find . -name \*.err | xargs -r rm
+make -s -C examples clean
+
+print_results 0 0 "clean-up - removing all probes and deleting logs"
+exit $?
diff --git a/tools/perf/testsuite/base_probe/examples/Makefile b/tools/perf/testsuite/base_probe/examples/Makefile
new file mode 100644
index 0000000..0ae9638
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/examples/Makefile
@@ -0,0 +1,13 @@
+CC=gcc
+CFLAGS=-g -O0
+
+SRCS = $(wildcard *.c)
+PROGS = $(patsubst %.c,%,$(SRCS))
+
+all: $(PROGS)
+
+%: %.c
+	$(CC) $(CFLAGS) -o $@ $<
+
+clean:
+	rm -f $(PROGS)
diff --git a/tools/perf/testsuite/base_probe/examples/advanced.c b/tools/perf/testsuite/base_probe/examples/advanced.c
new file mode 100644
index 0000000..1851e4b
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/examples/advanced.c
@@ -0,0 +1,40 @@
+#include <stdlib.h>
+#include <stdio.h>
+
+static int counter = 0;
+
+int incr(void)
+{
+	int a;
+	a = counter++ * 2;
+	return a;
+}
+
+int isprime(int a)
+{
+	int i;
+	if(a <= 1)
+		return 0;
+	for(i = 2; i <= a / 2; i++)
+		if(!(a % i))
+			return 0;
+	return 1;
+}
+
+int main(int argc, char **argv)
+{
+	int numbers[] = { 2, 3, 4, 5, 6, 7, 13, 17, 19 };
+	int i;
+
+	for(i = 0; i < 9; i++)
+	{
+		printf("%i %s prime\n", numbers[i], (isprime(numbers[i]))? "is" : "is not");
+	}
+
+	for(i = 0; i < 9; i++)
+	{
+		printf("Now the state is %i.\n", incr());
+	}
+
+	return 0;
+}
diff --git a/tools/perf/testsuite/base_probe/examples/exact_counts.c b/tools/perf/testsuite/base_probe/examples/exact_counts.c
new file mode 100644
index 0000000..f5cb8fa
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/examples/exact_counts.c
@@ -0,0 +1,35 @@
+#include <stdio.h>
+#include <stdlib.h>
+
+
+int f_1x(void) { return 1; }
+int f_2x(void) { return 2; }
+int f_3x(void) { return 3; }
+int f_103x(void) { return 103; }
+int f_997x(void) { return 997; }
+int f_65535x(void) {return 65535; }
+
+int main(int argc, char **argv)
+{
+	int i, a;
+
+	for(i = 0; i < 1; i++)
+		a = f_1x();
+
+	for(i = 0; i < 2; i++)
+		a = f_2x();
+
+	for(i = 0; i < 3; i++)
+		a = f_3x();
+
+	for(i = 0; i < 103; i++)
+		a = f_103x();
+
+	for(i = 0; i < 997; i++)
+		a = f_997x();
+
+	for(i = 0; i < 65535; i++)
+		a = f_65535x();
+
+	return 0;
+}
diff --git a/tools/perf/testsuite/base_probe/examples/test.c b/tools/perf/testsuite/base_probe/examples/test.c
new file mode 100644
index 0000000..5972f8e
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/examples/test.c
@@ -0,0 +1,35 @@
+#include <stdio.h>
+#include <stdlib.h>
+
+int some_function_with_a_really_long_name_that_must_be_longer_than_64_bytes(int some_argument_with_a_really_long_name_that_must_be_longer_than_64_bytes)
+{
+	int some_variable_with_a_really_long_name_that_must_be_longer_than_64_bytes = 0;
+	int i;
+
+	for(i = 0; i <= some_argument_with_a_really_long_name_that_must_be_longer_than_64_bytes; i++)
+	{
+		some_variable_with_a_really_long_name_that_must_be_longer_than_64_bytes += i;
+	}
+
+	return some_variable_with_a_really_long_name_that_must_be_longer_than_64_bytes;
+}
+
+int some_normal_function(int a)
+{
+	return a * a * a;
+}
+
+int main(int argc, char **argv)
+{
+	int x = 20, y, z;
+
+	if(argc > 1)
+		x = atoi(argv[1]);
+
+	y = some_function_with_a_really_long_name_that_must_be_longer_than_64_bytes(x);
+	z = some_normal_function(x);
+
+	printf("f1(%i) = %i\nf2(%i) = %i\n", x, y, x, z);
+
+	return 0;
+}
diff --git a/tools/perf/testsuite/base_probe/settings.sh b/tools/perf/testsuite/base_probe/settings.sh
new file mode 100644
index 0000000..0b06bcb
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/settings.sh
@@ -0,0 +1,42 @@
+#
+#	settings.sh of perf_report test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+export TEST_NAME="perf_probe"
+
+export MY_ARCH=`arch`
+
+check_kprobes_available()
+{
+	grep -q kprobe_register /proc/kallsyms
+}
+
+check_uprobes_available()
+{
+	grep -q uprobe_register /proc/kallsyms
+}
+
+clear_all_probes()
+{
+	echo 0 > /sys/kernel/debug/tracing/events/enable
+	check_kprobes_available && echo > /sys/kernel/debug/tracing/kprobe_events
+	check_uprobes_available && echo > /sys/kernel/debug/tracing/uprobe_events
+}
+
+# FIXME
+check_perf_probe_option()
+{ #option
+	$PERF probe -h 2>&1 | egrep '[\t ]+'$1'[\t ]+' > /dev/null
+}
+
+#FIXME
+check_kernel_debuginfo()
+{
+	eu-addr2line -k 0x`grep -m 1 vfs_read /proc/kallsyms | cut -f 1 -d" "` | grep vfs_read
+}
diff --git a/tools/perf/testsuite/base_probe/setup.sh b/tools/perf/testsuite/base_probe/setup.sh
new file mode 100755
index 0000000..8f32bc2
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/setup.sh
@@ -0,0 +1,23 @@
+#!/bin/bash
+
+#
+#	setup.sh of perf probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		We need to clean-up all the previously added probes
+#		FIXME
+#
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+
+make -s -C examples
+
+print_results $? 0 "building examples"
+exit $?
diff --git a/tools/perf/testsuite/base_probe/test_adding_blacklisted.sh b/tools/perf/testsuite/base_probe/test_adding_blacklisted.sh
new file mode 100755
index 0000000..785cf7b
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/test_adding_blacklisted.sh
@@ -0,0 +1,63 @@
+#!/bin/bash
+
+#
+#	test_adding_blacklisted of perf_probe test
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		Blacklisted functions should not be added successfully as probes,
+#	they must be skipped.
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+TEST_RESULT=0
+
+# skip if not supported
+BLACKFUNC=`head -n 1 /sys/kernel/debug/kprobes/blacklist 2> /dev/null | cut -f2`
+if [ -z "$BLACKFUNC" ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+# remove all previously added probes
+clear_all_probes
+
+
+### adding blacklisted function
+
+# functions from blacklist should be skipped by perf probe
+! $CMD_PERF probe $BLACKFUNC > adding_blacklisted.log 2> adding_blacklisted.err
+PERF_EXIT_CODE=$?
+
+REGEX_SKIP_MESSAGE=" is blacklisted function, skip it\."
+REGEX_NOT_FOUND_MESSAGE="Probe point \'$BLACKFUNC\' not found."
+REGEX_ERROR_MESSAGE="Error: Failed to add events."
+../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" < adding_blacklisted.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
+(( TEST_RESULT += $? ))
+
+
+### listing not-added probe
+
+# blacklisted probes should NOT appear in perf-list output
+$CMD_PERF list probe:\* > adding_blacklisted_list.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defined events" < adding_blacklisted_list.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing blacklisted probe (should NOT be listed)"
+(( TEST_RESULT += $? ))
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_probe/test_adding_kernel.sh b/tools/perf/testsuite/base_probe/test_adding_kernel.sh
new file mode 100755
index 0000000..c03a335
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/test_adding_kernel.sh
@@ -0,0 +1,229 @@
+#!/bin/bash
+
+#
+#	test_adding_kernel of perf_probe test
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests adding of probes, their correct listing
+#		and removing.
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+TEST_RESULT=0
+
+TEST_PROBE="vfs_read"
+
+check_kprobes_available
+if [ $? -ne 0 ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+
+### basic probe adding
+
+for opt in "" "-a" "--add"; do
+	clear_all_probes
+	$CMD_PERF probe $opt $TEST_PROBE 2> adding_kernel_add$opt.err
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "Added new event:" "probe:$TEST_PROBE" "on $TEST_PROBE" < adding_kernel_add$opt.err
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding probe $TEST_PROBE :: $opt"
+	(( TEST_RESULT += $? ))
+done
+
+
+### listing added probe :: perf list
+
+# any added probes should appear in perf-list output
+$CMD_PERF list probe:\* > adding_kernel_list.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defined events" "probe:$TEST_PROBE\s+\[Tracepoint event\]" < adding_kernel_list.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probe :: perf list"
+(( TEST_RESULT += $? ))
+
+
+### listing added probe :: perf probe -l
+
+# '-l' should list all the added probes as well
+$CMD_PERF probe -l > adding_kernel_list-l.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "\s*probe:$TEST_PROBE\s+\(on $TEST_PROBE@.+\)" < adding_kernel_list-l.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probe :: perf probe -l"
+(( TEST_RESULT += $? ))
+
+
+### using added probe
+
+$CMD_PERF stat -e probe:$TEST_PROBE -o adding_kernel_using_probe.log -- cat /proc/uptime > /dev/null
+PERF_EXIT_CODE=$?
+
+REGEX_STAT_HEADER="\s*Performance counter stats for \'cat /proc/uptime\':"
+# the value should be greater than 1
+REGEX_STAT_VALUES="\s*[1-9][0-9]*\s+probe:$TEST_PROBE"
+REGEX_STAT_TIME="\s*$RE_NUMBER\s+seconds time elapsed"
+../common/check_all_lines_matched.pl "$REGEX_STAT_HEADER" "$REGEX_STAT_VALUES" "$REGEX_STAT_TIME" "$RE_LINE_COMMENT" "$RE_LINE_EMPTY" < adding_kernel_using_probe.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using added probe"
+(( TEST_RESULT += $? ))
+
+
+### removing added probe
+
+# '-d' should remove the probe
+$CMD_PERF probe -d $TEST_PROBE 2> adding_kernel_removing.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE" < adding_kernel_removing.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "deleting added probe"
+(( TEST_RESULT += $? ))
+
+
+### listing removed probe
+
+# removed probes should NOT appear in perf-list output
+$CMD_PERF list probe:\* > adding_kernel_list_removed.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defined events" < adding_kernel_list_removed.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing removed probe (should NOT be listed)"
+(( TEST_RESULT += $? ))
+
+
+### dry run
+
+# the '-n' switch should run it in dry mode
+$CMD_PERF probe -n --add $TEST_PROBE 2> adding_kernel_dryrun.err
+PERF_EXIT_CODE=$?
+
+# check for the output (should be the same as usual)
+../common/check_all_patterns_found.pl "Added new event:" "probe:$TEST_PROBE" "on $TEST_PROBE" < adding_kernel_dryrun.err
+CHECK_EXIT_CODE=$?
+
+# check that no probe was added in real
+! ( $CMD_PERF probe -l | grep "probe:$TEST_PROBE" )
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "dry run :: adding probe"
+(( TEST_RESULT += $? ))
+
+
+### force-adding probes
+
+# when using '--force' a probe should be added even if it is already there
+$CMD_PERF probe --add $TEST_PROBE 2> adding_kernel_forceadd_01.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "Added new event:" "probe:$TEST_PROBE" "on $TEST_PROBE" < adding_kernel_forceadd_01.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: first probe adding"
+(( TEST_RESULT += $? ))
+
+# adding existing probe without '--force' should fail
+! $CMD_PERF probe --add $TEST_PROBE 2> adding_kernel_forceadd_02.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "Error: event \"$TEST_PROBE\" already exists." "Error: Failed to add events." < adding_kernel_forceadd_02.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: second probe adding (without force)"
+(( TEST_RESULT += $? ))
+
+# adding existing probe with '--force' should pass
+$CMD_PERF probe --force --add $TEST_PROBE 2> adding_kernel_forceadd_03.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "Added new event:" "probe:${TEST_PROBE}_1" "on $TEST_PROBE" < adding_kernel_forceadd_03.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: second probe adding (with force)"
+(( TEST_RESULT += $? ))
+
+
+### using doubled probe
+
+# since they are the same, they should produce the same results
+$CMD_PERF stat -e probe:$TEST_PROBE -e probe:${TEST_PROBE}_1 -x';' -o adding_kernel_using_two.log -- bash -c 'cat /proc/cpuinfo > /dev/null'
+PERF_EXIT_CODE=$?
+
+REGEX_LINE="$RE_NUMBER;+probe:${TEST_PROBE}_?1?;$RE_NUMBER;$RE_NUMBER"
+../common/check_all_lines_matched.pl "$REGEX_LINE" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < adding_kernel_using_two.log
+CHECK_EXIT_CODE=$?
+
+VALUE_1=`grep "$TEST_PROBE;" adding_kernel_using_two.log | awk -F';' '{print $1}'`
+VALUE_2=`grep "${TEST_PROBE}_1;" adding_kernel_using_two.log | awk -F';' '{print $1}'`
+
+test $VALUE_1 -eq $VALUE_2
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using doubled probe"
+
+
+### removing multiple probes
+
+# using wildcards should remove all matching probes
+$CMD_PERF probe --del \* 2> adding_kernel_removing_wildcard.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < adding_kernel_removing_wildcard.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple probes"
+(( TEST_RESULT += $? ))
+
+
+### wildcard adding support
+
+$CMD_PERF probe -nf -a 'vfs_* $params' 2> adding_kernel_adding_wildcard.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "probe:vfs_mknod" "probe:vfs_create" "probe:vfs_rmdir" "probe:vfs_link" "probe:vfs_write" < adding_kernel_adding_wildcard.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "wildcard adding support"
+(( TEST_RESULT += $? ))
+
+
+### out-of-text functions
+
+# out-of-text functions should be skipped
+INITTEXT=init_setup
+grep -q " $INITTEXT" /proc/kallsyms
+if [ $? -eq 0 -a "$MY_ARCH" = "x86_64" ]; then
+	! $CMD_PERF probe $INITTEXT 2> adding_kernel_outoftext.err
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "init_setup is out of \.text, skip it" < adding_kernel_outoftext.err
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "out-of-text functions"
+	(( TEST_RESULT += $? ))
+else
+	print_testcase_skipped "out-of-text functions"
+fi
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_probe/test_advanced.sh b/tools/perf/testsuite/base_probe/test_advanced.sh
new file mode 100755
index 0000000..086667d
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/test_advanced.sh
@@ -0,0 +1,124 @@
+#!/bin/bash
+
+#
+#	test_advanced.sh of perf_probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This testcase tries some more advanced probes, capturing
+#	values of variables, registers etc. The perf-script tool is
+#	used for processing the results.
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
+check_uprobes_available
+if [ $? -ne 0 ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+# clean up before we start
+clear_all_probes
+find . -name perf.data\* | xargs -r rm
+
+
+### function argument probing :: add
+
+# we want to trace values of the variable (argument) 'a' along with the function calls
+$CMD_PERF probe -x examples/advanced --add 'isprime a' > advanced_funcargs_add.log 2>&1
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "probe_advanced:isprime" < advanced_funcargs_add.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function argument probing :: add"
+(( TEST_RESULT += $? ))
+
+
+### function argument probing :: use
+
+# perf record should catch samples including the argument's value
+$CMD_PERF record -e 'probe_advanced:isprime' examples/advanced > /dev/null 2> advanced_funcargs_record.log
+PERF_EXIT_CODE=$?
+
+# perf record should catch exactly 9 samples
+../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" "9 samples" < advanced_funcargs_record.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function argument probing :: record"
+(( TEST_RESULT += $? ))
+
+# perf script should report the function calls with the correct arg values
+$CMD_PERF script > advanced_funcargs_script.log
+PERF_EXIT_CODE=$?
+
+# checking for the perf script output sanity
+REGEX_SCRIPT_LINE="\s*advanced\s+$RE_NUMBER\s+\[$RE_NUMBER\]\s+$RE_NUMBER:\s+probe_advanced:isprime:\s+\($RE_NUMBER\) a=$RE_NUMBER"
+../common/check_all_lines_matched.pl "$REGEX_SCRIPT_LINE" < advanced_funcargs_script.log
+CHECK_EXIT_CODE=$?
+
+# checking whether the values are really correct
+../common/check_exact_pattern_order.pl "a=2" "a=3" "a=4" "a=5" "a=6" "a=7" "a=13" "a=17" "a=19" < advanced_funcargs_script.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function argument probing :: script"
+(( TEST_RESULT += $? ))
+
+
+### function retval probing :: add
+
+# we want to trace return values of the function along with the function calls
+$CMD_PERF probe -x examples/advanced --add 'incr%return $retval' > advanced_funcretval_add.log 2>&1
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "probe_advanced:incr" < advanced_funcretval_add.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function retval probing :: add"
+(( TEST_RESULT += $? ))
+
+
+### function retval probing :: use
+
+# perf record should catch samples including the function return value
+$CMD_PERF record -e 'probe_advanced:incr' examples/advanced > /dev/null 2> advanced_funcretval_record.log
+PERF_EXIT_CODE=$?
+
+# perf record should catch exactly 9 samples
+../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" "9 samples" < advanced_funcretval_record.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function retval probing :: record"
+(( TEST_RESULT += $? ))
+
+# perf script should report the function calls with the correct return values
+$CMD_PERF script > advanced_funcretval_script.log
+PERF_EXIT_CODE=$?
+
+# checking for the perf script output sanity
+REGEX_SCRIPT_LINE="\s*advanced\s+$RE_NUMBER\s+\[$RE_NUMBER\]\s+$RE_NUMBER:\s+probe_advanced:incr:\s+\($RE_NUMBER_HEX\s+<\-\s+$RE_NUMBER_HEX\) arg1=0x$RE_NUMBER_HEX"
+../common/check_all_lines_matched.pl "$REGEX_SCRIPT_LINE" < advanced_funcretval_script.log
+CHECK_EXIT_CODE=$?
+
+# checking whether the values are really correct
+../common/check_exact_pattern_order.pl "arg1=0x0" "arg1=0x2" "arg1=0x4" "arg1=0x6" "arg1=0x8" "arg1=0xa" "arg1=0xc" "arg1=0xe" "arg1=0x10" < advanced_funcretval_script.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function retval probing :: script"
+(( TEST_RESULT += $? ))
+
+
+clear_all_probes
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_probe/test_basic.sh b/tools/perf/testsuite/base_probe/test_basic.sh
new file mode 100755
index 0000000..138db58
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/test_basic.sh
@@ -0,0 +1,79 @@
+#!/bin/bash
+
+#
+#	test_basic of perf_probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#
+#	Description:
+#
+#		This test tests basic functionality of perf probe command.
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+TEST_RESULT=0
+
+check_kprobes_available
+if [ $? -ne 0 ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+
+### help message
+
+if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
+	# test that a help message is shown and looks reasonable
+	$CMD_PERF probe --help > basic_helpmsg.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-PROBE" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "PROBE\s+SYNTAX" "PROBE\s+ARGUMENT" "LINE\s+SYNTAX" < basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "LAZY\s+MATCHING" "FILTER\s+PATTERN" "EXAMPLES" "SEE\s+ALSO" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "vmlinux" "module=" "source=" "verbose" "quiet" "add=" "del=" "list.*EVENT" "line=" "vars=" "externs" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "no-inlines" "funcs.*FILTER" "filter=FILTER" "force" "dry-run" "max-probes" "exec=" "demangle-kernel" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "help message"
+	(( TEST_RESULT += $? ))
+else
+	print_testcase_skipped "help message"
+fi
+
+
+### usage message
+
+# without any args perf-probe should print usage
+$CMD_PERF probe 2> basic_usage.log > /dev/null
+
+../common/check_all_patterns_found.pl "[Uu]sage" "perf probe" "verbose" "quiet" "add" "del" "force" "line" "vars" "externs" "range" < basic_usage.log
+CHECK_EXIT_CODE=$?
+
+print_results 0 $CHECK_EXIT_CODE "usage message"
+(( TEST_RESULT += $? ))
+
+
+### quiet switch
+
+# '--quiet' should mute all output
+$CMD_PERF probe --quiet --add vfs_read > basic_quiet01.log 2> basic_quiet01.err
+PERF_EXIT_CODE=$?
+$CMD_PERF probe --quiet --del vfs_read > basic_quiet03.log 2> basic_quiet02.err
+(( PERF_EXIT_CODE += $? ))
+
+test `cat basic_quiet*log basic_quiet*err | wc -l` -eq 0
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "quiet switch"
+(( TEST_RESULT += $? ))
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_probe/test_exact_counts.sh b/tools/perf/testsuite/base_probe/test_exact_counts.sh
new file mode 100755
index 0000000..196a110
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/test_exact_counts.sh
@@ -0,0 +1,106 @@
+#!/bin/bash
+
+#
+#	test_exact_counts of perf_probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This testcase checks, whether the perf-stat catches all
+#	the probes with exactly known counts of function calls.
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
+check_uprobes_available
+if [ $? -ne 0 ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+# clean up before we start
+clear_all_probes
+find . -name perf.data\* | xargs -r rm
+
+
+### adding userspace probes
+
+PERF_EXIT_CODE=0
+test -e exact_counts_add.log && rm -f exact_counts_add.log
+for i in 1 2 3 103 997 65535; do
+	$CMD_PERF probe -x examples/exact_counts --add f_${i}x >> exact_counts_add.log 2>&1
+	(( PERF_EXIT_CODE += $? ))
+done
+
+../common/check_all_patterns_found.pl "probe_exact:f_1x" "probe_exact:f_2x" "probe_exact:f_3x" "probe_exact:f_103x" \
+		"probe_exact:f_997x" "probe_exact:f_65535x" < exact_counts_add.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding userspace probes"
+(( TEST_RESULT += $? ))
+
+
+### listing added probes
+
+$CMD_PERF probe -l > exact_counts_list.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "probe_exact:f_1x" "probe_exact:f_2x" "probe_exact:f_3x" "probe_exact:f_103x" \
+		"probe_exact:f_997x" "probe_exact:f_65535x" < exact_counts_list.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probes"
+(( TEST_RESULT += $? ))
+
+
+### using probes :: perf stat
+
+# perf stat should catch all the events and give exact results
+$CMD_PERF stat -x';' -e 'probe_exact:*' examples/exact_counts 2> exact_counts_stat.log
+PERF_EXIT_CODE=$?
+
+# check for exact values in perf stat results
+../common/check_all_lines_matched.pl "(\d+);+probe_exact:f_\1x" < exact_counts_stat.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using probes :: perf stat"
+(( TEST_RESULT += $? ))
+
+
+### using probes :: perf record
+
+# perf record should catch all the samples as well
+$CMD_PERF record -e 'probe_exact:*' examples/exact_counts 2> exact_counts_record.log
+PERF_EXIT_CODE=$?
+
+# perf record should catch exactly 66641 samples
+../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" "66641 samples" < exact_counts_record.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using probes :: perf record"
+(( TEST_RESULT += $? ))
+
+# perf report should report exact values too
+$CMD_PERF report --stdio -n > exact_counts_report.log
+PERF_EXIT_CODE=$?
+
+# perf report should report exact sample counts
+../common/check_all_lines_matched.pl "\s*100.00%\s+(\d+)\s+exact_counts\s+exact_counts\s+\[\.\]\s+f_\1x" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < exact_counts_report.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using probes :: perf report"
+(( TEST_RESULT += $? ))
+
+
+clear_all_probes
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_probe/test_invalid_options.sh b/tools/perf/testsuite/base_probe/test_invalid_options.sh
new file mode 100755
index 0000000..703d95d
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/test_invalid_options.sh
@@ -0,0 +1,80 @@
+#!/bin/bash
+
+#
+#	test_invalid_options of perf_probe test
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test checks whether the invalid and incompatible options are reported
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+TEST_RESULT=0
+
+check_kprobes_available
+if [ $? -ne 0 ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+
+### missing argument
+
+# some options require an argument
+for opt in '-a' '-d' '-L' '-V'; do
+	! $CMD_PERF probe $opt 2> invalid_options_missing_argument$opt.err
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "Error: switch .* requires a value" < invalid_options_missing_argument$opt.err
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "missing argument for $opt"
+	(( TEST_RESULT += $? ))
+done
+
+
+### unnecessary argument
+
+# some options may omit the argument
+for opt in '-F' '-l'; do
+	$CMD_PERF probe -F > /dev/null 2> invalid_options_unnecessary_argument$opt.err
+	PERF_EXIT_CODE=$?
+
+	test ! -s invalid_options_unnecessary_argument$opt.err
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "unnecessary argument for $opt"
+	(( TEST_RESULT += $? ))
+done
+
+
+### mutually exclusive options
+
+# some options are mutually exclusive
+test -e invalid_options_mutually_exclusive.log && rm -f invalid_options_mutually_exclusive.log
+for opt in '-a xxx -d xxx' '-a xxx -L foo' '-a xxx -V foo' '-a xxx -l' '-a xxx -F' \
+		'-d xxx -L foo' '-d xxx -V foo' '-d xxx -l' '-d xxx -F' \
+		'-L foo -V bar' '-L foo -l' '-L foo -F' '-V foo -l' '-V foo -F' '-l -F'; do
+	! $CMD_PERF probe $opt 2> aux.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "Error: switch .+ cannot be used with switch .+" < aux.log
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "mutually exclusive options :: $opt"
+	(( TEST_RESULT += $? ))
+
+	# gather the logs
+	cat aux.log | grep "Error" >> invalid_options_mutually_exclusive.log
+done
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_probe/test_line_semantics.sh b/tools/perf/testsuite/base_probe/test_line_semantics.sh
new file mode 100755
index 0000000..edda024
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/test_line_semantics.sh
@@ -0,0 +1,56 @@
+#!/bin/bash
+
+#
+#	test_line_semantics of perf_probe test
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test checks whether the semantic errors of line option's
+#		arguments are properly reported.
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+TEST_RESULT=0
+
+check_kprobes_available
+if [ $? -ne 0 ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+
+### acceptable --line descriptions
+
+# testing acceptance of valid patterns for the '--line' option
+VALID_PATTERNS="func func:10 func:0-10 func:2+10 func@source.c func@source.c:1 source.c:1 source.c:1+1 source.c:1-10"
+for desc in $VALID_PATTERNS; do
+	! ( $CMD_PERF probe --line $desc 2>&1 | grep -q "Semantic error" )
+	CHECK_EXIT_CODE=$?
+
+	print_results 0 $CHECK_EXIT_CODE "acceptable descriptions :: $desc"
+	(( TEST_RESULT += $? ))
+done
+
+
+### unacceptable --line descriptions
+
+# testing handling of invalid patterns for the '--line' option
+INVALID_PATTERNS="func:foo func:1-foo func:1+foo func;lazy\*pattern"
+for desc in $INVALID_PATTERNS; do
+	$CMD_PERF probe --line $desc 2>&1 | grep -q "Semantic error"
+	CHECK_EXIT_CODE=$?
+
+	print_results 0 $CHECK_EXIT_CODE "unacceptable descriptions :: $desc"
+	(( TEST_RESULT += $? ))
+done
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_probe/test_listing.sh b/tools/perf/testsuite/base_probe/test_listing.sh
new file mode 100755
index 0000000..a995fbc
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/test_listing.sh
@@ -0,0 +1,154 @@
+#!/bin/bash
+
+#
+#	test_listing of perf_probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#
+#	Description:
+#
+#		This test tests various listings of the perf-probe command
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+TEST_RESULT=0
+
+check_kprobes_available
+if [ $? -ne 0 ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+check_uprobes_available
+if [ $? -ne 0 ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+
+### kernel functions list
+
+# the '-F' option should list all the available kernel functions for probing
+$CMD_PERF probe -F > listing_kernel_functions.log
+PERF_EXIT_CODE=$?
+
+RATE=`../common/check_kallsyms_vs_probes.pl /proc/kallsyms listing_kernel_functions.log`
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "kernel functions list ($RATE to kallsyms)"
+(( TEST_RESULT += $? ))
+
+
+### userspace functions list
+
+# with '-x binary' the '-F' option should inspect the binary instead of kernel
+$CMD_PERF probe -x examples/exact_counts -F > listing_userspace_functions.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "f_103x" "f_1x" "f_2x" "f_3x" "f_65535x" "f_997x" "main" < listing_userspace_functions.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "userspace functions list"
+(( TEST_RESULT += $? ))
+
+
+### kernel variables list
+
+# the '-V' option should list all the available variables for a function/line
+$CMD_PERF probe -V vfs_read > listing_kernel_variables.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "Available variables at vfs_read" "char\s*\*\s*buf" "pos" "size_t\s+count" "struct\s+file\s*\*\s*file" < listing_kernel_variables.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "kernel variables list"
+(( TEST_RESULT += $? ))
+
+
+### userspace variables list
+
+# with '-x binary' the '-V' option should inspect the binary for variables available in a function
+LONG_FUNC="some_function_with_a_really_long_name_that_must_be_longer_than_64_bytes"
+$CMD_PERF probe -x examples/test -V $LONG_FUNC > listing_userspace_variables.log
+PERF_EXIT_CODE=$?
+
+LONG_VAR="some_variable_with_a_really_long_name_that_must_be_longer_than_64_bytes"
+LONG_ARG="some_argument_with_a_really_long_name_that_must_be_longer_than_64_bytes"
+../common/check_all_patterns_found.pl "Available variables at $LONG_FUNC" "int\s+i" "int\s+$LONG_VAR" "int\s+$LONG_ARG" < listing_userspace_variables.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "userspace variables list"
+(( TEST_RESULT += $? ))
+
+
+### kernel lines list
+
+# the '-L' option should list all the available lines suitable for probing per function
+$CMD_PERF probe -L vfs_read > listing_kernel_lines.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "\d+\s+\{" "\d+\s+\}" "0\s+ssize_t\svfs_read" "\d+\s+\w+" < listing_kernel_lines.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "kernel lines list"
+(( TEST_RESULT += $? ))
+
+
+### kernel source lines list
+
+# the '-L' option should list all the available lines suitable for probing per file
+$CMD_PERF probe -L fs/read_write.c > listing_kernel_source_lines.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "linux/fs/read_write.c" "\d+\s+\{" "\d+\s+\}" "\d+\s+\w+" "\d+\s+.*vfs_read" "\d+\s+.*vfs_write" "Linus Torvalds" < listing_kernel_source_lines.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "kernel source lines list"
+(( TEST_RESULT += $? ))
+
+
+### userspace lines list --> currently NOT SUPPORTED
+if false; then
+
+# with '-x binary' the '-L' option should search for lines suitable for probing in the binary
+LONG_FUNC="some_function_with_a_really_long_name_that_must_be_longer_than_64_bytes"
+$CMD_PERF probe -x examples/test -L $LONG_FUNC > listing_userspace_lines.log
+PERF_EXIT_CODE=$?
+
+LONG_VAR="some_variable_with_a_really_long_name_that_must_be_longer_than_64_bytes"
+../common/check_all_patterns_found.pl "\d+\s+$LONG_VAR \+= 1;" < listing_userspace_lines.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "userspace lines list"
+(( TEST_RESULT += $? ))
+else
+print_testcase_skipped "userspace lines list"
+fi
+
+
+### userspace source lines list --> currently NOT SUPPORTED
+if false; then
+
+# the '-L' option should be able to list whole source file as well
+LONG_FUNC="some_function_with_a_really_long_name_that_must_be_longer_than_64_bytes"
+$CMD_PERF probe -x examples/test -L examples/test.c > listing_userspace_source_lines.log
+PERF_EXIT_CODE=$?
+
+LONG_VAR="some_variable_with_a_really_long_name_that_must_be_longer_than_64_bytes"
+../common/check_all_patterns_found.pl "\d+\s+$LONG_VAR \+= 1;" < listing_userspace_source_lines.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "userspace source lines list"
+(( TEST_RESULT += $? ))
+else
+print_testcase_skipped "userspace source lines list"
+fi
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/testsuite/base_probe/test_probe_syntax.sh b/tools/perf/testsuite/base_probe/test_probe_syntax.sh
new file mode 100755
index 0000000..4067cc6
--- /dev/null
+++ b/tools/perf/testsuite/base_probe/test_probe_syntax.sh
@@ -0,0 +1,119 @@
+#!/bin/bash
+
+#
+#	test_probe_syntax of perf_probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests adding of probes specified by some more
+#	advanced expressions (see man page section "PROBE SYNTAX":
+#
+# Probe points are defined by following syntax.
+#
+# 1) Define event based on function name
+#	[EVENT=]FUNC[@SRC][:RLN|+OFFS|%return|;PTN] [ARG ...]
+#
+# 2) Define event based on source file with line number
+#	[EVENT=]SRC:ALN [ARG ...]
+#
+# 3) Define event based on source file with lazy pattern
+#	[EVENT=]SRC;PTN [ARG ...]
+#
+#
+#		This testcase checks whether the above mentioned
+#	expression formats are accepted correctly by perf-probe.
+#
+
+# include working environment
+. ../common/init.sh
+. ./settings.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+TEST_RESULT=0
+
+TEST_PROBE="vfs_read"
+
+check_kprobes_available
+if [ $? -ne 0 ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+clear_all_probes
+
+
+### custom named probe
+
+# when "new_name=" prefix is given, the probe should be named according to it
+$CMD_PERF probe myprobe=$TEST_PROBE 2> probe_syntax_custom_name_add.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "Added new event:" "probe:myprobe" "on $TEST_PROBE" < probe_syntax_custom_name_add.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "custom named probe :: add"
+(( TEST_RESULT += $? ))
+
+# the custom name should appear in the probe list
+$CMD_PERF probe -l > probe_syntax_custom_name_list.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "\s*probe:myprobe\s+\(on $TEST_PROBE@.+\)" < probe_syntax_custom_name_list.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "custom named probe :: list"
+(( TEST_RESULT += $? ))
+
+# the custom named probe should be usable
+$CMD_PERF stat -e probe:myprobe -o probe_syntax_custom_name_use.log -- cat /proc/uptime > /dev/null
+PERF_EXIT_CODE=$?
+
+REGEX_STAT_HEADER="\s*Performance counter stats for \'cat /proc/uptime\':"
+# the value should be greater than 1
+REGEX_STAT_VALUES="\s*[1-9][0-9]*\s+probe:myprobe"
+REGEX_STAT_TIME="\s*$RE_NUMBER\s+seconds time elapsed"
+../common/check_all_lines_matched.pl "$REGEX_STAT_HEADER" "$REGEX_STAT_VALUES" "$REGEX_STAT_TIME" "$RE_LINE_COMMENT" "$RE_LINE_EMPTY" < probe_syntax_custom_name_use.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "custom named probe :: use"
+(( TEST_RESULT += $? ))
+
+clear_all_probes
+
+
+### various syntax forms
+
+# the probe point can be specified many ways
+VALID_PATTERNS_BY_FUNCTION="vfs_read@fs/read_write.c vfs_read:11@fs/read_write.c vfs_read@fs/read_write.c:11 vfs_read%return"
+for desc in $VALID_PATTERNS_BY_FUNCTION; do
+	! ( $CMD_PERF probe -f --add $desc 2>&1 | grep -q "Invalid argument" )
+	CHECK_EXIT_CODE=$?
+
+	print_results 0 $CHECK_EXIT_CODE "various syntax forms :: $desc"
+	(( TEST_RESULT += $? ))
+done
+
+clear_all_probes
+
+# the 'test.c:29' format is better to test with userspace probes,
+# since the absolute line numbers in the code does not change
+! ( $CMD_PERF probe -x examples/test --add test.c:29 2>&1 | grep -q "Invalid argument" )
+CHECK_EXIT_CODE=$?
+
+print_results 0 $CHECK_EXIT_CODE "various syntax forms :: test.c:29"
+(( TEST_RESULT += $? ))
+
+# function name with retval in the userspace code
+! ( $CMD_PERF probe -x examples/test --add 'some_normal_function%return $retval' 2>&1 | grep -q "Invalid argument" )
+CHECK_EXIT_CODE=$?
+
+print_results 0 $CHECK_EXIT_CODE "various syntax forms :: func%return \$retval"
+(( TEST_RESULT += $? ))
+
+clear_all_probes
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
