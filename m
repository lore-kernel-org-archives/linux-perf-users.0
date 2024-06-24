Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F013D606
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234546; cv=none; b=Xd2IQvmdbZCUycMPUkQP7npkhw/YdIv75vhcfDp5af4DthKcwvalhKjTCzGNP56neItspWgvsczg/WOVUbS3+M3IGO9gNt+3VOtEq45zm20sliWJlR+BkyYKtUMSsJb9yKFAp0ggLPTXF9nyB+BaD63lR6dTtymGkZPJ2x1KoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234546; c=relaxed/simple;
	bh=kl4X+GwPfOD9EmLUDERgXj+toEZmU6Wk5fmVMUfRu+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VWxcQgxERvJ7SfhTSvzBNXbG9jUkaoL4ZNICszlzRnSnUcDH9f5CYMJU5jX/fxYbK9nZ//4pcr3XwMiwq+uDa67KEoodaM3N1Ozv8HB7P+RNVif0Hv/VYuOT7srPIB34Kv1gLdONqx6EKU/jZlVJ+tO2LL9jnksCSzemhwMVUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXOhVQwd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXOhVQwd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=QOyLE2Dwgz0ifJiT8PBrZT80bFzm75z3DI3VGwRFg60=;
	b=dXOhVQwdLLj0XZIg2QLAf0zoWSKj3O5j9Gg7ldsMlN7FhDdlT9rt5/Gv6zB5FA75h4f4Oh
	d1+wA0zbfM7vE7CsI3X3oW9iXA/Wrk8cRLHcBqlw2I21BCLa/HsICUY7mWkNyBc+ykBzqX
	lVrDtbspYk7WPWToaDTzbRcGM8puyOY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-SCv9Uoq5NyCz1HrEUckpcg-1; Mon,
 24 Jun 2024 09:09:01 -0400
X-MC-Unique: SCv9Uoq5NyCz1HrEUckpcg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A7F519560B5;
	Mon, 24 Jun 2024 13:09:00 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB7B51956087;
	Mon, 24 Jun 2024 13:08:56 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH 09/11] perf testsuite report: Add test for perf-report basic functionality
Date: Mon, 24 Jun 2024 15:08:07 +0200
Message-Id: <20240624130809.1612-10-mpetlan@redhat.com>
In-Reply-To: <20240624130809.1612-1-mpetlan@redhat.com>
References: <20240624130809.1612-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

From: Veronika Molnarova <vmolnaro@redhat.com>

Test basic execution and some options of perf-report subcommand, like
show-nr-samples, header, showcpuutilization, pid and symbol filtering.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/base_report/setup.sh   |  32 +++
 .../shell/base_report/stderr-whitelist.txt    |   5 +
 .../tests/shell/base_report/test_basic.sh     | 190 ++++++++++++++++++
 tools/perf/tests/shell/common/settings.sh     |   2 +
 4 files changed, 229 insertions(+)
 create mode 100755 tools/perf/tests/shell/base_report/setup.sh
 create mode 100644 tools/perf/tests/shell/base_report/stderr-whitelist.txt
 create mode 100755 tools/perf/tests/shell/base_report/test_basic.sh

diff --git a/tools/perf/tests/shell/base_report/setup.sh b/tools/perf/tests/shell/base_report/setup.sh
new file mode 100755
index 000000000000..4caa496660c6
--- /dev/null
+++ b/tools/perf/tests/shell/base_report/setup.sh
@@ -0,0 +1,32 @@
+#!/bin/bash
+
+# SPDX-License-Identifier: GPL-2.0
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
+
+test -d "$HEADER_TAR_DIR" || mkdir -p "$HEADER_TAR_DIR"
+
+SW_EVENT="cpu-clock"
+
+$CMD_PERF record -asdg -e $SW_EVENT -o $CURRENT_TEST_DIR/perf.data -- $CMD_LONGER_SLEEP 2> $LOGS_DIR/setup.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_patterns_found.pl "$RE_LINE_RECORD1" "$RE_LINE_RECORD2" < $LOGS_DIR/setup.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "prepare the perf.data file"
+TEST_RESULT=$?
+
+print_overall_results $TEST_RESULT
+exit $?
diff --git a/tools/perf/tests/shell/base_report/stderr-whitelist.txt b/tools/perf/tests/shell/base_report/stderr-whitelist.txt
new file mode 100644
index 000000000000..e3341401b47c
--- /dev/null
+++ b/tools/perf/tests/shell/base_report/stderr-whitelist.txt
@@ -0,0 +1,5 @@
+no symbols found in .*, maybe install a debug package
+was updated .*is prelink enabled.+ Restart the long running apps that use it
+Warning:
+\d+ out of order events recorded.
+detected invalid bpf_prog_info
diff --git a/tools/perf/tests/shell/base_report/test_basic.sh b/tools/perf/tests/shell/base_report/test_basic.sh
new file mode 100755
index 000000000000..47677cbd4df3
--- /dev/null
+++ b/tools/perf/tests/shell/base_report/test_basic.sh
@@ -0,0 +1,190 @@
+#!/bin/bash
+
+# SPDX-License-Identifier: GPL-2.0
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
+
+TEST_RESULT=0
+
+
+### help message
+
+if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
+	# test that a help message is shown and looks reasonable
+	$CMD_PERF report --help > $LOGS_DIR/basic_helpmsg.log 2> $LOGS_DIR/basic_helpmsg.err
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-REPORT" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "OVERHEAD\s+CALCULATION" "SEE ALSO" < $LOGS_DIR/basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "input" "verbose" "show-nr-samples" "show-cpu-utilization" "threads" "comms" "pid" "tid" "dsos" "symbols" "symbol-filter" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "hide-unresolved" "sort" "fields" "parent" "exclude-other" "column-widths" "field-separator" "dump-raw-trace" "children" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "call-graph" "max-stack" "inverted" "ignore-callees" "pretty" "stdio" "tui" "gtk" "vmlinux" "kallsyms" "modules" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "force" "symfs" "cpu" "disassembler-style" "source" "asm-raw" "show-total-period" "show-info" "branch-stack" "group" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "branch-history" "objdump" "demangle" "percent-limit" "percentage" "header" "itrace" "full-source-path" "show-ref-call-graph" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_no_patterns_found.pl "No manual entry for" < $LOGS_DIR/basic_helpmsg.err
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
+REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
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
+REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER\s+\S+\s+\[kernel\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
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
+$CMD_PERF report -i $CURRENT_TEST_DIR/perf.data --stdio --header-only > $LOGS_DIR/basic_header.log
+PERF_EXIT_CODE=$?
+
+REGEX_LINE_TIMESTAMP="#\s+captured on\s*:\s*$RE_DATE_TIME"
+REGEX_LINE_HOSTNAME="#\s+hostname\s*:\s*$MY_HOSTNAME"
+REGEX_LINE_KERNEL="#\s+os release\s*:\s*${MY_KERNEL_VERSION//+/\\+}"
+REGEX_LINE_PERF="#\s+perf version\s*:\s*"
+REGEX_LINE_ARCH="#\s+arch\s*:\s*$MY_ARCH"
+REGEX_LINE_CPUS_ONLINE="#\s+nrcpus online\s*:\s*$MY_CPUS_ONLINE"
+REGEX_LINE_CPUS_AVAIL="#\s+nrcpus avail\s*:\s*$MY_CPUS_AVAILABLE"
+# disable precise check for "nrcpus avail" in BASIC runmode
+test $PERFTOOL_TESTSUITE_RUNMODE -lt $RUNMODE_STANDARD && REGEX_LINE_CPUS_AVAIL="#\s+nrcpus avail\s*:\s*$RE_NUMBER"
+../common/check_all_patterns_found.pl "$REGEX_LINE_TIMESTAMP" "$REGEX_LINE_HOSTNAME" "$REGEX_LINE_KERNEL" "$REGEX_LINE_PERF" "$REGEX_LINE_ARCH" "$REGEX_LINE_CPUS_ONLINE" "$REGEX_LINE_CPUS_AVAIL" < $LOGS_DIR/basic_header.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "header"
+(( TEST_RESULT += $? ))
+
+# '--header' and '--header-only' should use creation time
+OLD_TIMESTAMP=`$CMD_PERF report --stdio --header-only -i $CURRENT_TEST_DIR/perf.data | grep "captured on"`
+PERF_EXIT_CODE=$?
+
+( tar -C $CURRENT_TEST_DIR -c perf.data | xz > $CURRENT_TEST_DIR/perf.data.tar.xz ; xzcat $CURRENT_TEST_DIR/perf.data.tar.xz | tar x -C $HEADER_TAR_DIR )
+(( PERF_EXIT_CODE += $? ))
+
+NEW_TIMESTAMP=`$CMD_PERF report --stdio --header-only -i $HEADER_TAR_DIR/perf.data | grep "captured on"`
+(( PERF_EXIT_CODE += $? ))
+
+test "$OLD_TIMESTAMP" = "$NEW_TIMESTAMP"
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "header timestamp"
+(( TEST_RESULT += $? ))
+
+
+### show CPU utilization
+
+# '--showcpuutilization' should show percentage for both system and userspace mode
+$CMD_PERF report -i $CURRENT_TEST_DIR/perf.data --stdio --showcpuutilization > $LOGS_DIR/basic_cpuut.log 2> $LOGS_DIR/basic_cpuut.err
+PERF_EXIT_CODE=$?
+
+REGEX_LINES_HEADER="#\s*Children\s+Self\s+sys\s+usr\s+Command\s+Shared Object\s+Symbol"
+REGEX_LINES="\s*$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+$RE_NUMBER%\s+\S+\s+\[kernel\.(?:vmlinux)|(?:kallsyms)\]\s+\[[k\.]\]\s+\w+"
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
+grep -P -v '^#' $LOGS_DIR/basic_pid.log | grep -P '\s+[\d\.]+%' | ../common/check_all_lines_matched.pl "systemd|init"
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
+grep -P -v '^#' $LOGS_DIR/basic_symbolfilter.log | grep -P '\s+[\d\.]+%' | ../common/check_all_lines_matched.pl "\[[k\.]\]\s+.*map"
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
+# print overall results
+print_overall_results "$TEST_RESULT"
+exit $?
diff --git a/tools/perf/tests/shell/common/settings.sh b/tools/perf/tests/shell/common/settings.sh
index 2e50dd0bff9b..cba1b338f96f 100644
--- a/tools/perf/tests/shell/common/settings.sh
+++ b/tools/perf/tests/shell/common/settings.sh
@@ -80,12 +80,14 @@ if [ -n "$PERFSUITE_RUN_DIR" ]; then
 	export CURRENT_TEST_DIR="$PERFSUITE_RUN_DIR/$TEST_NAME"
 	export MAKE_TARGET_DIR="$CURRENT_TEST_DIR/examples"
 	export LOGS_DIR="$CURRENT_TEST_DIR/logs"
+	export HEADER_TAR_DIR="$CURRENT_TEST_DIR/header_tar"
 	test -d "$CURRENT_TEST_DIR" || mkdir -p "$CURRENT_TEST_DIR"
 	test -d "$LOGS_DIR" || mkdir -p "$LOGS_DIR"
 else
 	# when $PERFSUITE_RUN_DIR is not set, logs will be placed here
 	export CURRENT_TEST_DIR="."
 	export LOGS_DIR="."
+	export HEADER_TAR_DIR="./header_tar"
 fi
 
 
-- 
2.43.0

