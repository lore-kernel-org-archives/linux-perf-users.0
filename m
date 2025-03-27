Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D11F91FE
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114294; cv=none; b=P7V7KxsudxiOpqSpSaWlasahngMOhrPvBb7nu6R+H7+S/RWkqdeby414yKP7gSZaIBH/0bX+JqwIQpO4TaJI39gGHfSAFxIly+W14biLE+G4jBmRXi6mt5lD1EE8pJFz++2x6OJM0tSjEsCGaKd52+Zf/ct57fFjm8fcHHJdf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114294; c=relaxed/simple;
	bh=fl/8ycgPzIKEsh4MMDKBZ87evGynwfa6OfJKyADpznU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VvCvBJtQ5iWgTMc73AxWG0wK0xzE2NdtjjqMohmxHMgLd7xq8t0HHp7kq4UkaVGP4JQGi2X5wChtfrHUl80u8neWnCfRb9Qj90eE8QkGRrda+mQvUiW/A2r1LreKrhGT6Me3azgz9TWJOJ3Iz5D3H+etiGEHBw9Kas80oqCuGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ECVkKeJM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ECVkKeJM"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3032f4ea8cfso2692114a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743114281; x=1743719081; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t68xdbezRCm5hr/EeB6+g9mHIYGlNbNgK+ag7uVNl24=;
        b=ECVkKeJMo25Lw823nm7x8jSKzX4BqnSMU6hcQi3XwD9n4LhB/7nNXO+eE6IzcUMZi1
         vX7L185VJ874m+R5DseHYTGY4D846/tCdQmMqfUCAYljmp9bOTj4kklUN7lHyuIyEFUE
         1NLrADawndZ7llFeqxRTkuhJ/XUBGsQ22ijX9JwAevmb/LOtDQZSQ6HzJRcWiSzOdayZ
         XmLbULmJZp6u2QIipaV3a2qNFKU51GlAeaizlZ1rTc9Hppp11zD5AifWlr58MgprkS/L
         rfbmHTtbvE9iVBUydP/bJsQ4z3fE1gVBBFYBAdsgzIXeDn2pr3yMCApi75SEzCmFL7uk
         d3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743114281; x=1743719081;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t68xdbezRCm5hr/EeB6+g9mHIYGlNbNgK+ag7uVNl24=;
        b=FnUA3anTFmg6IkUClHHyrUt/t3fTphyWfUOwyufhy68csGnBU3i/9Jk0aFJO+B4aTK
         sKPZklffDCBSStwkkTdcGBLclOMyjNRSRwJs8Lmd8/+GvJcg6hdqKRZnXvxQx7mf6s1J
         XnQRPKjCuxTsdnfv3QNUCq0ZUz32vxy/epkdjmMxNa290GDSMBn+ksUaG5Si38aQh33t
         3MPXFbVCNwzTTMdvsHb0EqVXhkxsP84Z+cw9JtjLgtQCgVE60Kz0uvAWn1vWW9rgiZzY
         +ls94u0KyOpHALpxxLz4jfqb/Y+nlpDixbLrFyW63eCRTQV0agfzJV4ZiUlzqd1gm63c
         2yyw==
X-Forwarded-Encrypted: i=1; AJvYcCUyKFM5i5TZ4Jm6LYUoSX0+KgFP3a13mORLZBzuO2vll2fntb6AmOPDexpoB3KC82qmOKk208fQTghBls98b4mD@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbIJ732FjuipiSV1b7P6N28KNCoAE7W6wQ7+xI37Io0u/HOCF
	v1t7+lBfPlu2zvnQI0Ico9EDGyh5S1oEiU4HnkWjRZKoF4AlOE3R50zUzpmOhKxNX3O30Y57EtQ
	xo4ZWiA==
X-Google-Smtp-Source: AGHT+IEo8A+4wT/CWJ5R2VN/VO3FDbC2fCrfoQL7cRoiB3m0YEFbUa8C6fmw3gde32pnfL0bG3JNv5TFBrDS
X-Received: from pjbpx8.prod.google.com ([2002:a17:90b:2708:b0:301:4260:4d23])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d643:b0:2ee:a583:e616
 with SMTP id 98e67ed59e1d1-303a7d70360mr8015687a91.9.1743114281509; Thu, 27
 Mar 2025 15:24:41 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:23:26 -0700
In-Reply-To: <20250327222331.117701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327222331.117701-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327222331.117701-32-irogers@google.com>
Subject: [PATCH v4 31/35] perf vendor events: Update snowridgex events
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

Update event topic moving other topic events to cache and memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/snowridgex/cache.json | 192 +++++++++
 .../arch/x86/snowridgex/memory.json           | 202 +++++++++
 .../pmu-events/arch/x86/snowridgex/other.json | 394 ------------------
 3 files changed, 394 insertions(+), 394 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/cache.json b/tools/p=
erf/pmu-events/arch/x86/snowridgex/cache.json
index 7882dca9d5e1..1bb42acf1d48 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/cache.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/cache.json
@@ -357,6 +357,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3000000010000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that were supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -367,6 +377,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have an outstanding request. Returns the number of cycles unt=
il the response is received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.COREWB_M.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8003000000000000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -427,6 +457,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -487,6 +527,27 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve an outstanding request. Returns the number of cycles until the response =
is received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_HIT",
         "Counter": "0,1,2,3",
@@ -553,6 +614,27 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache.",
         "Counter": "0,1,2,3",
@@ -613,6 +695,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have an outstan=
ding request. Returns the number of cycles until the response is received (=
i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that were supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -623,6 +715,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L1 data cache hardware prefetches and =
software prefetches (except PREFETCHW and PFRFO) that have any type of resp=
onse.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10400",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts L1 data cache hardware prefetches and =
software prefetches (except PREFETCHW and PFRFO) that were supplied by the =
L3 cache where a snoop was sent, the snoop hit, and modified data was forwa=
rded.",
         "Counter": "0,1,2,3",
@@ -633,6 +735,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10040",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -693,6 +805,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have an outstanding request. Returns th=
e number of cycles until the response is received (i.e. XQ to XQ latency)."=
,
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000040",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10010",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -753,6 +885,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10020",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -813,6 +955,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have an outstanding request. Returns the numb=
er of cycles until the response is received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000020",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L1WB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1000000010000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that were supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -823,6 +985,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that have any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.L2WB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x2000000010000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that were supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -843,6 +1015,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e any type of response.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -903,6 +1085,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e an outstanding request. Returns the number of cycles until the response i=
s received (i.e. XQ to XQ latency).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.OUTSTANDING",
+        "MSRIndex": "0x1a6",
+        "MSRValue": "0x8000000000000477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts streaming stores that were supplied by=
 the L3 cache.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/memory.json b/tools/=
perf/pmu-events/arch/x86/snowridgex/memory.json
index 34306ec24e9b..260a488540bb 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/memory.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/memory.json
@@ -25,6 +25,16 @@
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000044",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all code reads that were not supplied =
by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -45,6 +55,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.ALL_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000044",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -65,6 +85,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -85,6 +115,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re not supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -105,6 +155,27 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.L3_MISS",
         "Counter": "0,1,2,3",
@@ -127,6 +198,27 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
+        "Counter": "0,1,2,3",
+        "Deprecated": "1",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -147,6 +239,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -167,6 +269,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000040",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -187,6 +299,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_CODE_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000040",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000010",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -207,6 +339,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_DATA_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000010",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000020",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -227,6 +379,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.HWPF_L2_RFO.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000020",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -317,6 +479,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e not supplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -337,6 +509,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x184000477",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts streaming stores that were not supplie=
d by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -357,6 +539,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x100184000000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts uncached memory reads that were not su=
pplied by the L3 cache.",
         "Counter": "0,1,2,3",
@@ -377,6 +569,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0XB7",
+        "EventName": "OCR.UC_RD.LOCAL_DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x100184000000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts uncached memory writes that were not s=
upplied by the L3 cache.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/other.json b/tools/p=
erf/pmu-events/arch/x86/snowridgex/other.json
index 57613207f7ad..35cdbfa617e7 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/other.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/other.json
@@ -116,26 +116,6 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.ALL_CODE_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000044",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all code reads that were supplied by D=
RAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.ALL_CODE_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000044",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts all code reads that have an outstandin=
g request. Returns the number of cycles until the response is received (i.e=
. XQ to XQ latency).",
         "Counter": "0,1,2,3",
@@ -146,180 +126,6 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3000000010000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have an outstanding request. Returns the number of cycles unt=
il the response is received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.COREWB_M.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8003000000000000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
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
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_CODE_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that we=
re supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts cacheable demand data reads, L1 data c=
ache hardware prefetches and software prefetches (except PREFETCHW) that ha=
ve an outstanding request. Returns the number of cycles until the response =
is received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.ANY_RESPONSE",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.DRAM",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.LOCAL_DRAM",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "This event is deprecated. Refer to new event =
OCR.DEMAND_DATA_AND_L1PF_RD.OUTSTANDING",
-        "Counter": "0,1,2,3",
-        "Deprecated": "1",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_DATA_RD.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_RFO.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_RFO.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have an outstan=
ding request. Returns the number of cycles until the response is received (=
i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.DEMAND_RFO.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
         "Counter": "0,1,2,3",
@@ -330,146 +136,6 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts L1 data cache hardware prefetches and =
software prefetches (except PREFETCHW and PFRFO) that have any type of resp=
onse.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L1D_AND_SWPF.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10400",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10040",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_CODE_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000040",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_CODE_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000040",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch code reads =
(written to the L2 cache only) that have an outstanding request. Returns th=
e number of cycles until the response is received (i.e. XQ to XQ latency)."=
,
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_CODE_RD.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000040",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10010",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_DATA_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000010",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch data reads =
(written to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_DATA_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000010",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_RFO.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10020",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_RFO.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000020",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that were supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_RFO.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000020",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L2 cache hardware prefetch RFOs (writt=
en to the L2 cache only) that have an outstanding request. Returns the numb=
er of cycles until the response is received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.HWPF_L2_RFO.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000020",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts modified writebacks from L1 cache that=
 miss the L2 cache that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.L1WB_M.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x1000000010000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts modified writeBacks from L2 cache that=
 miss the L3 cache that have any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.L2WB_M.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x2000000010000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts miscellaneous requests, such as I/O ac=
cesses, that have any type of response.",
         "Counter": "0,1,2,3",
@@ -500,46 +166,6 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e any type of response.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.READS_TO_CORE.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.READS_TO_CORE.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that wer=
e supplied by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.READS_TO_CORE.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x184000477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts all data read, code read and RFO reque=
sts including demands and prefetches to the core caches (L1 or L2) that hav=
e an outstanding request. Returns the number of cycles until the response i=
s received (i.e. XQ to XQ latency).",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.READS_TO_CORE.OUTSTANDING",
-        "MSRIndex": "0x1a6",
-        "MSRValue": "0x8000000000000477",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3",
@@ -560,26 +186,6 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.UC_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x100184000000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts uncached memory reads that were suppli=
ed by DRAM.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0XB7",
-        "EventName": "OCR.UC_RD.LOCAL_DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x100184000000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts uncached memory reads that have an out=
standing request. Returns the number of cycles until the response is receiv=
ed (i.e. XQ to XQ latency).",
         "Counter": "0,1,2,3",
--=20
2.49.0.472.ge94155a9ec-goog

