Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5B24887E
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758051093; cv=none; b=J+YKBuXIFwjmH+YEtTYhA0Gn/tHxjw/QC66pxvsA5xKX3XhL3fFzTcsVBEWDxIqUxzsjSS1LJfqAvgESwiXcovkI3OlYWCyMzX1qVLOZ8h7K8Q8RAlMeUWJo+85ECs4+bspx8GjU3Mk7Ajv6D3Xc20u642TIdX8sHgDU7isnOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758051093; c=relaxed/simple;
	bh=tWA9pE2c9SjTNmn7e5Z4EHT1RUVjuKEoDBEGgej/pow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IBwdRkCkSIEA76d3kTXNz/nmBPqhFC+Gn+VMtVGECTHSNy0ItWhXtK2w2+EnvICJjPYtqEKAiJ1qTLGyTkhNDURWZRdzykdLiejEGCdNIyLGbo5uvFE9j3XbOtSVarX42VuX+nc6CzZOsV0sQAQ4CKBe/CvclvVFT34WtVR8sNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwxCC4Pz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwxCC4Pz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758051090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s3Qo7UaYadSsZzeIV0ke9/VrgOysfQt5KuaaZQjIeWs=;
	b=TwxCC4PzLnKsZNmiHqlAYIBG1TW5Soba2qLOeVDCRd9Dh7PEQ5rFidmuYZ5OKBHCA7e+Wu
	1ffBMRMDTnouL503mzYPs8NVYcf8l7UdaWd9wBy+WaekA4mHI63C8I/0Gnmxquja4/vpp1
	0ljK89DVS9SqWYuPKaYgsjLF62c9b8U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-gEnYh085Op2IyK1tRhaKvw-1; Tue,
 16 Sep 2025 15:31:26 -0400
X-MC-Unique: gEnYh085Op2IyK1tRhaKvw-1
X-Mimecast-MFC-AGG-ID: gEnYh085Op2IyK1tRhaKvw_1758051084
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F281195605A;
	Tue, 16 Sep 2025 19:31:23 +0000 (UTC)
Received: from tallison-mac.rdu.redhat.com (unknown [10.13.33.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4113518003FC;
	Tue, 16 Sep 2025 19:31:21 +0000 (UTC)
From: Trevor Allison <tallison@redhat.com>
To: linux-perf-users@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	Trevor Allison <tallison@redhat.com>
Subject: [PATCH] perf test attr: Add missing int_mist.uop_dropping event to test-stat files
Date: Tue, 16 Sep 2025 15:30:46 -0400
Message-Id: <20250916193046.10054-1-tallison@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Setup struct perf-event-attr test was failing on EMR cpu because perf stat
was providing an event that was not included in the test. Type 4 Config 4269
or 10ad, int_misc.uop_dropping.

Add event type=4 config=4269 to test-stat-default and test-stat-detailed-*
files with optional=1 so EMR machines can pass test

Signed-off-by: Trevor Allison <tallison@redhat.com>
---
 tools/perf/tests/shell/attr/test-stat-default    | 7 +++++++
 tools/perf/tests/shell/attr/test-stat-detailed-1 | 7 +++++++
 tools/perf/tests/shell/attr/test-stat-detailed-2 | 7 +++++++
 tools/perf/tests/shell/attr/test-stat-detailed-3 | 7 +++++++
 4 files changed, 28 insertions(+)

diff --git a/tools/perf/tests/shell/attr/test-stat-default b/tools/perf/tests/shell/attr/test-stat-default
index e47fb4944679..8dd27c1fb661 100644
--- a/tools/perf/tests/shell/attr/test-stat-default
+++ b/tools/perf/tests/shell/attr/test-stat-default
@@ -227,3 +227,10 @@ fd=28
 type=4
 config=270
 optional=1
+
+# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
+[event29:base-stat]
+fd=29
+type=4
+config=4269
+optional=1
\ No newline at end of file
diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-1 b/tools/perf/tests/shell/attr/test-stat-detailed-1
index 3d500d3e0c5c..12a2ebf4e64a 100644
--- a/tools/perf/tests/shell/attr/test-stat-detailed-1
+++ b/tools/perf/tests/shell/attr/test-stat-detailed-1
@@ -269,3 +269,10 @@ fd=32
 type=3
 config=65538
 optional=1
+
+# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
+[event33:base-stat]
+fd=33
+type=4
+config=4269
+optional=1
\ No newline at end of file
diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-2 b/tools/perf/tests/shell/attr/test-stat-detailed-2
index 01777a63752f..66ea25b7d38f 100644
--- a/tools/perf/tests/shell/attr/test-stat-detailed-2
+++ b/tools/perf/tests/shell/attr/test-stat-detailed-2
@@ -329,3 +329,10 @@ fd=38
 type=3
 config=65540
 optional=1
+
+# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
+[event39:base-stat]
+fd=39
+type=4
+config=4269
+optional=1
\ No newline at end of file
diff --git a/tools/perf/tests/shell/attr/test-stat-detailed-3 b/tools/perf/tests/shell/attr/test-stat-detailed-3
index 8400abd7e1e4..4a27bbfb9f87 100644
--- a/tools/perf/tests/shell/attr/test-stat-detailed-3
+++ b/tools/perf/tests/shell/attr/test-stat-detailed-3
@@ -349,3 +349,10 @@ fd=40
 type=3
 config=66048
 optional=1
+
+# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
+[event41:base-stat]
+fd=41
+type=4
+config=4269
+optional=1
\ No newline at end of file
-- 
2.39.5 (Apple Git-154)

