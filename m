Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F3D1E5B9E
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920043; cv=none; b=jumzkmXODNramUHumnUoHVsnYfLXPU9DPuHzytkNGKUxT10WHBFlEcm3c6kHnwh4+FGP9fp7nksyqB/gPkkv2XMn/MVDMup9TYjbX2zWHBs0ns0vnMgQMdJlu1acSA/7+UiH1xn2cdsO+Q+aAP958NPEvouBNqE3nq7PsyX1ia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920043; c=relaxed/simple;
	bh=ctFqUDQckKzVSG33T+IsdXdx8dTadzpOv0SmZRQHLw8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cpdYuQUpxphynm0A7g+uHfckyt1R/WLgf8BMxvLHOYct2iMB8M/UstfAn9uWwEkdrYsxcoZyE0BxTyxpLLrcs7hdbwslwXpMTqV281/y1ZAOIilWydbezsD4MEZToFzILWTeOk2DMkqF8rNc2uGKKsJfF/rFfpziDWFjhOFe/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/ZV/zQ+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/ZV/zQ+"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e582bfcada6so9064188276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742920040; x=1743524840; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCeVNN7TIWImHS0j62KJ6VLYzh9l1k/vX/z1AR1Qmr4=;
        b=f/ZV/zQ+ovbyEkhqbUqyfVy9b2P5eSaJ9q9i37qa7x+YwtTKyKs+lQhcnasgzObc5W
         Cq8ntrYJ/wyQPbjfuxXwRJ0h4tzehBHEndAWm5/kguBFCgkQKvn6wNLwqp2ZCzS37/tY
         4yfy8GBIR5u0t7kC4Yi7bH8kYDjwwgpjtx8HIx5svAQ3YLlJPcFA72y6S6XmTdWy8b3i
         Mf7S6Fdovj77rK77KaNfJEPRO7BTwCUbaHcKNRFPS2RcUmf9enpvAcA8GQldpGeg1/CL
         qXoN51xI5YgXugsrqjP+SyeTDxX7rgODD/Ja/DJcxsayhQX3t9721A6kRR5NEhqsB1M7
         QiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920040; x=1743524840;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hCeVNN7TIWImHS0j62KJ6VLYzh9l1k/vX/z1AR1Qmr4=;
        b=hnuj2/MV4LnazqAFz/6A/qwr76B0buCtjSIp1IvLJosOjlkE3K5FNZAh2lWkzUuCQE
         TGefolpc1B4uKViPJA1b7uWW9tAEto9MWUkqWQp9ug84TX9/syiM+biPLvgEOU8Q0cHR
         vhpGOTQQC90iq2HKFypVlFkOV3FC0GW4Ky+8RixT3HnkjnO2X1wL412hGM1PWrWpH1XF
         7SCfsgJ9qYaY9OIbxstXJI5IRcApSuSqf/Nd+ikuP8wTrOocY4X/CkTnlKzVd0wLLq4L
         2MsC2h4kCknpuMR4f4jLdiy9QlZnBk3ZXBrhjrFK8LX93ZfHSCeCKnqfcL/TyLwmeGO2
         xvxg==
X-Forwarded-Encrypted: i=1; AJvYcCUmMdBFSXw1K5abhhC3/a4BZfTEkxcRTlblK9w8VNfhQxASrrAkW8xzd80QA3koxe9oEM83l8YFSnj0TrFOjW7d@vger.kernel.org
X-Gm-Message-State: AOJu0YyHAYw3r59V6ANNWDcrKOih4V3b6kA3ibQLeK2xaqi+an8krC3/
	9uFQBuRYCLHDSTPUOfAiWxsYLR0LMIkMShdhls8eKt5UaR/Y/ncvewEA6jvF/C/WrqwddvLEoc9
	mcGuECg==
X-Google-Smtp-Source: AGHT+IE5TTaHBDLZkoDO9QAvBKLaNncXgVzrVYcfyXsH0BTCj5VnP9qydhGKNFDriW5OwDShr94cf2zeagqv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a25:8246:0:b0:e63:f8c1:70e7 with SMTP id
 3f1490d57ef6-e66a4fccd43mr11962276.6.1742920039728; Tue, 25 Mar 2025 09:27:19
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:15:04 -0700
In-Reply-To: <20250325151511.13628-1-irogers@google.com>
Message-Id: <20250325151511.13628-29-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250325151511.13628-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 28/35] perf vendor events: Update sierraforest events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.08 to v1.09.
Update event topics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/sierraforest/cache.json          |  20 ++
 .../arch/x86/sierraforest/memory.json         |  20 ++
 .../arch/x86/sierraforest/other.json          |  48 ----
 .../arch/x86/sierraforest/pipeline.json       |   8 +
 .../arch/x86/sierraforest/uncore-cache.json   |  32 +++
 .../arch/x86/sierraforest/uncore-memory.json  | 240 ++++++++++++++++++
 7 files changed, 321 insertions(+), 49 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 0c16c9b840a5..bde2f32423a1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,7 @@ GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.25,sapphirerapids,core
-GenuineIntel-6-AF,v1.08,sierraforest,core
+GenuineIntel-6-AF,v1.09,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.36,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json b/tools=
/perf/pmu-events/arch/x86/sierraforest/cache.json
index 072df00aff92..21671c65d6dd 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
@@ -466,6 +466,16 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -486,6 +496,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/memory.json b/tool=
s/perf/pmu-events/arch/x86/sierraforest/memory.json
index 22d23077618e..3e2d0b565cfa 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/memory.json
@@ -82,6 +82,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/other.json b/tools=
/perf/pmu-events/arch/x86/sierraforest/other.json
index 4c77dac8ec78..daa16030d493 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/other.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/other.json
@@ -8,46 +8,6 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x730000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -57,13 +17,5 @@
         "MSRValue": "0x10800",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0x75",
-        "EventName": "SERIALIZATION.C01_MS_SCB",
-        "SampleAfterValue": "200003",
-        "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/sierraforest/pipeline.json
index df2c7bb474a0..a934b64f66d0 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
@@ -300,6 +300,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.C01_MS_SCB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend because allocation is stalled due to a mispredict=
ed jump or a machine clear. [This event is alias to TOPDOWN_BAD_SPECULATION=
.ALL_P]",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json =
b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
index a779a1a73ea5..7182ca00ef8d 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
@@ -873,6 +873,38 @@
         "UMask": "0x1",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Counts snoop filter capacity evictions for en=
tries tracking exclusive lines in the cores? cache.? Snoop filter capacity =
evictions occur when the snoop filter is full and evicts an existing entry =
to track a new entry.? Does not count clean evictions such as when a core?s=
 cache replaces a tracked cacheline with a new cacheline.",
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
tries tracking modified lines in the cores? cache.? Snoop filter capacity e=
victions occur when the snoop filter is full and evicts an existing entry t=
o track a new entry.? Does not count clean evictions such as when a core?s =
cache replaces a tracked cacheline with a new cacheline.",
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
tries tracking shared lines in the cores? cache.? Snoop filter capacity evi=
ctions occur when the snoop filter is full and evicts an existing entry to =
track a new entry.? Does not count clean evictions such as when a core?s ca=
che replaces a tracked cacheline with a new cacheline.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x3d",
+        "EventName": "UNC_CHA_SF_EVICTION.S_STATE",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Snoop Filter Capacity Evictions : S state",
+        "UMask": "0x4",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "All TOR Inserts",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json=
 b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
index ae9c62b32e92..c7e9dbe02eb0 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
@@ -188,6 +188,94 @@
         "PublicDescription": "DRAM Clockticks",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "# of cycles MR4 temp readings forced 2x refre=
sh",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xA7",
+        "EventName": "UNC_M_MR4_2XREF_CYCLES.SCH0_DIMM0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
         "Counter": "0,1,2,3",
@@ -286,6 +374,70 @@
         "PublicDescription": "-",
         "Unit": "IMC"
     },
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
     {
         "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
         "Counter": "0,1,2,3",
@@ -480,6 +632,94 @@
         "UMask": "0x1",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "# of cycles Throttling at Critical level on s=
pecified DIMM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT0",
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
+        "EventName": "UNC_M_THROTTLE_CRIT_CYCLES.SLOT1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
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
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "Write Pending Queue Allocations",
         "Counter": "0,1,2,3",
--=20
2.49.0.395.g12beb8f557-goog

