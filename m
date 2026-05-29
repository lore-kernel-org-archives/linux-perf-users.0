Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE5438D400
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030397; cv=none; b=FHZgobh7UYOUX8DJ5RFJLzAyNK7q6u6WX7qAxav0VSbd0snO9BvNbclMu7TZ1zDAozyk/KVmrq+bnpI9W84qeLFttN0XVm4s3w8GymbiVS2hc+4cq5MkX1fWd7XU7R8QP2Lkj21xZkHp6I+dfu22iFBuxLr/yVE2l2yC1go1Tjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030397; c=relaxed/simple;
	bh=+ZO+dRjFpAm6B7tnFcUpk6lnUN7ddtoQRR103TXP49U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WIzllflT7FZVIUunyFoSUs9OD/H1eeC/rD1AcqsCuZZ8Bi7X5o7OtNVUwEJFDzeHGnaZcL/yFbBxf1CsgjI1BYX0QDZoFHKL09DT9ijP5YkNP6sBHZMn5Htz4c5J2i2z6txSjPxayACYiqCy4OO3rrtvT5a4W1x92/qPoAanhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dE4NEP9p; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dE4NEP9p"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so15661450b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030354; x=1780635154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEx5T9t4bR3wMQ8JDf/X+nGS+pnh0j1PzKpdwnppXPM=;
        b=dE4NEP9psXqOPm2/n3YmL02b+1CMf9ufEmux067Eocw5gP/RtOc77CYSQG6WIMYXQ6
         LisxdrI5U3XOsV6PyeEmDrmrC/tm0TTcYN9DEE2w052aAhVYwlQWPe91Uks42sgbCLqE
         OxlQMURzYfFDGdR7SLkAnBQccj6bVR9r029K8HvpXlgEvEyvfL7cEFMzb2H3AtEJtK7u
         qE5k5omzpWt/sD+s9H5YTDUHfLlZAy5BM7ZEY8vZHvifSa719a9jCRA5Q3ht+izOuHw/
         0uRWrWLOFHDezTapAfxIoiJlbGMqDWGHH6TixwjCOY1yd6BOflLlcN3XU4v+s7ABMnCu
         b6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030354; x=1780635154;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CEx5T9t4bR3wMQ8JDf/X+nGS+pnh0j1PzKpdwnppXPM=;
        b=VWb1PGIoA9vqGRBpY+rYsitUQrnXYG7n4/Lo2Cj5llZrcQWWz+c9/ImBRakuq0AwRv
         Du8s3I3COo7PjrmQToeJN21MFNqv2ZD8BRLSKEEdK2MWNHe3diNtXoKXLKRlDX6F7Jyh
         y4iLlu2NvbvBWbkjJphJr7aZ1PqBM/VxKlbI8KAsapgAp7oCyQ9x6wHG4uxCaWccXGs0
         2RGP16s45opLD5uvMDAND84oObL/gJuR5R1ZTnn2ZH/hwv61XIbJBTfZ+RB3hmn3KLsk
         m/8tLbIDgwYrw7mX1jLQKxcg/ysZAEkna/qBzR11n68KD8qlBLFP1rzAdEJioCaFDYSV
         eqgg==
X-Forwarded-Encrypted: i=1; AFNElJ8tPgbEbzHLKUIHJUiWZ1CGYBFI1EUAV1K8du5KLwIKDfh/eBaHXO/Uzz7AamvLQF6LB7lmbmzgrjTFs5riZvRv@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/j4rUvrTEghrSwbI7lU4kSqgNZo6AZ6pKoBydG9DT3BnzLZX
	BzbbAvuzN+mMoH+P/4SgzdBES3g1cxly8NSn1M1Q5MUr8jQxiLIeAqBVIpVL2Tf7MIbnldk8Cu4
	JAy5CEffHtQ==
X-Received: from pfzz14.prod.google.com ([2002:a05:6a00:1ee:b0:841:f336:296f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2c99:b0:841:dca1:8b69
 with SMTP id d2e1a72fcca58-84212b9f59bmr1336839b3a.5.1780030353450; Thu, 28
 May 2026 21:52:33 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:46 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-5-irogers@google.com>
Subject: [PATCH v1 04/12] perf vendor events intel: Update clearwaterforest
 events and metrics from 1.00 to 1.02
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
Content-Transfer-Encoding: quoted-printable

The updated events and metrics were published in:
https://github.com/intel/perfmon/commit/6de6be144b5ea747690a74106f180269c3d=
647b0
https://github.com/intel/perfmon/commit/e7f5e6092c3e4c11f350c0468ddecb0e1e8=
18b76
https://github.com/intel/perfmon/commit/9c1a1baa5156efbe9325392194d2bf5d1c8=
bcb92
https://github.com/intel/perfmon/commit/6055edb3c30634fc913250b562c0fc42ac4=
eb523

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/clearwaterforest/cache.json      |  525 ++-
 .../arch/x86/clearwaterforest/counter.json    |   79 +-
 .../x86/clearwaterforest/cwf-metrics.json     |  310 ++
 .../x86/clearwaterforest/floating-point.json  |  191 +
 .../arch/x86/clearwaterforest/frontend.json   |  226 ++
 .../arch/x86/clearwaterforest/memory.json     |   92 +
 .../arch/x86/clearwaterforest/other.json      |   20 +
 .../arch/x86/clearwaterforest/pipeline.json   |  829 +++-
 .../x86/clearwaterforest/uncore-cache.json    | 3413 +++++++++++++++++
 .../arch/x86/clearwaterforest/uncore-cxl.json |   31 +
 .../clearwaterforest/uncore-interconnect.json | 1625 ++++++++
 .../arch/x86/clearwaterforest/uncore-io.json  | 1925 ++++++++++
 .../x86/clearwaterforest/uncore-memory.json   |  883 +++++
 .../x86/clearwaterforest/uncore-power.json    |  109 +
 .../x86/clearwaterforest/virtual-memory.json  |   94 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 16 files changed, 10307 insertions(+), 47 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/cwf-met=
rics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/floatin=
g-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.j=
son
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-=
cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-=
cxl.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-=
interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-=
io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-=
memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-=
power.json

diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json b/t=
ools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
index ecb7dc252208..480874ccbd09 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
@@ -1,4 +1,140 @@
 [
+    {
+        "BriefDescription": "Counts the number of requests that were not a=
ccepted into the L2Q because the L2Q is FULL.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x31",
+        "EventName": "CORE_REJECT_L2Q.ANY",
+        "PublicDescription": "Counts the number of (demand and L1 prefetch=
ers) core requests rejected by the L2Q due to a full or nearly full conditi=
on which likely indicates back pressure from L2Q. It also counts requests t=
hat would have gone directly to the XQ, but are rejected due to a full or n=
early full condition, indicating back pressure from the IDI link. The L2Q m=
ay also reject transactions from a core to ensure fairness between cores, o=
r to delay a core's dirty eviction when the address conflicts with incoming=
 external snoops. Note that L2 prefetcher requests that are dropped are not=
 counted by this event. Counts on a per core basis.",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of demand and prefetch tran=
sactions that the External Queue (XQ) rejects due to a full or near full co=
ndition.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x30",
+        "EventName": "L2_REJECT_XQ.ANY",
+        "PublicDescription": "Counts the number of demand and prefetch tra=
nsactions that the External Queue (XQ) rejects due to a full or near full c=
ondition which likely indicates back pressure from the IDI link.  The IDI l=
ink is a central on-die protocol for memory and coherence traffic between t=
he core and the uncore. It is highly optimized for efficiency, bandwidth, a=
nd coherency, using multiple channels and flow control mechanisms to manage=
 high-throughput, low-latency data and protocol communication within the ch=
ip. The XQ may reject transactions from the L2Q (non-cacheable requests), B=
BL (L2 misses) and WOB (L2 write-back victims).",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door requests for Code Read, Data Read, RFO, ITOM, and L2 Prefetches. =
Does not include rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1ff"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Code Read requests. Does not include rejects or recycles, =
per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_CODE_RD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc4"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Code Read requests that resulted in a hit. Does not includ=
e rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_CODE_RD_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x84"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Code Read requests that resulted in a Miss. Does not inclu=
de rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_CODE_RD_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x44"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Data Read requests. Does not include rejects or recycles, =
per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_DATA_RD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc1"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Data Read requests that resulted in a hit. Does not includ=
e rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_DATA_RD_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Data Read requests that resulted in a Miss. Does not inclu=
de rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_DATA_RD_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand RFO requests. Does not include rejects or recycles, per co=
re event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_RFO",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc2"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand RFO requests that resulted in a hit. Does not include reje=
cts or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_RFO_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand RFO requests that resulted in a Miss. Does not include rej=
ects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_RFO_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door requests that resulted in a Hit. Does not include rejects or recy=
cles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1bf"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Hardware Prefetch requests, including hits and misses. Does not i=
nclude rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HWPF",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc8"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Hardware Prefetch requests that result in a hit. Does not include=
 rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HWPF_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x88"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Hardware Prefetch requests that result in a miss. Does not includ=
e rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HWPF_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x48"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door requests that resulted in a Miss. Does not include rejects or rec=
ycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x17f"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -17,6 +153,231 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x4f"
     },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.L2_HIT",
+        "PublicDescription": "Counts the number of cycles a core is stalle=
d due to a demand load which hit in the L2 cache.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC, no snoop w=
as required. LLC provided data.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT_NOSNOOP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC, a snoop wa=
s required, the snoop misses  or the snoop hits but no fwd. LLC provides th=
e data.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT_SNOOP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the caches.  DR=
AM, MMIO or other LOCAL memory type provides the data.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS_LOCALMEM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the caches, a s=
noop was required, and hits in other core or module on same die.  Another c=
ore provides the data with a fwd, no fwd, or hitM.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS_OTHERMOD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the total number of load ops retired t=
hat miss the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.ALL",
+        "PublicDescription": "Counts the total number of load ops retired =
that miss the L3 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss the L3 cache and hit in DRAM Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in a Remote DRAM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM_OR_NOFWD",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss the L3 cache and hit in a Remote DRAM, OR had a Remote snoop miss/no fw=
d and hit in the Local DRAM. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in a Remote Cache and modified data was forwarded",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD_HITM",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss the L3 cache and hit in a Remote Cache and modified data was forwarded =
Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in a Remote Cache and non-modified data was forward=
ed",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD_NONM",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss the L3 cache and hit in a Remote Cache and non-modified data was forwar=
ded Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which a snoop was required and modified data was forwa=
rded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.L3_HIT_SNOOP_HITM",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L3 cache in which a snoop was required and modified data was forw=
arded. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which a snoop was required and no data was forwarded."=
,
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.L3_HIT_SNOOP_NO_FWD",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L3 cache in which a snoop was required and no data was forwarded.=
 Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which a snoop was required and non-modified data was f=
orwarded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.L3_HIT_SNOOP_WITH_FWD",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L3 cache in which a snoop was required and non-modified data was =
forwarded. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t the L1 data cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
+        "PublicDescription": "Counts the number of load ops retired that h=
it the L1 data cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the L1 data cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss in the L1 data cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L2 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss in the L2 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L3 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1c"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which no snoop was required.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT_NO_SNOOP",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L3 cache in which no snoop was required. Available PDIST counters=
: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which a snoop was required and it hit and forwarded da=
ta, it hit and did not forward data, or it hit and the forwarded data was m=
odified.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT_SNOOP_HIT",
+        "PublicDescription": "Counts the number of load ops retired that h=
it in the L3 cache in which a snoop was required and it hit and forwarded d=
ata, it hit and did not forward data, or it hit and the forwarded data was =
modified. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a load buffer full condition.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to an RSV full condition.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.RSV",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a store buffer full condition.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x04",
+        "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of memory uops retired.  A =
single uop that performs both a load AND a store will be counted as 1, not =
2 (e.g. ADD [mem], CONST).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.ALL",
+        "PublicDescription": "Counts the number of memory uops retired.  A=
 single uop that performs both a load AND a store will be counted as 1, not=
 2 (e.g. ADD [mem], CONST). Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x83"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -36,121 +397,213 @@
         "UMask": "0x82"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 1024.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
-        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold of 1024. Available PDIST counters: 0,1"=
,
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 128.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold of 128. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 16.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold of 16. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 2048.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x800",
-        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold of 2048. Available PDIST counters: 0,1"=
,
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 256.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold of 256. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 32.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold of 32. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 4.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold of 4. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 512.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold of 512. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 64.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold of 64. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 8.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD=
 - Only counts with PEBS enabled. Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d that exceed the latency threshold of 8. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
     {
-        "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Counts the number of load uops retired that p=
erformed one or more locks",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
+        "PublicDescription": "Counts the number of load uops retired that =
performed one or more locks Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x21"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that w=
ere correctly predicated by the memory renaming (MRN) feature.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.MRN_LOADS",
+        "PublicDescription": "Counts the number of load uops retired that =
were correctly predicated by the memory renaming (MRN) feature.  MRN loads =
are a part of the memory renaming process that optimizes data forwarding be=
tween stores and loads, reducing latency and improving performance. This in=
volves tagging stores that forward to loads and copying the physical source=
 (the actual data) directly from the store to the load.  The MRN'd load can=
 complete without accessing the memory, thus reducing load-to-use latency. =
Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x9"
+    },
+    {
+        "BriefDescription": "Counts the number of store uops retired that =
were correctly tagged by the memory renaming (MRN) feature.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.MRN_STORES",
+        "PublicDescription": "Counts the number of store uops retired that=
 were correctly tagged by the memory renaming (MRN) feature.  MRN stores ar=
e a part of the memory renaming process that optimizes data forwarding betw=
een stores and loads, reducing latency and improving performance. This invo=
lves tagging stores that forward to loads and copying the physical source (=
the actual data) directly from the store to the load.  The MRN store ensure=
s that it's data is accurately forwarded to matching subsequent loads. Avai=
lable PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xa"
+    },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 were splits.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT",
+        "PublicDescription": "Counts the number of memory uops retired tha=
t were splits. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x43"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split load uops.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
+        "PublicDescription": "Counts the number of retired split load uops=
. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x41"
+    },
+    {
+        "BriefDescription": "Counts the number of retired split store uops=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.SPLIT_STORES",
+        "PublicDescription": "Counts the number of retired split store uop=
s. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x42"
+    },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 missed in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
+        "PublicDescription": "Counts the number of memory uops retired tha=
t missed in the second level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x13"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the second Level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "PublicDescription": "Counts the number of load uops retired that =
miss in the second Level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Counts the number of store uops retired that =
miss in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "PublicDescription": "Counts the number of store uops retired that=
 miss in the second level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x12"
+    },
+    {
+        "BriefDescription": "Counts the number of stores uops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
-        "PublicDescription": "Counts the number of  stores uops retired sa=
me as MEM_UOPS_RETIRED.ALL_STORES Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of stores uops retired. Av=
ailable PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
@@ -175,5 +628,13 @@
         "PublicDescription": "Counts demand read for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to an icache miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ICACHE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/counter.json b=
/tools/perf/pmu-events/arch/x86/clearwaterforest/counter.json
index a0eaf5b6f2bc..03c2e5f77204 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/counter.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/counter.json
@@ -1,7 +1,82 @@
 [
     {
         "Unit": "core",
-        "CountersNumFixed": "3",
-        "CountersNumGeneric": "39"
+        "CountersNumFixed": "7",
+        "CountersNumGeneric": "8"
+    },
+    {
+        "Unit": "B2CMI",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "CHA",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "IMC",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "B2HOT",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "IIO",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "IRP",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "UPI",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "B2UPI",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "B2CXL",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "UBOX",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "2"
+    },
+    {
+        "Unit": "PCU",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "CHACMS",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "MDF",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
+    {
+        "Unit": "CXLCM",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 8
+    },
+    {
+        "Unit": "CXLDP",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/cwf-metrics.js=
on b/tools/perf/pmu-events/arch/x86/clearwaterforest/cwf-metrics.json
new file mode 100644
index 000000000000..bff8841096cd
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/cwf-metrics.json
@@ -0,0 +1,310 @@
+[
+    {
+        "BriefDescription": "C1 residency percent per core",
+        "MetricExpr": "cstate_core@c1\\-residency@ / msr@tsc@",
+        "MetricGroup": "Power",
+        "MetricName": "C1_Core_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / msr@tsc@",
+        "MetricGroup": "Power",
+        "MetricName": "C2_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "cstate_core@c6\\-residency@ / msr@tsc@",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C6 residency percent per package",
+        "MetricExpr": "cstate_pkg@c6\\-residency@ / msr@tsc@",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
+        "MetricName": "cpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "The average number of cores that are in cstat=
e C0 as observed by the power control unit (PCU)",
+        "MetricExpr": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0 / pcu_0@UNC_P_=
CLOCKTICKS@ * #num_packages",
+        "MetricName": "cpu_cstate_c0"
+    },
+    {
+        "BriefDescription": "The average number of cores are in cstate C6 =
as observed by the power control unit (PCU)",
+        "MetricExpr": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6 / pcu_0@UNC_P_=
CLOCKTICKS@ * #num_packages",
+        "MetricName": "cpu_cstate_c6"
+    },
+    {
+        "BriefDescription": "CPU operating frequency (in GHz)",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC =
* #SYSTEM_TSC_FREQ / 1e9",
+        "MetricName": "cpu_operating_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Percentage of time spent in the active CPU po=
wer state C0",
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "MetricName": "cpu_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
+        "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
+        "MetricName": "dtlb_2nd_level_load_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
+        "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
+        "MetricName": "dtlb_2nd_level_store_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Bandwidth observed by the integrated I/O traf=
fic controller (IIO) of IO reads that are initiated by end device controlle=
rs that are requesting memory from the CPU",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS * 4 / 1e=
6 / duration_time",
+        "MetricName": "iio_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth observed by the integrated I/O traf=
fic controller (IIO) of IO writes that are initiated by end device controll=
ers that are writing memory to the CPU",
+        "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS * 4 / 1=
e6 / duration_time",
+        "MetricName": "iio_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e6 / durati=
on_time",
+        "MetricName": "io_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of inbound IO reads that are initia=
ted by end device controllers that are requesting memory from the CPU and m=
iss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR * 64 / 1e6 / d=
uration_time",
+        "MetricName": "io_bandwidth_read_l3_miss",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the local CPU socket"=
,
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL * 64 / 1e6 / =
duration_time",
+        "MetricName": "io_bandwidth_read_local",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from a remote CPU socket",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_REMOTE * 64 / 1e6 /=
 duration_time",
+        "MetricName": "io_bandwidth_read_remote",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM + UNC_CHA_TOR_INSERTS.=
IO_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of inbound IO writes that are initi=
ated by end device controllers that are writing memory to the CPU",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_MISS_ITOM + UNC_CHA_TOR_INS=
ERTS.IO_MISS_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write_l3_miss",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the local CPU socket",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM_LOCAL + UNC_CHA_TOR_IN=
SERTS.IO_ITOMCACHENEAR_LOCAL) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write_local",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to a remote CPU socket",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM_REMOTE + UNC_CHA_TOR_I=
NSERTS.IO_ITOMCACHENEAR_REMOTE) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write_remote",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "The percent of inbound full cache line writes=
 initiated by IO that miss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM / UNC_CHA_TOR_INSE=
RTS.IO_ITOM",
+        "MetricName": "io_full_write_l3_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "The number of times per second that ownership=
 of a cacheline was stolen from the integrated IO controller before it was =
able to write back the modified line",
+        "MetricExpr": "(UNC_I_MISC1.LOST_FWD + UNC_I_MISC1.SEC_RCVD_INVLD)=
 / duration_time",
+        "MetricName": "io_lost_fwd",
+        "ScaleUnit": "1per_sec"
+    },
+    {
+        "BriefDescription": "Message Signaled Interrupts (MSI) per second =
sent by the integrated I/O traffic controller (IIO) to System Configuration=
 Controller (Ubox)",
+        "MetricExpr": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED / duratio=
n_time",
+        "MetricName": "io_msi",
+        "ScaleUnit": "1per_sec"
+    },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR + UNC_CHA_TOR=
_INSERTS.IO_RFO) / duration_time",
+        "MetricName": "io_number_of_partial_pci_writes",
+        "ScaleUnit": "1per_sec"
+    },
+    {
+        "BriefDescription": "The percent of inbound partial writes initiat=
ed by IO that miss the L3 cache",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR + UNC_CH=
A_TOR_INSERTS.IO_MISS_RFO) / (UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR + UNC_CH=
A_TOR_INSERTS.IO_RFO)",
+        "MetricName": "io_partial_write_l3_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "The percent of inbound reads initiated by IO =
that miss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR / UNC_CHA_TOR_=
INSERTS.IO_PCIRDCUR",
+        "MetricName": "io_read_l3_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
+        "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
+        "MetricName": "itlb_2nd_level_mpi",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 in L1 instruction cache (includes prefetches) to the total number of compl=
eted instructions",
+        "MetricExpr": "ICACHE.MISSES / INST_RETIRED.ANY",
+        "MetricName": "l1_i_code_read_misses_with_prefetches_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of demand load requests hitti=
ng in L1 data cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L1_HIT / INST_RETIRED.ANY",
+        "MetricName": "l1d_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed demand load requ=
ests hitting in L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L2_HIT / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_hits_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of completed data read reques=
t missing L2 cache to the total number of completed instructions",
+        "MetricExpr": "MEM_LOAD_UOPS_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "MetricName": "l2_demand_data_read_mpi",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of code read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_CRD + UNC_CHA_TOR_INSE=
RTS.IA_MISS_CRD_PREF) / INST_RETIRED.ANY",
+        "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT + UNC_CHA_TOR_=
INSERTS.IA_MISS_DRD_OPT_PREF + UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA) / I=
NST_RETIRED.ANY",
+        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) in nano seconds",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_OPT) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_=
CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT) * #num_packages)) * duration_time",
+        "MetricName": "llc_demand_data_read_miss_latency",
+        "ScaleUnit": "1ns"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_LOCAL * 64 / 1e6 / duration_=
time",
+        "MetricName": "llc_miss_local_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_LOCAL * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_local_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.READS_REMOTE * 64 / 1e6 / duration=
_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory",
+        "MetricExpr": "UNC_CHA_REQUESTS.WRITES_REMOTE * 64 / 1e6 / duratio=
n_time",
+        "MetricName": "llc_miss_remote_memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY",
+        "MetricName": "loads_retired_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "DDR memory read bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT_SCH0.RD + UNC_M_CAS_COUNT_SCH1.RD)=
 * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT_SCH0.RD + UNC_M_CAS_COUNT_SCH1.RD =
+ UNC_M_CAS_COUNT_SCH0.WR + UNC_M_CAS_COUNT_SCH1.WR) * 64 / 1e6 / duration_=
time",
+        "MetricName": "memory_bandwidth_total",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "DDR memory write bandwidth (MB/sec)",
+        "MetricExpr": "(UNC_M_CAS_COUNT_SCH0.WR + UNC_M_CAS_COUNT_SCH1.WR)=
 * 64 / 1e6 / duration_time",
+        "MetricName": "memory_bandwidth_write",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_LOCAL + UNC_CH=
A_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL) / (UNC_CHA_TOR_INSERTS.IA_MISS_DR=
D_OPT_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL + UNC_CHA_TOR_=
INSERTS.IA_MISS_DRD_OPT_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_R=
EMOTE)",
+        "MetricName": "numa_reads_addressed_to_local_dram",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_REMOTE + UNC_C=
HA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_REMOTE) / (UNC_CHA_TOR_INSERTS.IA_MISS_=
DRD_OPT_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL + UNC_CHA_TO=
R_INSERTS.IA_MISS_DRD_OPT_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF=
_REMOTE)",
+        "MetricName": "numa_reads_addressed_to_remote_dram",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Percentage of cycles spent in System Manageme=
nt Interrupts.",
+        "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0=
 else 0)",
+        "MetricGroup": "smi",
+        "MetricName": "smi_cycles",
+        "MetricThreshold": "smi_cycles > 0.1",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Number of SMI interrupts.",
+        "MetricExpr": "msr@smi@",
+        "MetricGroup": "smi",
+        "MetricName": "smi_num",
+        "ScaleUnit": "1SMI#"
+    },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "MEM_UOPS_RETIRED.ALL_STORES / INST_RETIRED.ANY",
+        "MetricName": "stores_retired_per_instr",
+        "ScaleUnit": "1per_instr"
+    },
+    {
+        "BriefDescription": "Uncore operating frequency in GHz",
+        "MetricExpr": "UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_CLOCKTIC=
KS) * #num_packages) / 1e9 / duration_time",
+        "MetricName": "uncore_frequency",
+        "ScaleUnit": "1GHz"
+    },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data t=
ransmit bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e=
6 / duration_time",
+        "MetricName": "upi_data_transmit_bw",
+        "ScaleUnit": "1MB/s"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/floating-point=
.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/floating-point.json
new file mode 100644
index 000000000000..34d7a50d2fd8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/floating-point.json
@@ -0,0 +1,191 @@
+[
+    {
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point dividers =
per cycle in the loop stage.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point divider u=
ops executed per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of all types of floating po=
int operations per uop with all default weighting",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.ALL",
+        "PublicDescription": "Counts the number of all types of floating p=
oint operations per uop with all default weighting Available PDIST counters=
: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s that produce 32 bit single precision results",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.FP32",
+        "PublicDescription": "Counts the number of floating point operatio=
ns that produce 32 bit single precision results Available PDIST counters: 0=
,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s that produce 64 bit double precision results",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc8",
+        "EventName": "FP_FLOPS_RETIRED.FP64",
+        "PublicDescription": "Counts the number of floating point operatio=
ns that produce 64 bit double precision results Available PDIST counters: 0=
,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a packed 128 bit double precision floating point. This may b=
e SSE or AVX.128 operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.128B_DP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a packed 128 bit double precision floating point. This may =
be SSE or AVX.128 operations. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a packed 128 bit single precision floating point. This may b=
e SSE or AVX.128 operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.128B_SP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a packed 128 bit single precision floating point. This may =
be SSE or AVX.128 operations. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a packed 256 bit double precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.256B_DP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a packed 256 bit double precision floating point. Available=
 PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a packed 256 bit single precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.256B_SP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a packed 256 bit single precision floating point. Available=
 PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a scalar 32bit single precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.32B_SP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a scalar 32bit single precision floating point. Available P=
DIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of retired instructions who=
se sources are a scalar 64 bit double precision floating point.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.64B_DP",
+        "PublicDescription": "Counts the number of retired instructions wh=
ose sources are a scalar 64 bit double precision floating point. Available =
PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the total number of  floating point re=
tired instructions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc7",
+        "EventName": "FP_INST_RETIRED.ALL",
+        "PublicDescription": "Counts the total number of  floating point r=
etired instructions. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3f"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on all flo=
ating point ports.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1f"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 0.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 1.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.P3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer port 0, 1, 2, 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.PRIMARY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1e"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on floatin=
g point and vector integer store data port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb2",
+        "EventName": "FP_VINT_UOPS_EXECUTED.STD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FP_ASSIST",
+        "PublicDescription": "Counts the number of floating point operatio=
ns retired that required microcode assist, which is not a reflection of the=
 number of FP operations, instructions or uops.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point divide uo=
ps retired (x87 and sse, including x87 sqrt).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.FPDIV",
+        "PublicDescription": "Counts the number of floating point divide u=
ops retired (x87 and sse, including x87 sqrt). Available PDIST counters: 0,=
1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/frontend.json =
b/tools/perf/pmu-events/arch/x86/clearwaterforest/frontend.json
index 7a9250e5c8f2..b71d6ae1abe8 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/frontend.json
@@ -1,4 +1,206 @@
 [
+    {
+        "BriefDescription": "Counts the total number of BACLEARS due to al=
l branch types including conditional and unconditional jumps, returns, and =
indirect branches.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.ANY",
+        "PublicDescription": "Counts the total number of BACLEARS, which o=
ccur when the Branch Target Buffer (BTB) prediction or lack thereof, was co=
rrected by a later branch predictor in the frontend.  Includes BACLEARS due=
 to all branch types including conditional and unconditional jumps, returns=
, and indirect branches.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of BACLEARS due to a condit=
ional jump.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.COND",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of BACLEARS due to an indir=
ect branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.INDIRECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of BACLEARS due to a return=
 branch.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.RETURN",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of BACLEARS due to a direct=
, unconditional jump.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe6",
+        "EventName": "BACLEARS.UNCOND",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged with having preceded with frontend bound behavior",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ALL",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged with having preceded with frontend bound behavior Available =
PDIST counters: 0,1",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a baclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_DETECT",
+        "PublicDescription": "Counts the number of instruction retired tha=
t are tagged after a branch instruction causes bubbles/empty issue slots du=
e to a baclear Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles /empty issue slots du=
e to a btclear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.BRANCH_RESTEER",
+        "PublicDescription": "Counts the number of instruction retired tha=
t are tagged after a branch instruction causes bubbles /empty issue slots d=
ue to a btclear Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged following an ms flow due to the bubble/wasted issue slot from=
 exiting long ms flow",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.CISC",
+        "PublicDescription": "Counts the number of  instructions retired t=
hat were tagged following an ms flow due to the bubble/wasted issue slot fr=
om exiting long ms flow Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged every cycle the decoder is unable to send 3 uops per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.DECODE",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged every cycle the decoder is unable to send 3 uops per cycle. =
Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ica=
che miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ICACHE",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to ic=
ache miss Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.ITLB_MISS",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to IT=
LB miss Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired tagg=
ed after a wasted issue slot if none of the previous events occurred",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.OTHER",
+        "PublicDescription": "Counts the number of instruction retired tag=
ged after a wasted issue slot if none of the previous events occurred Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of instruction retired that=
 are tagged after a branch instruction causes bubbles/empty issue slots due=
 to a predecode wrong.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc6",
+        "EventName": "FRONTEND_RETIRED.PREDECODE",
+        "PublicDescription": "Counts the number of instruction retired tha=
t are tagged after a branch instruction causes bubbles/empty issue slots du=
e to a predecode wrong. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to Ins=
truction L1 cache miss, that hit in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ICACHE_L2_HIT",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to In=
struction L1 cache miss, that hit in the L2 cache. Available PDIST counters=
: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to Ins=
truction L1 cache miss, that also missed in the L2 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ICACHE_L2_MISS",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to In=
struction L1 cache miss, that also missed in the L2 cache. Available PDIST =
counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to Ins=
truction L1 cache miss, that hit in the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ICACHE_L3_HIT",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to In=
struction L1 cache miss, that hit in the L3 cache. Available PDIST counters=
: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x6"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to Ins=
truction L1 cache miss, that hit in the L3 cache, and did not have to snoop=
 another core.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ICACHE_L3_HIT_NO_SNOOP",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to In=
struction L1 cache miss, that hit in the L3 cache, and did not have to snoo=
p another core. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to Ins=
truction L1 cache miss, that hit in the L3 cache, and required a snoop (tha=
t resulted in a snoop miss, snoop hitm, snoop hit with fwd, or snoop hit wi=
th no fwd).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ICACHE_L3_HIT_WITH_SNOOP",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to In=
struction L1 cache miss, that hit in the L3 cache, and required a snoop (th=
at resulted in a snoop miss, snoop hitm, snoop hit with fwd, or snoop hit w=
ith no fwd). Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to Ins=
truction L1 cache miss, that also missed in the L2 and L3 caches.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ICACHE_L3_MISS",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to In=
struction L1 cache miss, that also missed in the L2 and L3 caches. Availabl=
e PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss that hit in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ITLB_STLB_HIT",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to IT=
LB miss that hit in the second level TLB. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss that also missed the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.ITLB_STLB_MISS",
+        "PublicDescription": "Counts the number of instructions retired th=
at were tagged because empty issue slots were seen before the uop due to IT=
LB miss that also missed the second level TLB. Available PDIST counters: 0,=
1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of instructions retired tha=
t were preceded by empty issue slots at allocation due to an Instruction L1=
 cache miss, that matched a current outstanding prefetch request initiated =
by a Code SWPF stream.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc9",
+        "EventName": "FRONTEND_RETIRED_SOURCE.LATE_SWPF",
+        "PublicDescription": "Counts the number of instructions retired th=
at were preceded by empty issue slots at allocation due to an Instruction L=
1 cache miss, that matched a current outstanding prefetch request initiated=
 by a Code SWPF stream. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -7,6 +209,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
+    {
+        "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump and the instruction cache registers bytes are present.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x80",
+        "EventName": "ICACHE.HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts every time the code stream enters into=
 a new cache line by walking sequential from the previous line or being red=
irected by a jump and the instruction cache registers bytes are not present=
. -",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -14,5 +224,21 @@
         "EventName": "ICACHE.MISSES",
         "SampleAfterValue": "1000003",
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
+    },
+    {
+        "BriefDescription": "Counts the number of times entered into a uco=
de flow in the FEC.  Includes inserted flows due to front-end detected faul=
ts or assists.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "MS_DECODED.MS_ENTRY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json b/=
tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
index 58e543550279..ae9095a090e5 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
@@ -1,4 +1,96 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a core bound stall includin=
g a store address match, a DTLB miss or a page walk that detains the load f=
rom retiring.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_BOUND_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xf4"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a DL1 miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DL1 =
miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to other block cases.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.OTHER",
+        "PublicDescription": "Counts the number of cycles that the head (o=
ldest load) of the load buffer is stalled due to other block cases such as =
pipeline conflicts, fences, etc.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to other =
block cases.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.OTHER_AT_RET",
+        "PublicDescription": "Counts the number of cycles that the head (o=
ldest load) of the load buffer and retirement are both stalled due to other=
 block cases such as pipeline conflicts, fences, etc.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc0"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to request buffers full or loc=
k in progress.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to reques=
t buffers full or lock in progress.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING_FAST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8002"
+    },
+    {
+        "BriefDescription": "Counts misaligned loads that are 4K page spli=
ts.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "MISALIGN_MEM_REF.LOAD_PAGE_SPLIT",
+        "PublicDescription": "Counts misaligned loads that are 4K page spl=
its. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts misaligned stores that are 4K page spl=
its.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x13",
+        "EventName": "MISALIGN_MEM_REF.STORE_PAGE_SPLIT",
+        "PublicDescription": "Counts misaligned stores that are 4K page sp=
lits. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json b/t=
ools/perf/pmu-events/arch/x86/clearwaterforest/other.json
new file mode 100644
index 000000000000..2c8721903610
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
@@ -0,0 +1,20 @@
+[
+    {
+        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL. [This event is alias to MISC_RET=
IRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe4",
+        "EventName": "LBR_INSERTS.ANY",
+        "PublicDescription": "Counts the number of LBR entries recorded. R=
equires LBRs to be enabled in IA32_LBR_CTL. [This event is alias to MISC_RE=
TIRED.LBR_INSERTS] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the total number of BTCLEARS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe8",
+        "EventName": "PREDICTION.BTCLEAR",
+        "PublicDescription": "Counts the total number of BTCLEARS which oc=
curs when the Branch Target Buffer (BTB) predicts a taken branch.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json =
b/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
index 26bd12fefa3d..3d10dcffb8fc 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
@@ -1,4 +1,38 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point or integer dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles when any of the i=
nteger dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts number of active integer dividers per =
cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of integer divider uops exe=
cuted per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -7,6 +41,211 @@
         "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for. Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003"
     },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_INDIRECT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_NEAR_IND",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_INDIRECT] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_INDIRECT_OR_RETURN]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.ALL_NEAR_IND_OR_RET",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_INDIRECT_OR_RETURN] Available PDIST counters: 0,=
1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x58"
+    },
+    {
+        "BriefDescription": "Counts the number of conditional branch instr=
uctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND",
+        "PublicDescription": "Counts the number of conditional branch inst=
ructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts the number of not taken conditional br=
anch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_NTAKEN",
+        "PublicDescription": "Counts the number of not taken conditional b=
ranch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of taken conditional branch=
 instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PublicDescription": "Counts the number of taken conditional branc=
h instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of taken backward condition=
al branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN_BWD",
+        "PublicDescription": "Counts the number of taken backward conditio=
nal branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of taken forward conditiona=
l branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
+        "PublicDescription": "Counts the number of taken forward condition=
al branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_CALL",
+        "PublicDescription": "Counts the number of near CALL branch instru=
ctions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x30"
+    },
+    {
+        "BriefDescription": "Counts the number of near direct CALL branch =
instructions retired. [This event is alias to BR_INST_RETIRED.NEAR_DIR_CALL=
]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_DIRECT_CALL",
+        "PublicDescription": "Counts the number of near direct CALL branch=
 instructions retired. [This event is alias to BR_INST_RETIRED.NEAR_DIR_CAL=
L] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of near direct JMP branch i=
nstructions retired. [This event is alias to BR_INST_RETIRED.NEAR_DIR_JMP]"=
,
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_DIRECT_JMP",
+        "PublicDescription": "Counts the number of near direct JMP branch =
instructions retired. [This event is alias to BR_INST_RETIRED.NEAR_DIR_JMP]=
 Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_DIRECT_CALL]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_DIR_CALL",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_DIRECT_CALL] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_DIRECT_JMP]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_DIR_JMP",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_DIRECT_JMP] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired. [This event is alias to BR_IN=
ST_RETIRED.ALL_NEAR_IND]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT",
+        "PublicDescription": "Counts the number of near indirect JMP and n=
ear indirect CALL branch instructions retired. [This event is alias to BR_I=
NST_RETIRED.ALL_NEAR_IND] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50"
+    },
+    {
+        "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired. [This event is alias to BR_INST_RETIRED.NEAR_IND_CA=
LL]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT_CALL",
+        "PublicDescription": "Counts the number of near indirect CALL bran=
ch instructions retired. [This event is alias to BR_INST_RETIRED.NEAR_IND_C=
ALL] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP branch=
 instructions retired. [This event is alias to BR_INST_RETIRED.NEAR_IND_JMP=
]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT_JMP",
+        "PublicDescription": "Counts the number of near indirect JMP branc=
h instructions retired. [This event is alias to BR_INST_RETIRED.NEAR_IND_JM=
P] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP, near =
indirect CALL, and RET branch instructions retired. [This event is alias to=
 BR_INST_RETIRED.ALL_NEAR_IND_OR_RET]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_INDIRECT_OR_RETURN",
+        "PublicDescription": "Counts the number of near indirect JMP, near=
 indirect CALL, and RET branch instructions retired. [This event is alias t=
o BR_INST_RETIRED.ALL_NEAR_IND_OR_RET] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x58"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_INDIRECT_CALL]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_IND_CALL",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_INDIRECT_CALL] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_INDIRECT_JMP]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_IND_JMP",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_INDIRECT_JMP] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of near JMP branch instruct=
ions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_JMP",
+        "PublicDescription": "Counts the number of near JMP branch instruc=
tions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc0"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_RETURN]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RET",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_INST_RETIRED.NEAR_RETURN] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of near RET branch instruct=
ions retired. [This event is alias to BR_INST_RETIRED.NEAR_RET]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_RETURN",
+        "PublicDescription": "Counts the number of near RET branch instruc=
tions retired. [This event is alias to BR_INST_RETIRED.NEAR_RET] Available =
PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "PublicDescription": "Counts the number of near taken branch instr=
uctions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xfb"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -16,10 +255,47 @@
         "SampleAfterValue": "1000003"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_MISP_RETIRED.NEAR_INDIRECT]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.ALL_NEAR_IND",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to BR_MISP_RETIRED.NEAR_INDIRECT] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted not taken c=
onditional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
+        "PublicDescription": "Counts the number of mispredicted not taken =
conditional branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted taken condi=
tional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.COND_TAKEN",
+        "PublicDescription": "Counts the number of mispredicted taken cond=
itional branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired. [This event is a=
lias to BR_MISP_RETIRED.ALL_NEAR_IND]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.NEAR_INDIRECT",
+        "PublicDescription": "Counts the number of mispredicted near indir=
ect JMP and near indirect CALL branch instructions retired. [This event is =
alias to BR_MISP_RETIRED.ALL_NEAR_IND] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50"
+    },
+    {
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
@@ -27,13 +303,13 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
-        "SampleAfterValue": "1000003"
+        "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles.",
         "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "2000003",
         "UMask": "0x3"
     },
     {
@@ -42,14 +318,14 @@
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
     {
@@ -57,14 +333,14 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
-        "SampleAfterValue": "1000003"
+        "SampleAfterValue": "2000003"
     },
     {
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired.",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PublicDescription": "Fixed Counter: Counts the number of instruct=
ions retired. Available PDIST counters: 32",
-        "SampleAfterValue": "1000003",
+        "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
     {
@@ -73,15 +349,339 @@
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PublicDescription": "Counts the number of instructions retired. A=
vailable PDIST counters: 0,1",
+        "SampleAfterValue": "2000003"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on seconda=
ry integer ports 0,1,2,3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.2ND",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on all Int=
eger ports.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on a load =
port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.LD",
+        "PublicDescription": "Counts the number of uops executed on a load=
 port.  This event counts for integer uops even if the destination is FP/ve=
ctor",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 0.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P0",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 1.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 2.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P2",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.P3",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on integer=
 port  0,1, 2, 3.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.PRIMARY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x78"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on a Store=
 address port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.STA",
+        "PublicDescription": "Counts the number of uops executed on a Stor=
e address port. This event counts integer uops even if the data source is F=
P/vector",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of uops executed on an inte=
ger store data and jump port.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb3",
+        "EventName": "INT_UOPS_EXECUTED.STD_JMP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked because it initially appears to be store forward blocked, but subse=
quently is shown not to be blocked based on 4K alias check. Available PDIST=
 counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked for any of the following reasons:  DTLB miss, address alias, store f=
orward or data unknown (includes memory disambiguation blocks and ESP consu=
ming load blocks) and others.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.ALL",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked for any of the following reasons:  DTLB miss, address alias, store =
forward or data unknown (includes memory disambiguation blocks and ESP cons=
uming load blocks) and others. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1f"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.DATA_UNKNOWN",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked because its address exactly matches an older store whose data is no=
t ready. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked because its address partially overlapped with an older store.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.STORE_FORWARD",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked because its address partially overlapped with an older store. Avail=
able PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the total number of machine clears for=
 any reason including, but not limited to, memory ordering, memory disambig=
uation, SMC, and FP assist.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.ANY",
         "SampleAfterValue": "1000003"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.ANY_FAST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80ff"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.DISAMBIGUATION_FAST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8008"
+    },
+    {
+        "BriefDescription": "Counts the number of virtual traps taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FPC_VIRTUAL_TRAP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to me=
mory renaming.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MRN_NUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MRN_NUKE_FAST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8010"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.PAGE_FAULT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (self modifying code) within 1K of a recently fetched =
code page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.SMC",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (cross-core modifying code) within 1K of a recently fe=
tched code page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.XMC",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to LBR_INSERTS.ANY]",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
+        "EventCode": "0xe4",
+        "EventName": "MISC_RETIRED.LBR_INSERTS",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to LBR_INSERTS.ANY] Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of CLFLUSH, CLWB, and CLDEM=
OTE instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC_RETIRED1.CL_INST",
+        "PublicDescription": "Counts the number of CLFLUSH, CLWB, and CLDE=
MOTE instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff"
+    },
+    {
+        "BriefDescription": "Counts the number of LFENCE instructions reti=
red.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC_RETIRED1.LFENCE",
+        "PublicDescription": "Counts the number of LFENCE instructions ret=
ired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of accesses to KeyLocker ca=
che.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe1",
+        "EventName": "MISC_RETIRED2.KEYLOCKER_ACCESS",
+        "PublicDescription": "Counts the number of accesses to KeyLocker c=
ache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of misses to KeyLocker cach=
e.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe1",
+        "EventName": "MISC_RETIRED2.KEYLOCKER_MISS",
+        "PublicDescription": "Counts the number of misses to KeyLocker cac=
he. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state. For Tremont, UMWAIT and TPAUSE will onl=
y put the CPU into C0.1 activity state (not C0.2 activity state).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.C01_MS_SCB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots not consumed=
 due to a color request for an FCW or MXCSR control register when all 4 col=
ors (copies) are already in use.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.COLOR_STALLS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots where no uop=
 could issue due to an IQ scoreboard that stalls allocation until a specifi=
ed older uop retires or (in the case of jump scoreboard) executes. Commonly=
 executed instructions with IQ scoreboards include LFENCE and MFENCE.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.IQ_JEU_SCB",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots not consumed=
 by the backend due to a micro-sequencer (MS) scoreboard, which stalls the =
front-end from issuing from the UROM until a specified older uop retires.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.NON_C01_MS_SCB",
+        "PublicDescription": "Counts the number of issue slots not consume=
d by the backend due to a micro-sequencer (MS) scoreboard, which stalls the=
 front-end from issuing from the UROM until a specified older uop retires. =
The most commonly executed instruction with an MS scoreboard is PAUSE.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of issue slo=
ts that were not consumed by the backend because allocation is stalled due =
to a mispredicted jump or a machine clear.",
-        "Counter": "36",
+        "Counter": "Fixed counter 4",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.ALL_P",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window, including =
relevant microcode flows, and while uops are not yet available in the instr=
uction queue (IQ) or until an FE_BOUND event occurs besides OTHER and CISC.=
 Also includes the issue slots that were consumed by the backend but were t=
hrown away because they were younger than the mispredict or machine clear."=
,
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Fast Nukes such as  Memory Ord=
ering Machine clears and MRN nukes",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a branch mispredict that resul=
ted in LSD exit.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.LSD_MISPREDICT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Branch Mispredict",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls. [This event is alias to TOPDOWN_BE_BOUND.ALL_P=
]",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -90,6 +690,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to due to certain allocation rest=
rictions.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of retirement slots not con=
sumed due to backend stalls. [This event is alias to TOPDOWN_BE_BOUND.ALL]"=
,
         "Counter": "0,1,2,3,4,5,6,7",
@@ -98,18 +706,215 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to LSD entry.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.LSD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stall (sche=
duler not being able to accept another uop).  This could be caused by RSV f=
ull or load/store buffer block.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC and FPC RAT stalls - which=
 can be due to the FIQ and IEC reservation station stall (integer, FP and S=
IMD scheduler not being able to accept another uop).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to mrbl stall.  A marble refers t=
o a physical register file entry, also known as the physical destination (P=
DST).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REGISTER",
+        "PublicDescription": "Counts the number of issue slots every cycle=
 that were not consumed by the backend due to mrbl stall.  A 'marble' refer=
s to a physical register file entry, also known as the physical destination=
 (PDST).",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to ROB full",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to iq/jeu scoreboards or ms scb",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of retiremen=
t slots not consumed due to front end stalls.",
-        "Counter": "37",
+        "Counter": "Fixed counter 5",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
+    {
+        "BriefDescription": "Counts the number of retirement slots not con=
sumed due to front end stalls.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x9c",
+        "EventName": "TOPDOWN_FE_BOUND.ALL_P",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BAClear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTClear",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ms",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.CISC",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.DECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to frontend bandwidth restricti=
ons due to decode, predecode, cisc, and other limitations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8d"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to latency related stalls inclu=
ding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x72"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to itlb miss",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.ITLB_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend that do not categorize into any oth=
er common frontend stall",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.OTHER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to predecode wrong",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Fixed Counter: Counts the number of consumed =
retirement slots.",
-        "Counter": "38",
+        "Counter": "Fixed counter 6",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "SampleAfterValue": "1000003",
         "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts the number of consumed retirement slot=
s.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "TOPDOWN_RETIRING.ALL_P",
+        "PublicDescription": "Counts the number of consumed retirement slo=
ts. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of uops issued by the front=
 end every cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x0e",
+        "EventName": "UOPS_ISSUED.ANY",
+        "PublicDescription": "Counts the number of uops issued by the fron=
t end every cycle. When 4-uops are requested and only 2-uops are delivered,=
 the event counts 2. Uops_issued correlates to the number of ROB entries. I=
f uop takes 2 ROB slots it counts as 2 uops_issued.",
+        "SampleAfterValue": "1000003"
+    },
+    {
+        "BriefDescription": "Counts the number of uops retired that were d=
ual destination.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.DUAL_DEST",
+        "PublicDescription": "Counts the number of uops retired that were =
dual destination.  Dual destination (dual dest) micro-operations require wr=
iting to two separate destination registers or memory addresses upon execut=
ion. These uops consume two entries in the ROB and tracked separately becau=
se they involve more complex operations that necessitate multiple results. =
Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of uops retired that are th=
e last uop of a macro-instruction.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.EOM",
+        "PublicDescription": "Counts the number of uops retired that are t=
he last uop of a macro-instruction.   EOM uops indicate the 'end of a macro=
-instruction' and play a crucial role in the processor's control flow and r=
ecovery mechanisms.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of integer divide uops reti=
red.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.IDIV",
+        "PublicDescription": "Counts the number of integer divide uops ret=
ired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
+    {
+        "BriefDescription": "Counts the number of uops retired that origin=
ated from a loop stream detector.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.LSD",
+        "PublicDescription": "Counts the number of uops retired that origi=
nated from a loop stream detector. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS).  This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.MS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of x87 uops retired, includ=
es those in ms flows.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.X87",
+        "SampleAfterValue": "1000003"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.j=
son b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.json
new file mode 100644
index 000000000000..278837f2068a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.json
@@ -0,0 +1,3413 @@
+[
+    {
+        "BriefDescription": "Clockticks for CMS units attached to CHA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_CHACMS_CLOCKTICKS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "CHACMS"
+    },
+    {
+        "BriefDescription": "UNC_CHACMS_DISTRESS_ASSERTED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHACMS_DISTRESS_ASSERTED",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "CHACMS"
+    },
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
+    {
+        "BriefDescription": "Number of CHA clock cycles while the event is=
 enabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_CHA_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Clockticks of the uncore caching and home ag=
ent (CHA)",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts transactions that looked into the mult=
i-socket cacheline Directory state, and therefore did not send a snoop beca=
use the Directory indicated it was not needed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.NO_SNP",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts  transactions that looked into the mul=
ti-socket cacheline Directory state, and sent one or more snoops, because t=
he Directory indicated it was needed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x53",
+        "EventName": "UNC_CHA_DIR_LOOKUP.SNP",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts only multi-socket cacheline Directory =
state updates memory writes issued from the HA pipe. This does not include =
memory write requests which are for I (Invalid) or E (Exclusive) cachelines=
.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.HA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts only multi-socket cacheline Directory =
state updates due to memory writes issued from the TOR pipe which are the r=
esult of remote transaction hitting the SF/LLC and returning data Core2Core=
. This does not include memory write requests which are for I (Invalid) or =
E (Exclusive) cachelines.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_CHA_DIR_UPDATE.TOR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in TOR o=
r IRQ (immediate cause for triggering).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_ANY",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x3",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in IRQ (=
immediate cause for triggering).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_IRQ",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Distress signal assertion for dynamic prefetc=
h throttle (DPT).  Threshold for distress signal assertion reached in TOR (=
immediate cause for triggering).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x59",
+        "EventName": "UNC_CHA_DISTRESS_ASSERTED.DPT_TOR",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts when a normal (Non-Isochronous) full l=
ine write is issued from the CHA to the any of the memory controller channe=
ls.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Fu=
ll Line : Counts the total number of full line writes issued from the HA in=
to the memory controller.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.FULL_PRIORITY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : Partial =
Non-ISOCH : Counts the total number of full line writes issued from the HA =
into the memory controller.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CHA to iMC Full Line Writes Issued : ISOCH Pa=
rtial : Counts the total number of full line writes issued from the HA into=
 the memory controller.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x5b",
+        "EventName": "UNC_CHA_IMC_WRITES_COUNT.PARTIAL_PRIORITY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Requests to Remotely Homed=
 Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.ALL_REMOTE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : All transactions from Remote=
 Agents",
+        "UMask": "0x17e0ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: CRd Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.CODE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1bd0ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests and Read Prefetc=
hes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1bc1ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests, Read Prefetches=
, and Snoops",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Data Reads",
+        "UMask": "0x1fc1ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests to Locally Homed=
 Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Demand Data Reads, Core and =
LLC prefetches",
+        "UMask": "0x841ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests, Read Prefetches=
, and Snoops which miss the Cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.DATA_READ_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Data Read Misses",
+        "UMask": "0x1fc101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Requests to Locally Homed =
Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCALLY_HOMED_ADDRESS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Transactions homed locally",
+        "UMask": "0xbdfff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Read Requests and Code Re=
ad Prefetches to Locally Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_CODE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x19d0ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests and Read Prefetc=
hes to Locally Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DATA_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x19c1ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Read Requests to Locally =
Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_CODE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1850ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Requests to Locally Homed=
 Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_DATA_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1841ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests to Locally Homed =
Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_DMND_RFO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x1848ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: LLC Prefetch Requests to Local=
ly Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_LLC_PF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x189dff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Prefetches to Locally Home=
d Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x199dff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Prefetches to Locally Hom=
ed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_CODE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1910ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Read Prefetches to Locally Hom=
ed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_DATA_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1981ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Prefetches to Locally Home=
d Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_PF_RFO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x1908ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests and RFO Prefetche=
s to Locally Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.LOCAL_RFO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x19c8ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All Requests to Remotely Homed=
 Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTELY_HOMED_ADDRESS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Transactions homed remotely =
: Counts the number of times the LLC was accessed - this includes code, dat=
a, prefetches and hints coming from L2.  This has numerous filters availabl=
e.  Note the non-standard filtering equation.  This event will count reques=
ts that lookup the cache multiple times with multiple increments.  One must=
 ALWAYS set umask bit 0 and select a state or states to match.  Otherwise, =
the event will count nothing. : Transaction whose address resides in a remo=
te MC",
+        "UMask": "0x15dfff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Code Read/Prefetch Requests fr=
om a Remote Socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_CODE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : CRd Requests",
+        "UMask": "0x1a10ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Data Read/Prefetch Requests fr=
om a Remote Socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_DATA_RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed - this includes code, data, prefetches and hints coming from L2.  This =
has numerous filters available.  Note the non-standard filtering equation. =
 This event will count requests that lookup the cache multiple times with m=
ultiple increments.  One must ALWAYS set umask bit 0 and select a state or =
states to match.  Otherwise, the event will count nothing.   CHAFilter0[24:=
21,17] bits correspond to [FMESI] state. Read transactions",
+        "UMask": "0x1a01ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests/Prefetches from a=
 Remote Socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_RFO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : RFO Requests",
+        "UMask": "0x1a08ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Snoop Requests from a Remote S=
ocket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.REMOTE_SNP",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of times the LLC was acces=
sed",
+        "UMask": "0x1c19ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: All RFO and RFO Prefetches",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.RFO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : All RFOs - Demand and Prefet=
ches",
+        "UMask": "0x1bc8ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: RFO Requests and RFO Prefetche=
s to Locally Homed Memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.RFO_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Locally HOMed RFOs - Demand =
and Prefetches",
+        "UMask": "0x9c8ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Writes to Locally Homed Memory=
 (includes writebacks from L1/L2)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.WRITE_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Writes",
+        "UMask": "0x842ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Cache Lookups: Writes to Remotely Homed Memor=
y (includes writebacks from L1/L2)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHA_LLC_LOOKUP.WRITE_REMOTE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cache Lookups : Remote Writes",
+        "UMask": "0x17c2ff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : All Lines Victimized",
+        "UMask": "0xf",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : IA traffic : Counts the nu=
mber of lines that were victimized on a fill.  This can be filtered by the =
state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.IA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : IO traffic : Counts the nu=
mber of lines that were victimized on a fill.  This can be filtered by the =
state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.IO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - All Lines",
+        "UMask": "0x200f",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_E",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in E State"=
,
+        "UMask": "0x2002",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_F",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in F State"=
,
+        "UMask": "0x2008",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_M",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in M State"=
,
+        "UMask": "0x2001",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.LOCAL_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Local - Lines in S State"=
,
+        "UMask": "0x2004",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - All Lines",
+        "UMask": "0x800f",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_E",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - Lines in E State=
",
+        "UMask": "0x8002",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_M",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - Lines in M State=
",
+        "UMask": "0x8001",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Lines Victimized : Counts the number of lines=
 that were victimized on a fill.  This can be filtered by the state that th=
e line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.REMOTE_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Remote - Lines in S State=
",
+        "UMask": "0x8004",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_E",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Lines in E state",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_M",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Lines in M state",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of lines that were victimiz=
ed on a fill.  This can be filtered by the state that the line was in.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_CHA_LLC_VICTIMS.TOTAL_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Lines Victimized : Lines in S State",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts when a RFO (the Read for Ownership iss=
ued before a  write) request hit a cacheline in the S (Shared) state.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x39",
+        "EventName": "UNC_CHA_MISC.RFO_HIT_S",
+        "PerPkg": "1",
+        "PublicDescription": "Cbo Misc : RFO HitS",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Local InvItoE : Count o=
f OSB snoop broadcasts. Counts by 1 per request causing OSB snoops to be br=
oadcast. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.LOCAL_INVITOE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Local Rd : Count of OSB=
 snoop broadcasts. Counts by 1 per request causing OSB snoops to be broadca=
st. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.LOCAL_READ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Off : Count of OSB snoo=
p broadcasts. Counts by 1 per request causing OSB snoops to be broadcast. D=
oes not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.OFF_PWRHEURISTIC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : Remote Rd : Count of OS=
B snoop broadcasts. Counts by 1 per request causing OSB snoops to be broadc=
ast. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.REMOTE_READ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "OSB Snoop Broadcast : RFO HitS Snoop Broadcas=
t : Count of OSB snoop broadcasts. Counts by 1 per request causing OSB snoo=
ps to be broadcast. Does not count all the snoops generated by OSB.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x55",
+        "EventName": "UNC_CHA_OSB.RFO_HITS_SNP_BCAST",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.ALLOC_EXCLUSIVE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.ALLOC_EXCLUSIVE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.ALLOC_SHARED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.ALLOC_SHARED",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.DEALLOC_EVCTCLN",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.DEALLOC_EVCTCLN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.DIRBACKED_ONLY",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.DIRBACKED_ONLY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.HIT_EXCLUSIVE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.HIT_EXCLUSIVE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.HIT_SHARED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.HIT_SHARED",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.INCLUSIVE_ONLY",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.INCLUSIVE_ONLY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.MISS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.MISS",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.UPDATE_EXCLUSIVE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.UPDATE_EXCLUSIVE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.UPDATE_SHARED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.UPDATE_SHARED",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.VICTIM_EXCLUSIVE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.VICTIM_EXCLUSIVE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UNC_CHA_REMOTE_SF.VICTIM_SHARED",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x69",
+        "EventName": "UNC_CHA_REMOTE_SF.VICTIM_SHARED",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of requests coming fr=
om a unit on this socket for exclusive ownership of a cache line without re=
ceiving data (INVITOE) to the CHA.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE",
+        "PerPkg": "1",
+        "PublicDescription": "HA Read and Write Requests : InvalItoE",
+        "UMask": "0x30",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of requests coming fr=
om a unit on this socket for exclusive ownership of a cache line without re=
ceiving data (INVITOE) to the CHA.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of requests coming fr=
om a remote socket for exclusive ownership of a cache line without receivin=
g data (INVITOE) to the CHA.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.INVITOE_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts read requests made into this CHA. Read=
s include all read opcodes (including RFO: the Read for Ownership issued be=
fore a  write) .",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS",
+        "PerPkg": "1",
+        "PublicDescription": "HA Read and Write Requests : Reads",
+        "UMask": "0x3",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts read requests coming from a unit on th=
is socket made into this CHA. Reads include all read opcodes (including RFO=
: the Read for Ownership issued before a  write).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts read requests coming from a remote soc=
ket made into the CHA. Reads include all read opcodes (including RFO: the R=
ead for Ownership issued before a  write).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.READS_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts write requests made into the CHA, incl=
uding streaming, evictions, HitM (Reads from another core to a Modified cac=
heline), etc.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES",
+        "PerPkg": "1",
+        "PublicDescription": "HA Read and Write Requests : Writes",
+        "UMask": "0xc",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts  write requests coming from a unit on =
this socket made into this CHA, including streaming, evictions, HitM (Reads=
 from another core to a Modified cacheline), etc.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES_LOCAL",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the total number of read requests made=
 into the Home Agent. Reads include all read opcodes (including RFO).  Writ=
es include all writes (streaming, evictions, HitM, etc).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x50",
+        "EventName": "UNC_CHA_REQUESTS.WRITES_REMOTE",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "CHA"
+    },
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
+    {
+        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking exclusive lines in the core's cache. Snoop filter capacity e=
victions occur when the snoop filter is full and evicts an existing entry t=
o track a new entry. Does not count clean evictions such as when a core's c=
ache replaces a tracked cacheline with a new cacheline.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3d",
+        "EventName": "UNC_CHA_SF_EVICTION.E_STATE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Filter Capacity Evictions : E state",
+        "UMask": "0x2",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking modified lines in the core's cache. Snoop filter capacity ev=
ictions occur when the snoop filter is full and evicts an existing entry to=
 track a new entry. Does not count clean evictions such as when a core's ca=
che replaces a tracked cacheline with a new cacheline.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3d",
+        "EventName": "UNC_CHA_SF_EVICTION.M_STATE",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Filter Capacity Evictions : M state",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking shared lines in the core's cache. Snoop filter capacity evic=
tions occur when the snoop filter is full and evicts an existing entry to t=
rack a new entry. Does not count clean evictions such as when a core's cach=
e replaces a tracked cacheline with a new cacheline.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3d",
+        "EventName": "UNC_CHA_SF_EVICTION.S_STATE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Filter Capacity Evictions : S state",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR Inserts",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All",
+        "UMask": "0xc001ffff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush transactions from a CXL device which =
hit in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_CLFLUSH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCur transactions from a CXL device which =
hit in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_FSRDCUR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCurPtl transactions from a CXL device whi=
ch hit in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_FSRDCURPTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c9effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM transactions from a CXL device which hit=
 in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_ITOM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMWr transactions from a CXL device which h=
it in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_ITOMWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "MemPushWr transactions from a CXL device whic=
h hit in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_MEMPUSHWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCiL transactions from a CXL device which hit=
 in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_WCIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WcilF transactions from a CXL device which hi=
t in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_WCILF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c867fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WiL transactions from a CXL device which hit =
in the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_HIT_WIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush transactions from a CXL device which =
miss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_CLFLUSH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCur transactions from a CXL device which =
miss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_FSRDCUR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "FsRdCurPtl transactions from a CXL device whi=
ch miss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_FSRDCURPTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c9effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM transactions from a CXL device which mis=
s the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_ITOM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMWr transactions from a CXL device which m=
iss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_ITOMWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "MemPushWr transactions from a CXL device whic=
h miss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_MEMPUSHWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCiL transactions from a CXL device which mis=
s the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_WCIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WcilF transactions from a CXL device which mi=
ss the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_WCILF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c867fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WiL transactions from a CXL device which miss=
 the L3.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.CXL_MISS_WIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests from IA Cores"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from iA Cores",
+        "UMask": "0xc001ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush events that are initiated from the Co=
re",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CLFlushes issued by iA Cores",
+        "UMask": "0xc8c7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlushOpt events that are initiated from the=
 Core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CLFLUSHOPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CLFlushOpts issued by iA Cores=
",
+        "UMask": "0xc8d7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read from local IA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRDs issued by iA Cores",
+        "UMask": "0xc80fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read prefetch from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts; Code read prefetch from local I=
A that misses in the snoop filter",
+        "UMask": "0xc88fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt from local IA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opts issued by iA Cores",
+        "UMask": "0xc827ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt prefetch from local IA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es",
+        "UMask": "0xc8a7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests from IA Cores =
which hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Hit the LLC",
+        "UMask": "0xc001fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read from local IA that hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that H=
it the LLC",
+        "UMask": "0xc80ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read prefetch from local IA that hit the=
 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat hit the LLC",
+        "UMask": "0xc88ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All requests issued from IA cores to CXL acce=
lerator memory regions that hit the LLC.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt from local IA that hit the cach=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opts issued by iA Cores th=
at hit the LLC",
+        "UMask": "0xc827fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt prefetch from local IA that hit=
 the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that hit the LLC",
+        "UMask": "0xc8a7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM requests from local IA cores that hit th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by iA Cores that =
Hit LLC",
+        "UMask": "0xcc47fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch code read from loca=
l IA that hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefCode issued by iA Cores=
 that hit the LLC",
+        "UMask": "0xcccffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch data read from loca=
l IA that hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefData issued by iA Cores=
 that hit the LLC",
+        "UMask": "0xccd7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that hit the LLC",
+        "UMask": "0xccc7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that hit the=
 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that H=
it the LLC",
+        "UMask": "0xc807fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t hit the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Hit the LLC",
+        "UMask": "0xc887fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM events that are initiated from the Core"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by iA Cores",
+        "UMask": "0xcc47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNear requests from local IA cores",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears issued by iA Co=
res",
+        "UMask": "0xcd47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch code read from loca=
l IA.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefCode issued by iA Cores=
",
+        "UMask": "0xcccfff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch data read from loca=
l IA.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefData issued by iA Cores=
",
+        "UMask": "0xccd7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores"=
,
+        "UMask": "0xccc7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests from IA Cores =
which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from iA Cores tha=
t Missed the LLC",
+        "UMask": "0xc001fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read from local IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRds issued by iA Cores that M=
issed the LLC",
+        "UMask": "0xc80ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRDs from local IA cores to locally homed mem=
ory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd issued by iA Cores that Mi=
ssed the LLC - HOMed locally",
+        "UMask": "0xc80efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Code read prefetch from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat Missed the LLC",
+        "UMask": "0xc88ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRD Prefetches from local IA cores to locally=
 homed memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed locally",
+        "UMask": "0xc88efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRD Prefetches from local IA cores to remotel=
y homed memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed remotely",
+        "UMask": "0xc88f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CRDs from local IA cores to remotely homed me=
mory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CRD_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CRd issued by iA Cores that Mi=
ssed the LLC - HOMed remotely",
+        "UMask": "0xc80f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All requests issued from IA cores to CXL acce=
lerator memory regions that miss the LLC.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "DRds and equivalent opcodes issued from an IA=
 core which miss the L3 and target memory in a CXL type 2 memory expander c=
ard.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_CXL_ACC",
+        "PerPkg": "1",
+        "PublicDescription": "DRds issued from an IA core which miss the L=
3 and target memory in a CXL type 2 memory expander card.",
+        "UMask": "0x10c8178201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt from local IA that miss the cac=
he",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt issued by iA Cores tha=
t missed the LLC",
+        "UMask": "0xc827fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Inserts into the TOR from local IA cores whic=
h miss the LLC and snoop filter with the opcode DRd_Opt, and which target l=
ocal memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt issued by iA Cores tha=
t Missed the LLC - HOMed locally",
+        "UMask": "0xc826fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Data read opt prefetch from local IA that mis=
s the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that missed the LLC",
+        "UMask": "0xc8a7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Inserts into the TOR from local IA cores whic=
h miss the LLC and snoop filter with the opcode DRD_PREF_OPT, and target lo=
cal memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : Data read opt prefetch from lo=
cal iA that missed the LLC targeting local memory",
+        "UMask": "0xc8a6fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Inserts into the TOR from local IA cores whic=
h miss the LLC and snoop filter with the opcode DRD_PREF_OPT, and target re=
mote memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : Data read opt prefetch from lo=
cal iA that missed the LLC targeting remote memory",
+        "UMask": "0xc8a77e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Inserts into the TOR from local IA cores whic=
h miss the LLC and snoop filter with the opcode DRd_Opt, and target remote =
memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : Data read opt from local iA th=
at missed the LLC targeting remote memory",
+        "UMask": "0xc8277e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "L2 data prefetches issued from an IA core whi=
ch miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8978201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM requests from local IA cores that miss t=
he cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by iA Cores that =
Missed LLC",
+        "UMask": "0xcc47fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch code read from loca=
l IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefCode issued by iA Cores=
 that missed the LLC",
+        "UMask": "0xcccffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch data read from loca=
l IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefData issued by iA Cores=
 that missed the LLC",
+        "UMask": "0xccd7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "LLC data prefetches issued from an IA core wh=
ich miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccd78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : LLCPrefRFO issued by iA Cores =
that missed the LLC",
+        "UMask": "0xccc7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "L2 RFO prefetches issued from an IA core whic=
h miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFRFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8878201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to locally=
 homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc8668601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to locally=
 homed PMM addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc8668a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to locally =
homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to locally =
homed PMM addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_LOCAL_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to remotel=
y homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to remotel=
y homed PMM addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to remotely=
 homed DDR addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to remotely=
 homed PMM addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_REMOTE_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC",
+        "UMask": "0xc807fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RFOs issued from an IA core which miss the L3=
 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8078201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e LLC targeting local memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC - HOMed locally",
+        "UMask": "0xc806fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Missed the LLC",
+        "UMask": "0xc887fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "LLC RFO prefetches issued from an IA core whi=
ch miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccc78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the LLC targeting local memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed locally",
+        "UMask": "0xc886fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the LLC targeting remote memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores t=
hat Missed the LLC - HOMed remotely",
+        "UMask": "0xc8877e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA that miss th=
e LLC targeting remote memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores that M=
issed the LLC - HOMed remotely",
+        "UMask": "0xc8077e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "UCRDF requests from local IA cores that miss =
the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_UCRDF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : UCRdFs issued by iA Cores that=
 Missed LLC",
+        "UMask": "0xc877de01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from a local IA core that miss =
the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores that =
Missed the LLC",
+        "UMask": "0xc86ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA core that miss t=
he cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLF issued by iA Cores that =
Missed the LLC",
+        "UMask": "0xc867fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to DDR hom=
ed addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting DDR that missed the LLC",
+        "UMask": "0xc8678601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA cores to PMM hom=
ed addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLFs issued by iA Cores targ=
eting PMM that missed the LLC",
+        "UMask": "0xc8678a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from local IA cores to DDR home=
d addresses which miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting DDR that missed the LLC",
+        "UMask": "0xc86f8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from a local IA core to PMM hom=
ed addresses that miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores targe=
ting PMM that missed the LLC",
+        "UMask": "0xc86f8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WIL requests from local IA cores that miss th=
e cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_WIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WiLs issued by iA Cores that M=
issed LLC",
+        "UMask": "0xc87fde01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership from local IA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by iA Cores",
+        "UMask": "0xc807ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Read for ownership prefetch from local IA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFO_Prefs issued by iA Cores",
+        "UMask": "0xc887ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "SpecItoM events that are initiated from the C=
ore",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_SPECITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : SpecItoMs issued by iA Cores",
+        "UMask": "0xcc57ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbEFtoEs issued by iA Cores.  (Non Modified W=
rite Backs)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc3fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbEFtoIs issued by iA Cores .  (Non Modified =
Write Backs)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBEFTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc37ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbMtoEs issued by iA Cores .  (Modified Write=
 Backs)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc2fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbMtoI requests from local IA cores",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WbMtoIs issued by iA Cores",
+        "UMask": "0xcc27ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WbStoIs issued by iA Cores .  (Non Modified W=
rite Backs)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WBSTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc67ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCIL requests from a local IA core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLs issued by iA Cores",
+        "UMask": "0xc86fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WCILF requests from local IA core",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IA_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WCiLF issued by iA Cores",
+        "UMask": "0xc867ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR inserts from local IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from IO Devices",
+        "UMask": "0xc001ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "CLFlush requests from IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : CLFlushes issued by IO Devices=
",
+        "UMask": "0xc8c3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR inserts from local IO devices which h=
it the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from IO Devices t=
hat hit the LLC",
+        "UMask": "0xc001fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMs from local IO devices which hit the cac=
he",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t Hit the LLC",
+        "UMask": "0xcc43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices that hit the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that hit the LLC",
+        "UMask": "0xcd43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCURs issued by IO devices which hit the =
LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that hit the LLC",
+        "UMask": "0xc8f3fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RFOs from local IO devices which hit the cach=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices that=
 hit the LLC",
+        "UMask": "0xc803fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR ItoM inserts from local IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices",
+        "UMask": "0xcc43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices",
+        "UMask": "0xcd43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNear (partial write) transactions fr=
om an IO device that addresses memory on the local socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that address memory on the local sock=
et",
+        "UMask": "0xcd42ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNear (partial write) transactions fr=
om an IO device that addresses memory on a remote socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that address memory on a remote socke=
t",
+        "UMask": "0xcd437f04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM (write) transactions from an IO device t=
hat addresses memory on the local socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoM, indicating a write reque=
st, from IO Devices that address memory on the local socket",
+        "UMask": "0xcc42ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoM (write) transactions from an IO device t=
hat addresses memory on a remote socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_ITOM_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoM, indicating a write reque=
st, from IO Devices that address memory on a remote socket",
+        "UMask": "0xcc437f04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR inserts from local IO devices which m=
iss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All requests from IO Devices t=
hat missed the LLC",
+        "UMask": "0xc001fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR ItoM inserts from local IO devices wh=
ich miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMs issued by IO Devices tha=
t missed the LLC",
+        "UMask": "0xcc43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "ItoMCacheNears, indicating a partial write re=
quest, from IO Devices that missed the LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : ItoMCacheNears, indicating a p=
artial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCURs issued by IO devices which miss the=
 LLC",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that missed the LLC",
+        "UMask": "0xc8f3fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All TOR RFO inserts from local IO devices whi=
ch miss the cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices that=
 missed the LLC",
+        "UMask": "0xc803fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCURs issued by IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
",
+        "UMask": "0xc8f3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCUR (read) transactions from an IO devic=
e that addresses memory on the local socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that addresses memory on the local socket",
+        "UMask": "0xc8f2ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "PCIRDCUR (read) transactions from an IO devic=
e that addresses memory on a remote socket",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : PCIRdCurs issued by IO Devices=
 that addresses memory on a remote socket",
+        "UMask": "0xc8f37f04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "RFOs from local IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : RFOs issued by IO Devices",
+        "UMask": "0xc803ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "WBMtoI requests from IO devices",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.IO_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : WbMtoIs issued by IO Devices",
+        "UMask": "0xcc23ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Inserts for SF or LLC Evictions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LLC_OR_SF_EVICTIONS",
+        "PerPkg": "1",
+        "PublicDescription": "TOR allocation occurred as a result of SF/LL=
C evictions (came from the ISMQ)",
+        "UMask": "0xc001ff02",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All locally initiated requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All from Local iA and IO",
+        "UMask": "0xc000ff05",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All from Local iA",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All from Local iA",
+        "UMask": "0xc000ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All from Local IO",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.LOC_IO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All from Local IO",
+        "UMask": "0xc000ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All remote requests (e.g. snoops, writebacks)=
 that came from remote sockets",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REM_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All Remote Requests",
+        "UMask": "0xc001ffc8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "All snoops to this LLC that came from remote =
sockets",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_CHA_TOR_INSERTS.REM_SNPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Inserts : All Snoops from Remote",
+        "UMask": "0xc001ff08",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Occupancy for all TOR entries",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All",
+        "UMask": "0xc001ffff",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush transactions from a=
 CXL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_CLFLUSH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCur transactions from a=
 CXL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_FSRDCUR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCurPtl transactions fro=
m a CXL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_FSRDCURPTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c9effd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from a CX=
L device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_ITOM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMWr transactions from a =
CXL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_ITOMWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for MemPushWr transactions from=
 a CXL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_MEMPUSHWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCiL transactions from a CX=
L device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_WCIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WcilF transactions from a C=
XL device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_WCILF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c867fd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WiL transactions from a CXL=
 device which hit in the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_HIT_WIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffd20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush transactions from a=
 CXL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_CLFLUSH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8c7fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCur transactions from a=
 CXL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_FSRDCUR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c8effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for FsRdCurPtl transactions fro=
m a CXL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_FSRDCURPTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c9effe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from a CX=
L device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_ITOM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc47fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMWr transactions from a =
CXL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_ITOMWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc4ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for MemPushWr transactions from=
 a CXL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_MEMPUSHWR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78cc6ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCiL transactions from a CX=
L device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_WCIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c86ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WcilF transactions from a C=
XL device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_WCILF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c867fe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WiL transactions from a CXL=
 device which miss the L3.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.CXL_MISS_WIL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78c87ffe20",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores",
+        "UMask": "0xc001ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush events that are ini=
tiated from the Core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CLFlushes issued by iA Cores=
",
+        "UMask": "0xc8c7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlushOpt events that are =
initiated from the Core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CLFLUSHOPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CLFlushOpts issued by iA Cor=
es",
+        "UMask": "0xc8d7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRDs issued by iA Cores",
+        "UMask": "0xc80fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy; Code read prefetch from local=
 IA that misses in the snoop filter",
+        "UMask": "0xc88fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores"=
,
+        "UMask": "0xc827ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT_PREF",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores",
+        "UMask": "0xc8a7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores which hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Hit the LLC",
+        "UMask": "0xc001fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Hit the LLC",
+        "UMask": "0xc80ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that hit the LLC",
+        "UMask": "0xc88ffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All requests issued from IA=
 cores to CXL accelerator memory regions that hit the LLC.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018101",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores =
that hit the LLC",
+        "UMask": "0xc827fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores that hit the LLC",
+        "UMask": "0xc8a7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM requests from local IA=
 cores that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores tha=
t Hit LLC",
+        "UMask": "0xcc47fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefCode issued by iA Cor=
es that hit the LLC",
+        "UMask": "0xcccffd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefData issued by iA Cor=
es that hit the LLC",
+        "UMask": "0xccd7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that hit the LLC",
+        "UMask": "0xccc7fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Hit the LLC",
+        "UMask": "0xc807fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Hit the LLC",
+        "UMask": "0xc887fd01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM events that are initia=
ted from the Core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores",
+        "UMask": "0xcc47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNear requests from=
 local IA cores",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears issued by iA =
Cores",
+        "UMask": "0xcd47ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefCode issued by iA Cor=
es",
+        "UMask": "0xcccfff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefData issued by iA Cor=
es",
+        "UMask": "0xccd7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s",
+        "UMask": "0xccc7ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts from IA Cores which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from iA Cores t=
hat Missed the LLC",
+        "UMask": "0xc001fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read from local IA tha=
t miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRds issued by iA Cores that=
 Missed the LLC",
+        "UMask": "0xc80ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRDs from local IA cores to=
 locally homed memory",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd issued by iA Cores that =
Missed the LLC - HOMed locally",
+        "UMask": "0xc80efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Code read prefetch from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC",
+        "UMask": "0xc88ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRD Prefetches from local I=
A cores to locally homed memory",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC - HOMed locally",
+        "UMask": "0xc88efe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRD Prefetches from local I=
A cores to remotely homed memory",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd_Prefs issued by iA Cores=
 that Missed the LLC - HOMed remotely",
+        "UMask": "0xc88f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CRDs from local IA cores to=
 remotely homed memory",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CRD_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CRd issued by iA Cores that =
Missed the LLC - HOMed remotely",
+        "UMask": "0xc80f7e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All requests issued from IA=
 cores to CXL accelerator memory regions that miss the LLC.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c0018201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for DRds and equivalent opcodes=
 issued from an IA core which miss the L3 and target memory in a CXL type 2=
 memory expander card.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8178201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt from local IA=
 that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opt issued by iA Cores t=
hat missed the LLC",
+        "UMask": "0xc827fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Data read opt prefetch from=
 local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores that missed the LLC",
+        "UMask": "0xc8a7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for L2 data prefetches issued f=
rom an IA core which miss the L3 and target memory in a CXL type 2 accelera=
tor.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8978201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM requests from local IA=
 cores that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by iA Cores tha=
t Missed LLC",
+        "UMask": "0xcc47fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch c=
ode read from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFCODE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefCode issued by iA Cor=
es that missed the LLC",
+        "UMask": "0xcccffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch d=
ata read from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefData issued by iA Cor=
es that missed the LLC",
+        "UMask": "0xccd7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for LLC data prefetches issued =
from an IA core which miss the L3 and target memory in a CXL type 2 acceler=
ator.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFDATA_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccd78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Last level cache prefetch r=
ead for ownership from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : LLCPrefRFO issued by iA Core=
s that missed the LLC",
+        "UMask": "0xccc7fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for L2 RFO prefetches issued fr=
om an IA core which miss the L3 and target memory in a CXL type 2 accelerat=
or.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LLCPREFRFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8878201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to locally homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc8668601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to locally homed PMM addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc8668a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to locally homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to locally homed PMM addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_LOCAL_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed locally",
+        "UMask": "0xc86e8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to remotely homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to remotely homed PMM addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc8670a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to remotely homed DDR addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to remotely homed PMM addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_REMOTE_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC - HOMed remotely",
+        "UMask": "0xc86f0a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC",
+        "UMask": "0xc807fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RFOs issued from an IA core=
 which miss the L3 and target memory in a CXL type 2 accelerator.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10c8078201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC - HOMed locally",
+        "UMask": "0xc806fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Missed the LLC",
+        "UMask": "0xc887fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for LLC RFO prefetches issued f=
rom an IA core which miss the L3 and target memory in a CXL type 2 accelera=
tor.",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_CXL_ACC",
+        "PerPkg": "1",
+        "UMask": "0x10ccc78201",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_LOCAL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Missed the LLC - HOMed locally",
+        "UMask": "0xc886fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_PREF_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
 that Missed the LLC - HOMed remotely",
+        "UMask": "0xc8877e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_RFO_REMOTE",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores that=
 Missed the LLC - HOMed remotely",
+        "UMask": "0xc8077e01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for UCRDF requests from local I=
A cores that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_UCRDF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : UCRdFs issued by iA Cores th=
at Missed LLC",
+        "UMask": "0xc877de01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tha=
t Missed the LLC",
+        "UMask": "0xc86ffe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A core that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLF issued by iA Cores tha=
t Missed the LLC",
+        "UMask": "0xc867fe01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to DDR homed addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting DDR that missed the LLC",
+        "UMask": "0xc8678601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A cores to PMM homed addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCILF_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLFs issued by iA Cores ta=
rgeting PMM that missed the LLC",
+        "UMask": "0xc8678a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from local IA=
 cores to DDR homed addresses which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_DDR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting DDR that missed the LLC",
+        "UMask": "0xc86f8601",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core to PMM homed addresses that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WCIL_PMM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores tar=
geting PMM that missed the LLC",
+        "UMask": "0xc86f8a01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WIL requests from local IA =
cores that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_WIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WiLs issued by iA Cores that=
 Missed LLC",
+        "UMask": "0xc87fde01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership from loc=
al IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by iA Cores",
+        "UMask": "0xc807ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for Read for ownership prefetch=
 from local IA that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_RFO_PREF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFO_Prefs issued by iA Cores=
",
+        "UMask": "0xc887ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for SpecItoM events that are in=
itiated from the Core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_SPECITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : SpecItoMs issued by iA Cores=
",
+        "UMask": "0xcc57ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WbMtoI requests from local =
IA cores",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WbMtoIs issued by iA Cores",
+        "UMask": "0xcc27ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCIL requests from a local =
IA core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCIL",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLs issued by iA Cores",
+        "UMask": "0xc86fff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WCILF requests from local I=
A core",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_WCILF",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WCiLF issued by iA Cores",
+        "UMask": "0xc867ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
",
+        "UMask": "0xc001ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for CLFlush requests from IO de=
vices",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_CLFLUSH",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : CLFlushes issued by IO Devic=
es",
+        "UMask": "0xc8c3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices which hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that hit the LLC",
+        "UMask": "0xc001fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMs from local IO devices=
 which hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat Hit the LLC",
+        "UMask": "0xcc43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices that hit the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that hit the LLC",
+        "UMask": "0xcd43fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces which hit the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that hit the LLC",
+        "UMask": "0xc8f3fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RFOs from local IO devices =
which hit the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_HIT_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices th=
at hit the LLC",
+        "UMask": "0xc803fd04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR ItoM inserts from l=
ocal IO devices",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices",
+        "UMask": "0xcc43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices",
+        "UMask": "0xcd43ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR inserts from local =
IO devices which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All requests from IO Devices=
 that missed the LLC",
+        "UMask": "0xc001fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR ItoM inserts from l=
ocal IO devices which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat missed the LLC",
+        "UMask": "0xcc43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNears, indicating =
a partial write request, from IO Devices that missed the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd43fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNear transactions =
from an IO device on the local socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd42fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoMCacheNear transactions =
from an IO device on a remote socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOMCACHENEAR_REMOTE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMCacheNears, indicating a=
 partial write request, from IO Devices that missed the LLC",
+        "UMask": "0xcd437e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from an I=
O device on the local socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat missed the LLC",
+        "UMask": "0xcc42fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for ItoM transactions from an I=
O device on a remote socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_ITOM_REMOTE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : ItoMs issued by IO Devices t=
hat missed the LLC",
+        "UMask": "0xcc437e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces which miss the LLC",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC",
+        "UMask": "0xc8f3fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCUR transactions from =
an IO device on the local socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR_LOCAL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC",
+        "UMask": "0xc8f2fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCUR transactions from =
an IO device on a remote socket that miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_PCIRDCUR_REMOTE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es that missed the LLC",
+        "UMask": "0xc8f37e04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All TOR RFO inserts from lo=
cal IO devices which miss the cache",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_MISS_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices th=
at missed the LLC",
+        "UMask": "0xc803fe04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for PCIRDCURs issued by IO devi=
ces",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_PCIRDCUR",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : PCIRdCurs issued by IO Devic=
es",
+        "UMask": "0xc8f3ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for RFOs from local IO devices"=
,
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_RFO",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : RFOs issued by IO Devices",
+        "UMask": "0xc803ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for WBMtoI requests from IO dev=
ices",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.IO_WBMTOI",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : WbMtoIs issued by IO Devices=
",
+        "UMask": "0xcc23ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All locally initiated reque=
sts",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All from Local iA and IO",
+        "UMask": "0xc000ff05",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All from Local iA",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All from Local iA",
+        "UMask": "0xc000ff01",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All from Local IO",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.LOC_IO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All from Local IO",
+        "UMask": "0xc000ff04",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All remote requests (e.g. s=
noops, writebacks) that came from remote sockets",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.REM_ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All Remote Requests",
+        "UMask": "0xc001ffc8",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "TOR Occupancy for All snoops to this LLC that=
 came from remote sockets",
+        "Counter": "0",
+        "EventCode": "0x36",
+        "EventName": "UNC_CHA_TOR_OCCUPANCY.REM_SNPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "TOR Occupancy : All Snoops from Remote",
+        "UMask": "0xc001ff08",
+        "Unit": "CHA"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cxl.jso=
n b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cxl.json
new file mode 100644
index 000000000000..383a5ba5a697
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cxl.json
@@ -0,0 +1,31 @@
+[
+    {
+        "BriefDescription": "B2CXL Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2CXL_CLOCKTICKS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "B2CXL"
+    },
+    {
+        "BriefDescription": "Number of Allocation to Mem Data Packing buff=
er",
+        "Counter": "4,5,6,7",
+        "EventCode": "0x41",
+        "EventName": "UNC_CXLCM_RxC_PACK_BUF_INSERTS.MEM_DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "CXLCM"
+    },
+    {
+        "BriefDescription": "Number of Allocation to M2S Data AGF",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_CXLDP_TxC_AGF_INSERTS.M2S_DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "CXLDP"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interco=
nnect.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interco=
nnect.json
new file mode 100644
index 000000000000..251e5d20fefe
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.j=
son
@@ -0,0 +1,1625 @@
+[
+    {
+        "BriefDescription": "Clockticks of the mesh to memory (B2CMI)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2CMI_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of time D2C was not honoure=
d by egress due to directory state constraints",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_B2CMI_DIRECT2CORE_NOT_TAKEN_DIRSTATE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times B2CMI egress did D=
2C (direct to core)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x16",
+        "EventName": "UNC_B2CMI_DIRECT2CORE_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times D2C wasn't honoure=
d even though the incoming request had d2c set for non cisgress txn",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_B2CMI_DIRECT2CORE_TXN_OVERRIDE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of d2k wasn't done due to c=
redit constraints",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_CREDITS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Direct to UPI Transactions - Ignored due to l=
ack of credits : All : Counts the number of d2k wasn't done due to credit c=
onstraints",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1B",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_CREDITS.EGRESS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of time D2K was not honoure=
d by egress due to directory state constraints",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_DIRSTATE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Cycles when Direct2UPI was Disabled : Egress =
Ignored D2U : Counts the number of time D2K was not honoured by egress due =
to directory state constraints",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1A",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_NOT_TAKEN_DIRSTATE.EGRESS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times egress did D2K (Di=
rect to KTI)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_TAKEN",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of times D2K wasn't honoure=
d even though the incoming request had d2k set for non cisgress txn",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1C",
+        "EventName": "UNC_B2CMI_DIRECT2UPI_TXN_OVERRIDE",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit Clean",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x38",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On NonDirty Line in A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN_A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On NonDirty Line in I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On NonDirty Line in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.CLEAN_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit Dirty (modified)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On Dirty Line in A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY_A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On Dirty Line in I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Hit : On Dirty Line in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1D",
+        "EventName": "UNC_B2CMI_DIRECTORY_HIT.DIRTY_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with any directory to non persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.ANY",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with directory A to non persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.STATE_A",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with directory I to non persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.STATE_I",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the number of 1lm or 2lm hit read data=
 returns to egress with directory S to non persistent memory",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "UNC_B2CMI_DIRECTORY_LOOKUP.STATE_S",
+        "PerPkg": "1",
+        "PublicDescription": "Counts the number of 1lm or 2lm hit read  da=
ta returns to egress with directory S to non persistent memory",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss Clean",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x38",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On NonDirty Line in A State"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN_A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On NonDirty Line in I State"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On NonDirty Line in S State"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.CLEAN_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss Dirty (modified)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x7",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On Dirty Line in A State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY_A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On Dirty Line in I State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory Miss : On Dirty Line in S State",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_B2CMI_DIRECTORY_MISS.DIRTY_S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any A2I Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.A2I",
+        "PerPkg": "1",
+        "UMask": "0x320",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any A2S Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.A2S",
+        "PerPkg": "1",
+        "UMask": "0x340",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts cisgress directory updates",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.ANY",
+        "PerPkg": "1",
+        "UMask": "0x301",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts any 1lm or 2lm hit data return that wo=
uld result in directory update to non persistent memory (DRAM)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_ANY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x101",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in near memory to the A stat=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_X2A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x114",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in near memory to the I stat=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_X2I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x128",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in near memory to the S stat=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.HIT_X2S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x142",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any I2A Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.I2A",
+        "PerPkg": "1",
+        "UMask": "0x304",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any I2S Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.I2S",
+        "PerPkg": "1",
+        "UMask": "0x302",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in far memory to the A state=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.MISS_X2A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x214",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in far memory to the I state=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.MISS_X2I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x228",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update in far memory to the S state=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.MISS_X2S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x242",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any S2A Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.S2A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x310",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Any S2I Transition",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.S2I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x308",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update to the A state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.X2A",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x314",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update to the I state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.X2I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x328",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Directory update to the S state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_B2CMI_DIRECTORY_UPDATE.X2S",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x342",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts any read",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.ALL",
+        "PerPkg": "1",
+        "UMask": "0x104",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts normal reads issue to CMI",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.NORMAL",
+        "PerPkg": "1",
+        "UMask": "0x101",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Count reads to NM region",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.TO_DDR_AS_CACHE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x110",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts reads to 1lm non persistent memory reg=
ions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x24",
+        "EventName": "UNC_B2CMI_IMC_READS.TO_DDR_AS_MEM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x108",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "All Writes - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.ALL",
+        "PerPkg": "1",
+        "UMask": "0x110",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Full Non-ISOCH - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.FULL",
+        "PerPkg": "1",
+        "UMask": "0x101",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Non-Inclusive - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.NI",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Non-Inclusive Miss - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.NI_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Partial Non-ISOCH - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.PARTIAL",
+        "PerPkg": "1",
+        "UMask": "0x102",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "DDR, acting as Cache - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.TO_DDR_AS_CACHE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x140",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "DDR - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x25",
+        "EventName": "UNC_B2CMI_IMC_WRITES.TO_DDR_AS_MEM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x120",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : UPI - Ch 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.CH0_UPI",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : XPT - Ch 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.CH0_XPT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : UPI - All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.UPI_ALLCH",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Inserts : XPT -All Channels",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x56",
+        "EventName": "UNC_B2CMI_PREFCAM_INSERTS.XPT_ALLCH",
+        "PerPkg": "1",
+        "PublicDescription": "Prefetch CAM Inserts : XPT - All Channels",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Prefetch CAM Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x54",
+        "EventName": "UNC_B2CMI_PREFCAM_OCCUPANCY.CH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads and WRNI which were a hi=
t",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.ALL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a hit clean",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.RD_CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a hit dirty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.RD_DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a hit clean",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.WR_CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a hit dirty",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_B2CMI_TAG_HIT.WR_DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a WrN=
I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x5",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a WrN=
I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xa",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a Rd"=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.RD_2WAY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a miss and th=
e cache line is unmodified",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.RD_CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm reads which were a miss and th=
e cache line is modified",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.RD_DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm second way read miss for a WrN=
I",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.WR_2WAY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a miss and the=
 cache line is unmodified",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.WR_CLEAN",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Counts the 2lm WRNI which were a miss and the=
 cache line is modified",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x4B",
+        "EventName": "UNC_B2CMI_TAG_MISS.WR_DIRTY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_B2CMI_TRACKER_INSERTS.CH0",
+        "PerPkg": "1",
+        "UMask": "0x104",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Tracker Occupancy : Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x33",
+        "EventName": "UNC_B2CMI_TRACKER_OCCUPANCY.CH0",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "Write Tracker Inserts : Channel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_B2CMI_WR_TRACKER_INSERTS.CH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2CMI"
+    },
+    {
+        "BriefDescription": "UNC_B2HOT_CLOCKTICKS",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2HOT_CLOCKTICKS",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "B2HOT"
+    },
+    {
+        "BriefDescription": "Number of uclks in domain",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_B2UPI_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "B2UPI"
+    },
+    {
+        "BriefDescription": "Total Write Cache Occupancy : Mem",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0F",
+        "EventName": "UNC_I_CACHE_TOTAL_OCCUPANCY.MEM",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "IRP Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_I_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound read requests received by the IRP and=
 inserted into the FAF queue",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x18",
+        "EventName": "UNC_I_FAF_INSERTS",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "FAF occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x19",
+        "EventName": "UNC_I_FAF_OCCUPANCY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.FAST_REJ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.FAST_REQ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Lost Forward : Snoop pu=
lled away ownership before a write was committed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_I_MISC1.LOST_FWD",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Misc Events - Set 1 : Received Invalid : Seco=
ndary received a transfer that did not have sufficient MESI state",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1F",
+        "EventName": "UNC_I_MISC1.SEC_RCVD_INVLD",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Hit E/S responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_ES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x74",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Hit I responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x72",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Hit M responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_M",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop miss responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x71",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Inbound write (fast path) requests to coheren=
t memory, received by the IRP resulting in write ownership requests issued =
by IRP to the mesh.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x11",
+        "EventName": "UNC_I_TRANSACTIONS.WR_PREF",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "MDF Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_MDF_CLOCKTICKS",
+        "PerPkg": "1",
+        "Unit": "MDF"
+    },
+    {
+        "BriefDescription": "Number of UPI LL clock cycles while the event=
 is enabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_UPI_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "Number of kfclks",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Cycles in L1 : Number of UPI qfclk cycles spe=
nt in L1 power mode.  L1 is a mode that totally shuts down a UPI link.  Use=
 edge detect to count the number of instances when the UPI link entered L1.=
  Link power states are per link and per direction, so for example the Tx d=
irection could be in one state while Rx was in another. Because L1 totally =
shuts down the link, it takes a good amount of time to exit this mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "UNC_UPI_L1_POWER_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xe",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Bypass, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCB_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10e",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Non-C=
oherent Standard, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.NCS_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10f",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Reque=
st",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.REQ",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Reque=
st, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.REQ_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x108",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Conflict",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSPCNFLT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1aa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSPI",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x12a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xc",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - Data, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_DATA_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10c",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - No Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_NODATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Respo=
nse - No Data, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.RSP_NODATA_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Snoop=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.SNP",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Snoop=
, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.SNP_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x109",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Write=
back",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.WB",
+        "PerPkg": "1",
+        "UMask": "0xd",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Receive path of a UPI Port : Write=
back, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_UPI_RxL_BASIC_HDR_MATCH.WB_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10d",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : All Data : Shows legal=
 flit time (hides impact of L0p and L0c).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_DATA",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Null FLITs received from any slot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.ALL_NULL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Valid Flits Received : Null FLITs received f=
rom any slot",
+        "UMask": "0x27",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Data : Shows legal fli=
t time (hides impact of L0p and L0c). : Count Data Flits (which consume all=
 slots), but how much to count is based on Slot0-2 mask, so count can be 0-=
3 depending on which slots are enabled for counting..",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Idle : Shows legal fli=
t time (hides impact of L0p and L0c).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.IDLE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x47",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : LLCRD Not Empty : Show=
s legal flit time (hides impact of L0p and L0c). : Enables counting of LLCR=
D (with non-zero payload). This only applies to slot 2 since LLCRD is only =
allowed in slot 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.LLCRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : LLCTRL : Shows legal f=
lit time (hides impact of L0p and L0c). : Equivalent to an idle packet.  En=
ables counting of slot 0 LLCTRL messages.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.LLCTRL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : All Non Data : Shows l=
egal flit time (hides impact of L0p and L0c).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.NON_DATA",
+        "PerPkg": "1",
+        "UMask": "0x97",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot NULL or LLCRD Emp=
ty : Shows legal flit time (hides impact of L0p and L0c). : LLCRD with all =
zeros is treated as NULL. Slot 1 is not treated as NULL if slot 0 is a dual=
 slot. This can apply to slot 0,1, or 2.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.NULL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Protocol Header : Show=
s legal flit time (hides impact of L0p and L0c). : Enables count of protoco=
l headers in slot 0,1,2 (depending on slot uMask bits)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.PROTHDR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot 0 : Shows legal f=
lit time (hides impact of L0p and L0c). : Count Slot 0 - Other mask bits de=
termine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot 1 : Shows legal f=
lit time (hides impact of L0p and L0c). : Count Slot 1 - Other mask bits de=
termine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Received : Slot 2 : Shows legal f=
lit time (hides impact of L0p and L0c). : Count Slot 2 - Other mask bits de=
termine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_UPI_RxL_FLITS.SLOT2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 0 : Number=
 of allocations into the UPI Rx Flit Buffer.  Generally, when data is trans=
mitted across UPI, it will bypass the RxQ and pass directly to the ring int=
erface.  If things back up getting transmitted onto the ring, however, it m=
ay need to allocate into this buffer, thus increasing the latency.  This ev=
ent can be used in conjunction with the Flit Buffer Occupancy event in orde=
r to calculate the average flit buffer lifetime.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 1 : Number=
 of allocations into the UPI Rx Flit Buffer.  Generally, when data is trans=
mitted across UPI, it will bypass the RxQ and pass directly to the ring int=
erface.  If things back up getting transmitted onto the ring, however, it m=
ay need to allocate into this buffer, thus increasing the latency.  This ev=
ent can be used in conjunction with the Flit Buffer Occupancy event in orde=
r to calculate the average flit buffer lifetime.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Flit Buffer Allocations : Slot 2 : Number=
 of allocations into the UPI Rx Flit Buffer.  Generally, when data is trans=
mitted across UPI, it will bypass the RxQ and pass directly to the ring int=
erface.  If things back up getting transmitted onto the ring, however, it m=
ay need to allocate into this buffer, thus increasing the latency.  This ev=
ent can be used in conjunction with the Flit Buffer Occupancy event in orde=
r to calculate the average flit buffer lifetime.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x30",
+        "EventName": "UNC_UPI_RxL_INSERTS.SLOT2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "RxQ Occupancy - All Packets : Slot 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x32",
+        "EventName": "UNC_UPI_RxL_OCCUPANCY.SLOT2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Cycles in L0p",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_POWER_CYCLES_LL_ENTER",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES_LL_ENTER",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_POWER_CYCLES_M3_EXIT",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES_M3_EXIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xe",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCB_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10e",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Standard, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.NCS_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10f",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Requ=
est",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.REQ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Requ=
est, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.REQ_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x108",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Conflict",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSPCNFLT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1aa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Invalid",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSPI",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x12a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xc",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - Data, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_DATA_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10c",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - No Data",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xa",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Resp=
onse - No Data, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.RSP_NODATA_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10a",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Snoo=
p",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.SNP",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x9",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Snoo=
p, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.SNP_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x109",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Writ=
eback",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.WB",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xd",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Matches on Transmit path of a UPI Port : Writ=
eback, Match Opcode",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_UPI_TxL_BASIC_HDR_MATCH.WB_OPC",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10d",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : All Data : Counts number o=
f data flits across this UPI link.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_DATA",
+        "PerPkg": "1",
+        "UMask": "0xf",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "All Null Flits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.ALL_NULL",
+        "PerPkg": "1",
+        "PublicDescription": "Valid Flits Sent : Idle",
+        "UMask": "0x27",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Data : Shows legal flit ti=
me (hides impact of L0p and L0c). : Count Data Flits (which consume all slo=
ts), but how much to count is based on Slot0-2 mask, so count can be 0-3 de=
pending on which slots are enabled for counting..",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.DATA",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Idle : Shows legal flit ti=
me (hides impact of L0p and L0c).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.IDLE",
+        "PerPkg": "1",
+        "UMask": "0x47",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : LLCRD Not Empty : Shows le=
gal flit time (hides impact of L0p and L0c). : Enables counting of LLCRD (w=
ith non-zero payload). This only applies to slot 2 since LLCRD is only allo=
wed in slot 2",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.LLCRD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : LLCTRL : Shows legal flit =
time (hides impact of L0p and L0c). : Equivalent to an idle packet.  Enable=
s counting of slot 0 LLCTRL messages.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.LLCTRL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : All Non Data : Shows legal=
 flit time (hides impact of L0p and L0c).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.NON_DATA",
+        "PerPkg": "1",
+        "PublicDescription": "Valid Flits Sent : Null FLITs transmitted to=
 any slot",
+        "UMask": "0x97",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot NULL or LLCRD Empty :=
 Shows legal flit time (hides impact of L0p and L0c). : LLCRD with all zero=
s is treated as NULL. Slot 1 is not treated as NULL if slot 0 is a dual slo=
t. This can apply to slot 0,1, or 2.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.NULL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Protocol Header : Shows le=
gal flit time (hides impact of L0p and L0c). : Enables count of protocol he=
aders in slot 0,1,2 (depending on slot uMask bits)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.PROTHDR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot 0 : Shows legal flit =
time (hides impact of L0p and L0c). : Count Slot 0 - Other mask bits determ=
ine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot 1 : Shows legal flit =
time (hides impact of L0p and L0c). : Count Slot 1 - Other mask bits determ=
ine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Valid Flits Sent : Slot 2 : Shows legal flit =
time (hides impact of L0p and L0c). : Count Slot 2 - Other mask bits determ=
ine types of headers to count.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_UPI_TxL_FLITS.SLOT2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x4",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "Message Received : Doorbell",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.DOORBELL_RCVD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x8",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Message Received : Interrupt",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.INT_PRIO",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Message Received : Interrupt : Interrupts",
+        "UMask": "0x10",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Message Received : IPI",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.IPI_RCVD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Message Received : IPI : Inter Processor Int=
errupts",
+        "UMask": "0x4",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Message Received : MSI",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
+        "PerPkg": "1",
+        "PublicDescription": "Message Received : MSI : Message Signaled In=
terrupts - interrupts sent by devices (including PCIe via IOxAPIC) (Socket =
Mode only)",
+        "UMask": "0x2",
+        "Unit": "UBOX"
+    },
+    {
+        "BriefDescription": "Message Received : VLW",
+        "Counter": "0,1",
+        "EventCode": "0x42",
+        "EventName": "UNC_U_EVENT_MSG.VLW_RCVD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Message Received : VLW : Virtual Logical Wir=
e (legacy) message were received from Uncore.",
+        "UMask": "0x1",
+        "Unit": "UBOX"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-io.json=
 b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-io.json
new file mode 100644
index 000000000000..77f9c4cee952
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-io.json
@@ -0,0 +1,1925 @@
+[
+    {
+        "BriefDescription": "IIO Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_IIO_CLOCKTICKS",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PCIE Completion Buffer Inserts.  Counts once =
per 64 byte read issued from this PCIE device.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xC2",
+        "EventName": "UNC_IIO_COMP_BUF_INSERTS.CMPD.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0xff",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Count of allocations in the completion buffer=
",
+        "Counter": "2,3",
+        "EventCode": "0xD5",
+        "EventName": "UNC_IIO_COMP_BUF_OCCUPANCY.CMPD.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core reporting co=
mpletion of Card read from Core DRAM",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Core writing to C=
ards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) reading from this card.",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested by the CPU : Another card (dif=
ferent IIO stack) writing to this card.",
+        "Counter": "2,3",
+        "EventCode": "0xC0",
+        "EventName": "UNC_IIO_DATA_REQ_BY_CPU.PEER_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Counts once for every 4 bytes read from this =
card to memory.  This event does include reads to IO.",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card read=
ing from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Counts once for every 4 bytes written from th=
is card to memory.  This event does include writes to IO.",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x02",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x04",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x08",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x10",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x20",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x40",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Four byte data request of the CPU : Card writ=
ing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x80",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card reading from=
 another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_READ.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Counts once for every 4 bytes written from th=
is card to a peer device's IO space.",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.ALL_PARTS",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Data requested of the CPU : Card writing to a=
nother Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x83",
+        "EventName": "UNC_IIO_DATA_REQ_OF_CPU.PEER_WRITE.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Hits to a 1G Page",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.1G_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Hits to a 2M Page",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.2M_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Hits to a 4K Page",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.4K_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB lookups all",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.ALL_LOOKUPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Context cache hits",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Context cache lookups",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.CTXT_CACHE_LOOKUPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB lookups first",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.FIRST_LOOKUPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB Fills (same as IOTLB miss)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "UNC_IIO_IOMMU0.MISSES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOMMU memory access (both low and high priori=
ty)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0xc0",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOMMU high priority memory access",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES_HIGH",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOMMU low priority memory access",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.NUM_MEM_ACCESSES_LOW",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 1G page=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_1G_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 256T pa=
ge",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_256T_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 2M page=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_2M_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache Hit to a 512G pa=
ge",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_512G_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache fill",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_CACHE_FILLS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Second Level Page Walk Cache lookup",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x41",
+        "EventName": "UNC_IIO_IOMMU1.SLPWC_CACHE_LOOKUPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Cycles PWT full",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.CYC_PWT_FULL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Interrupt Entry cache hit",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.INT_CACHE_HITS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Interrupt Entry cache lookup",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.INT_CACHE_LOOKUPS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Context Cache invalidation events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_CTXT_CACHE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Interrupt Entry Cache invalidation events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_INT_CACHE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "IOTLB invalidation events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_IOTLB",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "PASID Cache invalidation events",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_IIO_IOMMU3.NUM_INVAL_PASID_CACHE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to UNC_IIO_NUM_OUTSTANDING_REQ_FROM_CPU.TO_IO]",
+        "Counter": "2,3",
+        "Deprecated": "1",
+        "EventCode": "0xc5",
+        "EventName": "UNC_IIO_NUM_OUSTANDING_REQ_FROM_CPU.TO_IO",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Occupancy of outbound request queue : To devi=
ce : Counts number of outbound requests/completions IIO is currently proces=
sing [This event is alias to UNC_IIO_NUM_OUSTANDING_REQ_FROM_CPU.TO_IO]",
+        "Counter": "2,3",
+        "EventCode": "0xc5",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_FROM_CPU.TO_IO",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Passing data to be written",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.DATA",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Issuing final read or write of line",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.FINAL_RD_WR",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Processing response from IOMMU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.IOMMU_HIT",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Issuing to IOMMU",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.IOMMU_REQ",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Request Ownership",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.REQ_OWN",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Writing line",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_OF_CPU.WR",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.ABORT",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.ABORT",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x80",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.CONFINED_P2P",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.CONFINED_P2P",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x40",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.LOC_P2P",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.LOC_P2P",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x20",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MCAST",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MCAST",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MEM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MEM",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MSGB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.MSGB",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.REM_P2P",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.REM_P2P",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x10",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Posted requests sent by the integrated IO (II=
O) controller to the Ubox, useful for counting message signaled interrupts =
(MSI).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED",
+        "FCMask": "0x01",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "All 9 bits of Page Walk Tracker Occupancy",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x42",
+        "EventName": "UNC_IIO_PWT_OCCUPANCY",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re reading from Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : Co=
re writing to Cards MMIO space",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) reading from this card.",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_READ.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested by the CPU : An=
other card (different IIO stack) writing to this card.",
+        "Counter": "2,3",
+        "EventCode": "0xC1",
+        "EventName": "UNC_IIO_TXN_REQ_BY_CPU.PEER_WRITE.ALL_PARTS",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_READ.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART0",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART2",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART3",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART4",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART5",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART6",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to DRAM",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.MEM_WRITE.PART7",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x1",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd reading from another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_READ.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART0",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x001",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART1",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x002",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART2",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x004",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART3",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x008",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART4",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x010",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART5",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x020",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART6",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x040",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    },
+    {
+        "BriefDescription": "Number Transactions requested of the CPU : Ca=
rd writing to another Card (same or different stack)",
+        "Counter": "0,1",
+        "EventCode": "0x84",
+        "EventName": "UNC_IIO_TXN_REQ_OF_CPU.PEER_WRITE.PART7",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x080",
+        "UMask": "0x2",
+        "Unit": "IIO"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-memory.=
json b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-memory.json
new file mode 100644
index 000000000000..8184c2b6b861
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-memory.json
@@ -0,0 +1,883 @@
+[
+    {
+        "BriefDescription": "DRAM Activate Count : Counts the number of DR=
AM Activate commands sent on this channel.  Activate commands are issued to=
 open up a page on the DRAM devices so that it can be read or written to wi=
th a CAS.  One can calculate the number of Page Misses by subtracting the n=
umber of Page Miss precharges from the number of Activates.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xf7",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count : Read transaction on Pag=
e Empty or Page Miss : Counts the number of DRAM Activate commands sent on =
this channel.  Activate commands are issued to open up a page on the DRAM d=
evices so that it can be read or written to with a CAS.  One can calculate =
the number of Page Misses by subtracting the number of Page Miss precharges=
 from the number of Activates.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count : Underfill Read transact=
ion on Page Empty or Page Miss : Counts the number of DRAM Activate command=
s sent on this channel.  Activate commands are issued to open up a page on =
the DRAM devices so that it can be read or written to with a CAS.  One can =
calculate the number of Page Misses by subtracting the number of Page Miss =
precharges from the number of Activates.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.UFILL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Activate Count : Write transaction on Pa=
ge Empty or Page Miss : Counts the number of DRAM Activate commands sent on=
 this channel.  Activate commands are issued to open up a page on the DRAM =
devices so that it can be read or written to with a CAS.  One can calculate=
 the number of Page Misses by subtracting the number of Page Miss precharge=
s from the number of Activates.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x02",
+        "EventName": "UNC_M_ACT_COUNT.WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0, all CAS operation=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.ALL",
+        "PerPkg": "1",
+        "UMask": "0xff",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0, all reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD",
+        "PerPkg": "1",
+        "UMask": "0xcf",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 regular reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_NON_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc3",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 auto-precharge rea=
ds",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_PRE_REG",
+        "PerPkg": "1",
+        "UMask": "0xc2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 auto-precharge und=
erfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_PRE_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 regular reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_REG",
+        "PerPkg": "1",
+        "UMask": "0xc1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_UNDERFILL_ALL",
+        "PerPkg": "1",
+        "UMask": "0xcc",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0, all writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.WR",
+        "PerPkg": "1",
+        "UMask": "0xf0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 regular writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.WR_NONPRE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xd0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 auto-precharge wri=
tes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.WR_PRE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xe0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1, all CAS operation=
s",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.ALL",
+        "PerPkg": "1",
+        "UMask": "0xff",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1, all reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD",
+        "PerPkg": "1",
+        "UMask": "0xcf",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 regular reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_NON_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc3",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 auto-precharge rea=
ds",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_PRE_REG",
+        "PerPkg": "1",
+        "UMask": "0xc2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 auto-precharge und=
erfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_PRE_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 regular reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_REG",
+        "PerPkg": "1",
+        "UMask": "0xc1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_UNDERFILL",
+        "PerPkg": "1",
+        "UMask": "0xc4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_UNDERFILL_ALL",
+        "PerPkg": "1",
+        "UMask": "0xcc",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1, all writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.WR",
+        "PerPkg": "1",
+        "UMask": "0xf0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 regular writes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.WR_NONPRE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xd0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 auto-precharge wri=
tes",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.WR_PRE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xe0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM DCLK clock cycles while the ev=
ent is enabled.  DCLK is 1/4 of DRAM data rate.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM Clockticks",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Number of DRAM HCLK clock cycles while the ev=
ent is enabled",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_M_HCLOCKTICKS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "DRAM Clockticks",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles MR4 temp readings forced 2x refre=
sh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM0",
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
+        "PublicDescription": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM1",
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
+        "PublicDescription": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM0",
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
+        "PublicDescription": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM1",
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
+        "PublicDescription": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM0",
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
+        "PublicDescription": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM1",
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
+        "PublicDescription": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM0",
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
+        "PublicDescription": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM1",
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
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.ALL",
+        "PerPkg": "1",
+        "UMask": "0xff",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Precharge due to (=
?) : Counts the number of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.PGT",
+        "PerPkg": "1",
+        "UMask": "0xf8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.RD",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.UFILL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x03",
+        "EventName": "UNC_M_PRE_COUNT.WR",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xf2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer inserts on subchannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_M_RDB_INSERTS.SCH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer inserts on subchannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x17",
+        "EventName": "UNC_M_RDB_INSERTS.SCH1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer occupancy on subchannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1a",
+        "EventName": "UNC_M_RDB_OCCUPANCY_SCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read buffer occupancy on subchannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1b",
+        "EventName": "UNC_M_RDB_OCCUPANCY_SCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations : Counts the n=
umber of allocations into the Read Pending Queue.  This queue is used to sc=
hedule reads out to the memory controller and to track the requests.  Reque=
sts allocate into the RPQ soon after they enter the memory controller, and =
need credits for an entry in this buffer before being sent from the HA to t=
he iMC.  They deallocate after the CAS command has been issued to memory.  =
This includes both ISOCH and non-ISOCH requests.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.PCH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue Allocations : Counts the n=
umber of allocations into the Read Pending Queue.  This queue is used to sc=
hedule reads out to the memory controller and to track the requests.  Reque=
sts allocate into the RPQ soon after they enter the memory controller, and =
need credits for an entry in this buffer before being sent from the HA to t=
he iMC.  They deallocate after the CAS command has been issued to memory.  =
This includes both ISOCH and non-ISOCH requests.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.PCH1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xa0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 0, =
pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH0_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 0, =
pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH0_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 1, =
pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH1_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read Pending Queue inserts for subchannel 1, =
pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x10",
+        "EventName": "UNC_M_RPQ_INSERTS.SCH1_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 0=
, pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x80",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH0_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 0=
, pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x81",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH0_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 1=
, pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x82",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH1_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Read pending queue occupancy for subchannel 1=
, pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "UNC_M_RPQ_OCCUPANCY_SCH1_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "subevent0 - # of cycles all ranks were in SR =
subevent1 - # of times all ranks went into SR subevent2 -# of times  ps_sr_=
active asserted (SRE) subevent3 - # of times ps_sr_active deasserted (SRX) =
subevent4 - # of times PS-&>Refresh ps_sr_req asserted (SRE) subevent5 - # =
of times PS-&>Refresh ps_sr_req deasserted (SRX) subevent6 - # of cycles PS=
Ctrlr FSM was in FATAL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_M_SELF_REFRESH.ENTER_SUCCESS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_SELF_REFRESH.ENTER_SUCCESS",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles all ranks were in SR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_M_SELF_REFRESH.ENTER_SUCCESS_CYCLES",
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
+        "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT0",
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
+        "PublicDescription": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT1",
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
+        "PublicDescription": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT0",
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
+        "PublicDescription": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT1",
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
+        "PublicDescription": "UNC_M_THROTTLE_LOW_CYCLES.SLOT0",
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
+        "PublicDescription": "UNC_M_THROTTLE_LOW_CYCLES.SLOT1",
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
+        "PublicDescription": "UNC_M_THROTTLE_MID_CYCLES.SLOT0",
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
+        "PublicDescription": "UNC_M_THROTTLE_MID_CYCLES.SLOT1",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.PCH0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x50",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue Allocations",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.PCH1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0xa0",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 0,=
 pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH0_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x10",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 0,=
 pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH0_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x20",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 1,=
 pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH1_PCH0",
+        "PerPkg": "1",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write Pending Queue inserts for subchannel 1,=
 pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x22",
+        "EventName": "UNC_M_WPQ_INSERTS.SCH1_PCH1",
+        "PerPkg": "1",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
0, pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x84",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH0_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
0, pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x85",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH0_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
1, pseudochannel 0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x86",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH1_PCH0",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "Write pending queue occupancy for subchannel =
1, pseudochannel 1",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x87",
+        "EventName": "UNC_M_WPQ_OCCUPANCY_SCH1_PCH1",
+        "PerPkg": "1",
+        "Unit": "IMC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-power.j=
son b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-power.json
new file mode 100644
index 000000000000..9ea852ef190e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-power.json
@@ -0,0 +1,109 @@
+[
+    {
+        "BriefDescription": "PCU Clockticks",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x01",
+        "EventName": "UNC_P_CLOCKTICKS",
+        "PerPkg": "1",
+        "PublicDescription": "PCU Clockticks:  The PCU runs off a fixed 1 =
GHz clock.  This event counts the number of pclk cycles measured while the =
counter was enabled.  The pclk, like the Memory Controller's dclk, counts a=
t a constant rate making it a good measure of actual wall time.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Thermal Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Thermal Strongest Upper Limit Cycles : Numbe=
r of cycles any frequency is reduced due to a thermal limit.  Count only if=
 throttling is occurring.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Power Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Power Strongest Upper Limit Cycles : Counts =
the number of cycles when power is the upper limit on frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Cycles spent changing Frequency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "UNC_P_FREQ_TRANS_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cycles spent changing Frequency : Counts the=
 number of cycles when the system is changing frequency.  This can not be f=
iltered by thread ID.  One can also use it with the occupancy counter that =
monitors number of threads in C0 to estimate the performance impact that fr=
equency transitions had on the system.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C2E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2b",
+        "EventName": "UNC_P_PKG_RESIDENCY_C2E_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Package C State Residency - C2E : Counts the=
 number of cycles when the package was in C2E.  This event can be used in c=
onjunction with edge detect to count C2E entrances (or exits using invert).=
  Residency events do not include transition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2d",
+        "EventName": "UNC_P_PKG_RESIDENCY_C6_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Package C State Residency - C6 : Counts the =
number of cycles when the package was in C6.  This event can be used in con=
junction with edge detect to count C6 entrances (or exits using invert).  R=
esidency events do not include transition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C0 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C3 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C6 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "External Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0a",
+        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "External Prochot : Counts the number of cycl=
es that we are in external PROCHOT mode.  This mode is triggered when a sen=
sor off the die determines that something off-die (like DRAM) is too hot an=
d must throttle to avoid damaging the chip.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Internal Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x09",
+        "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Internal Prochot : Counts the number of cycl=
es that we are in Internal PROCHOT mode.  This mode is triggered when a sen=
sor on the die determines that we are too hot and must throttle to avoid da=
maging the chip.",
+        "Unit": "PCU"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/x86/clearwaterforest/virtual-memory=
.json b/tools/perf/pmu-events/arch/x86/clearwaterforest/virtual-memory.json
index 78f2b835c1fa..a6a8733de235 100644
--- a/tools/perf/pmu-events/arch/x86/clearwaterforest/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/clearwaterforest/virtual-memory.json
@@ -1,4 +1,20 @@
 [
+    {
+        "BriefDescription": "Counts the number of page walks initiated by =
a demand load that missed the first and second level TLBs.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.MISS_CAUSED_WALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to a demand load that did not start a page walk. A=
ccounts for all page sizes. Will result in a DTLB write from STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to any page size.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -8,6 +24,32 @@
         "SampleAfterValue": "1000003",
         "UMask": "0xe"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to a 4K page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x08",
+        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to 4K pages. I=
ncludes page walks that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks initiated by =
a store that missed the first and second level TLBs.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.MISS_CAUSED_WALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to stores that did not start a page walk. Accounts=
 for all page sizes. Will result in a DTLB write from STLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.STLB_HIT",
+        "PublicDescription": "Counts the number of first level TLB misses =
but second level hits due to a demand load that did not start a page walk. =
Accounts for all page sizes. Will result in a DTLB write from STLB.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to any page size.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -17,6 +59,31 @@
         "SampleAfterValue": "1000003",
         "UMask": "0xe"
     },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to a 4K page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x49",
+        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to 4K pages.  Includes page walks that =
page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks initiated by =
a instruction fetch that missed the first and second level TLBs.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of first level TLB misses b=
ut second level hits due to an instruction fetch that did not start a page =
walk. Account for all pages sizes. Will result in an ITLB write from STLB."=
,
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.STLB_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -25,5 +92,32 @@
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
         "SampleAfterValue": "1000003",
         "UMask": "0xe"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to a 4K page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
+        "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to 4K pages.  Includes pag=
e walks that page fault.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of page walks outstanding f=
or iside in PMH every cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x85",
+        "EventName": "ITLB_MISSES.WALK_PENDING",
+        "PublicDescription": "Counts the number of page walks outstanding =
for iside in PMH every cycle.  A PMH page walk is outstanding from page wal=
k start till PMH becomes idle again (ready to serve next walk). Includes EP=
T-walk intervals.  Walks could be counted by edge detecting on this event, =
but would count restarted suspended walks.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of retired loads that are b=
locked due to a first level TLB miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x03",
+        "EventName": "LD_BLOCKS.DTLB_MISS",
+        "PublicDescription": "Counts the number of retired loads that are =
blocked due to a first level TLB miss. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 85f41cab56c7..a52909e212b4 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -7,7 +7,7 @@ GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
 GenuineIntel-6-4F,v23,broadwellx,core
 GenuineIntel-6-55-[56789ABCDEF],v1.25,cascadelakex,core
-GenuineIntel-6-DD,v1.00,clearwaterforest,core
+GenuineIntel-6-DD,v1.02,clearwaterforest,core
 GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.21,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
--=20
2.54.0.823.g6e5bcc1fc9-goog

