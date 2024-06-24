Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02C13D52F
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234529; cv=none; b=MTN/yY1qHOsrSV+0MM8VjQNLPEsp8cb6eDAOO0oqfXLsi3o7+kw+5Khp6QZel8/R0vcJS9XhKUyn8wuiHFHLbzXrkgvuNuBs/927xwOACiBSPxQ1/foinp1TrKfbh6QtBsl50VKgcKNK3FOz1w+oDh3VQk81Gxgk/MdPWulAKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234529; c=relaxed/simple;
	bh=9oPTwnban7OgMI5L5+T0rkmS2hWbN6oH4XMubK/XgRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=m/uwhfg5VDWEp63cGOEir91+JH7E4rY3hXSvYc4UoOxJrRx/W3l5TL3KkQPRvyGcHyIY/mV2+5evskAEcE6/CQAbEzMULCwqzBwCCpeiglw1ejp+eJ09HGy7mxDWeDG1u0U1VdwypqIcncONhIadt72pcVeQqwflxkSbvGStPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NE/xLYtN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NE/xLYtN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=b5JtwStAUJUFCt62lM+PdOVKC0YAYa7F6NLwZq77M3E=;
	b=NE/xLYtNGE3Tg4xbPrJIr9phxiIZ6XtYiecoYzboTBwSYL+CGNAljCPwC9VLbHFgpxXtE6
	Wl9jrVOYt+UHzW9Fcrf3wkYc40ZDU5GJh0suQOCMX4lSfQ4T+WWB+ScFQUggtNzmThNHWl
	TTYY/EKKsPvmiEowHmpzQ8Q/XYwiL7Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-YgF-lknMOcq8BqO2oAX0_w-1; Mon,
 24 Jun 2024 09:08:42 -0400
X-MC-Unique: YgF-lknMOcq8BqO2oAX0_w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAA5D1956088;
	Mon, 24 Jun 2024 13:08:40 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DAB21956087;
	Mon, 24 Jun 2024 13:08:37 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH 04/11] perf testsuite probe: Add test for blacklisted kprobes handling
Date: Mon, 24 Jun 2024 15:08:02 +0200
Message-Id: <20240624130809.1612-5-mpetlan@redhat.com>
In-Reply-To: <20240624130809.1612-1-mpetlan@redhat.com>
References: <20240624130809.1612-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

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
index 000000000000..b5dc10b2a738
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

