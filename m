Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E06FC3
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918847; cv=none; b=pUezDQRqFFjPcnPTUQ+ccu9ESTH45VdvEl7ckgvPAdZXk6M4YRJcZTkdeSMpQrp8Zpfw5XXg5ZJss/6g+1p1JxbFDeW/WUdGoI6U+22GLKZotXuwoGLcyVjMWIri0J6LWCtJ+uEAOnW8HbfTzqSa7Tkci5qXdnDwvF/Xr0ztlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918847; c=relaxed/simple;
	bh=N8Wrq4+dCjuPlQtK1iG6JTJkOu0XmvrI0HlF+9HcXvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1Gu7D6Z0tJMvmGnTiUw4xwpoc2OMnIKFA9q3GS86tfGn9qfNZBmBIXIkEHeoMQG0LJm6liz5bpkoIcePhAHlubVorTcDKtwOYc3R3YUX3l3Mjx1ES5LuRaFtfUimLFK0hsnafhRxXnECDkP/dq/TgTTFZnRwgBZbx2Qt1b8oRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWpvwdSO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWpvwdSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X9Jh/b3i9afcHNEsL92/nAcNZuOiPLBU9BH1ThOLoIE=;
	b=RWpvwdSOlRvpHMVlAZSpqD1OkUqJ9rn+hXqS9jTdnHaR8D/RvgxkACMoJtTdKlVTaYnsSF
	zrvNzevfpdhusd8XBO6KVPurWqIuQxdcpQYAetwo/hGY9ehIJ/9dlthwTY5ZyItzwxaUbG
	1xKOMac/NntOzwQ2nY+C9Xp8Rvw9BlU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-T45aOfrYO6iL75Xgt5PN3g-1; Tue,
 02 Jul 2024 07:14:01 -0400
X-MC-Unique: T45aOfrYO6iL75Xgt5PN3g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DA831955DA1;
	Tue,  2 Jul 2024 11:14:00 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E16E1956089;
	Tue,  2 Jul 2024 11:13:56 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 09/11] perf testsuite report: Add test for perf-report basic functionality
Date: Tue,  2 Jul 2024 13:08:48 +0200
Message-ID: <20240702110849.31904-11-vmolnaro@redhat.com>
In-Reply-To: <20240702110849.31904-1-vmolnaro@redhat.com>
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
index 0000000000..4caa496660
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
index 0000000000..e3341401b4
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
index 0000000000..47677cbd4d
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
index 2e50dd0bff..cba1b338f9 100644
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

