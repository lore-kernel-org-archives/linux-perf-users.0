Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FEB353A80
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966686; cv=none; b=o6gqVcQionLos1BpFkpjMSL6JxWDtMxGamR9BGLnlkFwWapLy0x7x6TM835SDBz5hZZRHtUhjhC2sIzqWzLPZAew6ZPuKwrL43fX049VW+1nWTDpOrQ/7y/FzDCUEytGKn5hGrmuhXC6HWf1g//KN99SN7tjGMYZgIHgi46J2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966686; c=relaxed/simple;
	bh=C8PnHQbqYc2ZoRZBe6tbjHRqGrDYHVNDxo97+P1Cwmg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pcj9UFXxL/ykwTdxLni6ObzQE+pXrMXW/8a1WXySUAwaC2lZ7Wg2H3B5WWAMK0g/EdAFyOU1Fmr7IgM2tJJzRhe3pFqTTdjcwG9TxRUfADOfmC5iPiCUkv6NhOG9aDyq2UgJH3oEEQd5yEKXjykEUk9oqdyVHynwZP5e0MRv7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GTm5dfTh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GTm5dfTh"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38e04a53a7aso1148622a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jul 2026 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783966684; x=1784571484; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w0amIZw6W4Yxl+v3vihCTIZm5N60SmxeUUWHL8I2Gzc=;
        b=GTm5dfTh2TtQchCCm/2HjiPBUGEJfMrkcwOCkE99E30obG99BE9knvnaxoW2NbFFKz
         oMgLIEHKtxQhOGej38gmZT5wmorJURV+bGLYovOfkVzEuFv36wFoQiEldXBdkoxAOSez
         l+qed7chaypnBQmTXy1Nb3Bs0XaZESbcvEn6ArvxglJ2lJN6LwxGeG/pY3EsQfVbYKF+
         eqOhMeNUKNSha0ePEeYUX0UMXPLBf16HSbrmqo3RXbw7RE9PHJ1JWcvWHIeCzQpSlV9d
         FYHf/2VMztTXiiOl0xafbRLLom/4zQEeomgU++oUN4ZLWQNPfbhNq2woMlK/I00FzLdQ
         HwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783966684; x=1784571484;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w0amIZw6W4Yxl+v3vihCTIZm5N60SmxeUUWHL8I2Gzc=;
        b=F47ZX/raLjZ5PBYKboITN35OuGrFTn2pz0pv0kXwfW/Wua5mKJXhmmF/lHwtmuryYe
         UzW0F0j5K4fyxO96324MbxV1zK4ytgtGajdijfjTSQxzbhnXsMks+7Hjgsarqok2knl+
         COjZeznNnfTCkRFzxFdPYQ3xLSGbFmCemEhlEt4sdxp+KTSNM0xu5DGx0dSruO3SYWzf
         wfWBmjKLI08v307g5ZiKVmynub5NQ/3XMUk2SZCptoEYFPtHmjKbARp/+OIIpsVU1W0L
         KsAR7mjbHZyLOIpENCo53QfPHlrBl+/dUHrrqQ86r+lEVRxjG1cfq0FHj7rpQXzDeAkE
         ydig==
X-Forwarded-Encrypted: i=1; AHgh+RpMQ8rJ8W/n4iRlptYN2Y8VbJUrSZ8PEzUBEWjZnN64LvGFfqgtmoJPqiSWY8ahsAIszk08o6DHu/WuEKphRfwl@vger.kernel.org
X-Gm-Message-State: AOJu0YwBARF5YmwuiNExIfVqw6Pz5gIvrNTWW+eOBIJgHR6c8CC0XJGF
	kM7N7qQ40lUhArJmNIhBDRSyPtFOxvpF1NT1KVSmGdc38nxyH/e/m8r4Mh8GTouRkNxegS9Mmsi
	Yn8E0Zg==
X-Received: from pjbay5.prod.google.com ([2002:a17:90b:305:b0:37d:f041:9678])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c51:b0:37c:607b:2cd9
 with SMTP id 98e67ed59e1d1-38dc7607589mr8543076a91.0.1783966684087; Mon, 13
 Jul 2026 11:18:04 -0700 (PDT)
Date: Mon, 13 Jul 2026 11:17:49 -0700
In-Reply-To: <20260713181757.481164-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260713181757.481164-1-ctshao@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260713181757.481164-5-ctshao@google.com>
Subject: [PATCH v1 04/12] perf vendor events intel: Update clearwaterforest
 events from 1.02 to 1.04
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, perry.taylor@intel.com, 
	Chun-Tse Shao <ctshao@google.com>
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
2.55.0.795.g602f6c329a-goog

