Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD413D600
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234532; cv=none; b=W0aKJWvwc0s2eGzyRJm1F+kJAi+bakK8NtnbeALwYNMTrMVcmv8q5QFX3ol5XuKWIv9xJL7s+6hxH+TIW6Swy/fN2x2xgVU4YzRAPJ6Ef1flqKn5b0CbXOiE7c1yYepv6ZcGiT7/H3pIV4Eb4LMKLC6zIgmJdeX9uIZ75JOeXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234532; c=relaxed/simple;
	bh=Ib0ASa6/svFYnhBNqfCht8mSttUAH1DsYhHGzcPC/sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hRb8lmGoJu/uXklDA5MViUfwRDXbuKluKtmMYJE3jVqVVMKQ3hkwTMl5/hfsteFkVWOXtu62n1RdcKxN1P5koZwsZ3KoRHOHvwQPx3QBMFkv7kxIw/2uRTTA8HW3Qdz8WnpOH073IRylc1v1traLQm8peM5huw97vO7UMSIcGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUfCf4jo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUfCf4jo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=tQCOEfx9EQj0HuL3pFsmgUmPYanTsemBahn60gx6AFQ=;
	b=UUfCf4joCOJq5uhiOom3NNwsvnipH3akEWloKmuQnRrwT1ScjR3OAF4/p4PKpxnGY3/lAo
	G+P/xzS50jw+EKVHWQRoFTHhh07fl1Kwr0IT++tICAPxKJaAD2LiKsZblIF7lr1AepmorH
	cRm3CdZumKYsOMbTzcDIODZikkgbvTw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-l3VMb2rFNvSdDWWUanUsBQ-1; Mon,
 24 Jun 2024 09:08:47 -0400
X-MC-Unique: l3VMb2rFNvSdDWWUanUsBQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA2C619560AB;
	Mon, 24 Jun 2024 13:08:45 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5AECA1956087;
	Mon, 24 Jun 2024 13:08:41 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH 05/11] perf testsuite probe: Add test for basic perf-probe options
Date: Mon, 24 Jun 2024 15:08:03 +0200
Message-Id: <20240624130809.1612-6-mpetlan@redhat.com>
In-Reply-To: <20240624130809.1612-1-mpetlan@redhat.com>
References: <20240624130809.1612-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

From: Veronika Molnarova <vmolnaro@redhat.com>

Test basic behavior of perf-probe subcommand. It is run as a part of
perftool-testsuite_probe test case.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../perf/tests/shell/base_probe/test_basic.sh | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100755 tools/perf/tests/shell/base_probe/test_basic.sh

diff --git a/tools/perf/tests/shell/base_probe/test_basic.sh b/tools/perf/tests/shell/base_probe/test_basic.sh
new file mode 100755
index 000000000000..09669ec479f2
--- /dev/null
+++ b/tools/perf/tests/shell/base_probe/test_basic.sh
@@ -0,0 +1,80 @@
+#!/bin/bash
+
+# SPDX-License-Identifier: GPL-2.0
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
+
+TEST_RESULT=0
+
+if ! check_kprobes_available; then
+	print_overall_skipped
+	exit 0
+fi
+
+
+### help message
+
+if [ "$PARAM_GENERAL_HELP_TEXT_CHECK" = "y" ]; then
+	# test that a help message is shown and looks reasonable
+	$CMD_PERF probe --help > $LOGS_DIR/basic_helpmsg.log 2> $LOGS_DIR/basic_helpmsg.err
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "PERF-PROBE" "NAME" "SYNOPSIS" "DESCRIPTION" "OPTIONS" "PROBE\s+SYNTAX" "PROBE\s+ARGUMENT" "LINE\s+SYNTAX" < $LOGS_DIR/basic_helpmsg.log
+	CHECK_EXIT_CODE=$?
+	../common/check_all_patterns_found.pl "LAZY\s+MATCHING" "FILTER\s+PATTERN" "EXAMPLES" "SEE\s+ALSO" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "vmlinux" "module=" "source=" "verbose" "quiet" "add=" "del=" "list.*EVENT" "line=" "vars=" "externs" < $LOGS_DIR/basic_helpmsg.log
+	(( CHECK_EXIT_CODE += $? ))
+	../common/check_all_patterns_found.pl "no-inlines" "funcs.*FILTER" "filter=FILTER" "force" "dry-run" "max-probes" "exec=" "demangle-kernel" < $LOGS_DIR/basic_helpmsg.log
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
+### usage message
+
+# without any args perf-probe should print usage
+$CMD_PERF probe 2> $LOGS_DIR/basic_usage.log > /dev/null
+
+../common/check_all_patterns_found.pl "[Uu]sage" "perf probe" "verbose" "quiet" "add" "del" "force" "line" "vars" "externs" "range" < $LOGS_DIR/basic_usage.log
+CHECK_EXIT_CODE=$?
+
+print_results 0 $CHECK_EXIT_CODE "usage message"
+(( TEST_RESULT += $? ))
+
+
+### quiet switch
+
+# '--quiet' should mute all output
+$CMD_PERF probe --quiet --add vfs_read > $LOGS_DIR/basic_quiet01.log 2> $LOGS_DIR/basic_quiet01.err
+PERF_EXIT_CODE=$?
+$CMD_PERF probe --quiet --del vfs_read > $LOGS_DIR/basic_quiet03.log 2> $LOGS_DIR/basic_quiet02.err
+(( PERF_EXIT_CODE += $? ))
+
+test "`cat $LOGS_DIR/basic_quiet*log $LOGS_DIR/basic_quiet*err | wc -l`" -eq 0
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "quiet switch"
+(( TEST_RESULT += $? ))
+
+
+# print overall results
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
2.43.0

