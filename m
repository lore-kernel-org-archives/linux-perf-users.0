Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E2634
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742947522; cv=none; b=p/Imzc82OLKEWCqEInDScBzZv/Ces6zMqBdR8hNJXVR4sFQfnrVAG/OptZHerez790YRs4HOLi3SfhaqDBl41fmULw4pr1f2AXXQuD1KvHRJFx5061FGDPra9pvkX9JLt6XAddhPQiHhznC0aDy8EA5v+yuyW8010zgxGGcUj3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742947522; c=relaxed/simple;
	bh=s0JRgLoxxuvunaHY7JyhOI/QMjmxBJL1LP9dIRrQ/aA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hTTHT95QAv4tiUZfnLzAPlm7dUXwafocYDTuMqLMI7s9TxGApSLzGkqam2IRQFwdYXOv1SD27Wx+VPiAsXu7ByYTtpXQ2LIxcv09xe6xrSoD/KdKpYaPh3HOgQM2XYvgH8AzMbqNoGXlWh1zK+SLJwAG/YCWfgOrSeSZS5vVkSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJGcqSZN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJGcqSZN"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so10555530a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 17:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742947519; x=1743552319; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGWGBvU/x5QSdgsAS6s6D7Oyp5KpZml9VkSt87fTBIw=;
        b=HJGcqSZNhTXdlsq7hRb+/LSiknbXZIfupjkOvzD2T7cHUfj6KgpJ+QTnuUR5xKyB3I
         SOmFee+67c01DujIqgl79B9Q/yTfBR8eVavRzuHRVo6Ok88nF+/fkLoFUF+NPQEVQhzI
         TtHWsFml/lXReYeSyQf5h8TgUvpgM0u0RN2VbyJo0O0cFoN2WtHEZg+sDujSBWAR6Jm4
         sDu7OTJ6PMRPjzkgGFPAC7eA1xFwNDNDdj9WHAULxtC8XwxCPV8fPC84ARIQLG5JXkha
         vicwFZUQMtahK5kZHrDnAzMMJFHF1mo/1iLP9zmYOtRtQPVkwd8pUsK/PGx4mEiTJ5mj
         ugjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742947519; x=1743552319;
        h=content-transfer-encoding:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aGWGBvU/x5QSdgsAS6s6D7Oyp5KpZml9VkSt87fTBIw=;
        b=KkLCAo1JhpM1Hv0m1eIfaAgs1k0l5gtKo28J+LfgZtDxwNnnVZj+txY/xP1EcDXNCm
         7y4/7DzrDhmHW1uWoydItDqLTTCDbM3nMCV3/z3ZxfxUQB4mr8r72LaCkV7m2MBVweCp
         Af90MMMn+QvT2gtX2RpnyfqIN4Fa02+QjyX1uJSBhoTSuD4PbYTdSo5ELm6pwhs2iOTC
         ZnfveRgoyt9RB3hjtFIgwyvWfchxiUuumhstkGD6Jm8ynojBCBskm4GQZT6B3X6sDsre
         cSFA0VrRd4/4FMd4SVUDA5QTX+XLppCtr+k6M8xJ/SG0w3wLS44gdq/bfZuWItDbCdPh
         bUBA==
X-Forwarded-Encrypted: i=1; AJvYcCVGdmTMKpNtDgXQftmdPeYe08Y2KB5YNt0K/UOtUtGM36wPJ/LZo4pfxJhl7CtIQuH6BVDAdYjaSV9fVAvYk5GL@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQARnTuwTbnuX60aHhgHktmTs5vzWN5S1pMkVUdOGme/AtZAv
	kD4IIe1dSl2RDiPI9U9sZI+uVGn7lCyu223BixuCG+1uSqE0lcK0EGo1PZoaMxzOPNzF8LgL9H0
	R5D3nag==
X-Google-Smtp-Source: AGHT+IH8r+oHk9yRWt/mYha62PxF4bSI8qeNl2jt9z/IDq5ZObjpVNzM7fb2MDiT1Z+6fmh5qurGS7ePI8ZX
X-Received: from pgau25.prod.google.com ([2002:a05:6a02:2d99:b0:af2:211e:938e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7488:b0:1f3:194b:30b0
 with SMTP id adf61e73a8af0-1fe42f25e29mr30484136637.5.1742947518974; Tue, 25
 Mar 2025 17:05:18 -0700 (PDT)
Date: Tue, 25 Mar 2025 17:04:00 -0700
In-Reply-To: <20250326000434.83325-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250326000434.83325-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250326000434.83325-3-irogers@google.com>
Subject: [PATCH v3 02/35] perf vendor events: Update AlderlakeN events/metrics
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

Update events from v1.28 to v1.29.
Update event topics, metrics to be generated from the TMA spreadsheet
and other small clean ups.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlaken/adln-metrics.json     | 54 +++++-----
 .../pmu-events/arch/x86/alderlaken/cache.json | 50 ++++++++++
 .../arch/x86/alderlaken/memory.json           | 40 ++++++++
 .../pmu-events/arch/x86/alderlaken/other.json | 98 -------------------
 .../arch/x86/alderlaken/pipeline.json         | 11 ++-
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  2 +-
 6 files changed, 128 insertions(+), 127 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index ad04b1e3881e..ce93648043ef 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -75,7 +75,7 @@
         "MetricExpr": "tma_core_bound",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_allocation_restriction",
-        "MetricThreshold": "(tma_allocation_restriction >0.10) & ((tma_cor=
e_bound >0.10) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core_b=
ound > 0.1 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
@@ -84,7 +84,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
-        "MetricThreshold": "(tma_backend_bound >0.10)",
+        "MetricThreshold": "tma_backend_bound > 0.1",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
         "ScaleUnit": "100%"
@@ -95,7 +95,7 @@
         "MetricExpr": "(5 * CPU_CLK_UNHALTED.CORE - (TOPDOWN_FE_BOUND.ALL =
+ TOPDOWN_BE_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / (5 * CPU_CLK_UNHALTED.COR=
E)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
-        "MetricThreshold": "(tma_bad_speculation >0.15)",
+        "MetricThreshold": "tma_bad_speculation > 0.15",
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
@@ -105,7 +105,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / (5 * CPU_CLK_UNHAL=
TED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_detect",
-        "MetricThreshold": "(tma_branch_detect >0.05) & ((tma_ifetch_laten=
cy >0.15) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
         "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s.",
         "ScaleUnit": "100%"
     },
@@ -114,7 +114,7 @@
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / (5 * CPU_CLK_U=
NHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
-        "MetricThreshold": "(tma_branch_mispredicts >0.05) & ((tma_bad_spe=
culation >0.15))",
+        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -123,7 +123,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / (5 * CPU_CLK_UNHA=
LTED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_resteer",
-        "MetricThreshold": "(tma_branch_resteer >0.05) & ((tma_ifetch_late=
ncy >0.15) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
@@ -131,7 +131,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.CISC / (5 * CPU_CLK_UNHALTED.CORE)=
",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_cisc",
-        "MetricThreshold": "(tma_cisc >0.05) & ((tma_ifetch_bandwidth >0.1=
0) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
@@ -139,7 +139,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / (5 * CPU_CLK_=
UNHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_core_bound",
-        "MetricThreshold": "(tma_core_bound >0.10) & ((tma_backend_bound >=
0.10))",
+        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -148,7 +148,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / (5 * CPU_CLK_UNHALTED.COR=
E)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_decode",
-        "MetricThreshold": "(tma_decode >0.05) & ((tma_ifetch_bandwidth >0=
.10) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
@@ -156,7 +156,7 @@
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / (5 * CPU_CLK_UNH=
ALTED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_fast_nuke",
-        "MetricThreshold": "(tma_fast_nuke >0.05) & ((tma_machine_clears >=
0.05) & ((tma_bad_speculation >0.15)))",
+        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
@@ -165,7 +165,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_frontend_bound",
-        "MetricThreshold": "(tma_frontend_bound >0.20)",
+        "MetricThreshold": "tma_frontend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%"
     },
@@ -174,7 +174,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / (5 * CPU_CLK_UNHALTED.COR=
E)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_icache_misses",
-        "MetricThreshold": "(tma_icache_misses >0.05) & ((tma_ifetch_laten=
cy >0.15) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
@@ -182,7 +182,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / (5 * CPU_CLK_=
UNHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_ifetch_bandwidth",
-        "MetricThreshold": "(tma_ifetch_bandwidth >0.10) & ((tma_frontend_=
bound >0.20))",
+        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -191,7 +191,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / (5 * CPU_CLK_UN=
HALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
         "MetricName": "tma_ifetch_latency",
-        "MetricThreshold": "(tma_ifetch_latency >0.15) & ((tma_frontend_bo=
und >0.20))",
+        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -473,7 +473,7 @@
         "BriefDescription": "PerfMon Event Multiplexing accuracy indicator=
",
         "MetricExpr": "CPU_CLK_UNHALTED.CORE_P / CPU_CLK_UNHALTED.CORE",
         "MetricName": "tma_info_system_mux",
-        "MetricThreshold": "((tma_info_system_mux > 1.1)|(tma_info_system_=
mux < 0.9))"
+        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_mu=
x < 0.9"
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
@@ -506,7 +506,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / (5 * CPU_CLK_UNHALTED.CORE)=
",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "(tma_itlb_misses >0.05) & ((tma_ifetch_latency=
 >0.15) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
@@ -514,7 +514,7 @@
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / (5 * CPU_C=
LK_UNHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_machine_clears",
-        "MetricThreshold": "(tma_machine_clears >0.05) & ((tma_bad_specula=
tion >0.15))",
+        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
n > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -523,7 +523,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / (5 * CPU_CLK_UNHAL=
TED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_mem_scheduler",
-        "MetricThreshold": "(tma_mem_scheduler >0.10) & ((tma_resource_bou=
nd >0.20) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
@@ -531,7 +531,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / (5 * CPU_CLK_U=
NHALTED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_non_mem_scheduler",
-        "MetricThreshold": "(tma_non_mem_scheduler >0.10) & ((tma_resource=
_bound >0.20) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
@@ -539,7 +539,7 @@
         "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / (5 * CPU_CLK_UNHALTE=
D.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_nuke",
-        "MetricThreshold": "(tma_nuke >0.05) & ((tma_machine_clears >0.05)=
 & ((tma_bad_speculation >0.15)))",
+        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
@@ -547,7 +547,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / (5 * CPU_CLK_UNHALTED.CORE=
)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_other_fb",
-        "MetricThreshold": "(tma_other_fb >0.05) & ((tma_ifetch_bandwidth =
>0.10) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
@@ -555,7 +555,7 @@
         "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / (5 * CPU_CLK_UNHALTED.=
CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_predecode",
-        "MetricThreshold": "(tma_predecode >0.05) & ((tma_ifetch_bandwidth=
 >0.10) & ((tma_frontend_bound >0.20)))",
+        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
@@ -563,7 +563,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / (5 * CPU_CLK_UNHALTED.C=
ORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_register",
-        "MetricThreshold": "(tma_register >0.10) & ((tma_resource_bound >0=
.20) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
@@ -571,7 +571,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / (5 * CPU_CLK_UNHA=
LTED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_reorder_buffer",
-        "MetricThreshold": "(tma_reorder_buffer >0.10) & ((tma_resource_bo=
und >0.20) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
@@ -579,7 +579,7 @@
         "MetricExpr": "tma_backend_bound - tma_core_bound",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_resource_bound",
-        "MetricThreshold": "(tma_resource_bound >0.20) & ((tma_backend_bou=
nd >0.10))",
+        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
@@ -589,7 +589,7 @@
         "MetricExpr": "TOPDOWN_RETIRING.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
-        "MetricThreshold": "(tma_retiring >0.75)",
+        "MetricThreshold": "tma_retiring > 0.75",
         "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%"
     },
@@ -598,7 +598,7 @@
         "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / (5 * CPU_CLK_UNHAL=
TED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_serialization",
-        "MetricThreshold": "(tma_serialization >0.10) & ((tma_resource_bou=
nd >0.20) & ((tma_backend_bound >0.10)))",
+        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/cache.json
index fd9ed58c2f90..605d56311dfc 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
@@ -396,6 +396,26 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x6"
     },
+    {
+        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10008",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
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
     {
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by the L3 cache.",
         "Counter": "0,1,2,3,4,5",
@@ -436,6 +456,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0xB7",
+        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
+        "MSRIndex": "0x1a6,0x1a7",
+        "MSRValue": "0x10001",
+        "SampleAfterValue": "100003",
+        "UMask": "0x1"
+    },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache.",
         "Counter": "0,1,2,3,4,5",
@@ -476,6 +506,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5",
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
y the L3 cache.",
         "Counter": "0,1,2,3,4,5",
@@ -516,6 +556,16 @@
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
     {
         "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L3 =
cache.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json b/tools/=
perf/pmu-events/arch/x86/alderlaken/memory.json
index 3b46b048dfb2..06eca0a45c18 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
@@ -56,6 +56,16 @@
         "SampleAfterValue": "20003",
         "UMask": "0x2"
     },
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
         "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were not supplied by the L3 cache.",
         "Counter": "0,1,2,3,4,5",
@@ -66,6 +76,16 @@
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
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3,4,5",
@@ -86,6 +106,16 @@
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
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
         "Counter": "0,1,2,3,4,5",
@@ -106,6 +136,16 @@
         "SampleAfterValue": "100003",
         "UMask": "0x1"
     },
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
         "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were not supplied by the=
 L3 cache.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/other.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/other.json
index f8c21b7f8f40..0ebcb3e20e1d 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/other.json
@@ -8,76 +8,6 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
-    {
-        "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.COREWB_M.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10008",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that have any type of response.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand instruction fetches and L1 inst=
ruction cache prefetches that were supplied by DRAM.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x784000004",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x10001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x784000001",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
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
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.DEMAND_RFO.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x784000002",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
     {
         "BriefDescription": "Counts streaming stores which modify a full 6=
4 byte cacheline that have any type of response.",
         "Counter": "0,1,2,3,4,5",
@@ -107,33 +37,5 @@
         "MSRValue": "0x10800",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that have any type of respons=
e.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.SWPF_RD.ANY_RESPONSE",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x14000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts L1 data cache software prefetches whic=
h include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by DRAM.",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0xB7",
-        "EventName": "OCR.SWPF_RD.DRAM",
-        "MSRIndex": "0x1a6,0x1a7",
-        "MSRValue": "0x784004000",
-        "SampleAfterValue": "100003",
-        "UMask": "0x1"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state. For Tremont, UMWAIT and TPAUSE will onl=
y put the CPU into C0.1 activity state (not C0.2 activity state)",
-        "Counter": "0,1,2,3,4,5",
-        "EventCode": "0x75",
-        "EventName": "SERIALIZATION.C01_MS_SCB",
-        "SampleAfterValue": "200003",
-        "UMask": "0x4"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/alderlaken/pipeline.json
index 713ebc21cec0..0cc8cd203fc3 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
@@ -399,8 +399,9 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine with the use of microcode due to SMC=
, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUAL_=
TRAP.",
+        "BriefDescription": "This event is deprecated.",
         "Counter": "0,1,2,3,4,5",
+        "Deprecated": "1",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SLOW",
         "SampleAfterValue": "20003",
@@ -423,6 +424,14 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x1"
     },
+    {
+        "BriefDescription": "Counts the number of issue slots in a UMWAIT =
or TPAUSE instruction where no uop issues due to the instruction putting th=
e CPU into the C0.1 activity state. For Tremont, UMWAIT and TPAUSE will onl=
y put the CPU into C0.1 activity state (not C0.2 activity state)",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x75",
+        "EventName": "SERIALIZATION.C01_MS_SCB",
+        "SampleAfterValue": "200003",
+        "UMask": "0x4"
+    },
     {
         "BriefDescription": "Counts the number of issue slots not consumed=
 by the backend due to a micro-sequencer (MS) scoreboard, which stalls the =
front-end from issuing from the UROM until a specified older uop retires.",
         "Counter": "0,1,2,3,4,5",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index 881f418137fd..0ef31b65f8df 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.29,alderlake,core
-GenuineIntel-6-BE,v1.28,alderlaken,core
+GenuineIntel-6-BE,v1.29,alderlaken,core
 GenuineIntel-6-C[56],v1.07,arrowlake,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v30,broadwell,core
--=20
2.49.0.395.g12beb8f557-goog

