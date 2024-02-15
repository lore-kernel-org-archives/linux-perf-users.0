Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6F128361
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994982; cv=none; b=NlfljkuHJlsRwXaGxvqFClYA+doH+k9JvsWlP8wZ7+6FGtKN5HfauO5jiPWzGr7mS+te48brj5rgCi1ye+vzV+i5Ja0EnAea8bLGGNPpn8Cy2JlbLdab0lzHTB2RtPgUvXmPUOjG2926BdiTA6iYvSaELb6NT6hR+xZqlcL9I2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994982; c=relaxed/simple;
	bh=0BKZUyp0g8LSiOQqur6lWH6YBhwm5TXQOwHBXWUwwOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=E/gptnxQ+fLLNV2Z7rdZsnTMYRpzMHX3RhnIGbBDbk5sl5vlCx2LC2WkwLSgFellLZR5mwl2cTea0qALBvmvTvOk/QQ2b0q01OPFBk1AMoPzy0NhTWD6FcqXMlgJre/aHOZj+DINoJH79Mzz02aLU0Ytu+zvGjWHoa6Z57EbHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwKQd1Jb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwKQd1Jb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707994979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=FmQYVjDZpMyFwf+xT3c8h8VH+cRwoZ7sXM0vWhvniYU=;
	b=hwKQd1JbxA5Q0Vx08KhPXc0/wQBMCSh/p9tJNOXZ3vqXViCWFvDA5ox0eDlj0+j1Dy7r9s
	h283J62tFAh7SAguK9czoserxL/eDWOqm1+OvFV4QU2+eJIY2xaLEntSR1tSRCbAOPMt9A
	dRoaCoH/SbQx+FJY5vfQ6DU0h0uqVZg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-ICqfi5tEPqWJn_QjbthubQ-1; Thu,
 15 Feb 2024 06:02:56 -0500
X-MC-Unique: ICqfi5tEPqWJn_QjbthubQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C1491C0782C;
	Thu, 15 Feb 2024 11:02:55 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 89B172166B32;
	Thu, 15 Feb 2024 11:02:52 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com
Subject: [PATCH v2 6/7] perf testsuite: Add test for kprobe handling
Date: Thu, 15 Feb 2024 12:02:30 +0100
Message-Id: <20240215110231.15385-7-mpetlan@redhat.com>
In-Reply-To: <20240215110231.15385-1-mpetlan@redhat.com>
References: <20240131113951.17077-1-mpetlan@redhat.com>
 <20240215110231.15385-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

From: Veronika Molnarova <vmolnaro@redhat.com>

Test perf interface to kprobes: listing, adding and removing probes. It
is run as a part of perftool-testsuite_probe test case.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/base_probe/settings.sh |  48 +++
 .../shell/base_probe/test_adding_kernel.sh    | 278 ++++++++++++++++++
 2 files changed, 326 insertions(+)
 create mode 100644 tools/perf/tests/shell/base_probe/settings.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_adding_kernel.sh

diff --git a/tools/perf/tests/shell/base_probe/settings.sh b/tools/perf/tests/shell/base_probe/settings.sh
new file mode 100644
index 000000000000..123621c7f95e
--- /dev/null
+++ b/tools/perf/tests/shell/base_probe/settings.sh
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+#	settings.sh of perf_probe test
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#
+
+export TEST_NAME="perf_probe"
+
+export MY_ARCH=`arch`
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
+
+check_kprobes_available()
+{
+	test -e /sys/kernel/debug/tracing/kprobe_events
+}
+
+check_uprobes_available()
+{
+	test -e /sys/kernel/debug/tracing/uprobe_events
+}
+
+clear_all_probes()
+{
+	echo 0 > /sys/kernel/debug/tracing/events/enable
+	check_kprobes_available && echo > /sys/kernel/debug/tracing/kprobe_events
+	check_uprobes_available && echo > /sys/kernel/debug/tracing/uprobe_events
+}
+
+check_sdt_support()
+{
+	$CMD_PERF list sdt | grep sdt > /dev/null 2> /dev/null
+}
diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
new file mode 100755
index 000000000000..a5d707efad85
--- /dev/null
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -0,0 +1,278 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
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
+# shellcheck disable=SC2034 # the variable is later used after the working environment is included
+THIS_TEST_NAME=`basename $0 .sh`
+TEST_RESULT=0
+
+TEST_PROBE=${TEST_PROBE:-"inode_permission"}
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
+	$CMD_PERF probe $opt $TEST_PROBE 2> $LOGS_DIR/adding_kernel_add$opt.err
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_add$opt.err
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
+$CMD_PERF list probe:\* > $LOGS_DIR/adding_kernel_list.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defined events" "probe:${TEST_PROBE}(?:_\d+)?\s+\[Tracepoint event\]" "Metric Groups:" < $LOGS_DIR/adding_kernel_list.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probe :: perf list"
+(( TEST_RESULT += $? ))
+
+
+### listing added probe :: perf probe -l
+
+# '-l' should list all the added probes as well
+$CMD_PERF probe -l > $LOGS_DIR/adding_kernel_list-l.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "\s*probe:${TEST_PROBE}(?:_\d+)?\s+\(on ${TEST_PROBE}(?:[:\+]$RE_NUMBER_HEX)?@.+\)" < $LOGS_DIR/adding_kernel_list-l.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing added probe :: perf probe -l"
+(( TEST_RESULT += $? ))
+
+
+### using added probe
+
+$CMD_PERF stat -e probe:$TEST_PROBE\* -o $LOGS_DIR/adding_kernel_using_probe.log -- cat /proc/uptime > /dev/null
+PERF_EXIT_CODE=$?
+
+REGEX_STAT_HEADER="\s*Performance counter stats for \'cat /proc/uptime\':"
+REGEX_STAT_VALUES="\s*\d+\s+probe:$TEST_PROBE"
+# the value should be greater than 1
+REGEX_STAT_VALUE_NONZERO="\s*[1-9][0-9]*\s+probe:$TEST_PROBE"
+REGEX_STAT_TIME="\s*$RE_NUMBER\s+seconds (?:time elapsed|user|sys)"
+../common/check_all_lines_matched.pl "$REGEX_STAT_HEADER" "$REGEX_STAT_VALUES" "$REGEX_STAT_TIME" "$RE_LINE_COMMENT" "$RE_LINE_EMPTY" < $LOGS_DIR/adding_kernel_using_probe.log
+CHECK_EXIT_CODE=$?
+../common/check_all_patterns_found.pl "$REGEX_STAT_HEADER" "$REGEX_STAT_VALUE_NONZERO" "$REGEX_STAT_TIME" < $LOGS_DIR/adding_kernel_using_probe.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using added probe"
+(( TEST_RESULT += $? ))
+
+
+### removing added probe
+
+# '-d' should remove the probe
+$CMD_PERF probe -d $TEST_PROBE\* 2> $LOGS_DIR/adding_kernel_removing.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE" < $LOGS_DIR/adding_kernel_removing.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "deleting added probe"
+(( TEST_RESULT += $? ))
+
+
+### listing removed probe
+
+# removed probes should NOT appear in perf-list output
+$CMD_PERF list probe:\* > $LOGS_DIR/adding_kernel_list_removed.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defined events" "Metric Groups:" < $LOGS_DIR/adding_kernel_list_removed.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing removed probe (should NOT be listed)"
+(( TEST_RESULT += $? ))
+
+
+### dry run
+
+# the '-n' switch should run it in dry mode
+$CMD_PERF probe -n --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_dryrun.err
+PERF_EXIT_CODE=$?
+
+# check for the output (should be the same as usual)
+../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_dryrun.err
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
+$CMD_PERF probe --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_01.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_forceadd_01.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: first probe adding"
+(( TEST_RESULT += $? ))
+
+# adding existing probe without '--force' should fail
+! $CMD_PERF probe --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_02.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "Error: event \"$TEST_PROBE\" already exists." "Error: Failed to add events." < $LOGS_DIR/adding_kernel_forceadd_02.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: second probe adding (without force)"
+(( TEST_RESULT += $? ))
+
+# adding existing probe with '--force' should pass
+NO_OF_PROBES=`$CMD_PERF probe -l | wc -l`
+$CMD_PERF probe --force --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_03.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "Added new events?:" "probe:${TEST_PROBE}_${NO_OF_PROBES}" "on $TEST_PROBE" < $LOGS_DIR/adding_kernel_forceadd_03.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: second probe adding (with force)"
+(( TEST_RESULT += $? ))
+
+
+### using doubled probe
+
+# since they are the same, they should produce the same results
+$CMD_PERF stat -e probe:$TEST_PROBE -e probe:${TEST_PROBE}_${NO_OF_PROBES} -x';' -o $LOGS_DIR/adding_kernel_using_two.log -- bash -c 'cat /proc/cpuinfo > /dev/null'
+PERF_EXIT_CODE=$?
+
+REGEX_LINE="$RE_NUMBER;+probe:${TEST_PROBE}_?(?:$NO_OF_PROBES)?;$RE_NUMBER;$RE_NUMBER"
+../common/check_all_lines_matched.pl "$REGEX_LINE" "$RE_LINE_EMPTY" "$RE_LINE_COMMENT" < $LOGS_DIR/adding_kernel_using_two.log
+CHECK_EXIT_CODE=$?
+
+VALUE_1=`grep "$TEST_PROBE;" $LOGS_DIR/adding_kernel_using_two.log | awk -F';' '{print $1}'`
+VALUE_2=`grep "${TEST_PROBE}_${NO_OF_PROBES};" $LOGS_DIR/adding_kernel_using_two.log | awk -F';' '{print $1}'`
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
+$CMD_PERF probe --del \* 2> $LOGS_DIR/adding_kernel_removing_wildcard.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_wildcard.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple probes"
+(( TEST_RESULT += $? ))
+
+
+### wildcard adding support
+
+$CMD_PERF probe -nf --max-probes=512 -a 'vfs_* $params' 2> $LOGS_DIR/adding_kernel_adding_wildcard.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "probe:vfs_mknod" "probe:vfs_create" "probe:vfs_rmdir" "probe:vfs_link" "probe:vfs_write" < $LOGS_DIR/adding_kernel_adding_wildcard.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "wildcard adding support"
+(( TEST_RESULT += $? ))
+
+
+### non-existing variable
+
+# perf probe should survive a non-existing variable probing attempt
+{ $CMD_PERF probe 'vfs_read somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64' ; } 2> $LOGS_DIR/adding_kernel_nonexisting.err
+PERF_EXIT_CODE=$?
+
+# the exitcode should not be 0 or segfault
+test $PERF_EXIT_CODE -ne 139 -a $PERF_EXIT_CODE -ne 0
+PERF_EXIT_CODE=$?
+
+# check that the error message is reasonable
+../common/check_all_patterns_found.pl "Failed to find" "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64" < $LOGS_DIR/adding_kernel_nonexisting.err
+CHECK_EXIT_CODE=$?
+../common/check_all_patterns_found.pl "in this function|at this address" "Error" "Failed to add events" < $LOGS_DIR/adding_kernel_nonexisting.err
+(( CHECK_EXIT_CODE += $? ))
+../common/check_all_lines_matched.pl "Failed to find" "Error" "Probe point .+ not found" "optimized out" "Use.+\-\-range option to show.+location range" < $LOGS_DIR/adding_kernel_nonexisting.err
+(( CHECK_EXIT_CODE += $? ))
+../common/check_no_patterns_found.pl "$RE_SEGFAULT" < $LOGS_DIR/adding_kernel_nonexisting.err
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "non-existing variable"
+(( TEST_RESULT += $? ))
+
+
+### function with return value
+
+# adding probe with return value
+$CMD_PERF probe --add "$TEST_PROBE%return \$retval" 2> $LOGS_DIR/adding_kernel_func_retval_add.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "Added new events?:" "probe:$TEST_PROBE" "on $TEST_PROBE%return with \\\$retval" < $LOGS_DIR/adding_kernel_func_retval_add.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function with retval :: add"
+(( TEST_RESULT += $? ))
+
+# recording some data
+$CMD_PERF record -e probe:$TEST_PROBE\* -o $CURRENT_TEST_DIR/perf.data -- cat /proc/cpuinfo > /dev/null 2> $LOGS_DIR/adding_kernel_func_retval_record.err
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/adding_kernel_func_retval_record.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function with retval :: record"
+(( TEST_RESULT += $? ))
+
+# perf script should report the function calls with the correct arg values
+$CMD_PERF script -i $CURRENT_TEST_DIR/perf.data > $LOGS_DIR/adding_kernel_func_retval_script.log
+PERF_EXIT_CODE=$?
+
+REGEX_SCRIPT_LINE="\s*cat\s+$RE_NUMBER\s+\[$RE_NUMBER\]\s+$RE_NUMBER:\s+probe:$TEST_PROBE\w*:\s+\($RE_NUMBER_HEX\s+<\-\s+$RE_NUMBER_HEX\)\s+arg1=$RE_NUMBER_HEX"
+../common/check_all_lines_matched.pl "$REGEX_SCRIPT_LINE" < $LOGS_DIR/adding_kernel_func_retval_script.log
+CHECK_EXIT_CODE=$?
+../common/check_all_patterns_found.pl "$REGEX_SCRIPT_LINE" < $LOGS_DIR/adding_kernel_func_retval_script.log
+(( CHECK_EXIT_CODE += $? ))
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "function argument probing :: script"
+(( TEST_RESULT += $? ))
+
+
+clear_all_probes
+
+# print overall results
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
2.43.0

