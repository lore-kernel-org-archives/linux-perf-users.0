Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026F331EC3
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 21:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041859; cv=none; b=mRa2881NonC8h2vB42HcNsLcT6jLHaqZIG6JtJokYjgPTupPfLOj/x9RRczDrCAmkoMTIzDb99TKyTrKGfmEWXkWonq8tY1pXHmPt4YT2FiKhsgeMIVDqltDlB5vpelLznON2E2PfRub3njfzqWfL+qeV7WoF5+kG0rJjordMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041859; c=relaxed/simple;
	bh=bzisRS8h0zyBpBT4AvjwsYPHWtmhzPru9tf4KOixYpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pz5Wf2I9MxRHNDdYSt3Vmj+txYIc4mDl/hPH24OeOdJP8mYzre/Y/MdkgV7c/pcAHTb0wbsE5D7/Inn1968OXx5Ag0W4VafT9NqfT0veuJN1lYeiJKqL7OiqzdHv6NTxK7s4wHX5fUkeXQtRTaOdtxGCtl+6ohh073J+NrOA8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ee+q3bg5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ee+q3bg5"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8582b167f7so3099491a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781041854; x=1781646654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfF2cucmuKSkEg9jfSy0pWRTIColxRowD2/yPXmqXLs=;
        b=Ee+q3bg5Dyto6CNDqSmzy8i9iLhlFLn7IZVzDds/OhhKSmm6623dZMd1tUcRB/zLYe
         AgLYln9gvI0h+IPirvrYM7ekIO0on4L7LCy9u5khJP43kWATFr4XxhBVtkuZKRemj3t6
         OPa7+x0nmJ/sc30Y06jXAEMdBQh2qUcIvUq+DbI42i42HDy1591qN7U3ROM/1hFm/G1S
         9dW68RyKajx888OOGLFV6ZKN6Yb16IaU0K8IkycrXHoFumwZqrPZ7BQX+1EATl12aw6h
         BcAIyGHnYfVfQmCn3zU9pQ8MI5xy8iRsLSp2vdU7NMuzYvp+39iO9SezciWsjBmIgqmR
         VQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041854; x=1781646654;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TfF2cucmuKSkEg9jfSy0pWRTIColxRowD2/yPXmqXLs=;
        b=rhnAT66CUCxbu97HAYM3lC9IemWkT0Sw8CaUiAier8mFg89gE2iizsC9ZtZ2v0O+yr
         vl3F/E1yCkWuT9GnbZMrjn80QA9ybZ9KptT/q9FumEjF1nLC9U/I8ku7YhwZ6rKbG8+/
         LCk+YM+HYKvdLDHMTw68itKQxjpFlE5nvOhll8rtEzUfJPFlQ1D/ZG11MxCyRdqsVKro
         cB0vgkp8o86faDgJgR517BSOebS/ex0QpcZsYkv7z4JXDyb4RBm0xD2azr0vfre+cLWr
         QVPbaE8iq+r0YBYwWyqDLw3syF+9ZiDfAp6yb4vz5vjbqg3X1RAegg8KnxjAgomlb0Td
         6Lxg==
X-Forwarded-Encrypted: i=1; AFNElJ+Z/4fdj62FACbae6Oeqd8vWT85q74iU9IAEEl7ZWLkTf1vQAIWefCnRPwCVzhXa2xy8QjksUBFQMM9Gp5vqUyG@vger.kernel.org
X-Gm-Message-State: AOJu0YxuvISo5JF0B8q8Za8pGAl1gFsAIE61SjWMPWTFvGEYL253bhQf
	hVvtTjtaomb6UW3wZ5HaFL+/yMXBmWsfbhj9ZVMtFT7/F1J1Is+sa0JoAv/nERoYOI3/GZChpVI
	r2DNygA==
X-Received: from pfuj3.prod.google.com ([2002:a05:6a00:1303:b0:842:2abf:9656])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1309:b0:835:366f:5da2
 with SMTP id d2e1a72fcca58-8430a781017mr4961998b3a.37.1781041853646; Tue, 09
 Jun 2026 14:50:53 -0700 (PDT)
Date: Tue,  9 Jun 2026 14:50:43 -0700
In-Reply-To: <20260609215046.2391903-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609215046.2391903-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260609215046.2391903-5-ctshao@google.com>
Subject: [PATCH v1 4/6] perf vendor events intel: Update lunarlake events from
 1.22 to 1.25
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/5535a3e8cc14ae8ef58013cf3d8e9480018=
b911a

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 .../pmu-events/arch/x86/lunarlake/cache.json  |   2 +-
 .../arch/x86/lunarlake/pipeline.json          |  27 ++-
 .../arch/x86/lunarlake/uncore-memory.json     | 208 +++++++++++++++++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 4 files changed, 228 insertions(+), 11 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/cache.json
index 92a3667b4520..5b350233a5e1 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "Counts the number of request that were not ac=
cepted into the L2Q because the L2Q is FULL.",
+        "BriefDescription": "Counts the number of requests that were not a=
ccepted into the L2Q because the L2Q is FULL.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x31",
         "EventName": "CORE_REJECT_L2Q.ANY",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/lunarlake/pipeline.json
index d66eafccebbb..a7467b2f291d 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
@@ -190,7 +190,6 @@
         "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
         "PublicDescription": "Counts taken forward conditional branch inst=
ructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "400009",
-        "UMask": "0x102",
         "Unit": "cpu_core"
     },
     {
@@ -324,6 +323,15 @@
         "UMask": "0xdf",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of taken branch instruction=
s retired",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -446,7 +454,7 @@
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_BWD_COST",
         "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken backward. This precise event may be used to get =
the misprediction cost via the Retire_Latency field of PEBS. It fires on th=
e instruction that immediately follows the mispredicted branch. Available P=
DIST counters: 0,1",
         "SampleAfterValue": "400009",
-        "UMask": "0x8001",
+        "UMask": "0x41",
         "Unit": "cpu_core"
     },
     {
@@ -475,7 +483,7 @@
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_FWD_COST",
         "PublicDescription": "number of branch instructions retired that w=
ere mispredicted and taken forward. This precise event may be used to get t=
he misprediction cost via the Retire_Latency field of PEBS. It fires on the=
 instruction that immediately follows the mispredicted branch. Available PD=
IST counters: 0,1",
         "SampleAfterValue": "400009",
-        "UMask": "0x8002",
+        "UMask": "0x140",
         "Unit": "cpu_core"
     },
     {
@@ -575,11 +583,11 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
+        "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired. Available PDIST counters: 0,1",
+        "PublicDescription": "This event counts the number of mispredicted=
 ret instructions retired. Available PDIST counters: 0,1",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
@@ -1373,6 +1381,15 @@
         "UMask": "0x88",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts number of virtual trap actually taken =
(e.g. highest priority event during retirement). It can count virtual trap =
from FPC port 0 or port 1 (x87/SSE) equally in a single counter.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FPC_VIRTUAL_TRAP",
+        "SampleAfterValue": "20003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of nukes due to memory rena=
ming",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/uncore-memory.json b/=
tools/perf/pmu-events/arch/x86/lunarlake/uncore-memory.json
index 63c4aa2791e4..a1e79f06645a 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/uncore-memory.json
@@ -1,6 +1,30 @@
 [
     {
-        "BriefDescription": "Read CAS command sent to DRAM",
+        "BriefDescription": "ACT command for a read request sent to DRAM."=
,
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x24",
+        "EventName": "UNC_M_ACT_COUNT_RD",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command sent to DRAM.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x26",
+        "EventName": "UNC_M_ACT_COUNT_TOTAL",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "ACT command for a write request sent to DRAM.=
",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x25",
+        "EventName": "UNC_M_ACT_COUNT_WR",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Read CAS command sent to DRAM.",
         "Counter": "0,1,2,3,4",
         "EventCode": "0x22",
         "EventName": "UNC_M_CAS_COUNT_RD",
@@ -8,7 +32,7 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Write CAS command sent to DRAM",
+        "BriefDescription": "Write CAS command sent to DRAM.",
         "Counter": "0,1,2,3,4",
         "EventCode": "0x23",
         "EventName": "UNC_M_CAS_COUNT_WR",
@@ -16,7 +40,94 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Any Rank at Hot state",
+        "BriefDescription": "Counting the number of clocks.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "CKE in DRAM is low.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x29",
+        "EventName": "UNC_M_DRAM_CKE_OFF_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming read request page status is Page Emp=
ty.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x1D",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming read request page status is Page Em=
pty",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming write request page status is Page Em=
pty.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x20",
+        "EventName": "UNC_M_DRAM_PAGE_EMPTY_WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming write request page status is Page E=
mpty",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming read request page status is Page Hit=
.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x1C",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming read request page status is Page Hi=
t",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming write request page status is Page Hi=
t.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x1F",
+        "EventName": "UNC_M_DRAM_PAGE_HIT_WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming write request page status is Page H=
it",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming read request page status is Page Mis=
s.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x1E",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming read request page status is Page Mi=
ss",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming write request page status is Page Mi=
ss.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x21",
+        "EventName": "UNC_M_DRAM_PAGE_MISS_WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "incoming write request page status is Page M=
iss",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "DRAM in Self-refresh (all channels).",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x12",
+        "EventName": "UNC_M_DRAM_SELF_REFRESH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Any Rank at Hot state.",
         "Counter": "0,1,2,3,4",
         "EventCode": "0x19",
         "EventName": "UNC_M_DRAM_THERMAL_HOT",
@@ -25,7 +136,7 @@
         "Unit": "iMC"
     },
     {
-        "BriefDescription": "Any Rank at Warm state",
+        "BriefDescription": "Any Rank at Warm state.",
         "Counter": "0,1,2,3,4",
         "EventCode": "0x1A",
         "EventName": "UNC_M_DRAM_THERMAL_WARM",
@@ -33,6 +144,42 @@
         "PerPkg": "1",
         "Unit": "iMC"
     },
+    {
+        "BriefDescription": "PRE command sent to DRAM for a read/write req=
uest.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x27",
+        "EventName": "UNC_M_PRE_COUNT_PAGE_MISS",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts number of bytes read, in 32B chunk, pe=
r DDR channel. Counter increments by 1 after receiving 32B chunk data.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x3A",
+        "EventName": "UNC_M_RD_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "This counter counts number of bytes read, in=
 32B chunk, per DDR channel. Counter increments by 1 after receiving 32B ch=
unk data.",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of VC0 read in channel0  - this event =
can increment by more than 1 (per channel/sub-ch).",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x13",
+        "EventName": "UNC_M_RD_OCCUPANCY_CH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of VC0 read in channel0  - this event=
 can  increment by more than 1 (per channel/sub-ch)",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Number of VC0 read in channel1 - this event c=
an increment by more than 1 (per channel/sub-ch).",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x14",
+        "EventName": "UNC_M_RD_OCCUPANCY_CH1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
     {
         "BriefDescription": "Total number of read and write byte transfers=
 to/from DRAM, in 32B chunk, per DDR channel. Counter increments by 1 after=
 sending  or receiving 32B chunk data.",
         "Counter": "0,1,2,3,4",
@@ -40,5 +187,58 @@
         "EventName": "UNC_M_TOTAL_DATA",
         "PerPkg": "1",
         "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Total number of requests entering MC, this is=
 the sum of all RD + WR requests for all VCs.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x39",
+        "EventName": "UNC_M_TOTAL_REQUESTS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC0 read request.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_VC0_REQUESTS_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC0 write request.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_VC0_REQUESTS_WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC1 read request.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x04",
+        "EventName": "UNC_M_VC1_REQUESTS_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Incoming VC1 write request.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_VC1_REQUESTS_WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "iMC"
+    },
+    {
+        "BriefDescription": "Counts number of bytes written, in 32B chunk,=
 per DDR channel. Counter increments by 1 after sending 32B chunk data.",
+        "Counter": "0,1,2,3,4",
+        "EventCode": "0x3B",
+        "EventName": "UNC_M_WR_DATA",
+        "PerPkg": "1",
+        "Unit": "iMC"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index b8ea72b99c52..7d19f8fa335a 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -22,7 +22,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
-GenuineIntel-6-BD,v1.22,lunarlake,core
+GenuineIntel-6-BD,v1.25,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.21,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
--=20
2.54.0.1099.g489fc7bff1-goog

