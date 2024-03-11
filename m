Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB510A29
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Mar 2024 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710145002; cv=none; b=aLMOvOObYSQMtfLOCxju0ySPE+LMsEBYMTbXofvBqp2vS3LcHaeL5Ekm6MCO9UydzgiyQsDqp5FSJ7nW3M5zEvhfoOFNKro3e96DGT7TyvoszhEr75A+8od6Pzbym5/0yD9YmQChGY8WSKuV0wS7HFORA4F5Drf809kK3QWW8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710145002; c=relaxed/simple;
	bh=54m/jQKgptoWAP6b4HWxpu8G/nuiGLMAs5lLpBMHsok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hg1i2PfvECRIBT+b2xsWTA8xb+7GUID7buhK2PXHHqL6jwK6cSuE5Bt1XQ4z02OkHZlX64tLRuOwTb6IJJa0W3WcqMDlP825dV4M64J9a5ybTFl/CACqanedbXilLlFh+1y5oe0J7jeTwTGZaOZgxoLONHWIuKiMaQFDlK5//SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G3G6MsKu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3G6MsKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710144999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b46ScBDpSgBmqZlR45fFVTq6OQ2KUgO/QN0N8fB+hqY=;
	b=G3G6MsKu7kUwF0uAgg2kN4Np/Gc6DDztnnzIPLBh0brVyaceXnbhSjyLpxiNfaCdmG4iuB
	e9ui5o490u/m2gMCsQUpUPn7a53Rho3egfCCACBh7/4A3zHt7y9mzI+r6YbCPyGSYaSZx9
	F77gxonkqMgLu62z33xPDu+hdjwt4pE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-vMbPORChMvKJDV8kEvwYJA-1; Mon, 11 Mar 2024 04:16:35 -0400
X-MC-Unique: vMbPORChMvKJDV8kEvwYJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DE58858DB3;
	Mon, 11 Mar 2024 08:16:35 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.214])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B1C502166AE4;
	Mon, 11 Mar 2024 08:16:33 +0000 (UTC)
From: vmolnaro@redhat.com
To: linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	acme@redhat.com
Cc: mpetlan@redhat.com,
	irogers@google.com
Subject: [PATCH] perf test attr: Add back missing topdown events
Date: Mon, 11 Mar 2024 09:16:11 +0100
Message-ID: <20240311081611.7835-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Veronika Molnarova <vmolnaro@redhat.com>

With the patch 0b6c5371c03c "Add missing topdown metrics events" eight
topdown metric events with numbers ranging from 0x8000 to 0x8700 were
added to the test since they were added as 'perf stat' default events.
Later the patch 951efb9976ce "Update no event/metric expectations" kept
only 4 of those events(0x8000-0x8300).

Currently, the topdown events with numbers 0x8400 to 0x8700 are missing
from the list of expected events resulting in a failure. Add back the
missing topdown events.

Fixes: 951efb9976ce ("perf test attr: Update no event/metric expectations")
Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
---
 tools/perf/tests/attr/test-stat-default    |  90 ++++++++++----
 tools/perf/tests/attr/test-stat-detailed-1 | 106 +++++++++++-----
 tools/perf/tests/attr/test-stat-detailed-2 | 130 ++++++++++++-------
 tools/perf/tests/attr/test-stat-detailed-3 | 138 ++++++++++++++-------
 4 files changed, 320 insertions(+), 144 deletions(-)

diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tests/attr/test-stat-default
index a1e2da0a9a6d..e47fb4944679 100644
--- a/tools/perf/tests/attr/test-stat-default
+++ b/tools/perf/tests/attr/test-stat-default
@@ -88,98 +88,142 @@ enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
+# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
 [event13:base-stat]
 fd=13
 group_fd=11
 type=4
-config=33280
+config=33024
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-be-bound (0x8300)
+# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
 [event14:base-stat]
 fd=14
 group_fd=11
 type=4
-config=33536
+config=33280
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
+# PERF_TYPE_RAW / topdown-be-bound (0x8300)
 [event15:base-stat]
 fd=15
 group_fd=11
 type=4
-config=33024
+config=33536
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
+# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
 [event16:base-stat]
 fd=16
+group_fd=11
 type=4
-config=4109
+config=33792
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
+# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
 [event17:base-stat]
 fd=17
+group_fd=11
 type=4
-config=17039629
+config=34048
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
+# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
 [event18:base-stat]
 fd=18
+group_fd=11
 type=4
-config=60
+config=34304
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
+# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
 [event19:base-stat]
 fd=19
+group_fd=11
 type=4
-config=2097421
+config=34560
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
+# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
 [event20:base-stat]
 fd=20
 type=4
-config=316
+config=4109
 optional=1
 
-# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
+# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
 [event21:base-stat]
 fd=21
 type=4
-config=412
+config=17039629
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
 [event22:base-stat]
 fd=22
 type=4
-config=572
+config=60
 optional=1
 
-# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
+# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
 [event23:base-stat]
 fd=23
 type=4
-config=706
+config=2097421
 optional=1
 
-# PERF_TYPE_RAW / UOPS_ISSUED.ANY
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
 [event24:base-stat]
 fd=24
 type=4
+config=316
+optional=1
+
+# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
+[event25:base-stat]
+fd=25
+type=4
+config=412
+optional=1
+
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
+[event26:base-stat]
+fd=26
+type=4
+config=572
+optional=1
+
+# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
+[event27:base-stat]
+fd=27
+type=4
+config=706
+optional=1
+
+# PERF_TYPE_RAW / UOPS_ISSUED.ANY
+[event28:base-stat]
+fd=28
+type=4
 config=270
 optional=1
diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/tests/attr/test-stat-detailed-1
index 1c52cb05c900..3d500d3e0c5c 100644
--- a/tools/perf/tests/attr/test-stat-detailed-1
+++ b/tools/perf/tests/attr/test-stat-detailed-1
@@ -90,99 +90,143 @@ enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
+# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
 [event13:base-stat]
 fd=13
 group_fd=11
 type=4
-config=33280
+config=33024
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-be-bound (0x8300)
+# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
 [event14:base-stat]
 fd=14
 group_fd=11
 type=4
-config=33536
+config=33280
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
+# PERF_TYPE_RAW / topdown-be-bound (0x8300)
 [event15:base-stat]
 fd=15
 group_fd=11
 type=4
-config=33024
+config=33536
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
+# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
 [event16:base-stat]
 fd=16
+group_fd=11
 type=4
-config=4109
+config=33792
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
+# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
 [event17:base-stat]
 fd=17
+group_fd=11
 type=4
-config=17039629
+config=34048
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
+# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
 [event18:base-stat]
 fd=18
+group_fd=11
 type=4
-config=60
+config=34304
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
+# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
 [event19:base-stat]
 fd=19
+group_fd=11
 type=4
-config=2097421
+config=34560
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
+# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
 [event20:base-stat]
 fd=20
 type=4
-config=316
+config=4109
 optional=1
 
-# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
+# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
 [event21:base-stat]
 fd=21
 type=4
-config=412
+config=17039629
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
 [event22:base-stat]
 fd=22
 type=4
-config=572
+config=60
 optional=1
 
-# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
+# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
 [event23:base-stat]
 fd=23
 type=4
-config=706
+config=2097421
 optional=1
 
-# PERF_TYPE_RAW / UOPS_ISSUED.ANY
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
 [event24:base-stat]
 fd=24
 type=4
+config=316
+optional=1
+
+# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
+[event25:base-stat]
+fd=25
+type=4
+config=412
+optional=1
+
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
+[event26:base-stat]
+fd=26
+type=4
+config=572
+optional=1
+
+# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
+[event27:base-stat]
+fd=27
+type=4
+config=706
+optional=1
+
+# PERF_TYPE_RAW / UOPS_ISSUED.ANY
+[event28:base-stat]
+fd=28
+type=4
 config=270
 optional=1
 
@@ -190,8 +234,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event25:base-stat]
-fd=25
+[event29:base-stat]
+fd=29
 type=3
 config=0
 optional=1
@@ -200,8 +244,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event26:base-stat]
-fd=26
+[event30:base-stat]
+fd=30
 type=3
 config=65536
 optional=1
@@ -210,8 +254,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event27:base-stat]
-fd=27
+[event31:base-stat]
+fd=31
 type=3
 config=2
 optional=1
@@ -220,8 +264,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event28:base-stat]
-fd=28
+[event32:base-stat]
+fd=32
 type=3
 config=65538
 optional=1
diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/tests/attr/test-stat-detailed-2
index 7e961d24a885..01777a63752f 100644
--- a/tools/perf/tests/attr/test-stat-detailed-2
+++ b/tools/perf/tests/attr/test-stat-detailed-2
@@ -90,99 +90,143 @@ enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
+# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
 [event13:base-stat]
 fd=13
 group_fd=11
 type=4
-config=33280
+config=33024
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-be-bound (0x8300)
+# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
 [event14:base-stat]
 fd=14
 group_fd=11
 type=4
-config=33536
+config=33280
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
+# PERF_TYPE_RAW / topdown-be-bound (0x8300)
 [event15:base-stat]
 fd=15
 group_fd=11
 type=4
-config=33024
+config=33536
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
+# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
 [event16:base-stat]
 fd=16
+group_fd=11
 type=4
-config=4109
+config=33792
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
+# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
 [event17:base-stat]
 fd=17
+group_fd=11
 type=4
-config=17039629
+config=34048
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
+# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
 [event18:base-stat]
 fd=18
+group_fd=11
 type=4
-config=60
+config=34304
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
+# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
 [event19:base-stat]
 fd=19
+group_fd=11
 type=4
-config=2097421
+config=34560
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
+# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
 [event20:base-stat]
 fd=20
 type=4
-config=316
+config=4109
 optional=1
 
-# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
+# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
 [event21:base-stat]
 fd=21
 type=4
-config=412
+config=17039629
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
 [event22:base-stat]
 fd=22
 type=4
-config=572
+config=60
 optional=1
 
-# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
+# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
 [event23:base-stat]
 fd=23
 type=4
-config=706
+config=2097421
 optional=1
 
-# PERF_TYPE_RAW / UOPS_ISSUED.ANY
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
 [event24:base-stat]
 fd=24
 type=4
+config=316
+optional=1
+
+# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
+[event25:base-stat]
+fd=25
+type=4
+config=412
+optional=1
+
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
+[event26:base-stat]
+fd=26
+type=4
+config=572
+optional=1
+
+# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
+[event27:base-stat]
+fd=27
+type=4
+config=706
+optional=1
+
+# PERF_TYPE_RAW / UOPS_ISSUED.ANY
+[event28:base-stat]
+fd=28
+type=4
 config=270
 optional=1
 
@@ -190,8 +234,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event25:base-stat]
-fd=25
+[event29:base-stat]
+fd=29
 type=3
 config=0
 optional=1
@@ -200,8 +244,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event26:base-stat]
-fd=26
+[event30:base-stat]
+fd=30
 type=3
 config=65536
 optional=1
@@ -210,8 +254,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event27:base-stat]
-fd=27
+[event31:base-stat]
+fd=31
 type=3
 config=2
 optional=1
@@ -220,8 +264,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event28:base-stat]
-fd=28
+[event32:base-stat]
+fd=32
 type=3
 config=65538
 optional=1
@@ -230,8 +274,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event29:base-stat]
-fd=29
+[event33:base-stat]
+fd=33
 type=3
 config=1
 optional=1
@@ -240,8 +284,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event30:base-stat]
-fd=30
+[event34:base-stat]
+fd=34
 type=3
 config=65537
 optional=1
@@ -250,8 +294,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event31:base-stat]
-fd=31
+[event35:base-stat]
+fd=35
 type=3
 config=3
 optional=1
@@ -260,8 +304,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event32:base-stat]
-fd=32
+[event36:base-stat]
+fd=36
 type=3
 config=65539
 optional=1
@@ -270,8 +314,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event33:base-stat]
-fd=33
+[event37:base-stat]
+fd=37
 type=3
 config=4
 optional=1
@@ -280,8 +324,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event34:base-stat]
-fd=34
+[event38:base-stat]
+fd=38
 type=3
 config=65540
 optional=1
diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/tests/attr/test-stat-detailed-3
index e50535f45977..8400abd7e1e4 100644
--- a/tools/perf/tests/attr/test-stat-detailed-3
+++ b/tools/perf/tests/attr/test-stat-detailed-3
@@ -90,99 +90,143 @@ enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
+# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
 [event13:base-stat]
 fd=13
 group_fd=11
 type=4
-config=33280
+config=33024
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-be-bound (0x8300)
+# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
 [event14:base-stat]
 fd=14
 group_fd=11
 type=4
-config=33536
+config=33280
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
+# PERF_TYPE_RAW / topdown-be-bound (0x8300)
 [event15:base-stat]
 fd=15
 group_fd=11
 type=4
-config=33024
+config=33536
 disabled=0
 enable_on_exec=0
 read_format=15
 optional=1
 
-# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
+# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
 [event16:base-stat]
 fd=16
+group_fd=11
 type=4
-config=4109
+config=33792
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
+# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
 [event17:base-stat]
 fd=17
+group_fd=11
 type=4
-config=17039629
+config=34048
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
+# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
 [event18:base-stat]
 fd=18
+group_fd=11
 type=4
-config=60
+config=34304
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
+# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
 [event19:base-stat]
 fd=19
+group_fd=11
 type=4
-config=2097421
+config=34560
+disabled=0
+enable_on_exec=0
+read_format=15
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
+# PERF_TYPE_RAW / INT_MISC.UOP_DROPPING
 [event20:base-stat]
 fd=20
 type=4
-config=316
+config=4109
 optional=1
 
-# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
+# PERF_TYPE_RAW / cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
 [event21:base-stat]
 fd=21
 type=4
-config=412
+config=17039629
 optional=1
 
-# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.THREAD
 [event22:base-stat]
 fd=22
 type=4
-config=572
+config=60
 optional=1
 
-# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
+# PERF_TYPE_RAW / INT_MISC.RECOVERY_CYCLES_ANY
 [event23:base-stat]
 fd=23
 type=4
-config=706
+config=2097421
 optional=1
 
-# PERF_TYPE_RAW / UOPS_ISSUED.ANY
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.REF_XCLK
 [event24:base-stat]
 fd=24
 type=4
+config=316
+optional=1
+
+# PERF_TYPE_RAW / IDQ_UOPS_NOT_DELIVERED.CORE
+[event25:base-stat]
+fd=25
+type=4
+config=412
+optional=1
+
+# PERF_TYPE_RAW / CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE
+[event26:base-stat]
+fd=26
+type=4
+config=572
+optional=1
+
+# PERF_TYPE_RAW / UOPS_RETIRED.RETIRE_SLOTS
+[event27:base-stat]
+fd=27
+type=4
+config=706
+optional=1
+
+# PERF_TYPE_RAW / UOPS_ISSUED.ANY
+[event28:base-stat]
+fd=28
+type=4
 config=270
 optional=1
 
@@ -190,8 +234,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event25:base-stat]
-fd=25
+[event29:base-stat]
+fd=29
 type=3
 config=0
 optional=1
@@ -200,8 +244,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event26:base-stat]
-fd=26
+[event30:base-stat]
+fd=30
 type=3
 config=65536
 optional=1
@@ -210,8 +254,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event27:base-stat]
-fd=27
+[event31:base-stat]
+fd=31
 type=3
 config=2
 optional=1
@@ -220,8 +264,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event28:base-stat]
-fd=28
+[event32:base-stat]
+fd=32
 type=3
 config=65538
 optional=1
@@ -230,8 +274,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event29:base-stat]
-fd=29
+[event33:base-stat]
+fd=33
 type=3
 config=1
 optional=1
@@ -240,8 +284,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event30:base-stat]
-fd=30
+[event34:base-stat]
+fd=34
 type=3
 config=65537
 optional=1
@@ -250,8 +294,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event31:base-stat]
-fd=31
+[event35:base-stat]
+fd=35
 type=3
 config=3
 optional=1
@@ -260,8 +304,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event32:base-stat]
-fd=32
+[event36:base-stat]
+fd=36
 type=3
 config=65539
 optional=1
@@ -270,8 +314,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event33:base-stat]
-fd=33
+[event37:base-stat]
+fd=37
 type=3
 config=4
 optional=1
@@ -280,8 +324,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event34:base-stat]
-fd=34
+[event38:base-stat]
+fd=38
 type=3
 config=65540
 optional=1
@@ -290,8 +334,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
-[event35:base-stat]
-fd=35
+[event39:base-stat]
+fd=39
 type=3
 config=512
 optional=1
@@ -300,8 +344,8 @@ optional=1
 #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
 # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
 # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
-[event36:base-stat]
-fd=36
+[event40:base-stat]
+fd=40
 type=3
 config=66048
 optional=1
-- 
2.43.0

