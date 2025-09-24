Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE625A34F
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693784; cv=none; b=gEnQ35ByWkLLT0Fry4x+WwMgvBCQoDcujSNK1mfkR3lQwjUIHIx72/q+Y+wxk7pJxSI1cV6yKJgDAe5V/+QUccsM3AsJEp8hUK/Qph66mzM42BdfaZCv5LTkIZNhkGKWDevyEb3+uKcME8+yvP2q0iulY/ImMRIPwJuDn8bnq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693784; c=relaxed/simple;
	bh=0T/mQGsjbLGtsHHweTa2tqGJAYZ5w6JqT7T8kgjUNxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=C40+m+KsWjphb/hbQR1PJZ2uyIQxuU2xfiIVAK2saGZUyhmALmBZT3dqP5IGfGqnBuGsylBo3EKfQ0qU8WKvPvFG/G8LVxowYvbslrS/fDDX6npTfwiSS3hRfcuKoQl00PjmJLYYnin2exSoQ5THR8rQJWANwBIz8A0WMJrMxno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+he992T; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+he992T"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so4498644a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 23:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758693781; x=1759298581; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uGeRT1nbXUsvz4XSKOwWMZaciPaY+TsA3/094LmJ3A=;
        b=j+he992TLoFbzbcY5W6gNllpdFQZ+WryEnQe25RPnev5szRh22sUt8u6zWDosSJ5aA
         bMlinB0oDovcfbI8Wke2mX3/6t8JqaQsDUgb1ZMwwO+OswAaE1WFZ3q2LDm+scPgERvj
         p9NbBeTAfaSqzmTHg45j4lX1b6Dzn68iRSxlqksBarB0rUOQD7pGuCRQtfsvaVHYmrP+
         C2jiDVmlTjeR82Rx76tIoilSdIp8okHz/kOCGT1GAADfkCflO56YxJUGt7cSfPbGmFEc
         uQzbNzphTQkRSgvHRlb6t9tQquvfI1Dd8tE2uKvjgjp1e3q8PaDi1MB8uOW4pVG+4zFA
         WY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693781; x=1759298581;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/uGeRT1nbXUsvz4XSKOwWMZaciPaY+TsA3/094LmJ3A=;
        b=dzLteMRy3SP0qoVgJG3Jf1tRqwWQvFo6zgoe5gKwYKUlAjGpHFMBDqtwr54+QNq0WM
         4uZNkkQyvDrSHpvZky1TH+flhM8Ati0kRDDvX+uWLt3rHyvbL40DFLCmt0qvfHyNjpxJ
         DlOdt1OeXCA6bzAYV1YKy5MACLC/d2F0oCcmg7BZ+MzPlU8Cgya6HKrMeQTo1QIgN5P2
         HaWB4IzMTJCRO4U3WfK75zaO4TuRukpHBjg+fcQvnsykS9X/l3+oKdyI51PCfI5xC0V3
         gul377voF3rkZo7g+ipxYabmWQ9x2dWR/ckLHiXObv7n7lDsQx7nk0UY1sj0zFbsNp5f
         DHXA==
X-Forwarded-Encrypted: i=1; AJvYcCXohWpZrRxS4LMrIm0ZauxMEqJIMffT5BOxaJ+KIcfGCpSmkfHnDVM6QANoJGsqRcMpoxnhwffufOQx068tBuwF@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSIMcFoVGQK/k30rA8SeDADrCdkWwddUtAzqSaHz6Bl8QpgnP
	CFHtw+5KOL0xKaz10XbPezY07KLZdzZ7S9s9yZCnO+IlpCpv+6+coRTMwVykTfplsm3f6M2gIbA
	+pXJJloO0oQ==
X-Google-Smtp-Source: AGHT+IGOU2pDh5XCUTrOEydHZMbt4623364kDp1ibS/wEH99C+nLNCLrYxz8wqugmAq4fQafnMSMtHNsyLyd
X-Received: from plby5.prod.google.com ([2002:a17:902:ed45:b0:267:d14f:81f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54f:b0:246:cfc4:9a30
 with SMTP id d9443c01a7336-27cc79ca662mr64581195ad.35.1758693781059; Tue, 23
 Sep 2025 23:03:01 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:02:29 -0700
In-Reply-To: <20250924060229.375718-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060229.375718-11-irogers@google.com>
Subject: [PATCH v1 10/10] perf vendor events intel: Update sierraforest events
 to v1.12
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update sierraforest events to v1.12 released in:
https://github.com/intel/perfmon/commit/8279984b0b2eef35412c0281983ef59ae74=
f19ed

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/sierraforest/cache.json          |  61 +++++++++--
 .../x86/sierraforest/uncore-interconnect.json |  10 +-
 .../arch/x86/sierraforest/uncore-io.json      |   1 -
 .../arch/x86/sierraforest/uncore-memory.json  | 103 ++++++++++++------
 5 files changed, 133 insertions(+), 44 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 3938555d661e..32093bded949 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -30,7 +30,7 @@ GenuineIntel-6-CC,v1.00,pantherlake,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.35,sapphirerapids,core
-GenuineIntel-6-AF,v1.11,sierraforest,core
+GenuineIntel-6-AF,v1.12,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.37,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json b/tools=
/perf/pmu-events/arch/x86/sierraforest/cache.json
index 877052db1490..b2650e8ae252 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
@@ -162,6 +162,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
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
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the local cache=
s. If the core has access to an L3 cache, an LLC miss refers to an L3 cache=
 miss, otherwise it is an L2 cache miss.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -178,6 +186,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x80"
     },
+    {
+        "BriefDescription": "Counts the total number of load ops retired t=
hat miss the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -186,6 +202,31 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in a Remote DRAM",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM_OR_NOFWD",
+        "PublicDescription": "Counts the number of load ops retired that m=
iss the L3 cache and hit in a Remote DRAM, OR had a Remote snoop miss/no fw=
d and hit in the Local Dram",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in a Remote Cache and modified data was forwarded",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd3",
+        "EventName": "MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD_HITM",
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
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that hi=
t the L1 data cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -286,7 +327,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
@@ -297,7 +338,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -308,7 +349,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -319,7 +360,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
@@ -330,7 +371,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -341,7 +382,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -352,7 +393,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -363,7 +404,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -374,7 +415,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -385,7 +426,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled.",
-        "Counter": "0,1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnec=
t.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.js=
on
index 952b6de3fefc..251e5d20fefe 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
@@ -839,11 +839,19 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x1F",
         "EventName": "UNC_I_MISC1.LOST_FWD",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x10",
         "Unit": "IRP"
     },
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
     {
         "BriefDescription": "Snoop Hit E/S responses",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json b/t=
ools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
index f4f956966e16..2ea2637df3fb 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
@@ -1321,7 +1321,6 @@
         "FCMask": "0x01",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "PublicDescription": "-",
         "UMask": "0x4",
         "Unit": "IIO"
     },
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json=
 b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
index c7e9dbe02eb0..a9fd7a34b24b 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
@@ -56,6 +56,33 @@
         "UMask": "0xcf",
         "Unit": "IMC"
     },
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
     {
         "BriefDescription": "CAS count for SubChannel 0 regular reads",
         "Counter": "0,1,2,3",
@@ -74,6 +101,15 @@
         "UMask": "0xc4",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "CAS count for SubChannel 0 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_M_CAS_COUNT_SCH0.RD_UNDERFILL_ALL",
+        "PerPkg": "1",
+        "UMask": "0xcc",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "CAS count for SubChannel 0, all writes",
         "Counter": "0,1,2,3",
@@ -121,6 +157,33 @@
         "UMask": "0xcf",
         "Unit": "IMC"
     },
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
     {
         "BriefDescription": "CAS count for SubChannel 1 regular reads",
         "Counter": "0,1,2,3",
@@ -139,6 +202,15 @@
         "UMask": "0xc4",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "CAS count for SubChannel 1 underfill reads",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x06",
+        "EventName": "UNC_M_CAS_COUNT_SCH1.RD_UNDERFILL_ALL",
+        "PerPkg": "1",
+        "UMask": "0xcc",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "CAS count for SubChannel 1, all writes",
         "Counter": "0,1,2,3",
@@ -195,7 +267,6 @@
         "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -206,7 +277,6 @@
         "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -217,7 +287,6 @@
         "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x4",
         "Unit": "IMC"
     },
@@ -228,7 +297,6 @@
         "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH1_DIMM1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x8",
         "Unit": "IMC"
     },
@@ -239,7 +307,6 @@
         "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -250,7 +317,6 @@
         "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH0_DIMM1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -261,7 +327,6 @@
         "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x4",
         "Unit": "IMC"
     },
@@ -272,7 +337,6 @@
         "EventName": "UNC_M_PDC_MR4ACTIVE_CYCLES.SCH1_DIMM1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x8",
         "Unit": "IMC"
     },
@@ -283,7 +347,6 @@
         "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -294,7 +357,6 @@
         "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -305,7 +367,6 @@
         "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK2",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x4",
         "Unit": "IMC"
     },
@@ -316,7 +377,6 @@
         "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK3",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x8",
         "Unit": "IMC"
     },
@@ -327,7 +387,6 @@
         "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x10",
         "Unit": "IMC"
     },
@@ -338,7 +397,6 @@
         "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x20",
         "Unit": "IMC"
     },
@@ -349,7 +407,6 @@
         "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK2",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x40",
         "Unit": "IMC"
     },
@@ -360,7 +417,6 @@
         "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK3",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x80",
         "Unit": "IMC"
     },
@@ -371,7 +427,6 @@
         "EventName": "UNC_M_POWER_CHANNEL_PPD_CYCLES",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "Unit": "IMC"
     },
     {
@@ -381,7 +436,6 @@
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES.SLOT0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -392,7 +446,6 @@
         "EventName": "UNC_M_POWER_CRITICAL_THROTTLE_CYCLES.SLOT1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -423,7 +476,6 @@
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.MR4BLKEN",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x8",
         "Unit": "IMC"
     },
@@ -434,7 +486,6 @@
         "EventName": "UNC_M_POWER_THROTTLE_CYCLES.RAPLBLK",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x4",
         "Unit": "IMC"
     },
@@ -617,7 +668,6 @@
         "EventName": "UNC_M_SELF_REFRESH.ENTER_SUCCESS",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "UNC_M_SELF_REFRESH.ENTER_SUCCESS",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -628,7 +678,6 @@
         "EventName": "UNC_M_SELF_REFRESH.ENTER_SUCCESS_CYCLES",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -639,7 +688,6 @@
         "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -650,7 +698,6 @@
         "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -661,7 +708,6 @@
         "EventName": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -672,7 +718,6 @@
         "EventName": "UNC_M_THROTTLE_HIGH_CYCLES.SLOT1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -683,7 +728,6 @@
         "EventName": "UNC_M_THROTTLE_LOW_CYCLES.SLOT0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -694,7 +738,6 @@
         "EventName": "UNC_M_THROTTLE_LOW_CYCLES.SLOT1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x2",
         "Unit": "IMC"
     },
@@ -705,7 +748,6 @@
         "EventName": "UNC_M_THROTTLE_MID_CYCLES.SLOT0",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x1",
         "Unit": "IMC"
     },
@@ -716,7 +758,6 @@
         "EventName": "UNC_M_THROTTLE_MID_CYCLES.SLOT1",
         "Experimental": "1",
         "PerPkg": "1",
-        "PublicDescription": "-",
         "UMask": "0x2",
         "Unit": "IMC"
     },
--=20
2.51.0.534.gc79095c0ca-goog

