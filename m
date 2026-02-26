Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892938A72C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772081606; cv=none; b=R6CLsh5cig2L4tnDPNXhv2rHnh7fl6QZ0M6qBNlZzAvYRA9Ur5YM1AG1REjgkJa/REP6k1gq9rfFGc4W9ZbLeHC2wtsnhegAGx8mgJHOAfm6+6sWMLybmizY/Dg9H/Na1fXPIi6FPQJCMYLpnUV/jWQqFizZ6TATXFR4t3NkuXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772081606; c=relaxed/simple;
	bh=Mk9cvKIy4sON7FwvDT+kYEcqzaMCyPDdIMfb87AYpN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=t/duSIuNxuDv5G7KXbP1D5/v5ufjlW+4CFhIGx9IIXIervz81Ey/GxoScG3vlid9skcS9tNhfpKoK/YQuww+Ri8qEaOqjz+M+gK0IKJrbEh3xdWLDo1NOPEi8fwPSOGT3RyIbey4q3fGifqi1V/yMMf1V8pzCDmIE4OMyrsqBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1VRPv2n; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1VRPv2n"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdc42265a2so432418eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 20:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772081603; x=1772686403; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6npFuJOKDaZnqw/1eVIeZ89jhiawFLS7lh1oSY6kk2o=;
        b=g1VRPv2nuWOo7H/EPLjfdOhPJA4V8QsJVO7pkoAMIBMK8jZh0TO77wQK0gXeSnMGzd
         3n/7RigkarkESAQY8iiFTE3uFWPxSGHKk92FiIwcbgjvP9JfXB2dX3mdVSoP6uLdcSrx
         u+0AFiwHj2W0Y4EWfV+0ghdkHaVBys8YEH1j4gA5EKmdHKWSqc1Ez4qUReYF19ZP0JLU
         uqro4EuyDe8ILM2VcbIfue5WojRfg/0T8gFIdQ9XC58dQ/dPx4QJwJKPlwkF3Da6omJ9
         DXZA6wwKnBtf9E8TwCKAD7/nRLTn9YtzeBJEPEfrxudZ/GpaA8YheBeCBX6EZxoEZVRH
         6HYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772081603; x=1772686403;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6npFuJOKDaZnqw/1eVIeZ89jhiawFLS7lh1oSY6kk2o=;
        b=IUFmeE4E+1URdyDkGP8HKsuw+d5xl8Xc82te3gW48eaFmvc6+Kq8C4cenwAU+6LJk9
         I0HyVIJoIpq7+beTjAh/961B9oTcvaSn0x1v5IIo3rmTOn4Vh7KXubCiemYUPlFxdGFK
         bAxx8l8Z8jfbi9FdhdaAZ9xZz8X93hC1eiO1m7VQuv9a7ImfCnKlVkCDYZl1NZPthwCz
         ZyKAOdJyzH6nb6DJEH7sqC/0AYRl8Lc/gEkZKVZgxsb5N+R4G6j4Jhqt6Nez/L/3CFD9
         7j0muOwr98jxIStAoK89rBlaiecWpFnhuXoMwafq4ifHowMgtsmG/6JvR4eudNNDTVob
         xw5w==
X-Forwarded-Encrypted: i=1; AJvYcCVe3bplzAM6r8wH5Fh2hxM67KYDeHAS8EX69lABA5Tt9P5u/nCnaLMUOBqDfX2odPF8KcRrP8wa4c+HWB6cVZ7P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+61w1wK4GQZSWSmvqVF3ro2tdIQSi9wIg5h3/ohvw2NdaJKrc
	VDiQaKNhWkmjMP5znafevKtLP0CXuK2D6+EQj76cUjhs9hiJ8iWOQNELiDjI1YROeNyXCTzBXjR
	Nv8RDnBiYJA==
X-Received: from dycaa2.prod.google.com ([2002:a05:7301:5402:b0:2ba:95f7:260f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e80e:b0:2ba:7a5f:9e5b
 with SMTP id 5a478bee46e88-2bd7bd60186mr7346436eec.35.1772081602747; Wed, 25
 Feb 2026 20:53:22 -0800 (PST)
Date: Wed, 25 Feb 2026 20:52:59 -0800
In-Reply-To: <20260226045301.459948-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226045301.459948-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226045301.459948-8-irogers@google.com>
Subject: [PATCH v1 08/10] perf vendor events intel: Update pantherlake events
 from 1.02 to 1.04
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
Content-Transfer-Encoding: quoted-printable

The updated events were published in:
https://github.com/intel/perfmon/commit/1f46fa264d202d57dade1d3fd5b58e79c47=
06147
https://github.com/intel/perfmon/commit/e49581aeb2903dde6fb1d187e9d412df58e=
01038

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/pantherlake/cache.json           | 159 +++++++++++++-
 .../arch/x86/pantherlake/floating-point.json  |  28 +++
 .../arch/x86/pantherlake/frontend.json        |  36 ++++
 .../arch/x86/pantherlake/memory.json          |  27 +++
 .../arch/x86/pantherlake/other.json           |  10 +
 .../arch/x86/pantherlake/pipeline.json        | 200 +++++++++++++++++-
 .../arch/x86/pantherlake/virtual-memory.json  |  30 +++
 8 files changed, 485 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 8d8fd8b08166..0839e21d4006 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -26,7 +26,7 @@ GenuineIntel-6-BD,v1.21,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.20,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
-GenuineIntel-6-CC,v1.02,pantherlake,core
+GenuineIntel-6-CC,v1.04,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.35,sapphirerapids,core
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/cache.json b/tools/=
perf/pmu-events/arch/x86/pantherlake/cache.json
index 91f5ab908926..e5323093eec0 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/cache.json
@@ -149,6 +149,60 @@
         "UMask": "0xff",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Code Read requests. Does not include rejects or recycles, =
per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_CODE_RD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Code Read requests that resulted in a Miss. Does not inclu=
de rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_CODE_RD_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x44",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Data Read requests. Does not include rejects or recycles, =
per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_DATA_RD",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand Data Read requests that resulted in a Miss. Does not inclu=
de rejects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_DATA_RD_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x41",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand RFO requests. Does not include rejects or recycles, per co=
re event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_RFO",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Demand RFO requests that resulted in a Miss. Does not include rej=
ects or recycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.DEMAND_RFO_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x42",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door requests that resulted in a Hit. Does not include rejects or recy=
cles, per core event.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -158,6 +212,24 @@
         "UMask": "0x1bf",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door Hardware Prefetch requests. Does not include rejects or recycles,=
 per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HWPF",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache accesses from f=
ront door requests that resulted in a Miss. Does not include rejects or rec=
ycles, per core event.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x17f",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache [Thi=
s event is alias to L2_RQSTS.MISS]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -365,6 +437,24 @@
         "UMask": "0x6",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC, no snoop w=
as required. LLC provided data.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_HIT_NOSNOOP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the local cache=
s.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -716,6 +806,16 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of load ops retired t=
hat miss the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.ALL",
+        "PublicDescription": "Counts the total number of load ops retired =
that miss the L3 cache. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -746,6 +846,26 @@
         "UMask": "0x8",
         "Unit": "cpu_atom"
     },
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
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that hi=
t the L1 data cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -796,6 +916,26 @@
         "UMask": "0x1c",
         "Unit": "cpu_atom"
     },
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
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -880,13 +1020,14 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 1024.",
         "Counter": "0,1,2,3,4,5,6,7",
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
@@ -894,6 +1035,7 @@
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
@@ -906,6 +1048,7 @@
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
@@ -916,13 +1059,14 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 2048.",
         "Counter": "0,1,2,3,4,5,6,7",
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
         "UMask": "0x5",
         "Unit": "cpu_atom"
@@ -930,6 +1074,7 @@
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
@@ -942,6 +1087,7 @@
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
@@ -954,6 +1100,7 @@
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
@@ -966,6 +1113,7 @@
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
@@ -978,6 +1126,7 @@
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
@@ -990,6 +1139,7 @@
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
@@ -1072,6 +1222,7 @@
     {
         "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
         "PublicDescription": "Counts the number of  stores uops retired sa=
me as MEM_UOPS_RETIRED.ALL_STORES Available PDIST counters: 0,1",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json
index e306a45b22ee..77f6c9028d93 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json
@@ -1,4 +1,14 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles when floating-point divide unit is bus=
y executing divide or square root operations.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -10,6 +20,24 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of floating point dividers =
per cycle in the loop stage.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point divider u=
ops executed per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts all microcode FP assists.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/frontend.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/frontend.json
index d36faa683d3f..5e69b81742f5 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/frontend.json
@@ -422,6 +422,24 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache In use-full",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS_INUSE",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache ISB-full",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS_ISB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -561,5 +579,23 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
         "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the micro-se=
quencer is busy.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "MS_DECODED.MS_BUSY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of times entered into a uco=
de flow in the FEC.  Includes inserted flows due to front-end detected faul=
ts or assists.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "MS_DECODED.MS_ENTRY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/memory.json b/tools=
/perf/pmu-events/arch/x86/pantherlake/memory.json
index 3d31e620383d..4248cc101391 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/memory.json
@@ -8,6 +8,24 @@
         "UMask": "0xf4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a DL1 miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DL1 =
miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.L1_MISS_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x81",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to request buffers full or loc=
k in progress.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -17,6 +35,15 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to reques=
t buffers full or lock in progress.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x05",
+        "EventName": "LD_HEAD.WCB_FULL_AT_RET",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x82",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/other.json b/tools/=
perf/pmu-events/arch/x86/pantherlake/other.json
index d49651d4f112..915c52f5abd1 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/other.json
@@ -30,6 +30,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the total number of BTCLEARS.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe8",
+        "EventName": "PREDICTION.BTCLEAR",
+        "PublicDescription": "Counts the total number of BTCLEARS which oc=
curs when the Branch Target Buffer (BTB) predicts a taken branch.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles the uncore cannot take further request=
s",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/pantherlake/pipeline.json
index fb87d30c403d..86009237df2f 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
@@ -1,4 +1,14 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point or integer dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -10,6 +20,16 @@
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of cycles when any of the i=
nteger dividers are active.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles when integer divide unit is busy execu=
ting divide or square root operations.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -21,6 +41,24 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts number of active integer dividers per =
cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of integer divider uops exe=
cuted per cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -58,6 +96,38 @@
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
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
+        "UMask": "0x50",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x58",
+        "Unit": "cpu_atom"
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
+        "UMask": "0x7",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Conditional branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -88,6 +158,16 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of taken conditional branch=
 instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN",
+        "PublicDescription": "Counts the number of taken conditional branc=
h instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Taken conditional branch instructions retired=
.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -98,6 +178,16 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of taken backward condition=
al branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN_BWD",
+        "PublicDescription": "Counts the number of taken backward conditio=
nal branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Taken backward conditional branch instruction=
s retired.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -108,6 +198,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of taken forward conditiona=
l branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
+        "PublicDescription": "Counts the number of taken forward condition=
al branch instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Taken forward conditional branch instructions=
 retired.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -178,6 +278,16 @@
         "UMask": "0x80",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x50",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns) [This event is alias to BR_INST_RETIRED.INDIRECT]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -208,6 +318,16 @@
         "UMask": "0x40",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x58",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to BR_INST_RETIRED.NEAR_INDIRECT_CALL]",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -283,7 +403,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Taken branch instructions retired.",
+        "BriefDescription": "Near Taken branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
@@ -755,7 +875,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "SampleAfterValue": "2000003",
@@ -1549,6 +1669,16 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of CLFLUSH, CLWB, and CLDEM=
OTE instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC_RETIRED1.CL_INST",
+        "PublicDescription": "Counts the number of CLFLUSH, CLWB, and CLDE=
MOTE instructions retired. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of LFENCE instructions reti=
red.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1620,6 +1750,15 @@
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number issue slots not consumed  d=
ue to a  color request for an FCW or MXCSR control register when all 4 colo=
rs (copies) are already in use.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.COLOR_STALLS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots where no uop=
 could issue due to an IQ scoreboard that stalls allocation until a specifi=
ed older uop retires or (in the case of jump scoreboard) executes. Commonly=
 executed instructions with IQ scoreboards include LFENCE and MFENCE.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1732,6 +1871,15 @@
         "UMask": "0x8",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x73",
+        "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to Branch Mispredict",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1795,6 +1943,15 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to ROB full",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x74",
+        "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to iq/jeu scoreboards or ms scb",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -2076,6 +2233,15 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
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
+        "SampleAfterValue": "1000003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Uops that RAT issues to RS",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -2107,6 +2273,16 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -2127,6 +2303,16 @@
         "UMask": "0x80",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of uops retired that origin=
ated from a loop stream detector.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.LSD",
+        "PublicDescription": "Counts the number of uops retired that origi=
nated from a loop stream detector. Available PDIST counters: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS).  This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -2161,6 +2347,16 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "UOPS_RETIRED.NANO_CODE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc2",
+        "EventName": "UOPS_RETIRED.NANO_CODE",
+        "PublicDescription": "UOPS_RETIRED.NANO_CODE Available PDIST count=
ers: 0,1",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that are utilized by operations that eventually get retired (commi=
tted) by the processor pipeline. Usually, this event positively correlates =
with higher performance  for example, as measured by the instructions-per-c=
ycle metric.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/pantherlake/virtual-memory.json=
 b/tools/perf/pmu-events/arch/x86/pantherlake/virtual-memory.json
index 8d56c16b2a39..8f3dd36707dc 100644
--- a/tools/perf/pmu-events/arch/x86/pantherlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/pantherlake/virtual-memory.json
@@ -78,6 +78,16 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
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
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 4K page.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -178,6 +188,16 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
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
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 4K page.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
@@ -267,6 +287,16 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
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
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
--=20
2.53.0.414.gf7e9f6c205-goog

