Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D51922FA
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917624; cv=none; b=Fa8YwAyIS6DPjXE4AItxiy3lCbICC2mh2+eOKh2/6Umeo8W3oCK6VMWlHT7aIBjEYadJqRlHf8GPXIf6XYD4BWOg2ubmxb/aFfAwmk9k89zdvKKqrfzlI3AJMHCLqRNbdQWjaCxgZT8zV2dUhF5ywd4odnojP3fqqDQsckGKwa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917624; c=relaxed/simple;
	bh=Jcm7UL8/lFDhQIlPhuAgLeKF3UATwKiIBixq/P6AT10=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nw7BRWvQDQ8BsVU7qz3yqoFdvnUE/hZUAf6k4cRv6YPjBiPybljrin4qo2yGbEjvYvAcmx1K9PuYNjYRbwkwgNtljmCyIummPUaGogiKTg/pldaD9K51ML7ntdMmuQ9+S8xRMw4YsqoUg3IUUBe+REC2obbZXN5I3W1gYNP9saA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1nFlQE8; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1nFlQE8"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e54da6701d2so8012161276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 08:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742917619; x=1743522419; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YC3LRLM5jbvcC6M7msVEOfa40sR0TPKU7PhwtgnPbI=;
        b=M1nFlQE8M2WHc1lexNkLenmb2QFiUze9vcERO88mLOl5h3u+QLbDVY1SQSxVuXErqZ
         LkNHgQKbsbKTFyvO79bIy+QVpPUQ9CZ/Lj58w/b6RuwIvvU/PIfnGooGP2Ej0cYOb7pv
         WS8GsXr3U/O7268ykppQ8y0TWxF1mPeLuD3OJsZJJXAcX6hTkshuL/MpUfHVoTRtEwk2
         lJF1xKr171X/PO4y1/wgf+zeSQvGtDeEq3U5OeNZ6XuyEsK18XqmvzCwFS8gtk34k3pH
         KmTsVotPmXZYuQaRp01dpFrU/FIsdTxJ/TA1X1uEHvCffRPzSszBoyV98njcHPFrG8UE
         3X2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917619; x=1743522419;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9YC3LRLM5jbvcC6M7msVEOfa40sR0TPKU7PhwtgnPbI=;
        b=S9lQu+M+65Qju7aln5/tG/gN02ENPI0u1Xtx4j6pkdnoKnmecTPhXjXvYXlIDT7n72
         nc8wsvpp7DkubBVhk6VDdDpzEN5A6CuohvcUSnogEkx73anm4LwPFhNFgFK1GDy3sTsC
         sizthrX3OpF1HJoHSt4J7acRdCRWg1BWuW4bEAp+xyao9U894HHppS2AMTeBBafkTD43
         NVjTFFbHpvUNMfpSfhZprjt3l1y1TXecqRN3rkaMfm1zp1yErlbdcFKAvr46JoFSpBm0
         COLg6RC8/Xk7711uQRgAdTZ/kNe9sl+zsxVLPZov9rpLtRf1bytZRrtUKF309jfoqEU7
         vhoA==
X-Forwarded-Encrypted: i=1; AJvYcCVVpiyh9AHIUnz1Fcr6OpP5VdRnBr6QHhOsSsKEceh3GDp804PUWkwIN4TRd9aV0lq/dbdvYkZythyBpQKtntu5@vger.kernel.org
X-Gm-Message-State: AOJu0YyAh+2jmPa7QLj+0wMhBN/Mldqlmh97ZJLvYpLvy8mx2VDBbW5e
	Ud31bdKA0iznkNgO91UaZohCJCDVqkIY6I78DP03WYnWfQUMDjphgQYS/mPk8uFqm5LeNOU688Z
	9ICnBDw==
X-Google-Smtp-Source: AGHT+IGIVXqTv0k4FBweaSRln1Fx8Bk/SNpEGGmplp90Sf0TbbXH6cKAqdmMKxJPTFvUva4jzj6YAbmZi7wz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a25:d6d8:0:b0:e60:9fd3:da1b with SMTP id
 3f1490d57ef6-e66a4fa6725mr12501276.5.1742917619392; Tue, 25 Mar 2025 08:46:59
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:14:48 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 12/35] perf vendor events: Update grandridge events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.05 to v1.07.
Update event topics, metrics to be generated from the TMA spreadsheet
and other small clean ups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/grandridge/cache.json | 150 ++++-
 .../arch/x86/grandridge/counter.json          |   2 +-
 .../arch/x86/grandridge/frontend.json         |   8 +
 .../arch/x86/grandridge/grr-metrics.json      | 521 +-----------------
 .../pmu-events/arch/x86/grandridge/other.json |  28 -
 .../arch/x86/grandridge/pipeline.json         |  51 +-
 .../arch/x86/grandridge/uncore-cache.json     |  45 +-
 .../arch/x86/grandridge/uncore-memory.json    | 338 ++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 9 files changed, 582 insertions(+), 563 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/cache.json b/tools/p=
erf/pmu-events/arch/x86/grandridge/cache.json
index 04802e254e51..21671c65d6dd 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/cache.json
@@ -1,4 +1,91 @@
 [
+    {
+        "BriefDescription": "Counts the number of L1D cacheline (dirty) ev=
ictions caused by load misses, stores, and prefetches.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x51",
+        "EventName": "DL1.DIRTY_EVICTION",
+        "PublicDescription": "Counts the number of L1D cacheline (dirty) e=
victions caused by load misses, stores, and prefetches.  Does not count evi=
ctions or dirty writebacks caused by snoops.  Does not count a replacement =
unless a (dirty) line was written back.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Exclusive state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.E",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Exclusive state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Forward state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.F",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Forward state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Modified state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.M",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Modified state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Shared state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.S",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Shared state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache lines that are =
evicted due to an L2 cache fill",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.NON_SILENT",
+        "PublicDescription": "Counts the number of L2 cache lines that are=
 evicted due to an L2 cache fill. Increments on the core that brought the l=
ine in originally.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache lines that are =
silently dropped due to an L2 cache fill",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.SILENT",
+        "PublicDescription": "Counts the number of L2 cache lines that are=
 silently dropped due to an L2 cache fill.  Increments on the core that bro=
ught the line in originally.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 Cache Accesses that r=
esulted in a Hit from a front door request only (does not include rejects o=
r recycles), per core event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of total L2 Cache Accesses =
that resulted in a Miss from a front door request only (does not include re=
jects or recycles), per core event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 Cache Accesses that m=
iss the L2 and get BBL reject  short and long rejects, per core event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.REJECTS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -35,7 +122,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an icache or itlb miss which hit in the LLC.",
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an ICACHE or ITLB miss which hit in the LLC. If the=
 core has access to an L3 cache, an LLC hit refers to an L3 cache hit, othe=
rwise it counts zeros.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x35",
         "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_HIT",
@@ -43,7 +130,7 @@
         "UMask": "0x6"
     },
     {
-        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an icache or itlb miss which missed all the caches.=
",
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an ICACHE or ITLB miss which missed all the caches.=
 If the core has access to an L3 cache, an LLC miss refers to an L3 cache m=
iss, otherwise it is an L2 cache miss.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x35",
         "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_MISS",
@@ -68,7 +155,7 @@
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC.",
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC. If the cor=
e has access to an L3 cache, an LLC hit refers to an L3 cache hit, otherwis=
e it counts zeros.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT",
@@ -76,13 +163,21 @@
         "UMask": "0x6"
     },
     {
-        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the local cache=
s.",
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the local cache=
s. If the core has access to an L3 cache, an LLC miss refers to an L3 cache=
 miss, otherwise it is an L2 cache miss.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS",
         "SampleAfterValue": "1000003",
         "UMask": "0x78"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled to a store buffer full condition",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.SBFULL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -335,6 +430,33 @@
         "SampleAfterValue": "200003",
         "UMask": "0x42"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 missed in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x13"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the second Level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Counts the number of store uops retired that =
miss in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x12"
+    },
     {
         "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -344,6 +466,16 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -364,6 +496,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/counter.json b/tools=
/perf/pmu-events/arch/x86/grandridge/counter.json
index 9fd5d8ad6d3b..d9ac3aca5bd5 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/counter.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/counter.json
@@ -37,6 +37,6 @@
     {
         "Unit": "CHACMS",
         "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
+        "CountersNumGeneric": "4"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/frontend.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/frontend.json
index 7cdf611efb23..fef5cba533bb 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/frontend.json
@@ -31,5 +31,13 @@
         "EventName": "ICACHE.MISSES",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the micro-se=
quencer is busy.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "MS_DECODED.MS_BUSY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json b/t=
ools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
index 2f9959c61718..3029022e4e94 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
@@ -69,7 +69,7 @@
     },
     {
         "BriefDescription": "Percentage of time spent in the active CPU po=
wer state C0",
-        "MetricExpr": "tma_info_system_cpu_utilization",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
         "MetricName": "cpu_utilization",
         "ScaleUnit": "100%"
     },
@@ -213,525 +213,6 @@
         "MetricName": "stores_retired_per_instr",
         "ScaleUnit": "1per_instr"
     },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to certain allocation restrictions",
-        "MetricExpr": "tma_core_bound",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_core_bound_group"=
,
-        "MetricName": "tma_allocation_restriction",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend due to backend stalls",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
-        "MetricName": "tma_backend_bound",
-        "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.ALL_P / (6 * CPU_CLK_UNHALT=
ED.CORE)",
-        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
-        "MetricName": "tma_bad_speculation",
-        "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BACLEARS, which occurs when the Branch T=
arget Buffer (BTB) prediction or lack thereof, was corrected by a later bra=
nch predictor in the frontend",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
-        "MetricName": "tma_branch_detect",
-        "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to branch mispredicts",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / (6 * CPU_CLK_U=
NHALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_bad_speculation_g=
roup",
-        "MetricName": "tma_branch_mispredicts",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BTCLEARS, which occurs when the Branch T=
arget Buffer (BTB) predicts a taken branch",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / (6 * CPU_CLK_UNHA=
LTED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
-        "MetricName": "tma_branch_resteer",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS)",
-        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / (6 * CPU_CLK_UNHALTED.CORE)=
",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
-        "MetricName": "tma_cisc",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are bounded by core restrictions and not attributed to an o=
utstanding load or stores, or resource limitation",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / (6 * CPU_CLK_=
UNHALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_backend_bound_gro=
up",
-        "MetricName": "tma_core_bound",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls",
-        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / (6 * CPU_CLK_UNHALTED.COR=
E)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
-        "MetricName": "tma_decode",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that does not require the =
use of microcode, classified as a fast nuke, due to memory ordering, memory=
 disambiguation and memory renaming",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / (6 * CPU_CLK_UNH=
ALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_machine_clears_gr=
oup",
-        "MetricName": "tma_fast_nuke",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
-        "MetricName": "tma_frontend_bound",
-        "MetricgroupNoGroup": "TopdownL1",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / (6 * CPU_CLK_UNHALTED.COR=
E)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
-        "MetricName": "tma_icache_misses",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / (6 * CPU_CLK_=
UNHALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_frontend_bound_gr=
oup",
-        "MetricName": "tma_ifetch_bandwidth",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / (6 * CPU_CLK_UN=
HALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_frontend_bound_gr=
oup",
-        "MetricName": "tma_ifetch_latency",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n",
-        "MetricExpr": "INST_RETIRED.ANY / FP_FLOPS_RETIRED.ALL",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_arith_inst_mix_ipflop"
-    },
-    {
-        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction",
-        "MetricExpr": "INST_RETIRED.ANY / (FP_INST_RETIRED.128B_DP + FP_IN=
ST_RETIRED.128B_SP)",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_arith_inst_mix_ipfparith_avx128"
-    },
-    {
-        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction",
-        "MetricExpr": "INST_RETIRED.ANY / FP_INST_RETIRED.64B_DP",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_arith_inst_mix_ipfparith_scalar_dp"
-    },
-    {
-        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction",
-        "MetricExpr": "INST_RETIRED.ANY / FP_INST_RETIRED.32B_SP",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_arith_inst_mix_ipfparith_scalar_sp"
-    },
-    {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
-        "MetricExpr": "100 * (LD_HEAD.DTLB_MISS_AT_RET + LD_HEAD.PGWALK_AT=
_RET) / CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": "Cycles",
-        "MetricName": "tma_info_bottleneck_dtlb_miss_bound_cycles",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of time that allocation and retire=
ment is stalled by the Frontend Cluster due to an Ifetch Miss, either Icach=
e or ITLB Miss",
-        "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.ALL / CPU_CLK_UNHALTE=
D.CORE",
-        "MetricGroup": "Cycles;Ifetch",
-        "MetricName": "tma_info_bottleneck_ifetch_miss_bound_cycles",
-        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 due to an L1 miss",
-        "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.ALL / CPU_CLK_UNHALTED.=
CORE",
-        "MetricGroup": "Cycles;Load_Store_Miss",
-        "MetricName": "tma_info_bottleneck_load_miss_bound_cycles",
-        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 by the Memory Cluster due to a pipeline stall",
-        "MetricExpr": "100 * LD_HEAD.ANY_AT_RET / CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": "Cycles;Mem_Exec",
-        "MetricName": "tma_info_bottleneck_mem_exec_bound_cycles",
-        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricName": "tma_info_br_inst_mix_ipbranch"
-    },
-    {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
-        "MetricName": "tma_info_br_inst_mix_ipcall"
-    },
-    {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-        "MetricName": "tma_info_br_inst_mix_ipfarbranch"
-    },
-    {
-        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
-        "MetricExpr": "INST_RETIRED.ANY / (BR_MISP_RETIRED.COND - BR_MISP_=
RETIRED.COND_TAKEN)",
-        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_ntaken"
-    },
-    {
-        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was taken",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
-        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_taken"
-    },
-    {
-        "BriefDescription": "Instructions per retired indirect call or jum=
p Branch Misprediction",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
-        "MetricName": "tma_info_br_inst_mix_ipmisp_indirect"
-    },
-    {
-        "BriefDescription": "Instructions per retired return Branch Mispre=
diction",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RETURN",
-        "MetricName": "tma_info_br_inst_mix_ipmisp_ret"
-    },
-    {
-        "BriefDescription": "Instructions per retired Branch Misprediction=
",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricName": "tma_info_br_inst_mix_ipmispredict"
-    },
-    {
-        "BriefDescription": "Ratio of all branches which mispredict",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
-        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_rati=
o"
-    },
-    {
-        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
-        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_to_u=
nknown_branch_ratio"
-    },
-    {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
-        "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.LD_BUF / CPU_CLK_UNHALTED=
.CORE",
-        "MetricName": "tma_info_buffer_stalls_load_buffer_stall_cycles",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to memory reservation stations full",
-        "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.RSV / CPU_CLK_UNHALTED.CO=
RE",
-        "MetricName": "tma_info_buffer_stalls_mem_rsv_stall_cycles",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to store buffer full",
-        "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.ST_BUF / CPU_CLK_UNHALTED=
.CORE",
-        "MetricName": "tma_info_buffer_stalls_store_buffer_stall_cycles",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Cycles Per Instruction",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE / INST_RETIRED.ANY",
-        "MetricName": "tma_info_core_cpi",
-        "ScaleUnit": "1per_instr"
-    },
-    {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "FP_FLOPS_RETIRED.ALL / CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_core_flopc"
-    },
-    {
-        "BriefDescription": "Instructions Per Cycle",
-        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.CORE",
-        "MetricName": "tma_info_core_ipc"
-    },
-    {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "TOPDOWN_RETIRING.ALL_P / INST_RETIRED.ANY",
-        "MetricName": "tma_info_core_upi"
-    },
-    {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
-        "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.L2_HIT / MEM_BOUND_ST=
ALLS_IFETCH.ALL",
-        "MetricName": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l2h=
it",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.LLC_HIT / MEM_BOUND_S=
TALLS_IFETCH.ALL",
-        "MetricName": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l3h=
it",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
-        "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.L2_HIT / MEM_BOUND_STAL=
LS_LOAD.ALL",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_loadmissbound_with_l2hit",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.LLC_HIT / MEM_BOUND_STA=
LLS_LOAD.ALL",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_loadmissbound_with_l3hit",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a pipeline block",
-        "MetricExpr": "100 * LD_HEAD.L1_BOUND_AT_RET / CPU_CLK_UNHALTED.CO=
RE",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_store_bound_l1_bound"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement",
-        "MetricExpr": "100 * (LD_HEAD.L1_BOUND_AT_RET + MEM_BOUND_STALLS_L=
OAD.ALL) / CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_store_bound_load_bound"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full",
-        "MetricExpr": "100 * (MEM_SCHEDULER_BLOCK.ST_BUF / MEM_SCHEDULER_B=
LOCK.ALL) * tma_mem_scheduler",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_store_bound_store_bound"
-    },
-    {
-        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to floating point assists",
-        "MetricExpr": "1e3 * MACHINE_CLEARS.FP_ASSIST / INST_RETIRED.ANY",
-        "MetricName": "tma_info_machine_clear_bound_machine_clears_fp_assi=
st_pki"
-    },
-    {
-        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to page faults",
-        "MetricExpr": "1e3 * MACHINE_CLEARS.PAGE_FAULT / INST_RETIRED.ANY"=
,
-        "MetricName": "tma_info_machine_clear_bound_machine_clears_page_fa=
ult_pki"
-    },
-    {
-        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to self-modifying code",
-        "MetricExpr": "1e3 * MACHINE_CLEARS.SMC / INST_RETIRED.ANY",
-        "MetricName": "tma_info_machine_clear_bound_machine_clears_smc_pki=
"
-    },
-    {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
-        "MetricExpr": "100 * LD_BLOCKS.ADDRESS_ALIAS / MEM_UOPS_RETIRED.AL=
L_LOADS",
-        "MetricName": "tma_info_mem_exec_blocks_loads_with_adressaliasing"=
,
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
-        "MetricName": "tma_info_mem_exec_blocks_loads_with_storefwdblk",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
-        "MetricExpr": "100 * LD_HEAD.L1_MISS_AT_RET / LD_HEAD.ANY_AT_RET",
-        "MetricName": "tma_info_mem_exec_bound_loadhead_with_l1miss",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to o=
ther block cases, such as pipeline conflicts, fences, etc",
-        "MetricExpr": "100 * LD_HEAD.OTHER_AT_RET / LD_HEAD.ANY_AT_RET",
-        "MetricName": "tma_info_mem_exec_bound_loadhead_with_otherpipeline=
blks",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 pagewalk",
-        "MetricExpr": "100 * LD_HEAD.PGWALK_AT_RET / LD_HEAD.ANY_AT_RET",
-        "MetricName": "tma_info_mem_exec_bound_loadhead_with_pagewalk",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 second level TLB miss",
-        "MetricExpr": "100 * LD_HEAD.DTLB_MISS_AT_RET / LD_HEAD.ANY_AT_RET=
",
-        "MetricName": "tma_info_mem_exec_bound_loadhead_with_stlbhit",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 store forward address match",
-        "MetricExpr": "100 * LD_HEAD.ST_ADDR_AT_RET / LD_HEAD.ANY_AT_RET",
-        "MetricName": "tma_info_mem_exec_bound_loadhead_with_storefwding",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Instructions per Load",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricName": "tma_info_mem_mix_ipload"
-    },
-    {
-        "BriefDescription": "Instructions per Store",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "MetricName": "tma_info_mem_mix_ipstore"
-    },
-    {
-        "BriefDescription": "Percentage of total non-speculative loads tha=
t perform one or more locks",
-        "MetricExpr": "100 * MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRE=
D.ALL_LOADS",
-        "MetricName": "tma_info_mem_mix_load_locks_ratio"
-    },
-    {
-        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
-        "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIR=
ED.ALL_LOADS",
-        "MetricName": "tma_info_mem_mix_load_splits_ratio"
-    },
-    {
-        "BriefDescription": "Ratio of mem load uops to all uops",
-        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / TOPDOWN_RETIRING=
.ALL_P",
-        "MetricName": "tma_info_mem_mix_memload_ratio"
-    },
-    {
-        "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
-        "MetricExpr": "100 * SERIALIZATION.C01_MS_SCB / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricName": "tma_info_serialization_tpause_cycles",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
-        "MetricName": "tma_info_system_cpu_utilization"
-    },
-    {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "FP_FLOPS_RETIRED.ALL / (duration_time * 1e9)",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_system_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width"
-    },
-    {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P:k / CPU_CLK_UNHALTED.CORE",
-        "MetricName": "tma_info_system_kernel_utilization"
-    },
-    {
-        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P / CPU_CLK_UNHALTED.CORE",
-        "MetricName": "tma_info_system_mux"
-    },
-    {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricName": "tma_info_system_turbo_utilization"
-    },
-    {
-        "BriefDescription": "Percentage of all uops which are FPDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / TOPDOWN_RETIRING.ALL_P",
-        "MetricName": "tma_info_uop_mix_fpdiv_uop_ratio"
-    },
-    {
-        "BriefDescription": "Percentage of all uops which are IDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.IDIV / TOPDOWN_RETIRING.ALL_P",
-        "MetricName": "tma_info_uop_mix_idiv_uop_ratio"
-    },
-    {
-        "BriefDescription": "Percentage of all uops which are microcode op=
s",
-        "MetricExpr": "100 * UOPS_RETIRED.MS / TOPDOWN_RETIRING.ALL_P",
-        "MetricName": "tma_info_uop_mix_microcode_uop_ratio"
-    },
-    {
-        "BriefDescription": "Percentage of all uops which are x87 uops",
-        "MetricExpr": "100 * UOPS_RETIRED.X87 / TOPDOWN_RETIRING.ALL_P",
-        "MetricName": "tma_info_uop_mix_x87_uop_ratio"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB_MISS / (6 * CPU_CLK_UNHALTED.=
CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
-        "MetricName": "tma_itlb_misses",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / (6 * CPU_C=
LK_UNHALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_bad_speculation_g=
roup",
-        "MetricName": "tma_machine_clears",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to memory reservation stalls in which a sched=
uler is not able to accept uops",
-        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
-        "MetricName": "tma_mem_scheduler",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to IEC or FPC RAT stalls, which can be due to=
 FIQ or IEC reservation stalls in which the integer, floating point or SIMD=
 scheduler is not able to accept uops",
-        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / (6 * CPU_CLK_U=
NHALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
-        "MetricName": "tma_non_mem_scheduler",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that requires the use of m=
icrocode (slow nuke)",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / (6 * CPU_CLK_UNHALTE=
D.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_machine_clears_gr=
oup",
-        "MetricName": "tma_nuke",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized",
-        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
-        "MetricName": "tma_other_fb",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes",
-        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / (6 * CPU_CLK_UNHALTED.=
CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
-        "MetricName": "tma_predecode",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the physical register file unable to accep=
t an entry (marble stalls)",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / (6 * CPU_CLK_UNHALTED.C=
ORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
-        "MetricName": "tma_register",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the reorder buffer being full (ROB stalls)=
",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / (6 * CPU_CLK_UNHA=
LTED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
-        "MetricName": "tma_reorder_buffer",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a resource limitation",
-        "MetricExpr": "tma_backend_bound - tma_core_bound",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_backend_bound_gro=
up",
-        "MetricName": "tma_resource_bound",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that result =
in retirement slots",
-        "MetricExpr": "TOPDOWN_RETIRING.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
-        "MetricName": "tma_retiring",
-        "MetricgroupNoGroup": "TopdownL1",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to scoreboards from the instruction queue (IQ=
), jump execution unit (JEU), or microcode sequencer (MS)",
-        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
-        "MetricName": "tma_serialization",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "Uncore operating frequency in GHz",
         "MetricExpr": "UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_CLOCKTIC=
KS) * #num_packages) / 1e9 / duration_time",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/other.json b/tools/p=
erf/pmu-events/arch/x86/grandridge/other.json
index 28f9a4c3ea84..daa16030d493 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/other.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/other.json
@@ -8,26 +8,6 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -37,13 +17,5 @@
         "MSRValue": "0x10800",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x75",
-        "EventName": "SERIALIZATION.C01_MS_SCB",
-        "SampleAfterValue": "200003",
-        "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/pipeline.json
index 40fa4f5ae261..a934b64f66d0 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
@@ -56,6 +56,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP branch=
 instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xef"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -81,6 +89,30 @@
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
+    {
+        "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc0"
+    },
+    {
+        "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_CALL",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfd"
+    },
+    {
+        "BriefDescription": "Counts the number of near relative JMP branch=
 instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -121,6 +153,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xef"
+    },
     {
         "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -236,8 +276,9 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine with the use of microcode due to SMC=
, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUAL_=
TRAP.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SLOW",
         "SampleAfterValue": "20003",
@@ -259,6 +300,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.C01_MS_SCB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
.ALL_P]",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
index 6a80cf6cbd36..b89ab6e5cfb5 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
@@ -8,6 +8,16 @@
         "PortMask": "0x000",
         "Unit": "CHACMS"
     },
+    {
+        "BriefDescription": "Counts the number of cycles FAST trigger is r=
eceived from the global FAST distress wire.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHACMS_RING_SRC_THRTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "CHACMS"
+    },
     {
         "BriefDescription": "Number of CHA clock cycles while the event is=
 enabled",
         "Counter": "0,1,2,3",
@@ -530,6 +540,26 @@
         "UMask": "0x4",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Ingress (from CMS) Allocations : IRQ : Counts=
 number of allocations per cycle into the specified Ingress queue.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x13",
+        "EventName": "UNC_CHA_RxC_INSERTS.IRQ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Ingress (from CMS) Occupancy : IRQ : Counts n=
umber of entries in the specified Ingress queue in each cycle.",
+        "Counter": "0",
+        "EventCode": "0x11",
+        "EventName": "UNC_CHA_RxC_OCCUPANCY.IRQ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "All TOR Inserts",
         "Counter": "0,1,2,3",
@@ -603,7 +633,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read opt prefetch from local IA that mis=
s the cache",
+        "BriefDescription": "Data read opt prefetch from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
@@ -764,7 +794,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that miss the cache",
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFRFO",
@@ -859,7 +889,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that missed the LLC",
+        "PublicDescription": "TOR Inserts : Data read opt prefetch from lo=
cal iA that missed the LLC targeting local memory",
         "UMask": "0xc8a6fe01",
         "Unit": "CHA"
     },
@@ -934,7 +964,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "BriefDescription": "Read for ownership from local IA that miss th=
e LLC targeting local memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_LOCAL",
@@ -954,7 +984,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the LLC targeting local memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_LOCAL",
@@ -1024,7 +1054,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "BriefDescription": "Read for ownership from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
@@ -1034,7 +1064,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "BriefDescription": "Read for ownership prefetch from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
@@ -1406,7 +1436,6 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores"=
,
         "UMask": "0xc827ff01",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
index e75b3050ccd5..6a11e5505957 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
@@ -188,6 +188,256 @@
         "PublicDescription": "DRAM Clockticks",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "# of cycles MR4 temp readings forced 2x refre=
sh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 temp readings forced 2x refre=
sh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 temp readings forced 2x refre=
sh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 temp readings forced 2x refre=
sh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 MRRs was triggered/running",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 MRRs was triggered/running",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 MRRs was triggered/running",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 MRRs was triggered/running",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA6",
+        "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x10",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x20",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e and all pages are closed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_M_POWER_CHANNEL_PPD_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Critical level on s=
pecified DIMM and throttle level is zero.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x89",
+        "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Critical level on s=
pecified DIMM and throttle level is zero.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x89",
+        "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "UNC_M_POWER_THROTTLE_CYCLES.BW_SLOT0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.BW_SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "UNC_M_POWER_THROTTLE_CYCLES.BW_SLOT1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.BW_SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "MR4 temp reading is throttling",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.MR4BLKEN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "RAPL is throttling",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x46",
+        "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RAPLBLK",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
         "Counter": "0,1,2,3",
@@ -360,6 +610,94 @@
         "PerPkg": "1",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "# of cycles Throttling at Critical level on s=
pecified DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Critical level on s=
pecified DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at High level on speci=
fied DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8d",
+        "EventName": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at High level on speci=
fied DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8d",
+        "EventName": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Normal level on spe=
cified DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8b",
+        "EventName": "UNC_M_THROTTLE_LOW_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Normal level on spe=
cified DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8b",
+        "EventName": "UNC_M_THROTTLE_LOW_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Mid level on specif=
ied DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M_THROTTLE_MID_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles Throttling at Mid level on specif=
ied DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8c",
+        "EventName": "UNC_M_THROTTLE_MID_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "Write Pending Queue Allocations",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 1b592cf63940..ed7a1845d43d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -12,7 +12,7 @@ GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.11,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-B6,v1.05,grandridge,core
+GenuineIntel-6-B6,v1.07,grandridge,core
 GenuineIntel-6-A[DE],v1.06,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
--=20
2.49.0.395.g12beb8f557-goog

