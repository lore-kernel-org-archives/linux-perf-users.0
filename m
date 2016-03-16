From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 3/9] perf test: new testsuite: perf annotate tests
Date: Wed, 16 Mar 2016 14:54:47 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1603161454250.13911@Rudolf-RHEL-7>
References: <cover.1458134357.git.mpetlan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34924 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209AbcCPNyu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Mar 2016 09:54:50 -0400
In-Reply-To: <cover.1458134357.git.mpetlan@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, Jiri Olsa <jolsa@redhat.com>

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
  tools/perf/testsuite/base_annotate/cleanup.sh      |  24 +++
  .../perf/testsuite/base_annotate/examples/Makefile |  16 ++
  tools/perf/testsuite/base_annotate/examples/load.c |  24 +++
  tools/perf/testsuite/base_annotate/settings.sh     |  31 ++++
  tools/perf/testsuite/base_annotate/setup.sh        |  35 +++++
  tools/perf/testsuite/base_annotate/test_basic.sh   | 169 +++++++++++++++++++++
  6 files changed, 299 insertions(+)
  create mode 100755 tools/perf/testsuite/base_annotate/cleanup.sh
  create mode 100644 tools/perf/testsuite/base_annotate/examples/Makefile
  create mode 100644 tools/perf/testsuite/base_annotate/examples/load.c
  create mode 100644 tools/perf/testsuite/base_annotate/settings.sh
  create mode 100755 tools/perf/testsuite/base_annotate/setup.sh
  create mode 100755 tools/perf/testsuite/base_annotate/test_basic.sh

diff --git a/tools/perf/testsuite/base_annotate/cleanup.sh b/tools/perf/testsuite/base_annotate/cleanup.sh
new file mode 100755
index 0000000..dd66675
--- /dev/null
+++ b/tools/perf/testsuite/base_annotate/cleanup.sh
@@ -0,0 +1,24 @@
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
+if [ -n "$PERFSUITE_RUN_DIR" ]; then
+	print_overall_skipped
+	exit 0
+fi
+
+make -s -C examples clean
+find . -name \*.log | xargs -r rm
+find . -name \*.err | xargs -r rm
+rm -f perf.data*
+
+print_overall_results 0
+exit $?
diff --git a/tools/perf/testsuite/base_annotate/examples/Makefile b/tools/perf/testsuite/base_annotate/examples/Makefile
new file mode 100644
index 0000000..3248b6c
--- /dev/null
+++ b/tools/perf/testsuite/base_annotate/examples/Makefile
@@ -0,0 +1,16 @@
+CC=gcc
+CFLAGS=-g -O0
+
+SRCS = $(wildcard *.c)
+PROGS = $(patsubst %.c,%,$(SRCS))
+
+all: $(PROGS)
+ifneq "$(MAKE_TARGET_DIR)x" 'x'
+	mv $(PROGS) $(MAKE_TARGET_DIR)/
+endif
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
index 0000000..398ed27
--- /dev/null
+++ b/tools/perf/testsuite/base_annotate/settings.sh
@@ -0,0 +1,31 @@
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
+export MY_CPUS_AVAILABLE=`cat /proc/cpuinfo | grep -P "processor\s" | wc -l`
+
+if [ -n "$PERFSUITE_RUN_DIR" ]; then
+	# when $PERFSUITE_RUN_DIR is set to something, all the logs and temp files will be placed there
+	# --> the $PERFSUITE_RUN_DIR/perf_something/examples and $PERFSUITE_RUN_DIR/perf_something/logs
+	#     dirs will be used for that
+	export PERFSUITE_RUN_DIR=`readlink -f $PERFSUITE_RUN_DIR`
+	export CURRENT_TEST_DIR="$PERFSUITE_RUN_DIR/$TEST_NAME"
+	export MAKE_TARGET_DIR="$CURRENT_TEST_DIR/examples"
+	test -d "$MAKE_TARGET_DIR" || mkdir -p "$MAKE_TARGET_DIR"
+	export LOGS_DIR="$PERFSUITE_RUN_DIR/$TEST_NAME/logs"
+	test -d "$LOGS_DIR" || mkdir -p "$LOGS_DIR"
+else
+	# when $PERFSUITE_RUN_DIR is not set, logs will be placed here
+	export CURRENT_TEST_DIR="."
+	export LOGS_DIR="."
+fi
diff --git a/tools/perf/testsuite/base_annotate/setup.sh b/tools/perf/testsuite/base_annotate/setup.sh
new file mode 100755
index 0000000..54b1e17
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
+$CMD_PERF record -o $CURRENT_TEST_DIR/perf.data $CURRENT_TEST_DIR/examples/load > /dev/null 2> $LOGS_DIR/setup_record.log
+PERF_EXIT_CODE=$?
+
+# check the perf record output
+../common/check_all_lines_matched.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/setup_record.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "record data"
+(( TEST_RESULT += $? ))
+
+print_overall_results $TEST_RESULT
+exit $?
diff --git a/tools/perf/testsuite/base_annotate/test_basic.sh b/tools/perf/testsuite/base_annotate/test_basic.sh
new file mode 100755
index 0000000..196c38b
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
+	$CMD_PERF annotate --help > $LOGS_DIR/basic_helpmsg.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-ANNOTATE" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "SEE ALSO" < $LOGS_DIR/basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "perf\-annotate \- Read perf.data .* display annotated code" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "input" "dsos" "symbol" "force" "verbose" "dump-raw-trace" "vmlinux" "modules" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "print-line" "full-paths" "stdio" "tui" "cpu" "source" "symfs" "disassembler-style" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "objdump" "skip-missing" "group" < $LOGS_DIR/basic_helpmsg.log
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
+( cd $CURRENT_TEST_DIR ; $CMD_PERF annotate --stdio > $LOGS_DIR/basic_annotate.log 2> $LOGS_DIR/basic_annotate.err )
+PERF_EXIT_CODE=$?
+
+# check the annotate output; default option means both source and assembly
+REGEX_HEADER="Percent.*Source code.*Disassembly\sof"
+REGEX_LINE="$RE_NUMBER\s+:\s+$RE_NUMBER_HEX\s*:.*"
+REGEX_SECTION__TEXT="Disassembly of section \.text:"
+# check for the basic structure
+../common/check_all_patterns_found.pl "$REGEX_HEADER load" "$REGEX_LINE" "$REGEX_SECTION__TEXT" < $LOGS_DIR/basic_annotate.log
+CHECK_EXIT_CODE=$?
+# check for the source code presence
+../common/check_all_patterns_found.pl "main" "from = atol" "from = 20L;" "for\s*\(i = 1L; j; \+\+i\)" "return 0;" < $LOGS_DIR/basic_annotate.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "basic execution - annotate"
+(( TEST_RESULT += $? ))
+
+
+### dso filter
+
+# '--dso SOME_DSO' limits the annotation to SOME_DSO only
+( cd $CURRENT_TEST_DIR ; $CMD_PERF annotate --stdio --dso load > $LOGS_DIR/basic_dso.log 2> $LOGS_DIR/basic_dso.err )
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "$REGEX_HEADER load" "$REGEX_LINE" "$REGEX_SECTION__TEXT" < $LOGS_DIR/basic_dso.log
+CHECK_EXIT_CODE=$?
+# check for the source code presence
+../common/check_all_patterns_found.pl "main\s*\(" "from = atol" "from = 20L;" "for\s*\(i = 1L; j; \+\+i\)" "return 0;" < $LOGS_DIR/basic_dso.log
+(( CHECK_EXIT_CODE += $? ))
+# check whether the '--dso' option cuts the output to one dso only
+test `grep -c "Disassembly" $LOGS_DIR/basic_dso.log` -ge 2 # FIXME wrong
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "dso filter"
+(( TEST_RESULT += $? ))
+
+
+### no-source
+
+# '--no-source' should show only the assembly code
+( cd $CURRENT_TEST_DIR ; $CMD_PERF annotate --stdio --no-source --dso load > $LOGS_DIR/basic_nosource.log 2> $LOGS_DIR/basic_nosource.err )
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "$REGEX_HEADER load" "$REGEX_LINE" "$REGEX_SECTION__TEXT" < $LOGS_DIR/basic_nosource.log
+CHECK_EXIT_CODE=$?
+# the C source should not be there
+../common/check_no_patterns_found.pl "from = atol" "from = 20L;" "for\s*\(i = 1L; j; \+\+i\)" "return 0;" < $LOGS_DIR/basic_nosource.log
+(( CHECK_EXIT_CODE += $? ))
+# check whether the '--dso' option cuts the output to one dso only
+test `grep -c "Disassembly" $LOGS_DIR/basic_nosource.log` -ge 2 # FIXME wrong
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "no-source"
+(( TEST_RESULT += $? ))
+
+
+### full-paths
+
+# '-P' should print full paths of DSOs
+( cd $CURRENT_TEST_DIR ; $CMD_PERF annotate --stdio --dso load -P > $LOGS_DIR/basic_fullpaths.log 2> $LOGS_DIR/basic_fullpaths.err )
+PERF_EXIT_CODE=$?
+
+FULLPATH=`readlink -f $CURRENT_TEST_DIR/examples`
+../common/check_all_patterns_found.pl "$REGEX_HEADER $FULLPATH/load" "$REGEX_LINE" "$REGEX_SECTION__TEXT" < $LOGS_DIR/basic_fullpaths.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "full-paths"
+(( TEST_RESULT += $? ))
+
+
+### print-line
+
+# '--print-line' should print inline the source lines
+( cd $CURRENT_TEST_DIR ; $CMD_PERF annotate --stdio --dso load -P --print-line > $LOGS_DIR/basic_printline.log 2> $LOGS_DIR/basic_printline.err )
+PERF_EXIT_CODE=$?
+
+FULLPATH="`pwd`/examples"
+../common/check_all_patterns_found.pl "$FULLPATH/load\.c:$RE_NUMBER\s+$REGEX_LINE" "$REGEX_SECTION__TEXT" < $LOGS_DIR/basic_printline.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "print-line"
+(( TEST_RESULT += $? ))
+
+
+### redirected input
+
+# '-i dir/perf.data' should point to some other perf.data file
+mv $CURRENT_TEST_DIR/perf.data $CURRENT_TEST_DIR/examples/
+$CMD_PERF annotate --stdio --dso load -i $CURRENT_TEST_DIR/examples/perf.data > $LOGS_DIR/basic_input.log 2> $LOGS_DIR/basic_input.err
+PERF_EXIT_CODE=$?
+
+# the output should be the same as before
+diff -q $LOGS_DIR/basic_input.log $LOGS_DIR/basic_dso.log
+CHECK_EXIT_CODE=$?
+diff -q $LOGS_DIR/basic_input.err $LOGS_DIR/basic_dso.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "redirected input"
+(( TEST_RESULT += $? ))
+
+
+### execution without perf.data
+
+# check for error message
+! $CMD_PERF annotate > $LOGS_DIR/basic_nodata.log 2> $LOGS_DIR/basic_nodata.err
+PERF_EXIT_CODE=$?
+
+REGEX_NO_DATA="failed to open perf.data: No such file or directory"
+../common/check_all_lines_matched.pl "$REGEX_NO_DATA" < $LOGS_DIR/basic_nodata.err
+CHECK_EXIT_CODE=$?
+test ! -s $LOGS_DIR/basic_nodata.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "execution without data"
+(( TEST_RESULT += $? ))
+mv $CURRENT_TEST_DIR/examples/perf.data $CURRENT_TEST_DIR/
+
+
+# print overall resutls
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
1.8.3.1
