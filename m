Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319C015AADA
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 11:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918839; cv=none; b=JlY6CKJuWG8DfvFX9dMw2RpOIEm+l2++LyRWt7J44dxRjiOhQH9iILDtp0LZn2u1OufDIPQlm140R6uhhj8asSXPKAC8C88AhepIqJmEMgGdI2WRqYmlZEyIQfakh5q0tzM1zwOHaswb7qbv38TbUArffxLg7FZdqRpYHg1TdQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918839; c=relaxed/simple;
	bh=PrL25RUebW6jn8SHJKggslFKwJna0//mlvG5/8aap+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djyRJbMuhyO6lyu6iPW4xh2HBOGJ5d+op0ezzYBjmfz+MI0P8/N0zRzsRVsKpqzCjtggsMAdvpY9swTq9VxsI5c9IxdrTDezeTL031Gxy+Z+bdaiFiwUVbtF1dXUa4tUzQ9P1PWwyip69yaaUKBQT7q8A2TAIaSb3hJ1qza2Dw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhS7oLGw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhS7oLGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719918837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1G3WywszQ1D1m0NDutCN4kxCqdhaAVnfeCGtxORVbJk=;
	b=QhS7oLGw6QVLXiaMfWF++hwl7LsOdRd9xbKaX4XEgNvDOFJih497hlNySXn8YRHK8L7mbQ
	5ZDWFgVDQp7i90enI87F9hE0kAGgQYIctQPQ9xfUzo64FM9MMOE08PafDyoBGDwKkq66K+
	9xK+/Sw3woXniW98lT5C2aCFeCCpmcE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-QA_90NaLMQWjCO0RWZL3HA-1; Tue,
 02 Jul 2024 07:13:54 -0400
X-MC-Unique: QA_90NaLMQWjCO0RWZL3HA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A1831977300;
	Tue,  2 Jul 2024 11:13:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.179])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A31BE1956089;
	Tue,  2 Jul 2024 11:13:49 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@redhat.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	mpetlan@redhat.com,
	irogers@google.com,
	atrajeev@linux.vnet.ibm.com,
	masami.hiramatsu.pt@hitachi.com
Subject: [PATCH v2 07/11] perf testsuite probe: Add test for line semantics
Date: Tue,  2 Jul 2024 13:08:46 +0200
Message-ID: <20240702110849.31904-9-vmolnaro@redhat.com>
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
index 0000000000..d8f4bde0f5
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

