Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E11D95B4
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Mar 2025 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742625315; cv=none; b=IiNx/Ag4KVtbC47uLEm3RewbXWthUkqGbG6bQ207C+03JUcg/bIlqtcfrPymVIXoL08L5XWD+sLu0fMr9hc9PccYoSBwv0gu/ZqKZMCdNhQ/hXGjmQ/qzAJMKJ13uHjOHTgC85Ah7yVVxwOldPKvvgSnTuxR2xzmLuIdoSgZ1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742625315; c=relaxed/simple;
	bh=VUw1fcLNkQyTdRlLD33gHLlCXcSYtZHb3F8Y5x/zUf0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eRmYE0MNWgkhPScm18iJBMn3yyrtJxVEcyosz/wjDHz6PbJmbUMbbZvORVEVHiFrhjvlKzNHvEPEgHmECtvGDksbgGPgp2xx7YFHzLMyA4pTlF9JQBGv/FY+z5GhTaWC7rE4Eq/xaBubw6iY4c60bSsdZT+10sH/eJQ1KtU10uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbREq6d1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbREq6d1"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f3ff1ff117so32347117b3.0
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Mar 2025 23:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742625296; x=1743230096; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q2wBK9I1dTSU9BJYYyCMSSg8VMlpEyof7o+h6tqNxVI=;
        b=cbREq6d1RU4E9VQBJjVCoew9c+KqPyt/X4jVtkHkIL8E88DYVROIkIWffGYcZKYz05
         n5DLthBTgqmC3ymsRMY66vtUBTg/RKFPqMMwfFoiSLe3y+ujCZNc6eqRC/YZ//5822if
         3zoV8EFgMkYlaDq8qWGHfBJMS/NUwwvQ+EIAnyiUewUDrMn6NQCZ2ore6nagkKyuvQRc
         DxKtm9mRj3BNdy0xboQDvQoF/7PyXQOab0SO5y+AbIqJsXzoisE6d5NvYMBmawTqoEtY
         jwaAhSX99Wh5UpkJ43kOkioq/c3qLQKhTTblPEQ2NWJyNknylWq+XM+SpFoBr80P0OOg
         KRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742625296; x=1743230096;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q2wBK9I1dTSU9BJYYyCMSSg8VMlpEyof7o+h6tqNxVI=;
        b=GjoPHLtmy1MRxbNgXg/WUJNVLPzA34MrOAQX9viWmcvTxuPyxQkNbNcswiu4vOFMn+
         QZCqvsODf0F7m2fUZhqD91Z4fozUUEsw1FAfh4dQmlCcprVJiVQ7kRp8plfGzavMmvDe
         xzNVBukzbvf14UDy7oGW3G1eseAIMw4TsQLz8rRkH79IT5cFgKhLqGV7I8mFq0m/s9Qk
         NrR8FdyFGrTj7uMorrEoE5kywcoEdeCyruXdF0y4MHf90D4LZsqQF/zH9AA9tTUhIqfI
         YEblv/mtdvn+yPRHlLOgzG5xe2rWmt4c4IxGb1vl4lWb4KfbIVsglboTsVC2s/5aWcA+
         opsw==
X-Forwarded-Encrypted: i=1; AJvYcCW3pGNk7PKDY4g5Fij5CxH2ZmUgBgD/uigHjKHQOJgdj/JC1PHLGpaBfczuv0K7RbG9NdN/2w5Jiz69t3BHy9x+@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qXMM+C1JFm2mM6isbsHhUGqttZ+m7x6iEugFaCJ16vc+whnG
	aFqANdUgSfog0DvfanwFPtJMan6Xj/cNl2L1Z2FEjzgdSLUeFgEARtOH4/qF2/1Js9i26d2j54F
	0Y0K/BA==
X-Google-Smtp-Source: AGHT+IGj5qXrpI+iy2j7Py+Jn2j1tPuZvub6APNcMq/QjpNFmxUp+MXudhsRHwdX4WoJB2ziRIwUVAS1tuJ7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c16d:a1c1:1823:1d0e])
 (user=irogers job=sendgmr) by 2002:a81:f00b:0:b0:6ff:6fa4:ea5a with SMTP id
 00721157ae682-700ba9bd6aemr41747b3.0.1742625295461; Fri, 21 Mar 2025 23:34:55
 -0700 (PDT)
Date: Fri, 21 Mar 2025 23:33:41 -0700
In-Reply-To: <20250322063403.364981-1-irogers@google.com>
Message-Id: <20250322063403.364981-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250322063403.364981-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v1 13/35] perf vendor events: Add graniterapids retirement latencies
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

Add retirement latencies for use in place of retirement latency events.
Update events from v1.06 to v1.08.
Update event topics, metrics to be generated from the TMA spreadsheet
and other small clean ups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/graniterapids/cache.json         | 122 +++++
 .../arch/x86/graniterapids/counter.json       |   5 +
 .../arch/x86/graniterapids/frontend.json      |  21 +
 .../arch/x86/graniterapids/gnr-metrics.json   | 483 +++++++++---------
 .../arch/x86/graniterapids/memory.json        | 130 +++++
 .../arch/x86/graniterapids/other.json         | 237 ---------
 .../arch/x86/graniterapids/pipeline.json      |  52 ++
 .../arch/x86/graniterapids/uncore-cache.json  |  42 ++
 .../graniterapids/uncore-interconnect.json    |  90 +++-
 .../arch/x86/graniterapids/uncore-memory.json | 240 +++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 11 files changed, 926 insertions(+), 498 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/graniterapids/cache.json
index d155da8610d8..6fa985656312 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
@@ -351,6 +351,9 @@
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
         "PublicDescription": "Counts retired load instructions with locked=
 access.",
+        "RetirementLatencyMax": 5156,
+        "RetirementLatencyMean": 63.76,
+        "RetirementLatencyMin": 15,
         "SampleAfterValue": "100007",
         "UMask": "0x21"
     },
@@ -361,6 +364,9 @@
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
         "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
+        "RetirementLatencyMax": 4704,
+        "RetirementLatencyMean": 3.97,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100003",
         "UMask": "0x41"
     },
@@ -371,6 +377,9 @@
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
         "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
+        "RetirementLatencyMax": 65535,
+        "RetirementLatencyMean": 19.0,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100003",
         "UMask": "0x42"
     },
@@ -381,6 +390,9 @@
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_HIT_LOADS",
         "PublicDescription": "Number of retired load instructions with a c=
lean hit in the 2nd-level TLB (STLB).",
+        "RetirementLatencyMax": 3424,
+        "RetirementLatencyMean": 1.57,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100003",
         "UMask": "0x9"
     },
@@ -391,6 +403,9 @@
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_HIT_STORES",
         "PublicDescription": "Number of retired store instructions that hi=
t in the 2nd-level TLB (STLB).",
+        "RetirementLatencyMax": 65535,
+        "RetirementLatencyMean": 5.24,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100003",
         "UMask": "0xa"
     },
@@ -430,6 +445,9 @@
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
         "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
+        "RetirementLatencyMax": 4472,
+        "RetirementLatencyMean": 353.04,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "20011",
         "UMask": "0x4"
     },
@@ -440,6 +458,9 @@
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
         "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "RetirementLatencyMax": 830,
+        "RetirementLatencyMean": 125.27,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "20011",
         "UMask": "0x1"
     },
@@ -460,6 +481,9 @@
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
         "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
+        "RetirementLatencyMax": 3939,
+        "RetirementLatencyMean": 289.9,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "20011",
         "UMask": "0x2"
     },
@@ -470,6 +494,9 @@
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
         "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
+        "RetirementLatencyMax": 4146,
+        "RetirementLatencyMean": 115.83,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100007",
         "UMask": "0x1"
     },
@@ -479,6 +506,9 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
+        "RetirementLatencyMax": 3572,
+        "RetirementLatencyMean": 430.22,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
@@ -489,6 +519,9 @@
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
         "PublicDescription": "Retired load instructions whose data sources=
 was forwarded from a remote cache.",
+        "RetirementLatencyMax": 8552,
+        "RetirementLatencyMean": 125.36,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100007",
         "UMask": "0x8"
     },
@@ -498,6 +531,9 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
+        "RetirementLatencyMax": 2580,
+        "RetirementLatencyMean": 135.29,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -548,6 +584,9 @@
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
         "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
+        "RetirementLatencyMax": 7140,
+        "RetirementLatencyMean": 5.71,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
@@ -568,6 +607,9 @@
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
+        "RetirementLatencyMax": 5630,
+        "RetirementLatencyMean": 57.64,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100021",
         "UMask": "0x4"
     },
@@ -598,6 +640,16 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that hit in the L3 or were snooped from another co=
re's caches on the same socket.",
         "Counter": "0,1,2,3",
@@ -618,6 +670,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that hit in the L3 o=
r were snooped from another core's caches on the same socket.",
         "Counter": "0,1,2,3",
@@ -678,6 +740,36 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that hit a modified =
line in a distant L3 Cache or were snooped from a distant core's L1/L2 cach=
es on this socket when the system is in SNC (sub-NUMA cluster) mode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.SNC_CACHE.HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1008000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that either hit a no=
n-modified line in a distant L3 Cache or were snooped from a distant core's=
 L1/L2 caches on this socket when the system is in SNC (sub-NUMA cluster) m=
ode.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.SNC_CACHE.HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x808000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FFC0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that hit in=
 the L3 or were snooped from another core's caches on the same socket.",
         "Counter": "0,1,2,3",
@@ -698,6 +790,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines and =
streaming stores that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.MODIFIED_WRITE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10808",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F3FFC4477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that hit in the L3 or were snooped from another core's caches on the sa=
me socket.",
         "Counter": "0,1,2,3",
@@ -718,6 +830,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and w=
ere supplied by a remote socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F33004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by a cache on a remote socket where a snoop was sent=
 and data was returned (Modified or Not Modified).",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/counter.json b/to=
ols/perf/pmu-events/arch/x86/graniterapids/counter.json
index 137da7efa8b1..5d3b202eadd3 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/counter.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/counter.json
@@ -73,5 +73,10 @@
         "Unit": "MDF",
         "CountersNumFixed": "0",
         "CountersNumGeneric": "4"
+    },
+    {
+        "Unit": "UBOX",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "2"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/frontend.json
index dc81055941b1..77ebb46d104e 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/frontend.json
@@ -53,6 +53,9 @@
         "MSRIndex": "0x3F7",
         "MSRValue": "0x1",
         "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
+        "RetirementLatencyMax": 65535,
+        "RetirementLatencyMean": 2.46,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100007",
         "UMask": "0x3"
     },
@@ -75,6 +78,9 @@
         "MSRIndex": "0x3F7",
         "MSRValue": "0x14",
         "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
+        "RetirementLatencyMax": 980,
+        "RetirementLatencyMean": 41.96,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100007",
         "UMask": "0x3"
     },
@@ -86,6 +92,9 @@
         "MSRIndex": "0x3F7",
         "MSRValue": "0x12",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
+        "RetirementLatencyMax": 1785,
+        "RetirementLatencyMean": 9.83,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100007",
         "UMask": "0x3"
     },
@@ -97,6 +106,9 @@
         "MSRIndex": "0x3F7",
         "MSRValue": "0x13",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
+        "RetirementLatencyMax": 2854,
+        "RetirementLatencyMean": 137.41,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100007",
         "UMask": "0x3"
     },
@@ -250,6 +262,9 @@
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x8",
+        "RetirementLatencyMax": 65535,
+        "RetirementLatencyMean": 77.14,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100007",
         "UMask": "0x3"
     },
@@ -261,6 +276,9 @@
         "MSRIndex": "0x3F7",
         "MSRValue": "0x15",
         "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
+        "RetirementLatencyMax": 754,
+        "RetirementLatencyMean": 206.85,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100007",
         "UMask": "0x3"
     },
@@ -271,6 +289,9 @@
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x17",
+        "RetirementLatencyMax": 532,
+        "RetirementLatencyMean": 3.85,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100007",
         "UMask": "0x3"
     },
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json =
b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
index a345b6874606..9d64d7f5f222 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
@@ -310,7 +310,7 @@
         "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
         "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * tma_info_core_co=
re_clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -322,7 +322,7 @@
         "MetricExpr": "EXE.AMX_BUSY / tma_info_core_core_clks",
         "MetricGroup": "BvCB;Compute;HPC;Server;TopdownL3;tma_L3_group;tma=
_core_bound_group",
         "MetricName": "tma_amx_busy",
-        "MetricThreshold": "tma_amx_busy > 0.5 & tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2",
+        "MetricThreshold": "tma_amx_busy > 0.5 & (tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
@@ -330,12 +330,12 @@
         "MetricExpr": "78 * ASSISTS.ANY / tma_info_thread_slots",
         "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
-        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1",
+        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops as a result of handing SSE to AVX* or AVX* to SSE transitio=
n Assists.",
         "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / tma_info_thread_slots",
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_avx_assists",
@@ -345,7 +345,7 @@
     {
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_inf=
o_thread_slots",
         "MetricGroup": "BvOB;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
@@ -361,12 +361,12 @@
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
-        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example",
+        "PublicDescription": "This category represents fraction of slots w=
asted due to incorrect speculations. This include slots used to issue uops =
that do not eventually get retired and slots for which the issue-pipeline w=
as blocked due to recovery from earlier incorrect speculation. For example;=
 wasted work due to miss-predicted branches are categorized under Bad Specu=
lation category. Incorrect data speculation followed by Memory Ordering Nuk=
es is another example.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misses =
+ tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
         "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
         "MetricName": "tma_bottleneck_big_code",
         "MetricThreshold": "tma_bottleneck_big_code > 20"
@@ -381,7 +381,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dr=
am_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_store_fwd_blk + tm=
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_fb_full)=
))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_l=
atency_dependency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)=
))",
         "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_bottleneck_cache_memory_bandwidth",
         "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
@@ -389,7 +389,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
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
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound =
+ tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_l1_=
latency_dependency / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependen=
cy + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_=
bound * (tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma=
_l3_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_fb=
_full + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tm=
a_store_fwd_blk)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_split_l=
oads / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + tma_lock_=
latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_s=
tore_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_split_stores / (tma_dtlb_store + tma_false_sharin=
g + tma_split_stores + tma_store_latency + tma_streaming_stores)) + tma_mem=
ory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_boun=
d + tma_l3_bound + tma_store_bound)) * (tma_store_latency / (tma_dtlb_store=
 + tma_false_sharing + tma_split_stores + tma_store_latency + tma_streaming=
_stores)))",
         "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_bottleneck_cache_memory_latency",
         "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
@@ -397,22 +397,22 @@
     },
     {
         "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
-        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_serializing_operation + tma_amx_busy + tma_ports_utilization) + tma_c=
ore_bound * tma_amx_busy / (tma_divider + tma_serializing_operation + tma_a=
mx_busy + tma_ports_utilization) + tma_core_bound * (tma_ports_utilization =
/ (tma_divider + tma_serializing_operation + tma_amx_busy + tma_ports_utili=
zation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_utili=
zed_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
+        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_amx_busy=
 + tma_divider + tma_ports_utilization + tma_serializing_operation) + tma_c=
ore_bound * tma_amx_busy / (tma_amx_busy + tma_divider + tma_ports_utilizat=
ion + tma_serializing_operation) + tma_core_bound * (tma_ports_utilization =
/ (tma_amx_busy + tma_divider + tma_ports_utilization + tma_serializing_ope=
ration)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_utili=
zed_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
         "MetricGroup": "BvCB;Cor;tma_issueComp",
         "MetricName": "tma_bottleneck_compute_bound_est",
         "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
-        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy"
+        "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: "
     },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
-        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses + t=
ma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - (1 - I=
NST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_fe=
tch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clears_resteers=
 + tma_mispredicts_resteers * tma_other_mispredicts / tma_branch_mispredict=
s) / (tma_mispredicts_resteers + tma_clears_resteers + tma_unknown_branches=
)) / (tma_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_sw=
itches + tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_ms / (tma_=
mite + tma_dsb + tma_ms))) - tma_bottleneck_big_code",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - I=
NST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetc=
h_latency * (tma_ms_switches + tma_branch_resteers * (tma_clears_resteers +=
 tma_mispredicts_resteers * tma_other_mispredicts / tma_branch_mispredicts)=
 / (tma_clears_resteers + tma_mispredicts_resteers + tma_unknown_branches))=
 / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_m=
isses + tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_ms / (tma_ds=
b + tma_mite + tma_ms))) - tma_bottleneck_big_code",
         "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
         "MetricName": "tma_bottleneck_instruction_fetch_bw",
         "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20"
     },
     {
         "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
-        "MetricExpr": "100 * ((1 - INST_RETIRED.REP_ITERATION / cpu@UOPS_R=
ETIRED.MS\\,cmask\\=3D0x1@) * (tma_fetch_latency * (tma_ms_switches + tma_b=
ranch_resteers * (tma_clears_resteers + tma_mispredicts_resteers * tma_othe=
r_mispredicts / tma_branch_mispredicts) / (tma_mispredicts_resteers + tma_c=
lears_resteers + tma_unknown_branches)) / (tma_icache_misses + tma_itlb_mis=
ses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) +=
 tma_fetch_bandwidth * tma_ms / (tma_mite + tma_dsb + tma_ms)) + 10 * tma_m=
icrocode_sequencer * tma_other_mispredicts / tma_branch_mispredicts * tma_b=
ranch_mispredicts + tma_machine_clears * tma_other_nukes / tma_other_nukes =
+ tma_core_bound * (tma_serializing_operation + RS.EMPTY_RESOURCE / tma_inf=
o_thread_clks * tma_ports_utilized_0) / (tma_divider + tma_serializing_oper=
ation + tma_amx_busy + tma_ports_utilization) + tma_microcode_sequencer / (=
tma_few_uops_instructions + tma_microcode_sequencer) * (tma_assists / tma_m=
icrocode_sequencer) * tma_heavy_operations)",
+        "MetricExpr": "100 * ((1 - INST_RETIRED.REP_ITERATION / cpu@UOPS_R=
ETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_switches + tma_bra=
nch_resteers * (tma_clears_resteers + tma_mispredicts_resteers * tma_other_=
mispredicts / tma_branch_mispredicts) / (tma_clears_resteers + tma_mispredi=
cts_resteers + tma_unknown_branches)) / (tma_branch_resteers + tma_dsb_swit=
ches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) + t=
ma_fetch_bandwidth * tma_ms / (tma_dsb + tma_mite + tma_ms)) + 10 * tma_mic=
rocode_sequencer * tma_other_mispredicts / tma_branch_mispredicts * tma_bra=
nch_mispredicts + tma_machine_clears * tma_other_nukes / tma_other_nukes + =
tma_core_bound * (tma_serializing_operation + RS.EMPTY_RESOURCE / tma_info_=
thread_clks * tma_ports_utilized_0) / (tma_amx_busy + tma_divider + tma_por=
ts_utilization + tma_serializing_operation) + tma_microcode_sequencer / (tm=
a_few_uops_instructions + tma_microcode_sequencer) * (tma_assists / tma_mic=
rocode_sequencer) * tma_heavy_operations)",
         "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
         "MetricName": "tma_bottleneck_irregular_overhead",
         "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
@@ -420,7 +420,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_depende=
ncy + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound=
 * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dra=
m_bound + tma_store_bound)) * (tma_dtlb_store / (tma_store_latency + tma_fa=
lse_sharing + tma_split_stores + tma_streaming_stores + tma_dtlb_store)))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (=
tma_dtlb_load / (tma_dtlb_load + tma_fb_full + tma_l1_latency_dependency + =
tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound=
 * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l=
3_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma_false=
_sharing + tma_split_stores + tma_store_latency + tma_streaming_stores)))",
         "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
@@ -428,7 +428,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * =
(tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) * tma_remote_cach=
e / (tma_local_mem + tma_remote_mem + tma_remote_cache) + tma_l3_bound / (t=
ma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_boun=
d) * (tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / =
(tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bo=
und) * tma_false_sharing / (tma_store_latency + tma_false_sharing + tma_spl=
it_stores + tma_streaming_stores + tma_dtlb_store - tma_store_latency)) + t=
ma_machine_clears * (1 - tma_other_nukes / tma_other_nukes))",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
(tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) * tma_remote_cach=
e / (tma_local_mem + tma_remote_cache + tma_remote_mem) + tma_l3_bound / (t=
ma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_boun=
d) * (tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / =
(tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bo=
und) * tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_=
stores + tma_store_latency + tma_streaming_stores - tma_store_latency)) + t=
ma_machine_clears * (1 - tma_other_nukes / tma_other_nukes))",
         "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
         "MetricName": "tma_bottleneck_memory_synchronization",
         "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
@@ -436,7 +436,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses=
 + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches))",
+        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
         "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
         "MetricName": "tma_bottleneck_mispredictions",
         "MetricThreshold": "tma_bottleneck_mispredictions > 20",
@@ -448,10 +448,10 @@
         "MetricGroup": "BvOB;Cor;Offcore",
         "MetricName": "tma_bottleneck_other_bottlenecks",
         "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
-        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls"
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls."
     },
     {
-        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead",
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
         "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slot=
s - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_se=
quencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)"=
,
         "MetricGroup": "BvUW;Ret",
         "MetricName": "tma_bottleneck_useful_work",
@@ -460,7 +460,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
         "DefaultMetricgroupName": "TopdownL2",
-        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * sl=
ots",
+        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound +=
 topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tm=
a_info_thread_slots",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;Default;TmaL2;TopdownL2=
;tma_L2_group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
@@ -473,24 +473,24 @@
         "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clk=
s + tma_unknown_branches",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group",
         "MetricName": "tma_branch_resteers",
-        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
+        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers. Branch Resteers estimates the Fro=
ntend delay in fetching operations from corrected path; following all sorts=
 of miss-predicted branches. For example; branchy code with lots of miss-pr=
edictions might get categorized under Branch Resteers. Note the value of th=
is node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_BRA=
NCHES",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings)",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.1 power-performance optimized state (Fas=
ter wakeup time; Smaller power savings).",
         "MetricExpr": "CPU_CLK_UNHALTED.C01 / tma_info_thread_clks",
         "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
         "MetricName": "tma_c01_wait",
-        "MetricThreshold": "tma_c01_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_c01_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings)",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due staying in C0.2 power-performance optimized state (Slo=
wer wakeup time; Larger power savings).",
         "MetricExpr": "CPU_CLK_UNHALTED.C02 / tma_info_thread_clks",
         "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_oper=
ation_group",
         "MetricName": "tma_c02_wait",
-        "MetricThreshold": "tma_c02_wait > 0.05 & tma_serializing_operatio=
n > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_c02_wait > 0.05 & (tma_serializing_operati=
on > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
@@ -498,8 +498,8 @@
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources",
+        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
         "ScaleUnit": "100%"
     },
     {
@@ -507,24 +507,24 @@
         "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation) =
* INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clks",
         "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueMC",
         "MetricName": "tma_clears_resteers",
-        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_restee=
rs > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_reste=
ers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Machine Clears. Sam=
ple with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, tma=
_machine_clears, tma_microcode_sequencer, tma_ms_switches",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache.",
         "MetricExpr": "max(0, FRONTEND_RETIRED.L1I_MISS * FRONTEND_RETIRED=
.L1I_MISS:R / tma_info_thread_clks - tma_code_l2_miss)",
         "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
         "MetricName": "tma_code_l2_hit",
-        "MetricThreshold": "tma_code_l2_hit > 0.05 & tma_icache_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_l2_hit > 0.05 & (tma_icache_misses > =
0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache",
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache."=
,
         "MetricExpr": "FRONTEND_RETIRED.L2_MISS * FRONTEND_RETIRED.L2_MISS=
:R / tma_info_thread_clks",
         "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
         "MetricName": "tma_code_l2_miss",
-        "MetricThreshold": "tma_code_l2_miss > 0.05 & tma_icache_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_l2_miss > 0.05 & (tma_icache_misses >=
 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%"
     },
     {
@@ -532,7 +532,7 @@
         "MetricExpr": "max(0, FRONTEND_RETIRED.ITLB_MISS * FRONTEND_RETIRE=
D.ITLB_MISS:R / tma_info_thread_clks - tma_code_stlb_miss)",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
         "MetricName": "tma_code_stlb_hit",
-        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_hit > 0.05 & (tma_itlb_misses > =
0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%"
     },
     {
@@ -540,48 +540,48 @@
         "MetricExpr": "FRONTEND_RETIRED.STLB_MISS * FRONTEND_RETIRED.STLB_=
MISS:R / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
         "MetricName": "tma_code_stlb_miss",
-        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_miss > 0.05 & (tma_itlb_misses >=
 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses.",
         "MetricExpr": "ITLB_MISSES.WALK_ACTIVE / tma_info_thread_clks * IT=
LB_MISSES.WALK_COMPLETED_2M_4M / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISS=
ES.WALK_COMPLETED_2M_4M)",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
         "MetricName": "tma_code_stlb_miss_2m",
-        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & (tma_code_stlb_=
miss > 0.05 & (tma_itlb_misses > 0.05 & (tma_fetch_latency > 0.1 & tma_fron=
tend_bound > 0.15)))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses.",
         "MetricExpr": "ITLB_MISSES.WALK_ACTIVE / tma_info_thread_clks * IT=
LB_MISSES.WALK_COMPLETED_4K / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.=
WALK_COMPLETED_2M_4M)",
         "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
         "MetricName": "tma_code_stlb_miss_4k",
-        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & (tma_code_stlb_=
miss > 0.05 & (tma_itlb_misses > 0.05 & (tma_fetch_latency > 0.1 & tma_fron=
tend_bound > 0.15)))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by non-taken conditional bran=
ches",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by non-taken conditional bran=
ches.",
         "MetricExpr": "BR_MISP_RETIRED.COND_NTAKEN_COST * BR_MISP_RETIRED.=
COND_NTAKEN_COST:R / tma_info_thread_clks",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_cond_nt_mispredicts",
-        "MetricThreshold": "tma_cond_nt_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_cond_nt_mispredicts > 0.05 & (tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by taken conditional branches",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to misprediction by taken conditional branches.",
         "MetricExpr": "BR_MISP_RETIRED.COND_TAKEN_COST * BR_MISP_RETIRED.C=
OND_TAKEN_COST:R / tma_info_thread_clks",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_cond_tk_mispredicts",
-        "MetricThreshold": "tma_cond_tk_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_cond_tk_mispredicts > 0.05 & (tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
-        "MetricExpr": "((min(MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS * MEM_LOAD_=
L3_HIT_RETIRED.XSNP_MISS:R, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS * (79 * tma_i=
nfo_system_core_frequency) - 4.4 * tma_info_system_core_frequency) if 0 < M=
EM_LOAD_L3_HIT_RETIRED.XSNP_MISS:R else MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS *=
 (79 * tma_info_system_core_frequency) - 4.4 * tma_info_system_core_frequen=
cy) + (min(MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * MEM_LOAD_L3_HIT_RETIRED.XSNP_=
FWD:R, MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (81 * tma_info_system_core_freque=
ncy) - 4.4 * tma_info_system_core_frequency) if 0 < MEM_LOAD_L3_HIT_RETIRED=
.XSNP_FWD:R else MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (81 * tma_info_system_c=
ore_frequency) - 4.4 * tma_info_system_core_frequency) * (OCR.DEMAND_DATA_R=
D.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DA=
TA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOA=
D_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "(MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS * min(MEM_LOAD_L=
3_HIT_RETIRED.XSNP_MISS:R, 74.6 * tma_info_system_core_frequency) + MEM_LOA=
D_L3_HIT_RETIRED.XSNP_FWD * min(MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD:R, 76.6 * =
tma_info_system_core_frequency) * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (=
OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_=
WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) =
/ tma_info_thread_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
-        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related =
metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false=
_sharing, tma_machine_clears, tma_remote_cache",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related m=
etrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_false_=
sharing, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
@@ -592,24 +592,24 @@
         "MetricName": "tma_core_bound",
         "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.2=
",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re Core non-memory issues were of a bottleneck.  Shortage in hardware compu=
te resources; or dependencies in software's instructions are both categoriz=
ed under Core Bound. Hence it may indicate the machine ran out of an out-of=
-order resource; certain execution units are overloaded or dependencies in =
program's data- or instruction-flow are limiting the performance (e.g. FP-c=
hained long-latency arithmetic operations).",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
-        "MetricExpr": "((min(MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD * MEM_LOA=
D_L3_HIT_RETIRED.XSNP_NO_FWD:R, MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD * (79 *=
 tma_info_system_core_frequency) - 4.4 * tma_info_system_core_frequency) if=
 0 < MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD:R else MEM_LOAD_L3_HIT_RETIRED.XSN=
P_NO_FWD * (79 * tma_info_system_core_frequency) - 4.4 * tma_info_system_co=
re_frequency) + (min(MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * MEM_LOAD_L3_HIT_RET=
IRED.XSNP_FWD:R, MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (79 * tma_info_system_c=
ore_frequency) - 4.4 * tma_info_system_core_frequency) if 0 < MEM_LOAD_L3_H=
IT_RETIRED.XSNP_FWD:R else MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (79 * tma_inf=
o_system_core_frequency) - 4.4 * tma_info_system_core_frequency) * (1 - OCR=
.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM +=
 OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB=
_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "(MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD * min(MEM_LOAD=
_L3_HIT_RETIRED.XSNP_NO_FWD:R, 74.6 * tma_info_system_core_frequency) + MEM=
_LOAD_L3_HIT_RETIRED.XSNP_FWD * min(MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD:R, 74.=
6 * tma_info_system_core_frequency) * (1 - OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_=
HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SN=
OOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MI=
SS / 2) / tma_info_thread_clks",
         "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
-        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_synch=
ronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears, =
tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - cpu@I=
NST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks / 2",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issueD0=
;tma_mite_group",
         "MetricName": "tma_decoder0_alone",
-        "MetricThreshold": "tma_decoder0_alone > 0.1 & tma_mite > 0.1 & tm=
a_fetch_bandwidth > 0.2",
+        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 & t=
ma_fetch_bandwidth > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere decoder-0 was the only active decoder. Related metrics: tma_few_uops_in=
structions",
         "ScaleUnit": "100%"
     },
@@ -618,7 +618,7 @@
         "MetricExpr": "ARITH.DIV_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
-        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & tma=
_backend_bound > 0.2",
+        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIV_ACTIVE",
         "ScaleUnit": "100%"
     },
@@ -627,7 +627,7 @@
         "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_thread_cl=
ks",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled on accesses to external memory (DRAM) by loads. Better caching can =
improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED=
.L3_MISS",
         "ScaleUnit": "100%"
     },
@@ -637,7 +637,7 @@
         "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_bandw=
idth_group",
         "MetricName": "tma_dsb",
         "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es in which CPU was likely limited due to DSB (decoded uop cache) fetch pip=
eline.  For example; inefficient utilization of the DSB cache structure or =
bank conflict when reading from it; are categorized here.",
         "ScaleUnit": "100%"
     },
     {
@@ -645,34 +645,34 @@
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
-        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwi=
dth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_inf=
o_inst_mix_iptb, tma_lcp",
+        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_ban=
dwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "(min(MEM_INST_RETIRED.STLB_HIT_LOADS * MEM_INST_RET=
IRED.STLB_HIT_LOADS:R, MEM_INST_RETIRED.STLB_HIT_LOADS * 7) if 0 < MEM_INST=
_RETIRED.STLB_HIT_LOADS:R else MEM_INST_RETIRED.STLB_HIT_LOADS * 7) / tma_i=
nfo_thread_clks + tma_load_stlb_miss",
+        "MetricExpr": "MEM_INST_RETIRED.STLB_HIT_LOADS * min(MEM_INST_RETI=
RED.STLB_HIT_LOADS:R, 7) / tma_info_thread_clks + tma_load_stlb_miss",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
-        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma=
_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS. Related metrics: tma_=
bottleneck_memory_data_tlbs, tma_dtlb_store",
+        "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_bottleneck_memory_data_tlbs, tma_dtlb_store",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(min(MEM_INST_RETIRED.STLB_HIT_STORES * MEM_INST_RE=
TIRED.STLB_HIT_STORES:R, MEM_INST_RETIRED.STLB_HIT_STORES * 7) if 0 < MEM_I=
NST_RETIRED.STLB_HIT_STORES:R else MEM_INST_RETIRED.STLB_HIT_STORES * 7) / =
tma_info_thread_clks + tma_store_stlb_miss",
+        "MetricExpr": "MEM_INST_RETIRED.STLB_HIT_STORES * min(MEM_INST_RET=
IRED.STLB_HIT_STORES:R, 7) / tma_info_thread_clks + tma_store_stlb_miss",
         "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
-        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.2 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES. Related metrics: tma_bottleneck_mem=
ory_data_tlbs, tma_dtlb_load",
+        "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_bottleneck_=
memory_data_tlbs, tma_dtlb_load",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "(170 * tma_info_system_core_frequency * cpu@OCR.DEM=
AND_RFO.L3_MISS\\,offcore_rsp\\=3D0x103b800002@ + 81 * tma_info_system_core=
_frequency * OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM) / tma_info_thread_clks",
+        "MetricExpr": "(170 * tma_info_system_core_frequency * OCR.DEMAND_=
RFO.L3_MISS@offcore_rsp\\=3D0x103b800002@ + 81 * tma_info_system_core_frequ=
ency * OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM) / tma_info_thread_clks",
         "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL4;=
tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
-        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound > 0=
.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronization, t=
ma_contested_accesses, tma_data_sharing, tma_machine_clears, tma_remote_cac=
he",
         "ScaleUnit": "100%"
     },
@@ -693,7 +693,7 @@
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1, FRONTEND_RETIRED.LATE=
NCY_GE_1, FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches,=
 tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1;FRONTEND_RETIRED.LATEN=
CY_GE_1;FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switches, t=
ma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_fr=
ontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%"
     },
     {
@@ -704,7 +704,7 @@
         "MetricName": "tma_fetch_latency",
         "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound >=
 0.15",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16, FRONTEND_RETIRED.LATENCY_GE_8",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend latency issues.  For example; instruction-=
cache misses; iTLB misses or fetch stalls after a branch misprediction are =
categorized under Frontend Latency. In such cases; the Frontend eventually =
delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_GE_=
16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -722,7 +722,7 @@
         "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_gr=
oup",
         "MetricName": "tma_fp_arith",
         "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > 0.=
6",
-        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting",
+        "PublicDescription": "This metric represents overall arithmetic fl=
oating-point (FP) operations fraction the CPU has executed (retired). Note =
this metric's value may exceed its parent due to use of \"Uops\" CountDomai=
n and FMA double-counting.",
         "ScaleUnit": "100%"
     },
     {
@@ -731,15 +731,15 @@
         "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_fp_assists",
         "MetricThreshold": "tma_fp_assists > 0.1",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals)",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Floating Point (FP) Assists=
. FP Assist may apply when working with very small floating point values (s=
o-called Denormals).",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active.",
         "MetricExpr": "ARITH.FPDIV_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
         "MetricName": "tma_fp_divider",
-        "MetricThreshold": "tma_fp_divider > 0.2 & tma_divider > 0.2 & tma=
_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_fp_divider > 0.2 & (tma_divider > 0.2 & (t=
ma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
@@ -747,8 +747,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + FP_ARITH_INST_RETIR=
ED2.SCALAR) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
-        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector_2=
56b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector_2=
56b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -756,8 +756,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.VECTOR + FP_ARITH_INST_RETIR=
ED2.VECTOR) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
-        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6=
, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -765,8 +765,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.128B_PACKED_HALF=
) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
-        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized=
_2",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_po=
rts_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -774,8 +774,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.256B_PACKED_HALF=
) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
-        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized=
_2",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_int_vector_128b, =
tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_po=
rts_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -783,8 +783,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE + FP_ARITH_INST_RETIRED2.512B_PACKED_HALF=
) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_512b",
-        "MetricThreshold": "tma_fp_vector_512b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector_512b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vecto=
r_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_=
2",
         "ScaleUnit": "100%"
     },
     {
@@ -795,27 +795,27 @@
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
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
ND_RETIRED.LATENCY_GE_4",
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
ND_RETIRED.LATENCY_GE_4_PS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions , where one uop can represent mul=
tiple contiguous instructions",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
         "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED / (=
tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions , where one uop can represent mu=
ltiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of l=
egacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Oth=
er_Light_Ops in MTL!)}",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of =
legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Ot=
her_Light_Ops in MTL!)}",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
         "DefaultMetricgroupName": "TopdownL2",
-        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_in=
fo_thread_slots",
         "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_re=
tiring_group",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+]). Sample with: UOPS_RET=
IRED.HEAVY",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences.([ICL+] Note this may overcoun=
t due to approximation using indirect events; [ADL+]). Sample with: UOPS_RE=
TIRED.HEAVY",
         "ScaleUnit": "100%"
     },
     {
@@ -823,24 +823,24 @@
         "MetricExpr": "ICACHE_DATA.STALLS / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS, FRONTEND_RETIRED.L1I_MISS",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect CALL instructions=
",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect CALL instructions=
.",
         "MetricExpr": "BR_MISP_RETIRED.INDIRECT_CALL_COST * BR_MISP_RETIRE=
D.INDIRECT_CALL_COST:R / tma_info_thread_clks",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ind_call_mispredicts",
-        "MetricThreshold": "tma_ind_call_mispredicts > 0.05 & tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_ind_call_mispredicts > 0.05 & (tma_branch_=
mispredicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect JMP instructions"=
,
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by indirect JMP instructions.=
",
         "MetricExpr": "max((BR_MISP_RETIRED.INDIRECT_COST * BR_MISP_RETIRE=
D.INDIRECT_COST:R - BR_MISP_RETIRED.INDIRECT_CALL_COST * BR_MISP_RETIRED.IN=
DIRECT_CALL_COST:R) / tma_info_thread_clks, 0)",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ind_jump_mispredicts",
-        "MetricThreshold": "tma_ind_jump_mispredicts > 0.05 & tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_ind_jump_mispredicts > 0.05 & (tma_branch_=
mispredicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
@@ -851,28 +851,28 @@
         "PublicDescription": "Branch Misprediction Cost: Cycles representi=
ng fraction of TMA slots wasted per non-speculative branch misprediction (r=
etired JEClear). Related metrics: tma_bottleneck_mispredictions, tma_branch=
_mispredicts, tma_mispredicts_resteers"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
-        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000"
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
     },
     {
-        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate)",
+        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_ret",
@@ -900,7 +900,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_dsb=
 + tma_ms)))",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_mite=
 + tma_ms)))",
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
@@ -908,7 +908,7 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + t=
ma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite + t=
ma_dsb + tma_ms))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite + tma_ms))",
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_misses",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
@@ -916,10 +916,11 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + =
tma_lcp + tma_dsb_switches))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
-        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5"
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
+        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
     },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
@@ -980,11 +981,11 @@
         "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED.P=
ORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * tma_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)"
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D0x1@",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp"
     },
@@ -997,8 +998,8 @@
         "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_inst_mix_iptb, tma_lcp"
     },
     {
-        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
         "MetricGroup": "DSBmiss",
         "MetricName": "tma_info_frontend_dsb_switch_cost"
     },
@@ -1011,7 +1012,7 @@
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D0=
x1@",
+        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "tma_info_frontend_fetch_upc"
     },
@@ -1061,10 +1062,10 @@
     },
     {
         "BriefDescription": "Average number of cycles the front-end was de=
layed due to an Unknown Branch detection",
-        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / cpu@INT_MISC.UNKNO=
WN_BRANCH_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
+        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / cpu@INT_MISC.UNKNO=
WN_BRANCH_CYCLES\\,cmask\\=3D1\\,edge@",
         "MetricGroup": "Fed",
         "MetricName": "tma_info_frontend_unknown_branch_cost",
-        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node"
+        "PublicDescription": "Average number of cycles the front-end was d=
elayed due to an Unknown Branch detection. See Unknown_Branches node."
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU retirement was stalled likely due to retired branches who got branch a=
ddress clears",
@@ -1073,7 +1074,7 @@
         "MetricName": "tma_info_frontend_unknown_branches_ret"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch",
+        "BriefDescription": "Branch instructions per taken branch.",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_bptkbranch"
@@ -1091,7 +1092,7 @@
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW"
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
@@ -1099,7 +1100,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
@@ -1107,7 +1108,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
@@ -1115,7 +1116,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx512",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx512 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). Values < 1 are poss=
ible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). Values < 1 are poss=
ible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
@@ -1123,7 +1124,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Half-Pr=
ecision instruction (lower number means higher occurrence rate)",
@@ -1131,7 +1132,7 @@
         "MetricGroup": "Flops;FpScalar;InsType;Server",
         "MetricName": "tma_info_inst_mix_iparith_scalar_hp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_hp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Half-P=
recision instruction (lower number means higher occurrence rate). Values < =
1 are possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Half-P=
recision instruction (lower number means higher occurrence rate). Values < =
1 are possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
@@ -1139,7 +1140,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
@@ -1194,7 +1195,7 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
-        "MetricThreshold": "tma_info_inst_mix_iptb < 6 * 2 + 1",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 13",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp"
     },
     {
@@ -1331,7 +1332,7 @@
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
         "MetricGroup": "Memory_BW;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_mlp"
     },
@@ -1396,21 +1397,21 @@
         "MetricExpr": "64 * OCR.READS_TO_CORE.DRAM / 1e9 / tma_info_system=
_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "tma_info_memory_soc_r2c_dram_bw",
-        "PublicDescription": "Average DRAM BW for Reads-to-Core (R2C) cove=
ring for memory attached to local- and remote-socket. See R2C_Offcore_BW"
+        "PublicDescription": "Average DRAM BW for Reads-to-Core (R2C) cove=
ring for memory attached to local- and remote-socket. See R2C_Offcore_BW."
     },
     {
         "BriefDescription": "Average L3-cache miss BW for Reads-to-Core (R=
2C)",
         "MetricExpr": "64 * OCR.READS_TO_CORE.L3_MISS / 1e9 / tma_info_sys=
tem_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "tma_info_memory_soc_r2c_l3m_bw",
-        "PublicDescription": "Average L3-cache miss BW for Reads-to-Core (=
R2C). This covering going to DRAM or other memory off-chip memory tears. Se=
e R2C_Offcore_BW"
+        "PublicDescription": "Average L3-cache miss BW for Reads-to-Core (=
R2C). This covering going to DRAM or other memory off-chip memory tears. Se=
e R2C_Offcore_BW."
     },
     {
         "BriefDescription": "Average Off-core access BW for Reads-to-Core =
(R2C)",
         "MetricExpr": "64 * OCR.READS_TO_CORE.ANY_RESPONSE / 1e9 / tma_inf=
o_system_time",
         "MetricGroup": "HPC;Mem;MemoryBW;SoC",
         "MetricName": "tma_info_memory_soc_r2c_offcore_bw",
-        "PublicDescription": "Average Off-core access BW for Reads-to-Core=
 (R2C). R2C account for demand or prefetch load/RFO/code access that fill d=
ata into the Core caches"
+        "PublicDescription": "Average Off-core access BW for Reads-to-Core=
 (R2C). R2C account for demand or prefetch load/RFO/code access that fill d=
ata into the Core caches."
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
@@ -1452,8 +1453,8 @@
         "MetricName": "tma_info_memory_tlb_store_stlb_mpki"
     },
     {
-        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D0x1@)",
+        "BriefDescription": "",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
     },
@@ -1474,18 +1475,18 @@
         "MetricExpr": "INST_RETIRED.ANY / ASSISTS.ANY",
         "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
         "MetricName": "tma_info_pipeline_ipassist",
-        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
+        "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
         "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
-        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D0x1@",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
     },
     {
         "BriefDescription": "Estimated fraction of retirement-cycles deali=
ng with repeat instructions",
-        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLOTS=
\\,cmask\\=3D0x1@",
+        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLOTS=
\\,cmask\\=3D1@",
         "MetricGroup": "MicroSeq;Pipeline;Ret",
         "MetricName": "tma_info_pipeline_strings_cycles",
         "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1"
@@ -1548,14 +1549,13 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_system_ipfarbranch",
-        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000"
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
         "MetricGroup": "OS",
-        "MetricName": "tma_info_system_kernel_cpi",
-        "ScaleUnit": "1per_instr"
+        "MetricName": "tma_info_system_kernel_cpi"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
@@ -1566,14 +1566,14 @@
     },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal DRAM memory [in nanoseconds]",
-        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / cha_0@event\\=3D0x0@",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / uncore_cha_0@event\\=3D0x1@",
         "MetricGroup": "MemOffcore;MemoryLat;Server;SoC",
         "MetricName": "tma_info_system_mem_dram_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data=
-read prefetches"
     },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
-        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / cha@UNC_CHA_TOR=
_OCCUPANCY.IA_MISS_DRD\\,thresh\\=3D0x1@",
+        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_OCC=
UPANCY.IA_MISS_DRD@thresh\\=3D1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
@@ -1599,7 +1599,7 @@
     },
     {
         "BriefDescription": "Socket actual clocks when any core is active =
on that socket",
-        "MetricExpr": "cha_0@event\\=3D0x0@",
+        "MetricExpr": "uncore_cha_0@event\\=3D0x1@",
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_socket_clks"
     },
@@ -1629,7 +1629,7 @@
         "MetricName": "tma_info_system_upi_data_transmit_bw"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Pipeline",
         "MetricName": "tma_info_thread_clks"
@@ -1638,15 +1638,14 @@
         "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
         "MetricExpr": "1 / tma_info_thread_ipc",
         "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_thread_cpi",
-        "ScaleUnit": "1per_instr"
+        "MetricName": "tma_info_thread_cpi"
     },
     {
         "BriefDescription": "The ratio of Executed- by Issued-Uops",
         "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
         "MetricGroup": "Cor;Pipeline",
         "MetricName": "tma_info_thread_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage"
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
     },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
@@ -1656,13 +1655,13 @@
     },
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "slots",
+        "MetricExpr": "TOPDOWN.SLOTS",
         "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots"
     },
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(tma_info_thread_slots / (slots / 2) if #SMT_on els=
e 1)",
+        "MetricExpr": "(tma_info_thread_slots / (TOPDOWN.SLOTS / 2) if #SM=
T_on else 1)",
         "MetricGroup": "SMT;TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots_utilization"
     },
@@ -1678,14 +1677,14 @@
         "MetricExpr": "tma_retiring * tma_info_thread_slots / BR_INST_RETI=
RED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
-        "MetricThreshold": "tma_info_thread_uptb < 6 * 1.5"
+        "MetricThreshold": "tma_info_thread_uptb < 9"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active",
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active.",
         "MetricExpr": "tma_divider - tma_fp_divider",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
         "MetricName": "tma_int_divider",
-        "MetricThreshold": "tma_int_divider > 0.2 & tma_divider > 0.2 & tm=
a_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_int_divider > 0.2 & (tma_divider > 0.2 & (=
tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
@@ -1694,7 +1693,7 @@
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_int_operations",
         "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operation=
s > 0.6",
-        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain",
+        "PublicDescription": "This metric represents overall Integer (Int)=
 select operations fraction the CPU has executed (retired). Vector/Matrix I=
nt operations and shuffles are counted. Note this metric's value may exceed=
 its parent due to use of \"Uops\" CountDomain.",
         "ScaleUnit": "100%"
     },
     {
@@ -1702,8 +1701,8 @@
         "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_128=
) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_128b",
-        "MetricThreshold": "tma_int_vector_128b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_256b, tma=
_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_int_vector_128b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents 128-bit vector Intege=
r ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction th=
e CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_ve=
ctor_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_256b, tma=
_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1711,8 +1710,8 @@
         "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_256 =
+ INT_VEC_RETIRED.VNNI_256) / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_group;=
tma_int_operations_group;tma_issue2P",
         "MetricName": "tma_int_vector_256b",
-        "MetricThreshold": "tma_int_vector_256b > 0.1 & tma_int_operations=
 > 0.1 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b,=
 tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_int_vector_256b > 0.1 & (tma_int_operation=
s > 0.1 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents 256-bit vector Intege=
r ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fractio=
n the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_f=
p_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b,=
 tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1720,8 +1719,8 @@
         "MetricExpr": "ICACHE_TAG.STALLS / tma_info_thread_clks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS, FRONTEND_RETIRED.ITLB_MISS",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -1729,7 +1728,7 @@
         "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVITY.=
STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_issueL1;tma_issueMC;tma_memory_bound_group",
         "MetricName": "tma_l1_bound",
-        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & =
tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1D. Another example is loads who miss in the TLB.=
 These cases are characterized by execution unit stalls; while some non-com=
pleted demand load lives in the machine without having that demand load mis=
sing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics: t=
ma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_swi=
tches, tma_ports_utilized_1",
         "ScaleUnit": "100%"
     },
@@ -1738,7 +1737,7 @@
         "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RETI=
RED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYCLE=
S_MEM_ANY - MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
         "MetricName": "tma_l1_latency_dependency",
-        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & tma_l1_bound=
 > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & (tma_l1_boun=
d > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimates=
 fraction of cycles with demand load accesses that hit the L1D cache. The s=
hort latency of the L1D cache may be exposed in pointer-chasing memory acce=
ss patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
         "ScaleUnit": "100%"
     },
@@ -1747,16 +1746,16 @@
         "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVITY.=
STALLS_L2_MISS) / tma_info_thread_clks",
         "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
-        "MetricExpr": "(min(MEM_LOAD_RETIRED.L2_HIT * MEM_LOAD_RETIRED.L2_=
HIT:R, MEM_LOAD_RETIRED.L2_HIT * (4.4 * tma_info_system_core_frequency)) if=
 0 < MEM_LOAD_RETIRED.L2_HIT:R else MEM_LOAD_RETIRED.L2_HIT * (4.4 * tma_in=
fo_system_core_frequency)) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRE=
D.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * min(MEM_LOAD_RETIRED.L2_H=
IT:R, 4.4 * tma_info_system_core_frequency) * (1 + MEM_LOAD_RETIRED.FB_HIT =
/ MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
         "MetricName": "tma_l2_hit_latency",
-        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_l2_hit_latency > 0.05 & (tma_l2_bound > 0.=
05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L2 cache under unloaded scenarios (pos=
sibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 hit=
s) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%"
     },
@@ -1765,17 +1764,17 @@
         "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY.S=
TALLS_L3_MISS) / tma_info_thread_clks",
         "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
         "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2 &=
 tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT",
+        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often the CPU was =
stalled due to loads accesses to L3 cache or contended with a sibling Core.=
  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency an=
d increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
-        "MetricExpr": "(min(MEM_LOAD_RETIRED.L3_HIT * MEM_LOAD_RETIRED.L3_=
HIT:R, MEM_LOAD_RETIRED.L3_HIT * (37 * tma_info_system_core_frequency) - 4.=
4 * tma_info_system_core_frequency) if 0 < MEM_LOAD_RETIRED.L3_HIT:R else M=
EM_LOAD_RETIRED.L3_HIT * (37 * tma_info_system_core_frequency) - 4.4 * tma_=
info_system_core_frequency) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIR=
ED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "MEM_LOAD_RETIRED.L3_HIT * min(MEM_LOAD_RETIRED.L3_H=
IT:R, 32.6 * tma_info_system_core_frequency) * (1 + MEM_LOAD_RETIRED.FB_HIT=
 / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
-        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.05=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT. Related metrics: tma_b=
ottleneck_cache_memory_latency, tma_branch_resteers, tma_mem_latency, tma_s=
tore_latency",
+        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_bottleneck_cache_memory_latency, tma_mem_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -1783,19 +1782,19 @@
         "MetricExpr": "DECODE.LCP / tma_info_thread_clks",
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
-        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & tma=
_frontend_bound > 0.15",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. Related metr=
ics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidt=
h, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_info_=
inst_mix_iptb",
+        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations , instructions that require =
no more than one uop (micro-operation)",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring light-weight operations -- instructions that require=
 no more than one uop (micro-operation)",
         "DefaultMetricgroupName": "TopdownL2",
         "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
         "MetricGroup": "Default;Retire;TmaL2;TopdownL2;tma_L2_group;tma_re=
tiring_group",
         "MetricName": "tma_light_operations",
         "MetricThreshold": "tma_light_operations > 0.6",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations , instructions that require=
 no more than one uop (micro-operation). This correlates with total number =
of instructions used by the program. A uops-per-instruction (see UopPI metr=
ic) ratio of 1 or less should be expected for decently optimized code runni=
ng on Intel Core/Xeon products. While this often indicates efficient X86 in=
structions were executed; high value does not necessarily mean better perfo=
rmance cannot be achieved. ([ICL+] Note this may undercount due to approxim=
ation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIST=
",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring light-weight operations -- instructions that requir=
e no more than one uop (micro-operation). This correlates with total number=
 of instructions used by the program. A uops-per-instruction (see UopPI met=
ric) ratio of 1 or less should be expected for decently optimized code runn=
ing on Intel Core/Xeon products. While this often indicates efficient X86 i=
nstructions were executed; high value does not necessarily mean better perf=
ormance cannot be achieved. ([ICL+] Note this may undercount due to approxi=
mation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DIS=
T",
         "ScaleUnit": "100%"
     },
     {
@@ -1812,7 +1811,7 @@
         "MetricExpr": "max(0, tma_dtlb_load - tma_load_stlb_miss)",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_hit",
-        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0.1=
 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_hit > 0.05 & (tma_dtlb_load > 0.=
1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
         "ScaleUnit": "100%"
     },
     {
@@ -1820,31 +1819,31 @@
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_thread_clks=
",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_miss",
-        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > 0.=
1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses.",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_1G / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_1g",
-        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & (tma_load_stlb_=
miss > 0.05 & (tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (tma_memory_boun=
d > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses.",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPL=
ETED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_2m",
-        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & (tma_load_stlb_=
miss > 0.05 & (tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (tma_memory_boun=
d > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses.",
         "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_4K / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
         "MetricName": "tma_load_stlb_miss_4k",
-        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & (tma_load_stlb_=
miss > 0.05 & (tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (tma_memory_boun=
d > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
@@ -1852,7 +1851,7 @@
         "MetricExpr": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * MEM_LOAD_L3_M=
ISS_RETIRED.LOCAL_DRAM:R * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_mem",
-        "MetricThreshold": "tma_local_mem > 0.1 & tma_mem_latency > 0.1 & =
tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_local_mem > 0.1 & (tma_mem_latency > 0.1 &=
 (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2)=
))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.LOCAL_DRAM",
         "ScaleUnit": "100%"
     },
@@ -1861,7 +1860,7 @@
         "MetricExpr": "MEM_INST_RETIRED.LOCK_LOADS * MEM_INST_RETIRED.LOCK=
_LOADS:R / tma_info_thread_clks",
         "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issueR=
FO;tma_l1_bound_group",
         "MetricName": "tma_lock_latency",
-        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 & =
tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%"
     },
@@ -1877,19 +1876,19 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to memory bandwidth Allocation=
 feature (RDT's memory bandwidth throttling)",
+        "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to memory bandwidth Allocation=
 feature (RDT's memory bandwidth throttling).",
         "MetricExpr": "INT_MISC.MBA_STALLS / tma_info_thread_clks",
         "MetricGroup": "MemoryBW;Offcore;Server;TopdownL5;tma_L5_group;tma=
_mem_bandwidth_group",
         "MetricName": "tma_mba_stalls",
-        "MetricThreshold": "tma_mba_stalls > 0.1 & tma_mem_bandwidth > 0.2=
 & tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2"=
,
+        "MetricThreshold": "tma_mba_stalls > 0.1 & (tma_mem_bandwidth > 0.=
2 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2)))",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
-        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidth,=
 tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%"
     },
@@ -1898,32 +1897,32 @@
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
         "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
-        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_latency=
",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of slots the =
Memory subsystem within the Backend was a bottleneck",
         "DefaultMetricgroupName": "TopdownL2",
-        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots"=
,
+        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + top=
down\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_in=
fo_thread_slots",
         "MetricGroup": "Backend;Default;TmaL2;TopdownL2;tma_L2_group;tma_b=
ackend_bound_group",
         "MetricName": "tma_memory_bound",
         "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound > 0=
.2",
         "MetricgroupNoGroup": "TopdownL2;Default",
-        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
",
+        "PublicDescription": "This metric represents fraction of slots the=
 Memory subsystem within the Backend was a bottleneck.  Memory Bound estima=
tes fraction of slots where pipeline is likely stalled due to demand load o=
r store instructions. This accounts mainly for (1) non-completed in-flight =
memory demand loads which coincides with execution units starvation; in add=
ition to (2) cases where stores could impose backpressure on the pipeline w=
hen many of them get buffered at the same time (less common out of the two)=
.",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to LFENCE Instructions.",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "13 * MISC2_RETIRED.LFENCE / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_memory_fence",
-        "MetricThreshold": "tma_memory_fence > 0.05 & tma_serializing_oper=
ation > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations , uops for memory load or store ac=
cesses",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
         "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma_r=
etiring * tma_info_thread_slots)",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
         "MetricName": "tma_memory_operations",
@@ -1944,7 +1943,7 @@
         "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * INT_=
MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clks",
         "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
-        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch_r=
esteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_bottleneck_mispredictions, tma_branch_mispredicts, tma_info_bad=
_spec_branch_misprediction_cost",
         "ScaleUnit": "100%"
     },
@@ -1958,17 +1957,17 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued , the Count Do=
main; [ADL+] cycles)",
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued -- the Count D=
omain; [ADL+] cycles)",
         "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / tma_info_thread_clks",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_utili=
zed_0_group",
         "MetricName": "tma_mixing_vectors",
         "MetricThreshold": "tma_mixing_vectors > 0.05",
-        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued , the Count D=
omain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investigat=
ing. Read more in Appendix B1 of the Optimizations Guide for this topic. Re=
lated metrics: tma_ms_switches",
+        "PublicDescription": "This metric estimates penalty in terms of pe=
rcentage of([SKL+] injected blend uops out of all Uops Issued -- the Count =
Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investiga=
ting. Read more in Appendix B1 of the Optimizations Guide for this topic. R=
elated metrics: tma_ms_switches",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details",
-        "MetricExpr": "max(IDQ.MS_CYCLES_ANY, cpu@UOPS_RETIRED.MS\\,cmask\=
\=3D0x1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY)) / tma_info_core_core_clk=
s / 2",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details.",
+        "MetricExpr": "max(IDQ.MS_CYCLES_ANY, cpu@UOPS_RETIRED.MS\\,cmask\=
\=3D1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY)) / tma_info_core_core_clks =
/ 2",
         "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
         "MetricName": "tma_ms",
         "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
@@ -1976,10 +1975,10 @@
     },
     {
         "BriefDescription": "This metric estimates the fraction of cycles =
when the CPU was stalled due to switches of uop delivery to the Microcode S=
equencer (MS)",
-        "MetricExpr": "3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge\\=3D=
0x1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY) / tma_info_thread_clks",
+        "MetricExpr": "3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge@ / (UO=
PS_RETIRED.SLOTS / UOPS_ISSUED.ANY) / tma_info_thread_clks",
         "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
         "MetricName": "tma_ms_switches",
-        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency > 0=
.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric estimates the fraction of cycles=
 when the CPU was stalled due to switches of uop delivery to the Microcode =
Sequencer (MS). Commonly used instructions are optimized for delivery by th=
e DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Cert=
ain operations cannot be handled natively by the execution pipeline; and mu=
st be performed by microcode (small programs injected into the execution st=
ream). Switching to the MS too often can negatively impact performance. The=
 MS is designated to deliver long uop flows required by CISC instructions l=
ike CPUID; or uncommon conditions like Floating Point Assists when dealing =
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_bottlene=
ck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clear=
s, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_operation",
         "ScaleUnit": "100%"
     },
@@ -1989,7 +1988,7 @@
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
         "ScaleUnit": "100%"
     },
     {
@@ -1997,7 +1996,7 @@
         "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_thread_slots)",
         "MetricGroup": "BvBO;Pipeline;TopdownL4;tma_L4_group;tma_other_lig=
ht_ops_group",
         "MetricName": "tma_nop_instructions",
-        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_other_light_o=
ps > 0.3 & tma_light_operations > 0.6",
+        "MetricThreshold": "tma_nop_instructions > 0.1 & (tma_other_light_=
ops > 0.3 & tma_light_operations > 0.6)",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
         "ScaleUnit": "100%"
     },
@@ -2011,19 +2010,19 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types)",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED.A=
LL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
         "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
-        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_misp=
redicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
         "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMORY=
_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
         "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
-        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears > =
0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
@@ -2032,7 +2031,7 @@
         "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
         "MetricName": "tma_page_faults",
         "MetricThreshold": "tma_page_faults > 0.05",
-        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost",
+        "PublicDescription": "This metric roughly estimates fraction of sl=
ots the CPU retired uops as a result of handing Page Faults. A Page Fault m=
ay apply on first application access to a memory page. Note operating syste=
m handling of page faults accounts for the majority of its cost.",
         "ScaleUnit": "100%"
     },
     {
@@ -2041,7 +2040,7 @@
         "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utilizat=
ion_group;tma_issue2P",
         "MetricName": "tma_port_0",
         "MetricThreshold": "tma_port_0 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_int_vector_128b, tma_int_vector_256b, tma_port_1, tma_port_6, tma_po=
rts_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd =
branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_scala=
r, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512=
b, tma_int_vector_128b, tma_int_vector_256b, tma_port_1, tma_port_5, tma_po=
rt_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -2050,7 +2049,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_1",
         "MetricThreshold": "tma_port_1 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_ve=
ctor_256b, tma_port_0, tma_port_6, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPATC=
HED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_12=
8b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_ve=
ctor_256b, tma_port_0, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -2059,7 +2058,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_por=
ts_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_por=
t_5, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -2067,8 +2066,8 @@
         "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (EX=
E_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_3_PORTS_UTIL)) / tm=
a_info_thread_clks if ARITH.DIV_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - EXE_=
ACTIVITY.BOUND_ON_LOADS else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EX=
E_ACTIVITY.2_3_PORTS_UTIL) / tma_info_thread_clks)",
         "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup",
         "MetricName": "tma_ports_utilization",
-        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_bound =
> 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations",
+        "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bound=
 > 0.1 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU performance was potentially limited due to Core computation issues (no=
n divider-related).  Two distinct categories can be attributed into this me=
tric: (1) heavy data-dependency among contiguous instructions would manifes=
t in this metric - such cases are often referred to as low Instruction Leve=
l Parallelism (ILP). (2) Contention on some hardware execution unit other t=
han Divider. For example; when there are too many multiply operations.",
         "ScaleUnit": "100%"
     },
     {
@@ -2076,8 +2075,8 @@
         "MetricExpr": "max(EXE_ACTIVITY.EXE_BOUND_0_PORTS - RESOURCE_STALL=
S.SCOREBOARD, 0) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
-        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric",
+        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed no uops on any execution port (Logical Processor cycles since IC=
L, Physical Core cycles otherwise). Long-latency instructions like divides =
may contribute to this metric.",
         "ScaleUnit": "100%"
     },
     {
@@ -2085,7 +2084,7 @@
         "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_1",
-        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utiliza=
tion > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
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
         "ScaleUnit": "100%"
     },
@@ -2095,8 +2094,8 @@
         "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
-        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6",
         "ScaleUnit": "100%"
     },
     {
@@ -2105,7 +2104,7 @@
         "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
         "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
-        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
         "ScaleUnit": "100%"
     },
@@ -2114,8 +2113,8 @@
         "MetricExpr": "(MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM * MEM_LOAD_L3=
_MISS_RETIRED.REMOTE_HITM:R + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_FWD:R) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_R=
ETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
         "MetricName": "tma_remote_cache",
-        "MetricThreshold": "tma_remote_cache > 0.05 & tma_mem_latency > 0.=
1 & tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. Sample with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM, MEM=
_LOAD_L3_MISS_RETIRED.REMOTE_FWD. Related metrics: tma_bottleneck_memory_sy=
nchronization, tma_contested_accesses, tma_data_sharing, tma_false_sharing,=
 tma_machine_clears",
+        "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article. Sample with: MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_HITM_PS;MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD_PS. Related metri=
cs: tma_bottleneck_memory_synchronization, tma_contested_accesses, tma_data=
_sharing, tma_false_sharing, tma_machine_clears",
         "ScaleUnit": "100%"
     },
     {
@@ -2123,22 +2122,22 @@
         "MetricExpr": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * MEM_LOAD_L3_=
MISS_RETIRED.REMOTE_DRAM:R * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRE=
D.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_mem",
-        "MetricThreshold": "tma_remote_mem > 0.1 & tma_mem_latency > 0.1 &=
 tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.REMOTE_DRAM",
+        "MetricThreshold": "tma_remote_mem > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article. Sample=
 with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by (indirect) RET instruction=
s",
+        "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to retired misprediction by (indirect) RET instruction=
s.",
         "MetricExpr": "BR_MISP_RETIRED.RET_COST * BR_MISP_RETIRED.RET_COST=
:R / tma_info_thread_clks",
         "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
         "MetricName": "tma_ret_mispredicts",
-        "MetricThreshold": "tma_ret_mispredicts > 0.05 & tma_branch_mispre=
dicts > 0.1 & tma_bad_speculation > 0.15",
+        "MetricThreshold": "tma_ret_mispredicts > 0.05 & (tma_branch_mispr=
edicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_=
thread_slots",
         "MetricGroup": "BvUW;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -2151,7 +2150,7 @@
         "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks +=
 tma_c02_wait",
         "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_bou=
nd_group;tma_issueSO",
         "MetricName": "tma_serializing_operation",
-        "MetricThreshold": "tma_serializing_operation > 0.1 & tma_core_bou=
nd > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_bo=
und > 0.1 & tma_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
         "ScaleUnit": "100%"
     },
@@ -2160,8 +2159,8 @@
         "MetricExpr": "tma_light_operations * INT_VEC_RETIRED.SHUFFLES / (=
tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_other_ligh=
t_ops_group",
         "MetricName": "tma_shuffles_256b",
-        "MetricThreshold": "tma_shuffles_256b > 0.1 & tma_other_light_ops =
> 0.3 & tma_light_operations > 0.6",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers",
+        "MetricThreshold": "tma_shuffles_256b > 0.1 & (tma_other_light_ops=
 > 0.3 & tma_light_operations > 0.6)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring Shuffle operations of 256-bit vector size (FP or In=
teger). Shuffles may incur slow cross \"vector lane\" data transfers.",
         "ScaleUnit": "100%"
     },
     {
@@ -2170,26 +2169,26 @@
         "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
-        "MetricThreshold": "tma_slow_pause > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTED.=
PAUSE_INST",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles hand=
ling memory load split accesses - load that cross 64-byte cache line bounda=
ry",
-        "MetricExpr": "(min(MEM_INST_RETIRED.SPLIT_LOADS * MEM_INST_RETIRE=
D.SPLIT_LOADS:R, MEM_INST_RETIRED.SPLIT_LOADS * tma_info_memory_load_miss_r=
eal_latency) if 0 < MEM_INST_RETIRED.SPLIT_LOADS:R else MEM_INST_RETIRED.SP=
LIT_LOADS * tma_info_memory_load_miss_real_latency) / tma_info_thread_clks"=
,
+        "MetricExpr": "MEM_INST_RETIRED.SPLIT_LOADS * min(MEM_INST_RETIRED=
.SPLIT_LOADS:R, tma_info_memory_load_miss_real_latency) / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_split_loads",
         "MetricThreshold": "tma_split_loads > 0.3",
-        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS",
+        "PublicDescription": "This metric estimates fraction of cycles han=
dling memory load split accesses - load that cross 64-byte cache line bound=
ary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents rate of split store ac=
cesses",
-        "MetricExpr": "(min(MEM_INST_RETIRED.SPLIT_STORES * MEM_INST_RETIR=
ED.SPLIT_STORES:R, MEM_INST_RETIRED.SPLIT_STORES) if 0 < MEM_INST_RETIRED.S=
PLIT_STORES:R else MEM_INST_RETIRED.SPLIT_STORES) / tma_info_thread_clks",
+        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES * min(MEM_INST_RETIRE=
D.SPLIT_STORES:R, 1) / tma_info_thread_clks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_bou=
nd_group",
         "MetricName": "tma_split_stores",
-        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0.2=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES",
+        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > 0.=
2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric represents rate of split store a=
ccesses.  Consider aligning your data to the 64-byte cache line granularity=
. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS. Related metrics: tma_port_=
4",
         "ScaleUnit": "100%"
     },
     {
@@ -2197,7 +2196,7 @@
         "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / tma_in=
fo_thread_clks",
         "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
-        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tma_=
memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_bottlen=
eck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma_m=
em_bandwidth",
         "ScaleUnit": "100%"
     },
@@ -2206,8 +2205,8 @@
         "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_thread_clks=
",
         "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_me=
mory_bound_group",
         "MetricName": "tma_store_bound",
-        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES",
+        "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
+        "PublicDescription": "This metric estimates how often CPU was stal=
led  due to RFO store memory accesses; RFO store issue a read-for-ownership=
 request before the write. Even though store accesses do not typically stal=
l out-of-order CPUs; there are few cases where stores can lead to actual st=
alls. This metric will be flagged should RFO stores be a bottleneck. Sample=
 with: MEM_INST_RETIRED.ALL_STORES_PS",
         "ScaleUnit": "100%"
     },
     {
@@ -2215,8 +2214,8 @@
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_store_fwd_blk",
-        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1 &=
 tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading",
+        "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles when the memory subsystem had loads blocked since they could not forwa=
rd data from earlier (in program order) overlapping stores. To streamline m=
emory operations in the pipeline; a load can avoid waiting for memory if a =
prior in-flight store is writing the data that the load wants to read (stor=
e forwarding process). However; in some cases the load may be blocked for a=
 significant time pending the store forward. For example; when the prior st=
ore is writing a smaller region than the load is reading.",
         "ScaleUnit": "100%"
     },
     {
@@ -2224,8 +2223,8 @@
         "MetricExpr": "(MEM_STORE_RETIRED.L2_HIT * 10 * (1 - MEM_INST_RETI=
RED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_=
LOADS / MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE=
_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
         "MetricGroup": "BvML;LockCont;MemoryLat;Offcore;TopdownL4;tma_L4_g=
roup;tma_issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
-        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma_l=
3_hit_latency, tma_lock_latency",
+        "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
         "ScaleUnit": "100%"
     },
     {
@@ -2242,7 +2241,7 @@
         "MetricExpr": "max(0, tma_dtlb_store - tma_store_stlb_miss)",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_hit",
-        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store > 0=
.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > =
0.2",
+        "MetricThreshold": "tma_store_stlb_hit > 0.05 & (tma_dtlb_store > =
0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2)))",
         "ScaleUnit": "100%"
     },
     {
@@ -2250,31 +2249,31 @@
         "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_core_=
clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_miss",
-        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store > =
0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
+        "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses.",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_1G / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_1g",
-        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & (tma_store_stl=
b_miss > 0.05 & (tma_dtlb_store > 0.05 & (tma_store_bound > 0.2 & (tma_memo=
ry_bound > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses.",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_2M_4M / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_C=
OMPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_2m",
-        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & (tma_store_stl=
b_miss > 0.05 & (tma_dtlb_store > 0.05 & (tma_store_bound > 0.2 & (tma_memo=
ry_bound > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses",
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses.",
         "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_4K / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
         "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
         "MetricName": "tma_store_stlb_miss_4k",
-        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & (tma_store_stl=
b_miss > 0.05 & (tma_dtlb_store > 0.05 & (tma_store_bound > 0.2 & (tma_memo=
ry_bound > 0.2 & tma_backend_bound > 0.2))))",
         "ScaleUnit": "100%"
     },
     {
@@ -2282,7 +2281,7 @@
         "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_thread=
_clks",
         "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueS=
mSt;tma_store_bound_group",
         "MetricName": "tma_streaming_stores",
-        "MetricThreshold": "tma_streaming_stores > 0.2 & tma_store_bound >=
 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates how often CPU was stal=
led  due to Streaming store memory accesses; Streaming store optimize out a=
 read request required by RFO stores. Even though store accesses do not typ=
ically stall out-of-order CPUs; there are few cases where stores can lead t=
o actual stalls. This metric will be flagged should Streaming stores be a b=
ottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: tma=
_fb_full",
         "ScaleUnit": "100%"
     },
@@ -2291,7 +2290,7 @@
         "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / tma_info_thread_cl=
ks",
         "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
         "MetricName": "tma_unknown_branches",
-        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_reste=
ers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "ScaleUnit": "100%"
     },
@@ -2300,8 +2299,8 @@
         "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
         "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
         "MetricName": "tma_x87_use",
-        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma_l=
ight_operations > 0.6",
-        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint",
+        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
+        "PublicDescription": "This metric serves as an approximation of le=
gacy x87 usage. It accounts for instructions beyond X87 FP arithmetic opera=
tions; hence may be used as a thermometer to avoid X87 high usage and prefe=
rably upgrade to modern ISA. See Tip under Tuning Hint.",
         "ScaleUnit": "100%"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/memory.json b/too=
ls/perf/pmu-events/arch/x86/graniterapids/memory.json
index 5da5a10275ba..deddfb4686e1 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/memory.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/memory.json
@@ -194,6 +194,16 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the local socket's L1, L=
2, or L3 caches.",
         "Counter": "0,1,2,3",
@@ -204,6 +214,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM attached to this socket=
, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM=
 accesses that are controlled by the close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the local socket's L1, L2, or L3 caches.",
         "Counter": "0,1,2,3",
@@ -214,6 +244,36 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C000002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were n=
ot supplied by the local socket's L1, L2, or L3 caches.",
         "Counter": "0,1,2,3",
@@ -224,6 +284,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mo=
de.  In SNC Mode counts only those DRAM accesses that are controlled by the=
 close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104000002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x73C004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches.",
         "Counter": "0,1,2,3",
@@ -254,6 +334,56 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA =
Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are co=
ntrolled by the close SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x104004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, whether or not in S=
ub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are contr=
olled by the close or distant SNC Cluster.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x70C004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x730004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM or PMM attached to another socket.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.REMOTE_MEMORY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x733004477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts Demand RFOs, ItoM's, PREFECTHW's, Hard=
ware RFO Prefetches to the L1/L2 and Streaming stores that likely resulted =
in a store to Memory (DRAM or PMM)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.WRITE_ESTIMATE.MEMORY",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0xFBFF80822",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/other.json b/tool=
s/perf/pmu-events/arch/x86/graniterapids/other.json
index 8df37f303273..99fcdc341272 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/other.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/other.json
@@ -16,204 +16,6 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x8"
     },
-    {
-        "BriefDescription": "Counts the cycles where the AMX (Advance Matr=
ix Extension) unit is busy performing an operation.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xb7",
-        "EventName": "EXE.AMX_BUSY",
-        "SampleAfterValue": "2000003",
-        "UMask": "0x2"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x73C000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM attached to this socket=
, unless in Sub NUMA Cluster(SNC) Mode.  In SNC Mode counts only those DRAM=
 accesses that are controlled by the close SNC Cluster.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x104000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x73C000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mode.  In S=
NC Mode counts only those DRAM accesses that are controlled by the close SN=
C Cluster.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x104000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM attached to another socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_DATA_RD.REMOTE_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x730000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that have a=
ny type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F3FFC0002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_RFO.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x73C000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) reque=
sts and software prefetches for exclusive ownership (PREFETCHW) that were s=
upplied by DRAM attached to this socket, unless in Sub NUMA Cluster(SNC) Mo=
de.  In SNC Mode counts only those DRAM accesses that are controlled by the=
 close SNC Cluster.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x104000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts writebacks of modified cachelines and =
streaming stores that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.MODIFIED_WRITE.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10808",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F3FFC4477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x73C004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, unless in Sub NUMA =
Cluster(SNC) Mode.  In SNC Mode counts only those DRAM accesses that are co=
ntrolled by the close SNC Cluster.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x104004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to this socket, whether or not in S=
ub NUMA Cluster(SNC) Mode.  In SNC Mode counts DRAM accesses that are contr=
olled by the close or distant SNC Cluster.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.LOCAL_SOCKET_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x70C004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were not supplied by the local socket's L1, L2, or L3 caches and w=
ere supplied by a remote socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.REMOTE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F33004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM attached to another socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.REMOTE_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x730004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM or PMM attached to another socket.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.REMOTE_MEMORY",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x733004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all (cacheable) data read, code read a=
nd RFO requests including demands and prefetches to the core caches (L1 or =
L2) that were supplied by DRAM on a distant memory controller of this socke=
t when the system is in SNC (sub-NUMA cluster) mode.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.READS_TO_CORE.SNC_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x708004477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3",
@@ -224,45 +26,6 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts Demand RFOs, ItoM's, PREFECTHW's, Hard=
ware RFO Prefetches to the L1/L2 and Streaming stores that likely resulted =
in a store to Memory (DRAM or PMM)",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x2A,0x2B",
-        "EventName": "OCR.WRITE_ESTIMATE.MEMORY",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0xFBFF80822",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xa5",
-        "EventName": "RS.EMPTY",
-        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x7"
-    },
-    {
-        "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "CounterMask": "1",
-        "EdgeDetect": "1",
-        "EventCode": "0xa5",
-        "EventName": "RS.EMPTY_COUNT",
-        "Invert": "1",
-        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
-        "SampleAfterValue": "100003",
-        "UMask": "0x7"
-    },
-    {
-        "BriefDescription": "Cycles when RS was empty and a resource alloc=
ation stall is asserted",
-        "Counter": "0,1,2,3,4,5,6,7",
-        "EventCode": "0xa5",
-        "EventName": "RS.EMPTY_RESOURCE",
-        "SampleAfterValue": "1000003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Cycles the uncore cannot take further request=
s",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
index da6478607984..8530d93849fa 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
@@ -154,6 +154,9 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN_COST",
+        "RetirementLatencyMax": 888,
+        "RetirementLatencyMean": 6.11,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "400009",
         "UMask": "0x50"
     },
@@ -171,6 +174,9 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN_COST",
+        "RetirementLatencyMax": 2750,
+        "RetirementLatencyMean": 5.09,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "400009",
         "UMask": "0x41"
     },
@@ -197,6 +203,9 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL_COST",
+        "RetirementLatencyMax": 703,
+        "RetirementLatencyMean": 15.56,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "400009",
         "UMask": "0x42"
     },
@@ -205,6 +214,9 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_COST",
+        "RetirementLatencyMax": 1562,
+        "RetirementLatencyMean": 11.07,
+        "RetirementLatencyMin": 0,
         "SampleAfterValue": "100003",
         "UMask": "0xc0"
     },
@@ -239,6 +251,9 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET_COST",
+        "RetirementLatencyMax": 1082,
+        "RetirementLatencyMean": 32.37,
+        "RetirementLatencyMin": 9,
         "SampleAfterValue": "100007",
         "UMask": "0x48"
     },
@@ -401,6 +416,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts the cycles where the AMX (Advance Matr=
ix Extension) unit is busy performing an operation.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xb7",
+        "EventName": "EXE.AMX_BUSY",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x2"
+    },
     {
         "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -774,6 +797,35 @@
         "SampleAfterValue": "100003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY",
+        "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_COUNT",
+        "Invert": "1",
+        "PublicDescription": "Counts end of periods where the Reservation =
Station (RS) was empty. Could be useful to closely sample on front-end late=
ncy issues (see the FRONTEND_RETIRED event of designated precise events)",
+        "SampleAfterValue": "100003",
+        "UMask": "0x7"
+    },
+    {
+        "BriefDescription": "Cycles when RS was empty and a resource alloc=
ation stall is asserted",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_RESOURCE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "This event counts a subset of the Topdown Slo=
ts event that were not consumed by the back-end pipeline due to lack of bac=
k-end resources, as a result of memory subsystem delays, execution units li=
mitations, or other conditions.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
index 53055986534d..b782f6d54fc2 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
@@ -853,6 +853,16 @@
         "UMask": "0x8",
         "Unit": "CHA"
     },
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
     {
         "BriefDescription": "Ingress (from CMS) Occupancy : IRQ : Counts n=
umber of entries in the specified Ingress queue in each cycle.",
         "Counter": "0",
@@ -863,6 +873,38 @@
         "UMask": "0x1",
         "Unit": "CHA"
     },
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
     {
         "BriefDescription": "All TOR Inserts",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.=
json
index 5c50275c79b0..e5bd11b27bcd 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
@@ -1076,7 +1076,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for AD_BNC",
+        "BriefDescription": "Egress bypasses for AD_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.AD_BNC",
@@ -1086,7 +1086,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for AD_CRD",
+        "BriefDescription": "Egress bypasses for AD_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.AD_CRD",
@@ -1096,7 +1096,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for AK",
+        "BriefDescription": "Egress bypasses for AK",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.AK",
@@ -1106,7 +1106,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for BL_BNC",
+        "BriefDescription": "Egress bypasses for BL_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.BL_BNC",
@@ -1116,7 +1116,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for BL_CRD",
+        "BriefDescription": "Egress bypasses for BL_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.BL_CRD",
@@ -1126,7 +1126,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress bypasses for for IV",
+        "BriefDescription": "Egress bypasses for IV",
         "Counter": "0,1,2,3",
         "EventCode": "0x1E",
         "EventName": "UNC_MDF_TxR_BYPASS.IV",
@@ -1136,7 +1136,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for AD_BNC",
+        "BriefDescription": "Number of egress inserts for AD_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.AD_BNC",
@@ -1146,7 +1146,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for AD_CRD",
+        "BriefDescription": "Number of egress inserts for AD_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.AD_CRD",
@@ -1156,7 +1156,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for AK",
+        "BriefDescription": "Number of egress inserts for AK",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.AK",
@@ -1166,7 +1166,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for BL_BNC",
+        "BriefDescription": "Number of egress inserts for BL_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.BL_BNC",
@@ -1176,7 +1176,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for BL_CRD",
+        "BriefDescription": "Number of egress inserts for BL_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.BL_CRD",
@@ -1186,7 +1186,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Number of egress inserts for for IV",
+        "BriefDescription": "Number of egress inserts for IV",
         "Counter": "0,1,2,3",
         "EventCode": "0x1C",
         "EventName": "UNC_MDF_TxR_INSERTS.IV",
@@ -1196,7 +1196,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for AD_BNC",
+        "BriefDescription": "Egress occupancy for AD_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.AD_BNC",
@@ -1206,7 +1206,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for AD_CRD",
+        "BriefDescription": "Egress occupancy for AD_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.AD_CRD",
@@ -1216,7 +1216,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for AK",
+        "BriefDescription": "Egress occupancy for AK",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.AK",
@@ -1226,7 +1226,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for BL_BNC",
+        "BriefDescription": "Egress occupancy for BL_BNC",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.BL_BNC",
@@ -1236,7 +1236,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for BL_CRD",
+        "BriefDescription": "Egress occupancy for BL_CRD",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.BL_CRD",
@@ -1246,7 +1246,7 @@
         "Unit": "MDF"
     },
     {
-        "BriefDescription": "Egress occupancy for for IV",
+        "BriefDescription": "Egress occupancy for IV",
         "Counter": "0,1,2,3",
         "EventCode": "0x1D",
         "EventName": "UNC_MDF_TxR_OCCUPANCY.IV",
@@ -1932,5 +1932,59 @@
         "Experimental": "1",
         "PerPkg": "1",
         "Unit": "UPI"
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
+        "Experimental": "1",
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
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.jso=
n b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
index 5f4783ff6ce5..b991f6e1afbe 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
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
@@ -478,6 +630,94 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index ed7a1845d43d..579b4fbd65d6 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.11,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.07,grandridge,core
-GenuineIntel-6-A[DE],v1.06,graniterapids,core
+GenuineIntel-6-A[DE],v1.08,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
--=20
2.49.0.395.g12beb8f557-goog

