Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3BE443AB3
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061653; cv=none; b=tBbXW0/cgFGrmXEXjmdf89B+7IznzHCVWsEw/j70hVLH36tAaOgcpzO9aXkwbh4M7udTPgakeLfvSUd95yGXZxLcSgW7a8xs2lQdaXOxbEpMO/IqYLqma6U4dX3kAIaJ9suPGi8bGUrw8dwoGVy8R3iP9BD3ruC0SKOq7sL4Mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061653; c=relaxed/simple;
	bh=N1ITHw9IuuACEAzEy4GsnhbB3Zq0mCBxTqz7r/yzlDY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PCYoQa1EhjQzzjt2LD3QdFk+FDCclB0golAF+6DhwNYOQSncMUdf3SKDEhoByeEdojqynBzc1itQcVzVJTKp4uthih7uxI7SDyzh+bUhrKQYGrWnSmCGZ43QFktdv4B/LaDjEpWrJ6as51kK3JQXseJgjnwt0Qt6eRee+BKQg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a5e5Uxaf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5e5Uxaf"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84a06bc82easo4641618b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 13:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784061650; x=1784666450; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+DL9iA3z00zgK08WsS/7y0/p3XsdvNlrnG8JH+ehPQ=;
        b=a5e5UxafiSPEBkr0qMJCw8j5j+QbWUP3ow7kJvR5RioUzVJ90a6A8cTauCfND1X0RI
         ktnLqSQpbvmvWdMQlaRL4bXowt2BcefNPfiaeGzNQMokR42SQkEtXD2dlPhpI987DMmC
         mawK+MCbtMeNdE1sXNw+KDyHCpMCzFn0m+RYtlXhPIVKAJt+ZTUAdhatJABGneoNtQEr
         BVKdRMVumPzwZ7j9JVpPxQfRFNX9FZMsTIcQQ0HKHVXC+JwBfqRefAWx8sUmEs/1cbdK
         ftKJWaGLbpyWvODwZkMf/0BBpBDSI+TxgGMJWNDzwWjukjdQ/Fa1c7tDoclPhF8GDWpl
         qDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061650; x=1784666450;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r+DL9iA3z00zgK08WsS/7y0/p3XsdvNlrnG8JH+ehPQ=;
        b=S3wzVo2LfGZmOu90DbKz/IlXw1EWOrLLpWV17IBNAES7236DuBF53s1aMAQNzIrTQp
         YCpiIXKIRkLD4dDW9YDZUXh4Rhyn/65RtnbWGUj2M8e9uAp0NOA1NIMfTumIyj+JMxmN
         bV5O41tE6KaD8ne+7InAI8Z6el2P8rQfNycguu3At+sszeWG1dIiKDxhc6PNTmjDcKM0
         3/QRm0QXHYITh6uQg5oVQWk1gj3cE46cBuGI//Ya/CEYt0pWX48tbsR2Gt8OBX+AQJBF
         AWSMFKGK8esCIwP/0i9cpnn9B5jTlXn+ao+hKaGX1FKItkj5+56hg8zcJIPyQSm9vH6f
         v2cw==
X-Forwarded-Encrypted: i=1; AHgh+RplzOC4q3rzM01VelBm9IRB24A/gBVdCTqhZNsKPyU/v8j36ilOGNpYgH9QEZ+PbfHkfLQsNDKFv9gpDLRyaLEz@vger.kernel.org
X-Gm-Message-State: AOJu0YzOG44+cQ2Ag94MR65qnWBqsKu71ypJDj7xYERxE9h9PQiEhRpB
	X8GuMbxy7FGdu8NbfuG0BWrPTo7de/8WHdZMGQ28B+FdaC4lJlhRoufFxbI19x81LSWN/U9tg87
	g5uQSDg==
X-Received: from pfbmb17.prod.google.com ([2002:a05:6a00:7611:b0:84a:3df4:fa1])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4205:b0:847:8b0f:2508
 with SMTP id d2e1a72fcca58-84a554fa616mr3894328b3a.13.1784061649657; Tue, 14
 Jul 2026 13:40:49 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:35 -0700
In-Reply-To: <20260714204044.1952031-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714204044.1952031-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714204044.1952031-5-ctshao@google.com>
Subject: [PATCH v2 04/12] perf vendor events intel: Update clearwaterforest
 events from 1.02 to 1.04
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/13983cd535d18b2bfd86a3b9daa374039f78a836

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../arch/x86/clearwaterforest/memory.json     | 33 +++++++++++++++++++
 .../arch/x86/clearwaterforest/pipeline.json   | 19 +++++++++++
 .../clearwaterforest/uncore-interconnect.json | 10 ++++++
 .../x86/clearwaterforest/uncore-memory.json   |  2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
index ae9095a090e5..477c06a561bb 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
@@ -91,6 +91,17 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied by DRAM.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7BC000001",
+        "PublicDescription": "Counts demand data reads that were supplied by DRAM. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -102,6 +113,28 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied by DRAM attached to this socket.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x784000001",
+        "PublicDescription": "Counts demand data reads that were supplied by DRAM attached to this socket. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied by DRAM attached to another socket.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730000001",
+        "PublicDescription": "Counts demand data reads that were supplied by DRAM attached to another socket. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) requests and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
index 3d10dcffb8fc..f73686174af9 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
@@ -291,6 +291,25 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x50"
     },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alias to BR_MISP_RETIRED.NEAR_RETURN]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_RET",
+        "PublicDescription": "This event is deprecated. [This event is alias to BR_MISP_RETIRED.NEAR_RETURN] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near RET branch instructions retired. [This event is alias to BR_MISP_RETIRED.NEAR_RET]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_RETURN",
+        "PublicDescription": "Counts the number of mispredicted near RET branch instructions retired. [This event is alias to BR_MISP_RETIRED.NEAR_RET] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD]",
         "Counter": "Fixed counter 1",
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json
index 251e5d20fefe..1f6e0970141a 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json
@@ -814,6 +814,16 @@
         "PerPkg": "1",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Cache Inserts of Write Transactions as Secondary",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.2ND_WR_INSERT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-memory.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-memory.json
index 8184c2b6b861..cae7d0f6c34d 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-memory.json
@@ -520,7 +520,7 @@
         "Unit": "IMC"
     },
     {
-        "BriefDescription": "DRAM Precharge commands. : Precharge due to (?) : Counts the number of DRAM Precharge commands sent on this channel.",
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to page table : Counts the number of DRAM Precharge commands sent on this channel.",
         "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "UNC_M_PRE_COUNT.PGT",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 7160ff89dac4..554ce716d402 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -7,7 +7,7 @@ GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
 GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
-GenuineIntel-6-DD,v1.02,clearwaterforest,core
+GenuineIntel-6-DD,v1.04,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.24,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
-- 
2.55.0.141.g00534a21ce-goog

