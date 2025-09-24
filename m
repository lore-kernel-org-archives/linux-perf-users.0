Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46B257844
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 06:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693775; cv=none; b=X8xJ+nsHQ9r+G11oISoGDM7WjlHGAzWUHccDj1y6eSxZdhXagx/OYsNp5thpyemoDu8Hs2WH5uWxbULIOlCanBI2kEdVIXuCKyOYv6Fn7SAwSpeKG01tO0OSRBCOBLjup0NF//VFCaJoy1Np/AZoRQUS4kfj/YXD5We7ajiufoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693775; c=relaxed/simple;
	bh=0dsBx0rLjrgD8j+AYwUwXM1mEl4AQNdxzf2cmwE5dJY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=i2Y1vA6YOlwWhZ9ml4IadwzjeycD2MQhBNWcnuc85t08oOYKldnL3MkfuG/VOJdZx0xu28/1FTefJR3F/+1fer2ZCea6lEECyZrVq2OYhdSg60laH/S0W0M8sajKh/y80+BCDopK8ekGN1pJ79PtJ9PwlBGtJRzUHtr+f+jKLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=alRV/1wj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="alRV/1wj"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3305c08d975so6482818a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 23:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758693773; x=1759298573; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZfrp4IQqotV5P6YLzd+6ne+HT25QFJ6TQ9kD8oQXYg=;
        b=alRV/1wj83L3yQ1EED7zysRFk5i+eiQZBO3xbB1Dq6szrT5gL5xcx9FcMhR0BaGltm
         mAY4eSf7tWp/LcYem90uaDyYj/H05P8+YDKXgdDPoWSa9EVlotl/VT10y5ZmdoFXd9Gr
         JRCiZCp1Nde5zpw8a7BMf0cvE2QyV5UCRWTU+oHV6hQ+sEdiSVsghbtvOXVOpsCfvppi
         jbvQEQiGzFbbwtZGrF/m/ga5LfWmmfgxMn8JJ7f2iEma9qKAAHveSyZ/eO4wu8zxcPeR
         XgOG7JK8WSMzd8YbMl4D1ZJPo2S8ZftyDB0qaRTgyy7UStMq/FGlhk71bErY2HFbwSFw
         Owxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758693773; x=1759298573;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CZfrp4IQqotV5P6YLzd+6ne+HT25QFJ6TQ9kD8oQXYg=;
        b=Ds9zAtZhc1QzxjxTILmJrGHXv9K5Hq/43d+CzvNNAdJ9eiQVgyZ93GGM7Idy2p4S5I
         8dvCIOpKITqa9KLNOv16pBZVHq+RpRKzeCIH4fXzJ09FnQS48/rbbCg1SHs8H8iAHUSf
         a6+nP1dSS3CjK08LWADiY89+cDSNCRoUKZVidlGI24/e+R7YD+8aSRuID4rw0+KmeoXW
         8fTleqFZM/cwDW11FLU0rJ16RJk/uGAMeyHr/l1mt7XASkQRHBXKSAZzbydth6qgfY0G
         CXjyllTGsSJaLlmDstHemdVmcX0DVdlhJzq2ryHky/D+98oZ7MPo1q7pPpalJ1Y2Mpth
         SsGA==
X-Forwarded-Encrypted: i=1; AJvYcCVwvy+hzNNyNsSW2IYzemja36E46xF0HbxsY8JWKem99DNEZe1MyA1CwHiv+vaXcnfYcbKnvoEWADaeWuU8gm1v@vger.kernel.org
X-Gm-Message-State: AOJu0YzXb5T14BOOHTCWqGkB+4G9Udhdj8+CSy2HEOj4bwIwOjSum33H
	/zCX2awlchF6WzX2Gpd3uImbIg8AqXueYQy3RfRGTQwm6XyRyaFG0Bkfxg7GCjcwDZ3nXJnM7Wx
	KrEygtPb33Q==
X-Google-Smtp-Source: AGHT+IGRLvfd9dN2JG/vqA/PzlttiuLrxa5hAXHXoFmGnIf3YTLqYU4zt/07V5MQQtWP9/iZIX53Y2zuIRFH
X-Received: from pjnu17.prod.google.com ([2002:a17:90a:8911:b0:32f:d1f3:646f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d4e:b0:32b:dfdb:b27f
 with SMTP id 98e67ed59e1d1-332a9597db9mr6621603a91.17.1758693773265; Tue, 23
 Sep 2025 23:02:53 -0700 (PDT)
Date: Tue, 23 Sep 2025 23:02:25 -0700
In-Reply-To: <20250924060229.375718-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924060229.375718-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250924060229.375718-7-irogers@google.com>
Subject: [PATCH v1 06/10] perf vendor events intel: Update lunarlake events to v1.18
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

Update lunarlake events to v1.18 released in:
https://github.com/intel/perfmon/commit/04e11e566618d781b854f526d7e394ed504=
20638

Event json automatically generated by:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../pmu-events/arch/x86/lunarlake/cache.json  | 46 +++++++++++++++++--
 .../pmu-events/arch/x86/lunarlake/memory.json |  6 +--
 .../pmu-events/arch/x86/lunarlake/other.json  |  2 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 4 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/cache.json
index 29bcb847178f..402ca8fc50b6 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
@@ -1305,6 +1305,18 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts writebacks of modified cachelines that=
 were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_M.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E00008",
+        "PublicDescription": "Counts writebacks of modified cachelines tha=
t were supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts writebacks of non-modified cachelines =
that have any type of response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1317,6 +1329,18 @@
         "UMask": "0x1",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts writebacks of non-modified cachelines =
that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.COREWB_NONM.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E01000",
+        "PublicDescription": "Counts writebacks of non-modified cachelines=
 that were supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
         "Counter": "0,1,2,3,4,5,6,7",
@@ -1355,7 +1379,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1367,7 +1391,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop hit in another cores caches, data forwarding i=
s required as the data is modified.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1379,7 +1403,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop hit in another cores caches which forwarded th=
e unmodified data to the requesting core.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1415,7 +1439,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1427,7 +1451,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were su=
pplied by the L3 cache where a snoop hit in another cores caches, data forw=
arding is required as the data is modified.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -1437,6 +1461,18 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts all data read, code read, RFO and ITOM=
 requests including demands and prefetches to the core caches (L1 or L2) th=
at were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
+        "EventCode": "0x2A,0x2B",
+        "EventName": "OCR.READS_TO_CORE.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x7E001E04477",
+        "PublicDescription": "Counts all data read, code read, RFO and ITO=
M requests including demands and prefetches to the core caches (L1 or L2) t=
hat were supplied by the L3 cache. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Any memory transaction that reached the SQ.",
         "Counter": "0,1,2,3,4,5,6,7,8,9",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/lunarlake/memory.json
index 25021cb76f61..caa387e10259 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/memory.json
@@ -352,7 +352,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -376,7 +376,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache and were supplied by the system memory (DRAM, MSC, or MM=
IO).",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -412,7 +412,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache and were supplied by the system memory (DRAM, MS=
C, or MMIO).",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/lunarlake/other.json
index 59949f9541d8..1df716442549 100644
--- a/tools/perf/pmu-events/arch/x86/lunarlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/lunarlake/other.json
@@ -151,7 +151,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
-        "Counter": "0,1,2,3",
+        "Counter": "0,1,2,3,4,5,6,7,8,9",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 6c0a6c3d2451..aa0e2b0c4ba4 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -22,7 +22,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
 GenuineIntel-6-3E,v24,ivytown,core
 GenuineIntel-6-2D,v24,jaketown,core
 GenuineIntel-6-(57|85),v16,knightslanding,core
-GenuineIntel-6-BD,v1.17,lunarlake,core
+GenuineIntel-6-BD,v1.18,lunarlake,core
 GenuineIntel-6-(AA|AC|B5),v1.16,meteorlake,core
 GenuineIntel-6-1[AEF],v4,nehalemep,core
 GenuineIntel-6-2E,v4,nehalemex,core
--=20
2.51.0.534.gc79095c0ca-goog

