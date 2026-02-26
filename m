Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0B364927
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128793; cv=none; b=h1yTkV6fU1PEJSokJt5FiylROlyjfPfW8+KCohd2vti3cSH8Y7dVhvoKCNZP108EJf5vmg+kdWZfuB+nSJ8SUfVwb0qOT5vu9he3ljY58L2LyUyKL7EGV1/rGLkrCF7PBNbYAAK2XP+MkBT0zBHQ/CUWpR91ajYFZKJhQvHsvJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128793; c=relaxed/simple;
	bh=qhtkRfykDtcvbjL2tFT/LAEUxAWj+xeJm0UCf0J7oHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=u7Ao2EUlzsgZeVQZLc554YaZ2SgGVUC26oQ9MnNeMw2ig0gqP0G/HQxQfQQg8ZUSIkSgqNQ9qzAA3GEv0dkaWGEHcJV1TedDbLF0YHx0XhJNL8phPMus+NUgQeMGqZqfAyi7VyClRnOU1kHpeGaj5YNmy37uRAJlcbLnUkuX2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXE/pGaL; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXE/pGaL"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdc5078895so24249251eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 09:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772128791; x=1772733591; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThXHpIwX96Kri+Lw+1W21ZJXtSkm2MpZVgq630ABzrY=;
        b=qXE/pGaLvMnG5DqNlNJTo0DxtdW78qG6/MFK1O8b0E2FwLYThO1RXUj9pRKhdJzlxj
         jS9XWkZj8VgR4HLO/fp5pAX2YvJcoxWS1Y04aCfbUEFBfnSGR66ootFQKRv4Wa/xGaIj
         LBzXxtoJ1uCtF7d6+SPMqbPXN+Bjd4heo/OT5RmZ0bme2QAcOUTOrY5Ww6XtVfqxcVNC
         WO3iYRFYB96z8kMEArE+QHRWsxLQmdIACAoc84ysjEdrG5RJVkamMRG6/cMK/GOEDQBg
         VDZCiTSEsJO3JtwmDTQB+5yrC0yQqXJApXj2khv2pvQbaLcjhr4Qhj2m1ohIBLfjLt1e
         Plqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772128791; x=1772733591;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThXHpIwX96Kri+Lw+1W21ZJXtSkm2MpZVgq630ABzrY=;
        b=j2c53IupoIh31lDp3XHIUA3abGKoGK8cp1BTvk16KKkSOOLesmvUk0UD2jQgHa57li
         Uc8uZEiMP8469GblDXOAfQsUGiSO0tpU6gnnOyfxRno8z5OncEIdXucAQO0BoZ0232Ks
         73RmFGkcabA+FuK+gYU88LA9zWkd12VjRrptPFgH+I7ubPVgiLYuA0WFyaPq2SecQZfj
         iQrvYB8eOeHCarMY+gBHZh+TPUABJu4Gy1xvULT18sxb/lYu8SN8wHV7sq+uFJyPZHL6
         5hslPLnbahm/XUmmmKZOJHyD2PoeALjGr3IEY2F1un6cekdgEL2p3mLz8lwoo7iBSV9v
         6elw==
X-Forwarded-Encrypted: i=1; AJvYcCXMt67XHlVNqt7CJVuf1kHHOEo+G35yxZsnF4Ub8SkQgC4RD5GNuZvL7NKkT6776ydJDGlYZxl/dC7tPndfVgsB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3phRmVU6Sg4oeTATvF5HqO8Is8qgsgsxcqCJBVjQtgLiU77y4
	qDXAgJGOnAPSqZWCfH0yGm4uI74t3WbN1cNR6CjJR1WpgMjW+upgh/goHGC9kx08lbh9jhPvj6M
	B7mcyhu/oWg==
X-Received: from dybfe10.prod.google.com ([2002:a05:7300:bf8a:b0:2ba:a7a3:e4eb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7492:b0:2b8:6abf:5ebf
 with SMTP id 5a478bee46e88-2bdcbf7c168mr2321626eec.12.1772128791306; Thu, 26
 Feb 2026 09:59:51 -0800 (PST)
Date: Thu, 26 Feb 2026 09:59:32 -0800
In-Reply-To: <20260226175936.593159-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226175936.593159-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260226175936.593159-6-irogers@google.com>
Subject: [PATCH v2 06/10] perf vendor events intel: Update lunarlake events
 from 1.19 to 1.21
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/d6755a30419d02930889497741552309343bdb1e
https://github.com/intel/perfmon/commit/6c9f684ae1de6229511fd56d1196fdc2db242a41

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/lunarlake/cache.json  | 36 ++++++++++++++-----
 .../arch/x86/lunarlake/frontend.json          | 27 ++++++++++++++
 .../arch/x86/lunarlake/pipeline.json          | 10 +++---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 61 insertions(+), 14 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
index 3d2616be8ec1..2db3e8a51fbd 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -550,6 +550,24 @@
         "UMask": "0x7e",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the core is stalled due to an icache or itlb miss which missed all the caches.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x78",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the core is stalled due to an icache or itlb miss which missed all the caches. Local DRAM, MMIO or other local memory type provides the data.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_MISS_LOCALMEM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the core is stalled due to an L1 demand load miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1088,7 +1106,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 128.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1100,7 +1118,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 16.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1112,7 +1130,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 256.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1124,7 +1142,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 32.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1136,7 +1154,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 4.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1148,7 +1166,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 512.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1160,7 +1178,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 64.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1172,7 +1190,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD - Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 8.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1274,7 +1292,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of  stores uops retired same as MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Counts the number of stores uops retired.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json b/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
index b21d602e9f1a..798eebf77436 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
@@ -424,6 +424,15 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of instructions retired that were tagged because empty issue slots were seen before the uop due to Instruction L1 cache miss, that missed in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ICACHE_L2_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of instructions retired that were tagged because empty issue slots were seen before the uop due to ITLB miss that hit in the second level TLB.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -500,6 +509,24 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L1 instruction cache In use-full",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS_INUSE",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L1 instruction cache ISB-full",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS_ISB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is delivering any Uop",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
index 97797f7b072e..d98723b3cd78 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
@@ -634,7 +634,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles.",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "SampleAfterValue": "2000003",
@@ -725,7 +725,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles.",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
@@ -1530,8 +1530,9 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of accesses to KeyLocker cache.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xe1",
         "EventName": "MISC_RETIRED2.KEYLOCKER_ACCESS",
         "SampleAfterValue": "1000003",
@@ -1539,8 +1540,9 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of misses to KeyLocker cache.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xe1",
         "EventName": "MISC_RETIRED2.KEYLOCKER_MISS",
         "SampleAfterValue": "1000003",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 96580ffda7bf..a2dde3faad5e 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -22,7 +22,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
-GenuineIntel-6-BD,v1.19,lunarlake,core
+GenuineIntel-6-BD,v1.21,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.18,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
-- 
2.53.0.414.gf7e9f6c205-goog

