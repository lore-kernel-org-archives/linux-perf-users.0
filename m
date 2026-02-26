Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3335A3AC
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128796; cv=none; b=n/OzT5Ox1rtq3jFvjIiELUAXi3Ag+dvuYVAF88QXEm3EbtWjSAslwXHE1efsI3kqmG1g/xq5VPB/KzbLWuxAMNBWu3JeRpmjqzlCGrMMcMAT+xprYNq0ixCGUOscqlhDCGqdC7Zi22wIz5opXtCmxDg1YJoSaHO6JPXCbhjaJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128796; c=relaxed/simple;
	bh=8HB/8fTXvYF0e3IyVD5cZEXWiSe42wKk2QckCy5P1Bo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Xbz/iRS/rXAHM9ol20RkSTw0C60WBSohXB+Q1DtMzTdWMUoVbvq9ButLkvlzwj+CG0CtDNEVXmpG7JD1zUZEQX86q9glPL9dNoBzt6Kpih4ZO0Ib5YX6SgwviERkXxgyJn4gOX6vVWV/Y74pygkGdW4i4AR10JZPVgfnH/xY7Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ljt/u4MR; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ljt/u4MR"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdc0bb5ea0so904350eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772128794; x=1772733594; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rboen1rFlhuZgaz8cBCuQXOwR9jkE3g8smiS5BGfdw=;
        b=Ljt/u4MRzdpdjqAA65yTZOZNTYXzV70Yhqb3s0D8THLfaSaR7z/fTvtWGt06rXnrNS
         VbQHziRrxvy4puFqPQvKglCLG9a0dhTohmTSUniTpau2DhWNayfCG0Gif/GbUYKQK4WJ
         UdA5PCvi5gvI2GOOq3VkceZdDEsjJO75/+3jmSc6//aG2IZwIshdXEBFCq1y6i+9PpvT
         6rJ1S40d7P7mbG/E6jlQpYIl9HZWr9fQWC6+dDwjAdBNcQW8TtOuus33ZPhWOrn91D/V
         ddTBL+h9R6dRSwj2YXuM3sjVlVIeqoWdDjuUVIjuj3bo8kWx1QSXs2p421r9xcXVULXd
         HoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772128794; x=1772733594;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8rboen1rFlhuZgaz8cBCuQXOwR9jkE3g8smiS5BGfdw=;
        b=HkNrD3kv+xDj/vAXc8jLexh8bNXk+2253fHHxNx7NffDea4viX76YEIn8biNaO+W3U
         kpedPNYyvi5V1cx/i3FesncKUeOiUwjqRZO3PhogQy9tKVndOm5P0lcuLJEJY4yufu9V
         Ak1ajbMNHVAl1L/r/TYx0xwRjuB4XczQPLBH3gXKMvzcS9P5sohvzAmPK7jAxNR9TLWk
         fPAwLDSqjLjx0EVQAf5J6nGET4XUbXXI1y+4uWUCyQ/tNfzKENwz7hleHCqJ312J/tty
         7BA+zi389PKZmo5+4MLwTArN5RNICBZSoz4F2OsFqq917Z+aOEH0nKK7O1sgwlZzurPd
         THnw==
X-Forwarded-Encrypted: i=1; AJvYcCWEcL2MSQ+gmaUtEHNct9uSKR8mv1uyj29vTmbuTtlKik6bysG96Do/IosOmGM0P+VItROgnCv3Y+fgTaz3u4E0@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4JZcogX4JRze76+EfmKknfvf9PEY7oDFDX0jPw68eLqDpHos
	0s4twNzkStUyWaYYyKci5dpihRyI4oS+nJCGzrpygTNIJ461mOnUQJeIbmTexWtq1HDRBNuDQla
	GaoG3Jwk+3A==
X-Received: from dyfi9.prod.google.com ([2002:a05:7300:2389:b0:2ba:8649:5b66])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fa0d:b0:2ba:990a:4829
 with SMTP id 5a478bee46e88-2bdd305166cmr1480415eec.30.1772128793623; Thu, 26
 Feb 2026 09:59:53 -0800 (PST)
Date: Thu, 26 Feb 2026 09:59:33 -0800
In-Reply-To: <20260226175936.593159-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226175936.593159-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260226175936.593159-7-irogers@google.com>
Subject: [PATCH v2 07/10] perf vendor events intel: Update meteorlake events
 from 1.18 to 1.20
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
https://github.com/intel/perfmon/commit/2eebd8e2612a0655e82b88e1d2fab960315=
c025b
https://github.com/intel/perfmon/commit/81c4ce2c16f05b839d2c40e8cf183ed1103=
57b73

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 67 ++++++++++++++++---
 .../arch/x86/meteorlake/frontend.json         | 18 +++++
 .../arch/x86/meteorlake/pipeline.json         | 46 +++++++++++--
 4 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index a2dde3faad5e..8d8fd8b08166 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.21,lunarlake,core
-GenuineIntel-6-(AA|AC|B5),v1.18,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.20,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-CC,v1.02,pantherlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index d3fc04b2ffbd..4c1220c19456 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -513,6 +513,15 @@
         "UMask": "0x6",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an ICACHE or ITLB miss which hit in the LLC, no sno=
op was required. LLC provides the data. If the core has access to an L3 cac=
he, an LLC hit refers to an L3 cache hit, otherwise it counts zeros.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_HIT_NOSNOOP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an ICACHE or ITLB miss which missed all the caches.=
 If the core has access to an L3 cache, an LLC miss refers to an L3 cache m=
iss, otherwise it is an L2 cache miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -522,6 +531,15 @@
         "UMask": "0x78",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an ICACHE or ITLB miss which missed all the caches.=
 DRAM, MMIO or other LOCAL memory type provides the data. If the core has a=
ccess to an L3 cache, an LLC miss refers to an L3 cache miss, otherwise it =
is an L2 cache miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.LLC_MISS_LOCALMEM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an L1 demand load miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -559,6 +577,24 @@
         "UMask": "0x6",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which hit in the LLC, no snoop w=
as required. LLC provides the data. If the core has access to an L3 cache, =
an LLC hit refers to an L3 cache hit, otherwise it counts zeros.",
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
s required, the snoop misses or the snoop hits but NO_FWD. LLC provides the=
 data. If the core has access to an L3 cache, an LLC hit refers to an L3 ca=
che hit, otherwise it counts zeros.",
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
s. If the core has access to an L3 cache, an LLC miss refers to an L3 cache=
 miss, otherwise it is an L2 cache miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -568,6 +604,15 @@
         "UMask": "0x78",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled to a demand load miss and the data was provided from an un=
known source. If the core has access to an L3 cache, an LLC miss refers to =
an L3 cache miss, otherwise it is an L2 cache miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS_LOCALMEM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled to a store buffer full condition",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -969,7 +1014,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 1024. Only counts with PEBS enabled."=
,
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -981,7 +1026,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 128. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -993,7 +1038,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 16. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1005,7 +1050,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 2048. Only counts with PEBS enabled."=
,
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1017,7 +1062,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 256. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1029,7 +1074,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 32. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1041,7 +1086,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 4. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1053,7 +1098,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 512. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1065,7 +1110,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 64. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1077,7 +1122,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 8. Only counts with PEBS enabled.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1159,7 +1204,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Counts the number of stores uops retired.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/frontend.json
index 6484834b1127..dcf8c8e720f3 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -430,6 +430,24 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "ICACHE_TAG.STALLS_INUSE",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS_INUSE",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "ICACHE_TAG.STALLS_ISB",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x83",
+        "EventName": "ICACHE_TAG.STALLS_ISB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index bfdaabe9377d..7662846745bd 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -517,7 +517,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles. [This event is alias to CPU_CLK_UNHALTED.THREAD]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "SampleAfterValue": "2000003",
@@ -583,7 +583,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
reference clock cycles.",
         "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "SampleAfterValue": "2000003",
@@ -620,7 +620,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
@@ -804,10 +804,10 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
+        "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired.",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PublicDescription": "Fixed Counter: Counts the number of instruct=
ions retired Available PDIST counters: 32",
+        "PublicDescription": "Fixed Counter: Counts the number of instruct=
ions retired. Available PDIST counters: 32",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -1207,6 +1207,42 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of CLFLUSH, CLWB, and CLDEM=
OTE instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC_RETIRED1.CL_INST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of LFENCE instructions reti=
red.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC_RETIRED1.LFENCE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of accesses to KeyLocker ca=
che.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe1",
+        "EventName": "MISC_RETIRED2.KEYLOCKER_ACCESS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of misses to KeyLocker cach=
e.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe1",
+        "EventName": "MISC_RETIRED2.KEYLOCKER_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x11",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
         "Counter": "0,1,2,3,4,5,6,7",
--=20
2.53.0.414.gf7e9f6c205-goog

