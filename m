Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D938F93B
	for <linux-perf-users@vger.kernel.org>; Fri, 29 May 2026 04:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780030403; cv=none; b=OWDQJtZurI9O2zZmo61ebNzcXEegUtmvqoIBICMbPTTbH6lx4/4GAq2OAWcB5DPr6Thcjom7dhwL27cA+r3czufk63MDdksMCi4fPeKc0nNRFy8AnceMO4qkXA6LRjEsCVxZ9bL8oFbUQv0yuiAY5ZiM7m49N1yO6DqG7K5SzEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780030403; c=relaxed/simple;
	bh=a5Zqk9e3SXypdh+sqKxBXKiERaM/qu8jjq/A6Mzncno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QlE/5KkSYFZT5gH0F6VQYmDO2WTF6N1yCiWJkoRWxcrmuygjjgtGUI7NvSwXOK8pZK3MLvPiQCeemY+93kgi5GAhlTwSClHn6iW6YS5+8TQ+Z1ibE66I30O/KrkeTCZoIUoxatsvyZsSZ4FoPFyrBH4vMxsgHs4Va4fcdMgKoss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IMbANQCV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IMbANQCV"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c827c880e39so6977622a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 21:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780030395; x=1780635195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egkGG8cDPV6R1wGs2K0PVC5Jooa7uGDMI2E1AKEt74A=;
        b=IMbANQCVR2ECzgXSYTqdue5Tc13vlcRwjtlW8ZoaZk/3GX5YkPPPyznxCPeWPs4M8z
         Uv2tsIT4h2oM+8HfaaTRw0iRhKYy2bvDvbuf9+yE2GhZuIcXpUoMLT0BKUvzJw07Po4X
         Sga+TcAN3a/WK4NVJAoF8/qUrSnF7z66AHofyho5kPFRAQo73eXw4aORJcHJyKQpuY2+
         8PXc26Sz6PLiEOhb8apztnnjKTvMghG7xLkpD4XQt0IjmesPoBPSlAni70wEGX9soKsc
         fjl8A+koJlyXgWxyu2xC91SJYMm6tYucLoLYAOyHQQpOCQnK/GZo5650JNHvtCBkadtr
         7Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780030395; x=1780635195;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=egkGG8cDPV6R1wGs2K0PVC5Jooa7uGDMI2E1AKEt74A=;
        b=GbEm7qp9fx3uoFR0cuEos7RtxhcFCpfwPWUU5g2y1s3AqqcR1tkOCoxJyPrcBUMy1L
         QZgxZP32Yb82xvUf/xSxMt/iQH/pw4sc1Xi5mof4Qv1/Ungz8qvowJholruXO4k4hVqy
         5Tv0v+m7VC9ZpreDWZI7FjW6BPjaIPQQcZhcGTmDAh5Z/zQJ3ueq/MZbw7v3bG3B3qVW
         JU9Uj7JPZJn0a5xK+JUcNvHJGSs6KctqCO3lf9NeVyYu4Gk7pw0canXWgJ03Bx6LwAVE
         d97nTTskS30qUUycbCc5grf/8U/d1KZHph0xMjKfeioO+qF0BPI5sUdFEWkkSGyiq8kF
         orug==
X-Forwarded-Encrypted: i=1; AFNElJ/C1b/vwADyYc/Ol5aQEoab6ItOUAxa5F0atfT24atwL3OHTFRPDBb24aw+USsW4AwpT7wIZW0jLiuT+SJxEfK7@vger.kernel.org
X-Gm-Message-State: AOJu0YyqII0jLjae5azdy4r5cn5pGsicEBxPMDD2Hsi2YacA7H4yJ5FJ
	gK1NktJm0AwwqKFsvBz1L1voBC96tiKCVFRArGLnvwR0MFH7RkpcSXErTj9mC7wscX3hpqOYIJe
	coHUZCo0+Rw==
X-Received: from pgea15.prod.google.com ([2002:a05:6a02:538f:b0:c85:7239:6db5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3318:b0:39b:87f0:758e
 with SMTP id adf61e73a8af0-3b411be88abmr1394604637.8.1780030395016; Thu, 28
 May 2026 21:53:15 -0700 (PDT)
Date: Thu, 28 May 2026 21:51:52 -0700
In-Reply-To: <20260529045155.311805-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529045155.311805-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529045155.311805-11-irogers@google.com>
Subject: [PATCH v1 10/12] perf vendor events intel: Update pantherlake events
 from 1.04 to 1.05
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
https://github.com/intel/perfmon/commit/f5593317a6dee0d11bb2db9a5895db1f231=
267a9

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/pantherlake/cache.json           | 152 ++++++++++--
 .../arch/x86/pantherlake/frontend.json        |  60 +++++
 .../arch/x86/pantherlake/memory.json          |  29 +++
 .../arch/x86/pantherlake/other.json           |  10 +
 .../arch/x86/pantherlake/pipeline.json        | 231 +++++++++++++++++-
 6 files changed, 462 insertions(+), 22 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 1a6bb8597cbe..70ba1af93822 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-BD,v1.22,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.21,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
-GenuineIntel-6-CC,v1.04,pantherlake,core
+GenuineIntel-6-(CC|D5),v1.05,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.36,sapphirerapids,core
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/cache.json b/tools/=
perf/pmu-events/arch/x86/pantherlake/cache.json
index e5323093eec0..165e955b870c 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/cache.json
@@ -1,4 +1,13 @@
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
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cache lines replaced in =
L0 data cache.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -130,6 +139,15 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
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
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door requests for Code Read, Data Read, RFO, ITOM, and L2 Prefetches. =
Does not include rejects or recycles, per core event.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -158,6 +176,15 @@
         "UMask": "0xc4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Code Read requests that resulted in a hit. Does not includ=
e rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_CODE_RD_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x84",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Code Read requests that resulted in a Miss. Does not inclu=
de rejects or recycles, per core event.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -176,6 +203,15 @@
         "UMask": "0xc1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Data Read requests that resulted in a hit. Does not includ=
e rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_DATA_RD_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Data Read requests that resulted in a Miss. Does not inclu=
de rejects or recycles, per core event.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -194,6 +230,15 @@
         "UMask": "0xc2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand RFO requests that resulted in a hit. Does not include reje=
cts or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_RFO_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand RFO requests that resulted in a Miss. Does not include rej=
ects or recycles, per core event.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -212,6 +257,16 @@
         "UMask": "0x1bf",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event i=
s alias to L2_RQSTS.HIT]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This=
 event is alias to L2_RQSTS.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x5f",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Hardware Prefetch requests. Does not include rejects or recycles,=
 per core event.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -221,6 +276,24 @@
         "UMask": "0xc8",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Hardware Prefetch requests that result in a hit. Does not include=
 rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HWPF_HIT",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x88",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Hardware Prefetch requests that result in a miss. Does not includ=
e rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HWPF_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x48",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door requests that resulted in a Miss. Does not include rejects or rec=
ycles, per core event.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -310,6 +383,16 @@
         "UMask": "0x21",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "All requests that hit L2 cache. [This event i=
s alias to L2_REQUEST.HIT]",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x24",
+        "EventName": "L2_RQSTS.HIT",
+        "PublicDescription": "Counts all requests that hit L2 cache. [This=
 event is alias to L2_REQUEST.HIT]",
+        "SampleAfterValue": "200003",
+        "UMask": "0x5f",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache [Thi=
s event is alias to L2_REQUEST.MISS]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -1019,6 +1102,19 @@
         "UMask": "0x82",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of tagged load uops retired=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x1",
+        "PublicDescription": "Counts the number of tagged load uops retire=
d. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x5",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 1024.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1033,27 +1129,27 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 128.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 16.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
@@ -1072,79 +1168,79 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 256.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 32.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 4.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 512.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 64.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 8.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
@@ -1159,6 +1255,26 @@
         "UMask": "0x21",
         "Unit": "cpu_atom"
     },
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
+        "UMask": "0x9",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of store uops retired that =
were correctly tagged by the memory renaming (MRN) feature.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd0",
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
+        "UMask": "0xa",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of memory uops retired that=
 were splits.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1220,12 +1336,12 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Counts the number of stores uops retired.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
-        "PublicDescription": "Counts the number of  stores uops retired sa=
me as MEM_UOPS_RETIRED.ALL_STORES Available PDIST counters: 0,1",
+        "PublicDescription": "Counts the number of stores uops retired. Av=
ailable PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x6",
         "Unit": "cpu_atom"
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/frontend.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/frontend.json
index 5e69b81742f5..ef490c38569d 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/frontend.json
@@ -120,6 +120,16 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -344,6 +354,56 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
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
+        "UMask": "0xe",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x6",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of instructions retired tha=
t were tagged because empty issue slots were seen before the uop due to ITL=
B miss that hit in the second level TLB.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/memory.json b/tools=
/perf/pmu-events/arch/x86/pantherlake/memory.json
index 4248cc101391..ac0446359de3 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/memory.json
@@ -26,6 +26,26 @@
         "UMask": "0x81",
         "Unit": "cpu_atom"
     },
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
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
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
+        "UMask": "0xc0",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to request buffers full or loc=
k in progress.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -63,6 +83,15 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MEMORY_ORDERING_FAST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8002",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
         "Counter": "2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/other.json b/tools/=
perf/pmu-events/arch/x86/pantherlake/other.json
index 915c52f5abd1..91dd2d25ebaf 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/other.json
@@ -18,6 +18,16 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/pipeline.json
index 86009237df2f..d476bad5e2a7 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
@@ -258,6 +258,16 @@
         "UMask": "0x30",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "near relative call instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.NEAR_REL_CALL]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -268,6 +278,16 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "near relative jump instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.NEAR_REL_JMP]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -278,6 +298,28 @@
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired. [This event is alias to BR_IN=
ST_RETIRED.ALL_NEAR_IND]",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -298,6 +340,16 @@
         "UMask": "0x50",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Indirect near call instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.NEAR_IND_CALL]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -308,6 +360,16 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Indirect near jump instructions retired. [Thi=
s event is alias to BR_INST_RETIRED.NEAR_IND_JMP]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -328,6 +390,17 @@
         "UMask": "0x58",
         "Unit": "cpu_atom"
     },
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
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_INDIRECT_CALL]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -339,6 +412,17 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_INDIRECT_JMP]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -350,6 +434,16 @@
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near JMP branch instruct=
ions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_JMP",
+        "PublicDescription": "Counts the number of near JMP branch instruc=
tions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc0",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Indirect and Direct Relative near jump instru=
ctions retired.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -382,6 +476,27 @@
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Return instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -966,7 +1081,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
@@ -1554,6 +1669,23 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of machine clears for=
 any reason including, but not limited to, memory ordering, memory disambig=
uation, SMC, and FP assist.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.ANY",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.ANY_FAST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80ff",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of machine clears (nukes) of any type.=
",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -1575,6 +1707,42 @@
         "UMask": "0x8",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.DISAMBIGUATION_FAST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8008",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of virtual traps taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.FPC_VIRTUAL_TRAP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machines clears due to m=
emory renaming.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MRN_NUKE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.MRN_NUKE_FAST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8010",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1603,6 +1771,16 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (cross-core modifying code) within 1K of a recently fe=
tched code page.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.XMC",
+        "PublicDescription": "Counts the number of machine clears due to p=
rogram modifying data (self modifying code) within 1K of a recently fetched=
 code page.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts cycles where no execution is happening=
 due to loads waiting for L1 cache (that is: no execution & load in flight =
& no load missed L1 cache)",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -1650,11 +1828,12 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL.",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to LBR_INSERTS.ANY]",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PublicDescription": "Counts the number of LBR entries recorded. R=
equires LBRs to be enabled in IA32_LBR_CTL. Available PDIST counters: 0,1",
+        "PublicDescription": "This event is deprecated. [This event is ali=
as to LBR_INSERTS.ANY] Available PDIST counters: 0,1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1943,6 +2122,25 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC and FPC RAT stalls - which=
 can be due to the FIQ and IEC reservation station stall (integer, FP and S=
IMD scheduler not being able to accept another uop).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to ROB full",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -2014,6 +2212,15 @@
         "UMask": "0x8",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to frontend bandwidth restricti=
ons due to decode, predecode, cisc, and other limitations.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x71",
+        "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8d",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to latency related stalls inclu=
ding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -2262,6 +2469,14 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of uops retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.ALL",
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles with retired uop(s).",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -2273,6 +2488,16 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of uops retired that are th=
e last uop of a macro-instruction.",
         "Counter": "0,1,2,3,4,5,6,7",
--=20
2.54.0.823.g6e5bcc1fc9-goog

