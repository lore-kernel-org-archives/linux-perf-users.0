Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE4189912
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 00:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947791; cv=none; b=n7tyBgshpHqHmhrC/A9oaaFPKdf45J/Td6+PzvL/4tWn4E5f/juvcipZ2K5qjnu2oK2+yjrRYVySzr11BABa0z+Q+N6fPHJoqWuE8lp8pWK3NHOYzYpzsrCDqKjJ4rt2hc7rsqV/nVKUsFwQj5skpkczPaR1FAC6cgPeK4UDP68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947791; c=relaxed/simple;
	bh=0AT9S4+tQKLFJnJKnyWkGKU0/cg5F7/LVzqrzS1ky+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=U2xEGYVDYw7T2+JpfyHdekvSC1KKZ1io3tmwLS6n4QvMAhiSTHqXVQXeTYGYBJedatSdlUN/T2eT9u3ZH2u8rN7wopnRFZPw+LSroqVcMJs2qWDaKUgDTdo4IOMbrO+5851GBfHmwBfLRNsKcMEeCJ6/vxCnS4Vo/3ctbxn4QiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctFKppnO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctFKppnO"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so17537592a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 17:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947787; x=1743552587; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umn9Nu09RuoBihtyilxpcZ9ZnsjZo8cvNgml2LAfPCY=;
        b=ctFKppnOfHrQ0fyjQMIeNpX4zESAOPG6WBGG8JoiH5cUy4SdLS3QBxrwYYQONpurGw
         6WDFVOpiPYjqwbwLivTSSIJqRlh5tluo+XN48cZVVB2GAtBPanFaHj0b4b3ciNbXGNH8
         nX+Gu8LHjbOrBTrFQ14623bwwKgCkRT6yFDst7pmBB4VUJae8HXuU4PzZc9bPXqnTMDJ
         k+j2VbqBGs+47YuSbriqg2oDXfEhMNGbQxi0tQGGkuEWYLJdoil4mmN5qAh0RKbt47xf
         rtULzDk5VIkBrXFMUkJBpIjp6gEjwLOuatanAFHEWM3iFSWjPhac63rBr1QO9Y4rdGdG
         /p5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947787; x=1743552587;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=umn9Nu09RuoBihtyilxpcZ9ZnsjZo8cvNgml2LAfPCY=;
        b=NwR1NnkFPa7wl2CAww4mqPBP45Za6pztD1sOpS1ocdGmVGTrarlfMoyzk6V0AtCy1K
         Vkr4qZ9Dj4PJKEO/cFIaE+QRw2s5o9TP9S4gMja5csYecM3BYDjTqHqnucoG40b8w9Y/
         V4zBDxVRPnrU43wMo3VDmlRnYraXPLMiuoBmRvgv0R4nFmwKAxxT+owuon1+86WyH2Fa
         36zIrUcfih6QHJoGi3FLuieS0wRD9aAg13HKIEBEkbds/jnvzo9wHD2u7GrOVXFe0Z3O
         i2AUtXtEUGTycBdpU67yxCd6uE63jCBnIUHejV5lhaDRNE94GwlSYrN/eTwImyb0NXiS
         4QtA==
X-Forwarded-Encrypted: i=1; AJvYcCWMDE7x/DpDvWFBVuZm4lE0R+sIxhmczyIfG+QBvFWGOyQV985ffCIpFlstGBVN06mZzvuDFO3/gu06VQqSIz/F@vger.kernel.org
X-Gm-Message-State: AOJu0YyXnbvewQWOcYN2BF0itybkoFoO7AliVJfd8NbOFuHqmS/+Y2oY
	I9/yf+19YpwSG4412nRWumXEI3QDbb1xN3z2UqCZV7MxyGUbBHj8T6dPQanbsk0nmvBqCZ1e7Gu
	WYGu/4Q==
X-Google-Smtp-Source: AGHT+IG7tJBdLQt+JiiRjeh94pcBEFZUxUWYxH+OLGhKxd2B4HZuBNfutj/wwUkHFqT45oiQ8ANAONPbAu+r
X-Received: from pjbqd16.prod.google.com ([2002:a17:90b:3cd0:b0:2ef:8055:93d9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2647:b0:2ff:592d:23bc
 with SMTP id 98e67ed59e1d1-3030fe58cc6mr30094855a91.4.1742947787303; Tue, 25
 Mar 2025 17:09:47 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:29 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-32-irogers@google.com>
Subject: [PATCH v3 31/35] perf vendor events: Update snowridgex events
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
2.49.0.395.g12beb8f557-goog

