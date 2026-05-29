Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BFA38D3EA
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030351; cv=none; b=mc1dVmDIrcI9vtmVsgt5LMM8qmWIZGBwwFcVyl64PGpeJM/5UAozllxu6A6x0NaxXVLHCBy1XZqEvPnpQPkHsklxvWYXGVs62gIp/okCxF9YtJ+OS1tGDZ4FhV/cXfs2HP5uFY+/ys9pHLkAWHYyt4YG4Rk2V1kWUtcVaICZJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030351; c=relaxed/simple;
	bh=lZYwNwjVkgk1giOENLZIOAuBJ+FBJZl+6+7miPztRcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HmbIAcGANQsSShjda3rgL8Yoc1NuRy9Sxmk4CFbmIpd9S7QyZCfa4rkw3V8nl0zYYKg45Np6DeYEz0JIYvCd4V/rb4yeJWkSghf1VwZMefeK5vW6bpt0wzFCb5U7ZSkhmHFZWUe7w0Y/b3GmO/vgyFpF4MBN1gaAHsmon+GQXOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIjlwQvr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIjlwQvr"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-841ef4bf8cfso1151106b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030347; x=1780635147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1TJiWjTTTxmYWqI8kL14HyIh3A1q346WVMnNRD+3mg=;
        b=eIjlwQvrlYSKQpYd/Igjf3qBjx2OgCqkFrOIWipnRTQDoAdktDVosf+4EuAr2ncqQK
         ASn+S9mUcCgP514zTMaufrq2O8Sj30vzTuHDwHuwSKeVT5FvPCb9D9sqptpSTXRvLDMV
         JWw5ZXmHjI5FweTEZ2TyAqxYvrxxrRhvqqaAL4dTuuy1irWBhggDF+Is3HevJoYefcxi
         Pk2Ccs5saH9zQbvmdDhHFbnTQGm8CWTsbMQh8vO7V13fxFdoSO7Qn+WT1GGdJlEBRLAB
         PipwDMPCyv5ARpmOYdQkNmcBclDOGxu4PPhd4jZEUhfkiB/Z/6ByJzUjGreeeguDFpWa
         9tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030347; x=1780635147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1TJiWjTTTxmYWqI8kL14HyIh3A1q346WVMnNRD+3mg=;
        b=RAtypNSIMN5kz8bferMQYz4KgxEXzSHiXGsJ2PXrXeCk3E2zMJNBAgbHW7XCJ4PNOq
         6bY8jYPE41oxlaj9WAAgYO/bioGiQQ2hNakKnpv/F/Va8qy0Njx7a7INd8KudtLRNFUp
         flcCUa90KBWL2MxuCnqZvxnwK/z8ZyEBYcVmzQBFPD1WRJ/XcvskVPrJy7BnjI1bP8wl
         HHvSeTYB1mYgd6x++TrQb5/kxWHbjoVHGB38iUl6z8Z3wXOEUhUKGUpsWjJ1nYPzNiys
         aITJYm1h+XfQvR2th9K54Dv0HRZgDozVcPgtK5gleYjGkmPK9Mvl/53JrYxYEbzylU9r
         vOew==
X-Forwarded-Encrypted: i=1; AFNElJ+1KX1yQpiRGxTgU3HzeCL6hs04Dve5CjaWov6GV/4r9fICWzN9x9hJnieHfctlRQ3FkmuEUpo1MIOu1F3/opHc@vger.kernel.org
X-Gm-Message-State: AOJu0Yydigm8sFtdtIEqav1A4DAyLqAH3JjfI1+bOshpPeVD/R4SgV7P
	nFwLNlWr5hLsX0QEeoTcKZOY76PQAhXjDiQMnypNV3qNpPG8q4epIor8kx6pp4NUyzd48Zr0JyD
	P9sgu2f50kw==
X-Received: from pfbfp6.prod.google.com ([2002:a05:6a00:6086:b0:83f:2647:b711])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1148:b0:837:6bb9:acd5
 with SMTP id d2e1a72fcca58-84212ade46cmr1272530b3a.0.1780030346702; Thu, 28
 May 2026 21:52:26 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:45 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-4-irogers@google.com>
Subject: [PATCH v1 03/12] perf vendor events intel: Update arrowlake events
 from 1.16 to 1.17
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/90c505bcd9b10fd9ce692a670c23074ab743aa87

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/arrowlake/cache.json  | 53 +++++++++++++++++++
 .../arch/x86/arrowlake/floating-point.json    |  9 ++++
 .../arch/x86/arrowlake/pipeline.json          | 48 ++++++++++++++++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json b/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
index 4c3aa1fab5a8..fe6b9ad68f87 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
@@ -339,6 +339,16 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event is alias to L2_RQSTS.HIT]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_RQSTS.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x5f",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of L2 Cache Accesses that resulted in a Hit from a front door request only (does not include rejects or recycles), per core event",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -464,6 +474,16 @@
         "UMask": "0x21",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event is alias to L2_REQUEST.HIT]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_REQUEST.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x5f",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache [This event is alias to L2_REQUEST.MISS]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -1126,6 +1146,15 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of retired load ops that hit in the L3 cache in which a snoop was required and modified data was forwarded",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.L3_HIT_SNOOP_HITM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of retired load ops with an unknown source",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1393,6 +1422,18 @@
         "UMask": "0x82",
         "Unit": "cpu_lowpower"
     },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 1024.",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "SampleAfterValue": "200003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 1024. Only counts with PEBS enabled.",
         "Counter": "0,1",
@@ -1453,6 +1494,18 @@
         "UMask": "0x5",
         "Unit": "cpu_lowpower"
     },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 2048.",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "SampleAfterValue": "200003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 2048. Only counts with PEBS enabled.",
         "Counter": "0,1",
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/floating-point.json b/tools/perf/pmu-events/arch/x86/arrowlake/floating-point.json
index 3e68c2468f11..c54fc201a6ca 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/floating-point.json
@@ -564,6 +564,15 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of uops executed on floating point and vector integer store data port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.STD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Counts the number of floating point operations retired that required microcode assist.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json b/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
index fb973c75be57..a0fd63cace22 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
@@ -376,7 +376,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of taken branch instructions retired",
+        "BriefDescription": "Counts the number of near taken branch instructions retired",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
@@ -422,6 +422,15 @@
         "UMask": "0xfd",
         "Unit": "cpu_lowpower"
     },
+    {
+        "BriefDescription": "Counts the number of relative JMP branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of near relative JMP branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -431,6 +440,25 @@
         "UMask": "0xdf",
         "Unit": "cpu_lowpower"
     },
+    {
+        "BriefDescription": "Counts the number of taken branch instructions retired",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Errata": "ARL011",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branch instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1663,6 +1691,15 @@
         "UMask": "0x88",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts number of virtual trap actually taken (e.g. highest priority event during retirement). It can count virtual trap from FPC port 0 or port 1 (x87/SSE) equally in a single counter.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FPC_VIRTUAL_TRAP",
+        "SampleAfterValue": "20003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of nukes due to memory renaming",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1672,6 +1709,15 @@
         "UMask": "0x10",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of machines clears due to memory renaming.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MRN_NUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Counts the number of machine clears that flush the pipeline and restart the machine without the use of microcode.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index c076dbed1611..85f41cab56c7 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.39,alderlake,core
 GenuineIntel-6-BE,v1.39,alderlaken,core
-GenuineIntel-6-C[56],v1.16,arrowlake,core
+GenuineIntel-6-C[56],v1.17,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
-- 
2.54.0.823.g6e5bcc1fc9-goog

