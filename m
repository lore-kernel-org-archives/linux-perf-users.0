Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830121ADAE
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738704796; cv=none; b=ci8q9zlmf7zOZ6atphmCOzQJj+ZVd9mLvIL+J04PtTOrWYJMcCfMaEG8pB8sVhfz4VbeoJItQfbAPT/irrACzfUH3Uu5AxhjsSvhOxeD2HhtcX3RuJ5DX9FRG702UNTGoUT+cKnM8AYhs5d4NEnBzf9vJh+aTtaggZa0JZ2cBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738704796; c=relaxed/simple;
	bh=0LbWr5gRYOkBNKAez3haca4JRvMAZJgD1DfI0XYa1rI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Q9vUngvVHd4Xsfs6b4wIiWTi4ooCsNTUciJ/cZyuhUDr2DspYav8LCvuA+oa8lvfJO0IQxS4ty+jXgC/JYmmHt7KvlohB58dIZnp/Y5ERB0ZZEym+MiriOqfwkFClwscTEJA1VWTsefE6T4KISL0qX9o/D8WBT2QZrbZkRJejmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGzO0vbQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGzO0vbQ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f975f86b74so23312497b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 13:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738704792; x=1739309592; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MNPoKBPhmjogTx/X5pfaeJnrreHPOFuKkgWQ5znUa8=;
        b=VGzO0vbQ3QNepRXjAAYni2HmYUi1pC1+Iz39HREUMcNVcbsEKl/G4or4flKCWPS1Rw
         Wi02zCSfszcF5sbpV8BacirkR26tR3vi2Mk37F4V+hXlMoe9rLwtMrtOFnHCcqi9js0B
         ctWsvRomMBdes7wLA7VQK9SAy8Yqdoe2NS0KrHYCO/7WbFL3BL9WT5njTxsVf2fztyHi
         D2TbxX8iiEF8IE8/mSgBEyF7W45sSG5EJgIrODdYwybDLO4PQkxJrI6qqGyRMPacDGhX
         n85m8qlp3aHl5VuyRO/Pv/OuQIiESw6mbVlAVJBsbP6Q6U0jbSZJo8mx1kjQz6e6Tfsu
         //4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738704792; x=1739309592;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+MNPoKBPhmjogTx/X5pfaeJnrreHPOFuKkgWQ5znUa8=;
        b=nROVce7xAQq96kqj8GBIflBX8CkE3+T0bbHIX4WcuoBovtzL5YhQTzq8d4iO/K07Uz
         NUC3V/QwlnmA1aTv3rT2DmT/ywx4OD5b0B8qowe0w9zcraaBxpnDt8rxMEO6eUKb3D59
         tpGkmt17sioQ0cye+M6Aopg7p0ZtA1SVQK1Wh9uiGbkzCvHvaai5iOpvOGU2aTuC4Ng5
         wHGfvKRx+tC3+7ocbEbI4E79jwRkg7RVMk10dTKhbB6AaHe5jbpBV1xlixYOXARih5ue
         /DFq/RpITZ6n0vyeLT7IFKWgDxNTR0Q7Mts1vgTPejSwCJxevnl7/LAd8K/jYJHP21uQ
         Cckg==
X-Forwarded-Encrypted: i=1; AJvYcCUb16mby9WFwcekZiRWRuCJptcGMLEW3927sUEOMjIV3AafA9P1r31FhSuj+Feb/AF5ch53Ha2v2Qojq+NVrVHa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cSP0RmnThM5ToZQX9pYAQKgdEMuH1bsFzpn5wpNAUwJmYU4u
	6PZiD5Ik/E1WvL9m6v6X37evVbtcrs+aV7Le+n9BMot7257qAw513GekEciF8FSqz4N/7jHWyod
	oILE7jw==
X-Google-Smtp-Source: AGHT+IHjnWVI+eQ5/TozczjdmJVoVhGKfZAJYI/TT6/O/v6Zmlhyn6+G0XHWS+ViWGXqOLN8It6UoqaXFtoo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7368:836:b122:bba])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e02:b0:6dd:fda3:6568 with SMTP
 id 00721157ae682-6f989f1aa97mr19017b3.3.1738704791976; Tue, 04 Feb 2025
 13:33:11 -0800 (PST)
Date: Tue,  4 Feb 2025 13:32:37 -0800
In-Reply-To: <20250204213259.127939-1-irogers@google.com>
Message-Id: <20250204213259.127939-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204213259.127939-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v4 02/23] perf vendor events: Update AlderlakeN events/metrics
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
	Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.27 to v1.28.
Update TMA metrics from 4.8 to 5.01.

Bring in the event updates v1.28:
https://github.com/intel/perfmon/commit/801f43f22ec6bd23fbb5d18860f395d61e7=
f4081

The TMA 5.01 update is from (with subsequent fixes):
https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5c2=
2d782

Co-developed-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Caleb Biggers <caleb.biggers@intel.com>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlaken/adln-metrics.json     |  83 ++++---
 .../pmu-events/arch/x86/alderlaken/cache.json | 227 ++++++++++++++++--
 .../arch/x86/alderlaken/floating-point.json   |  17 +-
 .../arch/x86/alderlaken/memory.json           |  20 ++
 .../pmu-events/arch/x86/alderlaken/other.json |  81 ++++++-
 .../arch/x86/alderlaken/pipeline.json         |  97 +++++---
 .../arch/x86/alderlaken/virtual-memory.json   |  30 +++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 8 files changed, 458 insertions(+), 99 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index 447596f924ab..141562def5c4 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -48,13 +48,6 @@
         "MetricName": "C7_Core_Residency",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "C7 residency percent per package",
-        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C7_Pkg_Residency",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "C8 residency percent per package",
         "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
@@ -62,13 +55,6 @@
         "MetricName": "C8_Pkg_Residency",
         "ScaleUnit": "100%"
     },
-    {
-        "BriefDescription": "C9 residency percent per package",
-        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
-        "MetricGroup": "Power",
-        "MetricName": "C9_Pkg_Residency",
-        "ScaleUnit": "100%"
-    },
     {
         "BriefDescription": "Percentage of cycles spent in System Manageme=
nt Interrupts.",
         "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ > 0=
 else 0)",
@@ -89,7 +75,7 @@
         "MetricExpr": "tma_core_bound",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_allocation_restriction",
-        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core_b=
ound > 0.1 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_allocation_restriction >0.10) & ((tma_cor=
e_bound >0.10) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%"
     },
     {
@@ -98,7 +84,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
-        "MetricThreshold": "tma_backend_bound > 0.1",
+        "MetricThreshold": "(tma_backend_bound >0.10)",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
         "ScaleUnit": "100%"
@@ -109,7 +95,7 @@
         "MetricExpr": "(5 * CPU_CLK_UNHALTED.CORE - (TOPDOWN_FE_BOUND.ALL =
+ TOPDOWN_BE_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / (5 * CPU_CLK_UNHALTED.COR=
E)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
-        "MetricThreshold": "tma_bad_speculation > 0.15",
+        "MetricThreshold": "(tma_bad_speculation >0.15)",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ). Also includes the issue slots that were consumed by the ba=
ckend but were thrown away because they were younger than the mispredict or=
 machine clear.",
         "ScaleUnit": "100%"
@@ -119,7 +105,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / (5 * CPU_CLK_UNHAL=
TED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_detect",
-        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_branch_detect >0.05) & ((tma_ifetch_laten=
cy >0.15) & ((tma_frontend_bound >0.20)))",
         "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s.",
         "ScaleUnit": "100%"
     },
@@ -128,7 +114,7 @@
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / (5 * CPU_CLK_U=
NHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
-        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
+        "MetricThreshold": "(tma_branch_mispredicts >0.05) & ((tma_bad_spe=
culation >0.15))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -137,7 +123,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / (5 * CPU_CLK_UNHA=
LTED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_resteer",
-        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_branch_resteer >0.05) & ((tma_ifetch_late=
ncy >0.15) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%"
     },
     {
@@ -145,7 +131,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.CISC / (5 * CPU_CLK_UNHALTED.CORE)=
",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_cisc >0.05) & ((tma_ifetch_bandwidth >0.1=
0) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%"
     },
     {
@@ -153,7 +139,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / (5 * CPU_CLK_=
UNHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_core_bound",
-        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
+        "MetricThreshold": "(tma_core_bound >0.10) & ((tma_backend_bound >=
0.10))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -162,7 +148,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / (5 * CPU_CLK_UNHALTED.COR=
E)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_decode",
-        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_decode >0.05) & ((tma_ifetch_bandwidth >0=
.10) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%"
     },
     {
@@ -170,7 +156,7 @@
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / (5 * CPU_CLK_UNH=
ALTED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_fast_nuke",
-        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
+        "MetricThreshold": "(tma_fast_nuke >0.05) & ((tma_machine_clears >=
0.05) & ((tma_bad_speculation >0.15)))",
         "ScaleUnit": "100%"
     },
     {
@@ -179,7 +165,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
-        "MetricThreshold": "tma_frontend_bound > 0.2",
+        "MetricThreshold": "(tma_frontend_bound >0.20)",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%"
     },
@@ -188,7 +174,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / (5 * CPU_CLK_UNHALTED.COR=
E)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_icache_misses >0.05) & ((tma_ifetch_laten=
cy >0.15) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%"
     },
     {
@@ -196,7 +182,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / (5 * CPU_CLK_=
UNHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_ifetch_bandwidth",
-        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
+        "MetricThreshold": "(tma_ifetch_bandwidth >0.10) & ((tma_frontend_=
bound >0.20))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -205,7 +191,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / (5 * CPU_CLK_UN=
HALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_ifetch_latency",
-        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
+        "MetricThreshold": "(tma_ifetch_latency >0.15) & ((tma_frontend_bo=
und >0.20))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -320,6 +306,11 @@
         "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / MEM_BOUND_ST=
ALLS.IFETCH",
         "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2hit"
     },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss doesn't hit in the L2",
+        "MetricExpr": "100 * (MEM_BOUND_STALLS.IFETCH_LLC_HIT + MEM_BOUND_=
STALLS.IFETCH_DRAM_HIT) / MEM_BOUND_STALLS.IFETCH",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2miss"
+    },
     {
         "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
         "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / MEM_BOUND_S=
TALLS.IFETCH",
@@ -336,6 +327,12 @@
         "MetricGroup": "load_store_bound",
         "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2hit=
"
     },
+    {
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses in the L2",
+        "MetricExpr": "100 * (MEM_BOUND_STALLS.LOAD_LLC_HIT + MEM_BOUND_ST=
ALLS.LOAD_DRAM_HIT) / MEM_BOUND_STALLS.LOAD",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2mis=
s"
+    },
     {
         "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
         "MetricExpr": "100 * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND_STA=
LLS.LOAD",
@@ -472,6 +469,12 @@
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_kernel_utilization"
     },
+    {
+        "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P / CPU_CLK_UNHALTED.CORE",
+        "MetricName": "tma_info_system_mux",
+        "MetricThreshold": "((tma_info_system_mux > 1.1)|(tma_info_system_=
mux < 0.9))"
+    },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE / CPU_CLK_UNHALTED.REF_TSC",
@@ -503,7 +506,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / (5 * CPU_CLK_UNHALTED.CORE)=
",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
 0.15 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_itlb_misses >0.05) & ((tma_ifetch_latency=
 >0.15) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%"
     },
     {
@@ -511,7 +514,7 @@
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / (5 * CPU_C=
LK_UNHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_machine_clears",
-        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
n > 0.15",
+        "MetricThreshold": "(tma_machine_clears >0.05) & ((tma_bad_specula=
tion >0.15))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -520,7 +523,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / (5 * CPU_CLK_UNHAL=
TED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_mem_scheduler",
-        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_mem_scheduler >0.10) & ((tma_resource_bou=
nd >0.20) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%"
     },
     {
@@ -528,7 +531,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / (5 * CPU_CLK_U=
NHALTED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_non_mem_scheduler",
-        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_non_mem_scheduler >0.10) & ((tma_resource=
_bound >0.20) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%"
     },
     {
@@ -536,7 +539,7 @@
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / (5 * CPU_CLK_UNHALTE=
D.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_nuke",
-        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
+        "MetricThreshold": "(tma_nuke >0.05) & ((tma_machine_clears >0.05)=
 & ((tma_bad_speculation >0.15)))",
         "ScaleUnit": "100%"
     },
     {
@@ -544,7 +547,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / (5 * CPU_CLK_UNHALTED.CORE=
)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_other_fb",
-        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_other_fb >0.05) & ((tma_ifetch_bandwidth =
>0.10) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%"
     },
     {
@@ -552,7 +555,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / (5 * CPU_CLK_UNHALTED.=
CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_predecode",
-        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
+        "MetricThreshold": "(tma_predecode >0.05) & ((tma_ifetch_bandwidth=
 >0.10) & ((tma_frontend_bound >0.20)))",
         "ScaleUnit": "100%"
     },
     {
@@ -560,7 +563,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / (5 * CPU_CLK_UNHALTED.C=
ORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_register",
-        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_register >0.10) & ((tma_resource_bound >0=
.20) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%"
     },
     {
@@ -568,7 +571,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / (5 * CPU_CLK_UNHA=
LTED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_reorder_buffer",
-        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_reorder_buffer >0.10) & ((tma_resource_bo=
und >0.20) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%"
     },
     {
@@ -576,7 +579,7 @@
         "MetricExpr": "tma_backend_bound - tma_core_bound",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_resource_bound",
-        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
+        "MetricThreshold": "(tma_resource_bound >0.20) & ((tma_backend_bou=
nd >0.10))",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -586,7 +589,7 @@
         "MetricExpr": "TOPDOWN_RETIRING.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
-        "MetricThreshold": "tma_retiring > 0.75",
+        "MetricThreshold": "(tma_retiring >0.75)",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%"
     },
@@ -595,7 +598,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / (5 * CPU_CLK_UNHAL=
TED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_serialization",
-        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
+        "MetricThreshold": "(tma_serialization >0.10) & ((tma_resource_bou=
nd >0.20) & ((tma_backend_bound >0.10)))",
         "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/cache.json
index 1500033ee19f..fd9ed58c2f90 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
@@ -1,4 +1,30 @@
 [
+    {
+        "BriefDescription": "Counts the total number of L2 Cache accesses.=
 Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.ALL",
+        "PublicDescription": "Counts the total number of L2 Cache Accesses=
, includes hits, misses, rejects  front door requests for CRd/DRd/RFO/ItoM/=
L2 Prefetches only.  Counts on a per core basis.",
+        "SampleAfterValue": "200003"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 Cache accesses that r=
esulted in a hit. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.HIT",
+        "PublicDescription": "Counts the number of L2 Cache accesses that =
resulted in a hit from a front door request only (does not include rejects =
or recycles), Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of L2 Cache accesses that r=
esulted in a miss. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x24",
+        "EventName": "L2_REQUEST.MISS",
+        "PublicDescription": "Counts the number of L2 Cache accesses that =
resulted in a miss from a front door request only (does not include rejects=
 or recycles). Counts on a per core basis.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
         "Counter": "0,1,2,3,4,5",
@@ -92,30 +118,81 @@
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache, in which a snoop was required and modified data was for=
warded from another core or module.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
+        "SampleAfterValue": "200003",
+        "UMask": "0x20"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L1 data cache.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
+        "SampleAfterValue": "200003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the L1 data cache.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L2 cache.",
         "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the L2 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd1",
+        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x10"
+    },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache.",
         "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x4"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache, in which a snoop was required, and non-modified data wa=
s forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.HIT_E_F",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x40"
+    },
+    {
+        "BriefDescription": "Counts the number of load uops retired that m=
iss in the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd2",
+        "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.L3_MISS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x20"
+    },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
         "Counter": "0,1,2,3,4,5",
@@ -154,7 +231,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of load uops retired=
.",
         "SampleAfterValue": "200003",
         "UMask": "0x81"
@@ -165,7 +241,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of store uops retire=
d.",
         "SampleAfterValue": "200003",
         "UMask": "0x82"
@@ -178,7 +253,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x80",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 128 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
@@ -191,7 +265,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x10",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 16 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
@@ -204,7 +277,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x100",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 256 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
@@ -217,7 +289,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x20",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 32 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
@@ -230,7 +301,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x4",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 4 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
@@ -243,7 +313,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x200",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 512 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
@@ -256,7 +325,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x40",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 64 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. =
If a PEBS record is generated, will populate the PEBS Latency and PEBS Data=
 Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
@@ -269,7 +337,6 @@
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
         "MSRIndex": "0x3F6",
         "MSRValue": "0x8",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of tagged loads with an in=
struction latency that exceeds or equals the threshold of 8 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled. I=
f a PEBS record is generated, will populate the PEBS Latency and PEBS Data =
Source fields accordingly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
@@ -280,7 +347,6 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x21"
     },
@@ -290,28 +356,93 @@
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x41"
     },
+    {
+        "BriefDescription": "Counts the total number of load and store uop=
s retired that missed in the second level TLB.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x13"
+    },
+    {
+        "BriefDescription": "Counts the number of load ops retired that mi=
ss in the second Level TLB.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "Counts the number of store ops retired that m=
iss in the second level TLB.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x12"
+    },
     {
         "BriefDescription": "Counts the number of stores uops retired. Cou=
nts with or without PEBS enabled.",
         "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
-        "PEBS": "2",
         "PublicDescription": "Counts the number of stores uops retired. Co=
unts with or without PEBS enabled. If PEBS is enabled and a PEBS record is =
generated, will populate PEBS Latency and PEBS Data Source fields according=
ly.",
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and modified data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, but no data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache where a snoop w=
as sent, the snoop hit, and non-modified data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache.",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C0001",
+        "MSRValue": "0x1F803C0001",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -351,7 +482,7 @@
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x3F803C0002",
+        "MSRValue": "0x1F803C0002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
@@ -365,6 +496,66 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, but no data was forwa=
rded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C0002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L3 =
cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.L3_HIT",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x1F803C4000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L3 =
cache where a snoop was sent, the snoop hit, and modified data was forwarde=
d.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.L3_HIT.SNOOP_HITM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10003C4000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L3 =
cache where a snoop was sent, the snoop hit, but no data was forwarded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.L3_HIT.SNOOP_HIT_NO_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x4003C4000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L3 =
cache where a snoop was sent, the snoop hit, and non-modified data was forw=
arded.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x8003C4000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to instruction cache misses.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json =
b/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
index 484d8b3167f0..ed963fcb6485 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
@@ -1,4 +1,20 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles the floating poin=
t divider is in the loop stage.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point divider u=
ops executed per cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.FPDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x8"
+    },
     {
         "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
         "Counter": "0,1,2,3,4,5",
@@ -13,7 +29,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.FPDIV",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x8"
     }
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json b/tools/=
perf/pmu-events/arch/x86/alderlaken/memory.json
index 619488d42a4a..3b46b048dfb2 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
@@ -56,6 +56,16 @@
         "SampleAfterValue": "20003",
         "UMask": "0x2"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84400004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3,4,5",
@@ -95,5 +105,15 @@
         "MSRValue": "0x3F84400002",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were not supplied by the=
 L3 cache.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.L3_MISS",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x3F84404000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/other.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/other.json
index 54ddbe2b3b9b..f8c21b7f8f40 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/other.json
@@ -5,7 +5,6 @@
         "Deprecated": "1",
         "EventCode": "0xe4",
         "EventName": "LBR_INSERTS.ANY",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -19,6 +18,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x784000004",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
         "Counter": "0,1,2,3,4,5",
@@ -29,6 +48,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x784000001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
         "Counter": "0,1,2,3,4,5",
@@ -39,6 +68,36 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_RFO.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x784000002",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.FULL_STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x800000010000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts streaming stores which modify only par=
t of a 64 byte cacheline that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.PARTIAL_STREAMING_WR.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x400000010000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
         "Counter": "0,1,2,3,4,5",
@@ -49,6 +108,26 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that have any type of respons=
e.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x14000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by DRAM.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.SWPF_RD.DRAM",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x784004000",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state. For Tremont, UMWAIT and TPAUSE will onl=
y put the CPU into C0.1 activity state (not C0.2 activity state)",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/alderlaken/pipeline.json
index f05db45578ff..713ebc21cec0 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
@@ -1,10 +1,59 @@
 [
+    {
+        "BriefDescription": "Counts the number of cycles when any of the f=
loating point or integer dividers are active.",
+        "Counter": "0,1,2,3,4,5",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of active floating point an=
d integer dividers per cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x3"
+    },
+    {
+        "BriefDescription": "Counts the number of floating point and integ=
er divider uops executed per cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.DIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0xc"
+    },
+    {
+        "BriefDescription": "Counts the number of cycles any of the two in=
teger dividers are active.",
+        "Counter": "0,1,2,3,4,5",
+        "CounterMask": "1",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_ACTIVE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of active integer dividers =
per cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_OCCUPANCY",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1"
+    },
+    {
+        "BriefDescription": "Counts the number of integer divider uops exe=
cuted per cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xcd",
+        "EventName": "ARITH.IDIV_UOPS",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions in w=
hich the instruction pointer (IP) of the processor is resteered due to a br=
anch instruction and the branch instruction successfully retires.  All bran=
ch type instructions are accounted for.",
         "SampleAfterValue": "200003"
     },
@@ -14,7 +63,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf9"
     },
@@ -23,7 +71,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
@@ -32,7 +79,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
@@ -41,7 +87,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xbf"
     },
@@ -50,7 +95,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
@@ -59,7 +103,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
@@ -69,7 +112,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
@@ -79,7 +121,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.JCC",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
@@ -88,7 +129,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf9"
     },
@@ -97,7 +137,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
@@ -106,7 +145,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xc0"
     },
@@ -116,7 +154,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
@@ -125,7 +162,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfd"
     },
@@ -135,7 +171,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.RETURN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
@@ -145,7 +180,6 @@
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
@@ -154,7 +188,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of mispredicted bran=
ch instructions retired.  All branch type instructions are accounted for.  =
Prediction of the branch target address enables the processor to begin exec=
uting instructions before the non-speculative execution path is known. The =
branch prediction unit (BPU) predicts the target address based on the instr=
uction pointer (IP) of the branch and on the execution path through which e=
xecution reached this IP.    A branch misprediction occurs when the predict=
ion is wrong, and results in discarding all instructions executed in the sp=
eculative path and re-fetching from the correct path.",
         "SampleAfterValue": "200003"
     },
@@ -163,7 +196,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
@@ -172,7 +204,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
@@ -181,7 +212,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
@@ -190,7 +220,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
@@ -200,7 +229,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfb"
     },
@@ -210,7 +238,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.JCC",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x7e"
     },
@@ -219,7 +246,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0x80"
     },
@@ -229,7 +255,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xeb"
     },
@@ -238,7 +263,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RETURN",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xf7"
     },
@@ -248,7 +272,6 @@
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
-        "PEBS": "1",
         "SampleAfterValue": "200003",
         "UMask": "0xfe"
     },
@@ -268,6 +291,15 @@
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses a programmable general purpose performance counter.",
         "SampleAfterValue": "2000003"
     },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
CPU_CLK_UNHALTED.REF_TSC_P",
+        "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
+        "EventCode": "0x3c",
+        "EventName": "CPU_CLK_UNHALTED.REF",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency. (Fixed event)",
         "Counter": "Fixed counter 2",
@@ -305,7 +337,6 @@
         "BriefDescription": "Counts the total number of instructions retir=
ed. (Fixed event)",
         "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses fixed counter 0.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
@@ -315,7 +346,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
-        "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses a programmable general purpose performance counter.",
         "SampleAfterValue": "2000003"
     },
@@ -325,7 +355,6 @@
         "Deprecated": "1",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -334,7 +363,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x4"
     },
@@ -343,7 +371,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
-        "PEBS": "1",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
@@ -392,7 +419,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of LBR entries recorded. R=
equires LBRs to be enabled in IA32_LBR_CTL. This event is PDIR on GP0 and N=
PEBS on all other GPs [This event is alias to LBR_INSERTS.ANY]",
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
@@ -588,7 +614,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "TOPDOWN_RETIRING.ALL",
-        "PEBS": "1",
         "SampleAfterValue": "1000003"
     },
     {
@@ -604,7 +629,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.ALL",
-        "PEBS": "1",
         "SampleAfterValue": "2000003"
     },
     {
@@ -612,7 +636,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.IDIV",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x10"
     },
@@ -621,7 +644,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
-        "PEBS": "1",
         "PublicDescription": "Counts the number of uops that are from comp=
lex flows issued by the Microcode Sequencer (MS). This includes uops from f=
lows due to complex instructions, faults, assists, and inserted flows.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
@@ -631,7 +653,6 @@
         "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
-        "PEBS": "1",
         "SampleAfterValue": "2000003",
         "UMask": "0x2"
     }
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
index ad2b1349bab4..d9c737a17df0 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
@@ -49,5 +49,35 @@
         "EventName": "LD_HEAD.DTLB_MISS_AT_RET",
         "SampleAfterValue": "1000003",
         "UMask": "0x90"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
MEM_UOPS_RETIRED.STLB_MISS",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "Deprecated": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x13"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
MEM_UOPS_RETIRED.STLB_MISS_LOADS",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "Deprecated": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
+        "SampleAfterValue": "200003",
+        "UMask": "0x11"
+    },
+    {
+        "BriefDescription": "This event is deprecated. Refer to new event =
MEM_UOPS_RETIRED.STLB_MISS_STORES",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "Deprecated": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
+        "SampleAfterValue": "200003",
+        "UMask": "0x12"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index d9538723927b..2fa5529ee585 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.28,alderlake,core
-GenuineIntel-6-BE,v1.27,alderlaken,core
+GenuineIntel-6-BE,v1.28,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v29,broadwell,core
 GenuineIntel-6-56,v11,broadwellde,core
--=20
2.48.1.362.g079036d154-goog

