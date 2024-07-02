Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A615AAC1
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918830; cv=none; b=MsU547rdSDROk0TUjZd4MbDcHGWrzT6pcfSO/lCY+OX5ukt0gfTnEu9ETji9EDaEAh1R5RH7ulbZNO++IH7w/UjRe7KON3AJmCj/OaECryysSEgH0yZPWb+CcJhsTOt6gWYCkidupTY6roOgD9sTKGX1fOkbgZnsgCp+chAl5no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918830; c=relaxed/simple;
	bh=MJMIVYBFsaJvJkjRB0PG2pLsgc6U4KwJEWer24/ssvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMjfcoAJVw7PMOMRs+Pn85WSh97yTRZWXeJz3R267NA3FrI5p9BeMT4xLkYc57W/zlZ7oTrvrsbO8aTFUoE9e0Zxb+AVAbHX0L2+t5PdKJ5nqSEurB7oLfjaJzEvLlOmMA1+IOqEskjt6QFIizVERdM3FnSRbrby2YpEMgJrqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVl5g9pb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVl5g9pb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWQ/aGCTj7YLAnh5GJTt/GiOLYB6/JfwZ0/YwjnOaIk=;
	b=AVl5g9pb9BBISPcJZHVMxlHNTCeqsN8opeEnkHA34Y1LhDiMiSAhCw5Cq0tt8htjXFErpA
	HP5LROiIeYL73A8d+l+1v1I6jwZCTbs73WotKfUzDzuZ8o4rTCyWj4qG2d8nOAXtLiLUXG
	VZp5A2N8wndfYU2jnhTNm03cUOmlDpg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-OK_-oBB5PZqBv1yR3liDFA-1; Tue,
 02 Jul 2024 07:13:44 -0400
X-MC-Unique: OK_-oBB5PZqBv1yR3liDFA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C656419560B2;
	Tue,  2 Jul 2024 11:13:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCEEB1956089;
	Tue,  2 Jul 2024 11:13:39 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 04/11] perf testsuite probe: Add test for blacklisted kprobes handling
Date: Tue,  2 Jul 2024 13:08:43 +0200
Message-ID: <20240702110849.31904-6-vmolnaro@redhat.com>
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

Test perf probe interface. Blacklisted functions should be rejected
when there is an attempt to set a kprobe to them.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../base_probe/test_adding_blacklisted.sh     | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100755 tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh

diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
new file mode 100755
index 0000000000..b5dc10b2a7
--- /dev/null
+++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
@@ -0,0 +1,67 @@
+#!/bin/bash
+
+# SPDX-License-Identifier: GPL-2.0
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
+
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
+! $CMD_PERF probe $BLACKFUNC > $LOGS_DIR/adding_blacklisted.log 2> $LOGS_DIR/adding_blacklisted.err
+PERF_EXIT_CODE=$?
+
+REGEX_SCOPE_FAIL="Failed to find scope of probe point"
+REGEX_SKIP_MESSAGE=" is blacklisted function, skip it\."
+REGEX_NOT_FOUND_MESSAGE="Probe point \'$BLACKFUNC\' not found."
+REGEX_ERROR_MESSAGE="Error: Failed to add events."
+REGEX_INVALID_ARGUMENT="Failed to write event: Invalid argument"
+REGEX_SYMBOL_FAIL="Failed to find symbol at $RE_ADDRESS"
+REGEX_OUT_SECTION="$BLACKFUNC is out of \.\w+, skip it"
+../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
+(( TEST_RESULT += $? ))
+
+
+### listing not-added probe
+
+# blacklisted probes should NOT appear in perf-list output
+$CMD_PERF list probe:\* > $LOGS_DIR/adding_blacklisted_list.log
+PERF_EXIT_CODE=$?
+
+../common/check_all_lines_matched.pl "$RE_LINE_EMPTY" "List of pre-defined events" "Metric Groups:" < $LOGS_DIR/adding_blacklisted_list.log
+CHECK_EXIT_CODE=$?
+
+print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "listing blacklisted probe (should NOT be listed)"
+(( TEST_RESULT += $? ))
+
+
+# print overall results
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
2.43.0

