Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2714D283
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Jun 2025 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686565; cv=none; b=s2T8ABEesE/uPjWv1L3aJwZnqfMULI1TvJZHvWyJc0a0wyazwsV4sjifAOFFbpMgztDOiAaQ3RSRzusqWajTE3m3cudXSGfmZZJDJIfwBOMWO5bWV0Dvm38lHQIvPexIkkLQL7cNo6A+qBs4J7X48/csU2J8U+iMMSklyk9Ysbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686565; c=relaxed/simple;
	bh=UiCwEQGp7+rB5RK9lBKZeWc45l3xje1iR/QffXJdQFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=i13utSVxz2w1oV+uLTJTrDuK6q7CDq7FONRjDwj/YXZkVvIuVg8ZSTyjfGIxXrOI/+jXqjHo9UMfzBA9OL+PR9AJS4/TgxkRT/amVaer2m1OUaaxEB4ekYXpyv9MEiQC2IrGsUKH34JnqUnHvNijUJdTxVJQDoE9QsPggc+NVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZvIt/YKh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvIt/YKh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138c50d2a0so485976a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 17:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749686562; x=1750291362; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D43XWYX3jacisQ6mmAebjsqq3iGJmoiD3TPO2d07rac=;
        b=ZvIt/YKhxv+CqTL1i+potDymFKRv2IJ8Ffx6DjNVdYHRBef2f+F2nWE4DTFcOuNYZ9
         F+sMM9ToFhuelI5BrybBt9C7T7sgy4HUOcXhc7WneYM/HH7oBbB3H+g5YEIWaX14nH43
         khVMgyzWjg5hkcpaq0n5YBgzltsxU2+Wfr1u2WO9lbbNfqa2ShnfMXVeTzuiP1jv0Rbh
         jlkY9mLO8fVkdSHBJzwNJOmPfg/gchZawnrTnkjoq189QNyol5+7fNswT9H3WoCPPopP
         sLOraRcbA/LzePNhQxjVqlzp2ETX80mXT+Y2eyJegRd7toBpC/J1nAl3sZqVisnOMcUy
         bVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686562; x=1750291362;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D43XWYX3jacisQ6mmAebjsqq3iGJmoiD3TPO2d07rac=;
        b=EF0XLC9s9lXXSQIJnDlfl+zKy4sqWQgwvESLnBLM7l7xBpSWElRrtntxR+STB1215d
         I9Veuu+nFJSOJQ/5TLtHCcAIht8i3TJbqKBLMxF15qmjc2c9K/Zu3XJ8ICfXLTmxMEl3
         6vAPrbl7LM/mxHlD70/aKaE/Qc4X6s1T1bV4HirYSqywQjoWQTQtSV9mnPDsyKUmebZD
         ZiGSPABiN4KpGR6twE2qvJJdCi8NQvN2Rp0BWmogxfocwvI9ojl0trcLUpTBghVSXJDQ
         IJPeWN9MMiMH0JgjkEymeio2puZzJwkn3ggsS53m1/zHlkbO3px7sGc0k6RSfz0CTxxU
         N/dg==
X-Forwarded-Encrypted: i=1; AJvYcCWAWjlM+tqzwm87CSIITIQ2qbopsn93wQmOQDIjBMeFMP22LbgRcoXOEx3EQ+t6dE+S4ZHsQrE4HXlbcfEQTjK+@vger.kernel.org
X-Gm-Message-State: AOJu0YxYg/Q9aqOj3OQatK2wukvEa16GkAk6MYye7ueIQ+xgF1a/H94d
	Okf9WynwuAoBC40kCc7068JVvOG/UxIEziZXz1+6OPl5LQCc0gv7cpKz5E21G/lK94CMG/2Dja9
	0O83kNpzl+Q==
X-Google-Smtp-Source: AGHT+IHsZzIAhQvfV3eP2v2YfpXD8r7KweAJW0WkMlGgrgPORX0imCwQua0i4V7e3Nr1HAIppkqg+ETmjXYX
X-Received: from pjur7.prod.google.com ([2002:a17:90a:d407:b0:311:ea2a:3919])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e88:b0:312:f54e:ba28
 with SMTP id 98e67ed59e1d1-313af2083f4mr8223478a91.24.1749686562593; Wed, 11
 Jun 2025 17:02:42 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:02:16 -0700
In-Reply-To: <20250612000224.780337-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612000224.780337-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250612000224.780337-8-irogers@google.com>
Subject: [PATCH v1 07/15] perf vendor events: Update GraniteRapids events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <mani@kernel.org>, 
	Caleb Biggers <caleb.biggers@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.08 to v1.10.

Bring in the event updates v1.10
https://github.com/intel/perfmon/commit/96259a932e2ce5f70ed7d347ca92fdeb78f=
83aa5
https://github.com/intel/perfmon/commit/19e315c8d2e0b44e170a6e60de44c935906=
2a6aa

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/graniterapids/cache.json         |  9 +++++
 .../arch/x86/graniterapids/counter.json       | 10 +++---
 .../arch/x86/graniterapids/gnr-metrics.json   | 36 +++++++++++++++++++
 .../arch/x86/graniterapids/pipeline.json      |  2 +-
 .../graniterapids/uncore-interconnect.json    | 19 ----------
 .../arch/x86/graniterapids/uncore-io.json     | 27 +++++++++++++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 7 files changed, 78 insertions(+), 27 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json b/tool=
s/perf/pmu-events/arch/x86/graniterapids/cache.json
index 32f99a8a3871..dbdeade6fe6f 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/cache.json
@@ -977,6 +977,15 @@
         "SampleAfterValue": "100003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Offcore Uncacheable memory data read transact=
ions.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.MEM_UC",
+        "PublicDescription": "This event counts noncacheable memory data r=
ead transactions. Available PDIST counters: 0",
+        "SampleAfterValue": "100003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Cycles when offcore outstanding cacheable Cor=
e Data Read transactions are present in SuperQueue (SQ), queue to uncore.",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/counter.json b/to=
ols/perf/pmu-events/arch/x86/graniterapids/counter.json
index 5d3b202eadd3..d97211a0227e 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/counter.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/counter.json
@@ -59,6 +59,11 @@
         "CountersNumFixed": "0",
         "CountersNumGeneric": 4
     },
+    {
+        "Unit": "UBOX",
+        "CountersNumFixed": "0",
+        "CountersNumGeneric": "2"
+    },
     {
         "Unit": "PCU",
         "CountersNumFixed": "0",
@@ -73,10 +78,5 @@
         "Unit": "MDF",
         "CountersNumFixed": "0",
         "CountersNumGeneric": "4"
-    },
-    {
-        "Unit": "UBOX",
-        "CountersNumFixed": "0",
-        "CountersNumGeneric": "2"
     }
 ]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json =
b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
index af527f7f9d0c..9a620e1b8de8 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
@@ -95,6 +95,12 @@
         "MetricName": "io_bandwidth_read",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "Bandwidth of inbound IO reads that are initia=
ted by end device controllers that are requesting memory from the CPU and m=
iss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR * 64 / 1e6 / d=
uration_time",
+        "MetricName": "io_bandwidth_read_l3_miss",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Bandwidth of IO reads that are initiated by e=
nd device controllers that are requesting memory from the local CPU socket"=
,
         "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR_LOCAL * 64 / 1e6 / =
duration_time",
@@ -113,6 +119,12 @@
         "MetricName": "io_bandwidth_write",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "Bandwidth of inbound IO writes that are initi=
ated by end device controllers that are writing memory to the CPU",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_MISS_ITOM + UNC_CHA_TOR_INS=
ERTS.IO_MISS_ITOMCACHENEAR) * 64 / 1e6 / duration_time",
+        "MetricName": "io_bandwidth_write_l3_miss",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Bandwidth of IO writes that are initiated by =
end device controllers that are writing memory to the local CPU socket",
         "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_ITOM_LOCAL + UNC_CHA_TOR_IN=
SERTS.IO_ITOMCACHENEAR_LOCAL) * 64 / 1e6 / duration_time",
@@ -125,6 +137,30 @@
         "MetricName": "io_bandwidth_write_remote",
         "ScaleUnit": "1MB/s"
     },
+    {
+        "BriefDescription": "The percent of inbound full cache line writes=
 initiated by IO that miss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_ITOM / UNC_CHA_TOR_INSE=
RTS.IO_ITOM",
+        "MetricName": "io_full_write_l3_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "Message Signaled Interrupts (MSI) per second =
sent by the integrated I/O traffic controller (IIO) to System Configuration=
 Controller (Ubox)",
+        "MetricExpr": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED / duratio=
n_time",
+        "MetricName": "io_msi",
+        "ScaleUnit": "1per_sec"
+    },
+    {
+        "BriefDescription": "The percent of inbound partial writes initiat=
ed by IO that miss the L3 cache",
+        "MetricExpr": "(UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR + UNC_CH=
A_TOR_INSERTS.IO_MISS_RFO) / (UNC_CHA_TOR_INSERTS.IO_ITOMCACHENEAR + UNC_CH=
A_TOR_INSERTS.IO_RFO)",
+        "MetricName": "io_partial_write_l3_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+        "BriefDescription": "The percent of inbound reads initiated by IO =
that miss the L3 cache",
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_MISS_PCIRDCUR / UNC_CHA_TOR_=
INSERTS.IO_PCIRDCUR",
+        "MetricName": "io_read_l3_miss",
+        "ScaleUnit": "100%"
+    },
     {
         "BriefDescription": "Ratio of number of completed page walks (for =
all page sizes) caused by a code fetch to the total number of completed ins=
tructions",
         "MetricExpr": "ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.ANY",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
index 1edfdad1600d..27af3bd6bacf 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
@@ -738,7 +738,7 @@
         "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
-        "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions. Available PDIST counters: 0",
+        "PublicDescription": "Counts all software-prefetch load dispatches=
 that hit the fill buffer (FB) allocated for the software prefetch. It can =
also be incremented by some lock instructions. So it should only be used wi=
th profiling so that the locks can be excluded by ASM (Assembly File) inspe=
ction of the nearby instructions. Available PDIST counters: 0",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.=
json
index e5bd11b27bcd..6667fbc50452 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
@@ -1915,24 +1915,6 @@
         "UMask": "0x4",
         "Unit": "UPI"
     },
-    {
-        "BriefDescription": "Tx Flit Buffer Allocations : Number of alloca=
tions into the UPI Tx Flit Buffer.  Generally, when data is transmitted acr=
oss UPI, it will bypass the TxQ and pass directly to the link.  However, th=
e TxQ will be used with L0p and when LLR occurs, increasing latency to tran=
sfer out to the link.  This event can be used in conjunction with the Flit =
Buffer Occupancy event in order to calculate the average flit buffer lifeti=
me.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x40",
-        "EventName": "UNC_UPI_TxL_INSERTS",
-        "Experimental": "1",
-        "PerPkg": "1",
-        "Unit": "UPI"
-    },
-    {
-        "BriefDescription": "Tx Flit Buffer Occupancy : Accumulates the nu=
mber of flits in the TxQ.  Generally, when data is transmitted across UPI, =
it will bypass the TxQ and pass directly to the link.  However, the TxQ wil=
l be used with L0p and when LLR occurs, increasing latency to transfer out =
to the link. This can be used with the cycles not empty event to track aver=
age occupancy, or the allocations event to track average lifetime in the Tx=
Q.",
-        "Counter": "0,1,2,3",
-        "EventCode": "0x42",
-        "EventName": "UNC_UPI_TxL_OCCUPANCY",
-        "Experimental": "1",
-        "PerPkg": "1",
-        "Unit": "UPI"
-    },
     {
         "BriefDescription": "Message Received : Doorbell",
         "Counter": "0,1",
@@ -1970,7 +1952,6 @@
         "Counter": "0,1",
         "EventCode": "0x42",
         "EventName": "UNC_U_EVENT_MSG.MSI_RCVD",
-        "Experimental": "1",
         "PerPkg": "1",
         "PublicDescription": "Message Received : MSI : Message Signaled In=
terrupts - interrupts sent by devices (including PCIe via IOxAPIC) (Socket =
Mode only)",
         "UMask": "0x2",
diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json b/=
tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
index 886b99a971be..f4f956966e16 100644
--- a/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
@@ -1121,8 +1121,9 @@
         "Unit": "IIO"
     },
     {
-        "BriefDescription": "Occupancy of outbound request queue : To devi=
ce : Counts number of outbound requests/completions IIO is currently proces=
sing",
+        "BriefDescription": "This event is deprecated. [This event is alia=
s to UNC_IIO_NUM_OUTSTANDING_REQ_FROM_CPU.TO_IO]",
         "Counter": "2,3",
+        "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "UNC_IIO_NUM_OUSTANDING_REQ_FROM_CPU.TO_IO",
         "Experimental": "1",
@@ -1132,6 +1133,18 @@
         "UMask": "0x8",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Occupancy of outbound request queue : To devi=
ce : Counts number of outbound requests/completions IIO is currently proces=
sing [This event is alias to UNC_IIO_NUM_OUSTANDING_REQ_FROM_CPU.TO_IO]",
+        "Counter": "2,3",
+        "EventCode": "0xc5",
+        "EventName": "UNC_IIO_NUM_OUTSTANDING_REQ_FROM_CPU.TO_IO",
+        "Experimental": "1",
+        "FCMask": "0x07",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "UMask": "0x8",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "Passing data to be written",
         "Counter": "0,1,2,3",
@@ -1300,6 +1313,18 @@
         "UMask": "0x4",
         "Unit": "IIO"
     },
+    {
+        "BriefDescription": "Posted requests sent by the integrated IO (II=
O) controller to the Ubox, useful for counting message signaled interrupts =
(MSI).",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x8e",
+        "EventName": "UNC_IIO_NUM_REQ_OF_CPU_BY_TGT.UBOX_POSTED",
+        "FCMask": "0x01",
+        "PerPkg": "1",
+        "PortMask": "0x0FF",
+        "PublicDescription": "-",
+        "UMask": "0x4",
+        "Unit": "IIO"
+    },
     {
         "BriefDescription": "All 9 bits of Page Walk Tracker Occupancy",
         "Counter": "0,1,2,3",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index f3fe686b6630..960076e3f66f 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -13,7 +13,7 @@ GenuineIntel-6-CF,v1.14,emeraldrapids,core
 GenuineIntel-6-5[CF],v13,goldmont,core
 GenuineIntel-6-7A,v1.01,goldmontplus,core
 GenuineIntel-6-B6,v1.09,grandridge,core
-GenuineIntel-6-A[DE],v1.08,graniterapids,core
+GenuineIntel-6-A[DE],v1.10,graniterapids,core
 GenuineIntel-6-(3C|45|46),v36,haswell,core
 GenuineIntel-6-3F,v29,haswellx,core
 GenuineIntel-6-7[DE],v1.24,icelake,core
--=20
2.50.0.rc1.591.g9c95f17f64-goog

