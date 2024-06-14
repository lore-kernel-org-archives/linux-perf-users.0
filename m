Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC15186E37
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2024 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406176; cv=none; b=eBNJYx/lHkLHWN38k8t1B0USs8sQ+ajIK+PLpht7QEZD7mzehlVYk2VCj+7kun73OvtwHDHLpr/zDmMSkKmMDQxfR1WQ+9apxDX9Uj/FbGc0PGBzD3JvmuSQ4g0je/Gq/UQw1m2KblR46POtiTX12WbuRui9M35edeB4mgIcRKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406176; c=relaxed/simple;
	bh=DWpTOW8LW3HItpkFXRTKFhWkzwQoYC+MZI0k5N/oIxw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=BWTbs3k031IqBH/PpHClKurHTNNrevYztKpzQzLyS9FfVQbWQskSJJpiuEUVTOSI4LqRefCd9s7EGLqK0PHeyuFbC2PoIId6tN/Yo0iZu7Sg+Vy/NB6K+rRlUaMkRwhIwK0pGabX2bA0nhHgR+un+bcUtNBN1JSArEUleRKw/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBm1w/xr; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBm1w/xr"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6326955ad54so19523927b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2024 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718406163; x=1719010963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk3BfYlYKUlxom+EfhYA5VjCbUlpaawGEtzkegxHNF4=;
        b=DBm1w/xrk94bpOqKYZZ6RUA6BH25ZLA8HHfvOE6AmGHudtQmX861AnUtNJ+6wKPx7f
         9r3BdMkOUk9JIpAuWVCZzoFqD67SZ23MMrtngqiTDnh7UDBLDXoHfL5c9yHRiXK6/wyS
         q+kS0+2U3YJTcoau0qvVRtefUHU7qyqDeNVKhuD4rXoTlEy8Av8X9xIDBUoVRQtP9aK+
         1f+dk7zdRRYyfMPqoNz311ByuPV5ObNghNmXW1TzzxEInK8TEyyaZXDfPnqzAlH4xHbE
         O6DVjCMZOFYxIJfLX+i5r0AO70KZuTfIfGM1xdDyYah1COk8syvOZVrWmeYcvqHxIHtD
         /KdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406163; x=1719010963;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hk3BfYlYKUlxom+EfhYA5VjCbUlpaawGEtzkegxHNF4=;
        b=I+NzJ4WHPEvyB0DP/CkL8eUdLm7gS0jZ4lN/YRxsyp4cIpaCOnd4wudq5HUZ6nM4Ue
         7sjv94Wi6CMTbDT+5JOPby0jD9Y9KqPf0G+ny6FGsNxZjGBMRAJTgZoEhMWoikTNrA+l
         5Ho5/hO8Trzj2jYMWWjBCOUHI42eKWY4V45JDAwpHSAa/tFqzEiu0xztgN5VdU2GXsMH
         tuvWgVxL9Nyzsr39/cpy7Wi4XFnTTVs3yIvlzjiiLEvOOvffynkN1qDamOCP7eTboXyu
         RdsJS+hejBEt2d+Bzl5pKrOs0u9HFyxjXLXBb4G4ozq1fdvPi8oGeB7I1UHTI7rzueZE
         Pknw==
X-Forwarded-Encrypted: i=1; AJvYcCWXKZracCCqmKo6OT9WytPsP7mj7xPlv5w0wIwlDO5NrxfaTfhrAOnGDJqLvgzIOIZuNSRNNsjoiNLUqxsfyj7vqDu4P6bJrtlPS6+sgPXjKQ==
X-Gm-Message-State: AOJu0Yw6X0AF0UWgWdgcUwy+6VAWp/HwCo/JI0C/o3aT7FpISu3OjxEQ
	wLO2P2eWNygsUA4xaWM8wCAOSAAf6UxQT12C63q3oJzlCWBDOCiXointijTNHumBCGfrX30e8lg
	ONZ9iEQ==
X-Google-Smtp-Source: AGHT+IHnFt9z/TEbZMw5Zj7g3SMollQxaaEd+0T1Y8M3eaXOBGKN7wjtACVhAfInxsawYjinDNTvfY80myA6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:714a:5e65:12a1:603])
 (user=irogers job=sendgmr) by 2002:a05:690c:6112:b0:62d:a29:53a0 with SMTP id
 00721157ae682-63224fe9ddfmr8429047b3.7.1718406163086; Fri, 14 Jun 2024
 16:02:43 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:01:09 -0700
In-Reply-To: <20240614230146.3783221-1-irogers@google.com>
Message-Id: <20240614230146.3783221-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614230146.3783221-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v1 01/37] perf vendor events: Update alderlake events/metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Weilin Wang <weilin.wang@intel.com>, Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from v1.24 to v1.27.
Update p-core TMA metrics from v4.7 to v4.8, and the e-core TMA
metrics to v3.6.

Bring in the event updates v1.27:
https://github.com/intel/perfmon/commit/ea4f309a04c50ca77a00da2db130fd7cf06=
db978
v1.26:
https://github.com/intel/perfmon/commit/0052e68d24d9873d5ff22363677794fa3eb=
05313

The p-core TMA 4.8 information was updated in:
https://github.com/intel/perfmon/commit/59194d4d90ca50a3fcb2de0d82b9f6fc0c9=
a5736
And e-core in:
https://github.com/intel/perfmon/commit/d9c2faa70bafe03129dc10f9fe414ef03a9=
5acd9

New events are:
EXE_ACTIVITY.2_3_PORTS_UTIL,
ICACHE_DATA.STALL_PERIODS,
L2_TRANS.L2_WB,
MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024,
MEM_UOPS_RETIRED.LOCK_LOADS,
OFFCORE_REQUESTS.DEMAND_CODE_RD,
OFFCORE_REQUESTS.DEMAND_RFO,
OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE_RD,
OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD,
RS.EMPTY_RESOURCE,
SERIALIZATION.C01_MS_SCB,
SW_PREFETCH_ACCESS.ANY,
UOPS_ISSUED.ANY,
UOPS_ISSUED.CYCLES

Co-authored-by: Weilin Wang <weilin.wang@intel.com>
Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlake/adl-metrics.json       | 988 +++++++++---------
 .../pmu-events/arch/x86/alderlake/cache.json  | 184 +++-
 .../arch/x86/alderlake/floating-point.json    |  20 +
 .../arch/x86/alderlake/frontend.json          |  56 +-
 .../pmu-events/arch/x86/alderlake/memory.json |  44 +
 .../arch/x86/alderlake/metricgroups.json      |  23 +-
 .../pmu-events/arch/x86/alderlake/other.json  |  37 +
 .../arch/x86/alderlake/pipeline.json          | 214 ++++
 .../x86/alderlake/uncore-interconnect.json    |  19 +
 .../arch/x86/alderlake/uncore-memory.json     |  25 +
 .../arch/x86/alderlake/uncore-other.json      |   1 +
 .../arch/x86/alderlake/virtual-memory.json    |  26 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 13 files changed, 1115 insertions(+), 524 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/to=
ols/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
index b72c0e2cb946..8fdf4a4225de 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
@@ -113,42 +113,30 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to certain allocation restrictions.",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / tma=
_info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_alloc_restriction",
-        "MetricThreshold": "tma_alloc_restriction > 0.1",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to certain allocation restrictions",
+        "MetricExpr": "tma_core_bound",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricName": "tma_allocation_restriction",
+        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core_b=
ound > 0.1 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend due to backend stalls",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALL@ / tma_info_core_slot=
s",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CPU_=
CLK_UNHALTED.CORE@)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.1",
         "MetricgroupNoGroup": "TopdownL1;Default",
-        "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that uops mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.   The rest of t=
hese subevents count backend stalls, in cycles, due to an outstanding reque=
st which is memory bound vs core bound.   The subevents are not slot based =
events and therefore can not be precisely added or subtracted from the Back=
end_Bound_Aux subevents which are slot based.",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
-        "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "tma_backend_bound",
-        "MetricGroup": "Default;TopdownL1;tma_L1_group",
-        "MetricName": "tma_backend_bound_aux",
-        "MetricThreshold": "tma_backend_bound_aux > 0.2",
-        "MetricgroupNoGroup": "TopdownL1;Default",
-        "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that UOPS mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.  All of these s=
ubevents count backend stalls, in slots, due to a resource limitation.   Th=
ese are not cycle based events and therefore can not be precisely added or =
subtracted from the Backend_Bound subevents which are cycle based.  These s=
ubevents are supplementary to Backend_Bound and can be used to analyze resu=
lts from a resource perspective at allocation.",
+        "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend due to backend stalls. Note that uops must=
 be available for consumption in order for this event to count. If a uop is=
 not available (IQ is empty), this event will not count",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "(tma_info_core_slots - (cpu_atom@TOPDOWN_FE_BOUND.A=
LL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RETIRING.ALL@)) / t=
ma_info_core_slots",
+        "MetricExpr": "(5 * cpu_atom@CPU_CLK_UNHALTED.CORE@ - (cpu_atom@TO=
PDOWN_FE_BOUND.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_RET=
IRING.ALL@)) / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
@@ -158,644 +146,564 @@
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of uops that are not from t=
he microsequencer.",
-        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ - cpu_atom@UOPS_RET=
IRED.MS@) / tma_info_core_slots",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
-        "MetricName": "tma_base",
-        "MetricThreshold": "tma_base > 0.6",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ / tma_info=
_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BACLEARS, which occurs when the Branch T=
arget Buffer (BTB) prediction or lack thereof, was corrected by a later bra=
nch predictor in the frontend",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ / (5 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_detect",
-        "MetricThreshold": "tma_branch_detect > 0.05",
-        "PublicDescription": "Counts the number of issue slots  that were =
not delivered by the frontend due to BACLEARS, which occurs when the Branch=
 Target Buffer (BTB) prediction or lack thereof, was corrected by a later b=
ranch predictor in the frontend. Includes BACLEARS due to all branch types =
including conditional and unconditional jumps, returns, and indirect branch=
es.",
+        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
+        "PublicDescription": "Counts the number of issue slots that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend. Includes BACLEARS due to all branch types i=
ncluding conditional and unconditional jumps, returns, and indirect branche=
s.",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to branch mispredicts.",
-        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / tma_=
info_core_slots",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to branch mispredicts",
+        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / (5 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
-        "MetricThreshold": "tma_branch_mispredicts > 0.05",
+        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BTCLEARS, which occurs when the Branch =
Target Buffer (BTB) predicts a taken branch.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ / tma_inf=
o_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BTCLEARS, which occurs when the Branch T=
arget Buffer (BTB) predicts a taken branch.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ / (5 * cp=
u_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_resteer",
-        "MetricThreshold": "tma_branch_resteer > 0.05",
+        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to the microcode sequencer (MS).",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.CISC@ / tma_info_core_slo=
ts",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS).",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (5 * cpu_atom@CPU=
_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.05",
+        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are core execution bound and not attributed to outstanding =
demand load or store stalls.",
-        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
+        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are bounded by core restrictions and not attributed to an o=
utstanding load or stores, or resource limitation",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (5 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_core_bound",
-        "MetricThreshold": "tma_core_bound > 0.1",
+        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to decode stalls.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / tma_info_core_s=
lots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / (5 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_decode",
-        "MetricThreshold": "tma_decode > 0.05",
+        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory disambiguation.",
-        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.DISAMBIGUATION@=
 / cpu_atom@MACHINE_CLEARS.SLOW@)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
-        "MetricName": "tma_disambiguation",
-        "MetricThreshold": "tma_disambiguation > 0.02",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that does not require the =
use of microcode, classified as a fast nuke, due to memory ordering, memory=
 disambiguation and memory renaming",
+        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / (5 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_fast_nuke",
+        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
-        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / tma_info=
_core_clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MIS=
S_AT_RET@) / tma_info_core_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_H=
IT@ / cpu_atom@MEM_BOUND_STALLS.LOAD@",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls.",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CPU_=
CLK_UNHALTED.CORE@)",
+        "MetricGroup": "Default;TopdownL1;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "MetricThreshold": "tma_frontend_bound > 0.2",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear classified as a fast nuke=
 due to memory ordering, memory disambiguation and memory renaming.",
-        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / tma_in=
fo_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
-        "MetricName": "tma_fast_nuke",
-        "MetricThreshold": "tma_fast_nuke > 0.05",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / (5 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricName": "tma_icache_misses",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / tma=
_info_core_slots",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (5 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
-        "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.1",
+        "MetricName": "tma_ifetch_bandwidth",
+        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / tma_i=
nfo_core_slots",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (5 * =
cpu_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
-        "MetricName": "tma_fetch_latency",
-        "MetricThreshold": "tma_fetch_latency > 0.15",
+        "MetricName": "tma_ifetch_latency",
+        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to FP assists.",
-        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.FP_ASSIST@ / cp=
u_atom@MACHINE_CLEARS.SLOW@)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
-        "MetricName": "tma_fp_assist",
-        "MetricThreshold": "tma_fp_assist > 0.02",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the number of floating point divide op=
erations per uop.",
-        "MetricExpr": "cpu_atom@UOPS_RETIRED.FPDIV@ / tma_info_core_slots"=
,
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
-        "MetricName": "tma_fpdiv_uops",
-        "MetricThreshold": "tma_fpdiv_uops > 0.2",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
+        "MetricExpr": "100 * (cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ + cpu_ato=
m@LD_HEAD.PGWALK_AT_RET@) / cpu_atom@CPU_CLK_UNHALTED.CORE@",
+        "MetricName": "tma_info_bottleneck_%_dtlb_miss_bound_cycles",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
-        "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ALL@ / tma_info_core_slot=
s",
-        "MetricGroup": "Default;TopdownL1;tma_L1_group",
-        "MetricName": "tma_frontend_bound",
-        "MetricThreshold": "tma_frontend_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL1;Default",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of time that allocation and retire=
ment is stalled by the Frontend Cluster due to an Ifetch Miss, either Icach=
e or ITLB Miss",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH@ / cpu_atom@=
CPU_CLK_UNHALTED.CORE@",
+        "MetricGroup": "Ifetch",
+        "MetricName": "tma_info_bottleneck_%_ifetch_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to instruction cache misses.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / tma_info_core_s=
lots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
-        "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of time that retirement is stalled=
 due to an L1 miss",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD@ / cpu_atom@CP=
U_CLK_UNHALTED.CORE@",
+        "MetricGroup": "Load_Store_Miss",
+        "MetricName": "tma_info_bottleneck_%_load_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@",
-        "MetricName": "tma_info_core_clks",
+        "BriefDescription": "Percentage of time that retirement is stalled=
 by the Memory Cluster due to a pipeline stall",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.ANY_AT_RET@ / cpu_atom@CPU_C=
LK_UNHALTED.CORE@",
+        "MetricGroup": "Mem_Exec",
+        "MetricName": "tma_info_bottleneck_%_mem_exec_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE_P@",
-        "MetricName": "tma_info_core_clks_p",
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIR=
ED.ALL_BRANCHES@",
+        "MetricName": "tma_info_br_inst_mix_ipbranch",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Cycles Per Instruction",
-        "MetricExpr": "tma_info_core_clks / INST_RETIRED.ANY",
-        "MetricName": "tma_info_core_cpi",
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIR=
ED.CALL@",
+        "MetricName": "tma_info_br_inst_mix_ipcall",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions Per Cycle",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / tma_info_core_clks",
-        "MetricName": "tma_info_core_ipc",
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RETIR=
ED.FAR_BRANCH@u",
+        "MetricName": "tma_info_br_inst_mix_ipfarbranch",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "5 * tma_info_core_clks",
-        "MetricName": "tma_info_core_slots",
+        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_MISP_RETI=
RED.COND@ - cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_ntaken",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "cpu_atom@UOPS_RETIRED.ALL@ / INST_RETIRED.ANY",
-        "MetricName": "tma_info_core_upi",
+        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was taken",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.COND_TAKEN@",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_taken",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
DRAM",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ / =
cpu_atom@MEM_BOUND_STALLS.IFETCH@",
-        "MetricName": "tma_info_frontend_inst_miss_cost_dramhit_percent",
+        "BriefDescription": "Instructions per retired indirect call or jum=
p Branch Misprediction",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.INDIRECT@",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_indirect",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
the L2",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@ / cp=
u_atom@MEM_BOUND_STALLS.IFETCH@",
-        "MetricName": "tma_info_frontend_inst_miss_cost_l2hit_percent",
+        "BriefDescription": "Instructions per retired return Branch Mispre=
diction",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.RETURN@",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_ret",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
the L3",
-        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ / c=
pu_atom@MEM_BOUND_STALLS.IFETCH@",
-        "MetricName": "tma_info_frontend_inst_miss_cost_l3hit_percent",
+        "BriefDescription": "Instructions per retired Branch Misprediction=
",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RETIR=
ED.ALL_BRANCHES@",
+        "MetricName": "tma_info_br_inst_mix_ipmispredict",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Ratio of all branches which mispredict",
-        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / BR_INST_RE=
TIRED.ALL_BRANCHES",
-        "MetricName": "tma_info_inst_mix_branch_mispredict_ratio",
+        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom@B=
R_INST_RETIRED.ALL_BRANCHES@",
+        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_rati=
o",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
-        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / BACLEARS.A=
NY",
-        "MetricName": "tma_info_inst_mix_branch_mispredict_to_unknown_bran=
ch_ratio",
+        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom@B=
ACLEARS.ANY@",
+        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_to_u=
nknown_branch_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are FPDiv uops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ / UOPS_RETIRED.A=
LL",
-        "MetricName": "tma_info_inst_mix_fpdiv_uop_ratio",
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
+        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.LD_BUF@ / cpu_at=
om@CPU_CLK_UNHALTED.CORE@",
+        "MetricName": "tma_info_buffer_stalls_%_load_buffer_stall_cycles",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are IDiv uops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ / UOPS_RETIRED.AL=
L",
-        "MetricName": "tma_info_inst_mix_idiv_uop_ratio",
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to memory reservation stations full",
+        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.RSV@ / cpu_atom@=
CPU_CLK_UNHALTED.CORE@",
+        "MetricName": "tma_info_buffer_stalls_%_mem_rsv_stall_cycles",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_INST_RETIRED.ALL_BR=
ANCHES",
-        "MetricName": "tma_info_inst_mix_ipbranch",
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to store buffer full",
+        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_at=
om@CPU_CLK_UNHALTED.CORE@",
+        "MetricName": "tma_info_buffer_stalls_%_store_buffer_stall_cycles"=
,
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_INST_RETIRED.CALL",
-        "MetricName": "tma_info_inst_mix_ipcall",
+        "BriefDescription": "Cycles Per Instruction",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@INST_RET=
IRED.ANY@",
+        "MetricName": "tma_info_core_cpi",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Far Branch",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_INST_RETI=
RED.FAR_BRANCH@ / 2)",
-        "MetricName": "tma_info_inst_mix_ipfarbranch",
+        "BriefDescription": "Instructions Per Cycle",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@CPU_CLK_UNHAL=
TED.CORE@",
+        "MetricName": "tma_info_core_ipc",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Load",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / MEM_UOPS_RETIRED.ALL_L=
OADS",
-        "MetricName": "tma_info_inst_mix_ipload",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricExpr": "cpu_atom@UOPS_RETIRED.ALL@ / cpu_atom@INST_RETIRED.=
ANY@",
+        "MetricName": "tma_info_core_upi",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_MISP_RETI=
RED.COND@ - cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)",
-        "MetricName": "tma_info_inst_mix_ipmisp_cond_ntaken",
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@ / cp=
u_atom@MEM_BOUND_STALLS.IFETCH@",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2hit",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was taken",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_MISP_RETIRED.COND_T=
AKEN",
-        "MetricName": "tma_info_inst_mix_ipmisp_cond_taken",
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ / c=
pu_atom@MEM_BOUND_STALLS.IFETCH@",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3hit",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per retired indirect call or jum=
p Branch Misprediction",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_MISP_RETIRED.INDIRE=
CT",
-        "MetricName": "tma_info_inst_mix_ipmisp_indirect",
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss subsequently misses in the L3",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ / =
cpu_atom@MEM_BOUND_STALLS.IFETCH@",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3miss",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per retired return Branch Mispre=
diction",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_MISP_RETIRED.RETURN=
",
-        "MetricName": "tma_info_inst_mix_ipmisp_ret",
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / cpu_=
atom@MEM_BOUND_STALLS.LOAD@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2hit=
",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per retired Branch Misprediction=
",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / BR_MISP_RETIRED.ALL_BR=
ANCHES",
-        "MetricName": "tma_info_inst_mix_ipmispredict",
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / cpu=
_atom@MEM_BOUND_STALLS.LOAD@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3hit=
",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Instructions per Store",
-        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / MEM_UOPS_RETIRED.ALL_S=
TORES",
-        "MetricName": "tma_info_inst_mix_ipstore",
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses the L3",
+        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / cp=
u_atom@MEM_BOUND_STALLS.LOAD@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3mis=
s",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are ucode ops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ / UOPS_RETIRED.ALL"=
,
-        "MetricName": "tma_info_inst_mix_microcode_uop_ratio",
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a pipeline block",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ / cpu_atom@=
CPU_CLK_UNHALTED.CORE@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_l1_bound",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of all uops which are x87 uops",
-        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ / UOPS_RETIRED.ALL=
",
-        "MetricName": "tma_info_inst_mix_x87_uop_ratio",
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement",
+        "MetricExpr": "100 * (cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ + cpu_atom=
@MEM_BOUND_STALLS.LOAD@) / cpu_atom@CPU_CLK_UNHALTED.CORE@",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_load_bound",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
-        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.4K_ALIAS@ / MEM_UOPS_RETIR=
ED.ALL_LOADS",
-        "MetricName": "tma_info_l1_bound_address_alias_blocks",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full",
+        "MetricExpr": "100 * (cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_a=
tom@MEM_SCHEDULER_BLOCK.ALL@) * tma_mem_scheduler",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_store_bound",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
-        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / MEM_=
UOPS_RETIRED.ALL_LOADS",
-        "MetricName": "tma_info_l1_bound_load_splits",
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to memory disambiguation",
+        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.DISAMBIGUATION@ / cpu=
_atom@INST_RETIRED.ANY@",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_disamb_=
pki",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / MEM_UOPS_R=
ETIRED.ALL_LOADS",
-        "MetricName": "tma_info_l1_bound_store_fwd_blocks",
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to floating point assists",
+        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.FP_ASSIST@ / cpu_atom=
@INST_RETIRED.ANY@",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_fp_assi=
st_pki",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Cycle cost per DRAM hit",
-        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / MEM_LOAD=
_UOPS_RETIRED.DRAM_HIT",
-        "MetricName": "tma_info_memory_cycles_per_demand_load_dram_hit",
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to memory ordering",
+        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.MEMORY_ORDERING@ / cp=
u_atom@INST_RETIRED.ANY@",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_monuke_=
pki",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Cycle cost per L2 hit",
-        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / MEM_LOAD_U=
OPS_RETIRED.L2_HIT",
-        "MetricName": "tma_info_memory_cycles_per_demand_load_l2_hit",
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to memory renaming",
+        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.MRN_NUKE@ / cpu_atom@=
INST_RETIRED.ANY@",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_mrn_pki=
",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Cycle cost per LLC hit",
-        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / MEM_LOAD_=
UOPS_RETIRED.L3_HIT",
-        "MetricName": "tma_info_memory_cycles_per_demand_load_l3_hit",
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to page faults",
+        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ / cpu_ato=
m@INST_RETIRED.ANY@",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_page_fa=
ult_pki",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "load ops retired per 1000 instruction",
-        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / INST_R=
ETIRED.ANY",
-        "MetricName": "tma_info_memory_memloadpki",
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to self-modifying code",
+        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.SMC@ / cpu_atom@INST_=
RETIRED.ANY@",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_smc_pki=
",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Average CPU Utilization",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
-        "MetricName": "tma_info_system_cpu_utilization",
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
+        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.4K_ALIAS@ / cpu_atom@MEM_U=
OPS_RETIRED.ALL_LOADS@",
+        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_adressaliasin=
g",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALTED=
.CORE",
-        "MetricGroup": "Summary",
-        "MetricName": "tma_info_system_kernel_utilization",
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
+        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / cpu_atom@M=
EM_UOPS_RETIRED.ALL_LOADS@",
+        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_storefwdblk",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "tma_info_core_clks / CPU_CLK_UNHALTED.REF_TSC",
-        "MetricGroup": "Power",
-        "MetricName": "tma_info_system_turbo_utilization",
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.L1_MISS_AT_RET@ / cpu_atom@L=
D_HEAD.ANY_AT_RET@",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_l1miss",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to Instruction Table Lookaside Buffer (ITL=
B) misses.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ITLB@ / tma_info_core_slo=
ts",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
-        "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of Memory Execution Bound due to o=
ther block cases, such as pipeline conflicts, fences, etc",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.OTHER_AT_RET@ / cpu_atom@LD_=
HEAD.ANY_AT_RET@",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_otherpipeli=
neblks",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a load block.",
-        "MetricExpr": "cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ / tma_info_core_c=
lks",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_l1_bound",
-        "MetricThreshold": "tma_l1_bound > 0.1",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 pagewalk",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.PGWALK_AT_RET@ / cpu_atom@LD=
_HEAD.ANY_AT_RET@",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_pagewalk",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the L2 Cache.",
-        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / tma_info_c=
ore_clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS_=
AT_RET@) / tma_info_core_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ =
/ cpu_atom@MEM_BOUND_STALLS.LOAD@",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.1",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 second level TLB miss",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ / cpu_atom=
@LD_HEAD.ANY_AT_RET@",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_stlbhit",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the Last Level Cache (LLC) or other core=
 with HITE/F/M.",
-        "MetricExpr": "cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / tma_info_=
core_clks - max((cpu_atom@MEM_BOUND_STALLS.LOAD@ - cpu_atom@LD_HEAD.L1_MISS=
_AT_RET@) / tma_info_core_clks, 0) * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT=
@ / cpu_atom@MEM_BOUND_STALLS.LOAD@",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.1",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 store forward address match",
+        "MetricExpr": "100 * cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ / cpu_atom@L=
D_HEAD.ANY_AT_RET@",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_storefwding=
",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to load buffer=
 full",
-        "MetricExpr": "tma_mem_scheduler * cpu_atom@MEM_SCHEDULER_BLOCK.LD=
_BUF@ / MEM_SCHEDULER_BLOCK.ALL",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
-        "MetricName": "tma_ld_buffer",
-        "MetricThreshold": "tma_ld_buffer > 0.05",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Instructions per Load",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RETI=
RED.ALL_LOADS@",
+        "MetricName": "tma_info_mem_mix_ipload",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
-        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@ / =
tma_info_core_slots",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
-        "MetricName": "tma_machine_clears",
-        "MetricThreshold": "tma_machine_clears > 0.05",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Instructions per Store",
+        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RETI=
RED.ALL_STORES@",
+        "MetricName": "tma_info_mem_mix_ipstore",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to memory reservation stalls in which a sche=
duler is not able to accept uops.",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ / tma_info=
_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_mem_scheduler",
-        "MetricThreshold": "tma_mem_scheduler > 0.1",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of total non-speculative loads tha=
t perform one or more locks",
+        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.LOCK_LOADS@ / cpu_a=
tom@MEM_UOPS_RETIRED.ALL_LOADS@",
+        "MetricName": "tma_info_mem_mix_load_locks_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to stores or loads.",
-        "MetricExpr": "min(tma_backend_bound, cpu_atom@LD_HEAD.ANY_AT_RET@=
 / tma_info_core_clks + tma_store_bound)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
-        "MetricName": "tma_memory_bound",
-        "MetricThreshold": "tma_memory_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
+        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / cpu_=
atom@MEM_UOPS_RETIRED.ALL_LOADS@",
+        "MetricName": "tma_info_mem_mix_load_splits_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory ordering.",
-        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.MEMORY_ORDERING=
@ / cpu_atom@MACHINE_CLEARS.SLOW@)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
-        "MetricName": "tma_memory_ordering",
-        "MetricThreshold": "tma_memory_ordering > 0.02",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Ratio of mem load uops to all uops",
+        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / cpu_at=
om@UOPS_RETIRED.ALL@",
+        "MetricName": "tma_info_mem_mix_memload_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS)",
-        "MetricExpr": "cpu_atom@UOPS_RETIRED.MS@ / tma_info_core_slots",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
-        "MetricName": "tma_ms_uops",
-        "MetricThreshold": "tma_ms_uops > 0.05",
-        "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "Counts the number of uops that are from the =
complex flows issued by the micro-sequencer (MS).  This includes uops from =
flows due to complex instructions, faults, assists, and inserted flows.",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
+        "MetricExpr": "100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (5 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricName": "tma_info_serialization _%_tpause_cycles",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to IEC or FPC RAT stalls, which can be due t=
o FIQ or IEC reservation stalls in which the integer, floating point or SIM=
D scheduler is not able to accept uops.",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER@ / tma_=
info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_non_mem_scheduler",
-        "MetricThreshold": "tma_non_mem_scheduler > 0.1",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Average CPU Utilization",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
+        "MetricName": "tma_info_system_cpu_utilization",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear (slow nuke).",
-        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.NUKE@ / tma_info_c=
ore_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
-        "MetricName": "tma_nuke",
-        "MetricThreshold": "tma_nuke > 0.05",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Fraction of cycles spent in Kernel mode",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE_P@k / cpu_atom@CPU_C=
LK_UNHALTED.CORE@",
+        "MetricGroup": "Summary",
+        "MetricName": "tma_info_system_kernel_utilization",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to other common frontend stalls not catego=
rized.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.OTHER@ / tma_info_core_sl=
ots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
-        "MetricName": "tma_other_fb",
-        "MetricThreshold": "tma_other_fb > 0.05",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
+        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@CPU_CLK_=
UNHALTED.REF_TSC@",
+        "MetricGroup": "Power",
+        "MetricName": "tma_info_system_turbo_utilization",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a number of other lo=
ad blocks.",
-        "MetricExpr": "cpu_atom@LD_HEAD.OTHER_AT_RET@ / tma_info_core_clks=
",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_other_l1",
-        "MetricThreshold": "tma_other_l1 > 0.05",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of all uops which are FPDiv uops",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ / cpu_atom@UOPS_=
RETIRED.ALL@",
+        "MetricName": "tma_info_uop_mix_fpdiv_uop_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hits in the L2, LLC, DRAM or MMIO (Non-D=
RAM) but could not be correctly attributed or cycles in which the load miss=
 is waiting on a request buffer.",
-        "MetricExpr": "max(0, tma_memory_bound - (tma_store_bound + tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound))",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_other_load_store",
-        "MetricThreshold": "tma_other_load_store > 0.1",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of all uops which are IDiv uops",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ / cpu_atom@UOPS_R=
ETIRED.ALL@",
+        "MetricName": "tma_info_uop_mix_idiv_uop_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of uops retired excluding m=
s and fp div uops.",
-        "MetricExpr": "(cpu_atom@TOPDOWN_RETIRING.ALL@ - cpu_atom@UOPS_RET=
IRED.MS@ - cpu_atom@UOPS_RETIRED.FPDIV@) / tma_info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
-        "MetricName": "tma_other_ret",
-        "MetricThreshold": "tma_other_ret > 0.3",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of all uops which are microcode op=
s",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ / cpu_atom@UOPS_RET=
IRED.ALL@",
+        "MetricName": "tma_info_uop_mix_microcode_uop_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to page faults.",
-        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ / c=
pu_atom@MACHINE_CLEARS.SLOW@)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
-        "MetricName": "tma_page_fault",
-        "MetricThreshold": "tma_page_fault > 0.02",
-        "ScaleUnit": "100%",
+        "BriefDescription": "Percentage of all uops which are x87 uops",
+        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ / cpu_atom@UOPS_RE=
TIRED.ALL@",
+        "MetricName": "tma_info_uop_mix_x87_uop_ratio",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to wrong predecodes.",
-        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.PREDECODE@ / tma_info_cor=
e_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
-        "MetricName": "tma_predecode",
-        "MetricThreshold": "tma_predecode > 0.05",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ITLB@ / (5 * cpu_atom@CPU=
_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricName": "tma_itlb_misses",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the physical register file unable to acce=
pt an entry (marble stalls).",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REGISTER@ / tma_info_core=
_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_register",
-        "MetricThreshold": "tma_register > 0.1",
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation",
+        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@ / =
(5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
+        "MetricName": "tma_machine_clears",
+        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
n > 0.15",
+        "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the reorder buffer being full (ROB stalls=
).",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REORDER_BUFFER@ / tma_inf=
o_core_slots",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to memory reservation stalls in which a sched=
uler is not able to accept uops",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ / (5 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_reorder_buffer",
-        "MetricThreshold": "tma_reorder_buffer > 0.1",
-        "ScaleUnit": "100%",
-        "Unit": "cpu_atom"
-    },
-    {
-        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
-        "MetricExpr": "tma_backend_bound",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_aux_group=
",
-        "MetricName": "tma_resource_bound",
-        "MetricThreshold": "tma_resource_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that uops mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.",
+        "MetricName": "tma_mem_scheduler",
+        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that result=
 in retirement slots.",
-        "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL@ / tma_info_core_slot=
s",
-        "MetricGroup": "Default;TopdownL1;tma_L1_group",
-        "MetricName": "tma_retiring",
-        "MetricThreshold": "tma_retiring > 0.75",
-        "MetricgroupNoGroup": "TopdownL1;Default",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to IEC or FPC RAT stalls, which can be due to=
 FIQ or IEC reservation stalls in which the integer, floating point or SIMD=
 scheduler is not able to accept uops",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER@ / (5 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_non_mem_scheduler",
+        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to RSV full re=
lative",
-        "MetricExpr": "tma_mem_scheduler * cpu_atom@MEM_SCHEDULER_BLOCK.RS=
V@ / MEM_SCHEDULER_BLOCK.ALL",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
-        "MetricName": "tma_rsv",
-        "MetricThreshold": "tma_rsv > 0.05",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that requires the use of m=
icrocode (slow nuke)",
+        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.NUKE@ / (5 * cpu_a=
tom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_nuke",
+        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to scoreboards from the instruction queue (I=
Q), jump execution unit (JEU), or microcode sequencer (MS).",
-        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.SERIALIZATION@ / tma_info=
_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
-        "MetricName": "tma_serialization",
-        "MetricThreshold": "tma_serialization > 0.1",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.OTHER@ / (5 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricName": "tma_other_fb",
+        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to SMC.",
-        "MetricExpr": "tma_nuke * (cpu_atom@MACHINE_CLEARS.SMC@ / cpu_atom=
@MACHINE_CLEARS.SLOW@)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
-        "MetricName": "tma_smc",
-        "MetricThreshold": "tma_smc > 0.02",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes.",
+        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.PREDECODE@ / (5 * cpu_ato=
m@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
+        "MetricName": "tma_predecode",
+        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to store buffe=
r full",
-        "MetricExpr": "tma_store_bound",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
-        "MetricName": "tma_st_buffer",
-        "MetricThreshold": "tma_st_buffer > 0.05",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the physical register file unable to accep=
t an entry (marble stalls)",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REGISTER@ / (5 * cpu_atom=
@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_register",
+        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a first level TLB mi=
ss.",
-        "MetricExpr": "cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ / tma_info_core_=
clks",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_stlb_hit",
-        "MetricThreshold": "tma_stlb_hit > 0.05",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the reorder buffer being full (ROB stalls)=
",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REORDER_BUFFER@ / (5 * cp=
u_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_reorder_buffer",
+        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a second level TLB m=
iss requiring a page walk.",
-        "MetricExpr": "cpu_atom@LD_HEAD.PGWALK_AT_RET@ / tma_info_core_clk=
s",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_stlb_miss",
-        "MetricThreshold": "tma_stlb_miss > 0.05",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a resource limitation",
+        "MetricExpr": "tma_backend_bound - tma_core_bound",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
+        "MetricName": "tma_resource_bound",
+        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
+        "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full.",
-        "MetricExpr": "tma_mem_scheduler * (cpu_atom@MEM_SCHEDULER_BLOCK.S=
T_BUF@ / cpu_atom@MEM_SCHEDULER_BLOCK.ALL@)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_store_bound",
-        "MetricThreshold": "tma_store_bound > 0.1",
+        "BriefDescription": "Counts the number of issue slots that result =
in retirement slots",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL@ / (5 * cpu_atom@CPU_=
CLK_UNHALTED.CORE@)",
+        "MetricGroup": "Default;TopdownL1;tma_L1_group",
+        "MetricName": "tma_retiring",
+        "MetricThreshold": "tma_retiring > 0.75",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a store forward bloc=
k.",
-        "MetricExpr": "cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ / tma_info_core_cl=
ks",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_store_fwd_blk",
-        "MetricThreshold": "tma_store_fwd_blk > 0.05",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to scoreboards from the instruction queue (IQ=
), jump execution unit (JEU), or microcode sequencer (MS)",
+        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.SERIALIZATION@ / (5 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
+        "MetricName": "tma_serialization",
+        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%",
         "Unit": "cpu_atom"
     },
@@ -818,7 +726,7 @@
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU retired uops delivered by the Microcode_Sequencer as a result of Assists=
",
         "MetricExpr": "78 * cpu_core@ASSISTS.ANY@ / tma_info_thread_slots"=
,
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_gro=
up",
+        "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequence=
r_group",
         "MetricName": "tma_assists",
         "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer >=
 0.05 & tma_heavy_operations > 0.1)",
         "PublicDescription": "This metric estimates fraction of slots the =
CPU retired uops delivered by the Microcode_Sequencer as a result of Assist=
s. Assists are long sequences of uops that are required in certain corner-c=
ases for operations that cannot be handled natively by the execution pipeli=
ne. For example; when working with very small floating point values (so-cal=
led Denormals); the FP units are not set up to perform these operations nat=
ively. Instead; a sequence of instructions to perform the computation on th=
e Denormals is injected into the pipeline. Since these microcode sequences =
might be dozens of uops long; Assists can be extremely deleterious to perfo=
rmance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
@@ -838,7 +746,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere no uops are being delivered due to a lack of required resources for acc=
epting new uops in the Backend",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
-        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "BvOB;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_backend_bound",
         "MetricThreshold": "tma_backend_bound > 0.2",
         "MetricgroupNoGroup": "TopdownL1;Default",
@@ -861,7 +769,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Branch Misprediction",
         "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@top=
down\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-re=
tiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
-        "MetricGroup": "BadSpec;BrMispredicts;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueBM",
+        "MetricGroup": "BadSpec;BrMispredicts;BvMP;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueBM",
         "MetricName": "tma_branch_mispredicts",
         "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specula=
tion > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
@@ -920,7 +828,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to contested acces=
ses",
         "MetricExpr": "(25 * tma_info_system_core_frequency * (cpu_core@ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP=
_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEM=
AND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) + 24 * tma_info_system_core_frequ=
ency * cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@) * (1 + cpu_core@MEM_LOA=
D_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thre=
ad_clks",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_l3_bound_group",
+        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_l3_bound_group",
         "MetricName": "tma_contested_accesses",
         "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_bound =
> 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to contested acce=
sses. Contested accesses occur when data written by one Logical Processor a=
re read by another Logical Processor on a different Physical Core. Examples=
 of contested accesses include synchronizations such as locks; true data sh=
aring such as modified locked variables; and false sharing. Sample with: ME=
M_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related m=
etrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma_remote=
_cache",
@@ -941,7 +849,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles whil=
e the memory subsystem was handling synchronizations due to data-sharing ac=
cesses",
         "MetricExpr": "24 * tma_info_system_core_frequency * (cpu_core@MEM=
_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_F=
WD@ * (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR.D=
EMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP=
_HIT_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@MEM_L=
OAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
-        "MetricGroup": "Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSync=
xn;tma_l3_bound_group",
+        "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issu=
eSyncxn;tma_l3_bound_group",
         "MetricName": "tma_data_sharing",
         "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whi=
le the memory subsystem was handling synchronizations due to data-sharing a=
ccesses. Data shared by multiple Logical Processors (even just read shared)=
 may cause increased access latency due to cache coherency. Excessive data =
sharing can drastically harm multithreaded performance. Sample with: MEM_LO=
AD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_contested_accesses, tma=
_false_sharing, tma_machine_clears, tma_remote_cache",
@@ -961,7 +869,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles whe=
re the Divider unit was active",
         "MetricExpr": "cpu_core@ARITH.DIV_ACTIVE@ / tma_info_thread_clks",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
+        "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group",
         "MetricName": "tma_divider",
         "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & tm=
a_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles wh=
ere the Divider unit was active. Divide and square root instructions are pe=
rformed by the Divider unit and can take considerably longer latency than i=
nteger or Floating Point addition; subtraction; or multiplication. Sample w=
ith: ARITH.DIVIDER_ACTIVE",
@@ -994,14 +902,14 @@
         "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetch_=
latency_group;tma_issueFB",
         "MetricName": "tma_dsb_switches",
         "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_mis=
ses, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to switches from DSB to MITE pipelines. The DSB (deco=
ded i-cache) is a Uop Cache where the front-end directly delivers Uops (mic=
ro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter la=
tency and delivered higher bandwidth than the MITE (legacy instruction deco=
de pipeline). Switching between the two pipelines can cause penalties hence=
 this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.DS=
B_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_ban=
dwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles where the Data TLB (DTLB) was missed by load accesses",
         "MetricExpr": "min(7 * cpu_core@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\=
\=3D1@ + cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@, max(cpu_core@CYCLE_ACTIVIT=
Y.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVITY.CYCLES_L1D_MISS@, 0)) / tma_in=
fo_thread_clks",
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
l1_bound_group",
+        "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_l1_bound_group",
         "MetricName": "tma_dtlb_load",
         "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & (t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates the fraction o=
f cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Trans=
lation Look-aside Buffers) are processor caches for recently used entries o=
ut of the Page Tables that are used to map virtual- to physical-addresses b=
y the operating system. This metric approximates the potential delay of dem=
and loads missing the first-level data TLB (assuming worst case scenario wi=
th back to back misses to different pages). This includes hitting in the se=
cond-level TLB (STLB) as well as performing a hardware page walk on an STLB=
 miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics: t=
ma_dtlb_store, tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_me=
mory_synchronization",
@@ -1011,7 +919,7 @@
     {
         "BriefDescription": "This metric roughly estimates the fraction of=
 cycles spent handling first-level data TLB store misses",
         "MetricExpr": "(7 * cpu_core@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=
=3D1@ + cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@) / tma_info_core_core_clks"=
,
-        "MetricGroup": "MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB;tma_=
store_bound_group",
+        "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueTLB=
;tma_store_bound_group",
         "MetricName": "tma_dtlb_store",
         "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0.2=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates the fraction o=
f cycles spent handling first-level data TLB store misses.  As with ordinar=
y data caching; focus on improving data locality and reducing working-set s=
ize to reduce DTLB overhead.  Additionally; consider using profile-guided o=
ptimization (PGO) to collocate frequently-used data on the same page.  Try =
using larger page sizes for large amounts of frequently-used data. Sample w=
ith: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load, =
tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_memory_synchroniz=
ation",
@@ -1021,7 +929,7 @@
     {
         "BriefDescription": "This metric roughly estimates how often CPU w=
as handling synchronizations due to False Sharing",
         "MetricExpr": "28 * tma_info_system_core_frequency * cpu_core@OCR.=
DEMAND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_thread_clks",
-        "MetricGroup": "DataSharing;Offcore;Snoop;TopdownL4;tma_L4_group;t=
ma_issueSyncxn;tma_store_bound_group",
+        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_gr=
oup;tma_issueSyncxn;tma_store_bound_group",
         "MetricName": "tma_false_sharing",
         "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric roughly estimates how often CPU =
was handling synchronizations due to False Sharing. False Sharing is a mult=
ithreading hiccup; where multiple Logical Processors contend on different d=
ata-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO.L=
3_HIT.SNOOP_HITM. Related metrics: tma_contested_accesses, tma_data_sharing=
, tma_machine_clears, tma_remote_cache",
@@ -1031,7 +939,7 @@
     {
         "BriefDescription": "This metric does a *rough estimation* of how =
often L1D Fill Buffer unavailability limited additional L1D miss memory acc=
ess requests to proceed",
         "MetricExpr": "cpu_core@L1D_PEND_MISS.FB_FULL@ / tma_info_thread_c=
lks",
-        "MetricGroup": "MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;tma_is=
sueSL;tma_issueSmSt;tma_l1_bound_group",
+        "MetricGroup": "BvMS;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW;t=
ma_issueSL;tma_issueSmSt;tma_l1_bound_group",
         "MetricName": "tma_fb_full",
         "MetricThreshold": "tma_fb_full > 0.3",
         "PublicDescription": "This metric does a *rough estimation* of how=
 often L1D Fill Buffer unavailability limited additional L1D miss memory ac=
cess requests to proceed. The higher the metric value; the deeper the memor=
y hierarchy level the misses are satisfied from (metric values >1 are valid=
). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache or=
 external memory). Related metrics: tma_info_bottleneck_cache_memory_bandwi=
dth, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store=
_latency, tma_streaming_stores",
@@ -1045,7 +953,7 @@
         "MetricName": "tma_fetch_bandwidth",
         "MetricThreshold": "tma_fetch_bandwidth > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_=
info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "This metric represents fraction of slots the=
 CPU was stalled due to Frontend bandwidth issues.  For example; inefficien=
cies at the instruction decoders; or restrictions for caching in the DSB (d=
ecoded uops cache) are categorized under Fetch Bandwidth. In such cases; th=
e Frontend typically delivers suboptimal amount of uops to the Backend. Sam=
ple with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.LA=
TENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_sw=
itches, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -1092,7 +1000,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) scalar uops fraction the CPU has retired",
-        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE\\,umas=
k\\=3D0x03@ / (tma_retiring * tma_info_thread_slots)",
+        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ / (tma_retir=
ing * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_scalar",
         "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -1102,7 +1010,7 @@
     },
     {
         "BriefDescription": "This metric approximates arithmetic floating-=
point (FP) vector uops fraction the CPU has retired aggregated across all v=
ector widths",
-        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE\\=
,umask\\=3D0x3c@ / (tma_retiring * tma_info_thread_slots)",
+        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.VECTOR@ / (tma_retir=
ing * tma_info_thread_slots)",
         "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arith_=
group;tma_issue2P",
         "MetricName": "tma_fp_vector",
         "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
@@ -1134,7 +1042,7 @@
         "BriefDescription": "This category represents fraction of slots wh=
ere the processor's Frontend undersupplies its Backend",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / tm=
a_info_thread_slots",
-        "MetricGroup": "Default;PGO;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "BvFB;BvIO;Default;PGO;TmaL1;TopdownL1;tma_L1_group=
",
         "MetricName": "tma_frontend_bound",
         "MetricThreshold": "tma_frontend_bound > 0.15",
         "MetricgroupNoGroup": "TopdownL1;Default",
@@ -1145,7 +1053,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring fused instructions -- where one uop can represent mu=
ltiple contiguous instructions",
         "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.MACRO_=
FUSED@ / (tma_retiring * tma_info_thread_slots)",
-        "MetricGroup": "Branches;Pipeline;TopdownL3;tma_L3_group;tma_light=
_operations_group",
+        "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_fused_instructions",
         "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_opera=
tions > 0.6",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring fused instructions -- where one uop can represent m=
ultiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of =
legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under Ot=
her_Light_Ops in MTL!)}",
@@ -1166,7 +1074,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to instruction cache misses",
         "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / tma_info_thread_clks=
",
-        "MetricGroup": "BigFootprint;FetchLat;IcMiss;TopdownL3;tma_L3_grou=
p;tma_fetch_latency_group",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_L3=
_group;tma_fetch_latency_group",
         "MetricName": "tma_icache_misses",
         "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to instruction cache misses. Sample with: FRONTEND_RE=
TIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
@@ -1183,7 +1091,7 @@
     },
     {
         "BriefDescription": "Instructions per retired mispredicts for cond=
itional non-taken branches (lower number means higher occurrence rate).",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_MISP_RETIRED.COND_N=
TAKEN",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.COND_NTAKEN@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200",
@@ -1191,7 +1099,7 @@
     },
     {
         "BriefDescription": "Instructions per retired mispredicts for cond=
itional taken branches (lower number means higher occurrence rate).",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_MISP_RETIRED.COND_T=
AKEN",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.COND_TAKEN@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200",
@@ -1199,7 +1107,7 @@
     },
     {
         "BriefDescription": "Instructions per retired mispredicts for indi=
rect CALL or JMP branches (lower number means higher occurrence rate).",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_MISP_RETIRED.INDIRE=
CT",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.INDIRECT@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_indirect",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3",
@@ -1207,7 +1115,7 @@
     },
     {
         "BriefDescription": "Instructions per retired mispredicts for retu=
rn branches (lower number means higher occurrence rate).",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_MISP_RETIRED.RET",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.RET@",
         "MetricGroup": "Bad;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmisp_ret",
         "MetricThreshold": "tma_info_bad_spec_ipmisp_ret < 500",
@@ -1215,7 +1123,7 @@
     },
     {
         "BriefDescription": "Number of Instructions per non-speculative Br=
anch Misprediction (JEClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_MISP_RETIRED.ALL_BR=
ANCHES",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RETIR=
ED.ALL_BRANCHES@",
         "MetricGroup": "Bad;BadSpec;BrMispredicts",
         "MetricName": "tma_info_bad_spec_ipmispredict",
         "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200",
@@ -1236,13 +1144,22 @@
         "MetricThreshold": "tma_info_botlnk_l0_core_bound_likely > 0.5",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Total pipeline cost of DSB (uop cache) hits -=
 subset of the Instruction_Fetch_BW Bottleneck",
+        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth / =
(tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_lsd =
+ tma_mite)))",
+        "MetricGroup": "DSB;FetchBW;tma_issueFB",
+        "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
+        "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) hits =
- subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb_s=
witches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_front=
end_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Total pipeline cost of DSB (uop cache) misses=
 - subset of the Instruction_Fetch_BW Bottleneck",
         "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tma_=
branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + =
tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + tm=
a_lsd + tma_mite))",
         "MetricGroup": "DSBmiss;Fed;tma_issueFB",
         "MetricName": "tma_info_botlnk_l2_dsb_misses",
         "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
-        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_frontend_dsb_coverage, tma_info_in=
st_mix_iptb, tma_lcp",
+        "PublicDescription": "Total pipeline cost of DSB (uop cache) misse=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_=
frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
         "Unit": "cpu_core"
     },
     {
@@ -1254,34 +1171,27 @@
         "PublicDescription": "Total pipeline cost of Instruction Cache mis=
ses - subset of the Big_Code Bottleneck. Related metrics: ",
         "Unit": "cpu_core"
     },
-    {
-        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the baseline operations not covered by Branching_Overhead nor Irregular_O=
verhead.",
-        "MetricExpr": "100 * (tma_retiring - (cpu_core@BR_INST_RETIRED.ALL=
_BRANCHES@ + cpu_core@BR_INST_RETIRED.NEAR_CALL@) / tma_info_thread_slots -=
 tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_seque=
ncer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
-        "MetricGroup": "Ret",
-        "MetricName": "tma_info_bottleneck_base_non_br",
-        "MetricThreshold": "tma_info_bottleneck_base_non_br > 20",
-        "Unit": "cpu_core"
-    },
     {
         "BriefDescription": "Total pipeline cost of instruction fetch rela=
ted bottlenecks by large code footprint programs (i-side cache; TLB and BTB=
 misses)",
         "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_ic=
ache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_switch=
es + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
-        "MetricGroup": "BigFootprint;Fed;Frontend;IcMiss;MemoryTLB",
+        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
         "MetricName": "tma_info_bottleneck_big_code",
         "MetricThreshold": "tma_info_bottleneck_big_code > 20",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of branch related instruc=
tions (used for program control-flow including function calls)",
-        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ + cp=
u_core@BR_INST_RETIRED.NEAR_CALL@) / tma_info_thread_slots)",
-        "MetricGroup": "Ret",
+        "BriefDescription": "Total pipeline cost of instructions used for =
program control-flow - a subset of the Retiring category in TMA",
+        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ + 2 =
* cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRED.NOP@) / tma_i=
nfo_thread_slots)",
+        "MetricGroup": "BvBO;Ret",
         "MetricName": "tma_info_bottleneck_branching_overhead",
         "MetricThreshold": "tma_info_bottleneck_branching_overhead > 5",
+        "PublicDescription": "Total pipeline cost of instructions used for=
 program control-flow - a subset of the Retiring category in TMA. Examples =
include function calls; loops and alignments. (A lower bound)",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Bandwidth related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_lock=
_latency + tma_split_loads + tma_store_fwd_blk)))",
-        "MetricGroup": "Mem;MemoryBW;Offcore;tma_issueBW",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (tm=
a_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound +=
 tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1_h=
it_latency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
+        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
         "MetricName": "tma_info_bottleneck_cache_memory_bandwidth",
         "MetricThreshold": "tma_info_bottleneck_cache_memory_bandwidth > 2=
0",
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_info_=
system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
@@ -1289,8 +1199,8 @@
     },
     {
         "BriefDescription": "Total pipeline cost of external Memory- or Ca=
che-Latency related bottlenecks",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_store_bound / (tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tm=
a_store_latency + tma_streaming_stores)))",
-        "MetricGroup": "Mem;MemoryLat;Offcore;tma_issueLat",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) *=
 (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_bou=
nd * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3=
_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesses =
+ tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound =
* tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bou=
nd + tma_store_bound) + tma_memory_bound * (tma_store_bound / (tma_dram_bou=
nd + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_=
store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tm=
a_store_latency + tma_streaming_stores)) + tma_memory_bound * (tma_l1_bound=
 / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store=
_bound)) * (tma_l1_hit_latency / (tma_dtlb_load + tma_fb_full + tma_l1_hit_=
latency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
+        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
         "MetricName": "tma_info_bottleneck_cache_memory_latency",
         "MetricThreshold": "tma_info_bottleneck_cache_memory_latency > 20"=
,
         "PublicDescription": "Total pipeline cost of external Memory- or C=
ache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tma_=
mem_latency",
@@ -1299,16 +1209,16 @@
     {
         "BriefDescription": "Total pipeline cost when the execution is com=
pute-bound - an estimation",
         "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divider =
+ tma_ports_utilization + tma_serializing_operation) + tma_core_bound * (tm=
a_ports_utilization / (tma_divider + tma_ports_utilization + tma_serializin=
g_operation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_ports_=
utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
-        "MetricGroup": "Cor;tma_issueComp",
+        "MetricGroup": "BvCB;Cor;tma_issueComp",
         "MetricName": "tma_info_bottleneck_compute_bound_est",
         "MetricThreshold": "tma_info_bottleneck_compute_bound_est > 20",
         "PublicDescription": "Total pipeline cost when the execution is co=
mpute-bound - an estimation. Covers Core Bound when High ILP as well as whe=
n long-latency execution units are busy. Related metrics: ",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks",
+        "BriefDescription": "Total pipeline cost of instruction fetch band=
width related bottlenecks (when the front-end could not sustain operations =
delivery to the back-end)",
         "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microcode=
_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_la=
tency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switches =
+ tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 - c=
pu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D=
1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_cl=
ears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_bran=
ch_mispredicts) / (tma_clears_resteers + tma_mispredicts_resteers + tma_unk=
nown_branches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_miss=
es + tma_itlb_misses + tma_lcp + tma_ms_switches))) - tma_info_bottleneck_b=
ig_code",
-        "MetricGroup": "Fed;FetchBW;Frontend",
+        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
         "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
         "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 20"=
,
         "Unit": "cpu_core"
@@ -1316,7 +1226,7 @@
     {
         "BriefDescription": "Total pipeline cost of irregular execution (e=
.g",
         "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ / =
cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_swi=
tches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_restee=
rs * tma_other_mispredicts / tma_branch_mispredicts) / (tma_clears_resteers=
 + tma_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_resteers=
 + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_m=
s_switches)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_b=
ranch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_other=
_nukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + cp=
u_core@RS.EMPTY\\,umask\\=3D1@ / tma_info_thread_clks * tma_ports_utilized_=
0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) + tm=
a_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequence=
r) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
-        "MetricGroup": "Bad;Cor;Ret;tma_issueMS",
+        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
         "MetricName": "tma_info_bottleneck_irregular_overhead",
         "MetricThreshold": "tma_info_bottleneck_irregular_overhead > 10",
         "PublicDescription": "Total pipeline cost of irregular execution (=
e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workloa=
ds, overhead in system services or virtualized environments). Related metri=
cs: tma_microcode_sequencer, tma_ms_switches",
@@ -1324,8 +1234,8 @@
     },
     {
         "BriefDescription": "Total pipeline cost of Memory Address Transla=
tion related bottlenecks (data-side TLBs)",
-        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_=
fb_full + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)) + tma_me=
mory_bound * (tma_store_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bou=
nd + tma_l3_bound + tma_store_bound)) * (tma_dtlb_store / (tma_dtlb_store +=
 tma_false_sharing + tma_split_stores + tma_store_latency + tma_streaming_s=
tores)))",
-        "MetricGroup": "Mem;MemoryTLB;Offcore;tma_issueTLB",
+        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma_m=
emory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + =
tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tma_=
fb_full + tma_l1_hit_latency + tma_lock_latency + tma_split_loads + tma_sto=
re_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_dram_bound + tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_dtlb_stor=
e / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_late=
ncy + tma_streaming_stores)))",
+        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
         "MetricName": "tma_info_bottleneck_memory_data_tlbs",
         "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
         "PublicDescription": "Total pipeline cost of Memory Address Transl=
ation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_load,=
 tma_dtlb_store, tma_info_bottleneck_memory_synchronization",
@@ -1334,7 +1244,7 @@
     {
         "BriefDescription": "Total pipeline cost of Memory Synchronization=
 related bottlenecks (data transfers and coherency updates across processor=
s)",
         "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_dram=
_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * (t=
ma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma_d=
ata_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_stores =
+ tma_store_latency + tma_streaming_stores - tma_store_latency)) + tma_mach=
ine_clears * (1 - tma_other_nukes / tma_other_nukes))",
-        "MetricGroup": "Mem;Offcore;tma_issueTLB",
+        "MetricGroup": "BvMS;Mem;Offcore;tma_issueTLB",
         "MetricName": "tma_info_bottleneck_memory_synchronization",
         "MetricThreshold": "tma_info_bottleneck_memory_synchronization > 1=
0",
         "PublicDescription": "Total pipeline cost of Memory Synchronizatio=
n related bottlenecks (data transfers and coherency updates across processo=
rs). Related metrics: tma_dtlb_load, tma_dtlb_store, tma_info_bottleneck_me=
mory_data_tlbs",
@@ -1343,45 +1253,53 @@
     {
         "BriefDescription": "Total pipeline cost of Branch Misprediction r=
elated bottlenecks",
         "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_other=
_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fetc=
h_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switc=
hes + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
-        "MetricGroup": "Bad;BadSpec;BrMispredicts;tma_issueBM",
+        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
         "MetricName": "tma_info_bottleneck_mispredictions",
         "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
         "PublicDescription": "Total pipeline cost of Branch Misprediction =
related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_bad_=
spec_branch_misprediction_cost, tma_mispredicts_resteers",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
(apart from those listed in the Info.Bottlenecks metrics class)",
-        "MetricExpr": "100 - (tma_info_bottleneck_big_code + tma_info_bott=
leneck_instruction_fetch_bw + tma_info_bottleneck_mispredictions + tma_info=
_bottleneck_cache_memory_bandwidth + tma_info_bottleneck_cache_memory_laten=
cy + tma_info_bottleneck_memory_data_tlbs + tma_info_bottleneck_memory_sync=
hronization + tma_info_bottleneck_compute_bound_est + tma_info_bottleneck_i=
rregular_overhead + tma_info_bottleneck_branching_overhead + tma_info_bottl=
eneck_base_non_br)",
-        "MetricGroup": "Cor;Offcore",
+        "BriefDescription": "Total pipeline cost of remaining bottlenecks =
in the back-end",
+        "MetricExpr": "100 - (tma_info_bottleneck_big_code + tma_info_bott=
leneck_instruction_fetch_bw + tma_info_bottleneck_mispredictions + tma_info=
_bottleneck_cache_memory_bandwidth + tma_info_bottleneck_cache_memory_laten=
cy + tma_info_bottleneck_memory_data_tlbs + tma_info_bottleneck_memory_sync=
hronization + tma_info_bottleneck_compute_bound_est + tma_info_bottleneck_i=
rregular_overhead + tma_info_bottleneck_branching_overhead + tma_info_bottl=
eneck_useful_work)",
+        "MetricGroup": "BvOB;Cor;Offcore",
         "MetricName": "tma_info_bottleneck_other_bottlenecks",
         "MetricThreshold": "tma_info_bottleneck_other_bottlenecks > 20",
-        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 (apart from those listed in the Info.Bottlenecks metrics class). Examples =
include data-dependencies (Core Bound when Low ILP) and other unlisted memo=
ry-related stalls.",
+        "PublicDescription": "Total pipeline cost of remaining bottlenecks=
 in the back-end. Examples include data-dependencies (Core Bound when Low I=
LP) and other unlisted memory-related stalls.",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Total pipeline cost of \"useful operations\" =
- the portion of Retiring category not covered by Branching_Overhead nor Ir=
regular_Overhead.",
+        "MetricExpr": "100 * (tma_retiring - (cpu_core@BR_INST_RETIRED.ALL=
_BRANCHES@ + 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRE=
D.NOP@) / tma_info_thread_slots - tma_microcode_sequencer / (tma_few_uops_i=
nstructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_seque=
ncer) * tma_heavy_operations)",
+        "MetricGroup": "BvUW;Ret",
+        "MetricName": "tma_info_bottleneck_useful_work",
+        "MetricThreshold": "tma_info_bottleneck_useful_work > 20",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of branches that are CALL or RET",
-        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@BR_=
INST_RETIRED.NEAR_RETURN@) / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@BR_=
INST_RETIRED.NEAR_RETURN@) / cpu_core@BR_INST_RETIRED.ALL_BRANCHES@",
         "MetricGroup": "Bad;Branches",
         "MetricName": "tma_info_branches_callret",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of branches that are non-taken condi=
tionals",
-        "MetricExpr": "cpu_core@BR_INST_RETIRED.COND_NTAKEN@ / BR_INST_RET=
IRED.ALL_BRANCHES",
+        "MetricExpr": "cpu_core@BR_INST_RETIRED.COND_NTAKEN@ / cpu_core@BR=
_INST_RETIRED.ALL_BRANCHES@",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
         "MetricName": "tma_info_branches_cond_nt",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of branches that are taken condition=
als",
-        "MetricExpr": "cpu_core@BR_INST_RETIRED.COND_TAKEN@ / BR_INST_RETI=
RED.ALL_BRANCHES",
+        "MetricExpr": "cpu_core@BR_INST_RETIRED.COND_TAKEN@ / cpu_core@BR_=
INST_RETIRED.ALL_BRANCHES@",
         "MetricGroup": "Bad;Branches;CodeGen;PGO",
         "MetricName": "tma_info_branches_cond_tk",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of branches that are unconditional (=
direct or indirect) jumps",
-        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu_core@BR=
_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@) / BR_I=
NST_RETIRED.ALL_BRANCHES",
+        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu_core@BR=
_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@) / cpu_=
core@BR_INST_RETIRED.ALL_BRANCHES@",
         "MetricGroup": "Bad;Branches",
         "MetricName": "tma_info_branches_jump",
         "Unit": "cpu_core"
@@ -1442,7 +1360,7 @@
         "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
         "MetricName": "tma_info_frontend_dsb_coverage",
         "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_inf=
o_thread_ipc / 6 > 0.35",
-        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_inst_mix_iptb, tma_lcp",
+        "PublicDescription": "Fraction of Uops delivered by the DSB (aka D=
ecoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_inst_mix_iptb, tma_lcp",
         "Unit": "cpu_core"
     },
     {
@@ -1468,7 +1386,7 @@
     },
     {
         "BriefDescription": "Instructions per non-speculative DSB miss (lo=
wer number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / FRONTEND_RETIRED.ANY_D=
SB_MISS",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FRONTEND_RETI=
RED.ANY_DSB_MISS@",
         "MetricGroup": "DSBmiss;Fed",
         "MetricName": "tma_info_frontend_ipdsb_miss_ret",
         "MetricThreshold": "tma_info_frontend_ipdsb_miss_ret < 50",
@@ -1476,21 +1394,21 @@
     },
     {
         "BriefDescription": "Instructions per speculative Unknown Branch M=
isprediction (BAClear) (lower number means higher occurrence rate)",
-        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
+        "MetricExpr": "tma_info_inst_mix_instructions / cpu_core@BACLEARS.=
ANY@",
         "MetricGroup": "Fed",
         "MetricName": "tma_info_frontend_ipunknown_branch",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache true code cacheline misses per kilo =
instruction",
-        "MetricExpr": "1e3 * cpu_core@FRONTEND_RETIRED.L2_MISS@ / INST_RET=
IRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@FRONTEND_RETIRED.L2_MISS@ / cpu_core=
@INST_RETIRED.ANY@",
         "MetricGroup": "IcMiss",
         "MetricName": "tma_info_frontend_l2mpki_code",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache speculative code cacheline misses pe=
r kilo instruction",
-        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.CODE_RD_MISS@ / INST_RETIRE=
D.ANY",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.CODE_RD_MISS@ / cpu_core@IN=
ST_RETIRED.ANY@",
         "MetricGroup": "IcMiss",
         "MetricName": "tma_info_frontend_l2mpki_code_all",
         "Unit": "cpu_core"
@@ -1512,7 +1430,7 @@
     },
     {
         "BriefDescription": "Branch instructions per taken branch.",
-        "MetricExpr": "cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ / BR_INST_RE=
TIRED.NEAR_TAKEN",
+        "MetricExpr": "cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ / cpu_core@B=
R_INST_RETIRED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_bptkbranch",
         "Unit": "cpu_core"
@@ -1527,7 +1445,7 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic instruction (l=
ower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.SCALAR_SINGLE\\,umask\\=3D0x03@ + cpu_core@FP_ARITH_INST_RETIRED.=
128B_PACKED_DOUBLE\\,umask\\=3D0x3c@)",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INS=
T_RETIRED.SCALAR@ + cpu_core@FP_ARITH_INST_RETIRED.VECTOR@)",
         "MetricGroup": "Flops;InsType",
         "MetricName": "tma_info_inst_mix_iparith",
         "MetricThreshold": "tma_info_inst_mix_iparith < 10",
@@ -1554,7 +1472,7 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Double-=
Precision instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / FP_ARITH_INST_RETIRED.=
SCALAR_DOUBLE",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FP_ARITH_INST=
_RETIRED.SCALAR_DOUBLE@",
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
@@ -1563,7 +1481,7 @@
     },
     {
         "BriefDescription": "Instructions per FP Arithmetic Scalar Single-=
Precision instruction (lower number means higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / FP_ARITH_INST_RETIRED.=
SCALAR_SINGLE",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FP_ARITH_INST=
_RETIRED.SCALAR_SINGLE@",
         "MetricGroup": "Flops;FpScalar;InsType",
         "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
         "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
@@ -1572,7 +1490,7 @@
     },
     {
         "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_INST_RETIRED.ALL_BR=
ANCHES",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.ALL_BRANCHES@",
         "MetricGroup": "Branches;Fed;InsType",
         "MetricName": "tma_info_inst_mix_ipbranch",
         "MetricThreshold": "tma_info_inst_mix_ipbranch < 8",
@@ -1580,7 +1498,7 @@
     },
     {
         "BriefDescription": "Instructions per (near) call (lower number me=
ans higher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_INST_RETIRED.NEAR_C=
ALL",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.NEAR_CALL@",
         "MetricGroup": "Branches;Fed;PGO",
         "MetricName": "tma_info_inst_mix_ipcall",
         "MetricThreshold": "tma_info_inst_mix_ipcall < 200",
@@ -1596,7 +1514,7 @@
     },
     {
         "BriefDescription": "Instructions per Load (lower number means hig=
her occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / MEM_INST_RETIRED.ALL_L=
OADS",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@MEM_INST_RETI=
RED.ALL_LOADS@",
         "MetricGroup": "InsType",
         "MetricName": "tma_info_inst_mix_ipload",
         "MetricThreshold": "tma_info_inst_mix_ipload < 3",
@@ -1604,14 +1522,14 @@
     },
     {
         "BriefDescription": "Instructions per PAUSE (lower number means hi=
gher occurrence rate)",
-        "MetricExpr": "tma_info_inst_mix_instructions / CPU_CLK_UNHALTED.P=
AUSE_INST",
+        "MetricExpr": "tma_info_inst_mix_instructions / cpu_core@CPU_CLK_U=
NHALTED.PAUSE_INST@",
         "MetricGroup": "Flops;FpVector;InsType",
         "MetricName": "tma_info_inst_mix_ippause",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Instructions per Store (lower number means hi=
gher occurrence rate)",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / MEM_INST_RETIRED.ALL_S=
TORES",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@MEM_INST_RETI=
RED.ALL_STORES@",
         "MetricGroup": "InsType",
         "MetricName": "tma_info_inst_mix_ipstore",
         "MetricThreshold": "tma_info_inst_mix_ipstore < 8",
@@ -1626,12 +1544,12 @@
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / BR_INST_RETIRED.NEAR_T=
AKEN",
+        "BriefDescription": "Instructions per taken branch",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RETIR=
ED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
         "MetricName": "tma_info_inst_mix_iptb",
         "MetricThreshold": "tma_info_inst_mix_iptb < 13",
-        "PublicDescription": "Instruction per taken branch. Related metric=
s: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tm=
a_info_frontend_dsb_coverage, tma_lcp",
+        "PublicDescription": "Instructions per taken branch. Related metri=
cs: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth=
, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp",
         "Unit": "cpu_core"
     },
     {
@@ -1664,13 +1582,13 @@
     },
     {
         "BriefDescription": "Fill Buffer (FB) hits per kilo instructions f=
or retired demand loads (L1D misses that merge into ongoing miss-handling e=
ntries)",
-        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / INST_RETI=
RED.ANY",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@=
INST_RETIRED.ANY@",
         "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_fb_hpki",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L1 data cache [GB / sec]",
         "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / duration_tim=
e",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l1d_cache_fill_bw",
@@ -1678,20 +1596,20 @@
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / INST_RET=
IRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / cpu_core=
@INST_RETIRED.ANY@",
         "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l1mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L1 cache true misses per kilo instruction for=
 all demand loads (including speculative)",
-        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.ALL_DEMAND_DATA_RD@ / INST_=
RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.ALL_DEMAND_DATA_RD@ / cpu_c=
ore@INST_RETIRED.ANY@",
         "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l1mpki_load",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L2 cache [GB / sec]",
         "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / duration_tim=
e",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l2_cache_fill_bw",
@@ -1699,48 +1617,55 @@
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all re=
quest types (including speculative)",
-        "MetricExpr": "1e3 * (cpu_core@L2_RQSTS.REFERENCES@ - cpu_core@L2_=
RQSTS.MISS@) / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * (cpu_core@L2_RQSTS.REFERENCES@ - cpu_core@L2_=
RQSTS.MISS@) / cpu_core@INST_RETIRED.ANY@",
         "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l2hpki_all",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache hits per kilo instruction for all de=
mand loads  (including speculative)",
-        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_HIT@ / INST_=
RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_HIT@ / cpu_c=
ore@INST_RETIRED.ANY@",
         "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l2hpki_load",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L2_MISS@ / INST_RET=
IRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L2_MISS@ / cpu_core=
@INST_RETIRED.ANY@",
         "MetricGroup": "Backend;CacheHits;Mem",
         "MetricName": "tma_info_memory_l2mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all request types (including speculative)",
-        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.MISS@ / INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.MISS@ / cpu_core@INST_RETIR=
ED.ANY@",
         "MetricGroup": "CacheHits;Mem;Offcore",
         "MetricName": "tma_info_memory_l2mpki_all",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "L2 cache ([RKL+] true) misses per kilo instru=
ction for all demand loads  (including speculative)",
-        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_MISS@ / INST=
_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_MISS@ / cpu_=
core@INST_RETIRED.ANY@",
         "MetricGroup": "CacheHits;Mem",
         "MetricName": "tma_info_memory_l2mpki_load",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Offcore requests (L2 cache miss) per kilo ins=
truction for demand RFOs",
+        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.RFO_MISS@ / cpu_core@INST_R=
ETIRED.ANY@",
+        "MetricGroup": "CacheMisses;Offcore",
+        "MetricName": "tma_info_memory_l2mpki_rfo",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average per-thread data access bandwidth to t=
he L3 cache [GB / sec]",
         "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e9 =
/ duration_time",
         "MetricGroup": "Mem;MemoryBW;Offcore",
         "MetricName": "tma_info_memory_l3_cache_access_bw",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Average per-thread data fill bandwidth to the=
 L3 cache [GB / sec]",
         "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / durat=
ion_time",
         "MetricGroup": "Mem;MemoryBW",
         "MetricName": "tma_info_memory_l3_cache_fill_bw",
@@ -1748,21 +1673,21 @@
     },
     {
         "BriefDescription": "L3 cache true misses per kilo instruction for=
 retired demand loads",
-        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L3_MISS@ / INST_RET=
IRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L3_MISS@ / cpu_core=
@INST_RETIRED.ANY@",
         "MetricGroup": "Mem",
         "MetricName": "tma_info_memory_l3mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Parallel L2 cache miss data reads",
-        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DATA_RD@ / OF=
FCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DATA_RD@ / cp=
u_core@OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@",
         "MetricGroup": "Memory_BW;Offcore",
         "MetricName": "tma_info_memory_latency_data_l2_mlp",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average Latency for L2 cache miss demand Load=
s",
-        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / OFFCORE_REQUESTS.DEMAND_DATA_RD",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_R=
D@ / cpu_core@OFFCORE_REQUESTS.DEMAND_DATA_RD@",
         "MetricGroup": "Memory_Lat;Offcore",
         "MetricName": "tma_info_memory_latency_load_l2_miss_latency",
         "Unit": "cpu_core"
@@ -1776,35 +1701,35 @@
     },
     {
         "BriefDescription": "Average Latency for L3 cache miss demand Load=
s",
-        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAN=
D_DATA_RD@ / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
+        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAN=
D_DATA_RD@ / cpu_core@OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD@",
         "MetricGroup": "Memory_Lat;Offcore",
         "MetricName": "tma_info_memory_latency_load_l3_miss_latency",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Actual Average Latency for L1 data-cache miss=
 demand load operations (in core cycles)",
-        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / MEM_LOAD_COMPLETE=
D.L1_MISS_ANY",
+        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / cpu_core@MEM_LOAD=
_COMPLETED.L1_MISS_ANY@",
         "MetricGroup": "Mem;MemoryBound;MemoryLat",
         "MetricName": "tma_info_memory_load_miss_real_latency",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "\"Bus lock\" per kilo instruction",
-        "MetricExpr": "1e3 * cpu_core@SQ_MISC.BUS_LOCK@ / INST_RETIRED.ANY=
",
+        "MetricExpr": "1e3 * cpu_core@SQ_MISC.BUS_LOCK@ / cpu_core@INST_RE=
TIRED.ANY@",
         "MetricGroup": "Mem",
         "MetricName": "tma_info_memory_mix_bus_lock_pki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Un-cacheable retired load per kilo instructio=
n",
-        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_MISC_RETIRED.UC@ / INST_RET=
IRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_MISC_RETIRED.UC@ / cpu_core=
@INST_RETIRED.ANY@",
         "MetricGroup": "Mem",
         "MetricName": "tma_info_memory_mix_uc_load_pki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Memory-Level-Parallelism (average number of L=
1 miss demand load when there is at least one such miss",
-        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / L1D_PEND_MISS.PEN=
DING_CYCLES",
+        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / cpu_core@L1D_PEND=
_MISS.PENDING_CYCLES@",
         "MetricGroup": "Mem;MemoryBW;MemoryBound",
         "MetricName": "tma_info_memory_mlp",
         "PublicDescription": "Memory-Level-Parallelism (average number of =
L1 miss demand load when there is at least one such miss. Per-Logical Proce=
ssor)",
@@ -1812,14 +1737,14 @@
     },
     {
         "BriefDescription": "STLB (2nd level TLB) code speculative misses =
per kilo instruction (misses of any page-size that complete the page walk)"=
,
-        "MetricExpr": "1e3 * cpu_core@ITLB_MISSES.WALK_COMPLETED@ / INST_R=
ETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@ITLB_MISSES.WALK_COMPLETED@ / cpu_co=
re@INST_RETIRED.ANY@",
         "MetricGroup": "Fed;MemoryTLB",
         "MetricName": "tma_info_memory_tlb_code_stlb_mpki",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data load speculative mi=
sses per kilo instruction (misses of any page-size that complete the page w=
alk)",
-        "MetricExpr": "1e3 * cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED@ / I=
NST_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED@ / c=
pu_core@INST_RETIRED.ANY@",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "tma_info_memory_tlb_load_stlb_mpki",
         "Unit": "cpu_core"
@@ -1834,21 +1759,42 @@
     },
     {
         "BriefDescription": "STLB (2nd level TLB) data store speculative m=
isses per kilo instruction (misses of any page-size that complete the page =
walk)",
-        "MetricExpr": "1e3 * cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED@ / =
INST_RETIRED.ANY",
+        "MetricExpr": "1e3 * cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED@ / =
cpu_core@INST_RETIRED.ANY@",
         "MetricGroup": "Mem;MemoryTLB",
         "MetricName": "tma_info_memory_tlb_store_stlb_mpki",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "",
+        "BriefDescription": "Instruction-Level-Parallelism (average number=
 of uops executed when there is execution) per core",
         "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_EXE=
CUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D1@)",
         "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
         "MetricName": "tma_info_pipeline_execute",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Average number of uops fetched from DSB per c=
ycle",
+        "MetricExpr": "cpu_core@IDQ.DSB_UOPS@ / cpu_core@IDQ.DSB_CYCLES_AN=
Y@",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "tma_info_pipeline_fetch_dsb",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average number of uops fetched from LSD per c=
ycle",
+        "MetricExpr": "cpu_core@LSD.UOPS@ / cpu_core@LSD.CYCLES_ACTIVE@",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "tma_info_pipeline_fetch_lsd",
+        "Unit": "cpu_core"
+    },
+    {
+        "BriefDescription": "Average number of uops fetched from MITE per =
cycle",
+        "MetricExpr": "cpu_core@IDQ.MITE_UOPS@ / cpu_core@IDQ.MITE_CYCLES_=
ANY@",
+        "MetricGroup": "Fed;FetchBW",
+        "MetricName": "tma_info_pipeline_fetch_mite",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Instructions per a microcode Assist invocatio=
n",
-        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / ASSISTS.ANY",
+        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@ASSISTS.ANY@"=
,
         "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
         "MetricName": "tma_info_pipeline_ipassist",
         "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
@@ -1887,14 +1833,14 @@
     },
     {
         "BriefDescription": "Average CPU Utilization (percentage)",
-        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
+        "MetricExpr": "tma_info_system_cpus_utilized / #num_cpus_online",
         "MetricGroup": "HPC;Summary",
         "MetricName": "tma_info_system_cpu_utilization",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Average number of utilized CPUs",
-        "MetricExpr": "#num_cpus_online * tma_info_system_cpu_utilization"=
,
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_cpus_utilized",
         "Unit": "cpu_core"
@@ -1925,14 +1871,14 @@
     },
     {
         "BriefDescription": "Cycles Per Instruction for the Operating Syst=
em (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / cpu_core@INST_RETIRED=
.ANY_P@k",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@k / cpu_core@INS=
T_RETIRED.ANY_P@k",
         "MetricGroup": "OS",
         "MetricName": "tma_info_system_kernel_cpi",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Fraction of cycles spent in the Operating Sys=
tem (OS) Kernel mode",
-        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THRE=
AD",
+        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@k / cpu_core@CPU=
_CLK_UNHALTED.THREAD@",
         "MetricGroup": "OS",
         "MetricName": "tma_info_system_kernel_utilization",
         "MetricThreshold": "tma_info_system_kernel_utilization > 0.05",
@@ -1971,7 +1917,7 @@
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "tma_info_thread_clks / cpu_core@CPU_CLK_UNHALTED.RE=
F_TSC@",
         "MetricGroup": "Power",
         "MetricName": "tma_info_system_turbo_utilization",
         "Unit": "cpu_core"
@@ -1992,7 +1938,7 @@
     },
     {
         "BriefDescription": "The ratio of Executed- by Issued-Uops",
-        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / UOPS_ISSUED.ANY",
+        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_ISSU=
ED.ANY@",
         "MetricGroup": "Cor;Pipeline",
         "MetricName": "tma_info_thread_execute_per_issue",
         "PublicDescription": "The ratio of Executed- by Issued-Uops. Ratio=
 > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate o=
f \"execute\" at rename stage.",
@@ -2021,15 +1967,15 @@
     },
     {
         "BriefDescription": "Uops Per Instruction",
-        "MetricExpr": "tma_retiring * tma_info_thread_slots / INST_RETIRED=
.ANY",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@INS=
T_RETIRED.ANY@",
         "MetricGroup": "Pipeline;Ret;Retire",
         "MetricName": "tma_info_thread_uoppi",
         "MetricThreshold": "tma_info_thread_uoppi > 1.05",
         "Unit": "cpu_core"
     },
     {
-        "BriefDescription": "Instruction per taken branch",
-        "MetricExpr": "tma_retiring * tma_info_thread_slots / BR_INST_RETI=
RED.NEAR_TAKEN",
+        "BriefDescription": "Uops per taken branch",
+        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@BR_=
INST_RETIRED.NEAR_TAKEN@",
         "MetricGroup": "Branches;Fed;FetchBW",
         "MetricName": "tma_info_thread_uptb",
         "MetricThreshold": "tma_info_thread_uptb < 9",
@@ -2068,7 +2014,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Instruction TLB (ITLB) misses",
         "MetricExpr": "cpu_core@ICACHE_TAG.STALLS@ / tma_info_thread_clks"=
,
-        "MetricGroup": "BigFootprint;FetchLat;MemoryTLB;TopdownL3;tma_L3_g=
roup;tma_fetch_latency_group",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;tma=
_L3_group;tma_fetch_latency_group",
         "MetricName": "tma_itlb_misses",
         "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency > =
0.1 & tma_frontend_bound > 0.15)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRONTE=
ND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
@@ -2085,10 +2031,20 @@
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "This metric roughly estimates fraction of cyc=
les with demand load accesses that hit the L1 cache",
+        "MetricExpr": "min(2 * (cpu_core@MEM_INST_RETIRED.ALL_LOADS@ - cpu=
_core@MEM_LOAD_RETIRED.FB_HIT@ - cpu_core@MEM_LOAD_RETIRED.L1_MISS@) * 20 /=
 100, max(cpu_core@CYCLE_ACTIVITY.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVIT=
Y.CYCLES_L1D_MISS@, 0)) / tma_info_thread_clks",
+        "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bound=
_group",
+        "MetricName": "tma_l1_hit_latency",
+        "MetricThreshold": "tma_l1_hit_latency > 0.1 & (tma_l1_bound > 0.1=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
+        "PublicDescription": "This metric roughly estimates fraction of cy=
cles with demand load accesses that hit the L1 cache. The short latency of =
the L1 data cache may be exposed in pointer-chasing memory access patterns =
as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
+        "ScaleUnit": "100%",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This metric estimates how often the CPU was s=
talled due to L2 cache accesses by loads",
         "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L1D_MISS@ - cpu_co=
re@MEMORY_ACTIVITY.STALLS_L2_MISS@) / tma_info_thread_clks",
-        "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
+        "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_=
L3_group;tma_memory_bound_group",
         "MetricName": "tma_l2_bound",
         "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2)",
         "PublicDescription": "This metric estimates how often the CPU was =
stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L1 =
misses/L2 hits) can improve the latency and increase performance. Sample wi=
th: MEM_LOAD_RETIRED.L2_HIT_PS",
@@ -2108,7 +2064,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles with=
 demand load accesses that hit the L3 cache under unloaded scenarios (possi=
bly L3 latency limited)",
         "MetricExpr": "9 * tma_info_system_core_frequency * (cpu_core@MEM_=
LOAD_RETIRED.L3_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@ME=
M_LOAD_RETIRED.L1_MISS@ / 2)) / tma_info_thread_clks",
-        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_=
l3_bound_group",
+        "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat=
;tma_l3_bound_group",
         "MetricName": "tma_l3_hit_latency",
         "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.0=
5 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles wit=
h demand load accesses that hit the L3 cache under unloaded scenarios (poss=
ibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3=
 hits) will improve the latency; reduce contention with sibling physical co=
res and increase performance.  Note the value of this node may overlap with=
 its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tm=
a_info_bottleneck_cache_memory_latency, tma_mem_latency",
@@ -2121,7 +2077,7 @@
         "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latency_=
group;tma_issueFB",
         "MetricName": "tma_lcp",
         "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & tm=
a_frontend_bound > 0.15)",
-        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, t=
ma_info_inst_mix_iptb",
+        "PublicDescription": "This metric represents fraction of cycles CP=
U was stalled due to Length Changing Prefixes (LCPs). Using proper compiler=
 flags or Intel Compiler by default will certainly avoid this. #Link: Optim=
ization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetch_=
bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses,=
 tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2170,7 +2126,7 @@
         "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_l1=
_bound_group",
         "MetricName": "tma_lock_latency",
         "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1 &=
 (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
-        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS_PS. Related metrics: tma_store_latency",
+        "PublicDescription": "This metric represents fraction of cycles th=
e CPU spent handling cache misses due to lock operations. Due to the microa=
rchitecture handling of locks; they are classified as L1_Bound regardless o=
f what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_LOA=
DS. Related metrics: tma_store_latency",
         "ScaleUnit": "100%",
         "Unit": "cpu_core"
     },
@@ -2187,7 +2143,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Machine Clears",
         "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredicts=
)",
-        "MetricGroup": "BadSpec;MachineClears;TmaL2;TopdownL2;tma_L2_group=
;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
+        "MetricGroup": "BadSpec;BvMS;MachineClears;TmaL2;TopdownL2;tma_L2_=
group;tma_bad_speculation_group;tma_issueMC;tma_issueSyncxn",
         "MetricName": "tma_machine_clears",
         "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculation=
 > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
@@ -2198,7 +2154,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the core's performance was likely hurt due to approaching bandwidth limit=
s of external memory - DRAM ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clk=
s",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_b=
ound_group;tma_issueBW",
+        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_d=
ram_bound_group;tma_issueBW",
         "MetricName": "tma_mem_bandwidth",
         "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the core's performance was likely hurt due to approaching bandwidth limi=
ts of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuris=
tic assumes that a similar off-core traffic is generated by all IA cores. T=
his metric does not aggregate non-data-read requests by this logical proces=
sor; requests from other IA Logical Processors/Physical Cores/sockets; or o=
ther non-IA devices like GPU; hence the maximum external memory bandwidth l=
imits may or may not be approached when this metric is flagged (see Uncore =
counters for that). Related metrics: tma_fb_full, tma_info_bottleneck_cache=
_memory_bandwidth, tma_info_system_dram_bw_use, tma_sq_full",
@@ -2208,7 +2164,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles wher=
e the performance was likely hurt due to latency from external memory - DRA=
M ([SPR-HBM] and/or HBM)",
         "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFF=
CORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_thread_clks - tm=
a_mem_bandwidth",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_dram_=
bound_group;tma_issueLat",
+        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
dram_bound_group;tma_issueLat",
         "MetricName": "tma_mem_latency",
         "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles whe=
re the performance was likely hurt due to latency from external memory - DR=
AM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from ot=
her Logical Processors/Physical Cores/sockets (see Uncore counters for that=
). Related metrics: tma_info_bottleneck_cache_memory_latency, tma_l3_hit_la=
tency",
@@ -2258,7 +2214,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to Branch Resteers as a result of Branch Misprediction=
 at execution stage",
         "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * cpu_=
core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
-        "MetricGroup": "BadSpec;BrMispredicts;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group;tma_issueBM",
+        "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_group;=
tma_branch_resteers_group;tma_issueBM",
         "MetricName": "tma_mispredicts_resteers",
         "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branch_=
resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to Branch Resteers as a result of Branch Mispredictio=
n at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related m=
etrics: tma_branch_mispredicts, tma_info_bad_spec_branch_misprediction_cost=
, tma_info_bottleneck_mispredictions",
@@ -2298,7 +2254,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring branch instructions that were not fused",
         "MetricExpr": "tma_light_operations * (cpu_core@BR_INST_RETIRED.AL=
L_BRANCHES@ - cpu_core@INST_RETIRED.MACRO_FUSED@) / (tma_retiring * tma_inf=
o_thread_slots)",
-        "MetricGroup": "Branches;Pipeline;TopdownL3;tma_L3_group;tma_light=
_operations_group",
+        "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tma_=
light_operations_group",
         "MetricName": "tma_non_fused_branches",
         "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_opera=
tions > 0.6",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring branch instructions that were not fused. Non-condit=
ional branches like direct JMP or CALL would count here. Can be used to exa=
mine fusible conditional jumps that were not fused.",
@@ -2308,7 +2264,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots wher=
e the CPU was retiring NOP (no op) instructions",
         "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.NOP@ /=
 (tma_retiring * tma_info_thread_slots)",
-        "MetricGroup": "Pipeline;TopdownL4;tma_L4_group;tma_other_light_op=
s_group",
+        "MetricGroup": "BvBO;Pipeline;TopdownL4;tma_L4_group;tma_other_lig=
ht_ops_group",
         "MetricName": "tma_nop_instructions",
         "MetricThreshold": "tma_nop_instructions > 0.1 & (tma_other_light_=
ops > 0.3 & tma_light_operations > 0.6)",
         "PublicDescription": "This metric represents fraction of slots whe=
re the CPU was retiring NOP (no op) instructions. Compilers often use NOPs =
for certain address alignments - e.g. start address of a function or loop b=
ody. Sample with: INST_RETIRED.NOP",
@@ -2328,7 +2284,7 @@
     {
         "BriefDescription": "This metric estimates fraction of slots the C=
PU was stalled due to other cases of misprediction (non-retired x86 branche=
s or other types).",
         "MetricExpr": "max(tma_branch_mispredicts * (1 - cpu_core@BR_MISP_=
RETIRED.ALL_BRANCHES@ / (cpu_core@INT_MISC.CLEARS_COUNT@ - cpu_core@MACHINE=
_CLEARS.COUNT@)), 0.0001)",
-        "MetricGroup": "BrMispredicts;TopdownL3;tma_L3_group;tma_branch_mi=
spredicts_group",
+        "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_bran=
ch_mispredicts_group",
         "MetricName": "tma_other_mispredicts",
         "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_mis=
predicts > 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
@@ -2337,7 +2293,7 @@
     {
         "BriefDescription": "This metric represents fraction of slots the =
CPU has wasted due to Nukes (Machine Clears) not related to memory ordering=
.",
         "MetricExpr": "max(tma_machine_clears * (1 - cpu_core@MACHINE_CLEA=
RS.MEMORY_ORDERING@ / cpu_core@MACHINE_CLEARS.COUNT@), 0.0001)",
-        "MetricGroup": "Machine_Clears;TopdownL3;tma_L3_group;tma_machine_=
clears_group",
+        "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_mac=
hine_clears_group",
         "MetricName": "tma_other_nukes",
         "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears >=
 0.1 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%",
@@ -2395,7 +2351,7 @@
     },
     {
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed no uops on any execution port (Logical Processor cycles since ICL=
, Physical Core cycles otherwise)",
-        "MetricExpr": "(cpu_core@EXE_ACTIVITY.3_PORTS_UTIL\\,umask\\=3D0x8=
0@ + cpu_core@RS.EMPTY\\,umask\\=3D1@) / tma_info_thread_clks * (cpu_core@C=
YCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@) / tma_=
info_thread_clks",
+        "MetricExpr": "(cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + max(cpu=
_core@RS.EMPTY\\,umask\\=3D1@ - cpu_core@RESOURCE_STALLS.SCOREBOARD@, 0)) /=
 tma_info_thread_clks * (cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@E=
XE_ACTIVITY.BOUND_ON_LOADS@) / tma_info_thread_clks",
         "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
         "MetricName": "tma_ports_utilized_0",
         "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_utiliz=
ation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
@@ -2428,7 +2384,7 @@
         "BriefDescription": "This metric represents fraction of cycles CPU=
 executed total of 3 or more uops per cycle on all execution ports (Logical=
 Processor cycles since ICL, Physical Core cycles otherwise)",
         "MetricConstraint": "NO_GROUP_EVENTS_NMI",
         "MetricExpr": "cpu_core@UOPS_EXECUTED.CYCLES_GE_3@ / tma_info_thre=
ad_clks",
-        "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utiliza=
tion_group",
+        "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_ut=
ilization_group",
         "MetricName": "tma_ports_utilized_3m",
         "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_utili=
zation > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric represents fraction of cycles CP=
U executed total of 3 or more uops per cycle on all execution ports (Logica=
l Processor cycles since ICL, Physical Core cycles otherwise). Sample with:=
 UOPS_EXECUTED.CYCLES_GE_3",
@@ -2439,7 +2395,7 @@
         "BriefDescription": "This category represents fraction of slots ut=
ilized by useful work i.e. issued uops that eventually get retired",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\\-=
fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retiring@=
 + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
-        "MetricGroup": "Default;TmaL1;TopdownL1;tma_L1_group",
+        "MetricGroup": "BvUW;Default;TmaL1;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > 0.=
1",
         "MetricgroupNoGroup": "TopdownL1;Default",
@@ -2450,7 +2406,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU issue-pipeline was stalled due to serializing operations",
         "MetricExpr": "cpu_core@RESOURCE_STALLS.SCOREBOARD@ / tma_info_thr=
ead_clks + tma_c02_wait",
-        "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_gr=
oup;tma_issueSO",
+        "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_bou=
nd_group;tma_issueSO",
         "MetricName": "tma_serializing_operation",
         "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_bo=
und > 0.1 & tma_backend_bound > 0.2)",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU issue-pipeline was stalled due to serializing operations. Instruction=
s like CPUID; WRMSR or LFENCE serialize the out-of-order execution which ma=
y limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related metri=
cs: tma_ms_switches",
@@ -2501,7 +2457,7 @@
     {
         "BriefDescription": "This metric measures fraction of cycles where=
 the Super Queue (SQ) was full taking into account all request-types and bo=
th hardware SMT threads (Logical Processors)",
         "MetricExpr": "(cpu_core@XQ.FULL_CYCLES@ + cpu_core@L1D_PEND_MISS.=
L2_STALLS@) / tma_info_thread_clks",
-        "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueB=
W;tma_l3_bound_group",
+        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_i=
ssueBW;tma_l3_bound_group",
         "MetricName": "tma_sq_full",
         "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric measures fraction of cycles wher=
e the Super Queue (SQ) was full taking into account all request-types and b=
oth hardware SMT threads (Logical Processors). Related metrics: tma_fb_full=
, tma_info_bottleneck_cache_memory_bandwidth, tma_info_system_dram_bw_use, =
tma_mem_bandwidth",
@@ -2531,7 +2487,7 @@
     {
         "BriefDescription": "This metric estimates fraction of cycles the =
CPU spent handling L1D store misses",
         "MetricExpr": "(cpu_core@MEM_STORE_RETIRED.L2_HIT@ * 10 * (1 - cpu=
_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.ALL_STORES@)=
 + (1 - cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.A=
LL_STORES@) * min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUE=
STS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO@)) / tma_info_thread_clks",
-        "MetricGroup": "MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_issue=
RFO;tma_issueSL;tma_store_bound_group",
+        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tma_=
issueRFO;tma_issueSL;tma_store_bound_group",
         "MetricName": "tma_store_latency",
         "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound > 0=
.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
         "PublicDescription": "This metric estimates fraction of cycles the=
 CPU spent handling L1D store misses. Store accesses usually less impact ou=
t-of-order core performance; however; holding resources for longer time can=
 lead into undesired implications (e.g. contention on L1D fill-buffer entri=
es - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
@@ -2579,7 +2535,7 @@
     {
         "BriefDescription": "This metric represents fraction of cycles the=
 CPU was stalled due to new branch address clears",
         "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / tma_info=
_thread_clks",
-        "MetricGroup": "BigFootprint;FetchLat;TopdownL4;tma_L4_group;tma_b=
ranch_resteers_group",
+        "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_group;=
tma_branch_resteers_group",
         "MetricName": "tma_unknown_branches",
         "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_rest=
eers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
         "PublicDescription": "This metric represents fraction of cycles th=
e CPU was stalled due to new branch address clears. These are fetched branc=
hes the Branch Prediction Unit was unable to recognize (e.g. first time the=
 branch is fetched or hitting BTB capacity limit) hence called Unknown Bran=
ches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
@@ -2588,7 +2544,7 @@
     },
     {
         "BriefDescription": "This metric serves as an approximation of leg=
acy x87 usage",
-        "MetricExpr": "tma_retiring * cpu_core@UOPS_EXECUTED.X87@ / UOPS_E=
XECUTED.THREAD",
+        "MetricExpr": "tma_retiring * cpu_core@UOPS_EXECUTED.X87@ / cpu_co=
re@UOPS_EXECUTED.THREAD@",
         "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_group"=
,
         "MetricName": "tma_x87_use",
         "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tma_=
light_operations > 0.6)",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/cache.json
index b3d7f8fb50df..3f51686fe7a8 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "L1D.HWPF_MISS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.HWPF_MISS",
         "SampleAfterValue": "1000003",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Counts the number of cache lines replaced in =
L1 data cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x51",
         "EventName": "L1D.REPLACEMENT",
         "PublicDescription": "Counts L1D data line replacements including =
opportunistic replacements, and replacements that require stall-for-replace=
 or block-for-replace.",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Number of cycles a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.FB_FULL",
         "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D Fill Buffer (FB) unavailability. Demand requests include=
 cacheable/uncacheable demand load, store, lock or SW prefetch accesses.",
@@ -27,6 +30,7 @@
     },
     {
         "BriefDescription": "Number of phases a demand request has waited =
due to L1D Fill Buffer (FB) unavailability.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x48",
@@ -38,6 +42,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
L1D_PEND_MISS.L2_STALLS",
+        "Counter": "0,1,2,3",
         "Deprecated": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALL",
@@ -47,6 +52,7 @@
     },
     {
         "BriefDescription": "Number of cycles a demand request has waited =
due to L1D due to lack of L2 resources.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.L2_STALLS",
         "PublicDescription": "Counts number of cycles a demand request has=
 waited due to L1D due to lack of L2 resources. Demand requests include cac=
heable/uncacheable demand load, store, lock or SW prefetch accesses.",
@@ -56,6 +62,7 @@
     },
     {
         "BriefDescription": "Number of L1D misses that are outstanding",
+        "Counter": "0,1,2,3",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING",
         "PublicDescription": "Counts number of L1D misses that are outstan=
ding in each cycle, that is each cycle the number of Fill Buffers (FB) outs=
tanding required by Demand Reads. FB either is held by demand loads, or it =
is held by non-demand loads and gets hit at least once by demand. The valid=
 outstanding interval is defined until the FB deallocation by one of the fo=
llowing ways: from FB allocation, if FB is allocated by demand from the dem=
and Hit FB, if it is allocated by hardware or software prefetch. Note: In t=
he L1D, a Demand Read contains cacheable or noncacheable demand loads, incl=
uding ones causing cache-line splits and reads due to page walks resulted f=
rom any request type.",
@@ -65,6 +72,7 @@
     },
     {
         "BriefDescription": "Cycles with L1D load Misses outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x48",
         "EventName": "L1D_PEND_MISS.PENDING_CYCLES",
@@ -75,6 +83,7 @@
     },
     {
         "BriefDescription": "L2 cache lines filling L2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x25",
         "EventName": "L2_LINES_IN.ALL",
         "PublicDescription": "Counts the number of L2 cache lines filling =
the L2. Counting does not cover rejects.",
@@ -84,6 +93,7 @@
     },
     {
         "BriefDescription": "Cache lines that have been L2 hardware prefet=
ched but not used by demand accesses",
+        "Counter": "0,1,2,3",
         "EventCode": "0x26",
         "EventName": "L2_LINES_OUT.USELESS_HWPF",
         "PublicDescription": "Counts the number of cache lines that have b=
een prefetched by the L2 hardware prefetcher but not used by demand access =
when evicted from the L2 cache",
@@ -93,6 +103,7 @@
     },
     {
         "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_RQSTS.REFERENCES]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.ALL",
         "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_RQSTS.REFERENCES]",
@@ -102,6 +113,7 @@
     },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache. [Th=
is event is alias to L2_RQSTS.MISS]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_REQUEST.MISS",
         "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_RQSTS.MISS]",
@@ -111,6 +123,7 @@
     },
     {
         "BriefDescription": "L2 code requests",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_CODE_RD",
         "PublicDescription": "Counts the total number of L2 code requests.=
",
@@ -120,6 +133,7 @@
     },
     {
         "BriefDescription": "Demand Data Read access L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_DATA_RD",
         "PublicDescription": "Counts Demand Data Read requests accessing t=
he L2 cache. These requests may hit or miss L2 cache. True-miss exclude mis=
ses that were merged with ongoing L2 misses. An access is counted once.",
@@ -129,6 +143,7 @@
     },
     {
         "BriefDescription": "Demand requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_DEMAND_MISS",
         "PublicDescription": "Counts demand requests that miss L2 cache.",
@@ -138,6 +153,7 @@
     },
     {
         "BriefDescription": "L2_RQSTS.ALL_HWPF",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_HWPF",
         "SampleAfterValue": "200003",
@@ -146,6 +162,7 @@
     },
     {
         "BriefDescription": "RFO requests to L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.ALL_RFO",
         "PublicDescription": "Counts the total number of RFO (read for own=
ership) requests to L2 cache. L2 RFO requests include both L1D demand RFO m=
isses as well as L1D RFO prefetches.",
@@ -155,6 +172,7 @@
     },
     {
         "BriefDescription": "L2 cache hits when fetching instructions, cod=
e reads.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_HIT",
         "PublicDescription": "Counts L2 cache hits when fetching instructi=
ons, code reads.",
@@ -164,6 +182,7 @@
     },
     {
         "BriefDescription": "L2 cache misses when fetching instructions",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.CODE_RD_MISS",
         "PublicDescription": "Counts L2 cache misses when fetching instruc=
tions.",
@@ -173,6 +192,7 @@
     },
     {
         "BriefDescription": "Demand Data Read requests that hit L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_HIT",
         "PublicDescription": "Counts the number of demand Data Read reques=
ts initiated by load instructions that hit L2 cache.",
@@ -182,6 +202,7 @@
     },
     {
         "BriefDescription": "Demand Data Read miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.DEMAND_DATA_RD_MISS",
         "PublicDescription": "Counts demand Data Read requests with true-m=
iss in the L2 cache. True-miss excludes misses that were merged with ongoin=
g L2 misses. An access is counted once.",
@@ -191,6 +212,7 @@
     },
     {
         "BriefDescription": "L2_RQSTS.HWPF_MISS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.HWPF_MISS",
         "SampleAfterValue": "200003",
@@ -199,6 +221,7 @@
     },
     {
         "BriefDescription": "Read requests with true-miss in L2 cache. [Th=
is event is alias to L2_REQUEST.MISS]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.MISS",
         "PublicDescription": "Counts read requests of any type with true-m=
iss in the L2 cache. True-miss excludes L2 misses that were merged with ong=
oing L2 misses. [This event is alias to L2_REQUEST.MISS]",
@@ -208,6 +231,7 @@
     },
     {
         "BriefDescription": "All accesses to L2 cache [This event is alias=
 to L2_REQUEST.ALL]",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.REFERENCES",
         "PublicDescription": "Counts all requests that were hit or true mi=
sses in L2 cache. True-miss excludes misses that were merged with ongoing L=
2 misses. [This event is alias to L2_REQUEST.ALL]",
@@ -217,6 +241,7 @@
     },
     {
         "BriefDescription": "RFO requests that hit L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_HIT",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that hit L2 cache.",
@@ -226,6 +251,7 @@
     },
     {
         "BriefDescription": "RFO requests that miss L2 cache",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.RFO_MISS",
         "PublicDescription": "Counts the RFO (Read-for-Ownership) requests=
 that miss L2 cache.",
@@ -235,6 +261,7 @@
     },
     {
         "BriefDescription": "SW prefetch requests that hit L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_HIT",
         "PublicDescription": "Counts Software prefetch requests that hit t=
he L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when =
FB is not full.",
@@ -244,6 +271,7 @@
     },
     {
         "BriefDescription": "SW prefetch requests that miss L2 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x24",
         "EventName": "L2_RQSTS.SWPF_MISS",
         "PublicDescription": "Counts Software prefetch requests that miss =
the L2 cache. Accounts for PREFETCHNTA and PREFETCHT0/1/2 instructions when=
 FB is not full.",
@@ -251,17 +279,29 @@
         "UMask": "0x28",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "L2 writebacks that access L2 cache",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x23",
+        "EventName": "L2_TRANS.L2_WB",
+        "PublicDescription": "Counts L2 writebacks that access L2 cache.",
+        "SampleAfterValue": "200003",
+        "UMask": "0x40",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that miss in the LLC. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
-        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 =
cache. Counts on a per core basis.",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that miss in the Last Level Cache (LLC). Requests include demand loads, =
reads for ownership (RFO), instruction fetches and L1 HW prefetches. If the=
 core has access to an L3 cache, the LLC is the L3 cache, otherwise it is t=
he L2 cache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x41",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Core-originated cacheable requests that misse=
d L3  (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.MISS",
         "PublicDescription": "Counts core-originated cacheable requests th=
at miss the L3 cache (Longest Latency cache). Requests include data and cod=
e reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pref=
etches to the L1 and L2.  It does not include hardware prefetches to the L3=
, and may not count other types of requests to the L3.",
@@ -271,15 +311,17 @@
     },
     {
         "BriefDescription": "Counts the number of cacheable memory request=
s that access the LLC. Counts on a per core basis.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
-        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2 c=
ache. Counts on a per core basis.",
+        "PublicDescription": "Counts the number of cacheable memory reques=
ts that access the Last Level Cache (LLC). Requests include demand loads, r=
eads for ownership (RFO), instruction fetches and L1 HW prefetches. If the =
core has access to an L3 cache, the LLC is the L3 cache, otherwise it is th=
e L2 cache. Counts on a per core basis.",
         "SampleAfterValue": "200003",
         "UMask": "0x4f",
         "Unit": "cpu_atom"
     },
     {
         "BriefDescription": "Core-originated cacheable requests that refer=
 to L3 (Except hardware prefetches to the L3)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x2e",
         "EventName": "LONGEST_LAT_CACHE.REFERENCE",
         "PublicDescription": "Counts core-originated cacheable requests to=
 the L3 cache (Longest Latency cache). Requests include data and code reads=
, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetches =
to the L1 and L2.  It does not include hardware prefetches to the L3, and m=
ay not count other types of requests to the L3.",
@@ -289,6 +331,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2, LLC, DRAM o=
r MMIO (Non-DRAM).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH",
         "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or translation lookaside buffer (TLB) miss =
which hit in the L2, LLC, DRAM or MMIO (Non-DRAM).",
@@ -298,6 +341,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in DRAM or MMIO (Non-D=
RAM).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_DRAM_HIT",
         "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or translation lookaside buffer (TLB) miss =
which hit in DRAM or MMIO (non-DRAM).",
@@ -307,6 +351,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the L2 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_L2_HIT",
         "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the L2 cache.",
@@ -316,6 +361,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to an instruction cache or TLB miss which hit in the LLC or other co=
re with HITE/F/M.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.IFETCH_LLC_HIT",
         "PublicDescription": "Counts the number of cycles the core is stal=
led due to an instruction cache or Translation Lookaside Buffer (TLB) miss =
which hit in the Last Level Cache (LLC) or other core with HITE/F/M.",
@@ -325,6 +371,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in the L2, LLC, DRAM or MMIO (Non-DR=
AM).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD",
         "SampleAfterValue": "200003",
@@ -333,6 +380,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_DRAM_HIT",
         "SampleAfterValue": "200003",
@@ -341,6 +389,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the L2 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_L2_HIT",
         "SampleAfterValue": "200003",
@@ -349,6 +398,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the LLC or other core with HITE/F/M.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_LLC_HIT",
         "PublicDescription": "Counts the number of cycles the core is stal=
led due to a demand load which hit in the Last Level Cache (LLC) or other c=
ore with HITE/F/M.",
@@ -358,6 +408,7 @@
     },
     {
         "BriefDescription": "Retired load instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_LOADS",
@@ -369,6 +420,7 @@
     },
     {
         "BriefDescription": "Retired store instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ALL_STORES",
@@ -380,6 +432,7 @@
     },
     {
         "BriefDescription": "All retired memory instructions.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.ANY",
@@ -391,6 +444,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with locked access.=
",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
@@ -402,6 +456,7 @@
     },
     {
         "BriefDescription": "Retired load instructions that split across a=
 cacheline boundary.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
@@ -413,6 +468,7 @@
     },
     {
         "BriefDescription": "Retired store instructions that split across =
a cacheline boundary.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
@@ -424,6 +480,7 @@
     },
     {
         "BriefDescription": "Retired load instructions that miss the STLB.=
",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
@@ -435,6 +492,7 @@
     },
     {
         "BriefDescription": "Retired store instructions that miss the STLB=
.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
@@ -446,6 +504,7 @@
     },
     {
         "BriefDescription": "Completed demand load uops that miss the L1 d=
-cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x43",
         "EventName": "MEM_LOAD_COMPLETED.L1_MISS_ANY",
         "PublicDescription": "Number of completed demand load requests tha=
t missed the L1 data cache including shadow misses (FB hits, merge to an on=
going L1D miss)",
@@ -455,6 +514,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were HitM responses from shared L3",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
@@ -466,6 +526,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
@@ -477,6 +538,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were HitM responses from shared L3",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
@@ -488,6 +550,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were L3 hit and cross-core snoop missed in on-pkg core cache.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
@@ -499,6 +562,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were hits in L3 without snoops required",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
@@ -510,6 +574,7 @@
     },
     {
         "BriefDescription": "Retired load instructions whose data sources =
were L3 and cross-core snoop hits in on-pkg core cache",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd2",
         "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
@@ -521,6 +586,7 @@
     },
     {
         "BriefDescription": "Retired load instructions which data sources =
missed L3 but serviced from local dram",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd3",
         "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
@@ -532,6 +598,7 @@
     },
     {
         "BriefDescription": "Retired instructions with at least 1 uncachea=
ble load or lock.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd4",
         "EventName": "MEM_LOAD_MISC_RETIRED.UC",
@@ -543,6 +610,7 @@
     },
     {
         "BriefDescription": "Number of completed demand load requests that=
 missed the L1, but hit the FB(fill buffer), because a preceding miss to th=
e same cacheline initiated the line to be brought into L1, but data is not =
yet ready in L1.",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.FB_HIT",
@@ -554,6 +622,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with L1 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_HIT",
@@ -565,6 +634,7 @@
     },
     {
         "BriefDescription": "Retired load instructions missed L1 cache as =
data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L1_MISS",
@@ -576,6 +646,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with L2 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_HIT",
@@ -587,6 +658,7 @@
     },
     {
         "BriefDescription": "Retired load instructions missed L2 cache as =
data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L2_MISS",
@@ -598,6 +670,7 @@
     },
     {
         "BriefDescription": "Retired load instructions with L3 cache hits =
as data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_HIT",
@@ -609,6 +682,7 @@
     },
     {
         "BriefDescription": "Retired load instructions missed L3 cache as =
data sources",
+        "Counter": "0,1,2,3",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_RETIRED.L3_MISS",
@@ -620,6 +694,7 @@
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in DRAM.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
@@ -630,6 +705,7 @@
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L2 cache.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
@@ -640,6 +716,7 @@
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
@@ -650,6 +727,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.ALL",
         "SampleAfterValue": "20003",
@@ -658,6 +736,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a load buffer full condition.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
         "SampleAfterValue": "20003",
@@ -666,6 +745,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to an RSV full condition.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.RSV",
         "SampleAfterValue": "20003",
@@ -674,6 +754,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a store buffer full condition.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
         "SampleAfterValue": "20003",
@@ -682,6 +763,7 @@
     },
     {
         "BriefDescription": "MEM_STORE_RETIRED.L2_HIT",
+        "Counter": "0,1,2,3",
         "EventCode": "0x44",
         "EventName": "MEM_STORE_RETIRED.L2_HIT",
         "SampleAfterValue": "200003",
@@ -690,6 +772,7 @@
     },
     {
         "BriefDescription": "Counts the number of load uops retired.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
@@ -701,6 +784,7 @@
     },
     {
         "BriefDescription": "Counts the number of store uops retired.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
@@ -712,6 +796,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 128 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled."=
,
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
@@ -725,6 +810,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 16 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -738,6 +824,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 256 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled."=
,
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
@@ -751,6 +838,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 32 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -764,6 +852,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 4 cycles as define=
d in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -777,6 +866,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 512 cycles as defi=
ned in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled."=
,
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
@@ -790,6 +880,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 64 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -803,6 +894,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 8 cycles as define=
d in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
@@ -814,8 +906,20 @@
         "UMask": "0x5",
         "Unit": "cpu_atom"
     },
+    {
+        "BriefDescription": "Counts the number of load uops retired that p=
erformed one or more locks.",
+        "Counter": "0,1,2,3,4,5",
+        "Data_LA": "1",
+        "EventCode": "0xd0",
+        "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
+        "PEBS": "1",
+        "SampleAfterValue": "200003",
+        "UMask": "0x21",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Counts the number of retired split load uops.=
",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
@@ -826,6 +930,7 @@
     },
     {
         "BriefDescription": "Counts the number of stores uops retired. Cou=
nts with or without PEBS enabled.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
@@ -837,6 +942,7 @@
     },
     {
         "BriefDescription": "Retired memory uops for any access",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe5",
         "EventName": "MEM_UOP_RETIRED.ANY",
         "PublicDescription": "Number of retired micro-operations (uops) fo=
r load or store memory accesses",
@@ -846,6 +952,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -856,6 +963,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -866,6 +974,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another cores caches, data forwarding is required as the data i=
s modified.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -876,6 +985,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, but no data was forwa=
rded.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -886,6 +996,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -896,6 +1007,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that resulted in a s=
noop hit in another cores caches which forwarded the unmodified data to the=
 requesting core.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -906,6 +1018,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -916,6 +1029,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -926,6 +1040,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that resulte=
d in a snoop hit in another cores caches, data forwarding is required as th=
e data is modified.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -936,6 +1051,7 @@
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS.ALL_REQUESTS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.ALL_REQUESTS",
         "SampleAfterValue": "100003",
@@ -944,6 +1060,7 @@
     },
     {
         "BriefDescription": "Demand and prefetch data reads",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DATA_RD",
         "PublicDescription": "Counts the demand and prefetch data reads. A=
ll Core Data Reads include cacheable 'Demands' and L2 prefetchers (not L3 p=
refetchers). Counting also covers reads due to page walks resulted from any=
 request type.",
@@ -951,8 +1068,19 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cacheable and noncacheable code read requests=
",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_CODE_RD",
+        "PublicDescription": "Counts both cacheable and non-cacheable code=
 read requests.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Demand Data Read requests sent to uncore",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.DEMAND_DATA_RD",
         "PublicDescription": "Counts the Demand Data Read requests sent to=
 uncore. Use it in conjunction with OFFCORE_REQUESTS_OUTSTANDING to determi=
ne average latency in the uncore.",
@@ -960,8 +1088,19 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Demand RFO requests including regular RFOs, l=
ocks, ItoM",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x21",
+        "EventName": "OFFCORE_REQUESTS.DEMAND_RFO",
+        "PublicDescription": "Counts the demand RFO (read for ownership) r=
equests including regular RFOs, locks, ItoM.",
+        "SampleAfterValue": "100003",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "Counter": "0,1,2,3",
         "Deprecated": "1",
         "Errata": "ADL038",
         "EventCode": "0x20",
@@ -972,6 +1111,7 @@
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA=
_RD",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "Errata": "ADL038",
         "EventCode": "0x20",
@@ -980,8 +1120,20 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles with offcore outstanding Code Reads tr=
ansactions in the SuperQueue (SQ), queue to uncore.",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_CODE=
_RD",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycles where at least 1 outstanding demand da=
ta read request is pending.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_DATA=
_RD",
@@ -991,6 +1143,7 @@
     },
     {
         "BriefDescription": "For every cycle where the core is waiting on =
at least 1 outstanding Demand RFO request, increments by 1.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO"=
,
@@ -1001,6 +1154,7 @@
     },
     {
         "BriefDescription": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
+        "Counter": "0,1,2,3",
         "Errata": "ADL038",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD",
@@ -1008,8 +1162,19 @@
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Offcore outstanding Code Reads transactions i=
n the SuperQueue (SQ), queue to uncore, every cycle.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x20",
+        "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_CODE_RD",
+        "PublicDescription": "Counts the number of offcore outstanding Cod=
e Reads transactions in the super queue every cycle. The 'Offcore outstandi=
ng' state of the transaction lasts from the L2 miss until the sending trans=
action completion to requestor (SQ deallocation). See the corresponding Uma=
sk under OFFCORE_REQUESTS.",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x2",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "For every cycle, increments by the number of =
outstanding demand data read requests pending.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD",
         "PublicDescription": "For every cycle, increments by the number of=
 outstanding demand data read requests pending.   Requests are considered o=
utstanding from the time they miss the core's L2 cache until the transactio=
n completion message is sent to the requestor.",
@@ -1019,6 +1184,7 @@
     },
     {
         "BriefDescription": "Counts bus locks, accounts for cache line spl=
it locks and UC locks.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2c",
         "EventName": "SQ_MISC.BUS_LOCK",
         "PublicDescription": "Counts the more expensive bus lock needed to=
 enforce cache coherency for certain memory accesses that need to be done a=
tomically.  Can be created by issuing an atomic instruction (via the LOCK p=
refix) which causes a cache line split or accesses uncacheable memory.",
@@ -1026,8 +1192,18 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of PREFETCHNTA, PREFETCHW, =
PREFETCHT0, PREFETCHT1 or PREFETCHT2 instructions executed.",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x40",
+        "EventName": "SW_PREFETCH_ACCESS.ANY",
+        "SampleAfterValue": "100003",
+        "UMask": "0xf",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Number of PREFETCHNTA instructions executed."=
,
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.NTA",
         "PublicDescription": "Counts the number of PREFETCHNTA instruction=
s executed.",
@@ -1037,6 +1213,7 @@
     },
     {
         "BriefDescription": "Number of PREFETCHW instructions executed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.PREFETCHW",
         "PublicDescription": "Counts the number of PREFETCHW instructions =
executed.",
@@ -1046,6 +1223,7 @@
     },
     {
         "BriefDescription": "Number of PREFETCHT0 instructions executed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T0",
         "PublicDescription": "Counts the number of PREFETCHT0 instructions=
 executed.",
@@ -1055,6 +1233,7 @@
     },
     {
         "BriefDescription": "Number of PREFETCHT1 or PREFETCHT2 instructio=
ns executed.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x40",
         "EventName": "SW_PREFETCH_ACCESS.T1_T2",
         "PublicDescription": "Counts the number of PREFETCHT1 or PREFETCHT=
2 instructions executed.",
@@ -1064,6 +1243,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to instruction cache misses.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ICACHE",
         "SampleAfterValue": "1000003",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json b=
/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
index cd291943dc08..b4621c221f58 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "ARITH.FPDIV_ACTIVE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.FPDIV_ACTIVE",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Counts all microcode FP assists.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.FP",
         "PublicDescription": "Counts all microcode Floating Point assists.=
",
@@ -19,6 +21,7 @@
     },
     {
         "BriefDescription": "ASSISTS.SSE_AVX_MIX",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.SSE_AVX_MIX",
         "SampleAfterValue": "1000003",
@@ -27,6 +30,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_0 [This event is ali=
as to FP_ARITH_DISPATCHED.V0]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_0",
         "SampleAfterValue": "2000003",
@@ -35,6 +39,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_1 [This event is ali=
as to FP_ARITH_DISPATCHED.V1]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_1",
         "SampleAfterValue": "2000003",
@@ -43,6 +48,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.PORT_5 [This event is ali=
as to FP_ARITH_DISPATCHED.V2]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.PORT_5",
         "SampleAfterValue": "2000003",
@@ -51,6 +57,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.V0 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_0]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V0",
         "SampleAfterValue": "2000003",
@@ -59,6 +66,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.V1 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_1]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V1",
         "SampleAfterValue": "2000003",
@@ -67,6 +75,7 @@
     },
     {
         "BriefDescription": "FP_ARITH_DISPATCHED.V2 [This event is alias t=
o FP_ARITH_DISPATCHED.PORT_5]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb3",
         "EventName": "FP_ARITH_DISPATCHED.V2",
         "SampleAfterValue": "2000003",
@@ -75,6 +84,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 128-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 2 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice =
as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE",
         "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 2 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as the=
y perform 2 calculations per element. The DAZ and FTZ flags in the MXCSR re=
gister need to be set when using these events.",
@@ -84,6 +94,7 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single precision floating-point instructions retired; some instructions w=
ill count twice as noted below.  Each count represents 4 computation operat=
ions, one for each element.  Applies to SSE* and AVX* packed single precisi=
on floating-point instructions: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 SQRT =
DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count twice as they pe=
rform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE",
         "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
@@ -93,6 +104,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed double precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 4 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed double =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perf=
orm 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE",
         "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed double precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 4 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed double precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions count twice as they perform 2 =
calculations per element. The DAZ and FTZ flags in the MXCSR register need =
to be set when using these events.",
@@ -102,6 +114,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational 256-bi=
t packed single precision floating-point instructions retired; some instruc=
tions will count twice as noted below.  Each count represents 8 computation=
 operations, one for each element.  Applies to SSE* and AVX* packed single =
precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN=
 MAX SQRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE",
         "PublicDescription": "Number of SSE/AVX computational 256-bit pack=
ed single precision floating-point instructions retired; some instructions =
will count twice as noted below.  Each count represents 8 computation opera=
tions, one for each element.  Applies to SSE* and AVX* packed single precis=
ion floating-point instructions: ADD SUB HADD HSUB SUBADD MUL DIV MIN MAX S=
QRT RSQRT RCP DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB instructions count tw=
ice as they perform 2 calculations per element. The DAZ and FTZ flags in th=
e MXCSR register need to be set when using these events.",
@@ -111,6 +124,7 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational 128-bit packe=
d single and 256-bit packed double precision FP instructions retired; some =
instructions will count twice as noted below.  Each count represents 2 or/a=
nd 4 computation operations, 1 for each element.  Applies to SSE* and AVX* =
packed single precision and packed double precision FP instructions: ADD SU=
B HADD HSUB SUBADD MUL DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DP=
P and FM(N)ADD/SUB count twice as they perform 2 calculations per element."=
,
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.4_FLOPS",
         "PublicDescription": "Number of SSE/AVX computational 128-bit pack=
ed single precision and 256-bit packed double precision  floating-point ins=
tructions retired; some instructions will count twice as noted below.  Each=
 count represents 2 or/and 4 computation operations, one for each element. =
 Applies to SSE* and AVX* packed single precision floating-point and packed=
 double precision floating-point instructions: ADD SUB HADD HSUB SUBADD MUL=
 DIV MIN MAX RCP14 RSQRT14 SQRT DPP FM(N)ADD/SUB.  DPP and FM(N)ADD/SUB ins=
tructions count twice as they perform 2 calculations per element. The DAZ a=
nd FTZ flags in the MXCSR register need to be set when using these events."=
,
@@ -120,6 +134,7 @@
     },
     {
         "BriefDescription": "Number of SSE/AVX computational scalar floati=
ng-point instructions retired; some instructions will count twice as noted =
below.  Applies to SSE* and AVX* scalar, double and single precision floati=
ng-point: ADD SUB MUL DIV MIN MAX RCP14 RSQRT14 RANGE SQRT DPP FM(N)ADD/SUB=
.  DPP and FM(N)ADD/SUB instructions count twice as they perform multiple c=
alculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR",
         "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision and double precision floating-point instructions retired; some =
instructions will count twice as noted below.  Each count represents 1 comp=
utational operation. Applies to SSE* and AVX* scalar single precision float=
ing-point instructions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB=
.  FM(N)ADD/SUB instructions count twice as they perform 2 calculations per=
 element. The DAZ and FTZ flags in the MXCSR register need to be set when u=
sing these events.",
@@ -129,6 +144,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational scalar=
 double precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar double precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructi=
ons count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
         "PublicDescription": "Number of SSE/AVX computational scalar doubl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar double precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT FM(N)ADD/SUB.  FM(N)ADD/SUB instructions co=
unt twice as they perform 2 calculations per element. The DAZ and FTZ flags=
 in the MXCSR register need to be set when using these events.",
@@ -138,6 +154,7 @@
     },
     {
         "BriefDescription": "Counts number of SSE/AVX computational scalar=
 single precision floating-point instructions retired; some instructions wi=
ll count twice as noted below.  Each count represents 1 computational opera=
tion. Applies to SSE* and AVX* scalar single precision floating-point instr=
uctions: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB=
 instructions count twice as they perform 2 calculations per element.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
         "PublicDescription": "Number of SSE/AVX computational scalar singl=
e precision floating-point instructions retired; some instructions will cou=
nt twice as noted below.  Each count represents 1 computational operation. =
Applies to SSE* and AVX* scalar single precision floating-point instruction=
s: ADD SUB MUL DIV MIN MAX SQRT RSQRT RCP FM(N)ADD/SUB.  FM(N)ADD/SUB instr=
uctions count twice as they perform 2 calculations per element. The DAZ and=
 FTZ flags in the MXCSR register need to be set when using these events.",
@@ -147,6 +164,7 @@
     },
     {
         "BriefDescription": "Number of any Vector retired FP arithmetic in=
structions",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc7",
         "EventName": "FP_ARITH_INST_RETIRED.VECTOR",
         "PublicDescription": "Number of any Vector retired FP arithmetic i=
nstructions.  The DAZ and FTZ flags in the MXCSR register need to be set wh=
en using these events.",
@@ -156,6 +174,7 @@
     },
     {
         "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PublicDescription": "Counts the number of floating point operatio=
ns retired that required microcode assist, which is not a reflection of the=
 number of FP operations, instructions or uops.",
@@ -165,6 +184,7 @@
     },
     {
         "BriefDescription": "Counts the number of floating point divide uo=
ps retired (x87 and SSE, including x87 sqrt).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.FPDIV",
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools=
/perf/pmu-events/arch/x86/alderlake/frontend.json
index 542ba4a81996..66735a612ebd 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the total number of BACLEARS due to al=
l branch types including conditional and unconditional jumps, returns, and =
indirect branches.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xe6",
         "EventName": "BACLEARS.ANY",
         "PublicDescription": "Counts the total number of BACLEARS, which o=
ccur when the Branch Target Buffer (BTB) prediction or lack thereof, was co=
rrected by a later branch predictor in the frontend.  Includes BACLEARS due=
 to all branch types including conditional and unconditional jumps, returns=
, and indirect branches.",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Clears due to Unknown Branches.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x60",
         "EventName": "BACLEARS.ANY",
         "PublicDescription": "Number of times the front-end is resteered w=
hen it finds a branch instruction in a fetch line. This is called Unknown B=
ranch which occurs for the first time a branch instruction is fetched or wh=
en the branch is not tracked by the BPU (Branch Prediction Unit) anymore.",
@@ -19,6 +21,7 @@
     },
     {
         "BriefDescription": "Stalls caused by changing prefix length of th=
e instruction.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.LCP",
         "PublicDescription": "Counts cycles that the Instruction Length de=
coder (ILD) stalls occurred due to dynamically changing prefix length of th=
e decoded instruction (by operand size prefix instruction 0x66, address siz=
e prefix instruction 0x67 or REX.W for Intel64). Count is proportional to t=
he number of prefixes in a 16B-line. This may result in a three-cycle penal=
ty for each LCP (Length changing prefix) in a 16-byte chunk.",
@@ -28,6 +31,7 @@
     },
     {
         "BriefDescription": "Cycles the Microcode Sequencer is busy.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x87",
         "EventName": "DECODE.MS_BUSY",
         "SampleAfterValue": "500009",
@@ -36,6 +40,7 @@
     },
     {
         "BriefDescription": "DSB-to-MITE switch true penalty cycles.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x61",
         "EventName": "DSB2MITE_SWITCHES.PENALTY_CYCLES",
         "PublicDescription": "Decode Stream Buffer (DSB) is a Uop-cache th=
at holds translations of previously fetched instructions that were decoded =
by the legacy x86 decode pipeline (MITE). This event counts fetch penalty c=
ycles when a transition occurs from DSB to MITE.",
@@ -45,6 +50,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced DSB miss=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
         "MSRIndex": "0x3F7",
@@ -57,6 +63,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced a critic=
al DSB miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.DSB_MISS",
         "MSRIndex": "0x3F7",
@@ -69,6 +76,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced iTLB tru=
e miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.ITLB_MISS",
         "MSRIndex": "0x3F7",
@@ -81,6 +89,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced Instruct=
ion L1 Cache true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.L1I_MISS",
         "MSRIndex": "0x3F7",
@@ -93,6 +102,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced Instruct=
ion L2 Cache true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.L2_MISS",
         "MSRIndex": "0x3F7",
@@ -105,6 +115,7 @@
     },
     {
         "BriefDescription": "Retired instructions after front-end starvati=
on of at least 1 cycle",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
         "MSRIndex": "0x3F7",
@@ -117,6 +128,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 128 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
         "MSRIndex": "0x3F7",
@@ -129,6 +141,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 16 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
         "MSRIndex": "0x3F7",
@@ -141,6 +154,7 @@
     },
     {
         "BriefDescription": "Retired instructions after front-end starvati=
on of at least 2 cycles",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
         "MSRIndex": "0x3F7",
@@ -153,6 +167,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 256 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
         "MSRIndex": "0x3F7",
@@ -165,6 +180,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end had at least 1 bubble-slot for a period of 2=
 cycles which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
         "MSRIndex": "0x3F7",
@@ -177,6 +193,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 32 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
         "MSRIndex": "0x3F7",
@@ -189,6 +206,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 4 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
         "MSRIndex": "0x3F7",
@@ -201,6 +219,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 512 cycles=
 which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
         "MSRIndex": "0x3F7",
@@ -213,6 +232,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 64 cycles =
which was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
         "MSRIndex": "0x3F7",
@@ -225,6 +245,7 @@
     },
     {
         "BriefDescription": "Retired instructions that are fetched after a=
n interval where the front-end delivered no uops for a period of 8 cycles w=
hich was not interrupted by a back-end stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
         "MSRIndex": "0x3F7",
@@ -237,6 +258,7 @@
     },
     {
         "BriefDescription": "FRONTEND_RETIRED.MS_FLOWS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.MS_FLOWS",
         "MSRIndex": "0x3F7",
@@ -248,6 +270,7 @@
     },
     {
         "BriefDescription": "Retired Instructions who experienced STLB (2n=
d level TLB) true miss.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.STLB_MISS",
         "MSRIndex": "0x3F7",
@@ -260,6 +283,7 @@
     },
     {
         "BriefDescription": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc6",
         "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
         "MSRIndex": "0x3F7",
@@ -271,6 +295,7 @@
     },
     {
         "BriefDescription": "Counts the number of requests to the instruct=
ion cache for one or more bytes of a cache line.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x80",
         "EventName": "ICACHE.ACCESSES",
         "PublicDescription": "Counts the total number of requests to the i=
nstruction cache.  The event only counts new cache line accesses, so that m=
ultiple back to back fetches to the exact same cache line or byte chunk cou=
nt as one.  Specifically, the event counts when accesses from sequential co=
de crosses the cache line boundary, or when a branch target is moved to a n=
ew line or to a non-sequential byte chunk of the same line.",
@@ -280,6 +305,7 @@
     },
     {
         "BriefDescription": "Counts the number of instruction cache misses=
.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x80",
         "EventName": "ICACHE.MISSES",
         "PublicDescription": "Counts the number of missed requests to the =
instruction cache.  The event only counts new cache line accesses, so that =
multiple back to back fetches to the exact same cache line and byte chunk c=
ount as one.  Specifically, the event counts when accesses from sequential =
code crosses the cache line boundary, or when a branch target is moved to a=
 new line or to a non-sequential byte chunk of the same line.",
@@ -289,6 +315,7 @@
     },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x80",
         "EventName": "ICACHE_DATA.STALLS",
         "PublicDescription": "Counts cycles where a code line fetch is sta=
lled due to an L1 instruction cache miss. The decode pipeline works at a 32=
 Byte granularity.",
@@ -296,8 +323,20 @@
         "UMask": "0x4",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "ICACHE_DATA.STALL_PERIODS",
+        "Counter": "0,1,2,3",
+        "CounterMask": "1",
+        "EdgeDetect": "1",
+        "EventCode": "0x80",
+        "EventName": "ICACHE_DATA.STALL_PERIODS",
+        "SampleAfterValue": "500009",
+        "UMask": "0x4",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycles where a code fetch is stalled due to L=
1 instruction cache tag miss.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x83",
         "EventName": "ICACHE_TAG.STALLS",
         "PublicDescription": "Counts cycles where a code fetch is stalled =
due to L1 instruction cache tag miss.",
@@ -307,6 +346,7 @@
     },
     {
         "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng any Uop",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_ANY",
@@ -317,16 +357,18 @@
     },
     {
         "BriefDescription": "Cycles DSB is delivering optimal number of Uo=
ps",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the M=
ITE (legacy decode pipeline) path. During these cycles uops are not being d=
elivered from the Decode Stream Buffer (DSB).",
+        "PublicDescription": "Counts the number of cycles where optimal nu=
mber of uops was delivered to the Instruction Decode Queue (IDQ) from the D=
SB (Decode Stream Buffer) path. Count includes uops that may 'bypass' the I=
DQ.",
         "SampleAfterValue": "2000003",
         "UMask": "0x8",
         "Unit": "cpu_core"
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from the Decode Stream Buffer (DSB) path",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_UOPS",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the Decode Stream Buffer (DSB) path.",
@@ -336,6 +378,7 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering any Uop",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_ANY",
@@ -346,6 +389,7 @@
     },
     {
         "BriefDescription": "Cycles MITE is delivering optimal number of U=
ops",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_CYCLES_OK",
@@ -356,6 +400,7 @@
     },
     {
         "BriefDescription": "Uops delivered to Instruction Decode Queue (I=
DQ) from MITE path",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MITE_UOPS",
         "PublicDescription": "Counts the number of uops delivered to Instr=
uction Decode Queue (IDQ) from the MITE path. This also means that uops are=
 not being delivered from the Decode Stream Buffer (DSB).",
@@ -365,6 +410,7 @@
     },
     {
         "BriefDescription": "Cycles when uops are being delivered to IDQ w=
hile MS is busy",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_CYCLES_ANY",
@@ -375,6 +421,7 @@
     },
     {
         "BriefDescription": "Number of switches from DSB or MITE to the MS=
",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0x79",
@@ -386,6 +433,7 @@
     },
     {
         "BriefDescription": "Uops delivered to IDQ while MS is busy",
+        "Counter": "0,1,2,3",
         "EventCode": "0x79",
         "EventName": "IDQ.MS_UOPS",
         "PublicDescription": "Counts the total number of uops delivered by=
 the Microcode Sequencer (MS).",
@@ -395,6 +443,7 @@
     },
     {
         "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE=
]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CORE",
         "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE]",
@@ -404,6 +453,7 @@
     },
     {
         "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled [This event is alias to IDQ_=
UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
@@ -414,6 +464,7 @@
     },
     {
         "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled [This event is alias t=
o IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x9c",
         "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
@@ -425,6 +476,7 @@
     },
     {
         "BriefDescription": "Uops not delivered by IDQ when backend of the=
 machine is not stalled [This event is alias to IDQ_BUBBLES.CORE]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
         "PublicDescription": "Counts the number of uops not delivered to b=
y the Instruction Decode Queue (IDQ) to the back-end of the pipeline when t=
here was no back-end stalls. This event counts for one SMT thread in a give=
n cycle. [This event is alias to IDQ_BUBBLES.CORE]",
@@ -434,6 +486,7 @@
     },
     {
         "BriefDescription": "Cycles when no uops are not delivered by the =
IDQ when backend of the machine is not stalled [This event is alias to IDQ_=
BUBBLES.CYCLES_0_UOPS_DELIV.CORE]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
@@ -444,6 +497,7 @@
     },
     {
         "BriefDescription": "Cycles when optimal number of uops was delive=
red to the back-end when the back-end is not stalled [This event is alias t=
o IDQ_BUBBLES.CYCLES_FE_WAS_OK]",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0x9c",
         "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/p=
erf/pmu-events/arch/x86/alderlake/memory.json
index 23d36164433f..81a03f53aadc 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Execution stalls while L3 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "6",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L3_MISS",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to any number of reasons, incl=
uding an L1 miss, WCB full, pagewalk, store address block or store data blo=
ck, on a load that retires.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.ANY_AT_RET",
         "SampleAfterValue": "1000003",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to a core bound stall includin=
g a store address match, a DTLB miss or a page walk that detains the load f=
rom retiring.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.L1_BOUND_AT_RET",
         "SampleAfterValue": "1000003",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DL1 =
miss.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.L1_MISS_AT_RET",
         "SampleAfterValue": "1000003",
@@ -34,6 +38,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to other =
block cases.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.OTHER_AT_RET",
         "PublicDescription": "Counts the number of cycles that the head (o=
ldest load) of the load buffer and retirement are both stalled due to other=
 block cases such as pipeline conflicts, fences, etc.",
@@ -43,6 +48,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a page=
walk.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.PGWALK_AT_RET",
         "SampleAfterValue": "1000003",
@@ -51,6 +57,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a stor=
e address match.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.ST_ADDR_AT_RET",
         "SampleAfterValue": "1000003",
@@ -59,6 +66,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering caused by a snoop from an external agent. Does not count inte=
rnally generated machine clears such as those due to memory disambiguation.=
",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "SampleAfterValue": "20003",
@@ -67,6 +75,7 @@
     },
     {
         "BriefDescription": "Number of machine clears due to memory orderi=
ng conflicts.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
         "PublicDescription": "Counts the number of Machine Clears detected=
 dye to memory ordering. Memory Ordering Machine Clears may apply when a me=
mory read may not conform to the memory ordering rules of the x86 architect=
ure",
@@ -76,6 +85,7 @@
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
         "CounterMask": "2",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.CYCLES_L1D_MISS",
@@ -85,6 +95,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "3",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L1D_MISS",
@@ -94,6 +105,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L2 cache miss demand c=
acheable load request is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L2_MISS",
@@ -104,6 +116,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L3 cache miss demand c=
acheable load request is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "9",
         "EventCode": "0x47",
         "EventName": "MEMORY_ACTIVITY.STALLS_L3_MISS",
@@ -112,8 +125,23 @@
         "UMask": "0x9",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 1024 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
+        "Data_LA": "1",
+        "EventCode": "0xcd",
+        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
+        "MSRIndex": "0x3F6",
+        "MSRValue": "0x400",
+        "PEBS": "2",
+        "PublicDescription": "Counts randomly selected loads when the late=
ncy from first dispatch to completion is greater than 1024 cycles.  Reporte=
d latency may be longer than just the memory latency.",
+        "SampleAfterValue": "53",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 128 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
@@ -127,6 +155,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 16 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
@@ -140,6 +169,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 256 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
@@ -153,6 +183,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 32 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
@@ -166,6 +197,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 4 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
@@ -179,6 +211,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 512 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
@@ -192,6 +225,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 64 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
@@ -205,6 +239,7 @@
     },
     {
         "BriefDescription": "Counts randomly selected loads when the laten=
cy from first dispatch to completion is greater than 8 cycles.",
+        "Counter": "1,2,3,4,5,6,7",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
@@ -218,6 +253,7 @@
     },
     {
         "BriefDescription": "Retired memory store access operations. A PDi=
st event for PEBS Store Latency Facility.",
+        "Counter": "0",
         "Data_LA": "1",
         "EventCode": "0xcd",
         "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
@@ -229,6 +265,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -239,6 +276,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -249,6 +287,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
@@ -259,6 +298,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -269,6 +309,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that were no=
t supplied by the L3 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -279,6 +320,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
@@ -289,6 +331,7 @@
     },
     {
         "BriefDescription": "Counts demand data read requests that miss th=
e L3 cache.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x21",
         "EventName": "OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
         "SampleAfterValue": "100003",
@@ -297,6 +340,7 @@
     },
     {
         "BriefDescription": "For every cycle, increments by the number of =
demand data read requests pending that are known to have missed the L3 cach=
e.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x20",
         "EventName": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_RD"=
,
         "PublicDescription": "For every cycle, increments by the number of=
 demand data read requests pending that are known to have missed the L3 cac=
he.  Note that this does not capture all elapsed cycles while requests are =
outstanding - only cycles from when the requests were known by the requesti=
ng core to have missed the L3 cache.",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json b/t=
ools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
index 7a03835f262c..b54a5fc0861f 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
@@ -5,8 +5,21 @@
     "BigFootprint": "Grouping from Top-down Microarchitecture Analysis Met=
rics spreadsheet",
     "BrMispredicts": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Branches": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
+    "BvBC": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvBO": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvCB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvFB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvIO": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvML": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMP": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMS": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvMT": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvOB": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
+    "BvUW": "Grouping from Top-down Microarchitecture Analysis Metrics spr=
eadsheet",
     "C0Wait": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
     "CacheHits": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
+    "CacheMisses": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
     "CodeGen": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "Compute": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "Cor": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
@@ -22,14 +35,17 @@
     "Frontend": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "HPC": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "IcMiss": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
+    "Ifetch": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
     "InsType": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "IntVector": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
     "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
+    "Load_Store_Miss": "Grouping from Top-down Microarchitecture Analysis =
Metrics spreadsheet",
     "MachineClears": "Grouping from Top-down Microarchitecture Analysis Me=
trics spreadsheet",
     "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis M=
etrics spreadsheet",
     "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics spre=
adsheet",
     "MemOffcore": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
+    "Mem_Exec": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "MemoryBW": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "MemoryBound": "Grouping from Top-down Microarchitecture Analysis Metr=
ics spreadsheet",
     "MemoryLat": "Grouping from Top-down Microarchitecture Analysis Metric=
s spreadsheet",
@@ -60,6 +76,7 @@
     "TopdownL4": "Metrics for top-down breakdown at level 4",
     "TopdownL5": "Metrics for top-down breakdown at level 5",
     "TopdownL6": "Metrics for top-down breakdown at level 6",
+    "load_store_bound": "Grouping from Top-down Microarchitecture Analysis=
 Metrics spreadsheet",
     "tma_L1_group": "Metrics for top-down breakdown at level 1",
     "tma_L2_group": "Metrics for top-down breakdown at level 2",
     "tma_L3_group": "Metrics for top-down breakdown at level 3",
@@ -68,10 +85,8 @@
     "tma_L6_group": "Metrics for top-down breakdown at level 6",
     "tma_alu_op_utilization_group": "Metrics contributing to tma_alu_op_ut=
ilization category",
     "tma_assists_group": "Metrics contributing to tma_assists category",
-    "tma_backend_bound_aux_group": "Metrics contributing to tma_backend_bo=
und_aux category",
     "tma_backend_bound_group": "Metrics contributing to tma_backend_bound =
category",
     "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
-    "tma_base_group": "Metrics contributing to tma_base category",
     "tma_branch_mispredicts_group": "Metrics contributing to tma_branch_mi=
spredicts category",
     "tma_branch_resteers_group": "Metrics contributing to tma_branch_reste=
ers category",
     "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
@@ -84,6 +99,8 @@
     "tma_fp_vector_group": "Metrics contributing to tma_fp_vector category=
",
     "tma_frontend_bound_group": "Metrics contributing to tma_frontend_boun=
d category",
     "tma_heavy_operations_group": "Metrics contributing to tma_heavy_opera=
tions category",
+    "tma_ifetch_bandwidth_group": "Metrics contributing to tma_ifetch_band=
width category",
+    "tma_ifetch_latency_group": "Metrics contributing to tma_ifetch_latenc=
y category",
     "tma_int_operations_group": "Metrics contributing to tma_int_operation=
s category",
     "tma_issue2P": "Metrics related by the issue $issue2P",
     "tma_issueBM": "Metrics related by the issue $issueBM",
@@ -110,11 +127,9 @@
     "tma_load_op_utilization_group": "Metrics contributing to tma_load_op_=
utilization category",
     "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
     "tma_mem_latency_group": "Metrics contributing to tma_mem_latency cate=
gory",
-    "tma_mem_scheduler_group": "Metrics contributing to tma_mem_scheduler =
category",
     "tma_memory_bound_group": "Metrics contributing to tma_memory_bound ca=
tegory",
     "tma_microcode_sequencer_group": "Metrics contributing to tma_microcod=
e_sequencer category",
     "tma_mite_group": "Metrics contributing to tma_mite category",
-    "tma_nuke_group": "Metrics contributing to tma_nuke category",
     "tma_other_light_ops_group": "Metrics contributing to tma_other_light_=
ops category",
     "tma_ports_utilization_group": "Metrics contributing to tma_ports_util=
ization category",
     "tma_ports_utilized_0_group": "Metrics contributing to tma_ports_utili=
zed_0 category",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/pe=
rf/pmu-events/arch/x86/alderlake/other.json
index 5250a17d9cae..f95e093f8fcf 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "ASSISTS.HARDWARE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.HARDWARE",
         "SampleAfterValue": "100003",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "ASSISTS.PAGE_FAULT",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.PAGE_FAULT",
         "SampleAfterValue": "1000003",
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "CORE_POWER.LICENSE_1",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_1",
         "SampleAfterValue": "200003",
@@ -25,6 +28,7 @@
     },
     {
         "BriefDescription": "CORE_POWER.LICENSE_2",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_2",
         "SampleAfterValue": "200003",
@@ -33,6 +37,7 @@
     },
     {
         "BriefDescription": "CORE_POWER.LICENSE_3",
+        "Counter": "0,1,2,3",
         "EventCode": "0x28",
         "EventName": "CORE_POWER.LICENSE_3",
         "SampleAfterValue": "200003",
@@ -41,6 +46,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xe4",
         "EventName": "LBR_INSERTS.ANY",
@@ -51,6 +57,7 @@
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.COREWB_M.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -61,6 +68,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -71,6 +79,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -81,6 +90,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y DRAM.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_DATA_RD.DRAM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -91,6 +101,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -101,6 +112,7 @@
     },
     {
         "BriefDescription": "Counts demand read for ownership (RFO) reques=
ts and software prefetches for exclusive ownership (PREFETCHW) that have an=
y type of response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -111,6 +123,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -121,6 +134,7 @@
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x2A,0x2B",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -131,6 +145,7 @@
     },
     {
         "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 for the thread.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa5",
         "EventName": "RS.EMPTY",
         "PublicDescription": "Counts cycles during which the reservation s=
tation (RS) is empty for this logical processor. This is usually caused whe=
n the front-end pipeline runs into starvation periods (e.g. branch mispredi=
ctions or i-cache misses)",
@@ -140,6 +155,7 @@
     },
     {
         "BriefDescription": "Counts end of periods where the Reservation S=
tation (RS) was empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xa5",
@@ -150,8 +166,18 @@
         "UMask": "0x7",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles when Reservation Station (RS) is empty=
 due to a resource in the back-end",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa5",
+        "EventName": "RS.EMPTY_RESOURCE",
+        "SampleAfterValue": "1000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY_COUNT",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EdgeDetect": "1",
@@ -164,6 +190,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
RS.EMPTY",
+        "Counter": "0,1,2,3,4,5,6,7",
         "Deprecated": "1",
         "EventCode": "0xa5",
         "EventName": "RS_EMPTY.CYCLES",
@@ -171,8 +198,18 @@
         "UMask": "0x7",
         "Unit": "cpu_core"
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
+        "UMask": "0x4",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Cycles the uncore cannot take further request=
s",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x2d",
         "EventName": "XQ.FULL_CYCLES",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/alderlake/pipeline.json
index df6032e816d4..b7656f77dee9 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.DIV_ACTIVE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EventCode": "0xb0",
@@ -11,6 +12,7 @@
     },
     {
         "BriefDescription": "Cycles when divide unit is busy executing div=
ide or square root operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.DIV_ACTIVE",
@@ -21,6 +23,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.FPDIV_ACTIVE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EventCode": "0xb0",
@@ -31,6 +34,7 @@
     },
     {
         "BriefDescription": "This event counts the cycles the integer divi=
der is busy.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb0",
         "EventName": "ARITH.IDIV_ACTIVE",
@@ -40,6 +44,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
ARITH.IDIV_ACTIVE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EventCode": "0xb0",
@@ -50,6 +55,7 @@
     },
     {
         "BriefDescription": "Number of occurrences where a microcode assis=
t is invoked by hardware.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc1",
         "EventName": "ASSISTS.ANY",
         "PublicDescription": "Counts the number of occurrences where a mic=
rocode assist is invoked by hardware. Examples include AD (page Access Dirt=
y), FP and AVX related assists.",
@@ -59,6 +65,7 @@
     },
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -68,6 +75,7 @@
     },
     {
         "BriefDescription": "All branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -77,6 +85,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_CALL",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.CALL",
@@ -87,6 +96,7 @@
     },
     {
         "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
         "PEBS": "1",
@@ -96,6 +106,7 @@
     },
     {
         "BriefDescription": "Conditional branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
         "PEBS": "1",
@@ -106,6 +117,7 @@
     },
     {
         "BriefDescription": "Not taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_NTAKEN",
         "PEBS": "1",
@@ -116,6 +128,7 @@
     },
     {
         "BriefDescription": "Counts the number of taken JCC (Jump on Condi=
tional Code) branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
         "PEBS": "1",
@@ -125,6 +138,7 @@
     },
     {
         "BriefDescription": "Taken conditional branch instructions retired=
.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
         "PEBS": "1",
@@ -135,6 +149,7 @@
     },
     {
         "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -144,6 +159,7 @@
     },
     {
         "BriefDescription": "Far branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -154,6 +170,7 @@
     },
     {
         "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
         "PEBS": "1",
@@ -163,6 +180,7 @@
     },
     {
         "BriefDescription": "Indirect near branch instructions retired (ex=
cluding returns)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
         "PEBS": "1",
@@ -173,6 +191,7 @@
     },
     {
         "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
         "PEBS": "1",
@@ -182,6 +201,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
@@ -192,6 +212,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.JCC",
@@ -202,6 +223,7 @@
     },
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -211,6 +233,7 @@
     },
     {
         "BriefDescription": "Direct and indirect near call instructions re=
tired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -221,6 +244,7 @@
     },
     {
         "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
@@ -230,6 +254,7 @@
     },
     {
         "BriefDescription": "Return instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
@@ -240,6 +265,7 @@
     },
     {
         "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -249,6 +275,7 @@
     },
     {
         "BriefDescription": "Taken branch instructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -259,6 +286,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
@@ -269,6 +297,7 @@
     },
     {
         "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "1",
@@ -278,6 +307,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_RETURN",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.RETURN",
@@ -288,6 +318,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND_TAKEN",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
@@ -298,6 +329,7 @@
     },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -307,6 +339,7 @@
     },
     {
         "BriefDescription": "All mispredicted branch instructions retired.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -316,6 +349,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted JCC (Jump o=
n Conditional Code) branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
         "PEBS": "1",
@@ -325,6 +359,7 @@
     },
     {
         "BriefDescription": "Mispredicted conditional branch instructions =
retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
         "PEBS": "1",
@@ -335,6 +370,7 @@
     },
     {
         "BriefDescription": "Mispredicted non-taken conditional branch ins=
tructions retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
         "PEBS": "1",
@@ -345,6 +381,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted taken JCC (=
Jump on Conditional Code) branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
         "PEBS": "1",
@@ -354,6 +391,7 @@
     },
     {
         "BriefDescription": "number of branch instructions retired that we=
re mispredicted and taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
         "PEBS": "1",
@@ -364,6 +402,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
         "PEBS": "1",
@@ -373,6 +412,7 @@
     },
     {
         "BriefDescription": "Miss-predicted near indirect branch instructi=
ons retired (excluding returns)",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
         "PEBS": "1",
@@ -383,6 +423,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
         "PEBS": "1",
@@ -392,6 +433,7 @@
     },
     {
         "BriefDescription": "Mispredicted indirect CALL retired.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
         "PEBS": "1",
@@ -402,6 +444,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT_CALL",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
@@ -412,6 +455,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.JCC",
@@ -422,6 +466,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -431,6 +476,7 @@
     },
     {
         "BriefDescription": "Number of near branch instructions retired th=
at were mispredicted and taken.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -441,6 +487,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
@@ -451,6 +498,7 @@
     },
     {
         "BriefDescription": "This event counts the number of mispredicted =
ret instructions retired. Non PEBS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RET",
         "PEBS": "1",
@@ -461,6 +509,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "1",
@@ -470,6 +519,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND_TAKEN",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
@@ -480,6 +530,7 @@
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.1 li=
ght-weight slower wakeup time but more power saving optimized state.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C01",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 light-weight slower wakeup time but more power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
@@ -489,6 +540,7 @@
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.2 li=
ght-weight faster wakeup time but less power saving optimized state.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C02",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.2 light-weight faster wakeup time but less power saving optimized state=
.  This state can be entered via the TPAUSE or UMWAIT instructions.",
@@ -498,6 +550,7 @@
     },
     {
         "BriefDescription": "Core clocks when the thread is in the C0.1 or=
 C0.2 or running a PAUSE in C0 ACPI state.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.C0_WAIT",
         "PublicDescription": "Counts core clocks when the thread is in the=
 C0.1 or C0.2 power saving optimized states (TPAUSE or UMWAIT instructions)=
 or running the PAUSE instruction.",
@@ -507,6 +560,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es. (Fixed event)",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.CORE",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses fixed counter 1.",
         "SampleAfterValue": "2000003",
@@ -515,6 +569,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.CORE_P",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state. The core enters the halt state when it is runni=
ng the HLT instruction. The core frequency may change from time to time. Fo=
r this reason this event may have a changing ratio with regards to time. Th=
is event uses a programmable general purpose performance counter.",
@@ -523,6 +578,7 @@
     },
     {
         "BriefDescription": "Cycle counts are evenly distributed between a=
ctive threads in the Core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.DISTRIBUTED",
         "PublicDescription": "This event distributes cycle counts between =
active hyperthreads, i.e., those in C0.  A hyperthread becomes inactive whe=
n it executes the HLT or MWAIT instructions.  If all other hyperthreads are=
 inactive (or disabled or do not exist), all counts are attributed to this =
hyperthread. To obtain the full count when the Core is active, sum the coun=
ts from each hyperthread.",
@@ -532,6 +588,7 @@
     },
     {
         "BriefDescription": "Core crystal clock cycles when this thread is=
 unhalted and the other thread is halted.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE",
         "PublicDescription": "Counts Core crystal clock cycles when curren=
t thread is unhalted and the other thread is halted.",
@@ -541,6 +598,7 @@
     },
     {
         "BriefDescription": "CPU_CLK_UNHALTED.PAUSE",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xec",
         "EventName": "CPU_CLK_UNHALTED.PAUSE",
         "SampleAfterValue": "2000003",
@@ -549,6 +607,7 @@
     },
     {
         "BriefDescription": "CPU_CLK_UNHALTED.PAUSE_INST",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xec",
@@ -559,6 +618,7 @@
     },
     {
         "BriefDescription": "Core crystal clock cycles. Cycle counts are e=
venly distributed between active threads in the Core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_DISTRIBUTED",
         "PublicDescription": "This event distributes Core crystal clock cy=
cle counts between active hyperthreads, i.e., those in C0 sleep-state. A hy=
perthread becomes inactive when it executes the HLT or MWAIT instructions. =
If one thread is active in a core, all counts are attributed to this hypert=
hread. To obtain the full count when the Core is active, sum the counts fro=
m each hyperthread.",
@@ -568,6 +628,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency. (Fixed event)",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses fixed counter 2.",
         "SampleAfterValue": "2000003",
@@ -576,6 +637,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "Fixed counter 2",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the eight programmable counte=
rs available for other events. Note: On all current platforms this event st=
ops counting during 'throttling (TM)' states duty off periods the processor=
 is 'halted'.  The counter update is done at a lower clock rate then the co=
re clock the overflow status bit for this counter may appear 'sticky'.  Aft=
er the counter has overflowed and software clears the overflow status bit a=
nd resets the counter to less than MAX. The reset value to the counter is n=
ot clocked immediately so the overflow status bit will flip 'high (1)' and =
generate another PMI (if enabled) after which the reset value gets clocked =
into the counter. Therefore, software will get the interrupt, read the over=
flow status bit '1 for bit 34 while the counter value is less than MAX. Sof=
tware should ignore this case.",
         "SampleAfterValue": "2000003",
@@ -584,6 +646,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted reference clock=
 cycles at TSC frequency.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PublicDescription": "Counts the number of reference cycles that t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction. This event is not affected by core frequency ch=
anges and increments at a fixed frequency that is also used for the Time St=
amp Counter (TSC). This event uses a programmable general purpose performan=
ce counter.",
@@ -593,6 +656,7 @@
     },
     {
         "BriefDescription": "Reference cycles when the core is not in halt=
 state.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
         "PublicDescription": "Counts the number of reference cycles when t=
he core is not in a halt state. The core enters the halt state when it is r=
unning the HLT instruction or the MWAIT instruction. This event is not affe=
cted by core frequency changes (for example, P states, TM2 transitions) but=
 has the same incrementing frequency as the time stamp counter. This event =
can approximate elapsed time while the core was not in a halt state. It is =
counted on a dedicated fixed counter, leaving the four (eight when Hyperthr=
eading is disabled) programmable counters available for other events. Note:=
 On all current platforms this event stops counting during 'throttling (TM)=
' states duty off periods the processor is 'halted'.  The counter update is=
 done at a lower clock rate then the core clock the overflow status bit for=
 this counter may appear 'sticky'.  After the counter has overflowed and so=
ftware clears the overflow status bit and resets the counter to less than M=
AX. The reset value to the counter is not clocked immediately so the overfl=
ow status bit will flip 'high (1)' and generate another PMI (if enabled) af=
ter which the reset value gets clocked into the counter. Therefore, softwar=
e will get the interrupt, read the overflow status bit '1 for bit 34 while =
the counter value is less than MAX. Software should ignore this case.",
@@ -602,6 +666,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es. (Fixed event)",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. The core frequency may change from time to time. F=
or this reason this event may have a changing ratio with regards to time.  =
This event uses fixed counter 1.",
         "SampleAfterValue": "2000003",
@@ -610,6 +675,7 @@
     },
     {
         "BriefDescription": "Core cycles when the thread is not in halt st=
ate",
+        "Counter": "Fixed counter 1",
         "EventName": "CPU_CLK_UNHALTED.THREAD",
         "PublicDescription": "Counts the number of core cycles while the t=
hread is not in a halt state. The thread enters the halt state when it is r=
unning the HLT instruction. This event is a component in many key event rat=
ios. The core frequency may change from time to time due to transitions ass=
ociated with Enhanced Intel SpeedStep Technology or TM2. For this reason th=
is event may have a changing ratio with regards to time. When the core freq=
uency is constant, this event can approximate elapsed time while the core w=
as not in the halt state. It is counted on a dedicated fixed counter, leavi=
ng the eight programmable counters available for other events.",
         "SampleAfterValue": "2000003",
@@ -618,6 +684,7 @@
     },
     {
         "BriefDescription": "Counts the number of unhalted core clock cycl=
es.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PublicDescription": "Counts the number of core cycles while the c=
ore is not in a halt state.  The core enters the halt state when it is runn=
ing the HLT instruction. The core frequency may change from time to time. F=
or this reason this event may have a changing ratio with regards to time. T=
his event uses a programmable general purpose performance counter.",
@@ -626,6 +693,7 @@
     },
     {
         "BriefDescription": "Thread cycles when thread is not in halt stat=
e",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0x3c",
         "EventName": "CPU_CLK_UNHALTED.THREAD_P",
         "PublicDescription": "This is an architectural event that counts t=
he number of thread cycles while the thread is not in a halt state. The thr=
ead enters the halt state when it is running the HLT instruction. The core =
frequency may change from time to time due to power or thermal throttling. =
For this reason, this event may have a changing ratio with regards to wall =
clock time.",
@@ -634,6 +702,7 @@
     },
     {
         "BriefDescription": "Cycles while L1 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
         "CounterMask": "8",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L1D_MISS",
@@ -643,6 +712,7 @@
     },
     {
         "BriefDescription": "Cycles while L2 cache miss demand load is out=
standing.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_L2_MISS",
@@ -652,6 +722,7 @@
     },
     {
         "BriefDescription": "Cycles while memory subsystem has an outstand=
ing load.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "16",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.CYCLES_MEM_ANY",
@@ -661,6 +732,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L1 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "12",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L1D_MISS",
@@ -670,6 +742,7 @@
     },
     {
         "BriefDescription": "Execution stalls while L2 cache miss demand l=
oad is outstanding.",
+        "Counter": "0,1,2,3",
         "CounterMask": "5",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_L2_MISS",
@@ -679,6 +752,7 @@
     },
     {
         "BriefDescription": "Total execution stalls.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xa3",
         "EventName": "CYCLE_ACTIVITY.STALLS_TOTAL",
@@ -688,6 +762,7 @@
     },
     {
         "BriefDescription": "Cycles total of 1 uop is executed on all port=
s and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.1_PORTS_UTIL",
         "PublicDescription": "Counts cycles during which a total of 1 uop =
was executed on all ports and Reservation Station (RS) was not empty.",
@@ -695,8 +770,18 @@
         "UMask": "0x2",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Cycles total of 2 or 3 uops are executed on a=
ll ports and Reservation Station (RS) was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "EventCode": "0xa6",
+        "EventName": "EXE_ACTIVITY.2_3_PORTS_UTIL",
+        "SampleAfterValue": "2000003",
+        "UMask": "0xc",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Cycles total of 2 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.2_PORTS_UTIL",
         "PublicDescription": "Counts cycles during which a total of 2 uops=
 were executed on all ports and Reservation Station (RS) was not empty.",
@@ -706,6 +791,7 @@
     },
     {
         "BriefDescription": "Cycles total of 3 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.3_PORTS_UTIL",
         "PublicDescription": "Cycles total of 3 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
@@ -715,6 +801,7 @@
     },
     {
         "BriefDescription": "Cycles total of 4 uops are executed on all po=
rts and Reservation Station was not empty.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.4_PORTS_UTIL",
         "PublicDescription": "Cycles total of 4 uops are executed on all p=
orts and Reservation Station (RS) was not empty.",
@@ -724,6 +811,7 @@
     },
     {
         "BriefDescription": "Execution stalls while memory subsystem has a=
n outstanding load.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "5",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_LOADS",
@@ -733,6 +821,7 @@
     },
     {
         "BriefDescription": "Cycles where the Store Buffer was full and no=
 loads caused an execution stall.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.BOUND_ON_STORES",
@@ -743,6 +832,7 @@
     },
     {
         "BriefDescription": "Cycles no uop executed while RS was not empty=
, the SB was not full and there was no outstanding load.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa6",
         "EventName": "EXE_ACTIVITY.EXE_BOUND_0_PORTS",
         "PublicDescription": "Number of cycles total of 0 uops executed on=
 all ports, Reservation Station (RS) was not empty, the Store Buffer (SB) w=
as not full and there was no outstanding load.",
@@ -752,6 +842,7 @@
     },
     {
         "BriefDescription": "Instruction decoders utilized in a cycle",
+        "Counter": "0,1,2,3",
         "EventCode": "0x75",
         "EventName": "INST_DECODED.DECODERS",
         "PublicDescription": "Number of decoders utilized in a cycle when =
the MITE (legacy decode pipeline) fetches instructions.",
@@ -761,6 +852,7 @@
     },
     {
         "BriefDescription": "Counts the total number of instructions retir=
ed. (Fixed event)",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the total number of instructions that=
 retired. For instructions that consist of multiple uops, this event counts=
 the retirement of the last uop of the instruction. This event continues co=
unting during hardware interrupts, traps, and inside interrupt handlers. Th=
is event uses fixed counter 0.",
@@ -770,6 +862,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. Fixed Counter=
 - architectural event",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.ANY",
         "PEBS": "1",
         "PublicDescription": "Counts the number of X86 instructions retire=
d - an Architectural PerfMon event. Counting continues during hardware inte=
rrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is co=
unted by a designated fixed counter freeing up programmable counters to cou=
nt other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
@@ -779,6 +872,7 @@
     },
     {
         "BriefDescription": "Counts the total number of instructions retir=
ed.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
@@ -788,6 +882,7 @@
     },
     {
         "BriefDescription": "Number of instructions retired. General Count=
er - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
@@ -797,6 +892,7 @@
     },
     {
         "BriefDescription": "INST_RETIRED.MACRO_FUSED",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.MACRO_FUSED",
         "PEBS": "1",
@@ -806,6 +902,7 @@
     },
     {
         "BriefDescription": "Retired NOP instructions.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.NOP",
         "PEBS": "1",
@@ -816,6 +913,7 @@
     },
     {
         "BriefDescription": "Precise instruction retired with PEBS precise=
-distribution",
+        "Counter": "Fixed counter 0",
         "EventName": "INST_RETIRED.PREC_DIST",
         "PEBS": "1",
         "PublicDescription": "A version of INST_RETIRED that allows for a =
precise distribution of samples across instructions retired. It utilizes th=
e Precise Distribution of Instructions Retired (PDIR++) feature to fix bias=
 in how retired instructions get sampled. Use on Fixed Counter 0.",
@@ -825,6 +923,7 @@
     },
     {
         "BriefDescription": "Iterations of Repeat string retired instructi=
ons.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.REP_ITERATION",
         "PEBS": "1",
@@ -835,6 +934,7 @@
     },
     {
         "BriefDescription": "Clears speculative count",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xad",
@@ -846,6 +946,7 @@
     },
     {
         "BriefDescription": "Counts cycles after recovery from a branch mi=
sprediction or machine clear till the first uop is issued from the resteere=
d path.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.CLEAR_RESTEER_CYCLES",
         "PublicDescription": "Cycles after recovery from a branch mispredi=
ction or machine clear till the first uop is issued from the resteered path=
.",
@@ -855,6 +956,7 @@
     },
     {
         "BriefDescription": "Core cycles the allocator was stalled due to =
recovery from earlier clear event for this thread",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.RECOVERY_CYCLES",
         "PublicDescription": "Counts core cycles when the Resource allocat=
or was stalled due to recovery from an earlier branch misprediction or mach=
ine clear event.",
@@ -864,6 +966,7 @@
     },
     {
         "BriefDescription": "Bubble cycles of BAClear (Unknown Branch).",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
         "MSRIndex": "0x3F7",
@@ -874,6 +977,7 @@
     },
     {
         "BriefDescription": "TMA slots where uops got dropped",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xad",
         "EventName": "INT_MISC.UOP_DROPPING",
         "PublicDescription": "Estimated number of Top-down Microarchitectu=
re Analysis slots that got dropped due to non front-end reasons",
@@ -883,6 +987,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.128BIT",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.128BIT",
         "SampleAfterValue": "1000003",
@@ -891,6 +996,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.256BIT",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.256BIT",
         "SampleAfterValue": "1000003",
@@ -899,6 +1005,7 @@
     },
     {
         "BriefDescription": "integer ADD, SUB, SAD 128-bit vector instruct=
ions.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_128",
         "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 128-bit vector instructions.",
@@ -908,6 +1015,7 @@
     },
     {
         "BriefDescription": "integer ADD, SUB, SAD 256-bit vector instruct=
ions.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.ADD_256",
         "PublicDescription": "Number of retired integer ADD/SUB (regular o=
r horizontal), SAD 256-bit vector instructions.",
@@ -917,6 +1025,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.MUL_256",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.MUL_256",
         "SampleAfterValue": "1000003",
@@ -925,6 +1034,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.SHUFFLES",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.SHUFFLES",
         "SampleAfterValue": "1000003",
@@ -933,6 +1043,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.VNNI_128",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_128",
         "SampleAfterValue": "1000003",
@@ -941,6 +1052,7 @@
     },
     {
         "BriefDescription": "INT_VEC_RETIRED.VNNI_256",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe7",
         "EventName": "INT_VEC_RETIRED.VNNI_256",
         "SampleAfterValue": "1000003",
@@ -949,6 +1061,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
LD_BLOCKS.ADDRESS_ALIAS",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
@@ -959,6 +1072,7 @@
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
         "PEBS": "1",
@@ -968,6 +1082,7 @@
     },
     {
         "BriefDescription": "False dependencies in MOB due to partial comp=
are on address.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
         "PublicDescription": "Counts the number of times a load got blocke=
d due to false dependencies in MOB due to partial compare on address.",
@@ -977,6 +1092,7 @@
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
         "PEBS": "1",
@@ -986,6 +1102,7 @@
     },
     {
         "BriefDescription": "The number of times that split load operation=
s are temporarily blocked because all resources for handling the split acce=
sses are in use.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.NO_SR",
         "PublicDescription": "Counts the number of times that split load o=
perations are temporarily blocked because all resources for handling the sp=
lit accesses are in use.",
@@ -995,6 +1112,7 @@
     },
     {
         "BriefDescription": "Loads blocked due to overlapping with a prece=
ding store that cannot be forwarded.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.STORE_FORWARD",
         "PublicDescription": "Counts the number of times where store forwa=
rding was prevented for a load operation. The most common case is a load bl=
ocked due to the address of memory access (partially) overlapping with a pr=
eceding uncompleted store. Note: See the table of not supported store forwa=
rds in the Optimization Guide.",
@@ -1004,6 +1122,7 @@
     },
     {
         "BriefDescription": "Counts the number of demand load dispatches t=
hat hit L1D fill buffer (FB) allocated for software prefetch.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x4c",
         "EventName": "LOAD_HIT_PREFETCH.SWPF",
         "PublicDescription": "Counts all not software-prefetch load dispat=
ches that hit the fill buffer (FB) allocated for the software prefetch. It =
can also be incremented by some lock instructions. So it should only be use=
d with profiling so that the locks can be excluded by ASM (Assembly File) i=
nspection of the nearby instructions.",
@@ -1013,6 +1132,7 @@
     },
     {
         "BriefDescription": "Cycles Uops delivered by the LSD, but didn't =
come from the decoder.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_ACTIVE",
@@ -1023,6 +1143,7 @@
     },
     {
         "BriefDescription": "Cycles optimal number of Uops delivered by th=
e LSD, but did not come from the decoder.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "6",
         "EventCode": "0xa8",
         "EventName": "LSD.CYCLES_OK",
@@ -1033,6 +1154,7 @@
     },
     {
         "BriefDescription": "Number of Uops delivered by the LSD.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa8",
         "EventName": "LSD.UOPS",
         "PublicDescription": "Counts the number of uops delivered to the b=
ack-end by the LSD(Loop Stream Detector).",
@@ -1042,6 +1164,7 @@
     },
     {
         "BriefDescription": "Number of machine clears (nukes) of any type.=
",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EdgeDetect": "1",
         "EventCode": "0xc3",
@@ -1053,6 +1176,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
         "SampleAfterValue": "20003",
@@ -1061,6 +1185,7 @@
     },
     {
         "BriefDescription": "Counts the number of machines clears due to m=
emory renaming.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MRN_NUKE",
         "SampleAfterValue": "1000003",
@@ -1069,6 +1194,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to a =
page fault.  Counts both I-Side and D-Side (Loads/Stores) page faults.  A p=
age fault occurs when either the page is not present, or an access violatio=
n occurs.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.PAGE_FAULT",
         "SampleAfterValue": "20003",
@@ -1077,6 +1203,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears that flus=
h the pipeline and restart the machine with the use of microcode due to SMC=
, MEMORY_ORDERING, FP_ASSISTS, PAGE_FAULT, DISAMBIGUATION, and FPC_VIRTUAL_=
TRAP.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SLOW",
         "SampleAfterValue": "20003",
@@ -1085,6 +1212,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (self modifying code) within 1K of a recently fetched =
code page.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
         "SampleAfterValue": "20003",
@@ -1093,6 +1221,7 @@
     },
     {
         "BriefDescription": "Self-modifying code (SMC) detected.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
         "PublicDescription": "Counts self-modifying code (SMC) detected, w=
hich causes a machine clear.",
@@ -1102,6 +1231,7 @@
     },
     {
         "BriefDescription": "LFENCE instructions retired",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xe0",
         "EventName": "MISC2_RETIRED.LFENCE",
         "PublicDescription": "number of LFENCE retired instructions",
@@ -1111,6 +1241,7 @@
     },
     {
         "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL. [This event is alias to LBR_INSE=
RTS.ANY]",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
         "PEBS": "1",
@@ -1121,6 +1252,7 @@
     },
     {
         "BriefDescription": "Increments whenever there is an update to the=
 LBR array.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xcc",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
         "PublicDescription": "Increments when an entry is added to the Las=
t Branch Record (LBR) array (or removed from the array in case of RETURNs i=
n call stack mode). The event requires LBR enable via IA32_DEBUGCTL MSR and=
 branch type selection via MSR_LBR_SELECT.",
@@ -1130,6 +1262,7 @@
     },
     {
         "BriefDescription": "Cycles stalled due to no store buffers availa=
ble. (not including draining form sync).",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SB",
         "PublicDescription": "Counts allocation stall cycles caused by the=
 store buffer (SB) being full. This counts cycles that the pipeline back-en=
d blocked uop delivery from the front-end.",
@@ -1139,6 +1272,7 @@
     },
     {
         "BriefDescription": "Counts cycles where the pipeline is stalled d=
ue to serializing operations.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa2",
         "EventName": "RESOURCE_STALLS.SCOREBOARD",
         "SampleAfterValue": "100003",
@@ -1147,6 +1281,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots not consumed=
 by the backend due to a micro-sequencer (MS) scoreboard, which stalls the =
front-end from issuing from the UROM until a specified older uop retires.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x75",
         "EventName": "SERIALIZATION.NON_C01_MS_SCB",
         "PublicDescription": "Counts the number of issue slots not consume=
d by the backend due to a micro-sequencer (MS) scoreboard, which stalls the=
 front-end from issuing from the UROM until a specified older uop retires. =
The most commonly executed instruction with an MS scoreboard is PAUSE.",
@@ -1156,6 +1291,7 @@
     },
     {
         "BriefDescription": "TMA slots where no uops were being issued due=
 to lack of back-end resources.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
         "PublicDescription": "Number of slots in TMA method where no micro=
-operations were being issued from front-end to back-end of the machine due=
 to lack of back-end resources.",
@@ -1165,6 +1301,7 @@
     },
     {
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
s.",
+        "Counter": "0",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BAD_SPEC_SLOTS",
         "PublicDescription": "Number of slots of TMA method that were wast=
ed due to incorrect speculation. It covers all types of control-flow or dat=
a-related mis-speculations.",
@@ -1174,6 +1311,7 @@
     },
     {
         "BriefDescription": "TMA slots wasted due to incorrect speculation=
 by branch mispredictions",
+        "Counter": "0",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
         "PublicDescription": "Number of TMA slots that were wasted due to =
incorrect speculation by (any type of) branch mispredictions. This event es=
timates number of speculative operations that were issued but not retired a=
s well as the out-of-order engine recovery past a branch misprediction.",
@@ -1183,6 +1321,7 @@
     },
     {
         "BriefDescription": "TOPDOWN.MEMORY_BOUND_SLOTS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.MEMORY_BOUND_SLOTS",
         "SampleAfterValue": "10000003",
@@ -1191,6 +1330,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. Fixed counter - architectural event",
+        "Counter": "Fixed counter 3",
         "EventName": "TOPDOWN.SLOTS",
         "PublicDescription": "Number of available slots for an unhalted lo=
gical processor. The event increments by machine-width of the narrowest pip=
eline as employed by the Top-down Microarchitecture Analysis method (TMA). =
The count is distributed among unhalted logical processors (hyper-threads) =
who share the same physical core. Software can use this event as the denomi=
nator for the top-level metrics of the TMA method. This architectural event=
 is counted on a designated fixed counter (Fixed Counter 3).",
         "SampleAfterValue": "10000003",
@@ -1199,6 +1339,7 @@
     },
     {
         "BriefDescription": "TMA slots available for an unhalted logical p=
rocessor. General counter - architectural event",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xa4",
         "EventName": "TOPDOWN.SLOTS_P",
         "PublicDescription": "Counts the number of available slots for an =
unhalted logical processor. The event increments by machine-width of the na=
rrowest pipeline as employed by the Top-down Microarchitecture Analysis met=
hod. The count is distributed among unhalted logical processors (hyper-thre=
ads) who share the same physical core.",
@@ -1208,6 +1349,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
         "PublicDescription": "Counts the total number of issue slots that =
were not consumed by the backend because allocation is stalled due to a mis=
predicted jump or a machine clear. Only issue slots wasted due to fast nuke=
s such as memory ordering nukes are counted. Other nukes are not accounted =
for. Counts all issue slots blocked during this recovery window including r=
elevant microcode flows and while uops are not yet available in the instruc=
tion queue (IQ) even if an FE_bound event occurs during this period. Also i=
ncludes the issue slots that were consumed by the backend but were thrown a=
way because they were younger than the mispredict or machine clear.",
@@ -1216,6 +1358,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to fast nukes such as memory orde=
ring and memory disambiguation machine clears.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
         "SampleAfterValue": "1000003",
@@ -1224,6 +1367,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS",
         "SampleAfterValue": "1000003",
@@ -1232,6 +1376,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to branch mispredicts.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
         "SampleAfterValue": "1000003",
@@ -1240,6 +1385,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
         "SampleAfterValue": "1000003",
@@ -1248,6 +1394,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to backend stalls.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
         "SampleAfterValue": "1000003",
@@ -1255,6 +1402,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to certain allocation restriction=
s.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
         "SampleAfterValue": "1000003",
@@ -1263,6 +1411,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stalls in w=
hich a scheduler is not able to accept uops.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
         "SampleAfterValue": "1000003",
@@ -1271,6 +1420,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to IEC or FPC RAT stalls, which c=
an be due to FIQ or IEC reservation stalls in which the integer, floating p=
oint or SIMD scheduler is not able to accept uops.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER",
         "SampleAfterValue": "1000003",
@@ -1279,6 +1429,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the physical register file una=
ble to accept an entry (marble stalls).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.REGISTER",
         "SampleAfterValue": "1000003",
@@ -1287,6 +1438,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the reorder buffer being full =
(ROB stalls).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
         "SampleAfterValue": "1000003",
@@ -1295,6 +1447,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to scoreboards from the instructi=
on queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
         "SampleAfterValue": "1000003",
@@ -1303,6 +1456,7 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to frontend stalls.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003",
@@ -1310,6 +1464,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BACLEARS.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_DETECT",
         "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BACLEARS, which occurs when=
 the Branch Target Buffer (BTB) prediction or lack thereof, was corrected b=
y a later branch predictor in the frontend. Includes BACLEARS due to all br=
anch types including conditional and unconditional jumps, returns, and indi=
rect branches.",
@@ -1319,6 +1474,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to BTCLEARS.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.BRANCH_RESTEER",
         "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to BTCLEARS, which occurs when=
 the Branch Target Buffer (BTB) predicts a taken branch.",
@@ -1328,6 +1484,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to the microcode sequencer (MS)=
.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.CISC",
         "SampleAfterValue": "1000003",
@@ -1336,6 +1493,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stalls.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.DECODE",
         "SampleAfterValue": "1000003",
@@ -1344,6 +1502,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to frontend bandwidth restricti=
ons due to decode, predecode, cisc, and other limitations.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
         "SampleAfterValue": "1000003",
@@ -1352,6 +1511,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to a latency related stalls inc=
luding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
         "SampleAfterValue": "1000003",
@@ -1360,6 +1520,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to ITLB misses.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ITLB",
         "PublicDescription": "Counts the number of issue slots every cycle=
 that were not delivered by the frontend due to Instruction Table Lookaside=
 Buffer (ITLB) misses.",
@@ -1369,6 +1530,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to other common frontend stalls=
 not categorized.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.OTHER",
         "SampleAfterValue": "1000003",
@@ -1377,6 +1539,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to wrong predecodes.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
         "SampleAfterValue": "1000003",
@@ -1385,6 +1548,7 @@
     },
     {
         "BriefDescription": "Counts the total number of consumed retiremen=
t slots.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "PEBS": "1",
@@ -1393,6 +1557,7 @@
     },
     {
         "BriefDescription": "UOPS_DECODED.DEC0_UOPS",
+        "Counter": "0,1,2,3",
         "EventCode": "0x76",
         "EventName": "UOPS_DECODED.DEC0_UOPS",
         "SampleAfterValue": "1000003",
@@ -1401,6 +1566,7 @@
     },
     {
         "BriefDescription": "Uops executed on port 0",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_0",
         "PublicDescription": "Number of uops dispatch to execution  port 0=
.",
@@ -1410,6 +1576,7 @@
     },
     {
         "BriefDescription": "Uops executed on port 1",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_1",
         "PublicDescription": "Number of uops dispatch to execution  port 1=
.",
@@ -1419,6 +1586,7 @@
     },
     {
         "BriefDescription": "Uops executed on ports 2, 3 and 10",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_2_3_10",
         "PublicDescription": "Number of uops dispatch to execution ports 2=
, 3 and 10",
@@ -1428,6 +1596,7 @@
     },
     {
         "BriefDescription": "Uops executed on ports 4 and 9",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_4_9",
         "PublicDescription": "Number of uops dispatch to execution ports 4=
 and 9",
@@ -1437,6 +1606,7 @@
     },
     {
         "BriefDescription": "Uops executed on ports 5 and 11",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_5_11",
         "PublicDescription": "Number of uops dispatch to execution ports 5=
 and 11",
@@ -1446,6 +1616,7 @@
     },
     {
         "BriefDescription": "Uops executed on port 6",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_6",
         "PublicDescription": "Number of uops dispatch to execution  port 6=
.",
@@ -1455,6 +1626,7 @@
     },
     {
         "BriefDescription": "Uops executed on ports 7 and 8",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb2",
         "EventName": "UOPS_DISPATCHED.PORT_7_8",
         "PublicDescription": "Number of uops dispatch to execution  ports =
7 and 8.",
@@ -1464,6 +1636,7 @@
     },
     {
         "BriefDescription": "Cycles at least 1 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_1",
@@ -1474,6 +1647,7 @@
     },
     {
         "BriefDescription": "Cycles at least 2 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_2",
@@ -1484,6 +1658,7 @@
     },
     {
         "BriefDescription": "Cycles at least 3 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_3",
@@ -1494,6 +1669,7 @@
     },
     {
         "BriefDescription": "Cycles at least 4 micro-op is executed from a=
ny thread on physical core.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CORE_CYCLES_GE_4",
@@ -1504,6 +1680,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 1 uop was executed per-=
thread",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_1",
@@ -1514,6 +1691,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 2 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "2",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_2",
@@ -1524,6 +1702,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 3 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "3",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_3",
@@ -1534,6 +1713,7 @@
     },
     {
         "BriefDescription": "Cycles where at least 4 uops were executed pe=
r-thread",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "4",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.CYCLES_GE_4",
@@ -1544,6 +1724,7 @@
     },
     {
         "BriefDescription": "Counts number of cycles no uops were dispatch=
ed to be executed on this thread.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.STALLS",
@@ -1555,6 +1736,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UOPS_EXECUTED.STALLS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EventCode": "0xb1",
@@ -1566,6 +1748,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops to be executed per-=
thread each cycle.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.THREAD",
         "SampleAfterValue": "2000003",
@@ -1574,6 +1757,7 @@
     },
     {
         "BriefDescription": "Counts the number of x87 uops dispatched.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xb1",
         "EventName": "UOPS_EXECUTED.X87",
         "PublicDescription": "Counts the number of x87 uops executed.",
@@ -1581,8 +1765,18 @@
         "UMask": "0x10",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "Counts the number of uops issued by the front=
 end every cycle.",
+        "Counter": "0,1,2,3,4,5",
+        "EventCode": "0x0e",
+        "EventName": "UOPS_ISSUED.ANY",
+        "PublicDescription": "Counts the number of uops issued by the fron=
t end every cycle. When 4-uops are requested and only 2-uops are delivered,=
 the event counts 2.  Uops_issued correlates to the number of ROB entries. =
 If uop takes 2 ROB slots it counts as 2 uops_issued.",
+        "SampleAfterValue": "200003",
+        "Unit": "cpu_atom"
+    },
     {
         "BriefDescription": "Uops that RAT issues to RS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xae",
         "EventName": "UOPS_ISSUED.ANY",
         "PublicDescription": "Counts the number of uops that the Resource =
Allocation Table (RAT) issues to the Reservation Station (RS).",
@@ -1590,8 +1784,19 @@
         "UMask": "0x1",
         "Unit": "cpu_core"
     },
+    {
+        "BriefDescription": "UOPS_ISSUED.CYCLES",
+        "Counter": "0,1,2,3,4,5,6,7",
+        "CounterMask": "1",
+        "EventCode": "0xae",
+        "EventName": "UOPS_ISSUED.CYCLES",
+        "SampleAfterValue": "2000003",
+        "UMask": "0x1",
+        "Unit": "cpu_core"
+    },
     {
         "BriefDescription": "Counts the total number of uops retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.ALL",
         "PEBS": "1",
@@ -1600,6 +1805,7 @@
     },
     {
         "BriefDescription": "Cycles with retired uop(s).",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.CYCLES",
@@ -1610,6 +1816,7 @@
     },
     {
         "BriefDescription": "Retired uops except the last uop of each inst=
ruction.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.HEAVY",
         "PublicDescription": "Counts the number of retired micro-operation=
s (uops) except the last uop of each instruction. An instruction that is de=
coded into less than two uops does not contribute to the count.",
@@ -1619,6 +1826,7 @@
     },
     {
         "BriefDescription": "Counts the number of integer divide uops reti=
red.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.IDIV",
         "PEBS": "1",
@@ -1628,6 +1836,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops that are from compl=
ex flows issued by the micro-sequencer (MS).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
         "PEBS": "1",
@@ -1638,6 +1847,7 @@
     },
     {
         "BriefDescription": "UOPS_RETIRED.MS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
         "MSRIndex": "0x3F7",
@@ -1648,6 +1858,7 @@
     },
     {
         "BriefDescription": "Retirement slots used.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.SLOTS",
         "PublicDescription": "Counts the retirement slots used each cycle.=
",
@@ -1657,6 +1868,7 @@
     },
     {
         "BriefDescription": "Cycles without actually retired uops.",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.STALLS",
@@ -1668,6 +1880,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UOPS_RETIRED.STALLS",
+        "Counter": "0,1,2,3,4,5,6,7",
         "CounterMask": "1",
         "Deprecated": "1",
         "EventCode": "0xc2",
@@ -1679,6 +1892,7 @@
     },
     {
         "BriefDescription": "Counts the number of x87 uops retired, includ=
es those in MS flows.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.j=
son b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
index 8bf020a9dfa8..7c0779c74154 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Number of requests allocated in Coherency Tra=
cker.",
+        "Counter": "0,1",
         "EventCode": "0x84",
         "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
         "PerPkg": "1",
@@ -9,56 +10,69 @@
     },
     {
         "BriefDescription": "Each cycle counts number of any coherent requ=
est at memory controller that were issued by any core.",
+        "Counter": "0",
         "EventCode": "0x85",
         "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Each cycle counts number of coherent reads pe=
nding on data return from memory controller that were issued by any core.",
+        "Counter": "0",
         "EventCode": "0x85",
         "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "Counter": "0,1",
         "Deprecated": "1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_DAT_REQUESTS.RD",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
UNC_ARB_DAT_OCCUPANCY.ALL",
+        "Counter": "0",
         "Deprecated": "1",
         "EventCode": "0x85",
         "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x1",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_T=
RK_OCCUPANCY.RD]",
+        "Counter": "0",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.RD]",
+        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Each cycle counts number of all outgoing vali=
d entries in ReqTrk. Such entry is defined as valid from its allocation in =
ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
+        "Counter": "0",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
         "PerPkg": "1",
@@ -67,14 +81,17 @@
     },
     {
         "BriefDescription": "Each cycle count number of 'valid' coherent D=
ata Read entries . Such entry is defined as valid when it is allocated till=
 deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_R=
EQ_TRK_OCCUPANCY.DRD]",
+        "Counter": "0",
         "EventCode": "0x80",
         "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "ARB"
     },
     {
         "BriefDescription": "Counts the number of coherent and in-coherent=
 requests initiated by IA cores, processor graphic units, or LLC.",
+        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
         "PerPkg": "1",
@@ -83,8 +100,10 @@
     },
     {
         "BriefDescription": "Number of all coherent Data Read entries. Doe=
sn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUEST.DRD=
]",
+        "Counter": "0,1",
         "EventCode": "0x81",
         "EventName": "UNC_ARB_TRK_REQUESTS.RD",
+        "Experimental": "1",
         "PerPkg": "1",
         "UMask": "0x2",
         "Unit": "ARB"
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json b/=
tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
index 163d7e7755c4..bcf275cd592a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts every 64B read  request entering the M=
emory Controller 0 to DRAM (sum of all channels).",
+        "Counter": "0",
         "EventCode": "0xff",
         "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
         "PerPkg": "1",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Counts every 64B write request entering the M=
emory Controller 0 to DRAM (sum of all channels). Each write request counts=
 as a new request incrementing this counter. However, same cache line write=
 requests (both full and partial) are combined to a single 64 byte data tra=
nsfer to DRAM.",
+        "Counter": "1",
         "EventCode": "0xff",
         "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
         "PerPkg": "1",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Counts every 64B read request entering the Me=
mory Controller 1 to DRAM (sum of all channels).",
+        "Counter": "3",
         "EventCode": "0xff",
         "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
         "PerPkg": "1",
@@ -27,6 +30,7 @@
     },
     {
         "BriefDescription": "Counts every 64B write request entering the M=
emory Controller 1 to DRAM (sum of all channels). Each write request counts=
 as a new request incrementing this counter. However, same cache line write=
 requests (both full and partial) are combined to a single 64 byte data tra=
nsfer to DRAM.",
+        "Counter": "4",
         "EventCode": "0xff",
         "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
         "PerPkg": "1",
@@ -35,6 +39,7 @@
     },
     {
         "BriefDescription": "ACT command for a read request sent to DRAM",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x24",
         "EventName": "UNC_M_ACT_COUNT_RD",
         "PerPkg": "1",
@@ -42,6 +47,7 @@
     },
     {
         "BriefDescription": "ACT command sent to DRAM",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x26",
         "EventName": "UNC_M_ACT_COUNT_TOTAL",
         "PerPkg": "1",
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "ACT command for a write request sent to DRAM"=
,
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x25",
         "EventName": "UNC_M_ACT_COUNT_WR",
         "PerPkg": "1",
@@ -56,6 +63,7 @@
     },
     {
         "BriefDescription": "Read CAS command sent to DRAM",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x22",
         "EventName": "UNC_M_CAS_COUNT_RD",
         "PerPkg": "1",
@@ -63,6 +71,7 @@
     },
     {
         "BriefDescription": "Write CAS command sent to DRAM",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x23",
         "EventName": "UNC_M_CAS_COUNT_WR",
         "PerPkg": "1",
@@ -70,6 +79,7 @@
     },
     {
         "BriefDescription": "Number of clocks",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x01",
         "EventName": "UNC_M_CLOCKTICKS",
         "PerPkg": "1",
@@ -77,6 +87,7 @@
     },
     {
         "BriefDescription": "incoming read request page status is Page Emp=
ty",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x1D",
         "EventName": "UNC_M_DRAM_PAGE_EMPTY_RD",
         "PerPkg": "1",
@@ -84,6 +95,7 @@
     },
     {
         "BriefDescription": "incoming write request page status is Page Em=
pty",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x20",
         "EventName": "UNC_M_DRAM_PAGE_EMPTY_WR",
         "PerPkg": "1",
@@ -91,6 +103,7 @@
     },
     {
         "BriefDescription": "incoming read request page status is Page Hit=
",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x1C",
         "EventName": "UNC_M_DRAM_PAGE_HIT_RD",
         "PerPkg": "1",
@@ -98,6 +111,7 @@
     },
     {
         "BriefDescription": "incoming write request page status is Page Hi=
t",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x1F",
         "EventName": "UNC_M_DRAM_PAGE_HIT_WR",
         "PerPkg": "1",
@@ -105,6 +119,7 @@
     },
     {
         "BriefDescription": "incoming read request page status is Page Mis=
s",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x1E",
         "EventName": "UNC_M_DRAM_PAGE_MISS_RD",
         "PerPkg": "1",
@@ -112,6 +127,7 @@
     },
     {
         "BriefDescription": "incoming write request page status is Page Mi=
ss",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x21",
         "EventName": "UNC_M_DRAM_PAGE_MISS_WR",
         "PerPkg": "1",
@@ -119,6 +135,7 @@
     },
     {
         "BriefDescription": "Any Rank at Hot state",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x19",
         "EventName": "UNC_M_DRAM_THERMAL_HOT",
         "PerPkg": "1",
@@ -126,6 +143,7 @@
     },
     {
         "BriefDescription": "Any Rank at Warm state",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x1A",
         "EventName": "UNC_M_DRAM_THERMAL_WARM",
         "PerPkg": "1",
@@ -133,6 +151,7 @@
     },
     {
         "BriefDescription": "Incoming read prefetch request from IA.",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x0A",
         "EventName": "UNC_M_PREFETCH_RD",
         "PerPkg": "1",
@@ -140,6 +159,7 @@
     },
     {
         "BriefDescription": "PRE command sent to DRAM due to page table id=
le timer expiration",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x28",
         "EventName": "UNC_M_PRE_COUNT_IDLE",
         "PerPkg": "1",
@@ -147,6 +167,7 @@
     },
     {
         "BriefDescription": "PRE command sent to DRAM for a read/write req=
uest",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x27",
         "EventName": "UNC_M_PRE_COUNT_PAGE_MISS",
         "PerPkg": "1",
@@ -154,6 +175,7 @@
     },
     {
         "BriefDescription": "Incoming VC0 read request",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x02",
         "EventName": "UNC_M_VC0_REQUESTS_RD",
         "PerPkg": "1",
@@ -161,6 +183,7 @@
     },
     {
         "BriefDescription": "Incoming VC0 write request",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x03",
         "EventName": "UNC_M_VC0_REQUESTS_WR",
         "PerPkg": "1",
@@ -168,6 +191,7 @@
     },
     {
         "BriefDescription": "Incoming VC1 read request",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x04",
         "EventName": "UNC_M_VC1_REQUESTS_RD",
         "PerPkg": "1",
@@ -175,6 +199,7 @@
     },
     {
         "BriefDescription": "Incoming VC1 write request",
+        "Counter": "0,1,2,3,4",
         "EventCode": "0x05",
         "EventName": "UNC_M_VC1_REQUESTS_WR",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b/t=
ools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
index 2af92e43b28a..1ac5b5ef8094 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
+        "Counter": "FIXED",
         "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json b=
/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
index 3827d292da80..e0d8f3070778 100644
--- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Loads that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.STLB_HIT",
         "PublicDescription": "Counts loads that miss the DTLB (Data TLB) a=
nd hit the STLB (Second level TLB).",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a demand load.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_ACTIVE",
@@ -20,6 +22,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to load DTLB misses to any page size.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x08",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts the number of page walks completed du=
e to loads (including SW prefetches) whose address translations missed in a=
ll Translation Lookaside Buffer (TLB) levels and were mapped to any page si=
ze. Includes page walks that page fault.",
@@ -29,6 +32,7 @@
     },
     {
         "BriefDescription": "Load miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data loads. This implies it missed in the DTLB and furth=
er levels of TLB. The page walk can end with or without a fault.",
@@ -38,6 +42,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 1G page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_1G",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
@@ -47,6 +52,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 2M/4M page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data loads. This implies address translations missed in the=
 DTLB and further levels of TLB. The page walk can end with or without a fa=
ult.",
@@ -56,6 +62,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data loa=
d to a 4K page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data loads. This implies address translations missed in the DT=
LB and further levels of TLB. The page walk can end with or without a fault=
.",
@@ -65,6 +72,7 @@
     },
     {
         "BriefDescription": "Number of page walks outstanding for a demand=
 load in the PMH each cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x12",
         "EventName": "DTLB_LOAD_MISSES.WALK_PENDING",
         "PublicDescription": "Counts the number of page walks outstanding =
for a demand load in the PMH (Page Miss Handler) each cycle.",
@@ -74,6 +82,7 @@
     },
     {
         "BriefDescription": "Stores that miss the DTLB and hit the STLB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.STLB_HIT",
         "PublicDescription": "Counts stores that miss the DTLB (Data TLB) =
and hit the STLB (2nd Level TLB).",
@@ -83,6 +92,7 @@
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for a store.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_ACTIVE",
@@ -93,6 +103,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to store DTLB misses to any page size.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x49",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts the number of page walks completed du=
e to stores whose address translations missed in all Translation Lookaside =
Buffer (TLB) levels and were mapped to any page size.  Includes page walks =
that page fault.",
@@ -102,6 +113,7 @@
     },
     {
         "BriefDescription": "Store misses in all TLB levels causes a page =
walk that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks  (all page sizes=
) caused by demand data stores. This implies it missed in the DTLB and furt=
her levels of TLB. The page walk can end with or without a fault.",
@@ -111,6 +123,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 1G page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_1G",
         "PublicDescription": "Counts completed page walks  (1G sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
@@ -120,6 +133,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 2M/4M page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts completed page walks  (2M/4M sizes) c=
aused by demand data stores. This implies address translations missed in th=
e DTLB and further levels of TLB. The page walk can end with or without a f=
ault.",
@@ -129,6 +143,7 @@
     },
     {
         "BriefDescription": "Page walks completed due to a demand data sto=
re to a 4K page.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts completed page walks  (4K sizes) caus=
ed by demand data stores. This implies address translations missed in the D=
TLB and further levels of TLB. The page walk can end with or without a faul=
t.",
@@ -138,6 +153,7 @@
     },
     {
         "BriefDescription": "Number of page walks outstanding for a store =
in the PMH each cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x13",
         "EventName": "DTLB_STORE_MISSES.WALK_PENDING",
         "PublicDescription": "Counts the number of page walks outstanding =
for a store in the PMH (Page Miss Handler) each cycle.",
@@ -147,6 +163,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks initiated by =
a instruction fetch that missed the first and second level TLBs.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
         "SampleAfterValue": "1000003",
@@ -155,6 +172,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks due to an ins=
truction fetch that miss the PDE (Page Directory Entry) cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.PDE_CACHE_MISS",
         "SampleAfterValue": "2000003",
@@ -163,6 +181,7 @@
     },
     {
         "BriefDescription": "Instruction fetch requests that miss the ITLB=
 and hit the STLB.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.STLB_HIT",
         "PublicDescription": "Counts instruction fetch requests that miss =
the ITLB (Instruction TLB) and hit the STLB (Second-level TLB).",
@@ -172,6 +191,7 @@
     },
     {
         "BriefDescription": "Cycles when at least one PMH is busy with a p=
age walk for code (instruction fetch) request.",
+        "Counter": "0,1,2,3",
         "CounterMask": "1",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_ACTIVE",
@@ -182,6 +202,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks completed due=
 to instruction fetch misses to any page size.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts the number of page walks completed du=
e to instruction fetches whose address translations missed in all Translati=
on Lookaside Buffer (TLB) levels and were mapped to any page size.  Include=
s page walks that page fault.",
@@ -191,6 +212,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (All page sizes)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED",
         "PublicDescription": "Counts completed page walks (all page sizes)=
 caused by a code fetch. This implies it missed in the ITLB (Instruction TL=
B) and further levels of TLB. The page walk can end with or without a fault=
.",
@@ -200,6 +222,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (2M/4M)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_2M_4M",
         "PublicDescription": "Counts completed page walks (2M/4M page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
@@ -209,6 +232,7 @@
     },
     {
         "BriefDescription": "Code miss in all TLB levels causes a page wal=
k that completes. (4K)",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_COMPLETED_4K",
         "PublicDescription": "Counts completed page walks (4K page sizes) =
caused by a code fetch. This implies it missed in the ITLB (Instruction TLB=
) and further levels of TLB. The page walk can end with or without a fault.=
",
@@ -218,6 +242,7 @@
     },
     {
         "BriefDescription": "Number of page walks outstanding for an outst=
anding code request in the PMH each cycle.",
+        "Counter": "0,1,2,3",
         "EventCode": "0x11",
         "EventName": "ITLB_MISSES.WALK_PENDING",
         "PublicDescription": "Counts the number of page walks outstanding =
for an outstanding code (instruction fetch) request in the PMH (Page Miss H=
andler) each cycle.",
@@ -227,6 +252,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DTLB=
 miss.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.DTLB_MISS_AT_RET",
         "SampleAfterValue": "1000003",
diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index c9891630be10..ec40215377f3 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,5 +1,5 @@
 Family-model,Version,Filename,EventType
-GenuineIntel-6-(97|9A|B7|BA|BF),v1.24,alderlake,core
+GenuineIntel-6-(97|9A|B7|BA|BF),v1.27,alderlake,core
 GenuineIntel-6-BE,v1.24,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v29,broadwell,core
--=20
2.45.2.627.g7a2c4fd464-goog

