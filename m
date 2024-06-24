Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C66213D52F
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234541; cv=none; b=WfEStNsvucr7pPFnT2SOQc+LUTO3VTqhyU+gtVzu4bMHTttfzxE9fGILfpXEtU3AAnarfo/UFRFM1gISnbV91IRJVICVa8AbfHjYldE7jrxBVz6qRZdmcUsQc038Ora6PXunIDMKYqHapUF9mbubPAY87d+fEJamqfYbEUOZLEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234541; c=relaxed/simple;
	bh=zSv3nrgT1VYKO+JNUyCmb6hwjrYPb9SY8M0DXFzyWOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Bq1cr4yundEJ91666CMUHANYQjLjBMnUhMg/8J8d8pCuAWxXZj9Fybj4JLj2dnhqIYoR4so6YFDl0RRivMkqCcuNgM3VziXL6d+p72AxO1FNpVcCXdpKw+fMpOkte7A5q//BsQROo4xf0EZhIyPakwnsfMEltGo4YYe5IBgZqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPghEJeH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPghEJeH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719234538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=bJ7m91oGs7drB4P9mLxf4yDLL7zr64IT3wn7pw1eAq0=;
	b=LPghEJeHv5+NyaOffxFPXpOmvgE/oqJKdrWVJJTeZFeDaoO4Gyl/LzzuP/A3QKuc9QNCN4
	UmYgZTVSKJLqtMBh1pi5SJhAaMaGDvQEc+EyPJFbfJKVND/gNm6JwhTm25d0djiwz0wHMl
	XQecXqWIxCmhBgRsPb3Im7rWrc5GtYU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-on6gPMaZONGY0fvNC60wOg-1; Mon,
 24 Jun 2024 09:08:54 -0400
X-MC-Unique: on6gPMaZONGY0fvNC60wOg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD00B195609F;
	Mon, 24 Jun 2024 13:08:52 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9F7371956087;
	Mon, 24 Jun 2024 13:08:49 +0000 (UTC)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH 07/11] perf testsuite probe: Add test for line semantics
Date: Mon, 24 Jun 2024 15:08:05 +0200
Message-Id: <20240624130809.1612-8-mpetlan@redhat.com>
In-Reply-To: <20240624130809.1612-1-mpetlan@redhat.com>
References: <20240624130809.1612-1-mpetlan@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

From: Veronika Molnarova <vmolnaro@redhat.com>

The perf-probe command uses a specific semantics to describe probes.
Test some patterns that are known to be both valid and invalid if
they are handled appropriately.

This test is run as a part of perftool-testsuite_probe test case.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 .../shell/base_probe/test_line_semantics.sh   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100755 tools/perf/tests/shell/base_probe/test_line_semantics.sh

diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
new file mode 100755
index 000000000000..d8f4bde0f585
--- /dev/null
+++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
@@ -0,0 +1,55 @@
+#!/bin/bash
+
+# SPDX-License-Identifier: GPL-2.0
+
+#
+#	test_line_semantics of perf_probe test
+#	Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
+#	Author: Michael Petlan <mpetlan@redhat.com>
+#
+#	Description:
+#
+#		This test checks whether the semantic errors of line option's
+#		arguments are properly reported.
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
+### acceptable --line descriptions
+
+# testing acceptance of valid patterns for the '--line' option
+VALID_PATTERNS="func func:10 func:0-10 func:2+10 func@source.c func@source.c:1 source.c:1 source.c:1+1 source.c:1-10"
+for desc in $VALID_PATTERNS; do
+	! ( $CMD_PERF probe --line $desc 2>&1 | grep -q "Semantic error" )
+	CHECK_EXIT_CODE=$?
+
+	print_results 0 $CHECK_EXIT_CODE "acceptable descriptions :: $desc"
+	(( TEST_RESULT += $? ))
+done
+
+
+### unacceptable --line descriptions
+
+# testing handling of invalid patterns for the '--line' option
+INVALID_PATTERNS="func:foo func:1-foo func:1+foo func;lazy\*pattern"
+for desc in $INVALID_PATTERNS; do
+	$CMD_PERF probe --line $desc 2>&1 | grep -q "Semantic error"
+	CHECK_EXIT_CODE=$?
+
+	print_results 0 $CHECK_EXIT_CODE "unacceptable descriptions :: $desc"
+	(( TEST_RESULT += $? ))
+done
+
+
+# print overall results
+print_overall_results "$TEST_RESULT"
+exit $?
-- 
2.43.0

