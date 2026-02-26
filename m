Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD33876B9
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Feb 2026 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772081591; cv=none; b=DR3FZRUfC4omejU5wvULVoSqN/kLHNjzD7rQEpTInrFHIXZrke9ao78kV853aF5ne2Xnmazhu+1c7EAXDslaCMh5BfrtnfkAZEji5aHtIccir02PO/SS5lKfmH8Xl/pPxzEWLdmF7SybPWrOWAilkLHqP1nLsP6XWsjeOn8tLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772081591; c=relaxed/simple;
	bh=W4VtDH0tM8R2uHOuZvtU79AyUHhrZjzQLgI7yxx9Sm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Okr+zZdDHympLkM/J94yf1sEP4bSoXLLC6Cdx92Uaxh5beyRbo94WHEvKxxhFdhkk82+ZmL6VBoQw26/JxRYOcQDWnEwtl2wfUSBBI7R5UmZvNtHXmTOttUsyb4NSIGl6Rjvt/vxYsZO4xqVYHjie1gImHfuv9AxCQQV6OJOX1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIVyOTPo; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIVyOTPo"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-126e8ee6227so681216c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Feb 2026 20:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772081589; x=1772686389; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SUhHGcSvPdY3f2YHlFAaLTVvEMlxJuiazk0owD9tgg=;
        b=dIVyOTPotUpBGy30oGswmMfAlehoXeEx8CG1ymuh6h54MwvmNCEhVJPTFPH9uVK9cv
         SDEBSL+EKcqRSzWdlsK3qax4zgG8YtA2snsJiNTgjYZ2+xQQ/VCZ6dyi0ABtgjkVNnVx
         F28jq7iCyzgx56W3Pb2SzNRwjdzuWgCq1ibN09OLRJBJ6jzhDTlBecGsn1sSDqsWh8HQ
         QjRtK7yBPjKLA5xLs61++Pj9Hwb/ArIsPOaJED4Q62ReBgM0UaNZIaWUerA1wgSsk2Xk
         T9ouAyyNPqQUvNbUBrv3teWXJUchUCm70i72QzjIqrZR5PqFo8NaPtLyChgPOLiH1Tzg
         qxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772081589; x=1772686389;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7SUhHGcSvPdY3f2YHlFAaLTVvEMlxJuiazk0owD9tgg=;
        b=T3VFX5h4PoDLAsuIeREHgV6VTGnA68nQ9MW/UmUBAqvjhULZoAIsQsK8pi4RtVoILM
         cLn/ckRDcL88c3WB9AAJgRRblOfpjRinleeBNUpW0sayBp4zLOvqzqVEHW7+hSH4l9WQ
         zOmS9UbqO/l/zZ8zNNtkJtQH6VnTQ3VQFg8czU50VkZ2kER48KMU2smsumzWa9Ya1srm
         VW87mvMnFu8V3VfXqyvZbENshBmnGcCU6PueEpSP0KCDLGuqaBU1H8uErKn3cWyWsI7a
         ln2azSizr3DMev1jrJw4U1XKl9tIuKTkNDW3SVU0TuqSGN4TEZGsZ296lZ02Sh2CFPuG
         sfzA==
X-Forwarded-Encrypted: i=1; AJvYcCXWG+JmCiV/auQuhDU+GZWr1dxQGbta877SN7yImp+UmTe8xduTz7okyEytWOGk8bNMXl1yR8v93u/3G5q2hPSQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvv5CajfE07s/ILz9PILnBWCL61CiDZPRisYFPXtADS+7Ep+jN
	GfxId9YSNXIEUTgX9sm/Xzwr1N6otcd5acXhUYFZI0v3fOBdDdyZ2g9dD6b3icTPLgJ5zwDMQVU
	o+l9ry05KIQ==
X-Received: from dlbeg32.prod.google.com ([2002:a05:7022:fa0:b0:123:2800:6acb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:50d:b0:127:5c70:930
 with SMTP id a92af1059eb24-12789ce8a88mr323568c88.43.1772081588738; Wed, 25
 Feb 2026 20:53:08 -0800 (PST)
Date: Wed, 25 Feb 2026 20:52:53 -0800
In-Reply-To: <20260226045301.459948-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260226045301.459948-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226045301.459948-2-irogers@google.com>
Subject: [PATCH v1 02/10] perf vendor events intel: Update arrowlake events
 from 1.14 to 1.16
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
https://github.com/intel/perfmon/commit/f0267f720eeab3b5416886c9e0e132fafcb=
38bbd
https://github.com/intel/perfmon/commit/d40cfa317e567fb5e8f6cbd92c81feeb7e6=
bd3dd

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/arrowlake/cache.json  | 103 ++++++++++++++----
 .../arch/x86/arrowlake/frontend.json          |  18 +++
 .../arch/x86/arrowlake/pipeline.json          |  40 +++++--
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 4 files changed, 135 insertions(+), 28 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/arrowlake/cache.json
index fba4a0672f6c..4c3aa1fab5a8 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/cache.json
@@ -628,6 +628,15 @@
         "UMask": "0x7f",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to an instruction cache or TLB miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x35",
+        "EventName": "MEM_BOUND_STALLS_IFETCH.ALL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x7f",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2 cache.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -731,6 +740,24 @@
         "UMask": "0x6",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles that the=
 core is stalled due to a demand load miss which hit in the LLC, no snoop w=
as required, and the LLC provided data",
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
s required, the snoop misses or the snoop hits but no fwd. LLC provides the=
 data",
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
@@ -749,6 +776,24 @@
         "UMask": "0x78",
         "Unit": "cpu_lowpower"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled due to a demand load miss which missed all the caches.  DR=
AM, MMIO or other LOCAL memory type provides the data",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.LLC_MISS_LOCALMEM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x50",
+        "Unit": "cpu_atom"
+    },
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
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled to a store buffer full condition",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1081,6 +1126,15 @@
         "UMask": "0x20",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of retired load ops with an=
 unknown source",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd4",
+        "EventName": "MEM_LOAD_UOPS_MISC_RETIRED.LOCAL_DRAM",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1181,6 +1235,15 @@
         "UMask": "0x1c",
         "Unit": "cpu_lowpower"
     },
+    {
+        "BriefDescription": "Counts the number of load ops retired that hi=
t in the L3 cache in which no snoop was required",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT_NO_SNOOP",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of loads that hit in a writ=
e combining buffer (WCB), excluding the first load that caused the WCB to a=
llocate.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1331,7 +1394,7 @@
         "Unit": "cpu_lowpower"
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
@@ -1343,7 +1406,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 128.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1355,7 +1418,7 @@
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
@@ -1367,7 +1430,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 16.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1379,7 +1442,7 @@
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
@@ -1391,7 +1454,7 @@
         "Unit": "cpu_lowpower"
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
@@ -1403,7 +1466,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 256.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1415,7 +1478,7 @@
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
@@ -1427,7 +1490,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 32.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1439,7 +1502,7 @@
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
@@ -1451,7 +1514,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 4.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1463,7 +1526,7 @@
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
@@ -1475,7 +1538,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 512.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1487,7 +1550,7 @@
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
@@ -1499,7 +1562,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 64.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1511,7 +1574,7 @@
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
@@ -1523,7 +1586,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOLD =
- Only counts with PEBS enabled",
+        "BriefDescription": "Counts the number of tagged load uops retired=
 that exceed the latency threshold of 8.",
         "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1535,7 +1598,7 @@
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
@@ -1707,7 +1770,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Counts the number of stores uops retired.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
@@ -1717,7 +1780,7 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
+        "BriefDescription": "Counts the number of stores uops retired.",
         "Counter": "0,1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xd0",
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/arrowlake/frontend.json
index a15de050a76c..21f00eafa98a 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/frontend.json
@@ -627,6 +627,24 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/arrowlake/pipeline.json
index 805616052925..fb973c75be57 100644
--- a/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
@@ -822,7 +822,7 @@
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
@@ -839,7 +839,7 @@
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
@@ -909,7 +909,7 @@
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
@@ -947,7 +947,7 @@
         "Unit": "cpu_lowpower"
     },
     {
-        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles.",
+        "BriefDescription": "Fixed Counter: Counts the number of unhalted =
core clock cycles. [This event is alias to CPU_CLK_UNHALTED.CORE]",
         "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "SampleAfterValue": "2000003",
@@ -964,7 +964,7 @@
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
@@ -1134,10 +1134,10 @@
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
         "Unit": "cpu_lowpower"
@@ -1607,6 +1607,14 @@
         "SampleAfterValue": "20003",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the total number of machine clears for=
 any reason including, but not limited to, memory ordering, memory disambig=
uation, SMC, and FP assist.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc3",
+        "EventName": "MACHINE_CLEARS.ANY",
+        "SampleAfterValue": "20003",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine without the use of microcode.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1813,6 +1821,15 @@
         "UMask": "0xff",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of CLFLUSH, CLWB, and CLDEM=
OTE instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC_RETIRED1.CL_INST",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xff",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Counts the number of LFENCE instructions reti=
red.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1822,6 +1839,15 @@
         "UMask": "0x2",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of LFENCE instructions reti=
red.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe0",
+        "EventName": "MISC_RETIRED1.LFENCE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_lowpower"
+    },
     {
         "BriefDescription": "Counts the number of RDPMC, RDTSC, and RDTSCP=
 instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 9370722dc564..7e9bc4241c61 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,7 +1,7 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.37,alderlake,core
 GenuineIntel-6-BE,v1.37,alderlaken,core
-GenuineIntel-6-C[56],v1.14,arrowlake,core
+GenuineIntel-6-C[56],v1.16,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
 GenuineIntel-6-56,v12,broadwellde,core
--=20
2.53.0.414.gf7e9f6c205-goog

