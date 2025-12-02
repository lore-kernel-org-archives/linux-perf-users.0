Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69792BDC29
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694434; cv=none; b=PoFCAg0ybjrTAV4ywZ4T29g6/kOg48ZUgRMfUuNHM9D1UfNsHYoB3bhRmpWLkaR736h7tGtbKTM2iGkfHsH+hZiW5+K3K6KOc6MsyP9GeLiAf8FHWkzfLP/PHHtW0b1MQaZONmY6QYxRTabrawNS6x8/G2NjNL5+Q69HQ8SHimc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694434; c=relaxed/simple;
	bh=+VuGKRpago5g32rnVZvs1w9NkuVaMi3ZWb1kIvxv5VM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sgO0prPPv6cXCNUNvVibDpMoXcQD+YLItFNxKohA8XCwWDGXSZJnr1L2LmLf+7v4woVxESMCC/iB1QDuTniHrZhwgCnE3+xl8u8iVQpm7+QHHFe32+KtihgHyWVTm5BXF/uYj4Rq3uvnC9wIMtunahIngEP3/khz8j4zbLkcGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tvg29oic; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tvg29oic"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297e5a18652so61241985ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764694432; x=1765299232; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thyC6gLHoXaiGKry1UOkvUXEqn0AK8hudN66LgrOvpU=;
        b=Tvg29oicQFX4TMmI0HXdTdF+9A5LjFAz5VjszVEMwigMcToD/u3WWq4aST2mv/4daC
         LKK35xB2n5erlHp6VJjZca93/x0nqp9VzdQ6jD9mm2uXkWGz5BbDP+nOsy2VaVaVNPFc
         9Qau0xspfbzSskLpoT7WcPUHHfnjhTgm3KAf1lwPJsP5PC6X3l9aQb2AcrKKzNJ113yg
         UpI26yC6KrJczq642esJh98VHD6JeN80CU5Wwc89hGsPtRcfS8Tq2LGEF8vYRNQvp6/Y
         +bNLYYppYzq2OyFDnp0WB33KIssBct+4qrqTdZQJfVwhdlV63S35Pepeevt5820cWkbb
         hmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764694432; x=1765299232;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thyC6gLHoXaiGKry1UOkvUXEqn0AK8hudN66LgrOvpU=;
        b=k1RwYx5EoZEbIHbHmpxNGv8po0tgou4CrA3hB0n4itbitYTwT47mjOzomxYwE3R8qX
         8Zh0X6+jKax8WuPTW4yVqWrltcRG94oRoP8eXbwccM2VgdcLet2Em2i9WohNf6UOwvm3
         aj37wDDQxV8Dyu1N1XGcdawKL9jhkpBvv/fD12clp+DGdn1U2lcqhc7Yd3CziKOUYevr
         32Ecve/eMiN7NC870o63RlKh1xgsXKmxCfJ0GvHF6f1FmrjWpYnwlcOrB0S7f4pM445y
         PtVkUmjf/LDA7BKK/B1qB/mCBrmpENxKlbaDqAjrZzaLrhmqiXs4lNwGyuiF2PsD9FTw
         VMsA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Q71tI/XUKC/9bbwTPY9bjKhL3vE+KIeFlUlEbvGFKSvrp2ZJxvOsAk2r/rzpMAmeY7ruBUSecvZitFBB/Y/0@vger.kernel.org
X-Gm-Message-State: AOJu0YxXN6zp3gf+XXIDUZ8pvvYsRi9R8IB8SCwsgJKB8mK0CxgiXfEO
	R5Dxb6YoH/pp/yNGLZkJrkXC7bg2Y1KpKkcOdaf+mlFV207yzR4I0/GqDBf+uJlRdpdNT9ChqTP
	YhoR7clLHfA==
X-Google-Smtp-Source: AGHT+IE0/p2JoW1TZj7cfNF1e+VX2+9tvW6YL7vSDYQAc09tPzgkkUBB08oJkfPbDdXi3VqNeI53knN1330k
X-Received: from pgbj27.prod.google.com ([2002:a63:551b:0:b0:bdb:36f7:556f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef51:b0:295:9b39:4533
 with SMTP id d9443c01a7336-29b6c57210emr484928435ad.30.1764694431947; Tue, 02
 Dec 2025 08:53:51 -0800 (PST)
Date: Tue,  2 Dec 2025 08:53:32 -0800
In-Reply-To: <20251202165340.555375-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202165340.555375-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202165340.555375-2-irogers@google.com>
Subject: [PATCH v1 1/9] perf vendor events intel: Update alderlake events from
 1.34 to 1.35
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The updated events were published in:
https://github.com/intel/perfmon/commit/c74f1cefa94d224cb3338507961b59d8a2a1c4e9

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/alderlake/cache.json     | 16 ++++++++--------
 .../pmu-events/arch/x86/alderlake/pipeline.json  |  6 ++++--
 .../pmu-events/arch/x86/alderlaken/cache.json    | 16 ++++++++--------
 .../pmu-events/arch/x86/alderlaken/pipeline.json |  6 ++++--
 tools/perf/pmu-events/arch/x86/mapfile.csv       |  4 ++--
 5 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
index 4cd535baf703..be15a7f83717 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -877,7 +877,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 128 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -890,7 +890,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 16 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -903,7 +903,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 256 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -916,7 +916,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 32 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -929,7 +929,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 4 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -942,7 +942,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 512 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -955,7 +955,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 64 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -968,7 +968,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 8 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
index 33d1f39e441f..57a8c78cdc49 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -32,8 +32,9 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Counts the number of active floating point and integer dividers per cycle.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xcd",
         "EventName": "ARITH.DIV_OCCUPANCY",
         "SampleAfterValue": "1000003",
@@ -41,8 +42,9 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of floating point and integer divider uops executed per cycle.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xcd",
         "EventName": "ARITH.DIV_UOPS",
         "SampleAfterValue": "1000003",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
index 669f4979b651..76a841675337 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
@@ -247,7 +247,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 128 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -259,7 +259,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 16 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -271,7 +271,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 256 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -283,7 +283,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 32 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -295,7 +295,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 4 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -307,7 +307,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 512 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -319,7 +319,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 64 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -331,7 +331,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an instruction latency that exceeds or equals the threshold of 8 cycles as defined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
-        "Counter": "0,1,2,3,4,5",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
index 1dd61baec1a9..d650cbd48c1f 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
@@ -9,16 +9,18 @@
         "UMask": "0x3"
     },
     {
-        "BriefDescription": "Counts the number of active floating point and integer dividers per cycle.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xcd",
         "EventName": "ARITH.DIV_OCCUPANCY",
         "SampleAfterValue": "1000003",
         "UMask": "0x3"
     },
     {
-        "BriefDescription": "Counts the number of floating point and integer divider uops executed per cycle.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xcd",
         "EventName": "ARITH.DIV_UOPS",
         "SampleAfterValue": "1000003",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 32093bded949..d640acb8a3c7 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.34,alderlake,core
-GenuineIntel-6-BE,v1.34,alderlaken,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.35,alderlake,core
+GenuineIntel-6-BE,v1.35,alderlaken,core
 GenuineIntel-6-C[56],v1.13,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
-- 
2.52.0.158.g65b55ccf14-goog

