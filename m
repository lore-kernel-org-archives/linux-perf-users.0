Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D13876D9
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 04:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772081602; cv=none; b=O/hLtV9fFssr1MHTwqYvdyZHGiZmGpDs87k+2Mmf0/VYICXAdZ3ILijyEObUh7h71hmi0QNdBQoum/L99HzznIJ5quPGkNkm1XdKySxkvU/hPRhAdTIxn9EIBp6U56oa6kTyg9zS5zvyP201Nic3ZiDP7TchZbG/kx5x6BRsiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772081602; c=relaxed/simple;
	bh=qhtkRfykDtcvbjL2tFT/LAEUxAWj+xeJm0UCf0J7oHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hHjtWer9+VIiH8BZ0g3JjN3/Qr3Vzu5L+mUfCTPm/EiszwToztzp/4uEe9AHCTYntC4oWHWHMsHr77RnxO7TDmKM4IlLiNWJpzIC47vcXMTE+JRgPVq4kUOBuEciU1BSTFcAovr3n0qtmsvCh2HfhWoKnzSm2Gfv+WEla5wcWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bcs6tokD; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bcs6tokD"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1275c6fc58aso1271170c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 20:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772081598; x=1772686398; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThXHpIwX96Kri+Lw+1W21ZJXtSkm2MpZVgq630ABzrY=;
        b=bcs6tokD/EZD79BBAazOU0e9PFI3aALSUXgShYLN7PKl7st2nDh1vy/ZOs7uS3Pf12
         pv/k4LGcIbhJlrU5zkLKOh5IdiQkybZ0z1kMnddwl/1ex7u/Xy5cjGxUTfsqIm1TEJPZ
         7tQedDfsYC57e7ioVC3UkR+77W6DDT6qhSZM4gu+UcOEbR5lzhC96G4nAB+YhLPPtvUY
         w+5DzNmuD3MgYge+2wDByTfgB0twJEeX0q3CzXEMRor5iM0CDyEmDr+a0OYT03NdAZof
         QAHwCD/k6PMETWzu2hKRs2RDdWZSp7jFQHLoibWo5RtY10b/b8OgO+yoVM9uUvBLJA4l
         /PTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772081598; x=1772686398;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThXHpIwX96Kri+Lw+1W21ZJXtSkm2MpZVgq630ABzrY=;
        b=BUD+IzmfOlczxwh5KyEoNYINqB1jpYIUwx201hcsne+Fciw2bIMXmZS2mq06LQffQP
         RagBtZXEPsoHGoHC6M+ofUVWQClqHNd76omf4VVtKC9ccy9vsM5R1GPa/24gcEmaVwz+
         8G3dwp91PgjEPETcyYI7hPKF4O6D8L7hs86CzvbHhAYyS0zopftMaTT5RBn8PNxSPHXv
         aej1jDUEBto6emokLCL2SRg9lqrUZBC1+d6ewIQJs5YYbTMgACNb+YRHcwJK+AKY0kk7
         3eAp6zevE/GpJWJ8X/tytE3TNG18cBGQK2riXDK+KapqRqvzsDvDRWAy6Fx2GHRqLEMv
         cQUw==
X-Forwarded-Encrypted: i=1; AJvYcCV0X0zTe6qPCyuwHrLTQxcdtfWzAvjLCJ8R0spuhEVqvaUiUui0PoM5qYVT0A4A9/nkUHWC1Q7yXtGHoZGvdSSy@vger.kernel.org
X-Gm-Message-State: AOJu0YydQGUB0H5ziGtF+NWWfNGFO/ruTokordCLWezsvThWz/H9qHzq
	jzGRspXBVwZ+5X1ifyfQ8S4nMe8msJ/nPdkil1apF/xBVflCuC1xhqk7FAyUz4sp6P1+/SiAHoA
	vm5bEvR1iCg==
X-Received: from dlbtz9.prod.google.com ([2002:a05:7022:eac9:b0:127:597a:3442])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4581:b0:127:3b1e:7e0e
 with SMTP id a92af1059eb24-12786966ab1mr1336156c88.20.1772081597866; Wed, 25
 Feb 2026 20:53:17 -0800 (PST)
Date: Wed, 25 Feb 2026 20:52:57 -0800
In-Reply-To: <20260226045301.459948-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226045301.459948-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226045301.459948-6-irogers@google.com>
Subject: [PATCH v1 06/10] perf vendor events intel: Update lunarlake events
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

