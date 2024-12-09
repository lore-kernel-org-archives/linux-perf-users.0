Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778019F43A
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783359; cv=none; b=ME97/ui5nTuYjbruOxkWNyLBtAPRq+xIOyTSkY0467C6ygFeIfK5DTQSgTW8n2THtwpWBv1W1NdL/MYi3C70KV1XOnxfqNPZzM7eh9OIUAtDMCUho74hmcsRXLA0RAoTotcqVFivozKb6ojYgMiQvrGUjM1LKA2v7FdBFuTcC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783359; c=relaxed/simple;
	bh=4JYnVh8CbLD7fl3w8V9WirRqL+rSvpskmlxDXlXC/EI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qtBKZd9MRDJvp0A8nhO5JVdEDH1UKypDmgmtLymVgECoMjeSuaZUHhLkteeKgmvwEd7upD7hY1MHqNXjb5pUrwHddrEKkrRBCxCdnp8gfoHqwMkz4QWywsokTj9n4OWfmULje+3pvWSJDmL8RISYTf7B74cGc6EPeH/PiSXVfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzXxFsTZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzXxFsTZ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3a109984a5so1109091276.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 14:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733783322; x=1734388122; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5ndn5M7EvReNq3EH//NyZbg7bX6Ay49WvetmEKoUBE=;
        b=fzXxFsTZefUYKrwCQROuwkYcI0HDdM2VZ72PIHweNmuamM8QP9MzAd5/v7ZRRk6k/V
         IY2WZsTGim1PXy6B5R2ybYOUR+eHSP7DzfU+OBaCJwKgghZi5F9J0TfayblIKG1htj1X
         LeaT9tvkGJPHp383Hr/lhRPCe4jWj5T5xGCGtEqHtzmxV6SSe1ojhhb3vQDWmjguZb+v
         7O4RFw5rcWkwp8hXi+OD/+CYN9MGUXbB6ltO1it8te3E/Ap6Gu9W4ZVWJMSfHGnRH101
         Nt0LWUoNWd0tBkRHNwTOBqjC09DS0f0QtBkSSLPdjD/bg7NwPsmSpEpFN+SY/qo4OkCv
         f1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733783322; x=1734388122;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e5ndn5M7EvReNq3EH//NyZbg7bX6Ay49WvetmEKoUBE=;
        b=Oba8lUdITThl2n4A3y2mKnjFzCpjSsVvWVxOBkF+bqLpZe2AppNzbPt0G16xNKfB5j
         cGiAFeRk9TriyJM+/+OQGsAKnRIislqgjD8CVQzLLPuSM6dC9X6eOklJ0L6St9Cd4HQ0
         43o5ckuGpTeDsUYdkhw35yj44jtjfQalu8o9gip4E4ZsB96NRWa2LSWRq9656KpwmbPM
         HOXDjxeg1Yz3uPzzBqnSCSA61Xuwb9YTzs9162ln0sOR7lG/C20FQT4tn0+WHhUwLQR3
         fUWxMq7OUz7fiyfibPOQGPuHy/YyUpoJhYVxOFKfOXyGBGtsc/RSgfN8yOzKLHTYJguq
         dlYA==
X-Forwarded-Encrypted: i=1; AJvYcCWLP04CC22NXJ9S9Xn+Gx8BCDmFrjlyk3puhzSyvrcai7P1gkTur0ppAiJcMuhZTwZJetdk/P1gp6dEM6QXX+ha@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNXqEndxZfmxf9iSX+s7ghLy7/eudAAXs88omf9cMGoB7YTEp
	273hf8LjmW/1E5J3+2lA8hM6ZR7Vu6g5SjGG5tcmY9uERBBEXu2sK56i7Y+qQF0+Hptt7fMZmqu
	ooyzbaw==
X-Google-Smtp-Source: AGHT+IECDovSrLGZ1bDxuKNZrIvK1Y8piYxcMOqCcqjIPRTbNQctj2LvgTU0U/kUqXtBMpBQ857MphAyPtPX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c8f1:280e:e8ad:32])
 (user=irogers job=sendgmr) by 2002:a25:dccb:0:b0:e39:8986:98b0 with SMTP id
 3f1490d57ef6-e3a0b522f92mr7056276.9.1733783321837; Mon, 09 Dec 2024 14:28:41
 -0800 (PST)
Date: Mon,  9 Dec 2024 14:27:51 -0800
In-Reply-To: <20241209222800.296000-1-irogers@google.com>
Message-Id: <20241209222800.296000-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241209222800.296000-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Subject: [PATCH v1 14/22] perf vendor events: Update IcelakeX events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.26 to v1.27.
Update TMA metrics from 4.8 to 5.01.

Bring in the event updates v1.27:
https://github.com/intel/perfmon/commit/6ee80d0532a778caee68d6e29d8e0527856=
7e69f

The TMA 5.01 update is from (with subsequent fixes):
https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5c2=
2d782

Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/icelakex/cache.json   |  41 +-
 .../arch/x86/icelakex/frontend.json           |  17 -
 .../arch/x86/icelakex/icx-metrics.json        | 852 ++++++++++--------
 .../pmu-events/arch/x86/icelakex/memory.json  |  13 +-
 .../arch/x86/icelakex/metricgroups.json       |  10 +-
 .../arch/x86/icelakex/pipeline.json           |  30 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 7 files changed, 533 insertions(+), 432 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/cache.json b/tools/per=
f/pmu-events/arch/x86/icelakex/cache.json
index 0cbb9d6a3ec1..e8ab6ef2cd50 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/cache.json
@@ -75,14 +75,23 @@
         "UMask": "0x2"
     },
     {
-        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache when triggered by an L2 cache fill.",
+        "BriefDescription": "Non-modified cache lines that are silently dr=
opped by L2 cache.",
         "Counter": "0,1,2,3",
         "EventCode": "0xF2",
         "EventName": "L2_LINES_OUT.SILENT",
-        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache when triggered by an L2 cache fill. These lines are ty=
pically in Shared or Exclusive state. A non-threaded event.",
+        "PublicDescription": "Counts the number of lines that are silently=
 dropped by L2 cache. These lines are typically in Shared or Exclusive stat=
e. A non-threaded event.",
         "SampleAfterValue": "200003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0xf2",
+        "EventName": "L2_LINES_OUT.USELESS_HWPF",
+        "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "L2 code requests",
         "Counter": "0,1,2,3",
@@ -224,7 +233,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired load instructions. This e=
vent accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1/2=
 or PREFETCHW.",
         "SampleAfterValue": "1000003",
         "UMask": "0x81"
@@ -235,7 +243,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired store instructions.",
         "SampleAfterValue": "1000003",
         "UMask": "0x82"
@@ -246,7 +253,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
-        "PEBS": "1",
         "PublicDescription": "Counts all retired memory instructions - loa=
ds and stores.",
         "SampleAfterValue": "1000003",
         "UMask": "0x83"
@@ -257,7 +263,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with locked=
 access.",
         "SampleAfterValue": "100007",
         "UMask": "0x21"
@@ -268,7 +273,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions that split =
across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x41"
@@ -279,7 +283,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
-        "PEBS": "1",
         "PublicDescription": "Counts retired store instructions that split=
 across a cacheline boundary.",
         "SampleAfterValue": "100003",
         "UMask": "0x42"
@@ -290,7 +293,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Number of retired load instructions that (st=
art a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x11"
@@ -301,7 +303,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
-        "PEBS": "1",
         "PublicDescription": "Number of retired store instructions that (s=
tart a) miss in the 2nd-level TLB (STLB).",
         "SampleAfterValue": "100003",
         "UMask": "0x12"
@@ -312,7 +313,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were HitM responses from shared L3.",
         "SampleAfterValue": "20011",
         "UMask": "0x4"
@@ -324,7 +324,6 @@
         "Deprecated": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "20011",
         "UMask": "0x2"
     },
@@ -335,7 +334,6 @@
         "Deprecated": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
-        "PEBS": "1",
         "SampleAfterValue": "20011",
         "UMask": "0x4"
     },
@@ -345,7 +343,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts the retired load instructions whose d=
ata sources were L3 hit and cross-core snoop missed in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x1"
@@ -356,7 +353,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were hits in L3 without snoops required.",
         "SampleAfterValue": "100003",
         "UMask": "0x8"
@@ -367,7 +363,6 @@
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions whose data =
sources were L3 and cross-core snoop hits in on-pkg core cache.",
         "SampleAfterValue": "20011",
         "UMask": "0x2"
@@ -378,7 +373,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
-        "PEBS": "1",
         "PublicDescription": "Retired load instructions which data sources=
 missed L3 but serviced from local DRAM.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -389,7 +383,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM",
-        "PEBS": "1",
         "SampleAfterValue": "100007",
         "UMask": "0x2"
     },
@@ -399,7 +392,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD",
-        "PEBS": "1",
         "PublicDescription": "Retired load instructions whose data sources=
 was forwarded from a remote cache.",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
@@ -410,7 +402,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM",
-        "PEBS": "1",
         "PublicDescription": "Retired load instructions whose data sources=
 was remote HITM.",
         "SampleAfterValue": "100007",
         "UMask": "0x4"
@@ -421,7 +412,6 @@
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with remote=
 Intel(R) Optane(TM) DC persistent memory as the data source and the data r=
equest missed L3 (AppDirect or Memory Mode) and DRAM cache(Memory Mode).",
         "SampleAfterValue": "100007",
         "UMask": "0x10"
@@ -432,7 +422,6 @@
         "Data_LA": "1",
         "EventCode": "0xd4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions with at least one load =
to uncacheable memory-type, or at least one cache-line split locked access =
(Bus Lock).",
         "SampleAfterValue": "100007",
         "UMask": "0x4"
@@ -443,7 +432,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop was load missed in L1 but hit FB (Fill Buffers) due to preceding=
 miss to the same cache line with data not ready.",
         "SampleAfterValue": "100007",
         "UMask": "0x40"
@@ -454,7 +442,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L1 data cache. This event includes all SW prefet=
ches and lock instructions regardless of the data source.",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
@@ -465,7 +452,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L1 cache.",
         "SampleAfterValue": "200003",
         "UMask": "0x8"
@@ -476,7 +462,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with L2 cac=
he hits as data sources.",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
@@ -487,7 +472,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions missed L2 c=
ache as data sources.",
         "SampleAfterValue": "100021",
         "UMask": "0x10"
@@ -498,7 +482,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that hit in the L3 cache.",
         "SampleAfterValue": "100021",
         "UMask": "0x4"
@@ -509,7 +492,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with at lea=
st one uop that missed in the L3 cache.",
         "SampleAfterValue": "50021",
         "UMask": "0x20"
@@ -520,7 +502,6 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.LOCAL_PMM",
-        "PEBS": "1",
         "PublicDescription": "Counts retired load instructions with local =
Intel(R) Optane(TM) DC persistent memory as the data source and the data re=
quest missed L3 (AppDirect or Memory Mode) and DRAM cache(Memory Mode).",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/frontend.json b/tools/=
perf/pmu-events/arch/x86/icelakex/frontend.json
index d79ddc15b220..3b1bdcfaa276 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/frontend.json
@@ -44,7 +44,6 @@
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x1",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -56,7 +55,6 @@
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x11",
-        "PEBS": "1",
         "PublicDescription": "Number of retired Instructions that experien=
ced a critical DSB (Decode stream buffer i.e. the decoded instruction-cache=
) miss. Critical means stalls were exposed to the back-end as a result of t=
he DSB miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -68,7 +66,6 @@
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x14",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 iTLB (Instruction TLB) true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -80,7 +77,6 @@
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x12",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L1 Cache true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -92,7 +88,6 @@
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x13",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions who experienced =
Instruction L2 Cache true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -104,7 +99,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x500106",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
1 cycle which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -116,7 +110,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x508006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 12=
8 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -128,7 +121,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x501006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 16 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -140,7 +132,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x500206",
-        "PEBS": "1",
         "PublicDescription": "Retired instructions that are fetched after =
an interval where the front-end delivered no uops for a period of at least =
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -152,7 +143,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x510006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 25=
6 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -164,7 +154,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x100206",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after the front-end had at least 1 bubble-slot for a per=
iod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while there =
was no RAT stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -176,7 +165,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x502006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 32 cycles. During th=
is period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -188,7 +176,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x500406",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 4 =
cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -200,7 +187,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x520006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 51=
2 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -212,7 +198,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x504006",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are fetched=
 after an interval where the front-end delivered no uops for a period of 64=
 cycles which was not interrupted by a back-end stall.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -224,7 +209,6 @@
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x500806",
-        "PEBS": "1",
         "PublicDescription": "Counts retired instructions that are deliver=
ed to the back-end after a front-end stall of at least 8 cycles. During thi=
s period the front-end delivered no uops.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -236,7 +220,6 @@
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
         "MSRValue": "0x15",
-        "PEBS": "1",
         "PublicDescription": "Counts retired Instructions that experienced=
 STLB (2nd level TLB) true miss.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/too=
ls/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index db5510ba9099..7bee03e532e4 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -34,7 +34,7 @@
         "MetricName": "UNCORE_FREQ"
     },
     {
-        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
         "MetricName": "cpi",
         "ScaleUnit": "1per_instr"
@@ -55,49 +55,55 @@
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte page sizes) caused by demand data loads to the total number of c=
ompleted instructions",
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRE=
D.ANY",
         "MetricName": "dtlb_2nd_level_2mb_large_page_load_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte page sizes) caused by demand data loads to the total number of =
completed instructions. This implies it missed in the Data Translation Look=
aside Buffer (DTLB) and further levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte page sizes) caused by demand data loads to the total number of =
completed instructions. This implies it missed in the Data Translation Look=
aside Buffer (DTLB) and further levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data loads to the total number of complete=
d instructions",
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETIRED.ANY"=
,
         "MetricName": "dtlb_2nd_level_load_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data loads to the total number of complet=
ed instructions. This implies it missed in the DTLB and further levels of T=
LB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by demand data stores to the total number of complet=
ed instructions",
         "MetricExpr": "DTLB_STORE_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
         "MetricName": "dtlb_2nd_level_store_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by demand data stores to the total number of comple=
ted instructions. This implies it missed in the DTLB and further levels of =
TLB",
         "ScaleUnit": "1per_instr"
     },
     {
-        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the local CPU socket.=
",
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_HIT_PCIRDCUR + UNC_CHA_TOR_=
INSERTS.IO_MISS_PCIRDCUR) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_read",
+        "ScaleUnit": "1MB/s"
+    },
+    {
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the local CPU socket"=
,
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL * 64 / 1e6 / =
duration_time",
         "MetricName": "io_bandwidth_read_local",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from a remote CPU socket."=
,
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from a remote CPU socket",
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_REMOTE * 64 / 1e6 /=
 duration_time",
         "MetricName": "io_bandwidth_read_remote",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU.",
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the CPU",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_INSE=
RTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TOR_I=
NSERTS.IO_MISS_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
         "MetricName": "io_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the local CPU socket.",
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the local CPU socket",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM_LOCAL + UNC_CHA_TOR_IN=
SERTS.IO_ITOMCACHENEAR_LOCAL) * 64 / 1e6 / duration_time",
         "MetricName": "io_bandwidth_write_local",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to a remote CPU socket.",
+        "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to a remote CPU socket",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM_REMOTE + UNC_CHA_TOR_I=
NSERTS.IO_ITOMCACHENEAR_REMOTE) * 64 / 1e6 / duration_time",
         "MetricName": "io_bandwidth_write_remote",
         "ScaleUnit": "1MB/s"
@@ -106,14 +112,14 @@
         "BriefDescription": "Ratio of number of completed page walks (for =
2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total n=
umber of completed instructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED_2M_4M / INST_RETIRED.ANY=
",
         "MetricName": "itlb_2nd_level_large_page_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 2 megabyte and 4 megabyte page sizes) caused by a code fetch to the total =
number of completed instructions. This implies it missed in the Instruction=
 Translation Lookaside Buffer (ITLB) and further levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
         "MetricName": "itlb_2nd_level_mpi",
-        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB.",
+        "PublicDescription": "Ratio of number of completed page walks (for=
 all page sizes) caused by a code fetch to the total number of completed in=
structions. This implies it missed in the ITLB (Instruction TLB) and furthe=
r levels of TLB",
         "ScaleUnit": "1per_instr"
     },
     {
@@ -164,6 +170,12 @@
         "MetricName": "llc_code_read_mpi_demand_plus_prefetch",
         "ScaleUnit": "1per_instr"
     },
+    {
+        "BriefDescription": "Ratio of number of data read requests missing=
 last level core cache (includes demand w/ prefetches) to the total number =
of completed instructions",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_LLCPREFDATA + UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF) / INST_RETI=
RED.ANY",
+        "MetricName": "llc_data_read_mpi_demand_plus_prefetch",
+        "ScaleUnit": "1per_instr"
+    },
     {
         "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) in nano seconds",
         "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_CHA_TOR_=
OCCUPANCY.IA_MISS_DRD) * #num_packages)) * duration_time",
@@ -182,6 +194,12 @@
         "MetricName": "llc_demand_data_read_miss_latency_for_remote_reques=
ts",
         "ScaleUnit": "1ns"
     },
+    {
+        "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to DRAM in nano seconds=
",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_DDR) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_=
CHA_TOR_OCCUPANCY.IA_MISS_DRD_DDR) * #num_packages)) * duration_time",
+        "MetricName": "llc_demand_data_read_miss_to_dram_latency",
+        "ScaleUnit": "1ns"
+    },
     {
         "BriefDescription": "Average latency of a last level cache (LLC) d=
emand data read miss (read memory access) addressed to Intel(R) Optane(TM) =
Persistent Memory(PMEM) in nano seconds",
         "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC_=
CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / (UNC_CHA_CLOCKTICKS / (source_count(UNC_=
CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM) * #num_packages)) * duration_time",
@@ -189,25 +207,25 @@
         "ScaleUnit": "1ns"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory.",
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to local memory",
         "MetricExpr": "UNC_CHA_REQUESTS.READS_LOCAL * 64 / 1e6 / duration_=
time",
         "MetricName": "llc_miss_local_memory_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory.",
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to local memory",
         "MetricExpr": "UNC_CHA_REQUESTS.WRITES_LOCAL * 64 / 1e6 / duration=
_time",
         "MetricName": "llc_miss_local_memory_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory.",
+        "BriefDescription": "Bandwidth (MB/sec) of read requests that miss=
 the last level cache (LLC) and go to remote memory",
         "MetricExpr": "UNC_CHA_REQUESTS.READS_REMOTE * 64 / 1e6 / duration=
_time",
         "MetricName": "llc_miss_remote_memory_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory.",
+        "BriefDescription": "Bandwidth (MB/sec) of write requests that mis=
s the last level cache (LLC) and go to remote memory",
         "MetricExpr": "UNC_CHA_REQUESTS.WRITES_REMOTE * 64 / 1e6 / duratio=
n_time",
         "MetricName": "llc_miss_remote_memory_bandwidth_write",
         "ScaleUnit": "1MB/s"
@@ -237,19 +255,19 @@
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Memory write bandwidth (MB/sec) caused by dir=
ectory updates; includes DDR and Intel(R) Optane(TM) Persistent Memory(PMEM=
).",
+        "BriefDescription": "Memory write bandwidth (MB/sec) caused by dir=
ectory updates; includes DDR and Intel(R) Optane(TM) Persistent Memory(PMEM=
)",
         "MetricExpr": "(UNC_CHA_DIR_UPDATE.HA + UNC_CHA_DIR_UPDATE.TOR + U=
NC_M2M_DIRECTORY_UPDATE.ANY) * 64 / 1e6 / duration_time",
         "MetricName": "memory_extra_write_bw_due_to_directory_updates",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL + UNC_CHA_TO=
R_INSERTS.IA_MISS_DRD_PREF_LOCAL) / (UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCAL =
+ UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_=
DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE)",
         "MetricName": "numa_reads_addressed_to_local_dram",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches.",
+        "BriefDescription": "Memory reads that miss the last level cache (=
LLC) addressed to remote DRAM as a percentage of total memory read accesses=
, does not include LLC prefetches",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_REMOTE + UNC_CHA_T=
OR_INSERTS.IA_MISS_DRD_PREF_REMOTE) / (UNC_CHA_TOR_INSERTS.IA_MISS_DRD_LOCA=
L + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_LOCAL + UNC_CHA_TOR_INSERTS.IA_MIS=
S_DRD_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PREF_REMOTE)",
         "MetricName": "numa_reads_addressed_to_remote_dram",
         "ScaleUnit": "100%"
@@ -317,12 +335,12 @@
         "MetricExpr": "LD_BLOCKS_PARTIAL.ADDRESS_ALIAS / tma_info_thread_c=
lks",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
         "MetricName": "tma_4k_aliasing",
-        "MetricThreshold": "tma_4k_aliasing > 0.2 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound).",
+        "MetricThreshold": "tma_4k_aliasing > 0.2 & tma_l1_bound > 0.1 & t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates how often memory load =
accesses were aliased by preceding stores (in program order) with a 4K addr=
ess offset. False match is possible; which incur a few cycles load re-issue=
. However; the short re-issue duration is often hidden by the out-of-order =
core and HW optimizations; hence a user may safely ignore a high value of t=
his metric unless it manages to propagate up into parent nodes of the hiera=
rchy (e.g. to L1_Bound)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations.",
+        "BriefDescription": "This metric represents Core fraction of cycle=
s CPU dispatched uops on execution ports for ALU operations",
         "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 + =
UOPS_DISPATCHED.PORT_5 + UOPS_DISPATCHED.PORT_6) / (4 * tma_info_core_core_=
clks)",
         "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_group=
",
         "MetricName": "tma_alu_op_utilization",
@@ -334,7 +352,7 @@
         "MetricExpr": "34 * ASSISTS.ANY / tma_info_thread_slots",
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
         "ScaleUnit": "100%"
     },
@@ -357,11 +375,104 @@
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions.",
+        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
+        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misses =
+ tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
+        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
+        "MetricName": "tma_bottleneck_big_code",
+        "MetricThreshold": "tma_bottleneck_big_code > 20"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
+        "MetricExpr": "100 * ((BR_INST_RETIRED.ALL_BRANCHES + 2 * BR_INST_=
RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slots)",
+        "MetricGroup": "BvBO;Ret",
+        "MetricName": "tma_bottleneck_branching_overhead",
+        "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
+        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)"
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
a_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_4k_alias=
ing + tma_fb_full)))",
+        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
+        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
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
pendency + tma_lock_latency + tma_split_loads + tma_4k_aliasing + tma_fb_fu=
ll)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tm=
a_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_lock_latency / (tma_=
dtlb_load + tma_store_fwd_blk + tma_l1_latency_dependency + tma_lock_latenc=
y + tma_split_loads + tma_4k_aliasing + tma_fb_full)) + tma_memory_bound * =
(tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_boun=
d + tma_store_bound)) * (tma_split_loads / (tma_dtlb_load + tma_store_fwd_b=
lk + tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_4=
k_aliasing + tma_fb_full)) + tma_memory_bound * (tma_store_bound / (tma_l1_=
bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * =
(tma_split_stores / (tma_store_latency + tma_false_sharing + tma_split_stor=
es + tma_streaming_stores + tma_dtlb_store)) + tma_memory_bound * (tma_stor=
e_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tm=
a_store_bound)) * (tma_store_latency / (tma_store_latency + tma_false_shari=
ng + tma_split_stores + tma_streaming_stores + tma_dtlb_store)))",
+        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricName": "tma_bottleneck_cache_memory_latency",
+        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
+        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency"
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
n long-latency execution units are busy"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
+        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses + t=
ma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - tma_mi=
crocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) *=
 (tma_assists / tma_microcode_sequencer) * (tma_fetch_latency * (tma_ms_swi=
tches + tma_branch_resteers * (tma_clears_resteers + 10 * tma_microcode_seq=
uencer * tma_other_mispredicts / tma_branch_mispredicts * tma_mispredicts_r=
esteers) / (tma_mispredicts_resteers + tma_clears_resteers + tma_unknown_br=
anches)) / (tma_icache_misses + tma_itlb_misses + tma_branch_resteers + tma=
_ms_switches + tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_ms /=
 (tma_mite + tma_dsb + tma_ms))) - tma_bottleneck_big_code",
+        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
+        "MetricName": "tma_bottleneck_instruction_fetch_bw",
+        "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
+        "MetricExpr": "100 * (tma_microcode_sequencer / (tma_few_uops_inst=
ructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_sequence=
r) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_cle=
ars_resteers + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_b=
ranch_mispredicts * tma_mispredicts_resteers) / (tma_mispredicts_resteers +=
 tma_clears_resteers + tma_unknown_branches)) / (tma_icache_misses + tma_it=
lb_misses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switc=
hes) + tma_fetch_bandwidth * tma_ms / (tma_mite + tma_dsb + tma_ms)) + 10 *=
 tma_microcode_sequencer * tma_other_mispredicts / tma_branch_mispredicts *=
 tma_branch_mispredicts + tma_machine_clears * tma_other_nukes / tma_other_=
nukes + tma_core_bound * (tma_serializing_operation + tma_core_bound * RS_E=
VENTS.EMPTY_CYCLES / tma_info_thread_clks * tma_ports_utilized_0) / (tma_di=
vider + tma_serializing_operation + tma_ports_utilization) + tma_microcode_=
sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) * (tma_as=
sists / tma_microcode_sequencer) * tma_heavy_operations)",
+        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
+        "MetricName": "tma_bottleneck_irregular_overhead",
+        "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
+        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_=
store_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_lo=
ads + tma_4k_aliasing + tma_fb_full)) + tma_memory_bound * (tma_store_bound=
 / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store=
_bound)) * (tma_dtlb_store / (tma_store_latency + tma_false_sharing + tma_s=
plit_stores + tma_streaming_stores + tma_dtlb_store)))",
+        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricName": "tma_bottleneck_memory_data_tlbs",
+        "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
+        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_l1=
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
+        "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
+        "MetricName": "tma_bottleneck_memory_synchronization",
+        "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
+        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_contested_accesses, tma_data_sharing, tma_false_s=
haring, tma_machine_clears, tma_remote_cache"
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
spec_branch_misprediction_cost, tma_mispredicts_resteers"
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
LP) and other unlisted memory-related stalls"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead",
+        "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slot=
s - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_se=
quencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)"=
,
+        "MetricGroup": "BvUW;Ret",
+        "MetricName": "tma_bottleneck_useful_work",
+        "MetricThreshold": "tma_bottleneck_useful_work > 20"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions",
         "MetricExpr": "tma_light_operations * BR_INST_RETIRED.ALL_BRANCHES=
 / (tma_retiring * tma_info_thread_slots)",
         "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_branch_instructions",
@@ -375,7 +486,7 @@
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredic=
tions, tma_mispredicts_resteers",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU has wasted due to Branch Misprediction.  These slots are either wasted=
 by uops fetched from an incorrectly speculated program path; or stalls whe=
n the out-of-order part of the machine needs to recover its state from a sp=
eculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES. Related metrics:=
 tma_bottleneck_mispredictions, tma_info_bad_spec_branch_misprediction_cost=
, tma_mispredicts_resteers",
         "ScaleUnit": "100%"
     },
     {
@@ -383,8 +494,8 @@
         "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clk=
s + tma_unknown_branches",
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
         "ScaleUnit": "100%"
     },
     {
@@ -392,8 +503,8 @@
         "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > 0.=
05 & tma_heavy_operations > 0.1)",
-        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources.",
+        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0.0=
5 & tma_heavy_operations > 0.1",
+        "PublicDescription": "This metric estimates fraction of cycles the=
 CPU retired uops originated from CISC (complex instruction set computer) i=
nstruction. A CISC instruction has multiple uops that are required to perfo=
rm the instruction's functionality as in the case of read-modify-write as a=
n example. Since these instructions require multiple uops they may or may n=
ot imply sub-optimal use of machine resources",
         "ScaleUnit": "100%"
     },
     {
@@ -401,18 +512,66 @@
         "MetricExpr": "(1 - BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRE=
D.ALL_BRANCHES + MACHINE_CLEARS.COUNT)) * INT_MISC.CLEAR_RESTEER_CYCLES / t=
ma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that hit in the L2 cache",
+        "MetricExpr": "max(0, tma_icache_misses - tma_code_l2_miss)",
+        "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
+        "MetricName": "tma_code_l2_hit",
+        "MetricThreshold": "tma_code_l2_hit > 0.05 & tma_icache_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates fraction of cycles the =
CPU was stalled due to instruction cache misses that miss in the L2 cache",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_COD=
E_RD / tma_info_thread_clks",
+        "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;tma=
_icache_misses_group",
+        "MetricName": "tma_code_l2_miss",
+        "MetricThreshold": "tma_code_l2_miss > 0.05 & tma_icache_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the (first level) ITLB was missed by instructions fetches, th=
at later on hit in second-level TLB (STLB)",
+        "MetricExpr": "max(0, tma_itlb_misses - tma_code_stlb_miss)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
+        "MetricName": "tma_code_stlb_hit",
+        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses > 0=
.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
where the Second-level TLB (STLB) was missed by instruction fetches, perfor=
ming a hardware page walk",
+        "MetricExpr": "ITLB_MISSES.WALK_ACTIVE / tma_info_thread_clks",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_itlb=
_misses_group",
+        "MetricName": "tma_code_stlb_miss",
+        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses > =
0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for (instruction) code accesses",
+        "MetricExpr": "tma_code_stlb_miss * ITLB_MISSES.WALK_COMPLETED_2M_=
4M / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.WALK_COMPLETED_2M_4M)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_2m",
+        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 (instruction) code accesses",
+        "MetricExpr": "tma_code_stlb_miss * ITLB_MISSES.WALK_COMPLETED_4K =
/ (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.WALK_COMPLETED_2M_4M)",
+        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_code=
_stlb_miss_group",
+        "MetricName": "tma_code_stlb_miss_4k",
+        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb_m=
iss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_fronten=
d_bound > 0.15",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(44 * tma_info_system_core_frequency * (MEM_LOAD_L3=
_HIT_RETIRED.XSNP_HITM * (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD)=
)) + 43.5 * tma_info_system_core_frequency * MEM_LOAD_L3_HIT_RETIRED.XSNP_M=
ISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_i=
nfo_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_l3_bound_group",
+        "MetricExpr": "((48 * tma_info_system_core_frequency - 4 * tma_inf=
o_system_core_frequency) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (OCR.DEMAND=
_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DE=
MAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + (47.5 * tma_info_system_core_fr=
equency - 4 * tma_info_system_core_frequency) * MEM_LOAD_L3_HIT_RETIRED.XSN=
P_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tm=
a_info_thread_clks",
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
M_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. Re=
lated metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma=
_remote_cache",
+        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound >=
 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_HITM, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related=
 metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_fals=
e_sharing, tma_machine_clears, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
@@ -422,25 +581,25 @@
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "43.5 * tma_info_system_core_frequency * (MEM_LOAD_L=
3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM * (1 - OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.D=
EMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT /=
 MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "(47.5 * tma_info_system_core_frequency - 4 * tma_in=
fo_system_core_frequency) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_L3=
_HIT_RETIRED.XSNP_HITM * (1 - OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.D=
EMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_=
FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma=
_info_thread_clks",
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
AD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
+        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.05 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_HIT. Related metrics: tma_bottleneck_memory_synchron=
ization, tma_contested_accesses, tma_false_sharing, tma_machine_clears, tma=
_remote_cache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re decoder-0 was the only active decoder",
-        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D1@ - cpu@INS=
T_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / 2",
+        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - cpu@I=
NST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks / 2",
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
         "ScaleUnit": "100%"
     },
@@ -449,18 +608,18 @@
         "MetricExpr": "ARITH.DIVIDER_ACTIVE / tma_info_thread_clks",
         "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
-        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
+        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & tma=
_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled on accesses to external memory (DRAM) by loads",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_cl=
ks + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma=
_info_thread_clks - tma_l2_bound - tma_pmm_bound if #has_pmem > 0 else CYCL=
E_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clks + (CYCLE_ACTIVITY.STALLS_L=
1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_thread_clks - tma_l2_bo=
und)",
+        "MetricExpr": "CYCLE_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clk=
s + (CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_thread_clks - tma_l2_bound",
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
         "ScaleUnit": "100%"
     },
     {
@@ -469,7 +628,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -477,44 +636,44 @@
         "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_thread_=
clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
-        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D1=
@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYCLE=
_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
+        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=3D0=
x1@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY - CYC=
LE_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
-        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D1@ =
+ DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
+        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D0x1=
@ + DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
-        "MetricExpr": "48 * tma_info_system_core_frequency * OCR.DEMAND_RF=
O.L3_HIT.SNOOP_HITM / tma_info_thread_clks",
-        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_store_bound_group",
+        "MetricExpr": "(120 * tma_info_system_core_frequency * cpu@OCR.DEM=
AND_RFO.L3_MISS\\,offcore_rsp\\=3D0x103b800002@ + 48 * tma_info_system_core=
_frequency * OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM) / tma_info_thread_clks",
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
ma_contested_accesses, tma_data_sharing, tma_machine_clears, tma_remote_cac=
he",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_thread_clks",
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
tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_late=
ncy, tma_streaming_stores",
         "ScaleUnit": "100%"
     },
     {
@@ -524,7 +683,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -534,16 +693,16 @@
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or up to=
 ([SNB+] four; [ADL+] five) uops",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring instructions that that are decoder into two or more =
uops",
         "MetricExpr": "tma_heavy_operations - tma_microcode_sequencer",
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
         "ScaleUnit": "100%"
     },
     {
@@ -552,7 +711,7 @@
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
         "ScaleUnit": "100%"
     },
     {
@@ -561,7 +720,15 @@
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
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Floating-Point Divider unit was active",
+        "MetricExpr": "ARITH.FP_DIVIDER_ACTIVE / tma_info_thread_clks",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
+        "MetricName": "tma_fp_divider",
+        "MetricThreshold": "tma_fp_divider > 0.2 & tma_divider > 0.2 & tma=
_core_bound > 0.1 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%"
     },
     {
@@ -569,7 +736,7 @@
         "MetricExpr": "FP_ARITH_INST_RETIRED.SCALAR / (tma_retiring * tma_=
info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
-        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
         "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) scalar uops fraction the CPU has retired. May overcount due to =
FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, tm=
a_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5, t=
ma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
@@ -578,7 +745,7 @@
         "MetricExpr": "FP_ARITH_INST_RETIRED.VECTOR / (tma_retiring * tma_=
info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
-        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
+        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
         "PublicDescription": "This metric approximates arithmetic floating=
-point (FP) vector uops fraction the CPU has retired aggregated across all =
vector widths. May overcount due to FMA double counting. Related metrics: t=
ma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, t=
ma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
@@ -587,8 +754,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.128B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slots)=
",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_128b",
-        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 128-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_256b, tma_fp_vector_512b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -596,8 +763,8 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slots)=
",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_256b",
-        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
-        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_512b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
+        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
+        "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 256-bit wide vectors. May overcount=
 due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar, t=
ma_fp_vector, tma_fp_vector_128b, tma_fp_vector_512b, tma_port_0, tma_port_=
1, tma_port_5, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -605,7 +772,7 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE + FP_ARIT=
H_INST_RETIRED.512B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slots)=
",
         "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vector=
_group;tma_issue2P",
         "MetricName": "tma_fp_vector_512b",
-        "MetricThreshold": "tma_fp_vector_512b > 0.1 & (tma_fp_vector > 0.=
1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
+        "MetricThreshold": "tma_fp_vector_512b > 0.1 & tma_fp_vector > 0.1=
 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
         "PublicDescription": "This metric approximates arithmetic FP vecto=
r uops fraction the CPU has retired for 512-bit wide vectors. May overcount=
 due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vector,=
 tma_fp_vector_128b, tma_fp_vector_256b, tma_port_0, tma_port_1, tma_port_5=
, tma_port_6, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
@@ -617,17 +784,17 @@
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations -- instructions that require=
 two or more uops or micro-coded sequences",
-        "MetricExpr": "tma_microcode_sequencer + tma_retiring * (UOPS_DECO=
DED.DEC0 - cpu@UOPS_DECODED.DEC0\\,cmask\\=3D1@) / IDQ.MITE_UOPS",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring heavy-weight operations , instructions that require =
two or more uops or micro-coded sequences",
+        "MetricExpr": "tma_microcode_sequencer + tma_retiring * (UOPS_DECO=
DED.DEC0 - cpu@UOPS_DECODED.DEC0\\,cmask\\=3D0x1@) / IDQ.MITE_UOPS",
         "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring_g=
roup",
         "MetricName": "tma_heavy_operations",
         "MetricThreshold": "tma_heavy_operations > 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations -- instructions that requir=
e two or more uops or micro-coded sequences. This highly-correlates with th=
e uop length of these instructions/sequences. ([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+] .)",
+        "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring heavy-weight operations , instructions that require=
 two or more uops or micro-coded sequences. This highly-correlates with the=
 uop length of these instructions/sequences.([ICL+] Note this may overcount=
 due to approximation using indirect events; [ADL+])",
         "ScaleUnit": "100%"
     },
     {
@@ -635,41 +802,41 @@
         "MetricExpr": "ICACHE_DATA.STALLS / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA sl=
ots wasted per non-speculative branch misprediction (retired JEClear)",
+        "BriefDescription": "Branch Misprediction Cost: Cycles representin=
g fraction of TMA slots wasted per non-speculative branch misprediction (re=
tired JEClear)",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "tma_info_bottleneck_mispredictions * tma_info_threa=
d_slots / BR_MISP_RETIRED.ALL_BRANCHES / 100",
+        "MetricExpr": "tma_bottleneck_mispredictions * tma_info_thread_slo=
ts / 5 / BR_MISP_RETIRED.ALL_BRANCHES / 100",
         "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
         "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
-        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA s=
lots wasted per non-speculative branch misprediction (retired JEClear). Rel=
ated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions, t=
ma_mispredicts_resteers"
+        "PublicDescription": "Branch Misprediction Cost: Cycles representi=
ng fraction of TMA slots wasted per non-speculative branch misprediction (r=
etired JEClear). Related metrics: tma_bottleneck_mispredictions, tma_branch=
_mispredicts, tma_mispredicts_resteers"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for cond=
itional taken branches (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
-        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3"
+        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000"
     },
     {
-        "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
+        "BriefDescription": "Instructions per retired Mispredicts for retu=
rn branches (lower number means higher occurrence rate)",
         "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_ret",
@@ -683,7 +850,7 @@
         "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200"
     },
     {
-        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing mispredicts and nukes)",
+        "BriefDescription": "Speculative to Retired ratio of all clears (c=
overing Mispredicts and nukes)",
         "MetricExpr": "INT_MISC.CLEARS_COUNT / (BR_MISP_RETIRED.ALL_BRANCH=
ES + MACHINE_CLEARS.COUNT)",
         "MetricGroup": "BrMispredicts",
         "MetricName": "tma_info_bad_spec_spec_clears_ratio"
@@ -698,8 +865,8 @@
     },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
-        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_mite=
)))",
-        "MetricGroup": "DSB;FetchBW;tma_issueFB",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_dsb=
 + tma_ms)))",
+        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
         "PublicDescription": "Total pipeline cost of DSB (uop cache) hits =
- subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb_s=
witches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_front=
end_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp"
@@ -707,7 +874,7 @@
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_mite))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + t=
ma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite + t=
ma_dsb + tma_ms))",
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_misses",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
@@ -716,108 +883,10 @@
     {
         "BriefDescription": "Total pipeline cost of Instruction Cache miss=
es - subset of the Big_Code Bottleneck",
         "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses +=
 tma_lcp + tma_ms_switches))",
+        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (tma=
_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches + =
tma_lcp + tma_dsb_switches))",
         "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
         "MetricName": "tma_info_botlnk_l2_ic_misses",
-        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
-        "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: "
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
-        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
-        "MetricName": "tma_info_bottleneck_big_code",
-        "MetricThreshold": "tma_info_bottleneck_big_code > 20"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
-        "MetricExpr": "100 * ((BR_INST_RETIRED.ALL_BRANCHES + 2 * BR_INST_=
RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slots)",
-        "MetricGroup": "BvBO;Ret",
-        "MetricName": "tma_info_bottleneck_branching_overhead",
-        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 5",
-        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound)) * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)=
) + tma_memory_bound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma=
_l2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma_sq_full=
 / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_latency + tma_sq=
_full)) + tma_memory_bound * (tma_l1_bound / (tma_dram_bound + tma_l1_bound=
 + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma_f=
b_full / (tma_4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1_hit_latenc=
y + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
-        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
-        "MetricName": "tma_info_bottleneck_cache_memory_bandwidth",
-        "MetricThreshold": "tma_info_bottleneck_cache_memory_bandwidth > 2=
0",
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound)) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) =
+ tma_memory_bound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l=
2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma_l3_hit_la=
tency / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_latency + t=
ma_sq_full)) + tma_memory_bound * tma_l2_bound / (tma_dram_bound + tma_l1_b=
ound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_store_bound) + tma=
_memory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_=
bound + tma_l3_bound + tma_pmm_bound + tma_store_bound)) * (tma_store_laten=
cy / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_lat=
ency + tma_streaming_stores)) + tma_memory_bound * (tma_l1_bound / (tma_dra=
m_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma_=
store_bound)) * (tma_l1_hit_latency / (tma_4k_aliasing + tma_dtlb_load + tm=
a_fb_full + tma_l1_hit_latency + tma_lock_latency + tma_split_loads + tma_s=
tore_fwd_blk)))",
-        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
-        "MetricName": "tma_info_bottleneck_cache_memory_latency",
-        "MetricThreshold": "tma_info_bottleneck_cache_memory_latency > 20"=
,
-        "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency"
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
n long-latency execution units are busy. Related metrics: "
-    },
-    {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - tma_mi=
crocode_sequencer / (tma_few_uops_instructions + tma_microcode_sequencer) *=
 (tma_assists / tma_microcode_sequencer) * tma_fetch_latency * (tma_ms_swit=
ches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_resteer=
s * (10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_misp=
redicts)) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unknown_b=
ranches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_misses + t=
ma_itlb_misses + tma_lcp + tma_ms_switches)) - tma_info_bottleneck_big_code=
",
-        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
-        "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
-        "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
-        "MetricExpr": "100 * (tma_microcode_sequencer / (tma_few_uops_inst=
ructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_sequence=
r) * tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clea=
rs_resteers + tma_mispredicts_resteers * (10 * tma_microcode_sequencer * tm=
a_other_mispredicts / tma_branch_mispredicts)) / (tma_clears_resteers + tma=
_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers + tma=
_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_swit=
ches) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_m=
ispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other_nukes =
/ tma_other_nukes + tma_core_bound * (tma_serializing_operation + tma_core_=
bound * RS_EVENTS.EMPTY_CYCLES / tma_info_thread_clks * tma_ports_utilized_=
0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) + tm=
a_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequence=
r) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
-        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
-        "MetricName": "tma_info_bottleneck_irregular_overhead",
-        "MetricThreshold": "tma_info_bottleneck_irregular_overhead > 10",
-        "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_pmm_bound + tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_=
4k_aliasing + tma_dtlb_load + tma_fb_full + tma_l1_hit_latency + tma_lock_l=
atency + tma_split_loads + tma_store_fwd_blk)) + tma_memory_bound * (tma_st=
ore_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_pmm_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store + tma=
_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_store=
s)))",
-        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_bottleneck_memory_data_tlbs",
-        "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
-        "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store, tma_info_bottleneck_memory_synchronization"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_pmm_bound + tma=
_store_bound) * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) *=
 tma_remote_cache / (tma_local_mem + tma_remote_cache + tma_remote_mem) + t=
ma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_pmm_bound + tma_store_bound) * (tma_contested_accesses + tma_data_sha=
ring) / (tma_contested_accesses + tma_data_sharing + tma_l3_hit_latency + t=
ma_sq_full) + tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bou=
nd + tma_l3_bound + tma_pmm_bound + tma_store_bound) * tma_false_sharing / =
(tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_latency =
+ tma_streaming_stores - tma_store_latency)) + tma_machine_clears * (1 - tm=
a_other_nukes / tma_other_nukes))",
-        "MetricGroup": "BvMS;Mem;Offcore;tma_issueTLB",
-        "MetricName": "tma_info_bottleneck_memory_synchronization",
-        "MetricThreshold": "tma_info_bottleneck_memory_synchronization > 1=
0",
-        "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_dtlb_load, tma_dtlb_store, tma_info_bottleneck_me=
mory_data_tlbs"
-    },
-    {
-        "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
-        "MetricConstraint": "NO_GROUP_EVENTS",
-        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
-        "MetricName": "tma_info_bottleneck_mispredictions",
-        "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
-        "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers"
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
LP) and other unlisted memory-related stalls."
-    },
-    {
-        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
-        "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCHES=
 + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slot=
s - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_se=
quencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)"=
,
-        "MetricGroup": "BvUW;Ret",
-        "MetricName": "tma_info_bottleneck_useful_work",
-        "MetricThreshold": "tma_info_bottleneck_useful_work > 20"
+        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5"
     },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
@@ -878,11 +947,11 @@
         "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + FP_ARITH_INST_RETIR=
ED.VECTOR) / (2 * tma_info_core_core_clks)",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_core_fp_arith_utilization",
-        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)."
+        "PublicDescription": "Actual per-core usage of the Floating Point =
non-X87 execution units (regardless of precision or vector-width). Values >=
 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common; =
[ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less commo=
n)"
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per thread (logical-processor)",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D1@",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\,c=
mask\\=3D0x1@",
         "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
         "MetricName": "tma_info_core_ilp"
     },
@@ -895,20 +964,20 @@
         "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_inst_mix_iptb, tma_lcp"
     },
     {
-        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
.",
-        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
+        "BriefDescription": "Average number of cycles of a switch from the=
 DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for details=
",
+        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_SWI=
TCHES.PENALTY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
         "MetricGroup": "DSBmiss",
         "MetricName": "tma_info_frontend_dsb_switch_cost"
     },
     {
         "BriefDescription": "Average number of Uops issued by front-end wh=
en it issued something",
-        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D1=
@",
+        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=3D0=
x1@",
         "MetricGroup": "Fed;FetchBW",
         "MetricName": "tma_info_frontend_fetch_upc"
     },
     {
         "BriefDescription": "Average Latency for L1 instruction cache miss=
es",
-        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D1\\,edge@",
+        "MetricExpr": "ICACHE_16B.IFDATA_STALL / cpu@ICACHE_16B.IFDATA_STA=
LL\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
         "MetricGroup": "Fed;FetchLat;IcMiss",
         "MetricName": "tma_info_frontend_icache_miss_latency"
     },
@@ -938,7 +1007,13 @@
         "MetricName": "tma_info_frontend_l2mpki_code_all"
     },
     {
-        "BriefDescription": "Branch instructions per taken branch.",
+        "BriefDescription": "Taken Branches retired Per Cycle",
+        "MetricExpr": "BR_INST_RETIRED.NEAR_TAKEN / tma_info_thread_clks",
+        "MetricGroup": "Branches;FetchBW",
+        "MetricName": "tma_info_frontend_tbpc"
+    },
+    {
+        "BriefDescription": "Branch instructions per taken branch",
         "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR=
_TAKEN",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_bptkbranch"
@@ -956,7 +1031,7 @@
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
-        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW."
+        "PublicDescription": "Instructions per FP Arithmetic instruction (=
lower number means higher occurrence rate). Values < 1 are possible due to =
intentional FMA double counting. Approximated prior to BDW"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-bi=
t instruction (lower number means higher occurrence rate)",
@@ -964,7 +1039,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx128",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128-b=
it instruction (lower number means higher occurrence rate). Values < 1 are =
possible due to intentional FMA double counting"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit i=
nstruction (lower number means higher occurrence rate)",
@@ -972,7 +1047,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx256",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bit =
instruction (lower number means higher occurrence rate). Values < 1 are pos=
sible due to intentional FMA double counting"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic AVX 512-bit in=
struction (lower number means higher occurrence rate)",
@@ -980,7 +1055,7 @@
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_iparith_avx512",
         "MetricThreshold": "tma_info_inst_mix_iparith_avx512 < 10",
-        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). Values < 1 are poss=
ible due to intentional FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic AVX 512-bit i=
nstruction (lower number means higher occurrence rate). Values < 1 are poss=
ible due to intentional FMA double counting"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
@@ -988,7 +1063,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Double=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
@@ -996,7 +1071,7 @@
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
-        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting."
+        "PublicDescription": "Instructions per FP Arithmetic Scalar Single=
-Precision instruction (lower number means higher occurrence rate). Values =
< 1 are possible due to intentional FMA double counting"
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
@@ -1041,7 +1116,7 @@
     },
     {
         "BriefDescription": "Instructions per Software prefetch instructio=
n (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurrenc=
e rate)",
-        "MetricExpr": "INST_RETIRED.ANY / cpu@SW_PREFETCH_ACCESS.T0\\,umas=
k\\=3D0xF@",
+        "MetricExpr": "INST_RETIRED.ANY / SW_PREFETCH_ACCESS.ANY",
         "MetricGroup": "Prefetches",
         "MetricName": "tma_info_inst_mix_ipswpf",
         "MetricThreshold": "tma_info_inst_mix_ipswpf < 100"
@@ -1051,7 +1126,7 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
-        "MetricThreshold": "tma_info_inst_mix_iptb < 11",
+        "MetricThreshold": "tma_info_inst_mix_iptb < 5 * 2 + 1",
         "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp"
     },
     {
@@ -1098,7 +1173,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
-        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / duration_time",
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw"
     },
@@ -1116,7 +1191,7 @@
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
-        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / duration_time",
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / tma_info_system_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l2_cache_fill_bw"
     },
@@ -1152,13 +1227,13 @@
     },
     {
         "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
-        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / duration=
_time",
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / tma_info=
_system_time",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "tma_info_memory_l3_cache_access_bw"
     },
     {
         "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
-        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / duration_time",
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / tma_info_system=
_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l3_cache_fill_bw"
     },
@@ -1177,21 +1252,15 @@
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
         "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFFCO=
RE_REQUESTS.DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore",
+        "MetricGroup": "LockCont;Memory_Lat;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_miss_latency"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss demand Loads",
-        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
+        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu@O=
FFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@",
         "MetricGroup": "Memory_BW;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_mlp"
     },
-    {
-        "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
-        "MetricExpr": "cpu@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,u=
mask\\=3D0x10@ / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
-        "MetricGroup": "Memory_Lat;Offcore",
-        "MetricName": "tma_info_memory_latency_load_l3_miss_latency"
-    },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
         "MetricExpr": "L1D_PEND_MISS.PENDING / (MEM_LOAD_RETIRED.L1_MISS +=
 MEM_LOAD_RETIRED.FB_HIT)",
@@ -1217,6 +1286,13 @@
         "MetricName": "tma_info_memory_mlp",
         "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)"
     },
+    {
+        "BriefDescription": "Rate of L2 HW prefetched lines that were not =
used by demand accesses",
+        "MetricExpr": "L2_LINES_OUT.USELESS_HWPF / (L2_LINES_OUT.SILENT + =
L2_LINES_OUT.NON_SILENT)",
+        "MetricGroup": "Prefetches",
+        "MetricName": "tma_info_memory_prefetches_useless_hwpf",
+        "MetricThreshold": "tma_info_memory_prefetches_useless_hwpf > 0.15=
"
+    },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
         "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY=
",
@@ -1244,7 +1320,7 @@
     },
     {
         "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
-        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D1@)",
+        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES_G=
E_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D0x1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute"
     },
@@ -1265,18 +1341,18 @@
         "MetricExpr": "INST_RETIRED.ANY / ASSISTS.ANY",
         "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
         "MetricName": "tma_info_pipeline_ipassist",
-        "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
+        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
         "PublicDescription": "Instructions per a microcode Assist invocati=
on. See Assists tree node for details (lower number means higher occurrence=
 rate)"
     },
     {
-        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired.",
-        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D1@",
+        "BriefDescription": "Average number of Uops retired in cycles wher=
e at least one uop has retired",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_RET=
IRED.SLOTS\\,cmask\\=3D0x1@",
         "MetricGroup": "Pipeline;Ret",
         "MetricName": "tma_info_pipeline_retire"
     },
     {
         "BriefDescription": "Measured Average Core Frequency for unhalted =
processors [GHz]",
-        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / dur=
ation_time",
+        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / tma=
_info_system_time",
         "MetricGroup": "Power;Summary",
         "MetricName": "tma_info_system_core_frequency"
     },
@@ -1294,28 +1370,28 @@
     },
     {
         "BriefDescription": "Average external Memory Bandwidth Use for rea=
ds and writes [GB / sec]",
-        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / duration_time",
+        "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / 1e=
9 / tma_info_system_time",
         "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
         "MetricName": "tma_info_system_dram_bw_use",
-        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlenec=
k_cache_memory_bandwidth, tma_mem_bandwidth, tma_sq_full"
+        "PublicDescription": "Average external Memory Bandwidth Use for re=
ads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_ban=
dwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full"
     },
     {
         "BriefDescription": "Giga Floating Point Operations Per Second",
-        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_ARIT=
H_INST_RETIRED.8_FLOPS + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) / 1=
e9 / duration_time",
+        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_ARIT=
H_INST_RETIRED.8_FLOPS + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE) / 1=
e9 / tma_info_system_time",
         "MetricGroup": "Cor;Flops;HPC",
         "MetricName": "tma_info_system_gflops",
         "PublicDescription": "Giga Floating Point Operations Per Second. A=
ggregate across all supported options of: FP precisions, scalar and vector =
instructions, vector-width"
     },
     {
         "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Reads [GB / sec]",
-        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e9 / durati=
on_time",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e9 / tma_in=
fo_system_time",
         "MetricGroup": "IoBW;MemOffcore;Server;SoC",
         "MetricName": "tma_info_system_io_read_bw",
         "PublicDescription": "Average IO (network or disk) Bandwidth Use f=
or Reads [GB / sec]. Bandwidth of IO reads that are initiated by end device=
 controllers that are requesting memory from the CPU"
     },
     {
         "BriefDescription": "Average IO (network or disk) Bandwidth Use fo=
r Writes [GB / sec]",
-        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_INSE=
RTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TOR_I=
NSERTS.IO_MISS_ITOMCACHENEAR) * 64 / 1e9 / duration_time",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_INSE=
RTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TOR_I=
NSERTS.IO_MISS_ITOMCACHENEAR) * 64 / 1e9 / tma_info_system_time",
         "MetricGroup": "IoBW;MemOffcore;Server;SoC",
         "MetricName": "tma_info_system_io_write_bw",
         "PublicDescription": "Average IO (network or disk) Bandwidth Use f=
or Writes [GB / sec]. Bandwidth of IO writes that are initiated by end devi=
ce controllers that are writing memory to the CPU"
@@ -1325,13 +1401,14 @@
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
         "MetricGroup": "Branches;OS",
         "MetricName": "tma_info_system_ipfarbranch",
-        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6"
+        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000"
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:k"=
,
         "MetricGroup": "OS",
-        "MetricName": "tma_info_system_kernel_cpi"
+        "MetricName": "tma_info_system_kernel_cpi",
+        "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
@@ -1347,45 +1424,46 @@
         "MetricName": "tma_info_system_mem_dram_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal DRAM memory [in nanoseconds]. Accounts for demand loads and L1/L2 data=
-read prefetches"
     },
+    {
+        "BriefDescription": "Fraction of Uncore cycles where requests got =
rejected due to duplicate address already in IRQ ingress queue in the cache=
 homing agent",
+        "MetricExpr": "UNC_CHA_RxC_IRQ1_REJECT.PA_MATCH / UNC_CHA_CLOCKTIC=
KS",
+        "MetricGroup": "LockCont;MemOffcore;Server;SoC",
+        "MetricName": "tma_info_system_mem_irq_duplicate_address",
+        "MetricThreshold": "(tma_info_system_mem_irq_duplicate_address > 0=
.1)"
+    },
     {
         "BriefDescription": "Average number of parallel data read requests=
 to external memory",
-        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_OCC=
UPANCY.IA_MISS_DRD@thresh\\=3D1@",
+        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / cha@UNC_CHA_TOR=
_OCCUPANCY.IA_MISS_DRD\\,thresh\\=3D0x1@",
         "MetricGroup": "Mem;MemoryBW;SoC",
         "MetricName": "tma_info_system_mem_parallel_reads",
         "PublicDescription": "Average number of parallel data read request=
s to external memory. Accounts for demand loads and L1/L2 prefetches"
     },
-    {
-        "BriefDescription": "Average latency of data read request to exter=
nal 3D X-Point memory [in nanoseconds]",
-        "MetricExpr": "(1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC=
_CHA_TOR_INSERTS.IA_MISS_DRD_PMM) / cha_0@event\\=3D0x0@ if #has_pmem > 0 e=
lse 0)",
-        "MetricGroup": "MemOffcore;MemoryLat;Server;SoC",
-        "MetricName": "tma_info_system_mem_pmm_read_latency",
-        "PublicDescription": "Average latency of data read request to exte=
rnal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L=
2 data-read prefetches"
-    },
     {
         "BriefDescription": "Average latency of data read request to exter=
nal memory (in nanoseconds)",
-        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (tma_info_system_socket_clks / duration_time)",
+        "MetricExpr": "1e9 * (UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_=
TOR_INSERTS.IA_MISS_DRD) / (tma_info_system_socket_clks / tma_info_system_t=
ime)",
         "MetricGroup": "Mem;MemoryLat;SoC",
         "MetricName": "tma_info_system_mem_read_latency",
         "PublicDescription": "Average latency of data read request to exte=
rnal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetche=
s. ([RKL+]memory-controller only)"
     },
     {
-        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [=
GB / sec]",
-        "MetricExpr": "(64 * UNC_M_PMM_RPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
-        "MetricGroup": "MemOffcore;MemoryBW;Server;SoC",
-        "MetricName": "tma_info_system_pmm_read_bw"
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P / CPU_CLK_UNHALTED.THREAD=
",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9"
     },
     {
-        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes =
[GB / sec]",
-        "MetricExpr": "(64 * UNC_M_PMM_WPQ_INSERTS / 1e9 / duration_time i=
f #has_pmem > 0 else 0)",
-        "MetricGroup": "MemOffcore;MemoryBW;Server;SoC",
-        "MetricName": "tma_info_system_pmm_write_bw"
+        "BriefDescription": "Total package Power in Watts",
+        "MetricExpr": "(power@energy\\-pkg@ * 61 + 15.6 * power@energy\\-r=
am@) / (duration_time * 1e6)",
+        "MetricGroup": "Power;SoC",
+        "MetricName": "tma_info_system_power"
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for baseline license level 0",
         "MetricExpr": "CORE_POWER.LVL0_TURBO_LICENSE / tma_info_core_core_=
clks",
         "MetricGroup": "Power",
         "MetricName": "tma_info_system_power_license0_utilization",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes."
+        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for baseline license level 0.  This includes non=
-AVX codes, SSE, AVX 128-bit, and low-current AVX 256-bit codes"
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 1",
@@ -1393,7 +1471,7 @@
         "MetricGroup": "Power",
         "MetricName": "tma_info_system_power_license1_utilization",
         "MetricThreshold": "tma_info_system_power_license1_utilization > 0=
.5",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions."
+        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 1.  This includes high current=
 AVX 256-bit instructions as well as low current AVX 512-bit instructions"
     },
     {
         "BriefDescription": "Fraction of Core cycles where the core was ru=
nning with power-delivery for license level 2 (introduced in SKX)",
@@ -1401,7 +1479,7 @@
         "MetricGroup": "Power",
         "MetricName": "tma_info_system_power_license2_utilization",
         "MetricThreshold": "tma_info_system_power_license2_utilization > 0=
.5",
-        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions."
+        "PublicDescription": "Fraction of Core cycles where the core was r=
unning with power-delivery for license level 2 (introduced in SKX).  This i=
ncludes high current AVX 512-bit instructions"
     },
     {
         "BriefDescription": "Fraction of cycles where both hardware Logica=
l Processors were active",
@@ -1415,6 +1493,13 @@
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_socket_clks"
     },
+    {
+        "BriefDescription": "Run duration time in seconds",
+        "MetricExpr": "duration_time",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_time",
+        "MetricThreshold": "tma_info_system_time < 1"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
@@ -1423,12 +1508,12 @@
     },
     {
         "BriefDescription": "Measured Average Uncore Frequency for the SoC=
 [GHz]",
-        "MetricExpr": "tma_info_system_socket_clks / 1e9 / duration_time",
+        "MetricExpr": "tma_info_system_socket_clks / 1e9 / tma_info_system=
_time",
         "MetricGroup": "SoC",
         "MetricName": "tma_info_system_uncore_frequency"
     },
     {
-        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active.",
+        "BriefDescription": "Per-Logical Processor actual clocks when the =
Logical Processor is active",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
         "MetricGroup": "Pipeline",
         "MetricName": "tma_info_thread_clks"
@@ -1437,14 +1522,15 @@
         "BriefDescription": "Cycles Per Instruction (per Logical Processor=
)",
         "MetricExpr": "1 / tma_info_thread_ipc",
         "MetricGroup": "Mem;Pipeline",
-        "MetricName": "tma_info_thread_cpi"
+        "MetricName": "tma_info_thread_cpi",
+        "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "The ratio of Executed- by Issued-Uops",
         "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
         "MetricGroup": "Cor;Pipeline",
         "MetricName": "tma_info_thread_execute_per_issue",
-        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage."
+        "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage"
     },
     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor=
)",
@@ -1454,13 +1540,13 @@
     },
     {
         "BriefDescription": "Total issue-pipeline slots (per-Physical Core=
 till ICL; per-Logical Processor ICL onward)",
-        "MetricExpr": "TOPDOWN.SLOTS",
+        "MetricExpr": "slots",
         "MetricGroup": "TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots"
     },
     {
         "BriefDescription": "Fraction of Physical Core issue-slots utilize=
d by this Logical Processor",
-        "MetricExpr": "(tma_info_thread_slots / (TOPDOWN.SLOTS / 2) if #SM=
T_on else 1)",
+        "MetricExpr": "(tma_info_thread_slots / (slots / 2) if #SMT_on els=
e 1)",
         "MetricGroup": "SMT;TmaL1;tma_L1_group",
         "MetricName": "tma_info_thread_slots_utilization"
     },
@@ -1476,33 +1562,41 @@
         "MetricExpr": "tma_retiring * tma_info_thread_slots / BR_INST_RETI=
RED.NEAR_TAKEN",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
-        "MetricThreshold": "tma_info_thread_uptb < 7.5"
+        "MetricThreshold": "tma_info_thread_uptb < 5 * 1.5"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles whe=
re the Integer Divider unit was active",
+        "MetricExpr": "tma_divider - tma_fp_divider",
+        "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
+        "MetricName": "tma_int_divider",
+        "MetricThreshold": "tma_int_divider > 0.2 & tma_divider > 0.2 & tm=
a_core_bound > 0.1 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "ICACHE_TAG.STALLS / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 data cache",
+        "BriefDescription": "This metric estimates how often the CPU was s=
talled without loads missing the L1 Data (L1D) cache",
         "MetricExpr": "max((CYCLE_ACTIVITY.STALLS_MEM_ANY - CYCLE_ACTIVITY=
.STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric roughly estimates fraction of cyc=
les with demand load accesses that hit the L1 cache",
+        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimates =
fraction of cycles with demand load accesses that hit the L1D cache",
         "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RETI=
RED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYCLE=
S_MEM_ANY - CYCLE_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1511,8 +1605,17 @@
         "MetricExpr": "MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_=
HIT / MEM_LOAD_RETIRED.L1_MISS) / (MEM_LOAD_RETIRED.L2_HIT * (1 + MEM_LOAD_=
RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + L1D_PEND_MISS.FB_FULL_PERIODS)=
 * ((CYCLE_ACTIVITY.STALLS_L1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_=
info_thread_clks)",
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
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents fraction of cycles wit=
h demand load accesses that hit the L2 cache under unloaded scenarios (poss=
ibly L2 latency limited)",
+        "MetricExpr": "4 * tma_info_system_core_frequency * MEM_LOAD_RETIR=
ED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / =
tma_info_thread_clks",
+        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_grou=
p",
+        "MetricName": "tma_l2_hit_latency",
+        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric represents fraction of cycles wi=
th demand load accesses that hit the L2 cache under unloaded scenarios (pos=
sibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 hit=
s) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
         "ScaleUnit": "100%"
     },
     {
@@ -1521,17 +1624,17 @@
         "MetricExpr": "(CYCLE_ACTIVITY.STALLS_L2_MISS - CYCLE_ACTIVITY.STA=
LLS_L3_MISS) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
-        "MetricExpr": "19 * tma_info_system_core_frequency * (MEM_LOAD_RET=
IRED.L3_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2))=
 / tma_info_thread_clks",
+        "MetricExpr": "(23 * tma_info_system_core_frequency - 4 * tma_info=
_system_core_frequency) * (MEM_LOAD_RETIRED.L3_HIT * (1 + MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2)) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1539,18 +1642,18 @@
         "MetricExpr": "DECODE.LCP / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
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
         "ScaleUnit": "100%"
     },
     {
@@ -1567,7 +1670,7 @@
         "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_hit",
-        "MetricThreshold": "tma_load_stlb_hit > 0.05 & (tma_dtlb_load > 0.=
1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
+        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0.1=
 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%"
     },
     {
@@ -1575,15 +1678,39 @@
         "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_thread_clks=
",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_gro=
up",
         "MetricName": "tma_load_stlb_miss",
-        "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load > 0=
.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2)))",
+        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > 0.=
1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_1G / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_1g",
+        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPL=
ETED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_2m",
+        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data load accesses",
+        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLETE=
D_4K / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLETE=
D_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_mis=
s_group",
+        "MetricName": "tma_load_stlb_miss_4k",
+        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb_m=
iss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound > =
0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from local memory",
-        "MetricExpr": "43.5 * tma_info_system_core_frequency * MEM_LOAD_L3=
_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "(66.5 * tma_info_system_core_frequency - 23 * tma_i=
nfo_system_core_frequency) * MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM=
_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks=
",
         "MetricGroup": "Server;TopdownL5;tma_L5_group;tma_mem_latency_grou=
p",
         "MetricName": "tma_local_mem",
-        "MetricThreshold": "tma_local_mem > 0.1 & (tma_mem_latency > 0.1 &=
 (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2)=
))",
+        "MetricThreshold": "tma_local_mem > 0.1 & tma_mem_latency > 0.1 & =
tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from local memory. Caching will =
improve the latency and increase performance. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.LOCAL_DRAM",
         "ScaleUnit": "100%"
     },
@@ -1591,9 +1718,9 @@
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU spent handling cache misses due to lock operations",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQSTS=
.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (10=
 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTSTAN=
DING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
-        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
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
         "ScaleUnit": "100%"
     },
@@ -1604,16 +1731,16 @@
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
equencer, tma_ms_switches, tma_remote_cache",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
-        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
-        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
+        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_O=
UTSTANDING.ALL_DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks",
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
 tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
         "ScaleUnit": "100%"
     },
     {
@@ -1621,8 +1748,8 @@
         "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1632,11 +1759,11 @@
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations -- uops for memory load or store a=
ccesses.",
+        "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring memory operations , uops for memory load or store ac=
cesses",
         "MetricConstraint": "NO_GROUP_EVENTS",
         "MetricExpr": "tma_light_operations * MEM_INST_RETIRED.ANY / INST_=
RETIRED.ANY",
         "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operatio=
ns_group",
@@ -1650,7 +1777,7 @@
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
be avoided. Sample with: IDQ.MS_UOPS. Related metrics: tma_clears_resteers,=
 tma_info_bottleneck_irregular_overhead, tma_l1_bound, tma_machine_clears, =
tma_ms_switches",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The M=
S is used for CISC instructions not supported by the default decoders (like=
 repeat move strings; or CPUID); or by microcode assists used to address so=
me operation modes (like in Floating Point assists). These cases can often =
be avoided. Sample with: IDQ.MS_UOPS. Related metrics: tma_bottleneck_irreg=
ular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clears, tma_m=
s_switches",
         "ScaleUnit": "100%"
     },
     {
@@ -1658,8 +1785,8 @@
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / (BR_MISP_RETIRED.ALL=
_BRANCHES + MACHINE_CLEARS.COUNT) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_inf=
o_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1673,19 +1800,27 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re (only) 4 uops were delivered by the MITE pipeline",
-        "MetricExpr": "(cpu@IDQ.MITE_UOPS\\,cmask\\=3D4@ - cpu@IDQ.MITE_UO=
PS\\,cmask\\=3D5@) / tma_info_thread_clks",
+        "MetricExpr": "(cpu@IDQ.MITE_UOPS\\,cmask\\=3D0x4@ - cpu@IDQ.MITE_=
UOPS\\,cmask\\=3D0x5@) / tma_info_thread_clks",
         "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_mite_gr=
oup",
         "MetricName": "tma_mite_4wide",
-        "MetricThreshold": "tma_mite_4wide > 0.05 & (tma_mite > 0.1 & tma_=
fetch_bandwidth > 0.2)",
+        "MetricThreshold": "tma_mite_4wide > 0.05 & tma_mite > 0.1 & tma_f=
etch_bandwidth > 0.2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued -- the Count D=
omain; [ADL+] cycles)",
+        "BriefDescription": "This metric estimates penalty in terms of per=
centage of([SKL+] injected blend uops out of all Uops Issued , the Count Do=
main; [ADL+] cycles)",
         "MetricExpr": "UOPS_ISSUED.VECTOR_WIDTH_MISMATCH / UOPS_ISSUED.ANY=
",
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
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric represents Core fraction of cycle=
s in which CPU was likely limited due to the Microcode Sequencer (MS) unit =
- see Microcode_Sequencer node for details",
+        "MetricExpr": "cpu@IDQ.MS_UOPS\\,cmask\\=3D0x1@ / tma_info_core_co=
re_clks / 2",
+        "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwidt=
h_group",
+        "MetricName": "tma_ms",
+        "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
         "ScaleUnit": "100%"
     },
     {
@@ -1693,8 +1828,8 @@
         "MetricExpr": "3 * IDQ.MS_SWITCHES / tma_info_thread_clks",
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
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_clears_r=
esteers, tma_info_bottleneck_irregular_overhead, tma_l1_bound, tma_machine_=
clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_operat=
ion",
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
with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_bottlene=
ck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clear=
s, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_operation",
         "ScaleUnit": "100%"
     },
     {
@@ -1702,7 +1837,7 @@
         "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_reti=
ring * tma_info_thread_slots)",
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
         "ScaleUnit": "100%"
     },
@@ -1717,28 +1852,19 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
+        "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types)",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED.A=
LL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
         "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
-        "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
+        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_misp=
redicts > 0.1 & tma_bad_speculation > 0.15",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
+        "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
",
         "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMORY=
_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
         "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
-        "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "This metric roughly estimates (based on idle =
latencies) how often the CPU was stalled on accesses to external 3D-Xpoint =
(Crystal Ridge, a.k.a",
-        "MetricExpr": "(((1 - (19 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM =
* (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 10 * (MEM_LOA=
D_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETI=
RED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD * (1 + MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM *=
 (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))) / (19 * (MEM_LO=
AD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RE=
TIRED.L1_MISS)) + 10 * (MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM * (1 + MEM_LOAD=
_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOAD_L3_MISS_RETIRED.REMO=
TE_FWD * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS) + MEM_LOA=
D_L3_MISS_RETIRED.REMOTE_HITM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RET=
IRED.L1_MISS)) + (25 * (MEM_LOAD_RETIRED.LOCAL_PMM * (1 + MEM_LOAD_RETIRED.=
FB_HIT / MEM_LOAD_RETIRED.L1_MISS)) + 33 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE=
_PMM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS))))) * (CYCL=
E_ACTIVITY.STALLS_L3_MISS / tma_info_thread_clks + (CYCLE_ACTIVITY.STALLS_L=
1D_MISS - CYCLE_ACTIVITY.STALLS_L2_MISS) / tma_info_thread_clks - tma_l2_bo=
und) if 1e6 * (MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM + MEM_LOAD_RETIRED.LOCAL=
_PMM) > MEM_LOAD_RETIRED.L1_MISS else 0) if #has_pmem > 0 else 0)",
-        "MetricGroup": "MemoryBound;Server;TmaL3mem;TopdownL3;tma_L3_group=
;tma_memory_bound_group",
-        "MetricName": "tma_pmm_bound",
-        "MetricThreshold": "tma_pmm_bound > 0.1 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
-        "PublicDescription": "This metric roughly estimates (based on idle=
 latencies) how often the CPU was stalled on accesses to external 3D-Xpoint=
 (Crystal Ridge, a.k.a. IXP) memory by loads, PMM stands for Persistent Mem=
ory Module.",
+        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears > =
0.1 & tma_bad_speculation > 0.15",
         "ScaleUnit": "100%"
     },
     {
@@ -1774,7 +1900,7 @@
         "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_grou=
p;tma_issue2P",
         "MetricName": "tma_port_6",
         "MetricThreshold": "tma_port_6 > 0.6",
-        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_6. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_port_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
+        "PublicDescription": "This metric represents Core fraction of cycl=
es CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simpl=
e ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scalar=
, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b=
, tma_port_0, tma_port_1, tma_port_5, tma_ports_utilized_2",
         "ScaleUnit": "100%"
     },
     {
@@ -1782,8 +1908,8 @@
         "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (EX=
E_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_PORTS_UTIL)) / tma_=
info_thread_clks if ARITH.DIVIDER_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - CY=
CLE_ACTIVITY.STALLS_MEM_ANY else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring =
* EXE_ACTIVITY.2_PORTS_UTIL) / tma_info_thread_clks)",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1791,8 +1917,8 @@
         "MetricExpr": "cpu@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x80@ / t=
ma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1800,7 +1926,7 @@
         "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
@@ -1809,7 +1935,7 @@
         "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma_p=
orts_utilization_group",
         "MetricName": "tma_ports_utilized_2",
-        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_utiliz=
ation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 2 uops per cycle on all execution ports (Logical Proces=
sor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorization =
-most compilers feature auto-Vectorization options today- reduces pressure =
on the execution ports as multiple elements are calculated with same uop. S=
ample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tma_=
fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_=
port_0, tma_port_1, tma_port_5, tma_port_6",
         "ScaleUnit": "100%"
     },
@@ -1818,32 +1944,32 @@
         "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote cache in other socket=
s including synchronizations issues",
-        "MetricExpr": "(97 * tma_info_system_core_frequency * MEM_LOAD_L3_=
MISS_RETIRED.REMOTE_HITM + 97 * tma_info_system_core_frequency * MEM_LOAD_L=
3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRE=
D.L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "((120 * tma_info_system_core_frequency - 23 * tma_i=
nfo_system_core_frequency) * MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM + (120 * =
tma_info_system_core_frequency - 23 * tma_info_system_core_frequency) * MEM=
_LOAD_L3_MISS_RETIRED.REMOTE_FWD) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD=
_RETIRED.L1_MISS / 2) / tma_info_thread_clks",
         "MetricGroup": "Offcore;Server;Snoop;TopdownL5;tma_L5_group;tma_is=
sueSyncxn;tma_mem_latency_group",
         "MetricName": "tma_remote_cache",
-        "MetricThreshold": "tma_remote_cache > 0.05 & (tma_mem_latency > 0=
.1 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. #link to NUMA article. Sample with: MEM_LOAD_L3_MISS_R=
ETIRED.REMOTE_HITM_PS;MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD_PS. Related metri=
cs: tma_contested_accesses, tma_data_sharing, tma_false_sharing, tma_machin=
e_clears",
+        "MetricThreshold": "tma_remote_cache > 0.05 & tma_mem_latency > 0.=
1 & tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote cache in other socke=
ts including synchronizations issues. This is caused often due to non-optim=
al NUMA allocations. Sample with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM, MEM=
_LOAD_L3_MISS_RETIRED.REMOTE_FWD. Related metrics: tma_bottleneck_memory_sy=
nchronization, tma_contested_accesses, tma_data_sharing, tma_false_sharing,=
 tma_machine_clears",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling loads from remote memory",
-        "MetricExpr": "108 * tma_info_system_core_frequency * MEM_LOAD_L3_=
MISS_RETIRED.REMOTE_DRAM * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.=
L1_MISS / 2) / tma_info_thread_clks",
+        "MetricExpr": "(131 * tma_info_system_core_frequency - 23 * tma_in=
fo_system_core_frequency) * MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM * (1 + MEM=
_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma_info_thread_clks=
",
         "MetricGroup": "Server;Snoop;TopdownL5;tma_L5_group;tma_mem_latenc=
y_group",
         "MetricName": "tma_remote_mem",
-        "MetricThreshold": "tma_remote_mem > 0.1 & (tma_mem_latency > 0.1 =
& (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
)))",
-        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. #link to NUMA article. Sample=
 with: MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS",
+        "MetricThreshold": "tma_remote_mem > 0.1 & tma_mem_latency > 0.1 &=
 tma_dram_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
+        "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling loads from remote memory. This is caus=
ed often due to non-optimal NUMA allocations. Sample with: MEM_LOAD_L3_MISS=
_RETIRED.REMOTE_DRAM",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * tma_info_=
thread_slots",
+        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topdow=
n\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
         "MetricGroup": "BvUW;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
@@ -1856,7 +1982,7 @@
         "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
@@ -1865,7 +1991,7 @@
         "MetricExpr": "37 * MISC_RETIRED.PAUSE_INST / tma_info_thread_clks=
",
         "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation_g=
roup",
         "MetricName": "tma_slow_pause",
-        "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
+        "MetricThreshold": "tma_slow_pause > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to PAUSE Instructions. Sample with: MISC_RETIRED.PAUS=
E_INST",
         "ScaleUnit": "100%"
     },
@@ -1874,8 +2000,8 @@
         "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCKS.=
NO_SR / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1884,17 +2010,17 @@
         "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_core_=
clks",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
         "MetricExpr": "L1D_PEND_MISS.L2_STALL / tma_info_thread_clks",
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
eck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma_m=
em_bandwidth",
         "ScaleUnit": "100%"
     },
     {
@@ -1902,8 +2028,8 @@
         "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_thread_clks=
",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1912,17 +2038,17 @@
         "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_clks=
",
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricExpr": "(L2_RQSTS.RFO_HIT * 10 * (1 - MEM_INST_RETIRED.LOCK=
_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOCK_LOADS / =
MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUEST=
S_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
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
         "ScaleUnit": "100%"
     },
     {
@@ -1939,7 +2065,7 @@
         "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_hit",
-        "MetricThreshold": "tma_store_stlb_hit > 0.05 & (tma_dtlb_store > =
0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2)))",
+        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store > 0=
.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > =
0.2",
         "ScaleUnit": "100%"
     },
     {
@@ -1947,7 +2073,31 @@
         "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_core_=
clks",
         "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_gr=
oup",
         "MetricName": "tma_store_stlb_miss",
-        "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store >=
 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_boun=
d > 0.2)))",
+        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store > =
0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 1 GB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_1G / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_1g",
+        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 2 or 4 MB page=
s for data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_2M_4M / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_C=
OMPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_2m",
+        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "This metric estimates the fraction of cycles =
to walk the memory paging structures to cache translation of 4 KB pages for=
 data store accesses",
+        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMPLE=
TED_4K / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
+        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_mi=
ss_group",
+        "MetricName": "tma_store_stlb_miss_4k",
+        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_stlb=
_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory_b=
ound > 0.2 & tma_backend_bound > 0.2",
         "ScaleUnit": "100%"
     },
     {
@@ -1955,7 +2105,7 @@
         "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_thread=
_clks",
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
         "ScaleUnit": "100%"
     },
@@ -1964,7 +2114,7 @@
         "MetricExpr": "10 * BACLEARS.ANY / tma_info_thread_clks",
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
ches. Sample with: BACLEARS.ANY",
         "ScaleUnit": "100%"
     },
@@ -1973,8 +2123,8 @@
         "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.TH=
READ",
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
         "ScaleUnit": "100%"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/memory.json b/tools/pe=
rf/pmu-events/arch/x86/icelakex/memory.json
index 32a3dedb82fb..ec9577cce3ac 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/memory.json
@@ -25,7 +25,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 128 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "1009",
         "UMask": "0x1"
@@ -38,7 +37,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 16 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "20011",
         "UMask": "0x1"
@@ -51,7 +49,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 256 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "503",
         "UMask": "0x1"
@@ -64,7 +61,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 32 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "100007",
         "UMask": "0x1"
@@ -77,7 +73,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 4 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
@@ -90,7 +85,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 512 cycles.  Reported=
 latency may be longer than just the memory latency.",
         "SampleAfterValue": "101",
         "UMask": "0x1"
@@ -103,7 +97,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 64 cycles.  Reported =
latency may be longer than just the memory latency.",
         "SampleAfterValue": "2003",
         "UMask": "0x1"
@@ -116,7 +109,6 @@
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PEBS": "2",
         "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 8 cycles.  Reported l=
atency may be longer than just the memory latency.",
         "SampleAfterValue": "50021",
         "UMask": "0x1"
@@ -353,17 +345,16 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of times RTM abort was tri=
ggered.",
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 4 categories (e.g. interrupt)",
+        "BriefDescription": "Number of times an RTM execution aborted due =
to none of the previous 3 categories (e.g. interrupt)",
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc9",
         "EventName": "RTM_RETIRED.ABORTED_EVENTS",
-        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 4 categories (e.g. interrupt).",
+        "PublicDescription": "Counts the number of times an RTM execution =
aborted due to none of the previous 3 categories (e.g. interrupt).",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
     },
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/metricgroups.json b/to=
ols/perf/pmu-events/arch/x86/icelakex/metricgroups.json
index cccfcab3425e..4a28187c2896 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/metricgroups.json
@@ -38,6 +38,7 @@
     "IoBW": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "LockCont": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "MachineClears": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
     "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -84,7 +85,9 @@
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
@@ -94,6 +97,7 @@
     "tma_fp_vector_group": "Metrics contributing to tma_fp_vector category=
",
     "tma_frontend_bound_group": "Metrics contributing to tma_frontend_boun=
d category",
     "tma_heavy_operations_group": "Metrics contributing to tma_heavy_opera=
tions category",
+    "tma_icache_misses_group": "Metrics contributing to tma_icache_misses =
category",
     "tma_issue2P": "Metrics related by the issue $issue2P",
     "tma_issueBM": "Metrics related by the issue $issueBM",
     "tma_issueBW": "Metrics related by the issue $issueBW",
@@ -113,10 +117,13 @@
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
@@ -129,5 +136,6 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tools/=
perf/pmu-events/arch/x86/icelakex/pipeline.json
index 74285b6c81e7..f1446f1b67c6 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
@@ -9,6 +9,15 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x9"
     },
+    {
+        "BriefDescription": "ARITH.FP_DIVIDER_ACTIVE",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0x14",
+        "EventName": "ARITH.FP_DIVIDER_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -23,7 +32,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts all branch instructions retired.",
         "SampleAfterValue": "400009"
     },
@@ -32,7 +40,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PEBS": "1",
         "PublicDescription": "Counts conditional branch instructions retir=
ed.",
         "SampleAfterValue": "400009",
         "UMask": "0x11"
@@ -42,7 +49,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts not taken branch instructions retired=
.",
         "SampleAfterValue": "400009",
         "UMask": "0x10"
@@ -52,7 +58,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken conditional branch instructions=
 retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x1"
@@ -62,7 +67,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PEBS": "1",
         "PublicDescription": "Counts far branch instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x40"
@@ -72,7 +76,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PEBS": "1",
         "PublicDescription": "Counts near indirect branch instructions ret=
ired excluding returns. TSX abort is an indirect branch.",
         "SampleAfterValue": "100003",
         "UMask": "0x80"
@@ -82,7 +85,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PEBS": "1",
         "PublicDescription": "Counts both direct and indirect near call in=
structions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x2"
@@ -92,7 +94,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PEBS": "1",
         "PublicDescription": "Counts return instructions retired.",
         "SampleAfterValue": "100007",
         "UMask": "0x8"
@@ -102,7 +103,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken branch instructions retired.",
         "SampleAfterValue": "400009",
         "UMask": "0x20"
@@ -112,7 +112,6 @@
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
         "SampleAfterValue": "50021"
     },
@@ -121,7 +120,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PEBS": "1",
         "PublicDescription": "Counts mispredicted conditional branch instr=
uctions retired.",
         "SampleAfterValue": "50021",
         "UMask": "0x11"
@@ -131,7 +129,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of conditional branch inst=
ructions retired that were mispredicted and the branch direction was not ta=
ken.",
         "SampleAfterValue": "50021",
         "UMask": "0x10"
@@ -141,7 +138,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts taken conditional mispredicted branch=
 instructions retired.",
         "SampleAfterValue": "50021",
         "UMask": "0x1"
@@ -151,7 +147,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PEBS": "1",
         "PublicDescription": "Counts all miss-predicted indirect branch in=
structions retired (excluding RETs. TSX aborts is considered indirect branc=
h).",
         "SampleAfterValue": "50021",
         "UMask": "0x80"
@@ -161,7 +156,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
         "PublicDescription": "Counts retired mispredicted indirect (near t=
aken) calls, including both register and memory indirect.",
         "SampleAfterValue": "50021",
         "UMask": "0x2"
@@ -171,7 +165,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "PublicDescription": "Counts number of near branch instructions re=
tired that were mispredicted and taken.",
         "SampleAfterValue": "50021",
         "UMask": "0x20"
@@ -181,7 +174,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
-        "PEBS": "1",
         "PublicDescription": "This is a non-precise version (that is, does=
 not use PEBS) of the event that counts mispredicted return instructions re=
tired.",
         "SampleAfterValue": "50021",
         "UMask": "0x8"
@@ -377,7 +369,6 @@
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of instructions retired - =
an Architectural PerfMon event. Counting continues during hardware interrup=
ts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counte=
d by a designated fixed counter freeing up programmable counters to count o=
ther events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
@@ -387,7 +378,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of instructions retired - =
an Architectural PerfMon event. Counting continues during hardware interrup=
ts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is counte=
d by a designated fixed counter freeing up programmable counters to count o=
ther events. INST_RETIRED.ANY_P is counted by a programmable counter.",
         "SampleAfterValue": "2000003"
     },
@@ -396,7 +386,6 @@
         "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     },
@@ -404,7 +393,6 @@
         "BriefDescription": "Precise instruction retired event with a redu=
ced effect of PEBS shadow in IP distribution",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
-        "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a =
more unbiased distribution of samples across instructions retired. It utili=
zes the Precise Distribution of Instructions Retired (PDIR) feature to miti=
gate some bias in how retired instructions get sampled. Use on Fixed Counte=
r 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 5a20439450ab..4472efb5bf9f 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -16,7 +16,7 @@ GenuineIntel-6-A[DE],v1.04,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
-GenuineIntel-6-6[AC],v1.26,icelakex,core
+GenuineIntel-6-6[AC],v1.27,icelakex,core
 GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
--=20
2.47.1.545.g3c1d2e2a6a-goog

