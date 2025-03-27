Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714D1EF365
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114247; cv=none; b=umcT+sYzT11unnlWemltieeD5xtBP5OBwCNUj/F3nnlbRQrOxLPlCGqKrXWk2tl64dc9kZ2s9Ak6BA7pPZZFWBclfzfMqU+8WxXC2yHMHqIxBnoprimxjYc5exYyXOky+gDnWjD0yqK3FU163R5v9kYW9vnV/bGKTvTfwwzfbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114247; c=relaxed/simple;
	bh=95zQSXHwS7zHC40e9B6yNMh54DuGC6WRwjKmT8Yqu/0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QmQH1P6kNFGdIRo+xsj+Wv3FEE0aGJBm/AyItm/9Ub6owZYy9kWEaL4IYi6gCuXD+VF9S4ETHYfNsshzCCAOHkuTQpYnEFG+1UtqsTrTeSkYn8N7jaLzBjnA/C4j9tJDLpmjHLKXSTuA4WD168Ps2E14XLkbOoGh1/7nthzERKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dhsQRqr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dhsQRqr"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so1464909a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743114241; x=1743719041; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+jBaOAS07jTrzqWC7g+NycYzv7lO7vRQH7Jvctfr0Q=;
        b=0dhsQRqrlGPwWuHpgZKI+bfy5uLI5hQHggtM/wvmnOp7+xWlpCcnFK+GlDviGTThrD
         /Mt4IyfAUe6/ggnwowTVG5QyoYsSEXuuY+u8zuQEzuC5+hwpz7OUqEjejKpKh/sFTnxH
         G8ehOWP1sRN5WzLbhmMNQTnEEYDdsfYABlP9YMy1kWVUinXPNypzDG5GbKGRmASDPvc4
         oQdTfRZswtAdi9NR9udhWzj0iRng7/IZaoQJeYkT9UwtcVupa7TblNJgwR7qvG+IDAPd
         dH0kBTtUILox1Sh9SspqM4gj4gdCL0TaRfU8XG+m9lRmznn1zrmv5dVxSzQp930c6sYX
         ynsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743114241; x=1743719041;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X+jBaOAS07jTrzqWC7g+NycYzv7lO7vRQH7Jvctfr0Q=;
        b=UjKHAZyh08ayYyZchG/rfUeXXIa9V41oDrrN1rlVeisozK6Mby8rQNxMj5oEmjB/rO
         qenXgYdKEyOtCwx+nLBRytlqCA20Yaa8mOknDKNqeDftQrUyCb2GEi4TltpYZ7UuRoqw
         2MoWtnPrzyga4/L8ASFz6hrYhWzcv6ipkTrnHdDlgKeFsIzXECElxiLyT+QSOKxvOJZn
         dfKqqli7QmoIe/B42QoCz/YlERj2Yjp3ydVRS5InR+XGa+5Y0q7ig+YqVg1qiFswQlY9
         dwWGIg5J0J3Qb+6w0WBp/nR0ZCy78nWyxeaDGlHiFEZn/eoTb6hfZTBLwctxDqeQFzlj
         sXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+EKCI4lXEbGv+K5QdjXUkxpakxY7U4di2nINIZQCLqUAlo1fOaaynnlIV7YJlI+Rv6c3lJ0wWGkVhS3cdO2F1@vger.kernel.org
X-Gm-Message-State: AOJu0YzzVjz1IvW9kdEyblDklzl3yY6vLZgIKTs/VxZo7GKhCWNj1wVl
	S7k+HXK0S+TD6tmn9Q0/WxzYS1j3yC/4vqrEFOOV6NHaf02fCgJWSpBx6fZbegtATWjfqRe+UKz
	GVxJ2og==
X-Google-Smtp-Source: AGHT+IG54jeDZtWnvt1eLPsgbFWie6Pim2sylrhou4CzZPut/H7NX0sEBUCb90Eyfb2IrO2hyMDPIupnIdSs
X-Received: from pga5.prod.google.com ([2002:a05:6a02:4f85:b0:af2:3385:de87])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9990:b0:1ee:8435:6b69
 with SMTP id adf61e73a8af0-1fea2d32fddmr10273404637.1.1743114241104; Thu, 27
 Mar 2025 15:24:01 -0700 (PDT)
Date: Thu, 27 Mar 2025 15:23:07 -0700
In-Reply-To: <20250327222331.117701-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250327222331.117701-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327222331.117701-13-irogers@google.com>
Subject: [PATCH v4 12/35] perf vendor events: Update grandridge events/metrics
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

Update events from v1.05 to v1.07.
Update event topics, metrics to be generated from the TMA spreadsheet
and other small clean ups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/grandridge/cache.json | 150 +++++++-
 .../arch/x86/grandridge/counter.json          |   2 +-
 .../arch/x86/grandridge/frontend.json         |   8 +
 .../arch/x86/grandridge/grr-metrics.json      | 204 ++++++-----
 .../pmu-events/arch/x86/grandridge/other.json |  28 --
 .../arch/x86/grandridge/pipeline.json         |  51 ++-
 .../arch/x86/grandridge/uncore-cache.json     |  45 ++-
 .../arch/x86/grandridge/uncore-memory.json    | 338 ++++++++++++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 9 files changed, 698 insertions(+), 130 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/grandridge/cache.json b/tools/p=
erf/pmu-events/arch/x86/grandridge/cache.json
index 04802e254e51..21671c65d6dd 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/cache.json
@@ -1,4 +1,91 @@
 [
+    {
+        "BriefDescription": "Counts the number of L1D cacheline (dirty) ev=
ictions caused by load misses, stores, and prefetches.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x51",
+        "EventName": "DL1.DIRTY_EVICTION",
+        "PublicDescription": "Counts the number of L1D cacheline (dirty) e=
victions caused by load misses, stores, and prefetches.  Does not count evi=
ctions or dirty writebacks caused by snoops.  Does not count a replacement =
unless a (dirty) line was written back.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Exclusive state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.E",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Exclusive state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Forward state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.F",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Forward state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x10"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Modified state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.M",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Modified state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
+    {
+        "BriefDescription": "Counts the number of cache lines filled into =
the L2 cache that are in Shared state",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x25",
+        "EventName": "L2_LINES_IN.S",
+        "PublicDescription": "Counts the number of cache lines filled into=
 the L2 cache that are in Shared state. Counts on a per core basis.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache lines that are =
evicted due to an L2 cache fill",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.NON_SILENT",
+        "PublicDescription": "Counts the number of L2 cache lines that are=
 evicted due to an L2 cache fill. Increments on the core that brought the l=
ine in originally.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 cache lines that are =
silently dropped due to an L2 cache fill",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x26",
+        "EventName": "L2_LINES_OUT.SILENT",
+        "PublicDescription": "Counts the number of L2 cache lines that are=
 silently dropped due to an L2 cache fill.  Increments on the core that bro=
ught the line in originally.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 Cache Accesses that r=
esulted in a Hit from a front door request only (does not include rejects o=
r recycles), per core event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of total L2 Cache Accesses =
that resulted in a Miss from a front door request only (does not include re=
jects or recycles), per core event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 Cache Accesses that m=
iss the L2 and get BBL reject  short and long rejects, per core event",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.REJECTS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -35,7 +122,7 @@
         "UMask": "0x1"
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
@@ -43,7 +130,7 @@
         "UMask": "0x6"
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
@@ -68,7 +155,7 @@
         "UMask": "0x1"
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
@@ -76,13 +163,21 @@
         "UMask": "0x6"
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
         "SampleAfterValue": "1000003",
         "UMask": "0x78"
     },
+    {
+        "BriefDescription": "Counts the number of unhalted cycles when the=
 core is stalled to a store buffer full condition",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0x34",
+        "EventName": "MEM_BOUND_STALLS_LOAD.SBFULL",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x80"
+    },
     {
         "BriefDescription": "Counts the number of load ops retired that mi=
ss the L3 cache and hit in DRAM",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -335,6 +430,33 @@
         "SampleAfterValue": "200003",
         "UMask": "0x42"
     },
+    {
+        "BriefDescription": "Counts the number of memory uops retired that=
 missed in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x13"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the second Level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Counts the number of store uops retired that =
miss in the second level TLB.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x12"
+    },
     {
         "BriefDescription": "Counts the number of  stores uops retired sam=
e as MEM_UOPS_RETIRED.ALL_STORES",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -344,6 +466,16 @@
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
@@ -364,6 +496,16 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/counter.json b/tools=
/perf/pmu-events/arch/x86/grandridge/counter.json
index 9fd5d8ad6d3b..d9ac3aca5bd5 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/counter.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/counter.json
@@ -37,6 +37,6 @@
     {
         "Unit": "CHACMS",
         "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
+        "CountersNumGeneric": "4"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/frontend.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/frontend.json
index 7cdf611efb23..fef5cba533bb 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/frontend.json
@@ -31,5 +31,13 @@
         "EventName": "ICACHE.MISSES",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles that the micro-se=
quencer is busy.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xe7",
+        "EventName": "MS_DECODED.MS_BUSY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json b/t=
ools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
index 2f9959c61718..1c6dba7b2822 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
@@ -216,15 +216,17 @@
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to certain allocation restrictions",
         "MetricExpr": "tma_core_bound",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_core_bound_group"=
,
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_allocation_restriction",
+        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core_b=
ound > 0.1 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend due to backend stalls",
         "MetricExpr": "TOPDOWN_BE_BOUND.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
+        "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
+        "MetricThreshold": "tma_backend_bound > 0.1",
         "MetricgroupNoGroup": "TopdownL1",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
         "ScaleUnit": "100%"
@@ -232,92 +234,104 @@
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.ALL_P / (6 * CPU_CLK_UNHALT=
ED.CORE)",
-        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
+        "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
+        "MetricThreshold": "tma_bad_speculation > 0.15",
         "MetricgroupNoGroup": "TopdownL1",
-        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BACLEARS, which occurs when the Branch T=
arget Buffer (BTB) prediction or lack thereof, was corrected by a later bra=
nch predictor in the frontend",
         "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_detect",
-        "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s",
+        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
+        "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s.",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to branch mispredicts",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / (6 * CPU_CLK_U=
NHALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_bad_speculation_g=
roup",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
+        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BTCLEARS, which occurs when the Branch T=
arget Buffer (BTB) predicts a taken branch",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BTCLEARS, which occurs when the Branch T=
arget Buffer (BTB) predicts a taken branch.",
         "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / (6 * CPU_CLK_UNHA=
LTED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_resteer",
+        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS)",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS).",
         "MetricExpr": "TOPDOWN_FE_BOUND.CISC / (6 * CPU_CLK_UNHALTED.CORE)=
",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_cisc",
+        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are bounded by core restrictions and not attributed to an o=
utstanding load or stores, or resource limitation",
         "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / (6 * CPU_CLK_=
UNHALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_backend_bound_gro=
up",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_core_bound",
+        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls.",
         "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / (6 * CPU_CLK_UNHALTED.COR=
E)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_decode",
+        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that does not require the =
use of microcode, classified as a fast nuke, due to memory ordering, memory=
 disambiguation and memory renaming",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / (6 * CPU_CLK_UNH=
ALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_machine_clears_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_fast_nuke",
+        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls.",
         "MetricExpr": "TOPDOWN_FE_BOUND.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
+        "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
+        "MetricThreshold": "tma_frontend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses.",
         "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / (6 * CPU_CLK_UNHALTED.COR=
E)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_icache_misses",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations.",
         "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / (6 * CPU_CLK_=
UNHALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_frontend_bound_gr=
oup",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_ifetch_bandwidth",
+        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations.",
         "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / (6 * CPU_CLK_UN=
HALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_frontend_bound_gr=
oup",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_ifetch_latency",
+        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -348,33 +362,28 @@
     {
         "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
         "MetricExpr": "100 * (LD_HEAD.DTLB_MISS_AT_RET + LD_HEAD.PGWALK_AT=
_RET) / CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": "Cycles",
-        "MetricName": "tma_info_bottleneck_dtlb_miss_bound_cycles",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_bottleneck_%_dtlb_miss_bound_cycles"
     },
     {
         "BriefDescription": "Percentage of time that allocation and retire=
ment is stalled by the Frontend Cluster due to an Ifetch Miss, either Icach=
e or ITLB Miss",
         "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.ALL / CPU_CLK_UNHALTE=
D.CORE",
-        "MetricGroup": "Cycles;Ifetch",
-        "MetricName": "tma_info_bottleneck_ifetch_miss_bound_cycles",
-        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound",
-        "ScaleUnit": "100%"
+        "MetricGroup": "Ifetch",
+        "MetricName": "tma_info_bottleneck_%_ifetch_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound"
     },
     {
         "BriefDescription": "Percentage of time that retirement is stalled=
 due to an L1 miss",
         "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.ALL / CPU_CLK_UNHALTED.=
CORE",
-        "MetricGroup": "Cycles;Load_Store_Miss",
-        "MetricName": "tma_info_bottleneck_load_miss_bound_cycles",
-        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound",
-        "ScaleUnit": "100%"
+        "MetricGroup": "Load_Store_Miss",
+        "MetricName": "tma_info_bottleneck_%_load_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound"
     },
     {
         "BriefDescription": "Percentage of time that retirement is stalled=
 by the Memory Cluster due to a pipeline stall",
         "MetricExpr": "100 * LD_HEAD.ANY_AT_RET / CPU_CLK_UNHALTED.CORE",
-        "MetricGroup": "Cycles;Mem_Exec",
-        "MetricName": "tma_info_bottleneck_mem_exec_bound_cycles",
-        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound",
-        "ScaleUnit": "100%"
+        "MetricGroup": "Mem_Exec",
+        "MetricName": "tma_info_bottleneck_%_mem_exec_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound"
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
@@ -429,26 +438,22 @@
     {
         "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
         "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.LD_BUF / CPU_CLK_UNHALTED=
.CORE",
-        "MetricName": "tma_info_buffer_stalls_load_buffer_stall_cycles",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_buffer_stalls_%_load_buffer_stall_cycles"
     },
     {
         "BriefDescription": "Percentage of time that allocation is stalled=
 due to memory reservation stations full",
         "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.RSV / CPU_CLK_UNHALTED.CO=
RE",
-        "MetricName": "tma_info_buffer_stalls_mem_rsv_stall_cycles",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_buffer_stalls_%_mem_rsv_stall_cycles"
     },
     {
         "BriefDescription": "Percentage of time that allocation is stalled=
 due to store buffer full",
         "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.ST_BUF / CPU_CLK_UNHALTED=
.CORE",
-        "MetricName": "tma_info_buffer_stalls_store_buffer_stall_cycles",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_buffer_stalls_%_store_buffer_stall_cycles"
     },
     {
         "BriefDescription": "Cycles Per Instruction",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE / INST_RETIRED.ANY",
-        "MetricName": "tma_info_core_cpi",
-        "ScaleUnit": "1per_instr"
+        "MetricName": "tma_info_core_cpi"
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
@@ -469,28 +474,46 @@
     {
         "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
         "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.L2_HIT / MEM_BOUND_ST=
ALLS_IFETCH.ALL",
-        "MetricName": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l2h=
it",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2hit"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss doesn't hit in the L2",
+        "MetricExpr": "100 * (MEM_BOUND_STALLS_IFETCH.LLC_HIT + MEM_BOUND_=
STALLS_IFETCH.LLC_MISS) / MEM_BOUND_STALLS_IFETCH.ALL",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2miss"
     },
     {
         "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
         "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.LLC_HIT / MEM_BOUND_S=
TALLS_IFETCH.ALL",
-        "MetricName": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l3h=
it",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3hit"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss subsequently misses in the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.LLC_MISS / MEM_BOUND_=
STALLS_IFETCH.ALL",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3miss"
     },
     {
         "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
         "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.L2_HIT / MEM_BOUND_STAL=
LS_LOAD.ALL",
         "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_loadmissbound_with_l2hit",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2hit=
"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses in the L2",
+        "MetricExpr": "100 * (MEM_BOUND_STALLS_LOAD.LLC_HIT + MEM_BOUND_ST=
ALLS_LOAD.LLC_MISS) / MEM_BOUND_STALLS_LOAD.ALL",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2mis=
s"
     },
     {
         "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
         "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.LLC_HIT / MEM_BOUND_STA=
LLS_LOAD.ALL",
         "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_loadmissbound_with_l3hit",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3hit=
"
+    },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.LLC_MISS / MEM_BOUND_ST=
ALLS_LOAD.ALL",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3mis=
s"
     },
     {
         "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a pipeline block",
@@ -528,44 +551,37 @@
     {
         "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
         "MetricExpr": "100 * LD_BLOCKS.ADDRESS_ALIAS / MEM_UOPS_RETIRED.AL=
L_LOADS",
-        "MetricName": "tma_info_mem_exec_blocks_loads_with_adressaliasing"=
,
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_adressaliasin=
g"
     },
     {
         "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
         "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
-        "MetricName": "tma_info_mem_exec_blocks_loads_with_storefwdblk",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_storefwdblk"
     },
     {
         "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
         "MetricExpr": "100 * LD_HEAD.L1_MISS_AT_RET / LD_HEAD.ANY_AT_RET",
-        "MetricName": "tma_info_mem_exec_bound_loadhead_with_l1miss",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_l1miss"
     },
     {
         "BriefDescription": "Percentage of Memory Execution Bound due to o=
ther block cases, such as pipeline conflicts, fences, etc",
         "MetricExpr": "100 * LD_HEAD.OTHER_AT_RET / LD_HEAD.ANY_AT_RET",
-        "MetricName": "tma_info_mem_exec_bound_loadhead_with_otherpipeline=
blks",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_otherpipeli=
neblks"
     },
     {
         "BriefDescription": "Percentage of Memory Execution Bound due to a=
 pagewalk",
         "MetricExpr": "100 * LD_HEAD.PGWALK_AT_RET / LD_HEAD.ANY_AT_RET",
-        "MetricName": "tma_info_mem_exec_bound_loadhead_with_pagewalk",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_pagewalk"
     },
     {
         "BriefDescription": "Percentage of Memory Execution Bound due to a=
 second level TLB miss",
         "MetricExpr": "100 * LD_HEAD.DTLB_MISS_AT_RET / LD_HEAD.ANY_AT_RET=
",
-        "MetricName": "tma_info_mem_exec_bound_loadhead_with_stlbhit",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_stlbhit"
     },
     {
         "BriefDescription": "Percentage of Memory Execution Bound due to a=
 store forward address match",
         "MetricExpr": "100 * LD_HEAD.ST_ADDR_AT_RET / LD_HEAD.ANY_AT_RET",
-        "MetricName": "tma_info_mem_exec_bound_loadhead_with_storefwding",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_storefwding=
"
     },
     {
         "BriefDescription": "Instructions per Load",
@@ -595,8 +611,7 @@
     {
         "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
         "MetricExpr": "100 * SERIALIZATION.C01_MS_SCB / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricName": "tma_info_serialization_tpause_cycles",
-        "ScaleUnit": "100%"
+        "MetricName": "tma_info_serialization_%_tpause_cycles"
     },
     {
         "BriefDescription": "Average CPU Utilization",
@@ -612,17 +627,20 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P:k / CPU_CLK_UNHALTED.CORE",
+        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE_P@k / CPU_CLK_UNHALTED.CO=
RE",
+        "MetricGroup": "Summary",
         "MetricName": "tma_info_system_kernel_utilization"
     },
     {
         "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE_P / CPU_CLK_UNHALTED.CORE",
-        "MetricName": "tma_info_system_mux"
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9"
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricGroup": "Power",
         "MetricName": "tma_info_system_turbo_utilization"
     },
     {
@@ -646,90 +664,102 @@
         "MetricName": "tma_info_uop_mix_x87_uop_ratio"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses.",
         "MetricExpr": "TOPDOWN_FE_BOUND.ITLB_MISS / (6 * CPU_CLK_UNHALTED.=
CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_itlb_misses",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / (6 * CPU_C=
LK_UNHALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_bad_speculation_g=
roup",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_machine_clears",
+        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
n > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to memory reservation stalls in which a sched=
uler is not able to accept uops",
         "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_mem_scheduler",
+        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to IEC or FPC RAT stalls, which can be due to=
 FIQ or IEC reservation stalls in which the integer, floating point or SIMD=
 scheduler is not able to accept uops",
         "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / (6 * CPU_CLK_U=
NHALTED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_non_mem_scheduler",
+        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that requires the use of m=
icrocode (slow nuke)",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / (6 * CPU_CLK_UNHALTE=
D.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_machine_clears_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_nuke",
+        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized.",
         "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_other_fb",
+        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes.",
         "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / (6 * CPU_CLK_UNHALTED.=
CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_predecode",
+        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the physical register file unable to accep=
t an entry (marble stalls)",
         "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / (6 * CPU_CLK_UNHALTED.C=
ORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_register",
+        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the reorder buffer being full (ROB stalls)=
",
         "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / (6 * CPU_CLK_UNHA=
LTED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_reorder_buffer",
+        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a resource limitation",
         "MetricExpr": "tma_backend_bound - tma_core_bound",
-        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_backend_bound_gro=
up",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_resource_bound",
+        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that result =
in retirement slots",
         "MetricExpr": "TOPDOWN_RETIRING.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
+        "MetricGroup": "TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
+        "MetricThreshold": "tma_retiring > 0.75",
         "MetricgroupNoGroup": "TopdownL1",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to scoreboards from the instruction queue (IQ=
), jump execution unit (JEU), or microcode sequencer (MS)",
         "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_serialization",
+        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/other.json b/tools/p=
erf/pmu-events/arch/x86/grandridge/other.json
index 28f9a4c3ea84..daa16030d493 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/other.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/other.json
@@ -8,26 +8,6 @@
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
@@ -37,13 +17,5 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/grandridge/pipeline.json
index 40fa4f5ae261..a934b64f66d0 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
@@ -56,6 +56,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
+    {
+        "BriefDescription": "Counts the number of near indirect JMP branch=
 instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.INDIRECT_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xef"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -81,6 +89,30 @@
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
+    {
+        "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
+        "SampleAfterValue": "200003",
+        "UMask": "0xc0"
+    },
+    {
+        "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_CALL",
+        "SampleAfterValue": "200003",
+        "UMask": "0xfd"
+    },
+    {
+        "BriefDescription": "Counts the number of near relative JMP branch=
 instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc4",
+        "EventName": "BR_INST_RETIRED.REL_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xdf"
+    },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -121,6 +153,14 @@
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
+    {
+        "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xc5",
+        "EventName": "BR_MISP_RETIRED.INDIRECT_JMP",
+        "SampleAfterValue": "200003",
+        "UMask": "0xef"
+    },
     {
         "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -236,8 +276,9 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine with the use of microcode due to SMC=
, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUAL_=
TRAP.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5,6,7",
+        "Deprecated": "1",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SLOW",
         "SampleAfterValue": "20003",
@@ -259,6 +300,14 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
index 6a80cf6cbd36..b89ab6e5cfb5 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-cache.json
@@ -8,6 +8,16 @@
         "PortMask": "0x000",
         "Unit": "CHACMS"
     },
+    {
+        "BriefDescription": "Counts the number of cycles FAST trigger is r=
eceived from the global FAST distress wire.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x34",
+        "EventName": "UNC_CHACMS_RING_SRC_THRTL",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PortMask": "0x000",
+        "Unit": "CHACMS"
+    },
     {
         "BriefDescription": "Number of CHA clock cycles while the event is=
 enabled",
         "Counter": "0,1,2,3",
@@ -530,6 +540,26 @@
         "UMask": "0x4",
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
+    {
+        "BriefDescription": "Ingress (from CMS) Occupancy : IRQ : Counts n=
umber of entries in the specified Ingress queue in each cycle.",
+        "Counter": "0",
+        "EventCode": "0x11",
+        "EventName": "UNC_CHA_RxC_OCCUPANCY.IRQ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "All TOR Inserts",
         "Counter": "0,1,2,3",
@@ -603,7 +633,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read opt prefetch from local IA that mis=
s the cache",
+        "BriefDescription": "Data read opt prefetch from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
@@ -764,7 +794,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA that miss the cache",
+        "BriefDescription": "Last level cache prefetch read for ownership =
from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_LLCPREFRFO",
@@ -859,7 +889,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that missed the LLC",
+        "PublicDescription": "TOR Inserts : Data read opt prefetch from lo=
cal iA that missed the LLC targeting local memory",
         "UMask": "0xc8a6fe01",
         "Unit": "CHA"
     },
@@ -934,7 +964,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "BriefDescription": "Read for ownership from local IA that miss th=
e LLC targeting local memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_LOCAL",
@@ -954,7 +984,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the LLC targeting local memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_LOCAL",
@@ -1024,7 +1054,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "BriefDescription": "Read for ownership from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
@@ -1034,7 +1064,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "BriefDescription": "Read for ownership prefetch from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
@@ -1406,7 +1436,6 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores"=
,
         "UMask": "0xc827ff01",
diff --git a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
index e75b3050ccd5..6a11e5505957 100644
--- a/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/grandridge/uncore-memory.json
@@ -188,6 +188,256 @@
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
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH0_RANK3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x8",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK0",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x10",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK1",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x20",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK2",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x40",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x47",
+        "EventName": "UNC_M_POWERDOWN_CYCLES.SCH1_RANK3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x80",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles a given rank is in Power Down Mod=
e and all pages are closed",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x88",
+        "EventName": "UNC_M_POWER_CHANNEL_PPD_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "Unit": "IMC"
+    },
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
@@ -360,6 +610,94 @@
         "PerPkg": "1",
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
index 1b592cf63940..ed7a1845d43d 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -12,7 +12,7 @@ GenuineIntel-6-9[6C],v1.05,elkhartlake,core
 GenuineIntel-6-CF,v1.11,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
-GenuineIntel-6-B6,v1.05,grandridge,core
+GenuineIntel-6-B6,v1.07,grandridge,core
 GenuineIntel-6-A[DE],v1.06,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
--=20
2.49.0.472.ge94155a9ec-goog

