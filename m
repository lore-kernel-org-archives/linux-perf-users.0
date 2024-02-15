Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519812D76F
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Feb 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994972; cv=none; b=ZDWXP330xQ/1EfaH6HU4AbjX9QM8m19imJF38RKZl6U3xyH5XoqzBsYqnvfE2qzn5glUZQQ2JcJcSC3xHITnf4cjVdO87uQXcfkm6eiowyk5EmoWcecnvJBhbyAGayva8yZJOSg7Cs7O65QB06otYUPjb8I772EDElAtygaWCeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994972; c=relaxed/simple;
	bh=uF2YHsySeNDi0rz4G6Fhip9qbAZRdh8amglk05+MufU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BfyOFhBN755XWbgkYqSeoNak/WH9sTYwAGi/BkHZV/I61omP4F/7oaE3+uYpJNMLcNZXaoiNiXBikOQzXPEKVW21VywHfF6l/njN2m8jatAkvys0pysu07JkIL2id+Hz9cn3TXQPcngm788qMc3LVWd3AgwXuspnctOCjvuBqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N0Wo/nOy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0Wo/nOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707994970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=YSA+QL1r+oXwd1lAFTZjRfm0QMnrBE/BoylCBbUSqZE=;
	b=N0Wo/nOygsR8ZHiefGoeHksrLOWNg01DikFQ10xv7x4TsrzQyUlKvpjdOBXyGbnSq9W+7F
	BkSI4Du/2FXgOAMlK/wRxp7Ya8pYW3P9opY5O70v1wftTf2Q4oywvmOKDL5/XQAEMWjIG/
	GRLUbpPcUb03N/Ahg7B/MsEucug7nh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-yrdlgZQxOIGhilxBZIAlzA-1; Thu, 15 Feb 2024 06:02:47 -0500
X-MC-Unique: yrdlgZQxOIGhilxBZIAlzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3703A83B828;
	Thu, 15 Feb 2024 11:02:46 +0000 (UTC)
Received: from Diego.redhat.com (unknown [10.39.208.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 704E42166AE1;
	Thu, 15 Feb 2024 11:02:43 +0000 (UTC)
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
Subject: [PATCH v2 3/7] perf testsuite: Add initialization script for shell tests
Date: Thu, 15 Feb 2024 12:02:27 +0100
Message-Id: <20240215110231.15385-4-mpetlan@redhat.com>
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

Initialize reporting and logging functions that unifies formatting
of the test output used for shell tests.

Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
Signed-off-by: Michael Petlan <mpetlan@redhat.com>
---
 tools/perf/tests/shell/common/init.sh | 117 ++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 tools/perf/tests/shell/common/init.sh

diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
new file mode 100644
index 000000000000..aadeaf782e03
--- /dev/null
+++ b/tools/perf/tests/shell/common/init.sh
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: GPL-2.0
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
+
+print_warning()
+{
+	WARN_COMMENT="$@"
+	_echo "$MWARN-- [ WARN ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $WARN_COMMENT"
+	return 0
+}
+
+# this function should skip a testcase if the testsuite is not run in
+# a runmode that fits the testcase --> if the suite runs in BASIC mode
+# all STANDARD and EXPERIMENTAL testcases will be skipped; if the suite
+# runs in STANDARD mode, all EXPERIMENTAL testcases will be skipped and
+# if the suite runs in EXPERIMENTAL mode, nothing is skipped
+consider_skipping()
+{
+	TESTCASE_RUNMODE="$1"
+	# the runmode of a testcase needs to be at least the current suite's runmode
+	if [ $PERFTOOL_TESTSUITE_RUNMODE -lt $TESTCASE_RUNMODE ]; then
+		print_overall_skipped
+		exit 0
+	fi
+}
+
+detect_baremetal()
+{
+	# return values:
+	# 0 = bare metal
+	# 1 = virtualization detected
+	# 2 = unknown state
+	VIRT=`systemd-detect-virt 2>/dev/null`
+	test $? -eq 127 && return 2
+	test "$VIRT" = "none"
+}
+
+detect_intel()
+{
+	# return values:
+	# 0 = is Intel
+	# 1 = is not Intel or unknown
+	grep "vendor_id" < /proc/cpuinfo | grep -q "GenuineIntel"
+}
+
+detect_amd()
+{
+	# return values:
+	# 0 = is AMD
+	# 1 = is not AMD or unknown
+	grep "vendor_id" < /proc/cpuinfo | grep -q "AMD"
+}
-- 
2.43.0

