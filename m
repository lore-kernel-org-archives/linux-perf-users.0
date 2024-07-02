Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03015AADA
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918837; cv=none; b=dmSMphXNyHB/uhdLxbTvNovn9OK4fShA3SlA8zeQZ4XY3rJbZunAIPpKXnrdZ8K4In3F8MgJ6rYcxlXrQ/K9xiznTXsDhGUCIbVMHU+uSqR1SJkKzjnQz5tczeytiZDpLRI0CqnRVf/oWE9o2tA5opTu8psVd3tauuQft96TNOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918837; c=relaxed/simple;
	bh=C1kXJ+ZcAVxwOSwr69TkxXN5FuRsv75kmbUfKTRZM+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRlWSyghtDoaXSPIFPju3pikXp8hgfU0teSjbYXAOiVFN/hPsG8vHAKsZd1w695mJQZQNXufkSuIWzMEPGVfVdaOf7A1Gu4bOobr4iKhkJEtXEWisC6+Cr9DOfbbFoYyTWCmw6d4EepWxqbyyD7YcUy5UWvnJLtjSVS3WOI07cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbJX47WS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbJX47WS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ORXDa04eKCHATzYDQeHAm+KBi0pkMTEFjHvt/MqeHvs=;
	b=hbJX47WSlvPM6tx9jPfI938+/tuwix+38UK5EH0Ll0wD16NgUAMRtoqKBmHr1qDhCMVJCw
	VxLQUWMk+mv9YTUbtdoKK1+5SDUSiug3TN7MtrvtlkTWRIvayAFluELmyOnJJX9EaaPV+s
	DrUyDK9PZfml2P89PIiDQWQmUGL1cv8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-0cCMipoEMdG1_kZymXcpeQ-1; Tue,
 02 Jul 2024 07:13:50 -0400
X-MC-Unique: 0cCMipoEMdG1_kZymXcpeQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AF68194510D;
	Tue,  2 Jul 2024 11:13:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 949A21956089;
	Tue,  2 Jul 2024 11:13:46 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 06/11] perf testsuite probe: Add test for invalid options
Date: Tue,  2 Jul 2024 13:08:45 +0200
Message-ID: <20240702110849.31904-8-vmolnaro@redhat.com>
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

Test if various incompatible options are correctly handled-rejected.
It is run as a part of perftool-testsuite_probe test case.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../shell/base_probe/test_invalid_options.sh  | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100755 tools/perf/tests/shell/base_probe/test_invalid_options.sh

diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
new file mode 100755
index 0000000000..1fedfd8b0d
--- /dev/null
+++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
@@ -0,0 +1,79 @@
+#!/bin/bash
+
+# SPDX-License-Identifier: GPL-2.0
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
+
+TEST_RESULT=0
+
+if ! check_kprobes_available; then
+	print_overall_skipped
+	exit 0
+fi
+
+
+### missing argument
+
+# some options require an argument
+for opt in '-a' '-d' '-L' '-V'; do
+	! $CMD_PERF probe $opt 2> $LOGS_DIR/invalid_options_missing_argument$opt.err
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "Error: switch .* requires a value" < $LOGS_DIR/invalid_options_missing_argument$opt.err
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
+	$CMD_PERF probe -F > /dev/null 2> $LOGS_DIR/invalid_options_unnecessary_argument$opt.err
+	PERF_EXIT_CODE=$?
+
+	test ! -s $LOGS_DIR/invalid_options_unnecessary_argument$opt.err
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
+test -e $LOGS_DIR/invalid_options_mutually_exclusive.log && rm -f $LOGS_DIR/invalid_options_mutually_exclusive.log
+for opt in '-a xxx -d xxx' '-a xxx -L foo' '-a xxx -V foo' '-a xxx -l' '-a xxx -F' \
+		'-d xxx -L foo' '-d xxx -V foo' '-d xxx -l' '-d xxx -F' \
+		'-L foo -V bar' '-L foo -l' '-L foo -F' '-V foo -l' '-V foo -F' '-l -F'; do
+	! $CMD_PERF probe $opt > /dev/null 2> $LOGS_DIR/aux.log
+	PERF_EXIT_CODE=$?
+
+	../common/check_all_patterns_found.pl "Error: switch .+ cannot be used with switch .+" < $LOGS_DIR/aux.log
+	CHECK_EXIT_CODE=$?
+
+	print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "mutually exclusive options :: $opt"
+	(( TEST_RESULT += $? ))
+
+	# gather the logs
+	cat $LOGS_DIR/aux.log | grep "Error" >> $LOGS_DIR/invalid_options_mutually_exclusive.log
+done
+
+
+# print overall results
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
2.43.0

