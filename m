Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BAE38B7B0
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030336; cv=none; b=n83AyY5bpouTZR0Hl9WrRlTjaC2BkpHLRP+eibSPGJ1wyxg6g22bbY63vgDUftKOBTbHth6iQ8on1ZjPdGQUmQcAnpUA28coAM8oooWMNqvqqzTcrrPkhxB/eBwlNIYkJLqquLHHYXJ51filyDljZ3BgCseyWXe9gK23vs2D2Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030336; c=relaxed/simple;
	bh=tp9Ipw/FbjuFLacpjrOX0RgT0wzZcUlEVS1UxYq9oXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LeeU76Vxz4Zs2OY5/9JWXhPacaczkLZ2/9837zXcZGgWEKeKlthUKXvAfrMCC4qRZav57fIxyQCfQ1gLRU6FX5DYvMU4m/0A7EOlnd0r6aBPETNX2h9fr5wKlI/vI2aq5LCGtoG3FFL80744V/CTHO4MRRWmebuessH74iAjqsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NGoDWJ8P; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NGoDWJ8P"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fd55bf6cdso8629147b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030334; x=1780635134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7BPswMGFXDRQFUZIJUHWEJ6uHq/WVlkqh05UUqcSzs=;
        b=NGoDWJ8PEiE/i3EzWHwfh5blFkDvg6b/h2nuV6E+I4gCn5X+yoMDhLo31ljgNKJY6h
         nhiiRDborqWIp03BvbUcNCF/OQvAGNPz9doPFZQrL5dwuFcxtisXYGENFhxP0jKT0PW4
         7DbENm/RDyhEdxE2AxC4VDN43vh9lvMbAsaXqlwbey13t0CTeQdqzKjL+4yWdX1xUwE4
         igWDoRaffG3zSzg6+PpR643+eWAObbjiGcVdxy7fpIrv7Q0/vu751HZx/v1+S1Ehl2Xj
         vF5DhlK087WIobxzTYkZLYTL+0HOolIyCtCC48e1lbDaqt1jwHDfYe66R+pKufud5wxL
         Me0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030334; x=1780635134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7BPswMGFXDRQFUZIJUHWEJ6uHq/WVlkqh05UUqcSzs=;
        b=fSnlEBrRoMduFAKDWdkken4NdHGmfVipzDbS+NFJNsKX/DY5xz6HaDLHq2rvbSuwzz
         HUd0hm5g4ikMrqtbLrd8nQpWXn7VCQ50DhchDUq+vjYjRvU0DhTJ/9jQG6xHR1/sZGey
         FOy07y0uCo9sErvlr3M0pTtlGvTVDXmxZEVN0OZJFqHAn5HMOb+pq65XgDjxFvzbmcoA
         KSouGX63Uv+Wrs00s3CquZ69gC7YoLS6wkQrJ4oXzP+YFvyvn6BfihXy2UgUgvc9TrQQ
         qB3mWRopXtY+4zKMd7pJc3COQuqqKc/knOppp5SmdO6KhbhAunmS9Z020LRhrgmZwvnu
         frNg==
X-Forwarded-Encrypted: i=1; AFNElJ+VFSAG1mOyChV7reBbrzBS66CU0WiEc3Gf71UVxo1KikajmPTC3WptmTw0NYPl0FYvWDCEHLfBqWw34T7FxgGn@vger.kernel.org
X-Gm-Message-State: AOJu0YzQt3ZtP2UCyr5nEB8JYzvTqKnl4XZFuu2ow2NIhxxvbex3al+r
	ojKoBni+GWzFV0/ldLe2FeCZ1XqC2XvT/RbeMjZ3Ye5baPVqpoQCXJuB50lvgtsbGX4wf11t4dS
	JVYtFJ66MYQ==
X-Received: from pfblb4.prod.google.com ([2002:a05:6a00:4f04:b0:831:2832:b2fc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:848:b0:841:71fd:6480
 with SMTP id d2e1a72fcca58-84212ba372emr1407139b3a.24.1780030333707; Thu, 28
 May 2026 21:52:13 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:43 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-2-irogers@google.com>
Subject: [PATCH v1 01/12] perf vendor events intel: Update alderlake events
 from 1.37 to 1.39
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
https://github.com/intel/perfmon/commit/e55693d19f4dfe6b09c0ee9eb2b4e93781e16dd9
https://github.com/intel/perfmon/commit/25a1cd4847c1ed9159b5c79d1f7afe24ec965269

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/alderlake/cache.json  | 85 +++++++++++++++++++
 .../pmu-events/arch/x86/alderlake/memory.json | 64 ++++++++++++++
 .../arch/x86/alderlake/pipeline.json          | 54 ++++++++++++
 .../arch/x86/alderlake/virtual-memory.json    |  9 ++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 5 files changed, 213 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
index 5d0d824f3e7e..e44e6b651d55 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -150,6 +150,16 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event is alias to L2_RQSTS.HIT]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_RQSTS.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of L2 Cache accesses that resulted in a miss. Counts on a per core basis.",
         "Counter": "0,1,2,3,4,5",
@@ -259,6 +269,16 @@
         "UMask": "0x21",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event is alias to L2_REQUEST.HIT]",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This event is alias to L2_REQUEST.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "L2_RQSTS.HWPF_MISS",
         "Counter": "0,1,2,3",
@@ -338,6 +358,16 @@
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles when L1D is locked",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "LOCK_CYCLES.CACHE_LOCK_DURATION",
+        "PublicDescription": "This event counts the number of cycles when the L1D is locked. It is a superset of the 0x1 mask (BUS_LOCK_CLOCKS.BUS_LOCK_DURATION).",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory requests that miss in the LLC. Counts on a per core basis.",
         "Counter": "0,1,2,3,4,5",
@@ -853,6 +883,17 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL",
+        "PublicDescription": "Counts the number of memory uops retired.  A single uop that performs both a load AND a store will be counted as 1, not 2 (e.g. ADD [mem], CONST)",
+        "SampleAfterValue": "200003",
+        "UMask": "0x83",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of load uops retired.",
         "Counter": "0,1,2,3,4,5",
@@ -875,6 +916,18 @@
         "UMask": "0x82",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 1024. Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 128. Only counts with PEBS enabled.",
         "Counter": "0,1",
@@ -899,6 +952,18 @@
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 2048. Only counts with PEBS enabled.",
+        "Counter": "0,1",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x800",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of tagged load uops retired that exceed the latency threshold of 256. Only counts with PEBS enabled.",
         "Counter": "0,1",
@@ -981,6 +1046,16 @@
         "UMask": "0x21",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that were splits.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x43",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of retired split load uops.",
         "Counter": "0,1,2,3,4,5",
@@ -991,6 +1066,16 @@
         "UMask": "0x41",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of retired split store uops.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x42",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the total number of load and store uops retired that missed in the second level TLB.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
index a0260d5b8619..f482c06ac728 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -9,6 +9,15 @@
         "UMask": "0x6",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to any number of reasons, including an L1 miss, WCB full, pagewalk, store address block or store data block.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ANY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7f",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to any number of reasons, including an L1 miss, WCB full, pagewalk, store address block or store data block, on a load that retires.",
         "Counter": "0,1,2,3,4,5",
@@ -27,6 +36,15 @@
         "UMask": "0xf4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a DL1 miss.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a DL1 miss.",
         "Counter": "0,1,2,3,4,5",
@@ -36,6 +54,16 @@
         "UMask": "0x81",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to other block cases.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.OTHER",
+        "PublicDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to other block cases such as pipeline conflicts, fences, etc.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to other block cases.",
         "Counter": "0,1,2,3,4,5",
@@ -46,6 +74,15 @@
         "UMask": "0xc0",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a pagewalk.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.PGWALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a pagewalk.",
         "Counter": "0,1,2,3,4,5",
@@ -55,6 +92,15 @@
         "UMask": "0xa0",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a store data forward block.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.ST_ADDR",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a store address match.",
         "Counter": "0,1,2,3,4,5",
@@ -64,6 +110,24 @@
         "UMask": "0x84",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to request buffers full or lock in progress.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to request buffers full or lock in progress.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of machine clears due to memory ordering caused by a snoop from an external agent. Does not count internally generated machine clears such as those due to memory disambiguation.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
index 80cad3c49d20..1c292f29b0aa 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -349,6 +349,15 @@
         "UMask": "0xfd",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of near relative JMP branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.NEAR_RETURN",
         "Counter": "0,1,2,3,4,5",
@@ -359,6 +368,15 @@
         "UMask": "0xf7",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.COND_TAKEN",
         "Counter": "0,1,2,3,4,5",
@@ -560,6 +578,15 @@
         "UMask": "0xfe",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the total number of BTCLEARS.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xe8",
+        "EventName": "BTCLEAR.ANY",
+        "PublicDescription": "Counts the total number of BTCLEARS which occurs when the Branch Target Buffer (BTB) predicts a taken branch.",
+        "SampleAfterValue": "200003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.1 light-weight slower wakeup time but more power saving optimized state.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1214,6 +1241,24 @@
         "UMask": "0x8",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears that flush the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FAST",
+        "SampleAfterValue": "20003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of virtual traps taken.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FPC_VIRTUAL_TRAP",
+        "SampleAfterValue": "20003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of machines clears due to memory renaming.",
         "Counter": "0,1,2,3,4,5",
@@ -1410,6 +1455,15 @@
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number issue slots not consumed  due to a  color request for an FCW or MXCSR control register when all 4 colors (copies) are already in use.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.COLOR_STALLS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots not consumed by the backend due to a micro-sequencer (MS) scoreboard, which stalls the front-end from issuing from the UROM until a specified older uop retires.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
index 132ce48af6d9..115bbc000a45 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
@@ -250,6 +250,15 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer is stalled due to a DTLB miss.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.DTLB_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (oldest load) of the load buffer and retirement are both stalled due to a DTLB miss.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 8a9e1735e21e..2f542283202a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,5 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.37,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.39,alderlake,core
 GenuineIntel-6-BE,v1.37,alderlaken,core
 GenuineIntel-6-C[56],v1.16,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
-- 
2.54.0.823.g6e5bcc1fc9-goog

