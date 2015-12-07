From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 3/9] perf test: new testsuite: perf annotate tests
Date: Mon, 07 Dec 2015 19:53:14 +0100
Message-ID: <1449514394.24573.253.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932310AbbLGSxQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Dec 2015 13:53:16 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 927418E234
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Dec 2015 18:53:16 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

This commit adds tests for perf annotate tool.

The structure of the base_something dirs is the following:

base_something/
	settings.sh
		- a script mentioned to be sourced within the tests
	setup.sh
		- if present, necessary for setup of the subset
	test_*.sh
		- various tests of the subset
	cleanup.sh
		- a cleanup script that should remove logs, etc.

All the tests should be stand-alone.  So if needed, it is enough to
cd to the proper base_directory and run the test.  Sometimes, setup
is needed to be run first.

Example:

cd testsuite/base_annotate
./setup.sh
./test_basic.sh

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/testsuite/base_annotate/cleanup.sh      |  22 +++
 .../perf/testsuite/base_annotate/examples/Makefile |  13 ++
 tools/perf/testsuite/base_annotate/examples/load.c |  24 +++
 tools/perf/testsuite/base_annotate/settings.sh     |  15 ++
 tools/perf/testsuite/base_annotate/setup.sh        |  35 +++++
 tools/perf/testsuite/base_annotate/test_basic.sh   | 169 +++++++++++++++++++++
 6 files changed, 278 insertions(+)
 create mode 100755 tools/perf/testsuite/base_annotate/cleanup.sh
 create mode 100644 tools/perf/testsuite/base_annotate/examples/Makefile
 create mode 100644 tools/perf/testsuite/base_annotate/examples/load.c
 create mode 100644 tools/perf/testsuite/base_annotate/settings.sh
 create mode 100755 tools/perf/testsuite/base_annotate/setup.sh
 create mode 100755 tools/perf/testsuite/base_annotate/test_basic.sh

diff --git a/tools/perf/testsuite/base_annotate/cleanup.sh b/tools/perf/testsuite/base_annotate/cleanup.sh
new file mode 100755
index 0000000..616873a
--- /dev/null
+++ b/tools/perf/testsuite/base_annotate/cleanup.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+
+#
+#	cleanup.sh of perf annotate test
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
+make -s -C examples clean
+
+find . -name \*.log | xargs -r rm
+find . -name \*.err | xargs -r rm
+rm -f perf.data
+
+print_results 0 0 "clean-up logs"
+exit $?
diff --git a/tools/perf/testsuite/base_annotate/examples/Makefile b/tools/perf/testsuite/base_annotate/examples/Makefile
new file mode 100644
index 0000000..0ae9638
--- /dev/null
+++ b/tools/perf/testsuite/base_annotate/examples/Makefile
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
diff --git a/tools/perf/testsuite/base_annotate/examples/load.c b/tools/perf/testsuite/base_annotate/examples/load.c
new file mode 100644
index 0000000..c8f30d1
--- /dev/null
+++ b/tools/perf/testsuite/base_annotate/examples/load.c
@@ -0,0 +1,24 @@
+#include <stdio.h>
+#include <stdlib.h>
+
+
+int main (int argc, char *argv[])
+{
+	long from, i, j = 20L;
+
+	if (argc > 1)
+		from = atol (argv[1]);
+	else
+		from = 20L;
+
+	for (i = 1L; j; ++i)
+	{
+		for (j = from; j > 0L; --j)
+			if (i % j)
+				break;
+	}
+
+	printf ("%ld\n", --i);
+
+	return 0;
+}
diff --git a/tools/perf/testsuite/base_annotate/settings.sh b/tools/perf/testsuite/base_annotate/settings.sh
new file mode 100644
index 0000000..77567ce
--- /dev/null
+++ b/tools/perf/testsuite/base_annotate/settings.sh
@@ -0,0 +1,15 @@
+#
+#	settings.sh of perf_annotate test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#		FIXME
+#
+#
+
+export TEST_NAME="perf_annotate"
+export MY_ARCH=`arch`
+export MY_HOSTNAME=`hostname`
+export MY_KERNEL_VERSION=`uname -r`
+export MY_CPUS_ONLINE=`nproc`
+export MY_CPUS_AVAILABLE=`cat /proc/cpuinfo | grep processor | wc -l`
diff --git a/tools/perf/testsuite/base_annotate/setup.sh b/tools/perf/testsuite/base_annotate/setup.sh
new file mode 100755
index 0000000..1a1bc41
--- /dev/null
+++ b/tools/perf/testsuite/base_annotate/setup.sh
@@ -0,0 +1,35 @@
+#!/bin/bash
+
+#
+#	setup.sh of perf annotate test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		FIXME - build C program
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
+print_results $? 0 "building the example code"
+TEST_RESULT=$?
+
+# record some data
+$CMD_PERF record examples/load > /dev/null 2> setup_record.log
+PERF_EXIT_CODE=$?
+
+# check the perf record output
+../common/check_all_lines_matched.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < setup_record.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "record data"
+(( TEST_RESULT += $? ))
+
+print_overall_results $TEST_RESULT
+exit $?
diff --git a/tools/perf/testsuite/base_annotate/test_basic.sh b/tools/perf/testsuite/base_annotate/test_basic.sh
new file mode 100755
index 0000000..84adf65
--- /dev/null
+++ b/tools/perf/testsuite/base_annotate/test_basic.sh
@@ -0,0 +1,169 @@
+#!/bin/bash
+
+#
+#	test_basic of perf annotate test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test tests basic functionality of perf annotate command.
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
+	$CMD_PERF annotate --help > basic_helpmsg.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-ANNOTATE" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "SEE ALSO" < basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "perf\-annotate \- Read perf.data .* display annotated code" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "input" "dsos" "symbol" "force" "verbose" "dump-raw-trace" "vmlinux" "modules" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "print-line" "full-paths" "stdio" "tui" "cpu" "source" "symfs" "disassembler-style" < basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "objdump" "skip-missing" "group" < basic_helpmsg.log
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
+# annotate...
+$CMD_PERF annotate --stdio > basic_annotate.log 2> basic_annotate.err
+PERF_EXIT_CODE=$?
+
+# check the annotate output; default option means both source and assembly
+REGEX_HEADER="Percent.*Source code.*Disassembly\sof"
+REGEX_LINE="$RE_NUMBER\s+:\s+$RE_NUMBER_HEX\s*:.*"
+REGEX_SECTION__TEXT="Disassembly of section \.text:"
+# check for the basic structure
+../common/check_all_patterns_found.pl "$REGEX_HEADER load" "$REGEX_LINE" "$REGEX_SECTION__TEXT" < basic_annotate.log
+CHECK_EXIT_CODE=$?
+# check for the source code presence
+../common/check_all_patterns_found.pl "main" "from = atol" "from = 20L;" "for\s*\(i = 1L; j; \+\+i\)" "return 0;" < basic_annotate.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution - annotate"
+(( TEST_RESULT += $? ))
+
+
+### dso filter
+
+# '--dso SOME_DSO' limits the annotation to SOME_DSO only
+$CMD_PERF annotate --stdio --dso load > basic_dso.log 2> basic_dso.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "$REGEX_HEADER load" "$REGEX_LINE" "$REGEX_SECTION__TEXT" < basic_dso.log
+CHECK_EXIT_CODE=$?
+# check for the source code presence
+../common/check_all_patterns_found.pl "main\(" "from = atol" "from = 20L;" "for\s*\(i = 1L; j; \+\+i\)" "return 0;" < basic_dso.log
+(( CHECK_EXIT_CODE += $? ))
+# check whether the '--dso' option cuts the output to one dso only
+test `grep -c "Disassembly" basic_dso.log` -eq 2
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "dso filter"
+(( TEST_RESULT += $? ))
+
+
+### no-source
+
+# '--no-source' should show only the assembly code
+$CMD_PERF annotate --stdio --no-source --dso load > basic_nosource.log 2> basic_nosource.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "$REGEX_HEADER load" "$REGEX_LINE" "$REGEX_SECTION__TEXT" < basic_nosource.log
+CHECK_EXIT_CODE=$?
+# the C source should not be there
+../common/check_no_patterns_found.pl "from = atol" "from = 20L;" "for\s*\(i = 1L; j; \+\+i\)" "return 0;" < basic_nosource.log
+(( CHECK_EXIT_CODE += $? ))
+# check whether the '--dso' option cuts the output to one dso only
+test `grep -c "Disassembly" basic_dso.log` -eq 2
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "no-source"
+(( TEST_RESULT += $? ))
+
+
+### full-paths
+
+# '-P' should print full paths of DSOs
+$CMD_PERF annotate --stdio --dso load -P > basic_fullpaths.log 2> basic_fullpaths.err
+PERF_EXIT_CODE=$?
+
+FULLPATH="`pwd`/examples"
+../common/check_all_patterns_found.pl "$REGEX_HEADER $FULLPATH/load" "$REGEX_LINE" "$REGEX_SECTION__TEXT" < basic_fullpaths.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "full-paths"
+(( TEST_RESULT += $? ))
+
+
+### print-line
+
+# '--print-line' should print inline the source lines
+$CMD_PERF annotate --stdio --dso load -P --print-line > basic_printline.log 2> basic_printline.err
+PERF_EXIT_CODE=$?
+
+FULLPATH="`pwd`/examples"
+../common/check_all_patterns_found.pl "$FULLPATH/load\.c:$RE_NUMBER\s+$REGEX_LINE" "$REGEX_SECTION__TEXT" < basic_printline.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "print-line"
+(( TEST_RESULT += $? ))
+
+
+### redirected input
+
+# '-i dir/perf.data' should point to some other perf.data file
+mv perf.data examples/
+$CMD_PERF annotate --stdio --dso load -i examples/perf.data > basic_input.log 2> basic_input.err
+PERF_EXIT_CODE=$?
+
+# the output should be the same as before
+diff -q basic_input.log basic_dso.log
+CHECK_EXIT_CODE=$?
+diff -q basic_input.err basic_dso.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "redirected input"
+(( TEST_RESULT += $? ))
+
+
+### execution without perf.data
+
+# check for error message
+! $CMD_PERF annotate > basic_nodata.log 2> basic_nodata.err
+PERF_EXIT_CODE=$?
+
+REGEX_NO_DATA="failed to open perf.data: No such file or directory"
+../common/check_all_lines_matched.pl "$REGEX_NO_DATA" < basic_nodata.err
+CHECK_EXIT_CODE=$?
+test ! -s basic_nodata.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "execution without data"
+(( TEST_RESULT += $? ))
+mv examples/perf.data ./
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
