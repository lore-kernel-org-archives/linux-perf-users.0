From: Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 2/9] perf test: adding new testsuite: common files
Date: Wed, 16 Mar 2016 14:51:29 +0100 (CET)
Message-ID: <alpine.LRH.2.20.1603161451100.13911@Rudolf-RHEL-7>
References: <cover.1458134357.git.mpetlan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53838 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966568AbcCPNvd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 Mar 2016 09:51:33 -0400
In-Reply-To: <cover.1458134357.git.mpetlan@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@kernel.org, Jiri Olsa <jolsa@redhat.com>

A new testsuite based on black-box testing of perf's subcommands is
located in tools/perf/testsuite.  It can be run from the perf's dir
by "perf test suite".

The suite aims on testing the subcommands and their sanity from the
user's point of view. It is designed to be easily extensible when a
new feature needs to be covered.

This commit adds the base part of the testsuite (config, checkers):

common/
     init.sh
         - to be sourced within the test scripts
     patterns.sh
         - contains common regexp patterns
     settings.sh
         - sourced from init.sh
         - contains various constants and settings
     parametrization.sh
         - sourced from settings.sh
         - like a config file for enablement and disablement
           of some features, regulation of depth, etc.
     check_*.pl
         - various scripts for checking output
         - might be extended by some more advanced checking
           tools and techniques

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
  .../testsuite/common/check_all_lines_matched.pl    |  38 +++++++
  .../testsuite/common/check_all_patterns_found.pl   |  33 ++++++
  .../testsuite/common/check_any_pattern_found.pl    |  14 +++
  .../testsuite/common/check_buildids_vs_files.pl    |  31 ++++++
  .../testsuite/common/check_errors_whitelisted.pl   |  50 +++++++++
  .../testsuite/common/check_exact_pattern_order.pl  |  27 +++++
  .../testsuite/common/check_kallsyms_vs_probes.pl   |  61 +++++++++++
  .../testsuite/common/check_no_patterns_found.pl    |  33 ++++++
  tools/perf/testsuite/common/init.sh                |  67 ++++++++++++
  tools/perf/testsuite/common/parametrization.sh     |  39 +++++++
  tools/perf/testsuite/common/patterns.sh            | 119 +++++++++++++++++++++
  tools/perf/testsuite/common/settings.sh            |  57 ++++++++++
  12 files changed, 569 insertions(+)
  create mode 100755 tools/perf/testsuite/common/check_all_lines_matched.pl
  create mode 100755 tools/perf/testsuite/common/check_all_patterns_found.pl
  create mode 100755 tools/perf/testsuite/common/check_any_pattern_found.pl
  create mode 100755 tools/perf/testsuite/common/check_buildids_vs_files.pl
  create mode 100755 tools/perf/testsuite/common/check_errors_whitelisted.pl
  create mode 100755 tools/perf/testsuite/common/check_exact_pattern_order.pl
  create mode 100755 tools/perf/testsuite/common/check_kallsyms_vs_probes.pl
  create mode 100755 tools/perf/testsuite/common/check_no_patterns_found.pl
  create mode 100644 tools/perf/testsuite/common/init.sh
  create mode 100644 tools/perf/testsuite/common/parametrization.sh
  create mode 100644 tools/perf/testsuite/common/patterns.sh
  create mode 100644 tools/perf/testsuite/common/settings.sh

diff --git a/tools/perf/testsuite/common/check_all_lines_matched.pl b/tools/perf/testsuite/common/check_all_lines_matched.pl
new file mode 100755
index 0000000..b3d9990
--- /dev/null
+++ b/tools/perf/testsuite/common/check_all_lines_matched.pl
@@ -0,0 +1,38 @@
+#!/usr/bin/perl
+
+@regexps = @ARGV;
+
+$max_printed_lines = 20;
+$max_printed_lines = $ENV{ERROR_MESSAGE_MAX_LINES} if (defined $ENV{ERROR_MESSAGE_MAX_LINES});
+
+$quiet = 1;
+$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
+
+$passed = 1;
+$lines_printed = 0;
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
+		if ($lines_printed++ < $max_printed_lines)
+		{
+			print "Line did not match any pattern: \"$_\"\n" unless $quiet;
+		}
+		$passed = 0;
+	}
+}
+
+exit ($passed == 0);
diff --git a/tools/perf/testsuite/common/check_all_patterns_found.pl b/tools/perf/testsuite/common/check_all_patterns_found.pl
new file mode 100755
index 0000000..392d3f8a
--- /dev/null
+++ b/tools/perf/testsuite/common/check_all_patterns_found.pl
@@ -0,0 +1,33 @@
+#!/usr/bin/perl
+
+@regexps = @ARGV;
+
+$quiet = 1;
+$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
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
+		print "Regexp not found: \"$r\"\n" unless $quiet;
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
diff --git a/tools/perf/testsuite/common/check_buildids_vs_files.pl b/tools/perf/testsuite/common/check_buildids_vs_files.pl
new file mode 100755
index 0000000..777a5ff
--- /dev/null
+++ b/tools/perf/testsuite/common/check_buildids_vs_files.pl
@@ -0,0 +1,31 @@
+#!/usr/bin/perl
+
+$quiet = 1;
+$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
+
+$passed = 1;
+
+while (<STDIN>)
+{
+	chomp;
+	($buildid_from_list, $filepath) = $_ =~ /^(\w{40})\s+((?:\/[\w\+.-]+)+|(?:\[kernel\.kallsyms\]))$/;
+	if ($filepath =~ /\[kernel\.kallsyms\]/)
+	{
+		$CMD_PERF = $ENV{'CMD_PERF'};
+		$buildid_from_file = `$CMD_PERF buildid-list -k`;
+		chomp $buildid_from_file;
+	}
+	else
+	{
+		$filecmd_output = `file $filepath 2>/dev/null`;
+		($buildid_from_file) = $filecmd_output =~ /BuildID\[sha1\]=(\w{40})/;
+	}
+
+	if ($buildid_from_file ne $buildid_from_list)
+	{
+		$passed = 0;
+		print "$filepath has $buildid_from_file buildid but perf shows $buildid_from_list\n" unless $quiet;
+	}
+}
+
+exit !($passed);
diff --git a/tools/perf/testsuite/common/check_errors_whitelisted.pl b/tools/perf/testsuite/common/check_errors_whitelisted.pl
new file mode 100755
index 0000000..274bac8
--- /dev/null
+++ b/tools/perf/testsuite/common/check_errors_whitelisted.pl
@@ -0,0 +1,50 @@
+#!/usr/bin/perl
+
+$whitelist_file = shift;
+
+if (defined $whitelist_file)
+{
+	open (INFILE, $whitelist_file) or die "Checker error: Unable to open the whitelist file: $whitelist_file\n";
+	@regexps = <INFILE>;
+	close INFILE or die "Checker error: Unable to close the whitelist file: $whitelist_file\n";
+}
+else
+{
+	@regexps = ();
+}
+
+$max_printed_lines = 20;
+$max_printed_lines = $ENV{ERROR_MESSAGE_MAX_LINES} if (defined $ENV{ERROR_MESSAGE_MAX_LINES});
+
+$quiet = 1;
+$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
+
+$passed = 1;
+$lines_printed = 0;
+
+while (<STDIN>)
+{
+	s/\n//;
+
+	$line_matched = 0;
+	for $r (@regexps)
+	{
+		chomp $r;
+		if (/$r/)
+		{
+			$line_matched = 1;
+			last;
+		}
+	}
+
+	unless ($line_matched)
+	{
+		if ($lines_printed++ < $max_printed_lines)
+		{
+			print "Line did not match any pattern: \"$_\"\n" unless $quiet;
+		}
+		$passed = 0;
+	}
+}
+
+exit ($passed == 0);
diff --git a/tools/perf/testsuite/common/check_exact_pattern_order.pl b/tools/perf/testsuite/common/check_exact_pattern_order.pl
new file mode 100755
index 0000000..cd2c7ed
--- /dev/null
+++ b/tools/perf/testsuite/common/check_exact_pattern_order.pl
@@ -0,0 +1,27 @@
+#!/usr/bin/perl
+
+@regexps = @ARGV;
+
+$quiet = 1;
+$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
+
+$passed = 1;
+$r = shift @regexps;
+
+while (<STDIN>)
+{
+	s/\n//;
+
+	if (/$r/)
+	{
+		$r = shift @regexps;
+	}
+}
+
+if (defined $r)
+{
+	print "Pattern not found in the proper order: $r\n" unless $quiet;
+	exit 1;
+}
+
+exit 0;
diff --git a/tools/perf/testsuite/common/check_kallsyms_vs_probes.pl b/tools/perf/testsuite/common/check_kallsyms_vs_probes.pl
new file mode 100755
index 0000000..c463294
--- /dev/null
+++ b/tools/perf/testsuite/common/check_kallsyms_vs_probes.pl
@@ -0,0 +1,61 @@
+#!/usr/bin/perl
+
+$matched = 0;
+$missing = 0;
+$all = 0;
+
+$threshold = 85;
+
+$kallsyms_file = $ARGV[0];
+$kfuncs_file = $ARGV[1];
+
+$quiet = 1;
+$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
+
+sub my_die
+{
+	my $msg = shift;
+	unless ($quiet)
+	{
+		print STDERR "$msg";
+	}
+	exit 1;
+}
+
+# load the kallsyms into a hash
+%kallsyms_hash = ();
+open (INFILE, $kallsyms_file) or my_die "ERROR: Unable to open $kallsyms_file.\n";
+@kallsyms_lines = <INFILE>;
+close INFILE or my_die "ERROR: Unable to close $kallsyms_file\n";
+
+for (@kallsyms_lines)
+{
+	chomp;
+	next unless /[\da-fA-F]+\s\w\s(\w+)/;
+
+	$kallsyms_hash{$1} = 1;
+}
+
+# check the kfuncs
+open (INFILE, $kfuncs_file) or my_die "ERROR: Unable to open $kfuncs_file\n";
+@kfuncs_lines = <INFILE>;
+close INFILE or my_die "ERROR: Unable to close $kfuncs_file\n";
+
+for (@kfuncs_lines)
+{
+	chomp;
+	if (exists $kallsyms_hash{$_})
+	{
+		$matched++;
+	}
+	else
+	{
+		$missing++;
+	}
+	$all++;
+}
+
+$rate = ($matched / $all) * 100;
+printf("%d%% matches\n", $rate) unless $quiet;
+
+exit !($rate > $threshold);
diff --git a/tools/perf/testsuite/common/check_no_patterns_found.pl b/tools/perf/testsuite/common/check_no_patterns_found.pl
new file mode 100755
index 0000000..52e6f8e
--- /dev/null
+++ b/tools/perf/testsuite/common/check_no_patterns_found.pl
@@ -0,0 +1,33 @@
+#!/usr/bin/perl
+
+@regexps = @ARGV;
+
+$quiet = 1;
+$quiet = 0 if (defined $ENV{TESTLOG_VERBOSITY} && $ENV{TESTLOG_VERBOSITY} ge 2);
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
+			$found{$r} = 1;
+		}
+	}
+}
+
+for $r (@regexps)
+{
+	if (exists $found{$r})
+	{
+		print "Regexp found: \"$r\"\n" unless $quiet;
+		$passed = 0;
+	}
+}
+
+exit ($passed == 0);
diff --git a/tools/perf/testsuite/common/init.sh b/tools/perf/testsuite/common/init.sh
new file mode 100644
index 0000000..d1c695b
--- /dev/null
+++ b/tools/perf/testsuite/common/init.sh
@@ -0,0 +1,67 @@
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
+
+. ../common/settings.sh
+. ../common/patterns.sh
+
+THIS_TEST_NAME=`basename $0 .sh`
+
+_echo()
+{
+	test "$TESTLOG_VERBOSITY" -ne 0 && echo -e "$@"
+}
+
+print_results()
+{
+	PERF_RETVAL="$1"; shift
+	CHECK_RETVAL="$1"; shift
+	FAILURE_REASON=""
+	TASK_COMMENT="$@"
+	if [ $PERF_RETVAL -eq 0 -a $CHECK_RETVAL -eq 0 ]; then
+		_echo "$MPASS-- [ PASS ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $TASK_COMMENT"
+		return 0
+	else
+		if [ $PERF_RETVAL -ne 0 ]; then
+			FAILURE_REASON="command exitcode"
+		fi
+		if [ $CHECK_RETVAL -ne 0 ]; then
+			test -n "$FAILURE_REASON" && FAILURE_REASON="$FAILURE_REASON + "
+			FAILURE_REASON="$FAILURE_REASON""output regexp parsing"
+		fi
+		_echo "$MFAIL-- [ FAIL ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $TASK_COMMENT ($FAILURE_REASON)"
+		return 1
+	fi
+}
+
+print_overall_results()
+{
+	RETVAL="$1"; shift
+	if [ $RETVAL -eq 0 ]; then
+		_echo "$MALLPASS## [ PASS ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY"
+	else
+		_echo "$MALLFAIL## [ FAIL ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY :: $RETVAL failures found"
+	fi
+	return $RETVAL
+}
+
+print_testcase_skipped()
+{
+	TASK_COMMENT="$@"
+	_echo "$MSKIP-- [ SKIP ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $TASK_COMMENT :: testcase skipped"
+	return 0
+}
+
+print_overall_skipped()
+{
+	_echo "$MSKIP## [ SKIP ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME :: testcase skipped"
+	return 0
+}
diff --git a/tools/perf/testsuite/common/parametrization.sh b/tools/perf/testsuite/common/parametrization.sh
new file mode 100644
index 0000000..617f47e
--- /dev/null
+++ b/tools/perf/testsuite/common/parametrization.sh
@@ -0,0 +1,39 @@
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
+#### general
+
+# If set, the '--help' outputs of the commands will be checked.
+# Since the '--help' option calls a manpage and manpages are not
+# always generated, you may skip the man-page checks.
+export PARAM_GENERAL_HELP_TEXT_CHECK=${PARAM_GENERAL_HELP_TEXT_CHECK:-n}
+
+
+#### perf_stat
+
+# If set, the 24x7 events will be tested on all available cores.
+# That might make it 'nproc' times longer. Basically it should be
+# enough to run each event on one core only.
+# Note: POWER8 only
+export PARAM_STAT_24x7_ALL_CORES=${PARAM_STAT_24x7_ALL_CORES:-n}
+
+# If set, all the tracepoint events will be checked for syntax
+# errors in their definition. This testcase may take a long time
+# and the checks are not that crucial, so it can be turned off
+# when you do not want to deep dive.
+export PARAM_STAT_TRACEPOINT_EVENTS_SYNTAX=${PARAM_STAT_TRACEPOINT_EVENTS_SYNTAX:-n}
+
+
+#### perf_trace
+
+# If set, some heavy load tests are run. That might be not always
+# desired behaviour.
+export PARAM_TRACE_OVERLOAD=${PARAM_TRACE_OVERLOAD:-y}
diff --git a/tools/perf/testsuite/common/patterns.sh b/tools/perf/testsuite/common/patterns.sh
new file mode 100644
index 0000000..eb86477
--- /dev/null
+++ b/tools/perf/testsuite/common/patterns.sh
@@ -0,0 +1,119 @@
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
+export RE_PROCESS_PID="\w+\/\d+"
+# A process with PID
+# Example:
+#    sleep/4102
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
+
+export RE_PATH="(?:\/[\w\+\.-]+)+"
+# A full filepath
+# Examples:
+#    /usr/lib64/somelib.so.5.4.0
+#    /lib/modules/4.3.0-rc5/kernel/fs/xfs/xfs.ko
+#    /usr/bin/mv
+
+
+export RE_LINE_COMMENT="^#.*"
+# A comment line
+# Examples:
+#    # Started on Thu Sep 10 11:43:00 2015
+
+
+export RE_LINE_EMPTY="^\s*$"
+# An empty line with possible whitespaces
+# Examples:
+#
+
+
+export RE_LINE_RECORD1="^\[\s+perf\s+record:\s+Woken up $RE_NUMBER times? to write data\s+\].*$"
+# The first line of perf-record "OK" output
+# Examples:
+#    [ perf record: Woken up 1 times to write data ]
+
+
+export RE_LINE_RECORD2="^\[\s+perf\s+record:\s+Captured and wrote $RE_NUMBER\s*MB\s+(?:[\w\+\.-]*(?:$RE_PATH)?\/)?perf\.data\s*\(~?$RE_NUMBER samples\)\s+\].*$"
+# The second line of perf-record "OK" output
+# Examples:
+#    [ perf record: Captured and wrote 0.405 MB perf.data (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB perf.data (~109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB /some/temp/dir/perf.data (109 samples) ]
+#    [ perf record: Captured and wrote 0.405 MB ./perf.data (109 samples) ]
+
+
+export RE_LINE_TRACE="^\s*$RE_NUMBER\s*\(\s*$RE_NUMBER\s*ms\s*\):\s*$RE_PROCESS_PID\s+.*\)\s+=\s+\-?$RE_NUMBER|$RE_NUMBER_HEX.*$"
+# A line of perf-trace output
+# Examples:
+#    0.115 ( 0.005 ms): sleep/4102 open(filename: 0xd09e2ab2, flags: CLOEXEC                             ) = 3
+#    0.157 ( 0.005 ms): sleep/4102 mmap(len: 3932736, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3   ) = 0x7f89d0605000
+
+export RE_LINE_TRACE_SUMMARY_HEADER="\s*syscall\s+calls\s+total\s+min\s+avg\s+max\s+stddev"
+# A header of a perf-trace summary table
+# Example:
+#    syscall            calls    total       min       avg       max      stddev
+
+
+export RE_LINE_TRACE_SUMMARY_CONTENT="\s*\w+\s+(?:$RE_NUMBER\s+){5}$RE_NUMBER%"
+# A line of a perf-trace summary table
+# Example:
+#    open                   3     0.017     0.005     0.006     0.007     10.90%
+
+
+export RE_LINE_REPORT_CONTENT="^\s+$RE_NUMBER%\s+\w+\s+\S+\s+\S+\s+\S+" # FIXME
+# A line from typicap perf report --stdio output
+# Example:
+#    100.00%  sleep    [kernel.vmlinux]  [k] syscall_return_slowpath
diff --git a/tools/perf/testsuite/common/settings.sh b/tools/perf/testsuite/common/settings.sh
new file mode 100644
index 0000000..68eb2f0
--- /dev/null
+++ b/tools/perf/testsuite/common/settings.sh
@@ -0,0 +1,57 @@
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
+export CMD_PERF=${CMD_PERF:-`which perf`}
+
+#### basic programs examinated by perf
+export CMD_BASIC_SLEEP="sleep 0.1"
+export CMD_QUICK_SLEEP="sleep 0.01"
+export CMD_LONGER_SLEEP="sleep 2"
+export CMD_SIMPLE="true"
+
+#### common settings
+export TESTLOG_VERBOSITY=${TESTLOG_VERBOSITY:-0}
+export ERROR_MESSAGE_MAX_LINES=${ERROR_MESSAGE_MAX_LINES:-20}
+
+#### clear locale
+export LC_ALL=C
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
-- 
1.8.3.1
