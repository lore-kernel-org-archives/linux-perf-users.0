Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68221C19E
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704888; cv=none; b=m1Lp9/N3GoJvbMDhPX9aa1RTh9Fc3Yc64MQSxCsTxajCzmMWi6pk+euHgsmZfBefUlmRxt464Qcm2YRxcWyNfN2JxEuC7wjziJhjBNpZ7nRYsmcwCM3LdyPlUt24sv1T8HjiUj5y8qLJ6sH6z9viisYCfpW/mlBSprfkltDeIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704888; c=relaxed/simple;
	bh=xJnW38VuRjiRXlJRlUGK++DeQL6IQI5LtgvI6by1/HU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U4nhc3kgMWrhKbvNc2ydnRUeeogU2hpw8slVm5XLdAf337WhPYt9nSiwPBiJCpBqZMBpDuTGndaYK8ckzJrIX+iiX9g69Ut5IQNItd7kifgZVn15rCxiQ6JjJ9rddESy8ZUl+RvhuhhraPwFek2hUGMQZh2n4UfAU9BufgSriIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGkoEWP9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGkoEWP9"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f988c263d5so4487877b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 13:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738704826; x=1739309626; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLeKcdwdZRixwxVblnO2Tf/vG9Gjz/CgNc3Cs91qmz8=;
        b=HGkoEWP9mM4wco3t6VxMPKBm1te5W7DpuPWlr0D+GU3TfTpRph0THPm9bCYjJZoPG9
         gsyRdeKO1VMKoQmXewBkWW9zac7FmWP68lhLKmlByiVcgEFvt+t1lkgX+OGQaSU4X6R/
         gLw+SOwaVmETUHytpwWcSr09VZXWxO2+wq3RdGruSH3aO5+4FY/i2r0MVfzZKM/UJzlA
         fv9oNgRWIJ9Rek/TuGFYNc864MbH27l36q9WGLStoIGNYnKefVF2PpiN9/UBHYygB75+
         w5qNIOwZ2CN+sKdDotHeI4cpkpqp1RafcNKYkyCklrYS8G2xxgJ+g639y2qIU1mOjINj
         DGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738704826; x=1739309626;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tLeKcdwdZRixwxVblnO2Tf/vG9Gjz/CgNc3Cs91qmz8=;
        b=WVE/xxcimmm5vvR8G3Mdf1QPCgLLuk1I4wx3fK3qLNzIUheOEj5wSXAr9HGSwsDJk8
         J+OKfHsk7F/AKlrecnSfyo2OKCDeODk0+u5Sm4skvysVPkM5W2bmV3LhZNEJ6eOmYvoj
         zHUxmAmDRcIVSb/bcmuTKRW8v6jg7XDq1kWLr2VGFwnTcMQQ8mBzXGPxbVnQdxiaZ5/a
         zHOOH7mVKBTmJuUOFCDy5k2BAmITcnqf/UEAqQCXTx98xD7oLfXuVZjosspx/cH8cikd
         gevRtSmCXaKkIyuzmHF1qTZEhq3qeiXnKvRkeQItNr4BE2DK/eZjBV87ehJaiwaPWRiw
         wIUA==
X-Forwarded-Encrypted: i=1; AJvYcCVpEUHZO2kQGow32JMsHlox2ZOYDM7PmrYk+H6A/dzzF8pY5JAQIoBqzlYjJugMUvjCIJdGqJOz1Qrjs8izBwr9@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQz5IczWgfXkE8BGuKEh6aJmtT4gpM7mDwzN2w3qdfDV5XcvL
	RTc32Z/Y543nDyRC4J/uuEkQvB5EbyHFv9VYR5YTIEWyDpIul5nApoE6R2Zn8cmI3Rzsg8TSsFw
	H3O2Z7w==
X-Google-Smtp-Source: AGHT+IH3FtNImIhy0urR3TjVLqSXUANNlaXTihq8cQOp2gHyqZ4WFPXLsJbVL43VfUCSmxI0nxcYqOCUHIj+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7368:836:b122:bba])
 (user=irogers job=sendgmr) by 2002:a05:690c:2a47:b0:6eb:ac7:b4bc with SMTP id
 00721157ae682-6f989d811acmr18467b3.2.1738704826192; Tue, 04 Feb 2025 13:33:46
 -0800 (PST)
Date: Tue,  4 Feb 2025 13:32:52 -0800
In-Reply-To: <20250204213259.127939-1-irogers@google.com>
Message-Id: <20250204213259.127939-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204213259.127939-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v4 17/23] perf vendor events: Update Meteorlake events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.10 to v1.12.
Update TMA metrics from 4.8 to 5.01.

Bring in the event updates v1.12:
https://github.com/intel/perfmon/commit/d8fe70c91bf8f166ba08edd4d02fd7846a3=
fd956
https://github.com/intel/perfmon/commit/b9dabd05ff44af24fde0682e16d1a716c93=
2f0d0
This updates the mapfile.csv for the 0xB5 CPUID variant of meteorlake.
https://github.com/intel/perfmon/commit/c3094bc9bbaff30071874a492afc3369554=
d572e

The TMA 5.01 addition is from (with subsequent fixes):
https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5c2=
2d782

Co-developed-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |  109 +-
 .../arch/x86/meteorlake/frontend.json         |   30 +-
 .../arch/x86/meteorlake/memory.json           |   22 +-
 .../arch/x86/meteorlake/metricgroups.json     |   10 +-
 .../arch/x86/meteorlake/mtl-metrics.json      | 3552 ++++++++++++++---
 .../pmu-events/arch/x86/meteorlake/other.json |   54 +
 .../arch/x86/meteorlake/pipeline.json         |   89 +-
 8 files changed, 3132 insertions(+), 736 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 33b21764a912..619e9e891328 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -23,7 +23,7 @@ GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
 GenuineIntel-6-BD,v1.11,lunarlake,core
-GenuineIntel-6-A[AC],v1.10,meteorlake,core
+GenuineIntel-6-(AA|AC|B5),v1.12,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.03,rocketlake,core
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/cache.json
index 908e3c7f6d6e..ce351cd7caaf 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/cache.json
@@ -92,11 +92,11 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache when triggered by an L2 cache fill.",
+        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache.",
         "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.SILENT",
-        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache when triggered by an L2 cache fill. These lines are ty=
pically in Shared or Exclusive state. A non-threaded event.",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event.",
         "SampleAfterValue": "200003",
         "UMask": "0x1",
         "Unit": "cpu_core"
@@ -399,7 +399,7 @@
         "Unit": "cpu_atom"
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
@@ -408,7 +408,7 @@
         "Unit": "cpu_atom"
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
@@ -436,7 +436,7 @@
         "Unit": "cpu_atom"
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
@@ -445,7 +445,7 @@
         "Unit": "cpu_atom"
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
@@ -459,7 +459,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
         "SampleAfterValue": "1000003",
         "UMask": "0x81",
@@ -471,7 +470,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82",
@@ -483,7 +481,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
         "SampleAfterValue": "1000003",
         "UMask": "0x83",
@@ -495,7 +492,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with locked=
 access.",
         "SampleAfterValue": "100007",
         "UMask": "0x21",
@@ -507,7 +503,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x41",
@@ -519,7 +514,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
-        "PEBS": "1",
         "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x42",
@@ -531,7 +525,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_HIT_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Number of retired load instructions with a c=
lean hit in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x9",
@@ -543,7 +536,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_HIT_STORES",
-        "PEBS": "1",
         "PublicDescription": "Number of retired store instructions that hi=
t in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0xa",
@@ -555,7 +547,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x11",
@@ -567,7 +558,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
-        "PEBS": "1",
         "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x12",
@@ -589,7 +579,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
         "SampleAfterValue": "20011",
         "UMask": "0x4",
@@ -601,7 +590,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
@@ -613,7 +601,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
         "SampleAfterValue": "100003",
         "UMask": "0x8",
@@ -625,7 +612,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x2",
@@ -637,7 +623,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
-        "PEBS": "1",
         "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -649,7 +634,6 @@
         "Data_LA": "1",
         "EventCode": "0xd4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
         "SampleAfterValue": "100007",
         "UMask": "0x4",
@@ -661,7 +645,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
@@ -673,7 +656,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1",
@@ -685,7 +667,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x8",
@@ -697,7 +678,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
         "SampleAfterValue": "200003",
         "UMask": "0x2",
@@ -709,7 +689,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
         "SampleAfterValue": "100021",
         "UMask": "0x10",
@@ -721,7 +700,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
         "SampleAfterValue": "100021",
         "UMask": "0x4",
@@ -733,7 +711,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
         "SampleAfterValue": "50021",
         "UMask": "0x20",
@@ -1027,6 +1004,36 @@
         "UMask": "0x42",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 missed in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x13",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the second Level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x11",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of store uops retired that =
miss in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x12",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1047,6 +1054,50 @@
         "UMask": "0x3",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F803C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and modified data was forwarded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, but no data was forwarded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and non-modified data was forwarded.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/frontend.json
index b6c52f7385fc..a10614513c8d 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/frontend.json
@@ -55,7 +55,6 @@
         "EventName": "FRONTEND_RETIRED.ANY_ANT",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x9",
-        "PEBS": "1",
         "PublicDescription": "Always Not Taken (ANT) conditional retired b=
ranches (no BTB entry and not mispredicted)",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -68,7 +67,6 @@
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x1",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -81,7 +79,6 @@
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x11",
-        "PEBS": "1",
         "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -103,7 +100,6 @@
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x14",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -116,7 +112,6 @@
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x12",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -129,7 +124,6 @@
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x13",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -142,7 +136,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600106",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -155,7 +148,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x608006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -168,7 +160,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x601006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -181,7 +172,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600206",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -194,7 +184,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x610006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -207,7 +196,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x100206",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -220,7 +208,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x602006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -233,7 +220,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600406",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -246,7 +232,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x620006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -259,7 +244,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x604006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -272,7 +256,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x600806",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -285,7 +268,6 @@
         "EventName": "FRONTEND_RETIRED.MISP_ANT",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x9",
-        "PEBS": "1",
         "PublicDescription": "ANT retired branches that got just mispredic=
ted",
         "SampleAfterValue": "100007",
         "UMask": "0x2",
@@ -298,7 +280,6 @@
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
-        "PEBS": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -310,7 +291,6 @@
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x15",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
@@ -323,7 +303,6 @@
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x17",
-        "PEBS": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x3",
         "Unit": "cpu_core"
@@ -539,5 +518,14 @@
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
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json b/tools/=
perf/pmu-events/arch/x86/meteorlake/memory.json
index b464a8ab32ca..e4481fbc1e13 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/memory.json
@@ -143,7 +143,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x400",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency.",
         "SampleAfterValue": "53",
         "UMask": "0x1",
@@ -157,7 +156,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "1009",
         "UMask": "0x1",
@@ -171,7 +169,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "20011",
         "UMask": "0x1",
@@ -185,7 +182,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x800",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 2048 cycles.  Reporte=
d latency may be longer than just the memory latency.",
         "SampleAfterValue": "23",
         "UMask": "0x1",
@@ -199,7 +195,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "503",
         "UMask": "0x1",
@@ -213,7 +208,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "100007",
         "UMask": "0x1",
@@ -227,7 +221,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "100003",
         "UMask": "0x1",
@@ -241,7 +234,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "101",
         "UMask": "0x1",
@@ -255,7 +247,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "2003",
         "UMask": "0x1",
@@ -269,7 +260,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
         "UMask": "0x1",
@@ -281,7 +271,6 @@
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
-        "PEBS": "2",
         "PublicDescription": "Counts Retired memory accesses with at least=
 1 store operation. This PEBS event is the precisely-distributed (PDist) tr=
igger covering all stores uops for sampling by the PEBS Store Latency Facil=
ity. The facility is described in Intel SDM Volume 3 section 19.9.8",
         "SampleAfterValue": "1000003",
         "UMask": "0x2",
@@ -305,6 +294,17 @@
         "UMask": "0x4",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3FBFC00004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json b/=
tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
index b54a5fc0861f..855585fe6fae 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
@@ -41,6 +41,7 @@
     "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "Load_Store_Miss": "Grouping from Top-down Microarchitecture Analysis =
Metrics spreadsheet",
+    "LockCont": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "MachineClears": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
     "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -89,7 +90,9 @@
     "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
     "tma_branch_mispredicts_group": "Metrics contributing to tma_branch_mi=
spredicts category",
     "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
+    "tma_code_stlb_miss_group": "Metrics contributing to tma_code_stlb_mis=
s category",
     "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
+    "tma_divider_group": "Metrics contributing to tma_divider category",
     "tma_dram_bound_group": "Metrics contributing to tma_dram_bound catego=
ry",
     "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load category=
",
     "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store catego=
ry",
@@ -99,6 +102,7 @@
     "tma_fp_vector_group": "Metrics contributing to tma_fp_vector category=
",
     "tma_frontend_bound_group": "Metrics contributing to tma_frontend_boun=
d category",
     "tma_heavy_operations_group": "Metrics contributing to tma_heavy_opera=
tions category",
+    "tma_icache_misses_group": "Metrics contributing to tma_icache_misses =
category",
     "tma_ifetch_bandwidth_group": "Metrics contributing to tma_ifetch_band=
width category",
     "tma_ifetch_latency_group": "Metrics contributing to tma_ifetch_latenc=
y category",
     "tma_int_operations_group": "Metrics contributing to tma_int_operation=
s category",
@@ -121,10 +125,13 @@
     "tma_issueSpSt": "Metrics related by the issue $issueSpSt",
     "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
     "tma_issueTLB": "Metrics related by the issue $issueTLB",
+    "tma_itlb_misses_group": "Metrics contributing to tma_itlb_misses cate=
gory",
     "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
+    "tma_l2_bound_group": "Metrics contributing to tma_l2_bound category",
     "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category",
     "tma_light_operations_group": "Metrics contributing to tma_light_opera=
tions category",
     "tma_load_op_utilization_group": "Metrics contributing to tma_load_op_=
utilization category",
+    "tma_load_stlb_miss_group": "Metrics contributing to tma_load_stlb_mis=
s category",
     "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
     "tma_mem_latency_group": "Metrics contributing to tma_mem_latency cate=
gory",
     "tma_memory_bound_group": "Metrics contributing to tma_memory_bound ca=
tegory",
@@ -138,5 +145,6 @@
     "tma_retiring_group": "Metrics contributing to tma_retiring category",
     "tma_serializing_operation_group": "Metrics contributing to tma_serial=
izing_operation category",
     "tma_store_bound_group": "Metrics contributing to tma_store_bound cate=
gory",
-    "tma_store_op_utilization_group": "Metrics contributing to tma_store_o=
p_utilization category"
+    "tma_store_op_utilization_group": "Metrics contributing to tma_store_o=
p_utilization category",
+    "tma_store_stlb_miss_group": "Metrics contributing to tma_store_stlb_m=
iss category"
 }
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json b/t=
ools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
index 1a7392f0da86..5c04a64812d1 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
@@ -84,54 +84,219 @@
         "MetricName": "smi_num",
         "ScaleUnit": "1SMI#"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duration_=
time / 1e9",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to certain allocation restrictions",
-        "MetricExpr": "tma_core_bound",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (6 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_allocation_restriction",
-        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core_b=
ound > 0.1 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_allocation_restriction >0.10) & ((tma_cor=
e_bound >0.10) & ((tma_backend_bound >0.10)))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
+        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS_D=
ISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_DIS=
PATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
+        "MetricGroup": "Core_Execution;TopdownL5;tma_L5_group;tma_ports_ut=
ilized_3m_group",
+        "MetricName": "tma_alu_op_utilization",
+        "MetricThreshold": "tma_alu_op_utilization > 0.4",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
+        "MetricExpr": "78 * cpu_core@ASSISTS.ANY@ / tma_info_thread_slots"=
,
+        "MetricGroup": "BvIO;Slots_Estimated;TopdownL4;tma_L4_group;tma_mi=
crocode_sequencer_group",
+        "MetricName": "tma_assists",
+        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists",
+        "MetricExpr": "63 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_threa=
d_slots",
+        "MetricGroup": "HPC;Slots_Estimated;TopdownL5;tma_L5_group;tma_ass=
ists_group",
+        "MetricName": "tma_avx_assists",
+        "MetricThreshold": "tma_avx_assists > 0.1",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend due to backend stalls",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALL_P@ / (6 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
+        "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
-        "MetricThreshold": "tma_backend_bound > 0.1",
+        "MetricThreshold": "tma_backend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
+        "PublicDescription": "This category represents fraction of slots w=
here no uops are being delivered due to a lack of required resources for ac=
cepting new uops in the Backend. Backend is the portion of the processor co=
re where the out-of-order scheduler dispatches ready uops into their respec=
tive execution units; and once completed these uops get retired according t=
o program order. For example; stalls due to data-cache misses or stalls due=
 to the divider unit being overloaded are both categorized under Backend Bo=
und. Backend Bound is further divided into two main categories: Memory Boun=
d and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
-        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.ALL_P@ / (6 * cpu_=
atom@CPU_CLK_UNHALTED.CORE@)",
+        "BriefDescription": "This category represents fraction of slots wa=
sted due to incorrect speculations",
+        "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound + t=
ma_retiring), 0)",
         "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misses =
+ tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
+        "MetricGroup": "BigFootprint;BvBC;Default;Fed;Frontend;IcMiss;Memo=
ryTLB;Scaled_Slots;TopdownL1;tma_L1_group",
+        "MetricName": "tma_bottleneck_big_code",
+        "MetricThreshold": "tma_bottleneck_big_code > 20",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ + 2 =
* cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRED.NOP@) / tma_i=
nfo_thread_slots)",
+        "MetricGroup": "BvBO;Default;Ret;Scaled_Slots;TopdownL1;tma_L1_gro=
up",
+        "MetricName": "tma_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dr=
am_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_store_fwd_blk + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_fb_full)=
))",
+        "MetricGroup": "BvMB;Default;Mem;MemoryBW;Offcore;Scaled_Slots;Top=
downL1;tma_L1_group;tma_issueBW",
+        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
+        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_mem_b=
andwidth, tma_sq_full",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + =
tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_de=
pendency + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_=
bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_d=
ram_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_st=
ore_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_load=
s + tma_fb_full)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_=
l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_split_l=
oads / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_dependency + tma=
_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound * (tma_s=
tore_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_split_stores / (tma_store_latency + tma_false_sha=
ring + tma_split_stores + tma_streaming_stores + tma_dtlb_store)) + tma_mem=
ory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_dram_bound + tma_store_bound)) * (tma_store_latency / (tma_store_late=
ncy + tma_false_sharing + tma_split_stores + tma_streaming_stores + tma_dtl=
b_store)))",
+        "MetricGroup": "BvML;Default;Mem;MemoryLat;Offcore;Scaled_Slots;To=
pdownL1;tma_L1_group;tma_issueLat",
+        "MetricName": "tma_bottleneck_cache_memory_latency",
+        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_serializing_operation + tma_ports_utilization) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_serializing_operation + tma_ports_=
utilization)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricGroup": "BvCB;Cor;Default;Scaled_Slots;TopdownL1;tma_L1_gro=
up;tma_issueComp",
+        "MetricName": "tma_bottleneck_compute_bound_est",
+        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses + t=
ma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
0x1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_=
clears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_br=
anch_mispredicts) / (tma_mispredicts_resteers + tma_clears_resteers + tma_u=
nknown_branches)) / (tma_icache_misses + tma_itlb_misses + tma_branch_reste=
ers + tma_ms_switches + tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth *=
 tma_ms / (tma_mite + tma_dsb + tma_lsd + tma_ms))) - tma_bottleneck_big_co=
de",
+        "MetricGroup": "BvFB;Default;Fed;FetchBW;Frontend;Scaled_Slots;Top=
downL1;tma_L1_group",
+        "MetricName": "tma_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_fetch_latency * (tma_ms_s=
witches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_rest=
eers * tma_other_mispredicts / tma_branch_mispredicts) / (tma_mispredicts_r=
esteers + tma_clears_resteers + tma_unknown_branches)) / (tma_icache_misses=
 + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_=
dsb_switches) + tma_fetch_bandwidth * tma_ms / (tma_mite + tma_dsb + tma_ls=
d + tma_ms)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_b=
ranch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other=
_nukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + cp=
u_core@RS.EMPTY_RESOURCE@ / tma_info_thread_clks * tma_ports_utilized_0) / =
(tma_divider + tma_serializing_operation + tma_ports_utilization) + tma_mic=
rocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) * =
(tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricGroup": "Bad;BvIO;Cor;Default;Ret;Scaled_Slots;TopdownL1;tm=
a_L1_group;tma_issueMS",
+        "MetricName": "tma_bottleneck_irregular_overhead",
+        "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_depende=
ncy + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound=
 * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dra=
m_bound + tma_store_bound)) * (tma_dtlb_store / (tma_store_latency + tma_fa=
lse_sharing + tma_split_stores + tma_streaming_stores + tma_dtlb_store)))",
+        "MetricGroup": "BvMT;Default;Mem;MemoryTLB;Offcore;Scaled_Slots;To=
pdownL1;tma_L1_group;tma_issueTLB",
+        "MetricName": "tma_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * =
tma_false_sharing / (tma_store_latency + tma_false_sharing + tma_split_stor=
es + tma_streaming_stores + tma_dtlb_store - tma_store_latency)) + tma_mach=
ine_clears * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricGroup": "BvMS;Default;LockCont;Mem;Offcore;Scaled_Slots;Top=
downL1;tma_L1_group;tma_issueSyncxn",
+        "MetricName": "tma_bottleneck_memory_synchronization",
+        "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_contested_accesses, tma_data_sharing, tma_false_s=
haring, tma_machine_clears",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses=
 + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;Default;Scaled_Slot=
s;TopdownL1;tma_L1_group;tma_issueBM",
+        "MetricName": "tma_bottleneck_mispredictions",
+        "MetricThreshold": "tma_bottleneck_mispredictions > 20",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_cache_me=
mory_bandwidth + tma_bottleneck_cache_memory_latency + tma_bottleneck_memor=
y_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottleneck_comput=
e_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_branching_=
overhead + tma_bottleneck_useful_work)",
+        "MetricGroup": "BvOB;Cor;Default;Offcore;Scaled_Slots;TopdownL1;tm=
a_L1_group",
+        "MetricName": "tma_bottleneck_other_bottlenecks",
+        "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "100 * (tma_retiring - (cpu_core@BR_INST_RETIRED.ALL=
_BRANCHES@ + 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRE=
D.NOP@) / tma_info_thread_slots - tma_microcode_sequencer / (tma_few_uops_i=
nstructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_seque=
ncer) * tma_heavy_operations)",
+        "MetricGroup": "BvUW;Default;Ret;Scaled_Slots;TopdownL1;tma_L1_gro=
up",
+        "MetricName": "tma_bottleneck_useful_work",
+        "MetricThreshold": "tma_bottleneck_useful_work > 20",
+        "MetricgroupNoGroup": "TopdownL1;Default",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BACLEARS, which occurs when the Branch T=
arget Buffer (BTB) prediction or lack thereof, was corrected by a later bra=
nch predictor in the frontend",
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ / (6 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_detect",
-        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_branch_detect >0.05) & ((tma_ifetch_laten=
cy >0.15) & ((tma_frontend_bound >0.20)))",
         "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s.",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to branch mispredicts",
-        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / (6 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * sl=
ots",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
-        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
+        "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: =
tma_bottleneck_mispredictions, tma_info_bad_spec_branch_misprediction_cost,=
 tma_mispredicts_resteers",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -140,563 +305,2402 @@
         "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ / (6 * cp=
u_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_resteer",
-        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_branch_resteer >0.05) & ((tma_ifetch_late=
ncy >0.15) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS).",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (6 * cpu_atom@CPU=
_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
-        "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers",
+        "MetricExpr": "cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_=
thread_clks + tma_unknown_branches",
+        "MetricGroup": "Clocks;FetchLat;TopdownL3;tma_L3_group;tma_fetch_l=
atency_group;tma_overlap",
+        "MetricName": "tma_branch_resteers",
+        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are bounded by core restrictions and not attributed to an o=
utstanding load or stores, or resource limitation",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (6 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
-        "MetricName": "tma_core_bound",
-        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
-        "MetricgroupNoGroup": "TopdownL2",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings)",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C01@ / tma_info_thread_cl=
ks",
+        "MetricGroup": "C0Wait;Clocks;TopdownL4;tma_L4_group;tma_serializi=
ng_operation_group",
+        "MetricName": "tma_c01_wait",
+        "MetricThreshold": "tma_c01_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / (6 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings)",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C02@ / tma_info_thread_cl=
ks",
+        "MetricGroup": "C0Wait;Clocks;TopdownL4;tma_L4_group;tma_serializi=
ng_operation_group",
+        "MetricName": "tma_c02_wait",
+        "MetricThreshold": "tma_c02_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU retired uops originated from CISC (complex instruction set computer) in=
struction",
+        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
-        "MetricName": "tma_decode",
-        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
+        "MetricName": "tma_cisc",
+        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources. Sample with: FRONTEND_RETIRE=
D.MS_FLOWS",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that does not require the =
use of microcode, classified as a fast nuke, due to memory ordering, memory=
 disambiguation and memory renaming",
-        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / (6 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
-        "MetricName": "tma_fast_nuke",
-        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Machine Clears",
+        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
+        "MetricGroup": "BadSpec;Clocks;MachineClears;TopdownL4;tma_L4_grou=
p;tma_branch_resteers_group;tma_issueMC",
+        "MetricName": "tma_clears_resteers",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_restee=
rs > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Sam=
ple with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, tma=
_machine_clears, tma_microcode_sequencer, tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ALL_P@ / (6 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
-        "MetricName": "tma_frontend_bound",
-        "MetricThreshold": "tma_frontend_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL1",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache",
+        "MetricExpr": "max(0, cpu_core@FRONTEND_RETIRED.L1I_MISS@ * cpu_co=
re@frontend_retired.l1i_miss@R / tma_info_thread_clks - tma_code_l2_miss)",
+        "MetricGroup": "Clocks_Retired;FetchLat;IcMiss;Offcore;TopdownL4;t=
ma_L4_group;tma_icache_misses_group",
+        "MetricName": "tma_code_l2_hit",
+        "MetricThreshold": "tma_code_l2_hit > 0.05 & tma_icache_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / (6 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
-        "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.L2_MISS@ * cpu_core@front=
end_retired.l2_miss@R / tma_info_thread_clks",
+        "MetricGroup": "Clocks_Retired;FetchLat;IcMiss;Offcore;TopdownL4;t=
ma_L4_group;tma_icache_misses_group",
+        "MetricName": "tma_code_l2_miss",
+        "MetricThreshold": "tma_code_l2_miss > 0.05 & tma_icache_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (6 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
-        "MetricName": "tma_ifetch_bandwidth",
-        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
-        "MetricgroupNoGroup": "TopdownL2",
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) ITLB was missed by instructions fetches, th=
at later on hit in second-level TLB (STLB)",
+        "MetricExpr": "max(0, cpu_core@FRONTEND_RETIRED.ITLB_MISS@ * cpu_c=
ore@frontend_retired.itlb_miss@R / tma_info_thread_clks - tma_code_stlb_mis=
s)",
+        "MetricGroup": "Clocks_Retired;FetchLat;MemoryTLB;TopdownL4;tma_L4=
_group;tma_itlb_misses_group",
+        "MetricName": "tma_code_stlb_hit",
+        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (6 * =
cpu_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
-        "MetricName": "tma_ifetch_latency",
-        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
-        "MetricgroupNoGroup": "TopdownL2",
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by instruction fetches, perfor=
ming a hardware page walk",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.STLB_MISS@ * cpu_core@fro=
ntend_retired.stlb_miss@R / tma_info_thread_clks",
+        "MetricGroup": "Clocks_Retired;FetchLat;MemoryTLB;TopdownL4;tma_L4=
_group;tma_itlb_misses_group",
+        "MetricName": "tma_code_stlb_miss",
+        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@FP_FLOPS_RETI=
RED.ALL@",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_arith_inst_mix_ipflop",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses",
+        "MetricExpr": "cpu_core@ITLB_MISSES.WALK_ACTIVE@ / tma_info_thread=
_clks * cpu_core@ITLB_MISSES.WALK_COMPLETED_2M_4M@ / (cpu_core@ITLB_MISSES.=
WALK_COMPLETED_4K@ + cpu_core@ITLB_MISSES.WALK_COMPLETED_2M_4M@)",
+        "MetricGroup": "Clocks_Estimated;FetchLat;MemoryTLB;TopdownL5;tma_=
L5_group;tma_code_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_2m",
+        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@FP_INST_RETI=
RED.128B_DP@ + cpu_atom@FP_INST_RETIRED.128B_SP@)",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_arith_inst_mix_ipfparith_avx128",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses",
+        "MetricExpr": "cpu_core@ITLB_MISSES.WALK_ACTIVE@ / tma_info_thread=
_clks * cpu_core@ITLB_MISSES.WALK_COMPLETED_4K@ / (cpu_core@ITLB_MISSES.WAL=
K_COMPLETED_4K@ + cpu_core@ITLB_MISSES.WALK_COMPLETED_2M_4M@)",
+        "MetricGroup": "Clocks_Estimated;FetchLat;MemoryTLB;TopdownL5;tma_=
L5_group;tma_code_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_4k",
+        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@FP_INST_RETIR=
ED.64B_DP@",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_arith_inst_mix_ipfparith_scalar_dp",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by non-taken conditional bran=
ches",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_NTAKEN_COST@ * cpu_co=
re@br_misp_retired.cond_ntaken_cost@R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;Clocks_Retired;TopdownL3;tma_L3_grou=
p;tma_branch_mispredicts_group",
+        "MetricName": "tma_cond_nt_mispredicts",
+        "MetricThreshold": "tma_cond_nt_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@FP_INST_RETIR=
ED.32B_SP@",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_arith_inst_mix_ipfparith_scalar_sp",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by taken conditional branches",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_TAKEN_COST@ * cpu_cor=
e@br_misp_retired.cond_taken_cost@R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;Clocks_Retired;TopdownL3;tma_L3_grou=
p;tma_branch_mispredicts_group",
+        "MetricName": "tma_cond_tk_mispredicts",
+        "MetricThreshold": "tma_cond_tk_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
-        "MetricExpr": "100 * (cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ + cpu_ato=
m@LD_HEAD.PGWALK_AT_RET@) / cpu_atom@CPU_CLK_UNHALTED.CORE@",
-        "MetricName": "tma_info_bottleneck_%_dtlb_miss_bound_cycles",
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
+        "MetricExpr": "((min(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ *=
 cpu_core@mem_load_l3_hit_retired.xsnp_miss@R, cpu_core@MEM_LOAD_L3_HIT_RET=
IRED.XSNP_MISS@ * (27 * tma_info_system_core_frequency) - 3 * tma_info_syst=
em_core_frequency) if 0 < cpu_core@mem_load_l3_hit_retired.xsnp_miss@R else=
 cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ * (27 * tma_info_system_core_f=
requency) - 3 * tma_info_system_core_frequency) + (min(cpu_core@MEM_LOAD_L3=
_HIT_RETIRED.XSNP_FWD@ * cpu_core@mem_load_l3_hit_retired.xsnp_fwd@R, cpu_c=
ore@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (28 * tma_info_system_core_frequenc=
y) - 3 * tma_info_system_core_frequency) if 0 < cpu_core@mem_load_l3_hit_re=
tired.xsnp_fwd@R else cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (28 * tm=
a_info_system_core_frequency) - 3 * tma_info_system_core_frequency) * (cpu_=
core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L=
3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@)=
)) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_=
MISS@ / 2) / tma_info_thread_clks",
+        "MetricGroup": "BvMS;Clocks_Estimated;DataSharing;LockCont;Offcore=
;Snoop;TopdownL4;tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
+        "MetricName": "tma_contested_accesses",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related =
metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false=
_sharing, tma_machine_clears",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of time that allocation and retire=
ment is stalled by the Frontend Cluster due to an Ifetch Miss, either Icach=
e or ITLB Miss",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.ALL@ / cpu_a=
tom@CPU_CLK_UNHALTED.CORE@",
-        "MetricGroup": "Ifetch",
-        "MetricName": "tma_info_bottleneck_%_ifetch_miss_bound_cycles",
-        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound",
+        "BriefDescription": "This metric represents fraction of slots wher=
e Core non-memory issues were of a bottleneck",
+        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricName": "tma_core_bound",
+        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
+        "MetricgroupNoGroup": "TopdownL2",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations)",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 due to an L1 miss",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@ / cpu_ato=
m@CPU_CLK_UNHALTED.CORE@",
-        "MetricGroup": "Load_Store_Miss",
-        "MetricName": "tma_info_bottleneck_%_load_miss_bound_cycles",
-        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound",
+        "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
+        "MetricExpr": "((min(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@=
 * cpu_core@mem_load_l3_hit_retired.xsnp_no_fwd@R, cpu_core@MEM_LOAD_L3_HIT=
_RETIRED.XSNP_NO_FWD@ * (27 * tma_info_system_core_frequency) - 3 * tma_inf=
o_system_core_frequency) if 0 < cpu_core@mem_load_l3_hit_retired.xsnp_no_fw=
d@R else cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ * (27 * tma_info_sys=
tem_core_frequency) - 3 * tma_info_system_core_frequency) + (min(cpu_core@M=
EM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * cpu_core@mem_load_l3_hit_retired.xsnp_fw=
d@R, cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (27 * tma_info_system_cor=
e_frequency) - 3 * tma_info_system_core_frequency) if 0 < cpu_core@mem_load=
_l3_hit_retired.xsnp_fwd@R else cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ =
* (27 * tma_info_system_core_frequency) - 3 * tma_info_system_core_frequenc=
y) * (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DE=
MAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_=
HIT_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LO=
AD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
+        "MetricGroup": "BvMS;Clocks_Estimated;Offcore;Snoop;TopdownL4;tma_=
L4_group;tma_issueSyncxn;tma_l3_bound_group",
+        "MetricName": "tma_data_sharing",
+        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_synch=
ronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 by the Memory Cluster due to a pipeline stall",
-        "MetricExpr": "100 * cpu_atom@LD_HEAD.ANY_AT_RET@ / cpu_atom@CPU_C=
LK_UNHALTED.CORE@",
-        "MetricGroup": "Mem_Exec",
-        "MetricName": "tma_info_bottleneck_%_mem_exec_bound_cycles",
-        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / (6 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricName": "tma_decode",
+        "MetricThreshold": "(tma_decode >0.05) & ((tma_ifetch_bandwidth >0=
.10) & ((tma_frontend_bound >0.20)))",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIR=
ED.ALL_BRANCHES@",
-        "MetricName": "tma_info_br_inst_mix_ipbranch",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
+        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - =
cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks =
/ 2",
+        "MetricGroup": "DSBmiss;FetchBW;Slots_Estimated;TopdownL4;tma_L4_g=
roup;tma_issueD0;tma_mite_group",
+        "MetricName": "tma_decoder0_alone",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & tma_mite > 0.1 & tm=
a_fetch_bandwidth > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIR=
ED.NEAR_CALL@",
-        "MetricName": "tma_info_br_inst_mix_ipcall",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
+        "MetricExpr": "cpu_core@ARITH.DIV_ACTIVE@ / tma_info_thread_clks",
+        "MetricGroup": "BvCB;Clocks;TopdownL3;tma_L3_group;tma_core_bound_=
group",
+        "MetricName": "tma_divider",
+        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & tma=
_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIV_ACTIVE",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIR=
ED.FAR_BRANCH@u",
-        "MetricName": "tma_info_br_inst_mix_ipfarbranch",
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
+        "MetricExpr": "cpu_core@MEMORY_ACTIVITY.STALLS_L3_MISS@ / tma_info=
_thread_clks",
+        "MetricGroup": "MemoryBound;Stalls;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
+        "MetricName": "tma_dram_bound",
+        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_MISP_RETI=
RED.COND@ - cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)",
-        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_ntaken",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to DSB (decoded uop cache) fetch pipe=
line",
+        "MetricExpr": "(cpu_core@IDQ.DSB_CYCLES_ANY@ - cpu_core@IDQ.DSB_CY=
CLES_OK@) / tma_info_core_core_clks / 2",
+        "MetricGroup": "DSB;FetchBW;Slots_Estimated;TopdownL3;tma_L3_group=
;tma_fetch_bandwidth_group",
+        "MetricName": "tma_dsb",
+        "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was taken",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.COND_TAKEN@",
-        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_taken",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to switches from DSB to MITE pipelines",
+        "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / tma_in=
fo_thread_clks",
+        "MetricGroup": "Clocks;DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma=
_fetch_latency_group;tma_issueFB",
+        "MetricName": "tma_dsb_switches",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwi=
dth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_inf=
o_inst_mix_iptb, tma_lcp",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per retired indirect call or jum=
p Branch Misprediction",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.INDIRECT@",
-        "MetricName": "tma_info_br_inst_mix_ipmisp_indirect",
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
+        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.STLB_HIT_LOADS@ * cp=
u_core@mem_inst_retired.stlb_hit_loads@R, cpu_core@MEM_INST_RETIRED.STLB_HI=
T_LOADS@ * 7) if 0 < cpu_core@mem_inst_retired.stlb_hit_loads@R else cpu_co=
re@MEM_INST_RETIRED.STLB_HIT_LOADS@ * 7) / tma_info_thread_clks + tma_load_=
stlb_miss",
+        "MetricGroup": "BvMT;Clocks_Estimated;MemoryTLB;TopdownL4;tma_L4_g=
roup;tma_issueTLB;tma_l1_bound_group",
+        "MetricName": "tma_dtlb_load",
+        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma=
_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS. Related metrics: tma_=
bottleneck_memory_data_tlbs, tma_dtlb_store",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per retired return Branch Mispre=
diction",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.RETURN@",
-        "MetricName": "tma_info_br_inst_mix_ipmisp_ret",
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
+        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.STLB_HIT_STORES@ * c=
pu_core@mem_inst_retired.stlb_hit_stores@R, cpu_core@MEM_INST_RETIRED.STLB_=
HIT_STORES@ * 7) if 0 < cpu_core@mem_inst_retired.stlb_hit_stores@R else cp=
u_core@MEM_INST_RETIRED.STLB_HIT_STORES@ * 7) / tma_info_thread_clks + tma_=
store_stlb_miss",
+        "MetricGroup": "BvMT;Clocks_Estimated;MemoryTLB;TopdownL4;tma_L4_g=
roup;tma_issueTLB;tma_store_bound_group",
+        "MetricName": "tma_dtlb_store",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.2 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES. Related metrics: tma_bottleneck_mem=
ory_data_tlbs, tma_dtlb_load",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per retired Branch Misprediction=
",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.ALL_BRANCHES@",
-        "MetricName": "tma_info_br_inst_mix_ipmispredict",
+        "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
+        "MetricExpr": "28 * tma_info_system_core_frequency * cpu_core@OCR.=
DEMAND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_thread_clks",
+        "MetricGroup": "BvMS;Clocks_Estimated;DataSharing;LockCont;Offcore=
;Snoop;TopdownL4;tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
+        "MetricName": "tma_false_sharing",
+        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound > 0=
.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronization, t=
ma_contested_accesses, tma_data_sharing, tma_machine_clears",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Ratio of all branches which mispredict",
-        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom@B=
R_INST_RETIRED.ALL_BRANCHES@",
-        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_rati=
o",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that does not require the =
use of microcode, classified as a fast nuke, due to memory ordering, memory=
 disambiguation and memory renaming",
+        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / (6 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_fast_nuke",
+        "MetricThreshold": "(tma_fast_nuke >0.05) & ((tma_machine_clears >=
0.05) & ((tma_bad_speculation >0.15)))",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
-        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom@B=
ACLEARS.ANY@",
-        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_to_u=
nknown_branch_ratio",
+        "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
+        "MetricExpr": "cpu_core@L1D_PEND_MISS.FB_FULL@ / tma_info_thread_c=
lks",
+        "MetricGroup": "BvMB;Clocks_Calculated;MemoryBW;TopdownL4;tma_L4_g=
roup;tma_issueBW;tma_issueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricName": "tma_fb_full",
+        "MetricThreshold": "tma_fb_full > 0.3",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_cache_memory_bandwidth, =
tma_mem_bandwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
-        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.LD_BUF@ / cpu_at=
om@CPU_CLK_UNHALTED.CORE@",
-        "MetricName": "tma_info_buffer_stalls_%_load_buffer_stall_cycles",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend bandwidth issues",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
+        "MetricGroup": "Default;FetchBW;Frontend;Slots;TmaL2;TopdownL2;tma=
_L2_group;tma_frontend_bound_group;tma_issueFB",
+        "MetricName": "tma_fetch_bandwidth",
+        "MetricThreshold": "tma_fetch_bandwidth > 0.2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1, FRONTEND_RETIRED.LATE=
NCY_GE_1, FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches,=
 tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to memory reservation stations full",
-        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.RSV@ / cpu_atom@=
CPU_CLK_UNHALTED.CORE@",
-        "MetricName": "tma_info_buffer_stalls_%_mem_rsv_stall_cycles",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - cpu_core@I=
NT_MISC.UOP_DROPPING@ / tma_info_thread_slots",
+        "MetricGroup": "Default;Frontend;Slots;TmaL2;TopdownL2;tma_L2_grou=
p;tma_frontend_bound_group",
+        "MetricName": "tma_fetch_latency",
+        "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16, FRONTEND_RETIRED.LATENCY_GE_8",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to store buffer full",
-        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_at=
om@CPU_CLK_UNHALTED.CORE@",
-        "MetricName": "tma_info_buffer_stalls_%_store_buffer_stall_cycles"=
,
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or more =
uops",
+        "MetricExpr": "max(0, tma_heavy_operations - tma_microcode_sequenc=
er)",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_heavy_operations_=
group;tma_issueD0",
+        "MetricName": "tma_few_uops_instructions",
+        "MetricThreshold": "tma_few_uops_instructions > 0.05 & tma_heavy_o=
perations > 0.1",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or more=
 uops. This highly-correlates with the number of uops in such instructions.=
 Related metrics: tma_decoder0_alone",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Cycles Per Instruction",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@INST_RET=
IRED.ANY@",
-        "MetricName": "tma_info_core_cpi",
+        "BriefDescription": "This metric represents overall arithmetic flo=
ating-point (FP) operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
+        "MetricGroup": "HPC;TopdownL3;Uops;tma_L3_group;tma_light_operatio=
ns_group",
+        "MetricName": "tma_fp_arith",
+        "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Floating Point Operations Per Cycle",
-        "MetricExpr": "cpu_atom@FP_FLOPS_RETIRED.ALL@ / cpu_atom@CPU_CLK_U=
NHALTED.CORE@",
+        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Floating Point (FP) Assists"=
,
+        "MetricExpr": "30 * cpu_core@ASSISTS.FP@ / tma_info_thread_slots",
+        "MetricGroup": "HPC;Slots_Estimated;TopdownL5;tma_L5_group;tma_ass=
ists_group",
+        "MetricName": "tma_fp_assists",
+        "MetricThreshold": "tma_fp_assists > 0.1",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals)",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active",
+        "MetricExpr": "cpu_core@ARITH.FPDIV_ACTIVE@ / tma_info_thread_clks=
",
+        "MetricGroup": "Clocks;TopdownL4;tma_L4_group;tma_divider_group",
+        "MetricName": "tma_fp_divider",
+        "MetricThreshold": "tma_fp_divider > 0.2 & tma_divider > 0.2 & tma=
_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
+        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ / (tma_retir=
ing * tma_info_thread_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL4;Uops;tma_L4_group;tma_fp_a=
rith_group;tma_issue2P",
+        "MetricName": "tma_fp_scalar",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma=
_port_1, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
+        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.VECTOR@ / (tma_retir=
ing * tma_info_thread_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL4;Uops;tma_L4_group;tma_fp_a=
rith_group;tma_issue2P",
+        "MetricName": "tma_fp_vector",
+        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized=
_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 128-bit wide vectors",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL5;Uops;tma_L5_group;tma_fp_v=
ector_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_128b",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric approximates arithmetic FP vector=
 uops fraction the CPU has retired for 256-bit wide vectors",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
+        "MetricGroup": "Compute;Flops;TopdownL5;Uops;tma_L5_group;tma_fp_v=
ector_group;tma_issue2P",
+        "MetricName": "tma_fp_vector_256b",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_int_vector_128b, tma_int_vector_256b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
+        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - cpu_core@IN=
T_MISC.UOP_DROPPING@ / tma_info_thread_slots",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "MetricThreshold": "tma_frontend_bound > 0.15",
+        "MetricgroupNoGroup": "TopdownL1",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions , where one uop can represent mul=
tiple contiguous instructions",
+        "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.MACRO_=
FUSED@ / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Branches;BvBO;Pipeline;Slots;TopdownL3;tma_L3_grou=
p;tma_light_operations_group",
+        "MetricName": "tma_fused_instructions",
+        "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions , where one uop can represent mu=
ltiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of l=
egacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Oth=
er_Light_Ops in MTL!)}",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricGroup": "Default;Retire;Slots;TmaL2;TopdownL2;tma_L2_group;=
tma_retiring_group",
+        "MetricName": "tma_heavy_operations",
+        "MetricThreshold": "tma_heavy_operations > 0.1",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+]). Sample with: UOPS_RET=
IRED.HEAVY",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
+        "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / tma_info_thread_clks=
",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricName": "tma_icache_misses",
+        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS, FRONTEND_RETIRED.L1I_MISS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (6 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricName": "tma_ifetch_bandwidth",
+        "MetricThreshold": "(tma_ifetch_bandwidth >0.10) & ((tma_frontend_=
bound >0.20))",
+        "MetricgroupNoGroup": "TopdownL2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (6 * =
cpu_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricName": "tma_ifetch_latency",
+        "MetricThreshold": "(tma_ifetch_latency >0.15) & ((tma_frontend_bo=
und >0.20))",
+        "MetricgroupNoGroup": "TopdownL2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect CALL instructions=
",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.INDIRECT_CALL_COST@ * cpu_=
core@br_misp_retired.indirect_call_cost@R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;Clocks_Retired;TopdownL3;tma_L3_grou=
p;tma_branch_mispredicts_group",
+        "MetricName": "tma_ind_call_mispredicts",
+        "MetricThreshold": "tma_ind_call_mispredicts > 0.05 & tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect JMP instructions"=
,
+        "MetricExpr": "max((cpu_core@BR_MISP_RETIRED.INDIRECT_COST@ * cpu_=
core@br_misp_retired.indirect_cost@R - cpu_core@BR_MISP_RETIRED.INDIRECT_CA=
LL_COST@ * cpu_core@br_misp_retired.indirect_call_cost@R) / tma_info_thread=
_clks, 0)",
+        "MetricGroup": "BrMispredicts;Clocks_Retired;TopdownL3;tma_L3_grou=
p;tma_branch_mispredicts_group",
+        "MetricName": "tma_ind_jump_mispredicts",
+        "MetricThreshold": "tma_ind_jump_mispredicts > 0.05 & tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@FP_FLOPS_RETI=
RED.ALL@",
         "MetricGroup": "Flops",
-        "MetricName": "tma_info_core_flopc",
+        "MetricName": "tma_info_arith_inst_mix_ipflop",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions Per Cycle",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@CPU_CLK_UNHAL=
TED.CORE@",
-        "MetricName": "tma_info_core_ipc",
+        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@FP_INST_RETI=
RED.128B_DP@ + cpu_atom@FP_INST_RETIRED.128B_SP@)",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_arith_inst_mix_ipfparith_avx128",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL_P@ / cpu_atom@INST_RE=
TIRED.ANY@",
-        "MetricName": "tma_info_core_upi",
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@FP_INST_RETIR=
ED.64B_DP@",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_arith_inst_mix_ipfparith_scalar_dp",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.L2_HIT@ / cp=
u_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
-        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2hit",
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@FP_INST_RETIR=
ED.32B_SP@",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_arith_inst_mix_ipfparith_scalar_sp",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.LLC_HIT@ / c=
pu_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
-        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3hit",
+        "BriefDescription": "Branch Misprediction Cost: Cycles representin=
g fraction of TMA slots wasted per non-speculative branch misprediction (re=
tired JEClear)",
+        "MetricExpr": "tma_bottleneck_mispredictions * tma_info_thread_slo=
ts / 6 / cpu_core@BR_MISP_RETIRED.ALL_BRANCHES@ / 100",
+        "MetricGroup": "Bad;BrMispredicts;Core_Metric;tma_issueBM",
+        "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
+        "PublicDescription": "Branch Misprediction Cost: Cycles representi=
ng fraction of TMA slots wasted per non-speculative branch misprediction (r=
etired JEClear). Related metrics: tma_bottleneck_mispredictions, tma_branch=
_mispredicts, tma_mispredicts_resteers",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss subsequently misses in the L3",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.LLC_MISS@ / =
cpu_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
-        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3miss",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.COND_NTAKEN@",
+        "MetricGroup": "Bad;BrMispredicts;Inst_Metric",
+        "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_LOAD.L2_HIT@ / cpu_=
atom@MEM_BOUND_STALLS_LOAD.ALL@",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2hit=
",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.COND_TAKEN@",
+        "MetricGroup": "Bad;BrMispredicts;Inst_Metric",
+        "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_HIT@ / cpu=
_atom@MEM_BOUND_STALLS_LOAD.ALL@",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3hit=
",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.INDIRECT@",
+        "MetricGroup": "Bad;BrMispredicts;Inst_Metric",
+        "MetricName": "tma_info_bad_spec_ipmisp_indirect",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses the L3",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_MISS@ / cp=
u_atom@MEM_BOUND_STALLS_LOAD.ALL@",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3mis=
s",
+        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.RET@",
+        "MetricGroup": "Bad;BrMispredicts;Inst_Metric",
+        "MetricName": "tma_info_bad_spec_ipmisp_ret",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_ret < 500",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a pipeline block",
-        "MetricExpr": "100 * cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ / cpu_atom@=
CPU_CLK_UNHALTED.CORE@",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_store_bound_l1_bound",
+        "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.ALL_BRANCHES@",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;Inst_Metric",
+        "MetricName": "tma_info_bad_spec_ipmispredict",
+        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement",
-        "MetricExpr": "100 * (cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ + cpu_atom=
@MEM_BOUND_STALLS_LOAD.ALL@) / cpu_atom@CPU_CLK_UNHALTED.CORE@",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_store_bound_load_bound",
+        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing Mispredicts and nukes)",
+        "MetricExpr": "cpu_core@INT_MISC.CLEARS_COUNT@ / (cpu_core@BR_MISP=
_RETIRED.ALL_BRANCHES@ + cpu_core@MACHINE_CLEARS.COUNT@)",
+        "MetricGroup": "BrMispredicts;Metric",
+        "MetricName": "tma_info_bad_spec_spec_clears_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Probability of Core Bound bottleneck hidden b=
y SMT-profiling artifacts",
+        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilization =
if tma_core_bound < tma_ports_utilization else 1) if tma_info_system_smt_2t=
_utilization > 0.5 else 0)",
+        "MetricGroup": "Cor;Metric;SMT",
+        "MetricName": "tma_info_botlnk_l0_core_bound_likely",
+        "MetricThreshold": "tma_info_botlnk_l0_core_bound_likely > 0.5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_dsb=
 + tma_lsd + tma_ms)))",
+        "MetricGroup": "DSB;Fed;FetchBW;Scaled_Slots;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) hits =
- subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb_s=
witches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_front=
end_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + t=
ma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite + t=
ma_dsb + tma_lsd + tma_ms))",
+        "MetricGroup": "DSBmiss;Fed;Scaled_Slots;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + =
tma_lcp + tma_dsb_switches))",
+        "MetricGroup": "Fed;FetchLat;IcMiss;Scaled_Slots;tma_issueFL",
+        "MetricName": "tma_info_botlnk_l2_ic_misses",
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
+        "MetricExpr": "100 * (cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ + cpu_ato=
m@LD_HEAD.PGWALK_AT_RET@) / cpu_atom@CPU_CLK_UNHALTED.CORE@",
+        "MetricName": "tma_info_bottleneck_%_dtlb_miss_bound_cycles",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation and retire=
ment is stalled by the Frontend Cluster due to an Ifetch Miss, either Icach=
e or ITLB Miss",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.ALL@ / cpu_a=
tom@CPU_CLK_UNHALTED.CORE@",
+        "MetricGroup": "Ifetch",
+        "MetricName": "tma_info_bottleneck_%_ifetch_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of time that retirement is stalled=
 due to an L1 miss",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_LOAD.ALL@ / cpu_ato=
m@CPU_CLK_UNHALTED.CORE@",
+        "MetricGroup": "Load_Store_Miss",
+        "MetricName": "tma_info_bottleneck_%_load_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of time that retirement is stalled=
 by the Memory Cluster due to a pipeline stall",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.ANY_AT_RET@ / cpu_atom@CPU_C=
LK_UNHALTED.CORE@",
+        "MetricGroup": "Mem_Exec",
+        "MetricName": "tma_info_bottleneck_%_mem_exec_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIR=
ED.ALL_BRANCHES@",
+        "MetricName": "tma_info_br_inst_mix_ipbranch",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIR=
ED.NEAR_CALL@",
+        "MetricName": "tma_info_br_inst_mix_ipcall",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIR=
ED.FAR_BRANCH@u",
+        "MetricName": "tma_info_br_inst_mix_ipfarbranch",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_MISP_RETI=
RED.COND@ - cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_ntaken",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was taken",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.COND_TAKEN@",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_taken",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per retired indirect call or jum=
p Branch Misprediction",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.INDIRECT@",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_indirect",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per retired return Branch Mispre=
diction",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.RETURN@",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_ret",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per retired Branch Misprediction=
",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.ALL_BRANCHES@",
+        "MetricName": "tma_info_br_inst_mix_ipmispredict",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Ratio of all branches which mispredict",
+        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom@B=
R_INST_RETIRED.ALL_BRANCHES@",
+        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_rati=
o",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
+        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom@B=
ACLEARS.ANY@",
+        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_to_u=
nknown_branch_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are CALL or RET",
+        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@BR_=
INST_RETIRED.NEAR_RETURN@) / cpu_core@BR_INST_RETIRED.ALL_BRANCHES@",
+        "MetricGroup": "Bad;Branches;Fraction",
+        "MetricName": "tma_info_branches_callret",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
+        "MetricExpr": "cpu_core@BR_INST_RETIRED.COND_NTAKEN@ / cpu_core@BR=
_INST_RETIRED.ALL_BRANCHES@",
+        "MetricGroup": "Bad;Branches;CodeGen;Fraction;PGO",
+        "MetricName": "tma_info_branches_cond_nt",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are taken condition=
als",
+        "MetricExpr": "cpu_core@BR_INST_RETIRED.COND_TAKEN@ / cpu_core@BR_=
INST_RETIRED.ALL_BRANCHES@",
+        "MetricGroup": "Bad;Branches;CodeGen;Fraction;PGO",
+        "MetricName": "tma_info_branches_cond_tk",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
+        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu_core@BR=
_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@) / cpu_=
core@BR_INST_RETIRED.ALL_BRANCHES@",
+        "MetricGroup": "Bad;Branches;Fraction",
+        "MetricName": "tma_info_branches_jump",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of branches of other types (not indi=
vidually covered by other metrics in Info.Branches group)",
+        "MetricExpr": "1 - (tma_info_branches_cond_nt + tma_info_branches_=
cond_tk + tma_info_branches_callret + tma_info_branches_jump)",
+        "MetricGroup": "Bad;Branches;Fraction",
+        "MetricName": "tma_info_branches_other_branches",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
+        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.LD_BUF@ / cpu_at=
om@CPU_CLK_UNHALTED.CORE@",
+        "MetricName": "tma_info_buffer_stalls_%_load_buffer_stall_cycles",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to memory reservation stations full",
+        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.RSV@ / cpu_atom@=
CPU_CLK_UNHALTED.CORE@",
+        "MetricName": "tma_info_buffer_stalls_%_mem_rsv_stall_cycles",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to store buffer full",
+        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_at=
om@CPU_CLK_UNHALTED.CORE@",
+        "MetricName": "tma_info_buffer_stalls_%_store_buffer_stall_cycles"=
,
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Core actual clocks when any Logical Processor=
 is active on the Physical Core",
+        "MetricExpr": "(cpu_core@CPU_CLK_UNHALTED.DISTRIBUTED@ if #SMT_on =
else tma_info_thread_clks)",
+        "MetricGroup": "Count;SMT",
+        "MetricName": "tma_info_core_core_clks",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle across hyper-threads (=
per physical core)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / tma_info_core_core_clk=
s",
+        "MetricGroup": "Core_Metric;Ret;SMT;TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_core_coreipc",
+        "MetricgroupNoGroup": "TopdownL1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@INST_RET=
IRED.ANY@",
+        "MetricName": "tma_info_core_cpi",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "uops Executed per Cycle",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / tma_info_thread_cl=
ks",
+        "MetricGroup": "Metric;Power",
+        "MetricName": "tma_info_core_epc",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu_c=
ore@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INST_=
RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) =
/ tma_info_core_core_clks",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_core_flopc",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Actual per-core usage of the Floating Point n=
on-X87 execution units (regardless of precision or vector-width)",
+        "MetricExpr": "(cpu_core@FP_ARITH_DISPATCHED.PORT_0@ + cpu_core@FP=
_ARITH_DISPATCHED.PORT_1@ + cpu_core@FP_ARITH_DISPATCHED.PORT_5@) / (2 * tm=
a_info_core_core_clks)",
+        "MetricGroup": "Cor;Core_Metric;Flops;HPC",
+        "MetricName": "tma_info_core_fp_arith_utilization",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_EXEC=
UTED.THREAD\\,cmask\\=3D0x1@",
+        "MetricGroup": "Backend;Cor;Metric;Pipeline;PortsUtil",
+        "MetricName": "tma_info_core_ilp",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@CPU_CLK_UNHAL=
TED.CORE@",
+        "MetricName": "tma_info_core_ipc",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL_P@ / cpu_atom@INST_RE=
TIRED.ANY@",
+        "MetricName": "tma_info_core_upi",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka De=
coded ICache; or Uop Cache)",
+        "MetricExpr": "cpu_core@IDQ.DSB_UOPS@ / cpu_core@UOPS_ISSUED.ANY@"=
,
+        "MetricGroup": "DSB;Fed;FetchBW;Metric;tma_issueFB",
+        "MetricName": "tma_info_frontend_dsb_coverage",
+        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 6 > 0.35",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_inst_mix_iptb, tma_lcp",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
",
+        "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / cpu_co=
re@DSB2MITE_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
+        "MetricGroup": "DSBmiss;Metric",
+        "MetricName": "tma_info_frontend_dsb_switch_cost",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired DSB misses",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.ANY_DSB_MISS@ * cpu_core@=
frontend_retired.any_dsb_miss@R / tma_info_thread_clks",
+        "MetricGroup": "Clocks_Retired;DSBmiss;Fed;FetchLat",
+        "MetricName": "tma_info_frontend_dsb_switches_ret",
+        "MetricThreshold": "tma_info_frontend_dsb_switches_ret > 0.05",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
+        "MetricExpr": "cpu_core@UOPS_ISSUED.ANY@ / cpu_core@UOPS_ISSUED.AN=
Y\\,cmask\\=3D0x1@",
+        "MetricGroup": "Fed;FetchBW;Metric",
+        "MetricName": "tma_info_frontend_fetch_upc",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
+        "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / cpu_core@ICACHE_DATA=
.STALL_PERIODS@",
+        "MetricGroup": "Fed;FetchLat;IcMiss;Metric",
+        "MetricName": "tma_info_frontend_icache_miss_latency",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FRONTEND_RETI=
RED.ANY_DSB_MISS@",
+        "MetricGroup": "DSBmiss;Fed;Inst_Metric",
+        "MetricName": "tma_info_frontend_ipdsb_miss_ret",
+        "MetricThreshold": "tma_info_frontend_ipdsb_miss_ret < 50",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / cpu_core@BACLEARS.=
ANY@",
+        "MetricGroup": "Fed;Metric",
+        "MetricName": "tma_info_frontend_ipunknown_branch",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
+        "MetricExpr": "1e3 * cpu_core@FRONTEND_RETIRED.L2_MISS@ / cpu_core=
@INST_RETIRED.ANY@",
+        "MetricGroup": "IcMiss;Metric",
+        "MetricName": "tma_info_frontend_l2mpki_code",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.CODE_RD_MISS@ / cpu_core@IN=
ST_RETIRED.ANY@",
+        "MetricGroup": "IcMiss;Metric",
+        "MetricName": "tma_info_frontend_l2mpki_code_all",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop S=
tream Detector; aka Loop Cache)",
+        "MetricExpr": "cpu_core@LSD.UOPS@ / cpu_core@UOPS_ISSUED.ANY@",
+        "MetricGroup": "Fed;LSD;Metric",
+        "MetricName": "tma_info_frontend_lsd_coverage",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired operations that invoke th=
e Microcode Sequencer",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.MS_FLOWS@ * cpu_core@fron=
tend_retired.ms_flows@R / tma_info_thread_clks",
+        "MetricGroup": "Clocks_Retired;Fed;FetchLat;MicroSeq",
+        "MetricName": "tma_info_frontend_ms_latency_ret",
+        "MetricThreshold": "tma_info_frontend_ms_latency_ret > 0.05",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ / tma_info_thr=
ead_clks",
+        "MetricGroup": "Branches;FetchBW;Metric",
+        "MetricName": "tma_info_frontend_tbpc",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average number of cycles the front-end was de=
layed due to an Unknown Branch detection",
+        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / cpu_core=
@INT_MISC.UNKNOWN_BRANCH_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
+        "MetricGroup": "Fed;Metric",
+        "MetricName": "tma_info_frontend_unknown_branch_cost",
+        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired branches who got branch a=
ddress clears",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.UNKNOWN_BRANCH@ * cpu_cor=
e@frontend_retired.unknown_branch@R / tma_info_thread_clks",
+        "MetricGroup": "Clocks_Retired;Fed;FetchLat",
+        "MetricName": "tma_info_frontend_unknown_branches_ret",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.L2_HIT@ / cp=
u_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2hit",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss doesn't hit in the L2",
+        "MetricExpr": "100 * (cpu_atom@MEM_BOUND_STALLS_IFETCH.LLC_HIT@ + =
cpu_atom@MEM_BOUND_STALLS_IFETCH.LLC_MISS@) / cpu_atom@MEM_BOUND_STALLS_IFE=
TCH.ALL@",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2miss",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.LLC_HIT@ / c=
pu_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3hit",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss subsequently misses in the L3",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_IFETCH.LLC_MISS@ / =
cpu_atom@MEM_BOUND_STALLS_IFETCH.ALL@",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3miss",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Branch instructions per taken branch",
+        "MetricExpr": "cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ / cpu_core@B=
R_INST_RETIRED.NEAR_TAKEN@",
+        "MetricGroup": "Branches;Fed;Metric;PGO",
+        "MetricName": "tma_info_inst_mix_bptkbranch",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total number of retired Instructions",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@",
+        "MetricGroup": "Count;Summary;TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_inst_mix_instructions",
+        "MetricgroupNoGroup": "TopdownL1",
+        "PublicDescription": "Total number of retired Instructions. Sample=
 with: INST_RETIRED.PREC_DIST",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.SCALAR@ + cpu_core@FP_ARITH_INST_RETIRED.VECTOR@)",
+        "MetricGroup": "Flops;InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_iparith",
+        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.128B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_=
SINGLE@)",
+        "MetricGroup": "Flops;FpVector;InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_iparith_avx128",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.256B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_=
SINGLE@)",
+        "MetricGroup": "Flops;FpVector;InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_iparith_avx256",
+        "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FP_ARITH_INST=
_RETIRED.SCALAR_DOUBLE@",
+        "MetricGroup": "Flops;FpScalar;InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FP_ARITH_INST=
_RETIRED.SCALAR_SINGLE@",
+        "MetricGroup": "Flops;FpScalar;InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
+        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.ALL_BRANCHES@",
+        "MetricGroup": "Branches;Fed;InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_ipbranch",
+        "MetricThreshold": "tma_info_inst_mix_ipbranch < 8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.NEAR_CALL@",
+        "MetricGroup": "Branches;Fed;Inst_Metric;PGO",
+        "MetricName": "tma_info_inst_mix_ipcall",
+        "MetricThreshold": "tma_info_inst_mix_ipcall < 200",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Floating Point (FP) Operatio=
n (lower number means higher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.SCALAR@ + 2 * cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ =
+ 4 * cpu_core@FP_ARITH_INST_RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_=
RETIRED.256B_PACKED_SINGLE@)",
+        "MetricGroup": "Flops;InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_ipflop",
+        "MetricThreshold": "tma_info_inst_mix_ipflop < 10",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@MEM_INST_RETI=
RED.ALL_LOADS@",
+        "MetricGroup": "InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_ipload",
+        "MetricThreshold": "tma_info_inst_mix_ipload < 3",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per PAUSE (lower number means hi=
gher occurrence rate)",
+        "MetricExpr": "tma_info_inst_mix_instructions / cpu_core@CPU_CLK_U=
NHALTED.PAUSE_INST@",
+        "MetricGroup": "Flops;FpVector;InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_ippause",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@MEM_INST_RETI=
RED.ALL_STORES@",
+        "MetricGroup": "InsType;Inst_Metric",
+        "MetricName": "tma_info_inst_mix_ipstore",
+        "MetricThreshold": "tma_info_inst_mix_ipstore < 8",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@SW_PREFETCH_A=
CCESS.ANY@",
+        "MetricGroup": "Inst_Metric;Prefetches",
+        "MetricName": "tma_info_inst_mix_ipswpf",
+        "MetricThreshold": "tma_info_inst_mix_ipswpf < 100",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per taken branch",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.NEAR_TAKEN@",
+        "MetricGroup": "Branches;Fed;FetchBW;Frontend;Inst_Metric;PGO;tma_=
issueFB",
+        "MetricName": "tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 6 * 2 + 1",
+        "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_LOAD.L2_HIT@ / cpu_=
atom@MEM_BOUND_STALLS_LOAD.ALL@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2hit=
",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses in the L2",
+        "MetricExpr": "100 * (cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_HIT@ + cp=
u_atom@MEM_BOUND_STALLS_LOAD.LLC_MISS@) / cpu_atom@MEM_BOUND_STALLS_LOAD.AL=
L@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2mis=
s",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_HIT@ / cpu=
_atom@MEM_BOUND_STALLS_LOAD.ALL@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3hit=
",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses the L3",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS_LOAD.LLC_MISS@ / cp=
u_atom@MEM_BOUND_STALLS_LOAD.ALL@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3mis=
s",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a pipeline block",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ / cpu_atom@=
CPU_CLK_UNHALTED.CORE@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_l1_bound",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement",
+        "MetricExpr": "100 * (cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ + cpu_atom=
@MEM_BOUND_STALLS_LOAD.ALL@) / cpu_atom@CPU_CLK_UNHALTED.CORE@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_load_bound",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full",
+        "MetricExpr": "100 * (cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_a=
tom@MEM_SCHEDULER_BLOCK.ALL@) * tma_mem_scheduler",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_store_bound",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to floating point assists",
+        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.FP_ASSIST@ / cpu_atom=
@INST_RETIRED.ANY@",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_fp_assi=
st_pki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to page faults",
+        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ / cpu_ato=
m@INST_RETIRED.ANY@",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_page_fa=
ult_pki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to self-modifying code",
+        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.SMC@ / cpu_atom@INST_=
RETIRED.ANY@",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_smc_pki=
",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
+        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.ADDRESS_ALIAS@ / cpu_atom@=
MEM_UOPS_RETIRED.ALL_LOADS@",
+        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_adressaliasin=
g",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
+        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / cpu_atom@M=
EM_UOPS_RETIRED.ALL_LOADS@",
+        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_storefwdblk",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.L1_MISS_AT_RET@ / cpu_atom@L=
D_HEAD.ANY_AT_RET@",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_l1miss",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to o=
ther block cases, such as pipeline conflicts, fences, etc",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.OTHER_AT_RET@ / cpu_atom@LD_=
HEAD.ANY_AT_RET@",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_otherpipeli=
neblks",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 pagewalk",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.PGWALK_AT_RET@ / cpu_atom@LD=
_HEAD.ANY_AT_RET@",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_pagewalk",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 second level TLB miss",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ / cpu_atom=
@LD_HEAD.ANY_AT_RET@",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_stlbhit",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 store forward address match",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ / cpu_atom@L=
D_HEAD.ANY_AT_RET@",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_storefwding=
",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Load",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RETI=
RED.ALL_LOADS@",
+        "MetricName": "tma_info_mem_mix_ipload",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Store",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RETI=
RED.ALL_STORES@",
+        "MetricName": "tma_info_mem_mix_ipstore",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads tha=
t perform one or more locks",
+        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.LOCK_LOADS@ / cpu_a=
tom@MEM_UOPS_RETIRED.ALL_LOADS@",
+        "MetricName": "tma_info_mem_mix_load_locks_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
+        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / cpu_=
atom@MEM_UOPS_RETIRED.ALL_LOADS@",
+        "MetricName": "tma_info_mem_mix_load_splits_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Ratio of mem load uops to all uops",
+        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / cpu_at=
om@TOPDOWN_RETIRING.ALL_P@",
+        "MetricName": "tma_info_mem_mix_memload_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
1 data cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_l1d_cache_fill_bw",
+        "MetricGroup": "Core_Metric;Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw_2t",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
2 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_l2_cache_fill_bw",
+        "MetricGroup": "Core_Metric;Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l2_cache_fill_bw_2t",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average per-core data access bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_l3_cache_access_bw",
+        "MetricGroup": "Core_Metric;Mem;MemoryBW;Offcore",
+        "MetricName": "tma_info_memory_core_l3_cache_access_bw_2t",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average per-core data fill bandwidth to the L=
3 cache [GB / sec]",
+        "MetricExpr": "tma_info_memory_l3_cache_fill_bw",
+        "MetricGroup": "Core_Metric;Mem;MemoryBW",
+        "MetricName": "tma_info_memory_core_l3_cache_fill_bw_2t",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@=
INST_RETIRED.ANY@",
+        "MetricGroup": "CacheHits;Mem;Metric",
+        "MetricName": "tma_info_memory_fb_hpki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
+        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / tma_info_sys=
tem_time",
+        "MetricGroup": "Mem;MemoryBW;Metric",
+        "MetricName": "tma_info_memory_l1d_cache_fill_bw",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / cpu_core=
@INST_RETIRED.ANY@",
+        "MetricGroup": "CacheHits;Mem;Metric",
+        "MetricName": "tma_info_memory_l1mpki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.ALL_DEMAND_DATA_RD@ / cpu_c=
ore@INST_RETIRED.ANY@",
+        "MetricGroup": "CacheHits;Mem;Metric",
+        "MetricName": "tma_info_memory_l1mpki_load",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
+        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / tma_info_sys=
tem_time",
+        "MetricGroup": "Mem;MemoryBW;Metric",
+        "MetricName": "tma_info_memory_l2_cache_fill_bw",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
+        "MetricExpr": "1e3 * (cpu_core@L2_RQSTS.REFERENCES@ - cpu_core@L2_=
RQSTS.MISS@) / cpu_core@INST_RETIRED.ANY@",
+        "MetricGroup": "CacheHits;Mem;Metric",
+        "MetricName": "tma_info_memory_l2hpki_all",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_HIT@ / cpu_c=
ore@INST_RETIRED.ANY@",
+        "MetricGroup": "CacheHits;Mem;Metric",
+        "MetricName": "tma_info_memory_l2hpki_load",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L2_MISS@ / cpu_core=
@INST_RETIRED.ANY@",
+        "MetricGroup": "Backend;CacheHits;Mem;Metric",
+        "MetricName": "tma_info_memory_l2mpki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.MISS@ / cpu_core@INST_RETIR=
ED.ANY@",
+        "MetricGroup": "CacheHits;Mem;Metric;Offcore",
+        "MetricName": "tma_info_memory_l2mpki_all",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_MISS@ / cpu_=
core@INST_RETIRED.ANY@",
+        "MetricGroup": "CacheHits;Mem;Metric",
+        "MetricName": "tma_info_memory_l2mpki_load",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Offcore requests (L2 cache miss) per kilo ins=
truction for demand RFOs",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.RFO_MISS@ / cpu_core@INST_R=
ETIRED.ANY@",
+        "MetricGroup": "CacheMisses;Metric;Offcore",
+        "MetricName": "tma_info_memory_l2mpki_rfo",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
+        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ tma_info_system_time",
+        "MetricGroup": "Mem;MemoryBW;Metric;Offcore",
+        "MetricName": "tma_info_memory_l3_cache_access_bw",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
+        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / tma_i=
nfo_system_time",
+        "MetricGroup": "Mem;MemoryBW;Metric",
+        "MetricName": "tma_info_memory_l3_cache_fill_bw",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L3_MISS@ / cpu_core=
@INST_RETIRED.ANY@",
+        "MetricGroup": "Mem;Metric",
+        "MetricName": "tma_info_memory_l3mpki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average Parallel L2 cache miss data reads",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DATA_RD@ / cp=
u_core@OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@",
+        "MetricGroup": "Memory_BW;Metric;Offcore",
+        "MetricName": "tma_info_memory_latency_data_l2_mlp",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS.DEMAND_DATA_RD@",
+        "MetricGroup": "Clocks_Latency;LockCont;Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_latency_load_l2_miss_latency",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average Parallel L2 cache miss demand Loads",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@"=
,
+        "MetricGroup": "Memory_BW;Metric;Offcore",
+        "MetricName": "tma_info_memory_latency_load_l2_mlp",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAN=
D_DATA_RD@ / cpu_core@OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD@",
+        "MetricGroup": "Clocks_Latency;Memory_Lat;Offcore",
+        "MetricName": "tma_info_memory_latency_load_l3_miss_latency",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
+        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / cpu_core@MEM_LOAD=
_COMPLETED.L1_MISS_ANY@",
+        "MetricGroup": "Clocks_Latency;Mem;MemoryBound;MemoryLat",
+        "MetricName": "tma_info_memory_load_miss_real_latency",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "\"Bus lock\" per kilo instruction",
+        "MetricExpr": "1e3 * cpu_core@SQ_MISC.BUS_LOCK@ / cpu_core@INST_RE=
TIRED.ANY@",
+        "MetricGroup": "Mem;Metric",
+        "MetricName": "tma_info_memory_mix_bus_lock_pki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_MISC_RETIRED.UC@ / cpu_core=
@INST_RETIRED.ANY@",
+        "MetricGroup": "Mem;Metric",
+        "MetricName": "tma_info_memory_mix_uc_load_pki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
+        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / cpu_core@L1D_PEND=
_MISS.PENDING_CYCLES@",
+        "MetricGroup": "Mem;MemoryBW;MemoryBound;Metric",
+        "MetricName": "tma_info_memory_mlp",
+        "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Rate of L2 HW prefetched lines that were not =
used by demand accesses",
+        "MetricExpr": "cpu_core@L2_LINES_OUT.USELESS_HWPF@ / (cpu_core@L2_=
LINES_OUT.SILENT@ + cpu_core@L2_LINES_OUT.NON_SILENT@)",
+        "MetricGroup": "Metric;Prefetches",
+        "MetricName": "tma_info_memory_prefetches_useless_hwpf",
+        "MetricThreshold": "tma_info_memory_prefetches_useless_hwpf > 0.15=
",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
+        "MetricExpr": "1e3 * cpu_core@ITLB_MISSES.WALK_COMPLETED@ / cpu_co=
re@INST_RETIRED.ANY@",
+        "MetricGroup": "Fed;MemoryTLB;Metric",
+        "MetricName": "tma_info_memory_tlb_code_stlb_mpki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to STLB misses by demand loads",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_MISS_LOADS@ * cpu_co=
re@mem_inst_retired.stlb_miss_loads@R / tma_info_thread_clks",
+        "MetricGroup": "Clocks_Retired;Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_load_stlb_miss_ret",
+        "MetricThreshold": "tma_info_memory_tlb_load_stlb_miss_ret > 0.05"=
,
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
+        "MetricExpr": "1e3 * cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED@ / c=
pu_core@INST_RETIRED.ANY@",
+        "MetricGroup": "Mem;MemoryTLB;Metric",
+        "MetricName": "tma_info_memory_tlb_load_stlb_mpki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Utilization of the core's Page Walker(s) serv=
ing STLB misses triggered by instruction/Load/Store accesses",
+        "MetricExpr": "(cpu_core@ITLB_MISSES.WALK_PENDING@ + cpu_core@DTLB=
_LOAD_MISSES.WALK_PENDING@ + cpu_core@DTLB_STORE_MISSES.WALK_PENDING@) / (4=
 * tma_info_core_core_clks)",
+        "MetricGroup": "Core_Metric;Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_page_walks_utilization",
+        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to STLB misses by demand stores",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_MISS_STORES@ * cpu_c=
ore@mem_inst_retired.stlb_miss_stores@R / tma_info_thread_clks",
+        "MetricGroup": "Clocks_Retired;Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_store_stlb_miss_ret",
+        "MetricThreshold": "tma_info_memory_tlb_store_stlb_miss_ret > 0.05=
",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
+        "MetricExpr": "1e3 * cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED@ / =
cpu_core@INST_RETIRED.ANY@",
+        "MetricGroup": "Mem;MemoryTLB;Metric",
+        "MetricName": "tma_info_memory_tlb_store_stlb_mpki",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D0x1@)",
+        "MetricGroup": "Cor;Metric;Pipeline;PortsUtil;SMT",
+        "MetricName": "tma_info_pipeline_execute",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average number of uops fetched from DSB per c=
ycle",
+        "MetricExpr": "cpu_core@IDQ.DSB_UOPS@ / cpu_core@IDQ.DSB_CYCLES_AN=
Y@",
+        "MetricGroup": "Fed;FetchBW;Metric",
+        "MetricName": "tma_info_pipeline_fetch_dsb",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average number of uops fetched from LSD per c=
ycle",
+        "MetricExpr": "cpu_core@LSD.UOPS@ / cpu_core@LSD.CYCLES_ACTIVE@",
+        "MetricGroup": "Fed;FetchBW;Metric",
+        "MetricName": "tma_info_pipeline_fetch_lsd",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average number of uops fetched from MITE per =
cycle",
+        "MetricExpr": "cpu_core@IDQ.MITE_UOPS@ / cpu_core@IDQ.MITE_CYCLES_=
ANY@",
+        "MetricGroup": "Fed;FetchBW;Metric",
+        "MetricName": "tma_info_pipeline_fetch_mite",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@ASSISTS.ANY@"=
,
+        "MetricGroup": "Inst_Metric;MicroSeq;Pipeline;Ret;Retire",
+        "MetricName": "tma_info_pipeline_ipassist",
+        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
+        "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D0x1@",
+        "MetricGroup": "Metric;Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_retire",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
+        "MetricExpr": "cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D0x1@",
+        "MetricGroup": "Metric;MicroSeq;Pipeline;Ret",
+        "MetricName": "tma_info_pipeline_strings_cycles",
+        "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
+        "MetricExpr": "100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (6 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricName": "tma_info_serialization _%_tpause_cycles",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of cycles the processor is waiting y=
et unhalted; covering legacy PAUSE instruction, as well as C0.1 / C0.2 powe=
r-performance optimized states",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C0_WAIT@ / tma_info_threa=
d_clks",
+        "MetricGroup": "C0Wait;Metric",
+        "MetricName": "tma_info_system_c0_wait",
+        "MetricThreshold": "tma_info_system_c0_wait > 0.05",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
+        "MetricGroup": "Power;Summary;System_Metric",
+        "MetricName": "tma_info_system_core_frequency",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average CPU Utilization (percentage)",
+        "MetricExpr": "tma_info_system_cpus_utilized / #num_cpus_online",
+        "MetricGroup": "HPC;Metric;Summary",
+        "MetricName": "tma_info_system_cpu_utilization",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average number of utilized CPUs",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
+        "MetricGroup": "Metric;Summary",
+        "MetricName": "tma_info_system_cpus_utilized",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu_c=
ore@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INST_=
RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) =
/ 1e9 / tma_info_system_time",
+        "MetricGroup": "Flops",
+        "MetricName": "tma_info_system_gflops",
+        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_INST_RETIRED.FAR_BR=
ANCH:u",
+        "MetricGroup": "Branches;Inst_Metric;OS",
+        "MetricName": "tma_info_system_ipfarbranch",
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
+        "MetricGroup": "Metric;OS",
+        "MetricName": "tma_info_system_kernel_cpi",
+        "ScaleUnit": "1per_instr",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / cpu_core@CPU_CLK_UNHA=
LTED.THREAD@",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_kernel_utilization",
+        "MetricThreshold": "tma_info_system_kernel_utilization > 0.05",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average number of parallel data read requests=
 to external memory",
+        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANCY.RD=
@thresh\\=3D0x1@",
+        "MetricGroup": "Mem;MemoryBW;SoC;System_Metric",
+        "MetricName": "tma_info_system_mem_parallel_reads",
+        "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@ / cpu_core@CPU_=
CLK_UNHALTED.THREAD@",
+        "MetricGroup": "Clocks;Summary",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total package Power in Watts",
+        "MetricExpr": "power@energy\\-pkg@ * 61 / (tma_info_system_time * =
1e6)",
+        "MetricGroup": "Power;SoC;System_Metric",
+        "MetricName": "tma_info_system_power",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
+        "MetricExpr": "(1 - cpu_core@CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE@ /=
 cpu_core@CPU_CLK_UNHALTED.REF_DISTRIBUTED@ if #SMT_on else 0)",
+        "MetricGroup": "Core_Metric;SMT",
+        "MetricName": "tma_info_system_smt_2t_utilization",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
+        "MetricExpr": "UNC_CLOCK.SOCKET",
+        "MetricGroup": "Count;SoC",
+        "MetricName": "tma_info_system_socket_clks",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Run duration time in seconds",
+        "MetricExpr": "duration_time",
+        "MetricGroup": "Seconds;Summary",
+        "MetricName": "tma_info_system_time",
+        "MetricThreshold": "tma_info_system_time < 1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "tma_info_thread_clks / cpu_core@CPU_CLK_UNHALTED.RE=
F_TSC@",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_system_turbo_utilization",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD@",
+        "MetricGroup": "Count;Pipeline",
+        "MetricName": "tma_info_thread_clks",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
+        "MetricExpr": "1 / tma_info_thread_ipc",
+        "MetricGroup": "Mem;Metric;Pipeline",
+        "MetricName": "tma_info_thread_cpi",
+        "ScaleUnit": "1per_instr",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "The ratio of Executed- by Issued-Uops",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_ISSU=
ED.ANY@",
+        "MetricGroup": "Cor;Metric;Pipeline",
+        "MetricName": "tma_info_thread_execute_per_issue",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / tma_info_thread_clks",
+        "MetricGroup": "Metric;Ret;Summary",
+        "MetricName": "tma_info_thread_ipc",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
+        "MetricExpr": "slots",
+        "MetricGroup": "Count;TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots",
+        "MetricgroupNoGroup": "TopdownL1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
+        "MetricExpr": "(tma_info_thread_slots / (slots / 2) if #SMT_on els=
e 1)",
+        "MetricGroup": "Metric;SMT;TmaL1;TopdownL1;tma_L1_group",
+        "MetricName": "tma_info_thread_slots_utilization",
+        "MetricgroupNoGroup": "TopdownL1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@INS=
T_RETIRED.ANY@",
+        "MetricGroup": "Metric;Pipeline;Ret;Retire",
+        "MetricName": "tma_info_thread_uoppi",
+        "MetricThreshold": "tma_info_thread_uoppi > 1.05",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Uops per taken branch",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@BR_=
INST_RETIRED.NEAR_TAKEN@",
+        "MetricGroup": "Branches;Fed;FetchBW;Metric",
+        "MetricName": "tma_info_thread_uptb",
+        "MetricThreshold": "tma_info_thread_uptb < 6 * 1.5",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are FPDiv uops",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ / cpu_atom@TOPDO=
WN_RETIRING.ALL_P@",
+        "MetricName": "tma_info_uop_mix_fpdiv_uop_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are IDiv uops",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ / cpu_atom@TOPDOW=
N_RETIRING.ALL_P@",
+        "MetricName": "tma_info_uop_mix_idiv_uop_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are microcode op=
s",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ / cpu_atom@TOPDOWN_=
RETIRING.ALL_P@",
+        "MetricName": "tma_info_uop_mix_microcode_uop_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Percentage of all uops which are x87 uops",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ / cpu_atom@TOPDOWN=
_RETIRING.ALL_P@",
+        "MetricName": "tma_info_uop_mix_x87_uop_ratio",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active",
+        "MetricExpr": "tma_divider - tma_fp_divider",
+        "MetricGroup": "Clocks;TopdownL4;tma_L4_group;tma_divider_group",
+        "MetricName": "tma_int_divider",
+        "MetricThreshold": "tma_int_divider > 0.2 & tma_divider > 0.2 & tm=
a_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents overall Integer (Int) =
select operations fraction the CPU has executed (retired)",
+        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b",
+        "MetricGroup": "Pipeline;TopdownL3;Uops;tma_L3_group;tma_light_ope=
rations_group",
+        "MetricName": "tma_int_operations",
+        "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operation=
s > 0.6",
+        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents 128-bit vector Integer=
 ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction the=
 CPU has retired",
+        "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_128@ + cpu_core@INT_V=
EC_RETIRED.VNNI_128@) / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;Uops;tma_L4_g=
roup;tma_int_operations_group;tma_issue2P",
+        "MetricName": "tma_int_vector_128b",
+        "MetricThreshold": "tma_int_vector_128b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_int_vector_256b, tma_port_0, tma_port_1,=
 tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents 256-bit vector Integer=
 ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fraction=
 the CPU has retired",
+        "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_256@ + cpu_core@INT_V=
EC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@) / (tma_retiring *=
 tma_info_thread_slots)",
+        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;Uops;tma_L4_g=
roup;tma_int_operations_group;tma_issue2P",
+        "MetricName": "tma_int_vector_256b",
+        "MetricThreshold": "tma_int_vector_256b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_port_0, tma_por=
t_1, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
+        "MetricExpr": "cpu_core@ICACHE_TAG.STALLS@ / tma_info_thread_clks"=
,
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricName": "tma_itlb_misses",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS, FRONTEND_RETIRED.ITLB_MISS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 Data (L1D) cache",
+        "MetricExpr": "max((cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L1D_MISS@) / tma_info_thread_clks, 0)",
+        "MetricGroup": "CacheHits;MemoryBound;Stalls;TmaL3mem;TopdownL3;tm=
a_L3_group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
+        "MetricName": "tma_l1_bound",
+        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & =
tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics: t=
ma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_swi=
tches, tma_ports_utilized_1",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
+        "MetricExpr": "min(2 * (cpu_core@MEM_INST_RETIRED.ALL_LOADS@ - cpu=
_core@MEM_LOAD_RETIRED.FB_HIT@ - cpu_core@MEM_LOAD_RETIRED.L1_MISS@) * 20 /=
 100, max(cpu_core@CYCLE_ACTIVITY.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVIT=
Y.CYCLES_L1D_MISS@, 0)) / tma_info_thread_clks",
+        "MetricGroup": "BvML;Clocks_Estimated;MemoryLat;TopdownL4;tma_L4_g=
roup;tma_l1_bound_group",
+        "MetricName": "tma_l1_latency_dependency",
+        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & tma_l1_bound=
 > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache. The s=
hort latency of the L1D cache may be exposed in pointer-chasing memory acce=
ss patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
+        "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L1D_MISS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L2_MISS@) / tma_info_thread_clks",
+        "MetricGroup": "BvML;CacheHits;MemoryBound;Stalls;TmaL3mem;Topdown=
L3;tma_L3_group;tma_memory_bound_group",
+        "MetricName": "tma_l2_bound",
+        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
+        "MetricExpr": "(min(cpu_core@MEM_LOAD_RETIRED.L2_HIT@ * cpu_core@m=
em_load_retired.l2_hit@R, cpu_core@MEM_LOAD_RETIRED.L2_HIT@ * (3 * tma_info=
_system_core_frequency)) if 0 < cpu_core@mem_load_retired.l2_hit@R else cpu=
_core@MEM_LOAD_RETIRED.L2_HIT@ * (3 * tma_info_system_core_frequency)) * (1=
 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ /=
 2) / tma_info_thread_clks",
+        "MetricGroup": "Clocks_Retired;MemoryLat;TopdownL4;tma_L4_group;tm=
a_l2_bound_group",
+        "MetricName": "tma_l2_hit_latency",
+        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L2 cache under unloaded scenarios (pos=
sibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 hit=
s) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled due to loads accesses to L3 cache or contended with a sibling Core",
+        "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L2_MISS@ - cpu_cor=
e@MEMORY_ACTIVITY.STALLS_L3_MISS@) / tma_info_thread_clks",
+        "MetricGroup": "CacheHits;MemoryBound;Stalls;TmaL3mem;TopdownL3;tm=
a_L3_group;tma_memory_bound_group",
+        "MetricName": "tma_l3_bound",
+        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
+        "MetricExpr": "(min(cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * cpu_core@m=
em_load_retired.l3_hit@R, cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * (12 * tma_inf=
o_system_core_frequency) - 3 * tma_info_system_core_frequency) if 0 < cpu_c=
ore@mem_load_retired.l3_hit@R else cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * (12 =
* tma_info_system_core_frequency) - 3 * tma_info_system_core_frequency) * (=
1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ =
/ 2) / tma_info_thread_clks",
+        "MetricGroup": "BvML;Clocks_Estimated;MemoryLat;TopdownL4;tma_L4_g=
roup;tma_issueLat;tma_l3_bound_group;tma_overlap",
+        "MetricName": "tma_l3_hit_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.05=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT. Related metrics: tma_b=
ottleneck_cache_memory_latency, tma_branch_resteers, tma_mem_latency, tma_s=
tore_latency",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 was stalled due to Length Changing Prefixes (LCPs)",
+        "MetricExpr": "cpu_core@DECODE.LCP@ / tma_info_thread_clks",
+        "MetricGroup": "Clocks;FetchLat;TopdownL3;tma_L3_group;tma_fetch_l=
atency_group;tma_issueFB",
+        "MetricName": "tma_lcp",
+        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & tma=
_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. Related metr=
ics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidt=
h, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_info_=
inst_mix_iptb",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations , instructions that require =
no more than one uop (micro-operation)",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
+        "MetricGroup": "Default;Retire;Slots;TmaL2;TopdownL2;tma_L2_group;=
tma_retiring_group",
+        "MetricName": "tma_light_operations",
+        "MetricThreshold": "tma_light_operations > 0.6",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations , instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UopPI metr=
ic) ratio of 1 or less should be expected for decently optimized code runni=
ng on Intel Core/Xeon products. While this often indicates efficient X86 in=
structions were executed; high value does not necessarily mean better perfo=
rmance cannot be achieved. ([ICL+] Note this may undercount due to approxim=
ation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIST=
",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Load operations",
+        "MetricExpr": "cpu_core@UOPS_DISPATCHED.PORT_2_3_10@ / (3 * tma_in=
fo_core_core_clks)",
+        "MetricGroup": "Core_Execution;TopdownL5;tma_L5_group;tma_ports_ut=
ilized_3m_group",
+        "MetricName": "tma_load_op_utilization",
+        "MetricThreshold": "tma_load_op_utilization > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port for Load operations. Sample with: =
UOPS_DISPATCHED.PORT_2_3_10",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) DTLB was missed by load accesses, that late=
r on hit in second-level TLB (STLB)",
+        "MetricExpr": "max(0, tma_dtlb_load - tma_load_stlb_miss)",
+        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL5;tma_L5_group;=
tma_dtlb_load_group",
+        "MetricName": "tma_load_stlb_hit",
+        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0.1=
 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by load accesses, performing a=
 hardware page walk",
+        "MetricExpr": "cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@ / tma_info_t=
hread_clks",
+        "MetricGroup": "Clocks_Calculated;MemoryTLB;TopdownL5;tma_L5_group=
;tma_dtlb_load_group",
+        "MetricName": "tma_load_stlb_miss",
+        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > 0.=
1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_1G@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_core@D=
TLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_COMP=
LETED_1G@)",
+        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_group;=
tma_load_stlb_miss_group",
+        "MetricName": "tma_load_stlb_miss_1g",
+        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_2M_4M@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_C=
OMPLETED_1G@)",
+        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_group;=
tma_load_stlb_miss_group",
+        "MetricName": "tma_load_stlb_miss_2m",
+        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_4K@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_core@D=
TLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_COMP=
LETED_1G@)",
+        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_group;=
tma_load_stlb_miss_group",
+        "MetricName": "tma_load_stlb_miss_4k",
+        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ * cpu_core@me=
m_inst_retired.lock_loads@R / tma_info_thread_clks",
+        "MetricGroup": "Clocks;LockCont;Offcore;TopdownL4;tma_L4_group;tma=
_issueRFO;tma_l1_bound_group",
+        "MetricName": "tma_lock_latency",
+        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 & =
tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to LSD (Loop Stream Detector) unit",
+        "MetricExpr": "(cpu_core@LSD.CYCLES_ACTIVE@ - cpu_core@LSD.CYCLES_=
OK@) / tma_info_core_core_clks / 2",
+        "MetricGroup": "FetchBW;LSD;Slots_Estimated;TopdownL3;tma_L3_group=
;tma_fetch_bandwidth_group",
+        "MetricName": "tma_lsd",
+        "MetricThreshold": "tma_lsd > 0.15 & tma_fetch_bandwidth > 0.2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
+        "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredicts=
)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricName": "tma_machine_clears",
+        "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
+        "MetricgroupNoGroup": "TopdownL2",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_bottleneck_memory_synchronization, tma_clears_resteers, tma_contested_a=
ccesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_s=
equencer, tma_ms_switches",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
+        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks"=
,
+        "MetricGroup": "BvMB;Clocks;MemoryBW;Offcore;TopdownL4;tma_L4_grou=
p;tma_dram_bound_group;tma_issueBW",
+        "MetricName": "tma_mem_bandwidth",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_sq_full",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory - DRA=
M ([SPR-HBM] and/or HBM)",
+        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_thread_clks - tm=
a_mem_bandwidth",
+        "MetricGroup": "BvML;Clocks;MemoryLat;Offcore;TopdownL4;tma_L4_gro=
up;tma_dram_bound_group;tma_issueLat",
+        "MetricName": "tma_mem_latency",
+        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_latency=
",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to memory reservation stalls in which a sched=
uler is not able to accept uops",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ / (6 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_mem_scheduler",
+        "MetricThreshold": "(tma_mem_scheduler >0.10) & ((tma_resource_bou=
nd >0.20) & ((tma_backend_bound >0.10)))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
+        "DefaultMetricgroupName": "TopdownL2",
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricGroup": "Backend;Default;Slots;TmaL2;TopdownL2;tma_L2_group=
;tma_backend_bound_group",
+        "MetricName": "tma_memory_bound",
+        "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
+        "MetricgroupNoGroup": "TopdownL2;Default",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "13 * cpu_core@MISC2_RETIRED.LFENCE@ / tma_info_thre=
ad_clks",
+        "MetricGroup": "Clocks;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
+        "MetricName": "tma_memory_fence",
+        "MetricThreshold": "tma_memory_fence > 0.05 & tma_serializing_oper=
ation > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations , uops for memory load or store ac=
cesses",
+        "MetricExpr": "tma_light_operations * cpu_core@MEM_UOP_RETIRED.ANY=
@ / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "Pipeline;Slots;TopdownL3;tma_L3_group;tma_light_op=
erations_group",
+        "MetricName": "tma_memory_operations",
+        "MetricThreshold": "tma_memory_operations > 0.1 & tma_light_operat=
ions > 0.6",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots the =
CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
+        "MetricExpr": "cpu_core@UOPS_RETIRED.MS@ / tma_info_thread_slots",
+        "MetricGroup": "MicroSeq;Slots;TopdownL3;tma_L3_group;tma_heavy_op=
erations_group;tma_issueMC;tma_issueMS",
+        "MetricName": "tma_microcode_sequencer",
+        "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_bottleneck_i=
rregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clears, t=
ma_ms_switches",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
+        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * cpu_=
core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
+        "MetricGroup": "BadSpec;BrMispredicts;BvMP;Clocks;TopdownL4;tma_L4=
_group;tma_branch_resteers_group;tma_issueBM",
+        "MetricName": "tma_mispredicts_resteers",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch_r=
esteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_bottleneck_mispredictions, tma_branch_mispredicts, tma_info_bad=
_spec_branch_misprediction_cost",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the MITE pipeline (the legacy deco=
de pipeline)",
+        "MetricExpr": "(cpu_core@IDQ.MITE_CYCLES_ANY@ - cpu_core@IDQ.MITE_=
CYCLES_OK@) / tma_info_core_core_clks / 2",
+        "MetricGroup": "DSBmiss;FetchBW;Slots_Estimated;TopdownL3;tma_L3_g=
roup;tma_fetch_bandwidth_group",
+        "MetricName": "tma_mite",
+        "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to the MITE pipeline (the legacy dec=
ode pipeline). This pipeline is used for code that was not pre-cached in th=
e DSB or LSD. For example; inefficiencies due to asymmetric decoders; use o=
f long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. Sa=
mple with: FRONTEND_RETIRED.ANY_DSB_MISS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued , the Count Do=
main; [ADL+] cycles)",
+        "MetricExpr": "160 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_thre=
ad_clks",
+        "MetricGroup": "Clocks;TopdownL5;tma_L5_group;tma_issueMV;tma_port=
s_utilized_0_group",
+        "MetricName": "tma_mixing_vectors",
+        "MetricThreshold": "tma_mixing_vectors > 0.05",
+        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued , the Count D=
omain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investigat=
ing. Read more in Appendix B1 of the Optimizations Guide for this topic. Re=
lated metrics: tma_ms_switches",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details",
+        "MetricExpr": "max(cpu_core@IDQ.MS_CYCLES_ANY@, cpu_core@UOPS_RETI=
RED.MS\\,cmask\\=3D0x1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISS=
UED.ANY@)) / tma_info_core_core_clks / 2",
+        "MetricGroup": "MicroSeq;Slots_Estimated;TopdownL3;tma_L3_group;tm=
a_fetch_bandwidth_group",
+        "MetricName": "tma_ms",
+        "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
+        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge=
\\=3D0x1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUED.ANY@) / tm=
a_info_thread_clks",
+        "MetricGroup": "Clocks_Estimated;FetchLat;MicroSeq;TopdownL3;tma_L=
3_group;tma_fetch_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_iss=
ueSO",
+        "MetricName": "tma_ms_switches",
+        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_bottleneck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_mac=
hine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_o=
peration",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
+        "MetricExpr": "tma_light_operations * (cpu_core@BR_INST_RETIRED.AL=
L_BRANCHES@ - cpu_core@INST_RETIRED.MACRO_FUSED@) / (tma_retiring * tma_inf=
o_thread_slots)",
+        "MetricGroup": "Branches;BvBO;Pipeline;Slots;TopdownL3;tma_L3_grou=
p;tma_light_operations_group",
+        "MetricName": "tma_non_fused_branches",
+        "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to IEC or FPC RAT stalls, which can be due to=
 FIQ or IEC reservation stalls in which the integer, floating point or SIMD=
 scheduler is not able to accept uops",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER@ / (6 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_non_mem_scheduler",
+        "MetricThreshold": "(tma_non_mem_scheduler >0.10) & ((tma_resource=
_bound >0.20) & ((tma_backend_bound >0.10)))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
+        "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.NOP@ /=
 (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "BvBO;Pipeline;Slots;TopdownL4;tma_L4_group;tma_oth=
er_light_ops_group",
+        "MetricName": "tma_nop_instructions",
+        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_other_light_o=
ps > 0.3 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that requires the use of m=
icrocode (slow nuke)",
+        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.NUKE@ / (6 * cpu_a=
tom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_nuke",
+        "MetricThreshold": "(tma_nuke >0.05) & ((tma_machine_clears >0.05)=
 & ((tma_bad_speculation >0.15)))",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.OTHER@ / (6 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricName": "tma_other_fb",
+        "MetricThreshold": "(tma_other_fb >0.05) & ((tma_ifetch_bandwidth =
>0.10) & ((tma_frontend_bound >0.20)))",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full",
-        "MetricExpr": "100 * (cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_a=
tom@MEM_SCHEDULER_BLOCK.ALL@) * tma_mem_scheduler",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_store_bound_store_bound",
+        "BriefDescription": "This metric represents the remaining light uo=
ps fraction the CPU has executed - remaining means not covered by other sib=
ling nodes",
+        "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma_i=
nt_operations + tma_memory_operations + tma_fused_instructions + tma_non_fu=
sed_branches))",
+        "MetricGroup": "Pipeline;Slots;TopdownL3;tma_L3_group;tma_light_op=
erations_group",
+        "MetricName": "tma_other_light_ops",
+        "MetricThreshold": "tma_other_light_ops > 0.3 & tma_light_operatio=
ns > 0.6",
+        "PublicDescription": "This metric represents the remaining light u=
ops fraction the CPU has executed - remaining means not covered by other si=
bling nodes. May undercount due to FMA double counting",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to floating point assists",
-        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.FP_ASSIST@ / cpu_atom=
@INST_RETIRED.ANY@",
-        "MetricName": "tma_info_machine_clear_bound_machine_clears_fp_assi=
st_pki",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types)",
+        "MetricExpr": "max(tma_branch_mispredicts * (1 - cpu_core@BR_MISP_=
RETIRED.ALL_BRANCHES@ / (cpu_core@INT_MISC.CLEARS_COUNT@ - cpu_core@MACHINE=
_CLEARS.COUNT@)), 0.0001)",
+        "MetricGroup": "BrMispredicts;BvIO;Slots;TopdownL3;tma_L3_group;tm=
a_branch_mispredicts_group",
+        "MetricName": "tma_other_mispredicts",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_misp=
redicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to page faults",
-        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ / cpu_ato=
m@INST_RETIRED.ANY@",
-        "MetricName": "tma_info_machine_clear_bound_machine_clears_page_fa=
ult_pki",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
+        "MetricExpr": "max(tma_machine_clears * (1 - cpu_core@MACHINE_CLEA=
RS.MEMORY_ORDERING@ / cpu_core@MACHINE_CLEARS.COUNT@), 0.0001)",
+        "MetricGroup": "BvIO;Machine_Clears;Slots;TopdownL3;tma_L3_group;t=
ma_machine_clears_group",
+        "MetricName": "tma_other_nukes",
+        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears > =
0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to self-modifying code",
-        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.SMC@ / cpu_atom@INST_=
RETIRED.ANY@",
-        "MetricName": "tma_info_machine_clear_bound_machine_clears_smc_pki=
",
+        "BriefDescription": "This metric roughly estimates fraction of slo=
ts the CPU retired uops as a result of handing Page Faults",
+        "MetricExpr": "99 * cpu_core@ASSISTS.PAGE_FAULT@ / tma_info_thread=
_slots",
+        "MetricGroup": "Slots_Estimated;TopdownL5;tma_L5_group;tma_assists=
_group",
+        "MetricName": "tma_page_faults",
+        "MetricThreshold": "tma_page_faults > 0.05",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
-        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.ADDRESS_ALIAS@ / cpu_atom@=
MEM_UOPS_RETIRED.ALL_LOADS@",
-        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_adressaliasin=
g",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd b=
ranch)",
+        "MetricExpr": "cpu_core@UOPS_DISPATCHED.PORT_0@ / tma_info_core_co=
re_clks",
+        "MetricGroup": "Compute;Core_Clocks;TopdownL6;tma_L6_group;tma_alu=
_op_utilization_group;tma_issue2P",
+        "MetricName": "tma_port_0",
+        "MetricThreshold": "tma_port_0 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_12=
8b, tma_int_vector_256b, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / cpu_atom@M=
EM_UOPS_RETIRED.ALL_LOADS@",
-        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_storefwdblk",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 1 (ALU)",
+        "MetricExpr": "cpu_core@UOPS_DISPATCHED.PORT_1@ / tma_info_core_co=
re_clks",
+        "MetricGroup": "Core_Clocks;TopdownL6;tma_L6_group;tma_alu_op_util=
ization_group;tma_issue2P",
+        "MetricName": "tma_port_1",
+        "MetricThreshold": "tma_port_1 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_port_=
0, tma_port_6, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
-        "MetricExpr": "100 * cpu_atom@LD_HEAD.L1_MISS_AT_RET@ / cpu_atom@L=
D_HEAD.ANY_AT_RET@",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_l1miss",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simple=
 ALU)",
+        "MetricExpr": "cpu_core@UOPS_DISPATCHED.PORT_6@ / tma_info_core_co=
re_clks",
+        "MetricGroup": "Core_Clocks;TopdownL6;tma_L6_group;tma_alu_op_util=
ization_group;tma_issue2P",
+        "MetricName": "tma_port_6",
+        "MetricThreshold": "tma_port_6 > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128=
b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_ports_utilized_2",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of Memory Execution Bound due to o=
ther block cases, such as pipeline conflicts, fences, etc",
-        "MetricExpr": "100 * cpu_atom@LD_HEAD.OTHER_AT_RET@ / cpu_atom@LD_=
HEAD.ANY_AT_RET@",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_otherpipeli=
neblks",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
+        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (cp=
u_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_=
3_PORTS_UTIL@)) / tma_info_thread_clks if cpu_core@ARITH.DIV_ACTIVE@ < cpu_=
core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ e=
lse (cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTI=
VITY.2_3_PORTS_UTIL@) / tma_info_thread_clks)",
+        "MetricGroup": "Clocks;PortsUtil;TopdownL3;tma_L3_group;tma_core_b=
ound_group",
+        "MetricName": "tma_ports_utilization",
+        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_bound =
> 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 pagewalk",
-        "MetricExpr": "100 * cpu_atom@LD_HEAD.PGWALK_AT_RET@ / cpu_atom@LD=
_HEAD.ANY_AT_RET@",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_pagewalk",
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
+        "MetricExpr": "max(cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ - cpu_=
core@RESOURCE_STALLS.SCOREBOARD@, 0) / tma_info_thread_clks",
+        "MetricGroup": "Clocks;PortsUtil;TopdownL4;tma_L4_group;tma_ports_=
utilization_group",
+        "MetricName": "tma_ports_utilized_0",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 second level TLB miss",
-        "MetricExpr": "100 * cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ / cpu_atom=
@LD_HEAD.ANY_AT_RET@",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_stlbhit",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the CPU executed total of 1 uop per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricExpr": "cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ / tma_info_thre=
ad_clks",
+        "MetricGroup": "Clocks;PortsUtil;TopdownL4;tma_L4_group;tma_issueL=
1;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_1",
+        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL. Related m=
etrics: tma_l1_bound",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 store forward address match",
-        "MetricExpr": "100 * cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ / cpu_atom@L=
D_HEAD.ANY_AT_RET@",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_storefwding=
",
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 2 uops per cycle on all execution ports (Logical Process=
or cycles since ICL, Physical Core cycles otherwise)",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "cpu_core@EXE_ACTIVITY.2_PORTS_UTIL@ / tma_info_thre=
ad_clks",
+        "MetricGroup": "Clocks;PortsUtil;TopdownL4;tma_L4_group;tma_issue2=
P;tma_ports_utilization_group",
+        "MetricName": "tma_ports_utilized_2",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma=
_int_vector_256b, tma_port_0, tma_port_1, tma_port_6",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Load",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RETI=
RED.ALL_LOADS@",
-        "MetricName": "tma_info_mem_mix_ipload",
+        "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.CYCLES_GE_3@ / tma_info_thre=
ad_clks",
+        "MetricGroup": "BvCB;Clocks;PortsUtil;TopdownL4;tma_L4_group;tma_p=
orts_utilization_group",
+        "MetricName": "tma_ports_utilized_3m",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Store",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RETI=
RED.ALL_STORES@",
-        "MetricName": "tma_info_mem_mix_ipstore",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.PREDECODE@ / (6 * cpu_ato=
m@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricName": "tma_predecode",
+        "MetricThreshold": "(tma_predecode >0.05) & ((tma_ifetch_bandwidth=
 >0.10) & ((tma_frontend_bound >0.20)))",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads tha=
t perform one or more locks",
-        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.LOCK_LOADS@ / cpu_a=
tom@MEM_UOPS_RETIRED.ALL_LOADS@",
-        "MetricName": "tma_info_mem_mix_load_locks_ratio",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the physical register file unable to accep=
t an entry (marble stalls)",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REGISTER@ / (6 * cpu_atom=
@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_register",
+        "MetricThreshold": "(tma_register >0.10) & ((tma_resource_bound >0=
.20) & ((tma_backend_bound >0.10)))",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
-        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / cpu_=
atom@MEM_UOPS_RETIRED.ALL_LOADS@",
-        "MetricName": "tma_info_mem_mix_load_splits_ratio",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the reorder buffer being full (ROB stalls)=
",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REORDER_BUFFER@ / (6 * cp=
u_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_reorder_buffer",
+        "MetricThreshold": "(tma_reorder_buffer >0.10) & ((tma_resource_bo=
und >0.20) & ((tma_backend_bound >0.10)))",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Ratio of mem load uops to all uops",
-        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / cpu_at=
om@TOPDOWN_RETIRING.ALL_P@",
-        "MetricName": "tma_info_mem_mix_memload_ratio",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a resource limitation",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALL_P@ / (6 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@) - tma_core_bound",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricName": "tma_resource_bound",
+        "MetricThreshold": "(tma_resource_bound >0.20) & ((tma_backend_bou=
nd >0.10))",
+        "MetricgroupNoGroup": "TopdownL2",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
-        "MetricExpr": "100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (6 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricName": "tma_info_serialization _%_tpause_cycles",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by (indirect) RET instruction=
s",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.RET_COST@ * cpu_core@br_mi=
sp_retired.ret_cost@R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;Clocks_Retired;TopdownL3;tma_L3_grou=
p;tma_branch_mispredicts_group",
+        "MetricName": "tma_ret_mispredicts",
+        "MetricThreshold": "tma_ret_mispredicts > 0.05 & tma_branch_mispre=
dicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
-        "MetricName": "tma_info_system_cpu_utilization",
+        "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricName": "tma_retiring",
+        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
+        "MetricgroupNoGroup": "TopdownL1",
+        "PublicDescription": "This category represents fraction of slots u=
tilized by useful work i.e. issued uops that eventually get retired. Ideall=
y; all pipeline slots would be attributed to the Retiring category.  Retiri=
ng of 100% would indicate the maximum Pipeline_Width throughput was achieve=
d.  Maximizing Retiring typically increases the Instructions-per-cycle (see=
 IPC metric). Note that a high Retiring value does not necessary mean there=
 is no room for more performance.  For example; Heavy-operations or Microco=
de Assists are categorized under Retiring. They often indicate suboptimal p=
erformance and can often be optimized or avoided. Sample with: UOPS_RETIRED=
.SLOTS",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "cpu_atom@FP_FLOPS_RETIRED.ALL@ / (duration_time * 1=
e9)",
-        "MetricGroup": "Flops",
-        "MetricName": "tma_info_system_gflops",
-        "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to scoreboards from the instruction queue (IQ=
), jump execution unit (JEU), or microcode sequencer (MS)",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.SERIALIZATION@ / (6 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_serialization",
+        "MetricThreshold": "(tma_serialization >0.10) & ((tma_resource_bou=
nd >0.20) & ((tma_backend_bound >0.10)))",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE_P@k / cpu_atom@CPU_C=
LK_UNHALTED.CORE@",
-        "MetricGroup": "Summary",
-        "MetricName": "tma_info_system_kernel_utilization",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
+        "MetricExpr": "cpu_core@RESOURCE_STALLS.SCOREBOARD@ / tma_info_thr=
ead_clks + tma_c02_wait",
+        "MetricGroup": "BvIO;Clocks;PortsUtil;TopdownL3;tma_L3_group;tma_c=
ore_bound_group;tma_issueSO",
+        "MetricName": "tma_serializing_operation",
+        "MetricThreshold": "tma_serializing_operation > 0.1 & tma_core_bou=
nd > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@CPU_CLK_=
UNHALTED.REF_TSC@",
-        "MetricGroup": "Power",
-        "MetricName": "tma_info_system_turbo_utilization",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring Shuffle operations of 256-bit vector size (FP or Int=
eger)",
+        "MetricExpr": "tma_light_operations * cpu_core@INT_VEC_RETIRED.SHU=
FFLES@ / (tma_retiring * tma_info_thread_slots)",
+        "MetricGroup": "HPC;Pipeline;Slots;TopdownL4;tma_L4_group;tma_othe=
r_light_ops_group",
+        "MetricName": "tma_shuffles_256b",
+        "MetricThreshold": "tma_shuffles_256b > 0.1 & tma_other_light_ops =
> 0.3 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are FPDiv uops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ / cpu_atom@TOPDO=
WN_RETIRING.ALL_P@",
-        "MetricName": "tma_info_uop_mix_fpdiv_uop_ratio",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to PAUSE Instructions",
+        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.PAUSE@ / tma_info_thread_=
clks",
+        "MetricGroup": "Clocks;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
+        "MetricName": "tma_slow_pause",
+        "MetricThreshold": "tma_slow_pause > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are IDiv uops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ / cpu_atom@TOPDOW=
N_RETIRING.ALL_P@",
-        "MetricName": "tma_info_uop_mix_idiv_uop_ratio",
+        "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
+        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ * cpu_c=
ore@mem_inst_retired.split_loads@R, cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ =
* tma_info_memory_load_miss_real_latency) if 0 < cpu_core@mem_inst_retired.=
split_loads@R else cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ * tma_info_memory=
_load_miss_real_latency) / tma_info_thread_clks",
+        "MetricGroup": "Clocks_Calculated;TopdownL4;tma_L4_group;tma_l1_bo=
und_group",
+        "MetricName": "tma_split_loads",
+        "MetricThreshold": "tma_split_loads > 0.3",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are microcode op=
s",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ / cpu_atom@TOPDOWN_=
RETIRING.ALL_P@",
-        "MetricName": "tma_info_uop_mix_microcode_uop_ratio",
+        "BriefDescription": "This metric represents rate of split store ac=
cesses",
+        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.SPLIT_STORES@ * cpu_=
core@mem_inst_retired.split_stores@R, cpu_core@MEM_INST_RETIRED.SPLIT_STORE=
S@) if 0 < cpu_core@mem_inst_retired.split_stores@R else cpu_core@MEM_INST_=
RETIRED.SPLIT_STORES@) / tma_info_thread_clks",
+        "MetricGroup": "Core_Utilization;TopdownL4;tma_L4_group;tma_issueS=
pSt;tma_store_bound_group",
+        "MetricName": "tma_split_stores",
+        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0.2=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are x87 uops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ / cpu_atom@TOPDOWN=
_RETIRING.ALL_P@",
-        "MetricName": "tma_info_uop_mix_x87_uop_ratio",
+        "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
+        "MetricExpr": "(cpu_core@XQ.FULL_CYCLES@ + cpu_core@L1D_PEND_MISS.=
L2_STALLS@) / tma_info_thread_clks",
+        "MetricGroup": "BvMB;Clocks;MemoryBW;Offcore;TopdownL4;tma_L4_grou=
p;tma_issueBW;tma_l3_bound_group",
+        "MetricName": "tma_sq_full",
+        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tma_=
memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_mem_bandwidth",
+        "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ITLB_MISS@ / (6 * cpu_ato=
m@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
-        "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
 0.15 & tma_frontend_bound > 0.2)",
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to RFO store memory accesses; RFO store issue a read-for-ownership =
request before the write",
+        "MetricExpr": "cpu_core@EXE_ACTIVITY.BOUND_ON_STORES@ / tma_info_t=
hread_clks",
+        "MetricGroup": "MemoryBound;Stalls;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
+        "MetricName": "tma_store_bound",
+        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation",
-        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@ / =
(6 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
-        "MetricName": "tma_machine_clears",
-        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
n > 0.15",
-        "MetricgroupNoGroup": "TopdownL2",
+        "BriefDescription": "This metric roughly estimates fraction of cyc=
les when the memory subsystem had loads blocked since they could not forwar=
d data from earlier (in program order) overlapping stores",
+        "MetricExpr": "13 * cpu_core@LD_BLOCKS.STORE_FORWARD@ / tma_info_t=
hread_clks",
+        "MetricGroup": "Clocks_Estimated;TopdownL4;tma_L4_group;tma_l1_bou=
nd_group",
+        "MetricName": "tma_store_fwd_blk",
+        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to memory reservation stalls in which a sched=
uler is not able to accept uops",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ / (6 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_mem_scheduler",
-        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
+        "MetricExpr": "(cpu_core@MEM_STORE_RETIRED.L2_HIT@ * 10 * (1 - cpu=
_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.ALL_STORES@)=
 + (1 - cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.A=
LL_STORES@) * min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO@)) / tma_info_thread_clks",
+        "MetricGroup": "BvML;Clocks_Estimated;LockCont;MemoryLat;Offcore;T=
opdownL4;tma_L4_group;tma_issueRFO;tma_issueSL;tma_overlap;tma_store_bound_=
group",
+        "MetricName": "tma_store_latency",
+        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma_l=
3_hit_latency, tma_lock_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to IEC or FPC RAT stalls, which can be due to=
 FIQ or IEC reservation stalls in which the integer, floating point or SIMD=
 scheduler is not able to accept uops",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER@ / (6 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_non_mem_scheduler",
-        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution port for Store operations",
+        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_4_9@ + cpu_core@UOPS=
_DISPATCHED.PORT_7_8@) / (4 * tma_info_core_core_clks)",
+        "MetricGroup": "Core_Execution;TopdownL5;tma_L5_group;tma_ports_ut=
ilized_3m_group",
+        "MetricName": "tma_store_op_utilization",
+        "MetricThreshold": "tma_store_op_utilization > 0.6",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port for Store operations. Sample with:=
 UOPS_DISPATCHED.PORT_7_8",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that requires the use of m=
icrocode (slow nuke)",
-        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.NUKE@ / (6 * cpu_a=
tom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
-        "MetricName": "tma_nuke",
-        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the TLB was missed by store accesses, hitting in the second-l=
evel TLB (STLB)",
+        "MetricExpr": "max(0, tma_dtlb_store - tma_store_stlb_miss)",
+        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL5;tma_L5_group;=
tma_dtlb_store_group",
+        "MetricName": "tma_store_stlb_hit",
+        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store > 0=
.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > =
0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.OTHER@ / (6 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
-        "MetricName": "tma_other_fb",
-        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the STLB was missed by store accesses, performing a hardware page wal=
k",
+        "MetricExpr": "cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@ / tma_info_=
core_core_clks",
+        "MetricGroup": "Clocks_Calculated;MemoryTLB;TopdownL5;tma_L5_group=
;tma_dtlb_store_group",
+        "MetricName": "tma_store_stlb_miss",
+        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store > =
0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.PREDECODE@ / (6 * cpu_ato=
m@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
-        "MetricName": "tma_predecode",
-        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_1G@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.WALK=
_COMPLETED_1G@)",
+        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_group;=
tma_store_stlb_miss_group",
+        "MetricName": "tma_store_stlb_miss_1g",
+        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the physical register file unable to accep=
t an entry (marble stalls)",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REGISTER@ / (6 * cpu_atom=
@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_register",
-        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_2M_4M@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_=
core@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.W=
ALK_COMPLETED_1G@)",
+        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_group;=
tma_store_stlb_miss_group",
+        "MetricName": "tma_store_stlb_miss_2m",
+        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the reorder buffer being full (ROB stalls)=
",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REORDER_BUFFER@ / (6 * cp=
u_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_reorder_buffer",
-        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_4K@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.WALK=
_COMPLETED_1G@)",
+        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_group;=
tma_store_stlb_miss_group",
+        "MetricName": "tma_store_stlb_miss_4k",
+        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a resource limitation",
-        "MetricExpr": "tma_backend_bound - tma_core_bound",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
-        "MetricName": "tma_resource_bound",
-        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
-        "MetricgroupNoGroup": "TopdownL2",
+        "BriefDescription": "This metric estimates how often CPU was stall=
ed  due to Streaming store memory accesses; Streaming store optimize out a =
read request required by RFO stores",
+        "MetricExpr": "9 * cpu_core@OCR.STREAMING_WR.ANY_RESPONSE@ / tma_i=
nfo_thread_clks",
+        "MetricGroup": "Clocks_Estimated;MemoryBW;Offcore;TopdownL4;tma_L4=
_group;tma_issueSmSt;tma_store_bound_group",
+        "MetricName": "tma_streaming_stores",
+        "MetricThreshold": "tma_streaming_stores > 0.2 & tma_store_bound >=
 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: tma=
_fb_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that result =
in retirement slots",
-        "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL_P@ / (6 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
-        "MetricName": "tma_retiring",
-        "MetricThreshold": "tma_retiring > 0.75",
-        "MetricgroupNoGroup": "TopdownL1",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
+        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / tma_info=
_thread_clks",
+        "MetricGroup": "BigFootprint;BvBC;Clocks;FetchLat;TopdownL4;tma_L4=
_group;tma_branch_resteers_group",
+        "MetricName": "tma_unknown_branches",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_reste=
ers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to scoreboards from the instruction queue (IQ=
), jump execution unit (JEU), or microcode sequencer (MS)",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.SERIALIZATION@ / (6 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_serialization",
-        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
+        "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
+        "MetricExpr": "tma_retiring * cpu_core@UOPS_EXECUTED.X87@ / cpu_co=
re@UOPS_EXECUTED.THREAD@",
+        "MetricGroup": "Compute;TopdownL4;Uops;tma_L4_group;tma_fp_arith_g=
roup",
+        "MetricName": "tma_x87_use",
+        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma_l=
ight_operations > 0.6",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -708,7 +2712,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
         "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS_D=
ISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_DIS=
PATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -721,13 +2725,13 @@
         "MetricExpr": "78 * cpu_core@ASSISTS.ANY@ / tma_info_thread_slots"=
,
         "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
-        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
+        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1",
         "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists.",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists",
         "MetricExpr": "63 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_threa=
d_slots",
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_avx_assists",
@@ -737,7 +2741,7 @@
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
-        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
         "MetricGroup": "BvOB;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -753,18 +2757,123 @@
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misses =
+ tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
+        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
+        "MetricName": "tma_bottleneck_big_code",
+        "MetricThreshold": "tma_bottleneck_big_code > 20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
+        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ + 2 =
* cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRED.NOP@) / tma_i=
nfo_thread_slots)",
+        "MetricGroup": "BvBO;Ret",
+        "MetricName": "tma_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
+        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dr=
am_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_store_fwd_blk + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_fb_full)=
))",
+        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
+        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_mem_b=
andwidth, tma_sq_full",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + =
tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_de=
pendency + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_=
bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_d=
ram_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_st=
ore_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_load=
s + tma_fb_full)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_=
l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_split_l=
oads / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_dependency + tma=
_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound * (tma_s=
tore_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_split_stores / (tma_store_latency + tma_false_sha=
ring + tma_split_stores + tma_streaming_stores + tma_dtlb_store)) + tma_mem=
ory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_dram_bound + tma_store_bound)) * (tma_store_latency / (tma_store_late=
ncy + tma_false_sharing + tma_split_stores + tma_streaming_stores + tma_dtl=
b_store)))",
+        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_bottleneck_cache_memory_latency",
+        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_serializing_operation + tma_ports_utilization) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_serializing_operation + tma_ports_=
utilization)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricGroup": "BvCB;Cor;tma_issueComp",
+        "MetricName": "tma_bottleneck_compute_bound_est",
+        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses + t=
ma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
0x1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_=
clears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_br=
anch_mispredicts) / (tma_mispredicts_resteers + tma_clears_resteers + tma_u=
nknown_branches)) / (tma_icache_misses + tma_itlb_misses + tma_branch_reste=
ers + tma_ms_switches + tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth *=
 tma_ms / (tma_mite + tma_dsb + tma_lsd + tma_ms))) - tma_bottleneck_big_co=
de",
+        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
+        "MetricName": "tma_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
+        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_fetch_latency * (tma_ms_s=
witches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_rest=
eers * tma_other_mispredicts / tma_branch_mispredicts) / (tma_mispredicts_r=
esteers + tma_clears_resteers + tma_unknown_branches)) / (tma_icache_misses=
 + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_=
dsb_switches) + tma_fetch_bandwidth * tma_ms / (tma_mite + tma_dsb + tma_ls=
d + tma_ms)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_b=
ranch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other=
_nukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + cp=
u_core@RS.EMPTY_RESOURCE@ / tma_info_thread_clks * tma_ports_utilized_0) / =
(tma_divider + tma_serializing_operation + tma_ports_utilization) + tma_mic=
rocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) * =
(tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
+        "MetricName": "tma_bottleneck_irregular_overhead",
+        "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
+        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_depende=
ncy + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound=
 * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dra=
m_bound + tma_store_bound)) * (tma_dtlb_store / (tma_store_latency + tma_fa=
lse_sharing + tma_split_stores + tma_streaming_stores + tma_dtlb_store)))",
+        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * =
tma_false_sharing / (tma_store_latency + tma_false_sharing + tma_split_stor=
es + tma_streaming_stores + tma_dtlb_store - tma_store_latency)) + tma_mach=
ine_clears * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
+        "MetricName": "tma_bottleneck_memory_synchronization",
+        "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
+        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_contested_accesses, tma_data_sharing, tma_false_s=
haring, tma_machine_clears",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
+        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses=
 + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches))",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
+        "MetricName": "tma_bottleneck_mispredictions",
+        "MetricThreshold": "tma_bottleneck_mispredictions > 20",
+        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
+        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_ins=
truction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_cache_me=
mory_bandwidth + tma_bottleneck_cache_memory_latency + tma_bottleneck_memor=
y_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottleneck_comput=
e_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_branching_=
overhead + tma_bottleneck_useful_work)",
+        "MetricGroup": "BvOB;Cor;Offcore",
+        "MetricName": "tma_bottleneck_other_bottlenecks",
+        "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead",
+        "MetricExpr": "100 * (tma_retiring - (cpu_core@BR_INST_RETIRED.ALL=
_BRANCHES@ + 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRE=
D.NOP@) / tma_info_thread_slots - tma_microcode_sequencer / (tma_few_uops_i=
nstructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_seque=
ncer) * tma_heavy_operations)",
+        "MetricGroup": "BvUW;Ret",
+        "MetricName": "tma_bottleneck_useful_work",
+        "MetricThreshold": "tma_bottleneck_useful_work > 20",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
-        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * sl=
ots",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: =
tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredict=
ions, tma_mispredicts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics: =
tma_bottleneck_mispredictions, tma_info_bad_spec_branch_misprediction_cost,=
 tma_mispredicts_resteers",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -773,26 +2882,26 @@
         "MetricExpr": "cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_=
thread_clks + tma_unknown_branches",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
-        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
+        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings).",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings)",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C01@ / tma_info_thread_cl=
ks",
         "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
         "MetricName": "tma_c01_wait",
-        "MetricThreshold": "tma_c01_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_c01_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings).",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings)",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C02@ / tma_info_thread_cl=
ks",
         "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
         "MetricName": "tma_c02_wait",
-        "MetricThreshold": "tma_c02_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_c02_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -801,7 +2910,7 @@
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
+        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources. Sample with: FRONTEND_RETIRE=
D.MS_FLOWS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -811,18 +2920,90 @@
         "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
-        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_restee=
rs > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Sam=
ple with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, tma=
_machine_clears, tma_microcode_sequencer, tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache",
+        "MetricExpr": "max(0, cpu_core@FRONTEND_RETIRED.L1I_MISS@ * cpu_co=
re@frontend_retired.l1i_miss@R / tma_info_thread_clks - tma_code_l2_miss)",
+        "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
+        "MetricName": "tma_code_l2_hit",
+        "MetricThreshold": "tma_code_l2_hit > 0.05 & tma_icache_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.L2_MISS@ * cpu_core@front=
end_retired.l2_miss@R / tma_info_thread_clks",
+        "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
+        "MetricName": "tma_code_l2_miss",
+        "MetricThreshold": "tma_code_l2_miss > 0.05 & tma_icache_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) ITLB was missed by instructions fetches, th=
at later on hit in second-level TLB (STLB)",
+        "MetricExpr": "max(0, cpu_core@FRONTEND_RETIRED.ITLB_MISS@ * cpu_c=
ore@frontend_retired.itlb_miss@R / tma_info_thread_clks - tma_code_stlb_mis=
s)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
+        "MetricName": "tma_code_stlb_hit",
+        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by instruction fetches, perfor=
ming a hardware page walk",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.STLB_MISS@ * cpu_core@fro=
ntend_retired.stlb_miss@R / tma_info_thread_clks",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
+        "MetricName": "tma_code_stlb_miss",
+        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses",
+        "MetricExpr": "cpu_core@ITLB_MISSES.WALK_ACTIVE@ / tma_info_thread=
_clks * cpu_core@ITLB_MISSES.WALK_COMPLETED_2M_4M@ / (cpu_core@ITLB_MISSES.=
WALK_COMPLETED_4K@ + cpu_core@ITLB_MISSES.WALK_COMPLETED_2M_4M@)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_2m",
+        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses",
+        "MetricExpr": "cpu_core@ITLB_MISSES.WALK_ACTIVE@ / tma_info_thread=
_clks * cpu_core@ITLB_MISSES.WALK_COMPLETED_4K@ / (cpu_core@ITLB_MISSES.WAL=
K_COMPLETED_4K@ + cpu_core@ITLB_MISSES.WALK_COMPLETED_2M_4M@)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_4k",
+        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by non-taken conditional bran=
ches",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_NTAKEN_COST@ * cpu_co=
re@br_misp_retired.cond_ntaken_cost@R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_cond_nt_mispredicts",
+        "MetricThreshold": "tma_cond_nt_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by taken conditional branches",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.COND_TAKEN_COST@ * cpu_cor=
e@br_misp_retired.cond_taken_cost@R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_cond_tk_mispredicts",
+        "MetricThreshold": "tma_cond_tk_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ * min(=
cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@R, 24 * tma_info_system_core_fre=
quency) + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * min(cpu_core@MEM_LOA=
D_L3_HIT_RETIRED.XSNP_FWD@R, 25 * tma_info_system_core_frequency) * (cpu_co=
re@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_=
HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@)))=
 * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MI=
SS@ / 2) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_l3_bound_group",
+        "MetricExpr": "((min(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ *=
 cpu_core@mem_load_l3_hit_retired.xsnp_miss@R, cpu_core@MEM_LOAD_L3_HIT_RET=
IRED.XSNP_MISS@ * (27 * tma_info_system_core_frequency) - 3 * tma_info_syst=
em_core_frequency) if 0 < cpu_core@mem_load_l3_hit_retired.xsnp_miss@R else=
 cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@ * (27 * tma_info_system_core_f=
requency) - 3 * tma_info_system_core_frequency) + (min(cpu_core@MEM_LOAD_L3=
_HIT_RETIRED.XSNP_FWD@ * cpu_core@mem_load_l3_hit_retired.xsnp_fwd@R, cpu_c=
ore@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (28 * tma_info_system_core_frequenc=
y) - 3 * tma_info_system_core_frequency) if 0 < cpu_core@mem_load_l3_hit_re=
tired.xsnp_fwd@R else cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (28 * tm=
a_info_system_core_frequency) - 3 * tma_info_system_core_frequency) * (cpu_=
core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L=
3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@)=
)) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_=
MISS@ / 2) / tma_info_thread_clks",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
-        "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related m=
etrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma_remote=
_cache",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related =
metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false=
_sharing, tma_machine_clears",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -833,26 +3014,26 @@
         "MetricName": "tma_core_bound",
         "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations)",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ * mi=
n(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@R, 24 * tma_info_system_core=
_frequency) + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * min(cpu_core@MEM=
_LOAD_L3_HIT_RETIRED.XSNP_FWD@R, 24 * tma_info_system_core_frequency) * (1 =
- cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DEMAND_DAT=
A_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH=
_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIR=
ED.L1_MISS@ / 2) / tma_info_thread_clks",
+        "MetricExpr": "((min(cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@=
 * cpu_core@mem_load_l3_hit_retired.xsnp_no_fwd@R, cpu_core@MEM_LOAD_L3_HIT=
_RETIRED.XSNP_NO_FWD@ * (27 * tma_info_system_core_frequency) - 3 * tma_inf=
o_system_core_frequency) if 0 < cpu_core@mem_load_l3_hit_retired.xsnp_no_fw=
d@R else cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ * (27 * tma_info_sys=
tem_core_frequency) - 3 * tma_info_system_core_frequency) + (min(cpu_core@M=
EM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * cpu_core@mem_load_l3_hit_retired.xsnp_fw=
d@R, cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (27 * tma_info_system_cor=
e_frequency) - 3 * tma_info_system_core_frequency) if 0 < cpu_core@mem_load=
_l3_hit_retired.xsnp_fwd@R else cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ =
* (27 * tma_info_system_core_frequency) - 3 * tma_info_system_core_frequenc=
y) * (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.DE=
MAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_=
HIT_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LO=
AD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
         "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
-        "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
+        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_synch=
ronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cp=
u_core@INST_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2"=
,
+        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - =
cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks =
/ 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & t=
ma_fetch_bandwidth > 0.2)",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & tma_mite > 0.1 & tm=
a_fetch_bandwidth > 0.2",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -862,8 +3043,8 @@
         "MetricExpr": "cpu_core@ARITH.DIV_ACTIVE@ / tma_info_thread_clks",
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
-        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
-        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_UOPS",
+        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & tma=
_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIV_ACTIVE",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -872,8 +3053,8 @@
         "MetricExpr": "cpu_core@MEMORY_ACTIVITY.STALLS_L3_MISS@ / tma_info=
_thread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS_PS",
+        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -883,7 +3064,7 @@
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
         "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -892,48 +3073,48 @@
         "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / tma_in=
fo_thread_clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
-        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_ban=
dwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwi=
dth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_inf=
o_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_HIT_LOADS@ * min(cpu=
_core@MEM_INST_RETIRED.STLB_HIT_LOADS@R, 7) / tma_info_thread_clks + tma_lo=
ad_stlb_miss",
+        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.STLB_HIT_LOADS@ * cp=
u_core@mem_inst_retired.stlb_hit_loads@R, cpu_core@MEM_INST_RETIRED.STLB_HI=
T_LOADS@ * 7) if 0 < cpu_core@mem_inst_retired.stlb_hit_loads@R else cpu_co=
re@MEM_INST_RETIRED.STLB_HIT_LOADS@ * 7) / tma_info_thread_clks + tma_load_=
stlb_miss",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
-        "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_me=
mory_synchronization",
+        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma=
_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS. Related metrics: tma_=
bottleneck_memory_data_tlbs, tma_dtlb_store",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_HIT_STORES@ * min(cp=
u_core@MEM_INST_RETIRED.STLB_HIT_STORES@R, 7) / tma_info_thread_clks + tma_=
store_stlb_miss",
+        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.STLB_HIT_STORES@ * c=
pu_core@mem_inst_retired.stlb_hit_stores@R, cpu_core@MEM_INST_RETIRED.STLB_=
HIT_STORES@ * 7) if 0 < cpu_core@mem_inst_retired.stlb_hit_stores@R else cp=
u_core@MEM_INST_RETIRED.STLB_HIT_STORES@ * 7) / tma_info_thread_clks + tma_=
store_stlb_miss",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
-        "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_memory_synchroniz=
ation",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.2 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES. Related metrics: tma_bottleneck_mem=
ory_data_tlbs, tma_dtlb_load",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
         "MetricExpr": "28 * tma_info_system_core_frequency * cpu_core@OCR.=
DEMAND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_store_bound_group",
+        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
-        "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_contested_accesses, tma_data_sharing=
, tma_machine_clears, tma_remote_cache",
+        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound > 0=
.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronization, t=
ma_contested_accesses, tma_data_sharing, tma_machine_clears",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricExpr": "cpu_core@L1D_PEND_MISS.FB_FULL@ / tma_info_thread_c=
lks",
-        "MetricGroup": "BvMS;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
-        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_bottleneck_cache_memory_bandwi=
dth, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store=
_latency, tma_streaming_stores",
+        "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_bottleneck_cache_memory_bandwidth, =
tma_mem_bandwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -944,28 +3125,28 @@
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1, FRONTEND_RETIRED.LATE=
NCY_GE_1, FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches,=
 tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU was stalled due to Frontend latency issues",
-        "MetricExpr": "cpu_core@topdown\\-fetch\\-lat@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / t=
ma_info_thread_slots",
+        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - cpu_core@I=
NT_MISC.UOP_DROPPING@ / tma_info_thread_slots",
         "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_frontend=
_bound_group",
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16, FRONTEND_RETIRED.LATENCY_GE_8",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or more =
uops",
         "MetricExpr": "max(0, tma_heavy_operations - tma_microcode_sequenc=
er)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_heavy_operations_group;=
tma_issueD0",
         "MetricName": "tma_few_uops_instructions",
         "MetricThreshold": "tma_few_uops_instructions > 0.05 & tma_heavy_o=
perations > 0.1",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or up t=
o ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number o=
f uops in such instructions. Related metrics: tma_decoder0_alone",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring instructions that that are decoder into two or more=
 uops. This highly-correlates with the number of uops in such instructions.=
 Related metrics: tma_decoder0_alone",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -975,7 +3156,7 @@
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
         "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
-        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -985,7 +3166,16 @@
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_fp_assists",
         "MetricThreshold": "tma_fp_assists > 0.1",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals).",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals)",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active",
+        "MetricExpr": "cpu_core@ARITH.FPDIV_ACTIVE@ / tma_info_thread_clks=
",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
+        "MetricName": "tma_fp_divider",
+        "MetricThreshold": "tma_fp_divider > 0.2 & tma_divider > 0.2 & tma=
_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -994,8 +3184,8 @@
         "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ / (tma_retir=
ing * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
-        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector_2=
56b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma=
_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1004,8 +3194,8 @@
         "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.VECTOR@ / (tma_retir=
ing * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
-        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized=
_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1014,8 +3204,8 @@
         "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
-        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_=
2",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1024,40 +3214,40 @@
         "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@=
 + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / (tma_retiring * tm=
a_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
-        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_=
2",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_int_vector_128b, tma_int_vector_256b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
-        "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tm=
a_info_thread_slots",
+        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - cpu_core@IN=
T_MISC.UOP_DROPPING@ / tma_info_thread_slots",
         "MetricGroup": "BvFB;BvIO;PGO;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4_PS",
+        "PublicDescription": "This category represents fraction of slots w=
here the processor's Frontend undersupplies its Backend. Frontend denotes t=
he first part of the processor core responsible to fetch operations that ar=
e executed later on by the Backend part. Within the Frontend; a branch pred=
ictor predicts the next address to fetch; cache-lines are fetched from the =
memory subsystem; parsed into instructions; and lastly decoded into micro-o=
perations (uops). Ideally the Frontend can issue Pipeline_Width uops every =
cycle to the Backend. Frontend Bound denotes unutilized issue-slots when th=
ere is no Backend stall; i.e. bubbles where Frontend delivered no uops whil=
e Backend could have accepted them. For example; stalls due to instruction-=
cache misses would be categorized under Frontend Bound. Sample with: FRONTE=
ND_RETIRED.LATENCY_GE_4",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions , where one uop can represent mul=
tiple contiguous instructions",
         "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.MACRO_=
FUSED@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of =
legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Ot=
her_Light_Ops in MTL!)}",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions , where one uop can represent mu=
ltiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of l=
egacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Oth=
er_Light_Ops in MTL!)}",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
-        "MetricExpr": "cpu_core@topdown\\-heavy\\-ops@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. ([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+] .). Sample with: UOPS=
_RETIRED.HEAVY",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+]). Sample with: UOPS_RET=
IRED.HEAVY",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1066,21 +3256,39 @@
         "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / tma_info_thread_clks=
",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
+        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS, FRONTEND_RETIRED.L1I_MISS",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect CALL instructions=
",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.INDIRECT_CALL_COST@ * cpu_=
core@br_misp_retired.indirect_call_cost@R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_ind_call_mispredicts",
+        "MetricThreshold": "tma_ind_call_mispredicts > 0.05 & tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect JMP instructions"=
,
+        "MetricExpr": "max((cpu_core@BR_MISP_RETIRED.INDIRECT_COST@ * cpu_=
core@br_misp_retired.indirect_cost@R - cpu_core@BR_MISP_RETIRED.INDIRECT_CA=
LL_COST@ * cpu_core@br_misp_retired.indirect_call_cost@R) / tma_info_thread=
_clks, 0)",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_ind_jump_mispredicts",
+        "MetricThreshold": "tma_ind_jump_mispredicts > 0.05 & tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
-        "MetricExpr": "tma_info_bottleneck_mispredictions * tma_info_threa=
d_slots / cpu_core@BR_MISP_RETIRED.ALL_BRANCHES@ / 100",
+        "BriefDescription": "Branch Misprediction Cost: Cycles representin=
g fraction of TMA slots wasted per non-speculative branch misprediction (re=
tired JEClear)",
+        "MetricExpr": "tma_bottleneck_mispredictions * tma_info_thread_slo=
ts / 6 / cpu_core@BR_MISP_RETIRED.ALL_BRANCHES@ / 100",
         "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
-        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers",
+        "PublicDescription": "Branch Misprediction Cost: Cycles representi=
ng fraction of TMA slots wasted per non-speculative branch misprediction (r=
etired JEClear). Related metrics: tma_bottleneck_mispredictions, tma_branch=
_mispredicts, tma_mispredicts_resteers",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate)",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.COND_NTAKEN@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
@@ -1088,7 +3296,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate)",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.COND_TAKEN@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
@@ -1096,15 +3304,15 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.INDIRECT@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
-        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3",
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate)",
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.RET@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_ret",
@@ -1120,7 +3328,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing mispredicts and nukes)",
+        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing Mispredicts and nukes)",
         "MetricExpr": "cpu_core@INT_MISC.CLEARS_COUNT@ / (cpu_core@BR_MISP=
_RETIRED.ALL_BRANCHES@ + cpu_core@MACHINE_CLEARS.COUNT@)",
         "MetricGroup": "BrMispredicts",
         "MetricName": "tma_info_bad_spec_spec_clears_ratio",
@@ -1136,8 +3344,8 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_lsd =
+ tma_mite)))",
-        "MetricGroup": "DSB;FetchBW;tma_issueFB",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_dsb=
 + tma_lsd + tma_ms)))",
+        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
         "PublicDescription": "Total pipeline cost of DSB (uop cache) hits =
- subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb_s=
witches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_front=
end_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
@@ -1145,7 +3353,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + t=
ma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite + t=
ma_dsb + tma_lsd + tma_ms))",
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_misses",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
@@ -1154,116 +3362,10 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + =
tma_lcp + tma_dsb_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
         "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
-        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: ",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
-        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
-        "MetricName": "tma_info_bottleneck_big_code",
-        "MetricThreshold": "tma_info_bottleneck_big_code > 20",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
-        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ + 2 =
* cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRED.NOP@) / tma_i=
nfo_thread_slots)",
-        "MetricGroup": "BvBO;Ret",
-        "MetricName": "tma_info_bottleneck_branching_overhead",
-        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 5",
-        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_h=
it_latency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
-        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_bottleneck_cache_memory_bandwidth",
-        "MetricThreshold": "tma_info_bottleneck_cache_memory_bandwidth > 2=
0",
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_store_bound / (tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tm=
a_store_latency + tma_streaming_stores)) + tma_memory_bound * (tma_l1_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store=
_bound)) * (tma_l1_hit_latency / (tma_dtlb_load + tma_fb_full + tma_l1_hit_=
latency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
-        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_info_bottleneck_cache_memory_latency",
-        "MetricThreshold": "tma_info_bottleneck_cache_memory_latency > 20"=
,
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
-        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_ports_utilization + tma_serializing_operation) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_ports_utilization + tma_serializin=
g_operation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
-        "MetricGroup": "BvCB;Cor;tma_issueComp",
-        "MetricName": "tma_info_bottleneck_compute_bound_est",
-        "MetricThreshold": "tma_info_bottleneck_compute_bound_est > 20",
-        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: ",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
-        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_cl=
ears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_bran=
ch_mispredicts) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unk=
nown_branches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_miss=
es + tma_itlb_misses + tma_lcp + tma_ms_switches))) - tma_info_bottleneck_b=
ig_code",
-        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
-        "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
-        "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"=
,
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
-        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_swi=
tches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_restee=
rs * tma_other_mispredicts / tma_branch_mispredicts) / (tma_clears_resteers=
 + tma_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers=
 + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_m=
s_switches)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_b=
ranch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other=
_nukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + cp=
u_core@RS.EMPTY\\,umask\\=3D1@ / tma_info_thread_clks * tma_ports_utilized_=
0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) + tm=
a_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequence=
r) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
-        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
-        "MetricName": "tma_info_bottleneck_irregular_overhead",
-        "MetricThreshold": "tma_info_bottleneck_irregular_overhead > 10",
-        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l1_hit_latency + tma_loc=
k_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma=
_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma_false_sharin=
g + tma_split_stores + tma_store_latency + tma_streaming_stores)))",
-        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_bottleneck_memory_data_tlbs",
-        "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store, tma_info_bottleneck_memory_synchronization",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_stores =
+ tma_store_latency + tma_streaming_stores - tma_store_latency)) + tma_mach=
ine_clears * (1 - tma_other_nukes / tma_other_nukes))",
-        "MetricGroup": "BvMS;Mem;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_bottleneck_memory_synchronization",
-        "MetricThreshold": "tma_info_bottleneck_memory_synchronization > 1=
0",
-        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_dtlb_load, tma_dtlb_store, tma_info_bottleneck_me=
mory_data_tlbs",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
-        "MetricName": "tma_info_bottleneck_mispredictions",
-        "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
-        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
-        "MetricExpr": "100 - (tma_info_bottleneck_big_code + tma_info_bott=
leneck_instruction_fetch_bw + tma_info_bottleneck_mispredictions + tma_info=
_bottleneck_cache_memory_bandwidth + tma_info_bottleneck_cache_memory_laten=
cy + tma_info_bottleneck_memory_data_tlbs + tma_info_bottleneck_memory_sync=
hronization + tma_info_bottleneck_compute_bound_est + tma_info_bottleneck_i=
rregular_overhead + tma_info_bottleneck_branching_overhead + tma_info_bottl=
eneck_useful_work)",
-        "MetricGroup": "BvOB;Cor;Offcore",
-        "MetricName": "tma_info_bottleneck_other_bottlenecks",
-        "MetricThreshold": "tma_info_bottleneck_other_bottlenecks > 20",
-        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls.",
-        "Unit": "cpu_core"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
-        "MetricExpr": "100 * (tma_retiring - (cpu_core@BR_INST_RETIRED.ALL=
_BRANCHES@ + 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRE=
D.NOP@) / tma_info_thread_slots - tma_microcode_sequencer / (tma_few_uops_i=
nstructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_seque=
ncer) * tma_heavy_operations)",
-        "MetricGroup": "BvUW;Ret",
-        "MetricName": "tma_info_bottleneck_useful_work",
-        "MetricThreshold": "tma_info_bottleneck_useful_work > 20",
         "Unit": "cpu_core"
     },
     {
@@ -1334,12 +3436,12 @@
         "MetricExpr": "(cpu_core@FP_ARITH_DISPATCHED.PORT_0@ + cpu_core@FP=
_ARITH_DISPATCHED.PORT_1@ + cpu_core@FP_ARITH_DISPATCHED.PORT_5@) / (2 * tm=
a_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n).",
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
-        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_EXEC=
UTED.THREAD\\,cmask\\=3D1@",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_EXEC=
UTED.THREAD\\,cmask\\=3D0x1@",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp",
         "Unit": "cpu_core"
@@ -1354,22 +3456,30 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
-        "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / cpu_co=
re@DSB2MITE_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
",
+        "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / cpu_co=
re@DSB2MITE_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
         "MetricGroup": "DSBmiss",
         "MetricName": "tma_info_frontend_dsb_switch_cost",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired DSB misses",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.ANY_DSB_MISS@ * cpu_core@=
frontend_retired.any_dsb_miss@R / tma_info_thread_clks",
+        "MetricGroup": "DSBmiss;Fed;FetchLat",
+        "MetricName": "tma_info_frontend_dsb_switches_ret",
+        "MetricThreshold": "tma_info_frontend_dsb_switches_ret > 0.05",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "cpu_core@UOPS_ISSUED.ANY@ / cpu_core@UOPS_ISSUED.AN=
Y\\,cmask\\=3D1@",
+        "MetricExpr": "cpu_core@UOPS_ISSUED.ANY@ / cpu_core@UOPS_ISSUED.AN=
Y\\,cmask\\=3D0x1@",
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "tma_info_frontend_fetch_upc",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
-        "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / cpu_core@ICACHE_DATA=
.STALLS\\,cmask\\=3D1\\,edge@",
+        "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / cpu_core@ICACHE_DATA=
.STALL_PERIODS@",
         "MetricGroup": "Fed;FetchLat;IcMiss",
         "MetricName": "tma_info_frontend_icache_miss_latency",
         "Unit": "cpu_core"
@@ -1410,16 +3520,38 @@
         "MetricName": "tma_info_frontend_lsd_coverage",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired operations that invoke th=
e Microcode Sequencer",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.MS_FLOWS@ * cpu_core@fron=
tend_retired.ms_flows@R / tma_info_thread_clks",
+        "MetricGroup": "Fed;FetchLat;MicroSeq",
+        "MetricName": "tma_info_frontend_ms_latency_ret",
+        "MetricThreshold": "tma_info_frontend_ms_latency_ret > 0.05",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ / tma_info_thr=
ead_clks",
+        "MetricGroup": "Branches;FetchBW",
+        "MetricName": "tma_info_frontend_tbpc",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Average number of cycles the front-end was de=
layed due to an Unknown Branch detection",
-        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / cpu_core=
@INT_MISC.UNKNOWN_BRANCH_CYCLES\\,cmask\\=3D1\\,edge@",
+        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / cpu_core=
@INT_MISC.UNKNOWN_BRANCH_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
         "MetricGroup": "Fed",
         "MetricName": "tma_info_frontend_unknown_branch_cost",
-        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node.",
+        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired branches who got branch a=
ddress clears",
+        "MetricExpr": "cpu_core@FRONTEND_RETIRED.UNKNOWN_BRANCH@ * cpu_cor=
e@frontend_retired.unknown_branch@R / tma_info_thread_clks",
+        "MetricGroup": "Fed;FetchLat",
+        "MetricName": "tma_info_frontend_unknown_branches_ret",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
+        "BriefDescription": "Branch instructions per taken branch",
         "MetricExpr": "cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ / cpu_core@B=
R_INST_RETIRED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_bptkbranch",
@@ -1439,7 +3571,7 @@
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW.",
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW",
         "Unit": "cpu_core"
     },
     {
@@ -1448,7 +3580,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting",
         "Unit": "cpu_core"
     },
     {
@@ -1457,7 +3589,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting",
         "Unit": "cpu_core"
     },
     {
@@ -1466,7 +3598,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting",
         "Unit": "cpu_core"
     },
     {
@@ -1475,7 +3607,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting.",
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting",
         "Unit": "cpu_core"
     },
     {
@@ -1527,7 +3659,7 @@
     },
     {
         "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@SW_PREFETCH_A=
CCESS.T0\\,umask\\=3D0xF@",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@SW_PREFETCH_A=
CCESS.ANY@",
         "MetricGroup": "Prefetches",
         "MetricName": "tma_info_inst_mix_ipswpf",
         "MetricThreshold": "tma_info_inst_mix_ipswpf < 100",
@@ -1538,7 +3670,7 @@
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
-        "MetricThreshold": "tma_info_inst_mix_iptb < 13",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 6 * 2 + 1",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp",
         "Unit": "cpu_core"
     },
@@ -1579,7 +3711,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / duration_tim=
e",
+        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / tma_info_sys=
tem_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw",
         "Unit": "cpu_core"
@@ -1600,7 +3732,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / duration_tim=
e",
+        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / tma_info_sys=
tem_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l2_cache_fill_bw",
         "Unit": "cpu_core"
@@ -1649,14 +3781,14 @@
     },
     {
         "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ duration_time",
+        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "tma_info_memory_l3_cache_access_bw",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / durat=
ion_time",
+        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / tma_i=
nfo_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l3_cache_fill_bw",
         "Unit": "cpu_core"
@@ -1678,13 +3810,13 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS.DEMAND_DATA_RD@",
-        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricGroup": "LockCont;Memory_Lat;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_miss_latency",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
-        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@"=
,
         "MetricGroup": "Memory_BW;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_mlp",
         "Unit": "cpu_core"
@@ -1725,6 +3857,14 @@
         "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Rate of L2 HW prefetched lines that were not =
used by demand accesses",
+        "MetricExpr": "cpu_core@L2_LINES_OUT.USELESS_HWPF@ / (cpu_core@L2_=
LINES_OUT.SILENT@ + cpu_core@L2_LINES_OUT.NON_SILENT@)",
+        "MetricGroup": "Prefetches",
+        "MetricName": "tma_info_memory_prefetches_useless_hwpf",
+        "MetricThreshold": "tma_info_memory_prefetches_useless_hwpf > 0.15=
",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
         "MetricExpr": "1e3 * cpu_core@ITLB_MISSES.WALK_COMPLETED@ / cpu_co=
re@INST_RETIRED.ANY@",
@@ -1732,6 +3872,14 @@
         "MetricName": "tma_info_memory_tlb_code_stlb_mpki",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to STLB misses by demand loads",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_MISS_LOADS@ * cpu_co=
re@mem_inst_retired.stlb_miss_loads@R / tma_info_thread_clks",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_load_stlb_miss_ret",
+        "MetricThreshold": "tma_info_memory_tlb_load_stlb_miss_ret > 0.05"=
,
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
         "MetricExpr": "1e3 * cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED@ / c=
pu_core@INST_RETIRED.ANY@",
@@ -1747,6 +3895,14 @@
         "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization > 0=
.5",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to STLB misses by demand stores",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.STLB_MISS_STORES@ * cpu_c=
ore@mem_inst_retired.stlb_miss_stores@R / tma_info_thread_clks",
+        "MetricGroup": "Mem;MemoryTLB",
+        "MetricName": "tma_info_memory_tlb_store_stlb_miss_ret",
+        "MetricThreshold": "tma_info_memory_tlb_store_stlb_miss_ret > 0.05=
",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
         "MetricExpr": "1e3 * cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED@ / =
cpu_core@INST_RETIRED.ANY@",
@@ -1755,8 +3911,8 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
-        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D1@)",
+        "BriefDescription": "",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D0x1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute",
         "Unit": "cpu_core"
@@ -1787,20 +3943,20 @@
         "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@ASSISTS.ANY@"=
,
         "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
         "MetricName": "tma_info_pipeline_ipassist",
-        "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
+        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
         "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D1@",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D0x1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
-        "MetricExpr": "cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D1@",
+        "MetricExpr": "cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOP=
S_RETIRED.SLOTS\\,cmask\\=3D0x1@",
         "MetricGroup": "MicroSeq;Pipeline;Ret",
         "MetricName": "tma_info_pipeline_strings_cycles",
         "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1",
@@ -1816,7 +3972,7 @@
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency",
         "Unit": "cpu_core"
@@ -1837,15 +3993,15 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_HAC_ARB_TRK_REQUESTS.ALL + UNC_HAC_ARB_CO=
H_TRK_REQUESTS.ALL) / 1e9 / duration_time",
+        "MetricExpr": "64 * (UNC_HAC_ARB_TRK_REQUESTS.ALL + UNC_HAC_ARB_CO=
H_TRK_REQUESTS.ALL) / 1e9 / tma_info_system_time",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_cache_memory_bandwidth, tma_mem_bandwidth, tma_sq_full",
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_ban=
dwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu_c=
ore@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INST_=
RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) =
/ 1e9 / duration_time",
+        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu_c=
ore@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INST_=
RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) =
/ 1e9 / tma_info_system_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width",
@@ -1853,22 +4009,23 @@
     },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.FAR_BRANCH@u",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_INST_RETIRED.FAR_BR=
ANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_system_ipfarbranch",
-        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6",
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@k / cpu_core@INS=
T_RETIRED.ANY_P@k",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
         "MetricGroup": "OS",
         "MetricName": "tma_info_system_kernel_cpi",
+        "ScaleUnit": "1per_instr",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@k / cpu_core@CPU=
_CLK_UNHALTED.THREAD@",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / cpu_core@CPU_CLK_UNHA=
LTED.THREAD@",
         "MetricGroup": "OS",
         "MetricName": "tma_info_system_kernel_utilization",
         "MetricThreshold": "tma_info_system_kernel_utilization > 0.05",
@@ -1876,12 +4033,27 @@
     },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
-        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANCY.RD=
@cmask\\=3D1@",
+        "MetricExpr": "UNC_ARB_DAT_OCCUPANCY.RD / UNC_ARB_DAT_OCCUPANCY.RD=
@thresh\\=3D0x1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@ / cpu_core@CPU_=
CLK_UNHALTED.THREAD@",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total package Power in Watts",
+        "MetricExpr": "power@energy\\-pkg@ * 61 / (tma_info_system_time * =
1e6)",
+        "MetricGroup": "Power;SoC",
+        "MetricName": "tma_info_system_power",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
         "MetricExpr": "(1 - cpu_core@CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE@ /=
 cpu_core@CPU_CLK_UNHALTED.REF_DISTRIBUTED@ if #SMT_on else 0)",
@@ -1896,6 +4068,14 @@
         "MetricName": "tma_info_system_socket_clks",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Run duration time in seconds",
+        "MetricExpr": "duration_time",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_time",
+        "MetricThreshold": "tma_info_system_time < 1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "tma_info_thread_clks / cpu_core@CPU_CLK_UNHALTED.RE=
F_TSC@",
@@ -1904,7 +4084,7 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD@",
         "MetricGroup": "Pipeline",
         "MetricName": "tma_info_thread_clks",
@@ -1915,6 +4095,7 @@
         "MetricExpr": "1 / tma_info_thread_ipc",
         "MetricGroup": "Mem;Pipeline",
         "MetricName": "tma_info_thread_cpi",
+        "ScaleUnit": "1per_instr",
         "Unit": "cpu_core"
     },
     {
@@ -1922,7 +4103,7 @@
         "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_ISSU=
ED.ANY@",
         "MetricGroup": "Cor;Pipeline",
         "MetricName": "tma_info_thread_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage.",
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage",
         "Unit": "cpu_core"
     },
     {
@@ -1934,14 +4115,14 @@
     },
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "cpu_core@TOPDOWN.SLOTS@",
+        "MetricExpr": "slots",
         "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(tma_info_thread_slots / (cpu_core@TOPDOWN.SLOTS@ /=
 2) if #SMT_on else 1)",
+        "MetricExpr": "(tma_info_thread_slots / (slots / 2) if #SMT_on els=
e 1)",
         "MetricGroup": "SMT;TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots_utilization",
         "Unit": "cpu_core"
@@ -1959,7 +4140,16 @@
         "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@BR_=
INST_RETIRED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
-        "MetricThreshold": "tma_info_thread_uptb < 9",
+        "MetricThreshold": "tma_info_thread_uptb < 6 * 1.5",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active",
+        "MetricExpr": "tma_divider - tma_fp_divider",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
+        "MetricName": "tma_int_divider",
+        "MetricThreshold": "tma_int_divider > 0.2 & tma_divider > 0.2 & tm=
a_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
@@ -1968,7 +4158,7 @@
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_int_operations",
         "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operation=
s > 0.6",
-        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain.",
+        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1977,8 +4167,8 @@
         "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_128@ + cpu_core@INT_V=
EC_RETIRED.VNNI_128@) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_128b",
-        "MetricThreshold": "tma_int_vector_128b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
-        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_256b, tma=
_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_int_vector_128b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_int_vector_256b, tma_port_0, tma_port_1,=
 tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1987,8 +4177,8 @@
         "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_256@ + cpu_core@INT_V=
EC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@) / (tma_retiring *=
 tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_256b",
-        "MetricThreshold": "tma_int_vector_256b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
-        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b,=
 tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_int_vector_256b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_port_0, tma_por=
t_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1997,28 +4187,28 @@
         "MetricExpr": "cpu_core@ICACHE_TAG.STALLS@ / tma_info_thread_clks"=
,
         "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS, FRONTEND_RETIRED.ITLB_MISS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 Data (L1D) cache",
         "MetricExpr": "max((cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L1D_MISS@) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
-        "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 data cache.  The L1 data cache typical=
ly has the shortest latency.  However; in certain cases like loads blocked =
on older stores; a load might suffer due to high latency even though it is =
being satisfied by the L1. Another example is loads who miss in the TLB. Th=
ese cases are characterized by execution unit stalls; while some non-comple=
ted demand load lives in the machine without having that demand load missin=
g the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.FB=
_HIT_PS. Related metrics: tma_clears_resteers, tma_machine_clears, tma_micr=
ocode_sequencer, tma_ms_switches, tma_ports_utilized_1",
+        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & =
tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics: t=
ma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_swi=
tches, tma_ports_utilized_1",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of cyc=
les with demand load accesses that hit the L1 cache",
+        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
         "MetricExpr": "min(2 * (cpu_core@MEM_INST_RETIRED.ALL_LOADS@ - cpu=
_core@MEM_LOAD_RETIRED.FB_HIT@ - cpu_core@MEM_LOAD_RETIRED.L1_MISS@) * 20 /=
 100, max(cpu_core@CYCLE_ACTIVITY.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVIT=
Y.CYCLES_L1D_MISS@, 0)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
-        "MetricName": "tma_l1_hit_latency",
-        "MetricThreshold": "tma_l1_hit_latency > 0.1 & (tma_l1_bound > 0.1=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles with demand load accesses that hit the L1 cache. The short latency of =
the L1 data cache may be exposed in pointer-chasing memory access patterns =
as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
+        "MetricName": "tma_l1_latency_dependency",
+        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & tma_l1_bound=
 > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache. The s=
hort latency of the L1D cache may be exposed in pointer-chasing memory acce=
ss patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2027,8 +4217,18 @@
         "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L1D_MISS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L2_MISS@) / tma_info_thread_clks",
         "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
+        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
+        "MetricExpr": "(min(cpu_core@MEM_LOAD_RETIRED.L2_HIT@ * cpu_core@m=
em_load_retired.l2_hit@R, cpu_core@MEM_LOAD_RETIRED.L2_HIT@ * (3 * tma_info=
_system_core_frequency)) if 0 < cpu_core@mem_load_retired.l2_hit@R else cpu=
_core@MEM_LOAD_RETIRED.L2_HIT@ * (3 * tma_info_system_core_frequency)) * (1=
 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ /=
 2) / tma_info_thread_clks",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
+        "MetricName": "tma_l2_hit_latency",
+        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L2 cache under unloaded scenarios (pos=
sibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 hit=
s) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2037,18 +4237,18 @@
         "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L2_MISS@ - cpu_cor=
e@MEMORY_ACTIVITY.STALLS_L3_MISS@) / tma_info_thread_clks",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
+        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
-        "MetricExpr": "cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * min(cpu_core@ME=
M_LOAD_RETIRED.L3_HIT@R, 9 * tma_info_system_core_frequency) * (1 + cpu_cor=
e@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_=
info_thread_clks",
+        "MetricExpr": "(min(cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * cpu_core@m=
em_load_retired.l3_hit@R, cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * (12 * tma_inf=
o_system_core_frequency) - 3 * tma_info_system_core_frequency) if 0 < cpu_c=
ore@mem_load_retired.l3_hit@R else cpu_core@MEM_LOAD_RETIRED.L3_HIT@ * (12 =
* tma_info_system_core_frequency) - 3 * tma_info_system_core_frequency) * (=
1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ =
/ 2) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
-        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_info_bottleneck_cache_memory_latency, tma_mem_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.05=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT. Related metrics: tma_b=
ottleneck_cache_memory_latency, tma_branch_resteers, tma_mem_latency, tma_s=
tore_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2057,19 +4257,19 @@
         "MetricExpr": "cpu_core@DECODE.LCP@ / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
-        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
+        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & tma=
_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. Related metr=
ics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidt=
h, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_info_=
inst_mix_iptb",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations , instructions that require =
no more than one uop (micro-operation)",
         "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_light_operations",
         "MetricThreshold": "tma_light_operations > 0.6",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UopPI met=
ric) ratio of 1 or less should be expected for decently optimized code runn=
ing on Intel Core/Xeon products. While this often indicates efficient X86 i=
nstructions were executed; high value does not necessarily mean better perf=
ormance cannot be achieved. ([ICL+] Note this may undercount due to approxi=
mation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIS=
T",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations , instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UopPI metr=
ic) ratio of 1 or less should be expected for decently optimized code runni=
ng on Intel Core/Xeon products. While this often indicates efficient X86 in=
structions were executed; high value does not necessarily mean better perfo=
rmance cannot be achieved. ([ICL+] Note this may undercount due to approxim=
ation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIST=
",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2088,7 +4288,7 @@
         "MetricExpr": "max(0, tma_dtlb_load - tma_load_stlb_miss)",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_hit",
-        "MetricThreshold": "tma_load_stlb_hit > 0.05 & (tma_dtlb_load > 0.=
1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
+        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0.1=
 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2097,16 +4297,43 @@
         "MetricExpr": "cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@ / tma_info_t=
hread_clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_miss",
-        "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
+        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > 0.=
1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_1G@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_core@D=
TLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_COMP=
LETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_1g",
+        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_2M_4M@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_C=
OMPLETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_2m",
+        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * cpu_core@DTLB_LOAD_MISSES.WALK=
_COMPLETED_4K@ / (cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED_4K@ + cpu_core@D=
TLB_LOAD_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_LOAD_MISSES.WALK_COMP=
LETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_4k",
+        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
-        "MetricExpr": "cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ * cpu_core@ME=
M_INST_RETIRED.LOCK_LOADS@R / tma_info_thread_clks",
-        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
+        "MetricExpr": "cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ * cpu_core@me=
m_inst_retired.lock_loads@R / tma_info_thread_clks",
+        "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
-        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 & =
tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2117,7 +4344,7 @@
         "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_lsd",
         "MetricThreshold": "tma_lsd > 0.15 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure.",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to LSD (Loop Stream Detector) unit. =
 LSD typically does well sustaining Uop supply. However; in some rare cases=
; optimal uop-delivery could not be reached for small loops whose size (in =
terms of number of uops) does not suit well the LSD structure",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2128,17 +4355,17 @@
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_sh=
aring, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote_c=
ache",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Machine Clears.  These slots are either wasted by uo=
ps fetched prior to the clear; or stalls the out-of-order portion of the ma=
chine needs to recover its state after the clear. For example; this can hap=
pen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Modif=
ying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics: =
tma_bottleneck_memory_synchronization, tma_clears_resteers, tma_contested_a=
ccesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode_s=
equencer, tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
-        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks"=
,
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
-        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_fb_full, tma_info_bottleneck_cache=
_memory_bandwidth, tma_info_system_dram_bw_use, tma_sq_full",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_sq_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2147,34 +4374,34 @@
         "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_thread_clks - tm=
a_mem_bandwidth",
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
-        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_info_bottleneck_cache_memory_latency, tma_l3_hit_la=
tency",
+        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_latency=
",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
-        "MetricExpr": "cpu_core@topdown\\-mem\\-bound@ / (cpu_core@topdown=
\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiri=
ng@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
         "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend_b=
ound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * cpu_core@MISC2_RETIRED.LFENCE@ / tma_info_thre=
ad_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_memory_fence",
-        "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_memory_fence > 0.05 & tma_serializing_oper=
ation > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations , uops for memory load or store ac=
cesses",
         "MetricExpr": "tma_light_operations * cpu_core@MEM_UOP_RETIRED.ANY=
@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_memory_operations",
@@ -2188,7 +4415,7 @@
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operatio=
ns_group;tma_issueMC;tma_issueMS",
         "MetricName": "tma_microcode_sequencer",
         "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_ope=
rations > 0.1",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_clears_reste=
ers, tma_info_bottleneck_irregular_overhead, tma_l1_bound, tma_machine_clea=
rs, tma_ms_switches",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_bottleneck_i=
rregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clears, t=
ma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2197,8 +4424,8 @@
         "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * cpu_=
core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
-        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_bad_spec_branch_misprediction_cost=
, tma_info_bottleneck_mispredictions",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch_r=
esteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_bottleneck_mispredictions, tma_branch_mispredicts, tma_info_bad=
_spec_branch_misprediction_cost",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2213,22 +4440,31 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued -- the Count D=
omain; [ADL+] cycles)",
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued , the Count Do=
main; [ADL+] cycles)",
         "MetricExpr": "160 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_thre=
ad_clks",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
         "MetricName": "tma_mixing_vectors",
         "MetricThreshold": "tma_mixing_vectors > 0.05",
-        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued -- the Count =
Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investiga=
ting. Read more in Appendix B1 of the Optimizations Guide for this topic. R=
elated metrics: tma_ms_switches",
+        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued , the Count D=
omain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investigat=
ing. Read more in Appendix B1 of the Optimizations Guide for this topic. Re=
lated metrics: tma_ms_switches",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details",
+        "MetricExpr": "max(cpu_core@IDQ.MS_CYCLES_ANY@, cpu_core@UOPS_RETI=
RED.MS\\,cmask\\=3D0x1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISS=
UED.ANY@)) / tma_info_core_core_clks / 2",
+        "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
+        "MetricName": "tma_ms",
+        "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ =
/ (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUED.ANY@) / tma_info_thr=
ead_clks",
+        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge=
\\=3D0x1@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUED.ANY@) / tm=
a_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
-        "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_clears_resteers, tma_info_bottleneck_irregular_overhead, tma_l1_bound, tm=
a_machine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializ=
ing_operation",
+        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: tm=
a_bottleneck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_mac=
hine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_o=
peration",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2238,7 +4474,7 @@
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2247,7 +4483,7 @@
         "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.NOP@ /=
 (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "BvBO;Pipeline;TopdownL4;tma_L4_group;tma_other_lig=
ht_ops_group",
         "MetricName": "tma_nop_instructions",
-        "MetricThreshold": "tma_nop_instructions > 0.1 & (tma_other_light_=
ops > 0.3 & tma_light_operations > 0.6)",
+        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_other_light_o=
ps > 0.3 & tma_light_operations > 0.6",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2263,20 +4499,20 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types)",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - cpu_core@BR_MISP_=
RETIRED.ALL_BRANCHES@ / (cpu_core@INT_MISC.CLEARS_COUNT@ - cpu_core@MACHINE=
_CLEARS.COUNT@)), 0.0001)",
         "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
-        "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_misp=
redicts > 0.1 & tma_bad_speculation > 0.15",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
         "MetricExpr": "max(tma_machine_clears * (1 - cpu_core@MACHINE_CLEA=
RS.MEMORY_ORDERING@ / cpu_core@MACHINE_CLEARS.COUNT@), 0.0001)",
         "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
-        "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
+        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears > =
0.1 & tma_bad_speculation > 0.15",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2286,7 +4522,7 @@
         "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_page_faults",
         "MetricThreshold": "tma_page_faults > 0.05",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost.",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2296,7 +4532,7 @@
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_int_vector_128b, tma_int_vector_256b, tma_port_1, tma_port_5, tma_po=
rt_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_12=
8b, tma_int_vector_256b, tma_port_1, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2306,7 +4542,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_ve=
ctor_256b, tma_port_0, tma_port_5, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_port_=
0, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2316,27 +4552,27 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_6. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_por=
t_5, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128=
b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_ports_utilized_2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU performance was potentially limited due to Core computation issues (non=
 divider-related)",
-        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (cp=
u_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_=
PORTS_UTIL\\,umask\\=3D0xc@)) / tma_info_thread_clks if cpu_core@ARITH.DIV_=
ACTIVE@ < cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOU=
ND_ON_LOADS@ else (cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu=
_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@) / tma_info_thread_clks)",
+        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (cp=
u_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.2_=
3_PORTS_UTIL@)) / tma_info_thread_clks if cpu_core@ARITH.DIV_ACTIVE@ < cpu_=
core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ e=
lse (cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTI=
VITY.2_3_PORTS_UTIL@) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
-        "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
+        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_bound =
> 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "max((cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + max=
(cpu_core@RS.EMPTY_RESOURCE@ - cpu_core@RESOURCE_STALLS.SCOREBOARD@, 0)) / =
tma_info_thread_clks, 1) * (cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_cor=
e@EXE_ACTIVITY.BOUND_ON_LOADS@) / tma_info_thread_clks",
+        "MetricExpr": "max(cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ - cpu_=
core@RESOURCE_STALLS.SCOREBOARD@, 0) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
-        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2345,7 +4581,7 @@
         "MetricExpr": "cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
-        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the CPU executed total of 1 uop per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise). This can be=
 due to heavy data-dependency among software instructions; or over oversubs=
cribing a particular hardware resource. In some other cases with high 1_Por=
t_Utilized and L1_Bound; this metric can point to L1 data-cache latency bot=
tleneck that may not necessarily manifest with complete execution starvatio=
n (due to the short L1 latency e.g. walking a linked list) - looking at the=
 assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL. Related m=
etrics: tma_l1_bound",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2356,8 +4592,8 @@
         "MetricExpr": "cpu_core@EXE_ACTIVITY.2_PORTS_UTIL@ / tma_info_thre=
ad_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
-        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma=
_int_vector_256b, tma_port_0, tma_port_1, tma_port_6",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2367,14 +4603,23 @@
         "MetricExpr": "cpu_core@UOPS_EXECUTED.CYCLES_GE_3@ / tma_info_thre=
ad_clks",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by (indirect) RET instruction=
s",
+        "MetricExpr": "cpu_core@BR_MISP_RETIRED.RET_COST@ * cpu_core@br_mi=
sp_retired.ret_cost@R / tma_info_thread_clks",
+        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricName": "tma_ret_mispredicts",
+        "MetricThreshold": "tma_ret_mispredicts > 0.05 & tma_branch_mispre=
dicts > 0.1 & tma_bad_speculation > 0.15",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
-        "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-=
fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@=
 + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
         "MetricGroup": "BvUW;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -2388,7 +4633,7 @@
         "MetricExpr": "cpu_core@RESOURCE_STALLS.SCOREBOARD@ / tma_info_thr=
ead_clks + tma_c02_wait",
         "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_bou=
nd_group;tma_issueSO",
         "MetricName": "tma_serializing_operation",
-        "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_bo=
und > 0.1 & tma_backend_bound > 0.2)",
+        "MetricThreshold": "tma_serializing_operation > 0.1 & tma_core_bou=
nd > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2398,8 +4643,8 @@
         "MetricExpr": "tma_light_operations * cpu_core@INT_VEC_RETIRED.SHU=
FFLES@ / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_other_ligh=
t_ops_group",
         "MetricName": "tma_shuffles_256b",
-        "MetricThreshold": "tma_shuffles_256b > 0.1 & (tma_other_light_ops=
 > 0.3 & tma_light_operations > 0.6)",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers.",
+        "MetricThreshold": "tma_shuffles_256b > 0.1 & tma_other_light_ops =
> 0.3 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2409,38 +4654,38 @@
         "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.PAUSE@ / tma_info_thread_=
clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
-        "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_slow_pause > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
-        "MetricExpr": "cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ * min(cpu_co=
re@MEM_INST_RETIRED.SPLIT_LOADS@R, tma_info_memory_load_miss_real_latency) =
/ tma_info_thread_clks",
+        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ * cpu_c=
ore@mem_inst_retired.split_loads@R, cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ =
* tma_info_memory_load_miss_real_latency) if 0 < cpu_core@mem_inst_retired.=
split_loads@R else cpu_core@MEM_INST_RETIRED.SPLIT_LOADS@ * tma_info_memory=
_load_miss_real_latency) / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
-        "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
+        "MetricThreshold": "tma_split_loads > 0.3",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "cpu_core@MEM_INST_RETIRED.SPLIT_STORES@ * min(cpu_c=
ore@MEM_INST_RETIRED.SPLIT_STORES@R, 1) / tma_info_thread_clks",
+        "MetricExpr": "(min(cpu_core@MEM_INST_RETIRED.SPLIT_STORES@ * cpu_=
core@mem_inst_retired.split_stores@R, cpu_core@MEM_INST_RETIRED.SPLIT_STORE=
S@) if 0 < cpu_core@mem_inst_retired.split_stores@R else cpu_core@MEM_INST_=
RETIRED.SPLIT_STORES@) / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
-        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
+        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0.2=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
         "MetricExpr": "(cpu_core@XQ.FULL_CYCLES@ + cpu_core@L1D_PEND_MISS.=
L2_STALLS@) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
+        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
-        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_bottleneck_cache_memory_bandwidth, tma_info_system_dram_bw_use, =
tma_mem_bandwidth",
+        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tma_=
memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_mem_bandwidth",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2449,8 +4694,8 @@
         "MetricExpr": "cpu_core@EXE_ACTIVITY.BOUND_ON_STORES@ / tma_info_t=
hread_clks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
-        "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS",
+        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2459,18 +4704,18 @@
         "MetricExpr": "13 * cpu_core@LD_BLOCKS.STORE_FORWARD@ / tma_info_t=
hread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
-        "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
+        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricExpr": "(cpu_core@MEM_STORE_RETIRED.L2_HIT@ * 10 * (1 - cpu=
_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.ALL_STORES@)=
 + (1 - cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.A=
LL_STORES@) * min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO@)) / tma_info_thread_clks",
-        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
issueRFO;tma_issueSL;tma_store_bound_group",
+        "MetricGroup": "BvML;LockCont;MemoryLat;Offcore;TopdownL4;tma_L4_g=
roup;tma_issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
-        "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
+        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma_l=
3_hit_latency, tma_lock_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2489,7 +4734,7 @@
         "MetricExpr": "max(0, tma_dtlb_store - tma_store_stlb_miss)",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_hit",
-        "MetricThreshold": "tma_store_stlb_hit > 0.05 & (tma_dtlb_store > =
0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2)))",
+        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store > 0=
.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > =
0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2498,7 +4743,34 @@
         "MetricExpr": "cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@ / tma_info_=
core_core_clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_miss",
-        "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
+        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store > =
0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_1G@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.WALK=
_COMPLETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_1g",
+        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_2M_4M@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_=
core@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.W=
ALK_COMPLETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_2m",
+        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * cpu_core@DTLB_STORE_MISSES.WA=
LK_COMPLETED_4K@ / (cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED_4K@ + cpu_cor=
e@DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M@ + cpu_core@DTLB_STORE_MISSES.WALK=
_COMPLETED_1G@)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_4k",
+        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2507,7 +4779,7 @@
         "MetricExpr": "9 * cpu_core@OCR.STREAMING_WR.ANY_RESPONSE@ / tma_i=
nfo_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
         "MetricName": "tma_streaming_stores",
-        "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_streaming_stores > 0.2 & tma_store_bound >=
 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: tma=
_fb_full",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2517,7 +4789,7 @@
         "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / tma_info=
_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
         "MetricName": "tma_unknown_branches",
-        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_reste=
ers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
@@ -2527,8 +4799,8 @@
         "MetricExpr": "tma_retiring * cpu_core@UOPS_EXECUTED.X87@ / cpu_co=
re@UOPS_EXECUTED.THREAD@",
         "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
         "MetricName": "tma_x87_use",
-        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
+        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma_l=
ight_operations > 0.6",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     }
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/other.json b/tools/p=
erf/pmu-events/arch/x86/meteorlake/other.json
index 53d23d8decc6..46a21776a4e9 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/other.json
@@ -1,4 +1,14 @@
 [
+    {
+        "BriefDescription": "Count all other hardware assists or traps tha=
t are not necessarily architecturally exposed (through a software handler) =
beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-eve=
nts. the event also counts for Machine Ordering count.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc1",
+        "EventName": "ASSISTS.HARDWARE",
+        "PublicDescription": "Count all other hardware assists or traps th=
at are not necessarily architecturally exposed (through a software handler)=
 beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-ev=
ents.  This includes, but not limited to, assists at EXE or MEM uop writeba=
ck like AVX* load/store/gather/scatter (non-FP GSSE-assist ) , assists gene=
rated by ROB like PEBS and RTIT, Uncore trap, RAR (Remote Action Request) a=
nd CET (Control flow Enforcement Technology) assists. the event also counts=
 for Machine Ordering count.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "ASSISTS.PAGE_FAULT",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -18,6 +28,28 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -95,6 +127,28 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.FULL_STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x800000010000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that have any type of response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.PARTIAL_STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x400000010000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/meteorlake/pipeline.json
index bc806c7330f4..265f6c5a0248 100644
--- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
@@ -1,6 +1,6 @@
 [
     {
-        "BriefDescription": "Counts the number of cycles when any of the d=
ividers are active.",
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point or integer dividers are active.",
         "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xcd",
@@ -54,7 +54,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts all branch instructions retired.",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
@@ -73,7 +72,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PEBS": "1",
         "PublicDescription": "Counts conditional branch instructions retir=
ed.",
         "SampleAfterValue": "400009",
         "UMask": "0x11",
@@ -84,7 +82,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts not taken branch instructions retired=
.",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
@@ -104,7 +101,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
@@ -124,7 +120,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PEBS": "1",
         "PublicDescription": "Counts far branch instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x40",
@@ -144,7 +139,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PEBS": "1",
         "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
@@ -159,6 +153,15 @@
         "UMask": "0xfb",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP branch=
 instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xef",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -183,7 +186,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PEBS": "1",
         "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x2",
@@ -203,23 +205,48 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PEBS": "1",
         "PublicDescription": "Counts return instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc0",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Taken branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken branch instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_CALL",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfd",
+        "Unit": "cpu_atom"
+    },
+    {
+        "BriefDescription": "Counts the number of near relative JMP branch=
 instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -234,7 +261,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts all the retired branch instructions t=
hat were mispredicted by the processor. A branch misprediction occurs when =
the processor incorrectly predicts the destination of the branch.  When the=
 misprediction is discovered at execution, all the instructions executed in=
 the wrong (speculative) path must be discarded, and the processor must sta=
rt fetching from the correct path.",
         "SampleAfterValue": "400009",
         "Unit": "cpu_core"
@@ -244,7 +270,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x44",
         "Unit": "cpu_core"
@@ -263,7 +288,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PEBS": "1",
         "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x11",
@@ -274,7 +298,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x51",
         "Unit": "cpu_core"
@@ -284,7 +307,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
         "SampleAfterValue": "400009",
         "UMask": "0x10",
@@ -295,7 +317,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x50",
         "Unit": "cpu_core"
@@ -314,7 +335,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1",
@@ -325,7 +345,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x41",
         "Unit": "cpu_core"
@@ -344,7 +363,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PEBS": "1",
         "PublicDescription": "Counts miss-predicted near indirect branch i=
nstructions retired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80",
@@ -364,7 +382,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
         "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) CALL instructions, including both register and memory indirect.",
         "SampleAfterValue": "400009",
         "UMask": "0x2",
@@ -375,7 +392,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x42",
         "Unit": "cpu_core"
@@ -385,11 +401,19 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_COST",
-        "PEBS": "1",
         "SampleAfterValue": "100003",
         "UMask": "0xc0",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xef",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -404,7 +428,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
         "SampleAfterValue": "400009",
         "UMask": "0x20",
@@ -415,7 +438,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN_COST",
-        "PEBS": "1",
         "SampleAfterValue": "400009",
         "UMask": "0x60",
         "Unit": "cpu_core"
@@ -425,7 +447,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PEBS": "1",
         "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8",
@@ -445,7 +466,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET_COST",
-        "PEBS": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x48",
         "Unit": "cpu_core"
@@ -771,7 +791,6 @@
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
         "Unit": "cpu_atom"
@@ -780,7 +799,6 @@
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
@@ -799,7 +817,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "Unit": "cpu_core"
@@ -809,7 +826,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x10",
         "Unit": "cpu_core"
@@ -819,7 +835,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired NOP or ENDBR32/64 or PREF=
ETCHIT0/1 instructions",
         "SampleAfterValue": "2000003",
         "UMask": "0x2",
@@ -829,7 +844,6 @@
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
-        "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1",
@@ -840,7 +854,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
-        "PEBS": "1",
         "PublicDescription": "Number of iterations of Repeat (REP) string =
retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word, a=
nd doubleword version and string instructions can be repeated using a repet=
ition prefix, REP, that allows their architectural execution to be repeated=
 a number of times as specified by the RCX register. Note the number of ite=
rations is implementation-dependent.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
@@ -1176,6 +1189,16 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa2",
+        "EventName": "RESOURCE_STALLS.SB",
+        "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x8",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
         "Counter": "0,1,2,3,4,5,6,7",
--=20
2.48.1.362.g079036d154-goog

