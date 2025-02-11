Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616DC2676C3
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309507; cv=none; b=jMiosK96y/GJ54I26bisBg+h+1x2IM2H0Qf+aNzTWeYsaxNTdBXULBLoUeDcbX9qbR7KAPTdLrvTbYhhI82uOn6lZ90XBNw3HH8UHMBRvxQt7rFcYQqBdpPsUk7mOi7iJcOr4+OXaodsgUSwRjBMjiSlEMucI3rRT3ojTounUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309507; c=relaxed/simple;
	bh=C04XcxM4h86ElaAtoyqR8RxBZVRY+1FrYlBi+52gUs4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qqK1qD/LK56LObMxiu2YKgIeRvV7W1G9Nyv9wV/FtTwmlQPzxCjrL3cqn1opWqhfSuuu4gmQtTP/h5MGKLa4bIqbHszYJlbiVmubRmzImOvLJldXQsjjSz9Gwt9AwwuejYo7TKYL9KUzDhaQmpN0QfzPfRVLh68BThRbFPdsClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4USJMo3I; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4USJMo3I"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f4348c854eso80510447b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Feb 2025 13:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739309486; x=1739914286; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPEGw/EJighM4s/hXEp9J0BBeEyhAixHnPvDEun1bB4=;
        b=4USJMo3I/qYioO2HduQd5fZTr++xK9/sAf1ZPI0zXgAhM39iUOkgFjAaYcDCOz5VNf
         ikFQFtf+gq4pt1zjB9xVQl/kaikuKJezBPdgDd0/+YgZmAnQfpzPdmKYrmPVgLMpS9cm
         Jqen+DZ/Wy0IdhbuP5aO3ayqwpt33qzHFS6/BKns1m37RzwWmwa/+B/ZZR1hNmQLsIXd
         671menOuAYLXk2NN2PjG0ycMbhoQXsgR/Uk6gA+8iWVlWSdb0GuxdDebhMOltqqXI5gF
         W/PBoQDjTMEd6f5C2xde3sJn76s2kJPpdzXzb1oHUXEUSc2OHIkbjSMdO++qOJ5ab+D3
         oGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739309486; x=1739914286;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tPEGw/EJighM4s/hXEp9J0BBeEyhAixHnPvDEun1bB4=;
        b=KQpcoCe7Tet0UqFTEOUVhwhQTIk2zGO/r1HkEBVYz7hnFWpyM1HDLsLL/mKBo+MoP7
         wCXgyXFJ2S1fU3oUyVix2QYsMKSjfGGDawl86mJ7CgTtWcZJeqofa9MWSMd10CbB6Sv0
         0tdhpfikUmKuJPM/1uN+mI5QPtpCUsK1veUZB9cQTssCbqmkKH0f1NgI15mgBeRvDWYU
         YxrYVCpBxHuWLH2C+qvk9lQP4o1eDNL2rJTfsHpoSTx+dAddmcHONDYcya24c2NzF9BE
         OEHSiksrhK+oG5VzhIpqZYs547BmyoyjzuCo9PBA7MMwgcZERW+8OOhLm2vjDDEN3O3y
         wfiA==
X-Forwarded-Encrypted: i=1; AJvYcCVSwj3n3u8GbKXspJDa3ygvpsmx8wBUnkwH9M3+b2UUWSHONfxcnsmofDxC4ujzyhP3CvrJTHoTCLWcaP9tVHtD@vger.kernel.org
X-Gm-Message-State: AOJu0YxomUvowKkkX1Zi81Wx/gIOjOTtsU/k6MNbUTJXHTsWWz6R4ZEi
	9j4i5O3hqp9IvlqEW7v4sRJxfvADBuKz6qmw973w7Tuyh1o8eBPhH1yOe/FyYtpMS2nxC6Hq2BJ
	LcVU3rA==
X-Google-Smtp-Source: AGHT+IGhGN5H8/t3WIUK0BEkyy2vjOPj2Ny3K5sBqABlGs9yZQFwZWok8a4xOdsuDSQC5Z/ApvbPN6kbJnib
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a24c:c86a:18a9:d15b])
 (user=irogers job=sendgmr) by 2002:a5b:a0e:0:b0:e39:8506:c03d with SMTP id
 3f1490d57ef6-e5d9f1815d2mr8078276.9.1739309486178; Tue, 11 Feb 2025 13:31:26
 -0800 (PST)
Date: Tue, 11 Feb 2025 13:30:27 -0800
In-Reply-To: <20250211213031.114209-1-irogers@google.com>
Message-Id: <20250211213031.114209-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250211213031.114209-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v8 20/24] perf vendor events: Update Sierraforest events/metrics
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
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.04 to v1.07.
Update TMA metrics from 4.8 to 5.02.

Bring in the event updates v1.08:
https://github.com/intel/perfmon/commit/7ae9c45ccf42cea2dc0b867ec1030ab5a84=
45b9f
https://github.com/intel/perfmon/commit/903b3d0a0a61bb6064013db9eb4c26457da=
cfea6
https://github.com/intel/perfmon/commit/825c4361473e676119b51f04c7896a8cfa8=
a5ea5
https://github.com/intel/perfmon/commit/bafe6a7b5cbee92c31ec19dfcefd6dcc243=
e4e8a

The TMA 5.02 addition is from (with subsequent fixes):
https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5c2=
2d782

Update uncore IIO events umask with the change:
https://github.com/intel/perfmon/commit/d78e8a166537c9ceab4f2e901dc96c53667=
a2174
which should address an issue originally raised by Michael Petlan:
Reported-by: Michael Petlan <mpetlan@redhat.com>
Closes: https://lore.kernel.org/all/alpine.LRH.2.20.2401300733310.11354@Die=
go/

Co-developed-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 .../arch/x86/sierraforest/cache.json          | 130 +++++++-
 .../arch/x86/sierraforest/counter.json        |  24 +-
 .../arch/x86/sierraforest/frontend.json       |   8 +
 .../arch/x86/sierraforest/other.json          |  20 ++
 .../arch/x86/sierraforest/pipeline.json       |  46 ++-
 .../arch/x86/sierraforest/srf-metrics.json    | 308 ++++++------------
 .../arch/x86/sierraforest/uncore-cache.json   |  61 +++-
 .../arch/x86/sierraforest/uncore-cxl.json     |   2 -
 .../x86/sierraforest/uncore-interconnect.json |  87 +++++
 .../arch/x86/sierraforest/uncore-io.json      | 280 ++++++++--------
 .../arch/x86/sierraforest/uncore-memory.json  | 122 ++++++-
 .../arch/x86/sierraforest/uncore-power.json   |  98 ++++++
 13 files changed, 799 insertions(+), 389 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index dd51caac7deb..678ee6b11184 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,7 @@ GenuineIntel-6-2E,v4,nehalemex,core
 GenuineIntel-6-A7,v1.04,rocketlake,core
 GenuineIntel-6-2A,v19,sandybridge,core
 GenuineIntel-6-8F,v1.25,sapphirerapids,core
-GenuineIntel-6-AF,v1.04,sierraforest,core
+GenuineIntel-6-AF,v1.08,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v59,skylake,core
 GenuineIntel-6-55-[01234],v1.35,skylakex,core
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json b/tools=
/perf/pmu-events/arch/x86/sierraforest/cache.json
index 04802e254e51..072df00aff92 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/cache.json
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
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/counter.json b/too=
ls/perf/pmu-events/arch/x86/sierraforest/counter.json
index e57e3bf98b2a..a92c75109e6a 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/counter.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/counter.json
@@ -19,6 +19,16 @@
         "CountersNumFixed": "0",
         "CountersNumGeneric": "4"
     },
+    {
+        "Unit": "CXLCM",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 8
+    },
+    {
+        "Unit": "CXLDP",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": 4
+    },
     {
         "Unit": "B2HOT",
         "CountersNumFixed": "0",
@@ -52,26 +62,16 @@
     {
         "Unit": "PCU",
         "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
+        "CountersNumGeneric": "4"
     },
     {
         "Unit": "CHACMS",
         "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
+        "CountersNumGeneric": "4"
     },
     {
         "Unit": "MDF",
         "CountersNumFixed": "0",
         "CountersNumGeneric": 4
-    },
-    {
-        "Unit": "CXLCM",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 8
-    },
-    {
-        "Unit": "CXLDP",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": 4
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/frontend.json b/to=
ols/perf/pmu-events/arch/x86/sierraforest/frontend.json
index 7cdf611efb23..fef5cba533bb 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/frontend.json
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
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/other.json b/tools=
/perf/pmu-events/arch/x86/sierraforest/other.json
index 28f9a4c3ea84..4c77dac8ec78 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/other.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/other.json
@@ -18,6 +18,26 @@
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
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
         "Counter": "0,1,2,3,4,5,6,7",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/sierraforest/pipeline.json
index b67c0c89054d..df2c7bb474a0 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
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
@@ -185,7 +225,6 @@
         "BriefDescription": "Fixed Counter: Counts the number of instructi=
ons retired",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -237,8 +276,9 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json b=
/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
index b881b1958f11..83c86afd2960 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
@@ -1,4 +1,11 @@
 [
+    {
+        "BriefDescription": "C10 residency percent per package",
+        "MetricExpr": "cstate_pkg@c10\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C10_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "C1 residency percent per core",
         "MetricExpr": "cstate_core@c1\\-residency@ / TSC",
@@ -7,17 +14,24 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per core",
-        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "BriefDescription": "C2 residency percent per package",
+        "MetricExpr": "cstate_pkg@c2\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C6_Core_Residency",
+        "MetricName": "C2_Pkg_Residency",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "C6 residency percent per module",
-        "MetricExpr": "cstate_module@c6\\-residency@ / TSC",
+        "BriefDescription": "C3 residency percent per package",
+        "MetricExpr": "cstate_pkg@c3\\-residency@ / TSC",
         "MetricGroup": "Power",
-        "MetricName": "C6_Module_Residency",
+        "MetricName": "C3_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C6 residency percent per core",
+        "MetricExpr": "cstate_core@c6\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C6_Core_Residency",
         "ScaleUnit": "100%"
     },
     {
@@ -28,7 +42,21 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles.",
+        "BriefDescription": "C7 residency percent per core",
+        "MetricExpr": "cstate_core@c7\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C7_Core_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "C8 residency percent per package",
+        "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
+        "MetricGroup": "Power",
+        "MetricName": "C8_Pkg_Residency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Cycles per instruction retired; indicating ho=
w much time each executed instruction took; in units of cycles",
         "MetricExpr": "CPU_CLK_UNHALTED.THREAD / INST_RETIRED.ANY",
         "MetricName": "cpi",
         "ScaleUnit": "1per_instr"
@@ -49,67 +77,67 @@
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
-        "BriefDescription": "Bandwidth observed by the integrated I/O traf=
fic contoller (IIO) of IO reads that are initiated by end device controller=
s that are requesting memory from the CPU.",
+        "BriefDescription": "Bandwidth observed by the integrated I/O traf=
fic contoller (IIO) of IO reads that are initiated by end device controller=
s that are requesting memory from the CPU",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.ALL_PARTS * 4 / 1e=
6 / duration_time",
         "MetricName": "iio_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth observed by the integrated I/O traf=
fic controller (IIO) of IO writes that are initiated by end device controll=
ers that are writing memory to the CPU.",
+        "BriefDescription": "Bandwidth observed by the integrated I/O traf=
fic controller (IIO) of IO writes that are initiated by end device controll=
ers that are writing memory to the CPU",
         "MetricExpr": "UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.ALL_PARTS * 4 / 1=
e6 / duration_time",
         "MetricName": "iio_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU.",
+        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the CPU",
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1e6 / durati=
on_time",
         "MetricName": "io_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the local CPU socket.=
",
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
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM + UNC_CHA_TOR_INSERTS.=
IO_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
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
@@ -118,14 +146,14 @@
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
@@ -177,25 +205,25 @@
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
@@ -225,13 +253,13 @@
         "ScaleUnit": "1MB/s"
     },
     {
-        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches.",
+        "BriefDescription": "Memory read that miss the last level cache (L=
LC) addressed to local DRAM as a percentage of total memory read accesses, =
does not include LLC prefetches",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_LOCAL + UNC_CH=
A_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL) / (UNC_CHA_TOR_INSERTS.IA_MISS_DR=
D_OPT_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL + UNC_CHA_TOR_=
INSERTS.IA_MISS_DRD_OPT_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_R=
EMOTE)",
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
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_REMOTE + UNC_C=
HA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_REMOTE) / (UNC_CHA_TOR_INSERTS.IA_MISS_=
DRD_OPT_LOCAL + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_LOCAL + UNC_CHA_TO=
R_INSERTS.IA_MISS_DRD_OPT_REMOTE + UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF=
_REMOTE)",
         "MetricName": "numa_reads_addressed_to_remote_dram",
         "ScaleUnit": "100%"
@@ -260,17 +288,15 @@
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to certain allocation restrictions",
         "MetricExpr": "tma_core_bound",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_core_bound_group"=
,
         "MetricName": "tma_allocation_restriction",
-        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core_b=
ound > 0.1 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend due to backend stalls",
         "MetricExpr": "TOPDOWN_BE_BOUND.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
-        "MetricThreshold": "tma_backend_bound > 0.1",
         "MetricgroupNoGroup": "TopdownL1",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
         "ScaleUnit": "100%"
@@ -278,104 +304,92 @@
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.ALL_P / (6 * CPU_CLK_UNHALT=
ED.CORE)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
-        "MetricThreshold": "tma_bad_speculation > 0.15",
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
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BACLEARS, which occurs when the Branch T=
arget Buffer (BTB) prediction or lack thereof, was corrected by a later bra=
nch predictor in the frontend",
         "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
         "MetricName": "tma_branch_detect",
-        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
-        "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s.",
+        "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to branch mispredicts",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / (6 * CPU_CLK_U=
NHALTED.CORE)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_bad_speculation_g=
roup",
         "MetricName": "tma_branch_mispredicts",
-        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BTCLEARS, which occurs when the Branch T=
arget Buffer (BTB) predicts a taken branch.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BTCLEARS, which occurs when the Branch T=
arget Buffer (BTB) predicts a taken branch",
         "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / (6 * CPU_CLK_UNHA=
LTED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
         "MetricName": "tma_branch_resteer",
-        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS).",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS)",
         "MetricExpr": "TOPDOWN_FE_BOUND.CISC / (6 * CPU_CLK_UNHALTED.CORE)=
",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are bounded by core restrictions and not attributed to an o=
utstanding load or stores, or resource limitation",
         "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / (6 * CPU_CLK_=
UNHALTED.CORE)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_backend_bound_gro=
up",
         "MetricName": "tma_core_bound",
-        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls",
         "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / (6 * CPU_CLK_UNHALTED.COR=
E)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
         "MetricName": "tma_decode",
-        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
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
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_machine_clears_gr=
oup",
         "MetricName": "tma_fast_nuke",
-        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls",
         "MetricExpr": "TOPDOWN_FE_BOUND.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
-        "MetricThreshold": "tma_frontend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses",
         "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / (6 * CPU_CLK_UNHALTED.COR=
E)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations",
         "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / (6 * CPU_CLK_=
UNHALTED.CORE)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_frontend_bound_gr=
oup",
         "MetricName": "tma_ifetch_bandwidth",
-        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations",
         "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / (6 * CPU_CLK_UN=
HALTED.CORE)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_frontend_bound_gr=
oup",
         "MetricName": "tma_ifetch_latency",
-        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -403,32 +417,6 @@
         "MetricGroup": "Flops",
         "MetricName": "tma_info_arith_inst_mix_ipfparith_scalar_sp"
     },
-    {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
-        "MetricExpr": "tma_info_bottleneck_dtlb_miss_bound_cycles",
-        "MetricName": "tma_info_bottleneck_%_dtlb_miss_bound_cycles"
-    },
-    {
-        "BriefDescription": "Percentage of time that allocation and retire=
ment is stalled by the Frontend Cluster due to an Ifetch Miss, either Icach=
e or ITLB Miss",
-        "MetricExpr": "tma_info_bottleneck_ifetch_miss_bound_cycles",
-        "MetricGroup": "Ifetch",
-        "MetricName": "tma_info_bottleneck_%_ifetch_miss_bound_cycles",
-        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound"
-    },
-    {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 due to an L1 miss",
-        "MetricExpr": "tma_info_bottleneck_load_miss_bound_cycles",
-        "MetricGroup": "Load_Store_Miss",
-        "MetricName": "tma_info_bottleneck_%_load_miss_bound_cycles",
-        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound"
-    },
-    {
-        "BriefDescription": "Percentage of time that retirement is stalled=
 by the Memory Cluster due to a pipeline stall",
-        "MetricExpr": "tma_info_bottleneck_mem_exec_bound_cycles",
-        "MetricGroup": "Mem_Exec",
-        "MetricName": "tma_info_bottleneck_%_mem_exec_bound_cycles",
-        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound"
-    },
     {
         "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
         "MetricExpr": "100 * (LD_HEAD.DTLB_MISS_AT_RET + LD_HEAD.PGWALK_AT=
_RET) / CPU_CLK_UNHALTED.CORE",
@@ -510,21 +498,6 @@
         "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
         "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_to_u=
nknown_branch_ratio"
     },
-    {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
-        "MetricExpr": "tma_info_buffer_stalls_load_buffer_stall_cycles",
-        "MetricName": "tma_info_buffer_stalls_%_load_buffer_stall_cycles"
-    },
-    {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to memory reservation stations full",
-        "MetricExpr": "tma_info_buffer_stalls_mem_rsv_stall_cycles",
-        "MetricName": "tma_info_buffer_stalls_%_mem_rsv_stall_cycles"
-    },
-    {
-        "BriefDescription": "Percentage of time that allocation is stalled=
 due to store buffer full",
-        "MetricExpr": "tma_info_buffer_stalls_store_buffer_stall_cycles",
-        "MetricName": "tma_info_buffer_stalls_%_store_buffer_stall_cycles"
-    },
     {
         "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
         "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.LD_BUF / CPU_CLK_UNHALTED=
.CORE",
@@ -546,7 +519,8 @@
     {
         "BriefDescription": "Cycles Per Instruction",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE / INST_RETIRED.ANY",
-        "MetricName": "tma_info_core_cpi"
+        "MetricName": "tma_info_core_cpi",
+        "ScaleUnit": "1per_instr"
     },
     {
         "BriefDescription": "Floating Point Operations Per Cycle",
@@ -564,21 +538,6 @@
         "MetricExpr": "TOPDOWN_RETIRING.ALL_P / INST_RETIRED.ANY",
         "MetricName": "tma_info_core_upi"
     },
-    {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
-        "MetricExpr": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l2h=
it",
-        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2hit"
-    },
-    {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
-        "MetricExpr": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l3h=
it",
-        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3hit"
-    },
-    {
-        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss subsequently misses in the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.LLC_MISS / MEM_BOUND_=
STALLS_IFETCH.ALL",
-        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3miss"
-    },
     {
         "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
         "MetricExpr": "100 * MEM_BOUND_STALLS_IFETCH.L2_HIT / MEM_BOUND_ST=
ALLS_IFETCH.ALL",
@@ -591,24 +550,6 @@
         "MetricName": "tma_info_ifetch_miss_bound_ifetchmissbound_with_l3h=
it",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
-        "MetricExpr": "tma_info_load_miss_bound_loadmissbound_with_l2hit",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2hit=
"
-    },
-    {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
-        "MetricExpr": "tma_info_load_miss_bound_loadmissbound_with_l3hit",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3hit=
"
-    },
-    {
-        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.LLC_MISS / MEM_BOUND_ST=
ALLS_LOAD.ALL",
-        "MetricGroup": "load_store_bound",
-        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3mis=
s"
-    },
     {
         "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
         "MetricExpr": "100 * MEM_BOUND_STALLS_LOAD.L2_HIT / MEM_BOUND_STAL=
LS_LOAD.ALL",
@@ -656,16 +597,6 @@
         "MetricExpr": "1e3 * MACHINE_CLEARS.SMC / INST_RETIRED.ANY",
         "MetricName": "tma_info_machine_clear_bound_machine_clears_smc_pki=
"
     },
-    {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
-        "MetricExpr": "tma_info_mem_exec_blocks_loads_with_adressaliasing"=
,
-        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_adressaliasin=
g"
-    },
-    {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "tma_info_mem_exec_blocks_loads_with_storefwdblk",
-        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_storefwdblk"
-    },
     {
         "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
         "MetricExpr": "100 * LD_BLOCKS.ADDRESS_ALIAS / MEM_UOPS_RETIRED.AL=
L_LOADS",
@@ -678,31 +609,6 @@
         "MetricName": "tma_info_mem_exec_blocks_loads_with_storefwdblk",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
-        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_l1miss",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_l1miss"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to o=
ther block cases, such as pipeline conflicts, fences, etc",
-        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_otherpipeline=
blks",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_otherpipeli=
neblks"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 pagewalk",
-        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_pagewalk",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_pagewalk"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 second level TLB miss",
-        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_stlbhit",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_stlbhit"
-    },
-    {
-        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 store forward address match",
-        "MetricExpr": "tma_info_mem_exec_bound_loadhead_with_storefwding",
-        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_storefwding=
"
-    },
     {
         "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
         "MetricExpr": "100 * LD_HEAD.L1_MISS_AT_RET / LD_HEAD.ANY_AT_RET",
@@ -758,11 +664,6 @@
         "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / TOPDOWN_RETIRING=
.ALL_P",
         "MetricName": "tma_info_mem_mix_memload_ratio"
     },
-    {
-        "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
-        "MetricExpr": "tma_info_serialization_tpause_cycles",
-        "MetricName": "tma_info_serialization _%_tpause_cycles"
-    },
     {
         "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
         "MetricExpr": "100 * SERIALIZATION.C01_MS_SCB / (6 * CPU_CLK_UNHAL=
TED.CORE)",
@@ -783,14 +684,17 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE_P@k / CPU_CLK_UNHALTED.CO=
RE",
-        "MetricGroup": "Summary",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P:k / CPU_CLK_UNHALTED.CORE",
         "MetricName": "tma_info_system_kernel_utilization"
     },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P / CPU_CLK_UNHALTED.CORE",
+        "MetricName": "tma_info_system_mux"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": "Power",
         "MetricName": "tma_info_system_turbo_utilization"
     },
     {
@@ -814,102 +718,90 @@
         "MetricName": "tma_info_uop_mix_x87_uop_ratio"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses",
         "MetricExpr": "TOPDOWN_FE_BOUND.ITLB_MISS / (6 * CPU_CLK_UNHALTED.=
CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_latency_gr=
oup",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
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
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_bad_speculation_g=
roup",
         "MetricName": "tma_machine_clears",
-        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
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
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
         "MetricName": "tma_mem_scheduler",
-        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
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
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
         "MetricName": "tma_non_mem_scheduler",
-        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that requires the use of m=
icrocode (slow nuke)",
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / (6 * CPU_CLK_UNHALTE=
D.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_machine_clears_gr=
oup",
         "MetricName": "tma_nuke",
-        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized",
         "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
         "MetricName": "tma_other_fb",
-        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes.",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes",
         "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / (6 * CPU_CLK_UNHALTED.=
CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_ifetch_bandwidth_=
group",
         "MetricName": "tma_predecode",
-        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the physical register file unable to accep=
t an entry (marble stalls)",
         "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / (6 * CPU_CLK_UNHALTED.C=
ORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
         "MetricName": "tma_register",
-        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the reorder buffer being full (ROB stalls)=
",
         "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / (6 * CPU_CLK_UNHA=
LTED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
         "MetricName": "tma_reorder_buffer",
-        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a resource limitation",
         "MetricExpr": "tma_backend_bound - tma_core_bound",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricGroup": "Slots;TopdownL2;tma_L2_group;tma_backend_bound_gro=
up",
         "MetricName": "tma_resource_bound",
-        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that result =
in retirement slots",
         "MetricExpr": "TOPDOWN_RETIRING.ALL_P / (6 * CPU_CLK_UNHALTED.CORE=
)",
-        "MetricGroup": "TopdownL1;tma_L1_group",
+        "MetricGroup": "Slots;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
-        "MetricThreshold": "tma_retiring > 0.75",
         "MetricgroupNoGroup": "TopdownL1",
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to scoreboards from the instruction queue (IQ=
), jump execution unit (JEU), or microcode sequencer (MS)",
         "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / (6 * CPU_CLK_UNHAL=
TED.CORE)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_resource_bound_gr=
oup",
         "MetricName": "tma_serialization",
-        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json =
b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
index f37107373e3b..a779a1a73ea5 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cache.json
@@ -9,6 +9,16 @@
         "PublicDescription": "UNC_CHACMS_CLOCKTICKS",
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
@@ -843,6 +853,26 @@
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
@@ -1066,7 +1096,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Code read from local IA that miss the cache",
+        "BriefDescription": "Code read from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_CRD",
@@ -1086,7 +1116,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read opt from local IA that miss the cac=
he",
+        "BriefDescription": "Data read opt from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT",
@@ -1096,7 +1126,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Data read opt prefetch from local IA that mis=
s the cache",
+        "BriefDescription": "Data read opt prefetch from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_DRD_OPT_PREF",
@@ -1266,7 +1296,7 @@
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
@@ -1400,7 +1430,7 @@
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
@@ -1410,7 +1440,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_PREF_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRd_Opt_Prefs issued by iA Cor=
es that missed the LLC",
+        "PublicDescription": "TOR Inserts : Data read opt prefetch from lo=
cal iA that missed the LLC targeting remote memory",
         "UMask": "0xc8a77e01",
         "Unit": "CHA"
     },
@@ -1420,7 +1450,7 @@
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_DRD_OPT_REMOTE",
         "PerPkg": "1",
-        "PublicDescription": "TOR Inserts : DRd_Opt issued by iA Cores tha=
t missed the LLC",
+        "PublicDescription": "TOR Inserts : Data read opt from local iA th=
at missed the LLC targeting remote memory",
         "UMask": "0xc8277e01",
         "Unit": "CHA"
     },
@@ -1595,7 +1625,7 @@
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
@@ -1624,7 +1654,7 @@
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
@@ -1634,7 +1664,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the LLC targeting remote memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_PREF_REMOTE",
@@ -1644,7 +1674,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "BriefDescription": "Read for ownership from local IA that miss th=
e LLC targeting remote memory",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_MISS_RFO_REMOTE",
@@ -1736,7 +1766,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership from local IA that miss th=
e cache",
+        "BriefDescription": "Read for ownership from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO",
@@ -1746,7 +1776,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "Read for ownership prefetch from local IA tha=
t miss the cache",
+        "BriefDescription": "Read for ownership prefetch from local IA",
         "Counter": "0,1,2,3",
         "EventCode": "0x35",
         "EventName": "UNC_CHA_TOR_INSERTS.IA_RFO_PREF",
@@ -2380,7 +2410,6 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_DRD_OPT",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores"=
,
         "UMask": "0xc827ff01",
@@ -2442,7 +2471,6 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opts issued by iA Cores =
that hit the LLC",
         "UMask": "0xc827fd01",
@@ -2453,7 +2481,6 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_HIT_DRD_OPT_PREF",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores that hit the LLC",
         "UMask": "0xc8a7fd01",
@@ -2663,7 +2690,6 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opt issued by iA Cores t=
hat missed the LLC",
         "UMask": "0xc827fe01",
@@ -2674,7 +2700,6 @@
         "Counter": "0",
         "EventCode": "0x36",
         "EventName": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_OPT_PREF",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "TOR Occupancy : DRd_Opt_Prefs issued by iA C=
ores that missed the LLC",
         "UMask": "0xc8a7fe01",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.json b/=
tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.json
index 383a5ba5a697..43e094c233cc 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-cxl.json
@@ -13,7 +13,6 @@
         "Counter": "4,5,6,7",
         "EventCode": "0x41",
         "EventName": "UNC_CXLCM_RxC_PACK_BUF_INSERTS.MEM_DATA",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x10",
         "Unit": "CXLCM"
@@ -23,7 +22,6 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x02",
         "EventName": "UNC_CXLDP_TxC_AGF_INSERTS.M2S_DATA",
-        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x20",
         "Unit": "CXLDP"
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnec=
t.json b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.js=
on
index 80440edac431..2ccbc8bca24e 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-interconnect.json
@@ -814,6 +814,26 @@
         "PerPkg": "1",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Rejects",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.FAST_REJ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x2",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Counts Timeouts - Set 0 : Fastpath Requests",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x1E",
+        "EventName": "UNC_I_MISC0.FAST_REQ",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x1",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Misc Events - Set 1 : Lost Forward : Snoop pu=
lled away ownership before a write was committed",
         "Counter": "0,1,2,3",
@@ -824,6 +844,46 @@
         "UMask": "0x10",
         "Unit": "IRP"
     },
+    {
+        "BriefDescription": "Snoop Hit E/S responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_ES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x74",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Hit I responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_I",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x72",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop Hit M responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_HIT_M",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x78",
+        "Unit": "IRP"
+    },
+    {
+        "BriefDescription": "Snoop miss responses",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x12",
+        "EventName": "UNC_I_SNOOP_RESP.ALL_MISS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "UMask": "0x71",
+        "Unit": "IRP"
+    },
     {
         "BriefDescription": "Inbound write (fast path) requests to coheren=
t memory, received by the IRP resulting in write ownership requests issued =
by IRP to the mesh.",
         "Counter": "0,1,2,3",
@@ -1196,6 +1256,33 @@
         "UMask": "0x4",
         "Unit": "UPI"
     },
+    {
+        "BriefDescription": "Cycles in L0p",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x27",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_POWER_CYCLES_LL_ENTER",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x28",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES_LL_ENTER",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
+    {
+        "BriefDescription": "UNC_UPI_TxL0P_POWER_CYCLES_M3_EXIT",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x29",
+        "EventName": "UNC_UPI_TxL0P_POWER_CYCLES_M3_EXIT",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "Unit": "UPI"
+    },
     {
         "BriefDescription": "Matches on Transmit path of a UPI Port : Non-=
Coherent Bypass",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json b/t=
ools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
index cffb9d94b53d..886b99a971be 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-io.json
@@ -17,7 +17,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -29,7 +29,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -41,7 +41,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -53,7 +53,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -65,7 +65,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -77,7 +77,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -89,7 +89,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -101,7 +101,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -113,7 +113,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -125,7 +125,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff0ff",
+        "UMask": "0xff",
         "Unit": "IIO"
     },
     {
@@ -137,7 +137,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -149,7 +149,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -161,7 +161,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -173,7 +173,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -185,7 +185,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010010",
+        "UMask": "0x10",
         "Unit": "IIO"
     },
     {
@@ -197,7 +197,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020020",
+        "UMask": "0x20",
         "Unit": "IIO"
     },
     {
@@ -209,7 +209,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040040",
+        "UMask": "0x40",
         "Unit": "IIO"
     },
     {
@@ -221,7 +221,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080080",
+        "UMask": "0x80",
         "Unit": "IIO"
     },
     {
@@ -233,7 +233,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -245,7 +245,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -257,7 +257,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -269,7 +269,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -281,7 +281,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -293,7 +293,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -305,7 +305,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -317,7 +317,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -329,7 +329,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -341,7 +341,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -352,7 +352,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -363,7 +363,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -374,7 +374,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -385,7 +385,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -396,7 +396,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -407,7 +407,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -418,7 +418,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -429,7 +429,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -440,7 +440,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -451,7 +451,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -462,7 +462,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -473,7 +473,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -484,7 +484,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x02",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -495,7 +495,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x04",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -506,7 +506,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x08",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -517,7 +517,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x10",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -528,7 +528,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x20",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -539,7 +539,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x40",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -550,7 +550,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x80",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -561,7 +561,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -572,7 +572,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -583,7 +583,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x02",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -594,7 +594,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x04",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -605,7 +605,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x08",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -616,7 +616,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x10",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -627,7 +627,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x20",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -638,7 +638,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x40",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -649,7 +649,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x80",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -661,7 +661,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -673,7 +673,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -685,7 +685,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -697,7 +697,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -709,7 +709,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -721,7 +721,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -733,7 +733,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -745,7 +745,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -757,7 +757,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -769,7 +769,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -781,7 +781,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -793,7 +793,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -805,7 +805,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -817,7 +817,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -829,7 +829,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -841,7 +841,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -853,7 +853,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1129,7 +1129,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1141,7 +1141,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f020",
+        "UMask": "0x20",
         "Unit": "IIO"
     },
     {
@@ -1153,7 +1153,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1165,7 +1165,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1177,7 +1177,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1189,7 +1189,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1201,7 +1201,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x700f010",
+        "UMask": "0x10",
         "Unit": "IIO"
     },
     {
@@ -1213,7 +1213,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff080",
+        "UMask": "0x80",
         "Unit": "IIO"
     },
     {
@@ -1225,7 +1225,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff040",
+        "UMask": "0x40",
         "Unit": "IIO"
     },
     {
@@ -1237,7 +1237,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff020",
+        "UMask": "0x20",
         "Unit": "IIO"
     },
     {
@@ -1249,7 +1249,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1261,7 +1261,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1273,7 +1273,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1285,7 +1285,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff010",
+        "UMask": "0x10",
         "Unit": "IIO"
     },
     {
@@ -1297,7 +1297,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1318,7 +1318,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1329,7 +1329,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1340,7 +1340,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1351,7 +1351,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1362,7 +1362,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1373,7 +1373,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1384,7 +1384,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1395,7 +1395,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1406,7 +1406,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1417,7 +1417,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1428,7 +1428,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1439,7 +1439,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1450,7 +1450,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1461,7 +1461,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1472,7 +1472,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1483,7 +1483,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1494,7 +1494,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1505,7 +1505,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1516,7 +1516,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1527,7 +1527,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x0FF",
-        "UMask": "0x70ff002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1538,7 +1538,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1549,7 +1549,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1560,7 +1560,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1571,7 +1571,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1582,7 +1582,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1593,7 +1593,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1604,7 +1604,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1615,7 +1615,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080004",
+        "UMask": "0x4",
         "Unit": "IIO"
     },
     {
@@ -1626,7 +1626,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1637,7 +1637,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1648,7 +1648,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1659,7 +1659,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1670,7 +1670,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1681,7 +1681,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1692,7 +1692,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1703,7 +1703,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080001",
+        "UMask": "0x1",
         "Unit": "IIO"
     },
     {
@@ -1715,7 +1715,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1727,7 +1727,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1739,7 +1739,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1751,7 +1751,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1763,7 +1763,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1775,7 +1775,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1787,7 +1787,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1799,7 +1799,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080008",
+        "UMask": "0x8",
         "Unit": "IIO"
     },
     {
@@ -1811,7 +1811,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x001",
-        "UMask": "0x7001002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1823,7 +1823,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x002",
-        "UMask": "0x7002002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1835,7 +1835,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x004",
-        "UMask": "0x7004002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1847,7 +1847,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x008",
-        "UMask": "0x7008002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1859,7 +1859,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x010",
-        "UMask": "0x7010002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1871,7 +1871,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x020",
-        "UMask": "0x7020002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1883,7 +1883,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x040",
-        "UMask": "0x7040002",
+        "UMask": "0x2",
         "Unit": "IIO"
     },
     {
@@ -1895,7 +1895,7 @@
         "FCMask": "0x07",
         "PerPkg": "1",
         "PortMask": "0x080",
-        "UMask": "0x7080002",
+        "UMask": "0x2",
         "Unit": "IIO"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json=
 b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
index 7e6e6764f181..ae9c62b32e92 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-memory.json
@@ -169,7 +169,7 @@
         "Unit": "IMC"
     },
     {
-        "BriefDescription": "Number of DRAM DCLK clock cycles while the ev=
ent is enabled",
+        "BriefDescription": "Number of DRAM DCLK clock cycles while the ev=
ent is enabled.  DCLK is 1/4 of DRAM data rate.",
         "Counter": "0,1,2,3",
         "EventCode": "0x01",
         "EventName": "UNC_M_CLOCKTICKS",
@@ -188,6 +188,104 @@
         "PublicDescription": "DRAM Clockticks",
         "Unit": "IMC"
     },
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
     {
         "BriefDescription": "DRAM Precharge commands. : Counts the number =
of DRAM Precharge commands sent on this channel.",
         "Counter": "0,1,2,3",
@@ -360,6 +458,28 @@
         "PerPkg": "1",
         "Unit": "IMC"
     },
+    {
+        "BriefDescription": "subevent0 - # of cycles all ranks were in SR =
subevent1 - # of times all ranks went into SR subevent2 -# of times  ps_sr_=
active asserted (SRE) subevent3 - # of times ps_sr_active deasserted (SRX) =
subevent4 - # of times PS-&>Refresh ps_sr_req asserted (SRE) subevent5 - # =
of times PS-&>Refresh ps_sr_req deasserted (SRX) subevent6 - # of cycles PS=
Ctrlr FSM was in FATAL",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_M_SELF_REFRESH.ENTER_SUCCESS",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "UNC_M_SELF_REFRESH.ENTER_SUCCESS",
+        "UMask": "0x2",
+        "Unit": "IMC"
+    },
+    {
+        "BriefDescription": "# of cycles all ranks were in SR",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x43",
+        "EventName": "UNC_M_SELF_REFRESH.ENTER_SUCCESS_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "-",
+        "UMask": "0x1",
+        "Unit": "IMC"
+    },
     {
         "BriefDescription": "Write Pending Queue Allocations",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-power.json
index 02e59f64a544..9ea852ef190e 100644
--- a/tools/perf/pmu-events/arch/x86/sierraforest/uncore-power.json
+++ b/tools/perf/pmu-events/arch/x86/sierraforest/uncore-power.json
@@ -7,5 +7,103 @@
         "PerPkg": "1",
         "PublicDescription": "PCU Clockticks:  The PCU runs off a fixed 1 =
GHz clock.  This event counts the number of pclk cycles measured while the =
counter was enabled.  The pclk, like the Memory Controller's dclk, counts a=
t a constant rate making it a good measure of actual wall time.",
         "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Thermal Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x04",
+        "EventName": "UNC_P_FREQ_MAX_LIMIT_THERMAL_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Thermal Strongest Upper Limit Cycles : Numbe=
r of cycles any frequency is reduced due to a thermal limit.  Count only if=
 throttling is occurring.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Power Strongest Upper Limit Cycles",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x05",
+        "EventName": "UNC_P_FREQ_MAX_POWER_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Power Strongest Upper Limit Cycles : Counts =
the number of cycles when power is the upper limit on frequency.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Cycles spent changing Frequency",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x74",
+        "EventName": "UNC_P_FREQ_TRANS_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Cycles spent changing Frequency : Counts the=
 number of cycles when the system is changing frequency.  This can not be f=
iltered by thread ID.  One can also use it with the occupancy counter that =
monitors number of threads in C0 to estimate the performance impact that fr=
equency transitions had on the system.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C2E",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2b",
+        "EventName": "UNC_P_PKG_RESIDENCY_C2E_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Package C State Residency - C2E : Counts the=
 number of cycles when the package was in C2E.  This event can be used in c=
onjunction with edge detect to count C2E entrances (or exits using invert).=
  Residency events do not include transition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Package C State Residency - C6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x2d",
+        "EventName": "UNC_P_PKG_RESIDENCY_C6_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Package C State Residency - C6 : Counts the =
number of cycles when the package was in C6.  This event can be used in con=
junction with edge detect to count C6 entrances (or exits using invert).  R=
esidency events do not include transition times.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C0",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C0",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C0 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C3",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x36",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C3",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C3 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Number of cores in C6",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x37",
+        "EventName": "UNC_P_POWER_STATE_OCCUPANCY_CORES_C6",
+        "PerPkg": "1",
+        "PublicDescription": "Number of cores in C6 : This is an occupancy=
 event that tracks the number of cores that are in the chosen C-State.  It =
can be used by itself to get the average number of cores in that C-state wi=
th thresholding to generate histograms, or with other PCU events and occupa=
ncy triggering to capture other details.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "External Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x0a",
+        "EventName": "UNC_P_PROCHOT_EXTERNAL_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "External Prochot : Counts the number of cycl=
es that we are in external PROCHOT mode.  This mode is triggered when a sen=
sor off the die determines that something off-die (like DRAM) is too hot an=
d must throttle to avoid damaging the chip.",
+        "Unit": "PCU"
+    },
+    {
+        "BriefDescription": "Internal Prochot",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x09",
+        "EventName": "UNC_P_PROCHOT_INTERNAL_CYCLES",
+        "Experimental": "1",
+        "PerPkg": "1",
+        "PublicDescription": "Internal Prochot : Counts the number of cycl=
es that we are in Internal PROCHOT mode.  This mode is triggered when a sen=
sor on the die determines that we are too hot and must throttle to avoid da=
maging the chip.",
+        "Unit": "PCU"
     }
 ]
--=20
2.48.1.502.g6dc24dfdaf-goog

