Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AA8187333
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2024 23:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718406173; cv=none; b=m7q65G3t4WHonF5yPl/hGJCQwlMjqn4s76BKpyMQbjZxgNpcqkD9EpaJ8zXAhWUAv9IE1D37QkkMSfwHsoliqshvJ1HP860i103qRpOv4pnfTIyNPBuZ4Wm97zu/2B6RHCm9XzCYNK59F5bEXQDd2jIbW8wGgWlapx9rCBT09/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718406173; c=relaxed/simple;
	bh=4pUL1JADjO95V9OjxlKk07Yo4BUIMAuyREgHDHMSRXc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=HJhlaMJHSYsBIQpQMnPxNstq04ywjwEoXolTd++qfm0sJpRVkhXsGcpmkt/0sOFRUc1QWGt5dIaQRF5uu/BevdPzEpE/kYWUO0F4YSG1zj5BoXhAgc5c2lgxkXJiO9fzagox2DhhVtXqt+qdD9bmwGEHai5CB1JDYIBQOBOBUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mgxTbOcT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mgxTbOcT"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6326955ad54so19524577b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jun 2024 16:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718406166; x=1719010966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LZzCptj0rF83irmI/OZ9/t2euLaVtCX2Lt5MOO45FY=;
        b=mgxTbOcTIAiygRQxCCWi4VFPzfsphdBRVFGtl+uBP36w6zqi6LAt2s+oLZgzUxzzhT
         8oMKSP2zdO/nK0dsi6Ul7UH3YwBowNDMfHl5noWCxMJuOrhLvdKev0yyMD7pQ/vdKUvb
         9or3vbJEYdjKrBHmNIakx9vtXE/zdKqWg+VEgP/3XzN/ljWXhOQRAIY+OtRG5L7Mfcnz
         ePfBqm2mGTwQ1Ho8/j/9wDbl6rxuivkashSY/ncoGhyQU57ayFJZJY39snJep0Hvlbf5
         Dt/tdi395DS0a22ur2HB10jwhpqdCnBHBD5ovLITgd2g5DZ13cbmLCKo+yP7lOgpQIR/
         dn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718406166; x=1719010966;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4LZzCptj0rF83irmI/OZ9/t2euLaVtCX2Lt5MOO45FY=;
        b=ZUsSvtnDdyCSRvLrqFJbkKKq5rq4yHkUWv2t9cIcQJXlGQJ3u9079qTRvTZz9lZ9oZ
         sElJ3JDqoshmFFl6w/DF5WgN9VHgIiV/gxrUgeOoyku3YsA53UTONMiddScQ6ZcuB3cD
         CjGCow/48GUp2jxH5b43bL5mR7gY9vC5dO3wCS5unKLCQ7rzdjJ0nWMwynisr8fr9jrc
         2APq0WyWoHfwZ+gAgWd4MWES0kYTY3LgYlYsajl4CMCBlznr4CTa7eEggdZzDNosS645
         Xq6OzR5kxjlV59ImMZD5JaEov3pzBfnXCs1lQqUWYGyNOgfNOjF7zd6EvQTP2Xc1Ugdh
         h2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUwrw92wyJi4tzeEKqPbn1GkJbv2G2rMg4pst8ceT8Ig8Rj+5X0k4tWpUklFfUlDovLWNYGM9KB6C5ruck4hdO0nTgT6KgJV/IOB3Z2Z64g0g==
X-Gm-Message-State: AOJu0YxOcJWBwI/3gO8rv7J0BhaBjyulwafHmbSoNI31FnxwH9faBHrd
	zUDdOIlC+OSnuY36Cz5Jcfw8BjWPq22RweCYF5xBx+owYzmhbxt9XsfkZp7s8A54Nc3vSX+/yw1
	/j274Dw==
X-Google-Smtp-Source: AGHT+IHmQWGicyCoihPvrC1mUHffUYRYqoxoEz26YYeiPB+gilQ+erbl6IJDE8A7CnrpV623OhyyVjsZwQy2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:714a:5e65:12a1:603])
 (user=irogers job=sendgmr) by 2002:a25:aaa6:0:b0:dfe:fdde:a583 with SMTP id
 3f1490d57ef6-dff1540839dmr178533276.7.1718406165575; Fri, 14 Jun 2024
 16:02:45 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:01:10 -0700
In-Reply-To: <20240614230146.3783221-1-irogers@google.com>
Message-Id: <20240614230146.3783221-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614230146.3783221-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v1 02/37] perf vendor events: Update alderlaken events/metrics
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
Update e-core TMA metrics to v3.6.

Bring in the event updates v1.27:
https://github.com/intel/perfmon/commit/ea4f309a04c50ca77a00da2db130fd7cf06=
db978
v1.26:
https://github.com/intel/perfmon/commit/0052e68d24d9873d5ff22363677794fa3eb=
05313

The e-core TMA 3.6 information was updated in:
https://github.com/intel/perfmon/commit/d9c2faa70bafe03129dc10f9fe414ef03a9=
5acd9

New events are:
MEM_UOPS_RETIRED.LOCK_LOADS,
SERIALIZATION.C01_MS_SCB,
UOPS_ISSUED.ANY.

Co-authored-by: Weilin Wang <weilin.wang@intel.com>
Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../arch/x86/alderlaken/adln-metrics.json     | 658 ++++++++----------
 .../pmu-events/arch/x86/alderlaken/cache.json |  50 +-
 .../arch/x86/alderlaken/floating-point.json   |   2 +
 .../arch/x86/alderlaken/frontend.json         |   3 +
 .../arch/x86/alderlaken/memory.json           |  11 +
 .../arch/x86/alderlaken/metricgroups.json     |  21 +-
 .../pmu-events/arch/x86/alderlaken/other.json |  13 +
 .../arch/x86/alderlaken/pipeline.json         |  80 +++
 .../x86/alderlaken/uncore-interconnect.json   |  19 +
 .../arch/x86/alderlaken/uncore-memory.json    |  25 +
 .../arch/x86/alderlaken/uncore-other.json     |   1 +
 .../arch/x86/alderlaken/virtual-memory.json   |   6 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   2 +-
 13 files changed, 503 insertions(+), 388 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
index a35edf7d86a9..447596f924ab 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
@@ -85,39 +85,28 @@
         "ScaleUnit": "1SMI#"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to certain allocation restrictions.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / tma_info_core=
_slots",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend due to backend stalls",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / tma_info_core_slots",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
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
-        "ScaleUnit": "100%"
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
         "ScaleUnit": "100%"
     },
     {
         "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a misp=
redicted jump or a machine clear",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "(tma_info_core_slots - (TOPDOWN_FE_BOUND.ALL + TOPD=
OWN_BE_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / tma_info_core_slots",
+        "MetricExpr": "(5 * CPU_CLK_UNHALTED.CORE - (TOPDOWN_FE_BOUND.ALL =
+ TOPDOWN_BE_BOUND.ALL + TOPDOWN_RETIRING.ALL)) / (5 * CPU_CLK_UNHALTED.COR=
E)",
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_bad_speculation",
         "MetricThreshold": "tma_bad_speculation > 0.15",
@@ -126,300 +115,351 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of uops that are not from t=
he microsequencer.",
-        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS) / tma_info=
_core_slots",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
-        "MetricName": "tma_base",
-        "MetricThreshold": "tma_base > 0.6",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BACLEARS, which occurs when the Branch =
Target Buffer (BTB) prediction or lack thereof, was corrected by a later br=
anch predictor in the frontend",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / tma_info_core_slot=
s",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BACLEARS, which occurs when the Branch T=
arget Buffer (BTB) prediction or lack thereof, was corrected by a later bra=
nch predictor in the frontend",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_DETECT / (5 * CPU_CLK_UNHAL=
TED.CORE)",
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
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to branch mispredicts.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / tma_info_core_=
slots",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to branch mispredicts",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MISPREDICT / (5 * CPU_CLK_U=
NHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_branch_mispredicts",
-        "MetricThreshold": "tma_branch_mispredicts > 0.05",
+        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_specul=
ation > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to BTCLEARS, which occurs when the Branch =
Target Buffer (BTB) predicts a taken branch.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / tma_info_core_slo=
ts",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to BTCLEARS, which occurs when the Branch T=
arget Buffer (BTB) predicts a taken branch.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.BRANCH_RESTEER / (5 * CPU_CLK_UNHA=
LTED.CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
         "MetricName": "tma_branch_resteer",
-        "MetricThreshold": "tma_branch_resteer > 0.05",
+        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_latenc=
y > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to the microcode sequencer (MS).",
-        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / tma_info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to the microcode sequencer (MS).",
+        "MetricExpr": "TOPDOWN_FE_BOUND.CISC / (5 * CPU_CLK_UNHALTED.CORE)=
",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_cisc",
-        "MetricThreshold": "tma_cisc > 0.05",
+        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.1 =
& tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are core execution bound and not attributed to outstanding =
demand load or store stalls.",
-        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
+        "BriefDescription": "Counts the number of cycles due to backend bo=
und stalls that are bounded by core restrictions and not attributed to an o=
utstanding load or stores, or resource limitation",
+        "MetricExpr": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS / (5 * CPU_CLK_=
UNHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_core_bound",
-        "MetricThreshold": "tma_core_bound > 0.1",
+        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0.1=
",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to decode stalls.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / tma_info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to decode stalls.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.DECODE / (5 * CPU_CLK_UNHALTED.COR=
E)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_decode",
-        "MetricThreshold": "tma_decode > 0.05",
+        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory disambiguation.",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.DISAMBIGUATION / MACHINE=
_CLEARS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
-        "MetricName": "tma_disambiguation",
-        "MetricThreshold": "tma_disambiguation > 0.02",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that does not require the =
use of microcode, classified as a fast nuke, due to memory ordering, memory=
 disambiguation and memory renaming",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / (5 * CPU_CLK_UNH=
ALTED.CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
+        "MetricName": "tma_fast_nuke",
+        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears > 0=
.05 & tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / tma_info_core_clks=
 - max((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_core_clk=
s, 0) * MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOUND_STALLS.LOAD",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_dram_bound",
-        "MetricThreshold": "tma_dram_bound > 0.1",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to frontend stalls.",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
+        "MetricGroup": "Default;TopdownL1;tma_L1_group",
+        "MetricName": "tma_frontend_bound",
+        "MetricThreshold": "tma_frontend_bound > 0.2",
+        "MetricgroupNoGroup": "TopdownL1;Default",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear classified as a fast nuke=
 due to memory ordering, memory disambiguation and memory renaming.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.FASTNUKE / tma_info_core_sl=
ots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
-        "MetricName": "tma_fast_nuke",
-        "MetricThreshold": "tma_fast_nuke > 0.05",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to instruction cache misses.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / (5 * CPU_CLK_UNHALTED.COR=
E)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricName": "tma_icache_misses",
+        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / tma_info_core=
_slots",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend bandwidth restrictions due to d=
ecode, predecode, cisc, and other limitations.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH / (5 * CPU_CLK_=
UNHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
-        "MetricName": "tma_fetch_bandwidth",
-        "MetricThreshold": "tma_fetch_bandwidth > 0.1",
+        "MetricName": "tma_ifetch_bandwidth",
+        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_boun=
d > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to frontend bandwidth restrictions due to =
decode, predecode, cisc, and other limitations.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / tma_info_core_s=
lots",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to frontend latency restrictions due to ica=
che misses, itlb misses, branch detection, and resteer limitations.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY / (5 * CPU_CLK_UN=
HALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
-        "MetricName": "tma_fetch_latency",
-        "MetricThreshold": "tma_fetch_latency > 0.15",
+        "MetricName": "tma_ifetch_latency",
+        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bound=
 > 0.2",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to FP assists.",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.FP_ASSIST / MACHINE_CLEA=
RS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
-        "MetricName": "tma_fp_assist",
-        "MetricThreshold": "tma_fp_assist > 0.02",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of time that retirement is stalled=
 due to a first level data TLB miss",
+        "MetricExpr": "100 * (LD_HEAD.DTLB_MISS_AT_RET + LD_HEAD.PGWALK_AT=
_RET) / CPU_CLK_UNHALTED.CORE",
+        "MetricName": "tma_info_bottleneck_%_dtlb_miss_bound_cycles"
     },
     {
-        "BriefDescription": "Counts the number of floating point divide op=
erations per uop.",
-        "MetricExpr": "UOPS_RETIRED.FPDIV / tma_info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
-        "MetricName": "tma_fpdiv_uops",
-        "MetricThreshold": "tma_fpdiv_uops > 0.2",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of time that allocation and retire=
ment is stalled by the Frontend Cluster due to an Ifetch Miss, either Icach=
e or ITLB Miss",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH / CPU_CLK_UNHALTED.CO=
RE",
+        "MetricGroup": "Ifetch",
+        "MetricName": "tma_info_bottleneck_%_ifetch_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that allocation and retir=
ement is stalled by the Frontend Cluster due to an Ifetch Miss, either Icac=
he or ITLB Miss. See Info.Ifetch_Bound"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to frontend stalls.",
-        "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ALL / tma_info_core_slots",
-        "MetricGroup": "Default;TopdownL1;tma_L1_group",
-        "MetricName": "tma_frontend_bound",
-        "MetricThreshold": "tma_frontend_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL1;Default",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of time that retirement is stalled=
 due to an L1 miss",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.LOAD / CPU_CLK_UNHALTED.CORE=
",
+        "MetricGroup": "Load_Store_Miss",
+        "MetricName": "tma_info_bottleneck_%_load_miss_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d due to an L1 miss. See Info.Load_Miss_Bound"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to instruction cache misses.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ICACHE / tma_info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
-        "MetricName": "tma_icache_misses",
-        "MetricThreshold": "tma_icache_misses > 0.05",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of time that retirement is stalled=
 by the Memory Cluster due to a pipeline stall",
+        "MetricExpr": "100 * LD_HEAD.ANY_AT_RET / CPU_CLK_UNHALTED.CORE",
+        "MetricGroup": "Mem_Exec",
+        "MetricName": "tma_info_bottleneck_%_mem_exec_bound_cycles",
+        "PublicDescription": "Percentage of time that retirement is stalle=
d by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound"
+    },
+    {
+        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "MetricName": "tma_info_br_inst_mix_ipbranch"
+    },
+    {
+        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
+        "MetricName": "tma_info_br_inst_mix_ipcall"
+    },
+    {
+        "BriefDescription": "Instructions per Far Branch ( Far Branches ap=
ply upon transition from application to operating system, handling interrup=
ts, exceptions) [lower number means higher occurrence rate]",
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "MetricName": "tma_info_br_inst_mix_ipfarbranch"
+    },
+    {
+        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
+        "MetricExpr": "INST_RETIRED.ANY / (BR_MISP_RETIRED.COND - BR_MISP_=
RETIRED.COND_TAKEN)",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_ntaken"
+    },
+    {
+        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was taken",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_taken"
+    },
+    {
+        "BriefDescription": "Instructions per retired indirect call or jum=
p Branch Misprediction",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_indirect"
+    },
+    {
+        "BriefDescription": "Instructions per retired return Branch Mispre=
diction",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RETURN",
+        "MetricName": "tma_info_br_inst_mix_ipmisp_ret"
+    },
+    {
+        "BriefDescription": "Instructions per retired Branch Misprediction=
",
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "MetricName": "tma_info_br_inst_mix_ipmispredict"
+    },
+    {
+        "BriefDescription": "Ratio of all branches which mispredict",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
+        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_rati=
o"
+    },
+    {
+        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
+        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
+        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_to_u=
nknown_branch_ratio"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE",
-        "MetricName": "tma_info_core_clks"
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to load buffer full",
+        "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.LD_BUF / CPU_CLK_UNHALTED=
.CORE",
+        "MetricName": "tma_info_buffer_stalls_%_load_buffer_stall_cycles"
     },
     {
-        "BriefDescription": "",
-        "MetricExpr": "CPU_CLK_UNHALTED.CORE_P",
-        "MetricName": "tma_info_core_clks_p"
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to memory reservation stations full",
+        "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.RSV / CPU_CLK_UNHALTED.CO=
RE",
+        "MetricName": "tma_info_buffer_stalls_%_mem_rsv_stall_cycles"
+    },
+    {
+        "BriefDescription": "Percentage of time that allocation is stalled=
 due to store buffer full",
+        "MetricExpr": "100 * MEM_SCHEDULER_BLOCK.ST_BUF / CPU_CLK_UNHALTED=
.CORE",
+        "MetricName": "tma_info_buffer_stalls_%_store_buffer_stall_cycles"
     },
     {
         "BriefDescription": "Cycles Per Instruction",
-        "MetricExpr": "tma_info_core_clks / INST_RETIRED.ANY",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE / INST_RETIRED.ANY",
         "MetricName": "tma_info_core_cpi"
     },
     {
         "BriefDescription": "Instructions Per Cycle",
-        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_clks",
+        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.CORE",
         "MetricName": "tma_info_core_ipc"
     },
-    {
-        "BriefDescription": "",
-        "MetricExpr": "5 * tma_info_core_clks",
-        "MetricName": "tma_info_core_slots"
-    },
     {
         "BriefDescription": "Uops Per Instruction",
         "MetricExpr": "UOPS_RETIRED.ALL / INST_RETIRED.ANY",
         "MetricName": "tma_info_core_upi"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
DRAM",
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L2",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / MEM_BOUND_ST=
ALLS.IFETCH",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
2hit"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss hits in the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / MEM_BOUND_S=
TALLS.IFETCH",
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3hit"
+    },
+    {
+        "BriefDescription": "Percentage of ifetch miss bound stalls, where=
 the ifetch miss subsequently misses in the L3",
         "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_DRAM_HIT / MEM_BOUND_=
STALLS.IFETCH",
-        "MetricName": "tma_info_frontend_inst_miss_cost_dramhit_percent"
+        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with_l=
3miss"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
the L2",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_L2_HIT / MEM_BOUND_ST=
ALLS.IFETCH",
-        "MetricName": "tma_info_frontend_inst_miss_cost_l2hit_percent"
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L2",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_STAL=
LS.LOAD",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2hit=
"
     },
     {
-        "BriefDescription": "Percent of instruction miss cost that hit in =
the L3",
-        "MetricExpr": "100 * MEM_BOUND_STALLS.IFETCH_LLC_HIT / MEM_BOUND_S=
TALLS.IFETCH",
-        "MetricName": "tma_info_frontend_inst_miss_cost_l3hit_percent"
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that hit the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND_STA=
LLS.LOAD",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3hit=
"
     },
     {
-        "BriefDescription": "Ratio of all branches which mispredict",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.ALL_=
BRANCHES",
-        "MetricName": "tma_info_inst_mix_branch_mispredict_ratio"
+        "BriefDescription": "Percentage of memory bound stalls where retir=
ement is stalled due to an L1 miss that subsequently misses the L3",
+        "MetricExpr": "100 * MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_BOUND_ST=
ALLS.LOAD",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3mis=
s"
     },
     {
-        "BriefDescription": "Ratio between Mispredicted branches and unkno=
wn branches",
-        "MetricExpr": "BR_MISP_RETIRED.ALL_BRANCHES / BACLEARS.ANY",
-        "MetricName": "tma_info_inst_mix_branch_mispredict_to_unknown_bran=
ch_ratio"
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a pipeline block",
+        "MetricExpr": "100 * LD_HEAD.L1_BOUND_AT_RET / CPU_CLK_UNHALTED.CO=
RE",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_l1_bound"
     },
     {
-        "BriefDescription": "Percentage of all uops which are FPDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / UOPS_RETIRED.ALL",
-        "MetricName": "tma_info_inst_mix_fpdiv_uop_ratio"
+        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement",
+        "MetricExpr": "100 * (LD_HEAD.L1_BOUND_AT_RET + MEM_BOUND_STALLS.L=
OAD) / CPU_CLK_UNHALTED.CORE",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_load_bound"
     },
     {
-        "BriefDescription": "Percentage of all uops which are IDiv uops",
-        "MetricExpr": "100 * UOPS_RETIRED.IDIV / UOPS_RETIRED.ALL",
-        "MetricName": "tma_info_inst_mix_idiv_uop_ratio"
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full",
+        "MetricExpr": "100 * (MEM_SCHEDULER_BLOCK.ST_BUF / MEM_SCHEDULER_B=
LOCK.ALL) * tma_mem_scheduler",
+        "MetricGroup": "load_store_bound",
+        "MetricName": "tma_info_load_store_bound_store_bound"
     },
     {
-        "BriefDescription": "Instructions per Branch (lower number means h=
igher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
-        "MetricName": "tma_info_inst_mix_ipbranch"
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to memory disambiguation",
+        "MetricExpr": "1e3 * MACHINE_CLEARS.DISAMBIGUATION / INST_RETIRED.=
ANY",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_disamb_=
pki"
     },
     {
-        "BriefDescription": "Instruction per (near) call (lower number mea=
ns higher occurrence rate)",
-        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
-        "MetricName": "tma_info_inst_mix_ipcall"
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to floating point assists",
+        "MetricExpr": "1e3 * MACHINE_CLEARS.FP_ASSIST / INST_RETIRED.ANY",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_fp_assi=
st_pki"
     },
     {
-        "BriefDescription": "Instructions per Far Branch",
-        "MetricExpr": "INST_RETIRED.ANY / (BR_INST_RETIRED.FAR_BRANCH / 2)=
",
-        "MetricName": "tma_info_inst_mix_ipfarbranch"
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to memory ordering",
+        "MetricExpr": "1e3 * MACHINE_CLEARS.MEMORY_ORDERING / INST_RETIRED=
.ANY",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_monuke_=
pki"
     },
     {
-        "BriefDescription": "Instructions per Load",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
-        "MetricName": "tma_info_inst_mix_ipload"
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to memory renaming",
+        "MetricExpr": "1e3 * MACHINE_CLEARS.MRN_NUKE / INST_RETIRED.ANY",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_mrn_pki=
"
     },
     {
-        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was not taken",
-        "MetricExpr": "INST_RETIRED.ANY / (BR_MISP_RETIRED.COND - BR_MISP_=
RETIRED.COND_TAKEN)",
-        "MetricName": "tma_info_inst_mix_ipmisp_cond_ntaken"
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to page faults",
+        "MetricExpr": "1e3 * MACHINE_CLEARS.PAGE_FAULT / INST_RETIRED.ANY"=
,
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_page_fa=
ult_pki"
     },
     {
-        "BriefDescription": "Instructions per retired conditional Branch M=
isprediction where the branch was taken",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
-        "MetricName": "tma_info_inst_mix_ipmisp_cond_taken"
+        "BriefDescription": "Counts the number of machine clears relative =
to thousands of instructions retired, due to self-modifying code",
+        "MetricExpr": "1e3 * MACHINE_CLEARS.SMC / INST_RETIRED.ANY",
+        "MetricName": "tma_info_machine_clear_bound_machine_clears_smc_pki=
"
     },
     {
-        "BriefDescription": "Instructions per retired indirect call or jum=
p Branch Misprediction",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
-        "MetricName": "tma_info_inst_mix_ipmisp_indirect"
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h an address aliasing block",
+        "MetricExpr": "100 * LD_BLOCKS.4K_ALIAS / MEM_UOPS_RETIRED.ALL_LOA=
DS",
+        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_adressaliasin=
g"
     },
     {
-        "BriefDescription": "Instructions per retired return Branch Mispre=
diction",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RETURN",
-        "MetricName": "tma_info_inst_mix_ipmisp_ret"
+        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
+        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
+        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_storefwdblk"
     },
     {
-        "BriefDescription": "Instructions per retired Branch Misprediction=
",
-        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
-        "MetricName": "tma_info_inst_mix_ipmispredict"
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 first level data cache miss",
+        "MetricExpr": "100 * LD_HEAD.L1_MISS_AT_RET / LD_HEAD.ANY_AT_RET",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_l1miss"
     },
     {
-        "BriefDescription": "Instructions per Store",
-        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
-        "MetricName": "tma_info_inst_mix_ipstore"
+        "BriefDescription": "Percentage of Memory Execution Bound due to o=
ther block cases, such as pipeline conflicts, fences, etc",
+        "MetricExpr": "100 * LD_HEAD.OTHER_AT_RET / LD_HEAD.ANY_AT_RET",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_otherpipeli=
neblks"
     },
     {
-        "BriefDescription": "Percentage of all uops which are ucode ops",
-        "MetricExpr": "100 * UOPS_RETIRED.MS / UOPS_RETIRED.ALL",
-        "MetricName": "tma_info_inst_mix_microcode_uop_ratio"
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 pagewalk",
+        "MetricExpr": "100 * LD_HEAD.PGWALK_AT_RET / LD_HEAD.ANY_AT_RET",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_pagewalk"
     },
     {
-        "BriefDescription": "Percentage of all uops which are x87 uops",
-        "MetricExpr": "100 * UOPS_RETIRED.X87 / UOPS_RETIRED.ALL",
-        "MetricName": "tma_info_inst_mix_x87_uop_ratio"
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 second level TLB miss",
+        "MetricExpr": "100 * LD_HEAD.DTLB_MISS_AT_RET / LD_HEAD.ANY_AT_RET=
",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_stlbhit"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a address aliasing block",
-        "MetricExpr": "100 * LD_BLOCKS.4K_ALIAS / MEM_UOPS_RETIRED.ALL_LOA=
DS",
-        "MetricName": "tma_info_l1_bound_address_alias_blocks"
+        "BriefDescription": "Percentage of Memory Execution Bound due to a=
 store forward address match",
+        "MetricExpr": "100 * LD_HEAD.ST_ADDR_AT_RET / LD_HEAD.ANY_AT_RET",
+        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_storefwding=
"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
-        "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIR=
ED.ALL_LOADS",
-        "MetricName": "tma_info_l1_bound_load_splits"
+        "BriefDescription": "Instructions per Load",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_LOADS",
+        "MetricName": "tma_info_mem_mix_ipload"
     },
     {
-        "BriefDescription": "Percentage of total non-speculative loads wit=
h a store forward or unknown store address block",
-        "MetricExpr": "100 * LD_BLOCKS.DATA_UNKNOWN / MEM_UOPS_RETIRED.ALL=
_LOADS",
-        "MetricName": "tma_info_l1_bound_store_fwd_blocks"
+        "BriefDescription": "Instructions per Store",
+        "MetricExpr": "INST_RETIRED.ANY / MEM_UOPS_RETIRED.ALL_STORES",
+        "MetricName": "tma_info_mem_mix_ipstore"
     },
     {
-        "BriefDescription": "Cycle cost per DRAM hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_DRAM_HIT / MEM_LOAD_UOPS_RETI=
RED.DRAM_HIT",
-        "MetricName": "tma_info_memory_cycles_per_demand_load_dram_hit"
+        "BriefDescription": "Percentage of total non-speculative loads tha=
t perform one or more locks",
+        "MetricExpr": "100 * MEM_UOPS_RETIRED.LOCK_LOADS / MEM_UOPS_RETIRE=
D.ALL_LOADS",
+        "MetricName": "tma_info_mem_mix_load_locks_ratio"
     },
     {
-        "BriefDescription": "Cycle cost per L2 hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_LOAD_UOPS_RETIRE=
D.L2_HIT",
-        "MetricName": "tma_info_memory_cycles_per_demand_load_l2_hit"
+        "BriefDescription": "Percentage of total non-speculative loads tha=
t are splits",
+        "MetricExpr": "100 * MEM_UOPS_RETIRED.SPLIT_LOADS / MEM_UOPS_RETIR=
ED.ALL_LOADS",
+        "MetricName": "tma_info_mem_mix_load_splits_ratio"
     },
     {
-        "BriefDescription": "Cycle cost per LLC hit",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_LOAD_UOPS_RETIR=
ED.L3_HIT",
-        "MetricName": "tma_info_memory_cycles_per_demand_load_l3_hit"
+        "BriefDescription": "Ratio of mem load uops to all uops",
+        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / UOPS_RETIRED.ALL=
",
+        "MetricName": "tma_info_mem_mix_memload_ratio"
     },
     {
-        "BriefDescription": "load ops retired per 1000 instruction",
-        "MetricExpr": "1e3 * MEM_UOPS_RETIRED.ALL_LOADS / INST_RETIRED.ANY=
",
-        "MetricName": "tma_info_memory_memloadpki"
+        "BriefDescription": "Percentage of time that the core is stalled d=
ue to a TPAUSE or UMWAIT instruction",
+        "MetricExpr": "100 * SERIALIZATION.C01_MS_SCB / (5 * CPU_CLK_UNHAL=
TED.CORE)",
+        "MetricName": "tma_info_serialization _%_tpause_cycles"
     },
     {
         "BriefDescription": "Average CPU Utilization",
@@ -428,194 +468,122 @@
     },
     {
         "BriefDescription": "Fraction of cycles spent in Kernel mode",
-        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE@k / CPU_CLK_UNHALTED.CORE=
",
+        "MetricExpr": "cpu@CPU_CLK_UNHALTED.CORE_P@k / CPU_CLK_UNHALTED.CO=
RE",
         "MetricGroup": "Summary",
         "MetricName": "tma_info_system_kernel_utilization"
     },
     {
         "BriefDescription": "Average Frequency Utilization relative nomina=
l frequency",
-        "MetricExpr": "tma_info_core_clks / CPU_CLK_UNHALTED.REF_TSC",
+        "MetricExpr": "CPU_CLK_UNHALTED.CORE / CPU_CLK_UNHALTED.REF_TSC",
         "MetricGroup": "Power",
         "MetricName": "tma_info_system_turbo_utilization"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to Instruction Table Lookaside Buffer (ITL=
B) misses.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / tma_info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_latency_group",
-        "MetricName": "tma_itlb_misses",
-        "MetricThreshold": "tma_itlb_misses > 0.05",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of all uops which are FPDiv uops",
+        "MetricExpr": "100 * UOPS_RETIRED.FPDIV / UOPS_RETIRED.ALL",
+        "MetricName": "tma_info_uop_mix_fpdiv_uop_ratio"
     },
     {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a load block.",
-        "MetricExpr": "LD_HEAD.L1_BOUND_AT_RET / tma_info_core_clks",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_l1_bound",
-        "MetricThreshold": "tma_l1_bound > 0.1",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of all uops which are IDiv uops",
+        "MetricExpr": "100 * UOPS_RETIRED.IDIV / UOPS_RETIRED.ALL",
+        "MetricName": "tma_info_uop_mix_idiv_uop_ratio"
     },
     {
-        "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the L2 Cache.",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_L2_HIT / tma_info_core_clks -=
 max((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_core_clks,=
 0) * MEM_BOUND_STALLS.LOAD_L2_HIT / MEM_BOUND_STALLS.LOAD",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_l2_bound",
-        "MetricThreshold": "tma_l2_bound > 0.1",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of all uops which are microcode op=
s",
+        "MetricExpr": "100 * UOPS_RETIRED.MS / UOPS_RETIRED.ALL",
+        "MetricName": "tma_info_uop_mix_microcode_uop_ratio"
     },
     {
-        "BriefDescription": "Counts the number of cycles a core is stalled=
 due to a demand load which hit in the Last Level Cache (LLC) or other core=
 with HITE/F/M.",
-        "MetricExpr": "MEM_BOUND_STALLS.LOAD_LLC_HIT / tma_info_core_clks =
- max((MEM_BOUND_STALLS.LOAD - LD_HEAD.L1_MISS_AT_RET) / tma_info_core_clks=
, 0) * MEM_BOUND_STALLS.LOAD_LLC_HIT / MEM_BOUND_STALLS.LOAD",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_l3_bound",
-        "MetricThreshold": "tma_l3_bound > 0.1",
-        "ScaleUnit": "100%"
+        "BriefDescription": "Percentage of all uops which are x87 uops",
+        "MetricExpr": "100 * UOPS_RETIRED.X87 / UOPS_RETIRED.ALL",
+        "MetricName": "tma_info_uop_mix_x87_uop_ratio"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to load buffer=
 full",
-        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.LD_BUF / ME=
M_SCHEDULER_BLOCK.ALL",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
-        "MetricName": "tma_ld_buffer",
-        "MetricThreshold": "tma_ld_buffer > 0.05",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to Instruction Table Lookaside Buffer (ITLB=
) misses.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.ITLB / (5 * CPU_CLK_UNHALTED.CORE)=
",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
+        "MetricName": "tma_itlb_misses",
+        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency >=
 0.15 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation.",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / tma_info_c=
ore_slots",
+        "BriefDescription": "Counts the total number of issue slots that w=
ere not consumed by the backend because allocation is stalled due to a mach=
ine clear (nuke) of any kind including memory ordering and memory disambigu=
ation",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS / (5 * CPU_C=
LK_UNHALTED.CORE)",
         "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group",
         "MetricName": "tma_machine_clears",
-        "MetricThreshold": "tma_machine_clears > 0.05",
+        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculatio=
n > 0.15",
         "MetricgroupNoGroup": "TopdownL2",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to memory reservation stalls in which a sche=
duler is not able to accept uops.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / tma_info_core_slot=
s",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to memory reservation stalls in which a sched=
uler is not able to accept uops",
+        "MetricExpr": "TOPDOWN_BE_BOUND.MEM_SCHEDULER / (5 * CPU_CLK_UNHAL=
TED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_mem_scheduler",
-        "MetricThreshold": "tma_mem_scheduler > 0.1",
+        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to stores or loads.",
-        "MetricExpr": "min(tma_backend_bound, LD_HEAD.ANY_AT_RET / tma_inf=
o_core_clks + tma_store_bound)",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
-        "MetricName": "tma_memory_bound",
-        "MetricThreshold": "tma_memory_bound > 0.2",
-        "MetricgroupNoGroup": "TopdownL2",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to memory ordering.",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.MEMORY_ORDERING / MACHIN=
E_CLEARS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
-        "MetricName": "tma_memory_ordering",
-        "MetricThreshold": "tma_memory_ordering > 0.02",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of uops that are from the c=
omplex flows issued by the micro-sequencer (MS)",
-        "MetricExpr": "UOPS_RETIRED.MS / tma_info_core_slots",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_retiring_group",
-        "MetricName": "tma_ms_uops",
-        "MetricThreshold": "tma_ms_uops > 0.05",
-        "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "Counts the number of uops that are from the =
complex flows issued by the micro-sequencer (MS).  This includes uops from =
flows due to complex instructions, faults, assists, and inserted flows.",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to IEC or FPC RAT stalls, which can be due t=
o FIQ or IEC reservation stalls in which the integer, floating point or SIM=
D scheduler is not able to accept uops.",
-        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / tma_info_core_=
slots",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to IEC or FPC RAT stalls, which can be due to=
 FIQ or IEC reservation stalls in which the integer, floating point or SIMD=
 scheduler is not able to accept uops",
+        "MetricExpr": "TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER / (5 * CPU_CLK_U=
NHALTED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_non_mem_scheduler",
-        "MetricThreshold": "tma_non_mem_scheduler > 0.1",
+        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_bo=
und > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to a machine clear (slow nuke).",
-        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / tma_info_core_slots"=
,
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to a machine clear that requires the use of m=
icrocode (slow nuke)",
+        "MetricExpr": "TOPDOWN_BAD_SPECULATION.NUKE / (5 * CPU_CLK_UNHALTE=
D.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
         "MetricName": "tma_nuke",
-        "MetricThreshold": "tma_nuke > 0.05",
+        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05 &=
 tma_bad_speculation > 0.15)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to other common frontend stalls not catego=
rized.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / tma_info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to other common frontend stalls not categor=
ized.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.OTHER / (5 * CPU_CLK_UNHALTED.CORE=
)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_other_fb",
-        "MetricThreshold": "tma_other_fb > 0.05",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a number of other lo=
ad blocks.",
-        "MetricExpr": "LD_HEAD.OTHER_AT_RET / tma_info_core_clks",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_other_l1",
-        "MetricThreshold": "tma_other_l1 > 0.05",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hits in the L2, LLC, DRAM or MMIO (Non-D=
RAM) but could not be correctly attributed or cycles in which the load miss=
 is waiting on a request buffer.",
-        "MetricExpr": "max(0, tma_memory_bound - (tma_store_bound + tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound))",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_other_load_store",
-        "MetricThreshold": "tma_other_load_store > 0.1",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of uops retired excluding m=
s and fp div uops.",
-        "MetricExpr": "(TOPDOWN_RETIRING.ALL - UOPS_RETIRED.MS - UOPS_RETI=
RED.FPDIV) / tma_info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_base_group",
-        "MetricName": "tma_other_ret",
-        "MetricThreshold": "tma_other_ret > 0.3",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to page faults.",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.PAGE_FAULT / MACHINE_CLE=
ARS.SLOW)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
-        "MetricName": "tma_page_fault",
-        "MetricThreshold": "tma_page_fault > 0.02",
+        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot delivered by the frontend due to wrong predecodes.",
-        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / tma_info_core_slots",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_fetch_bandwidth_group",
+        "BriefDescription": "Counts the number of issue slots that were no=
t delivered by the frontend due to wrong predecodes.",
+        "MetricExpr": "TOPDOWN_FE_BOUND.PREDECODE / (5 * CPU_CLK_UNHALTED.=
CORE)",
+        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_group"=
,
         "MetricName": "tma_predecode",
-        "MetricThreshold": "tma_predecode > 0.05",
+        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth >=
 0.1 & tma_frontend_bound > 0.2)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the physical register file unable to acce=
pt an entry (marble stalls).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / tma_info_core_slots",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the physical register file unable to accep=
t an entry (marble stalls)",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REGISTER / (5 * CPU_CLK_UNHALTED.C=
ORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_register",
-        "MetricThreshold": "tma_register > 0.1",
+        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0.2=
 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to the reorder buffer being full (ROB stalls=
).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / tma_info_core_slo=
ts",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to the reorder buffer being full (ROB stalls)=
",
+        "MetricExpr": "TOPDOWN_BE_BOUND.REORDER_BUFFER / (5 * CPU_CLK_UNHA=
LTED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_reorder_buffer",
-        "MetricThreshold": "tma_reorder_buffer > 0.1",
+        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bound=
 > 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the total number of issue slots  that =
were not consumed by the backend due to backend stalls",
-        "MetricExpr": "tma_backend_bound",
-        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_aux_group=
",
+        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a resource limitation",
+        "MetricExpr": "tma_backend_bound - tma_core_bound",
+        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
         "MetricName": "tma_resource_bound",
-        "MetricThreshold": "tma_resource_bound > 0.2",
+        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound >=
 0.1",
         "MetricgroupNoGroup": "TopdownL2",
-        "PublicDescription": "Counts the total number of issue slots  that=
 were not consumed by the backend due to backend stalls.  Note that uops mu=
st be available for consumption in order for this event to count.  If a uop=
 is not available (IQ is empty), this event will not count.",
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of issue slots  that result=
 in retirement slots.",
+        "BriefDescription": "Counts the number of issue slots that result =
in retirement slots",
         "DefaultMetricgroupName": "TopdownL1",
-        "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
+        "MetricExpr": "TOPDOWN_RETIRING.ALL / (5 * CPU_CLK_UNHALTED.CORE)"=
,
         "MetricGroup": "Default;TopdownL1;tma_L1_group",
         "MetricName": "tma_retiring",
         "MetricThreshold": "tma_retiring > 0.75",
@@ -623,67 +591,11 @@
         "ScaleUnit": "100%"
     },
     {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to RSV full re=
lative",
-        "MetricExpr": "tma_mem_scheduler * MEM_SCHEDULER_BLOCK.RSV / MEM_S=
CHEDULER_BLOCK.ALL",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
-        "MetricName": "tma_rsv",
-        "MetricThreshold": "tma_rsv > 0.05",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of issue slots  that were n=
ot consumed by the backend due to scoreboards from the instruction queue (I=
Q), jump execution unit (JEU), or microcode sequencer (MS).",
-        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / tma_info_core_slot=
s",
+        "BriefDescription": "Counts the number of issue slots that were no=
t consumed by the backend due to scoreboards from the instruction queue (IQ=
), jump execution unit (JEU), or microcode sequencer (MS)",
+        "MetricExpr": "TOPDOWN_BE_BOUND.SERIALIZATION / (5 * CPU_CLK_UNHAL=
TED.CORE)",
         "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
         "MetricName": "tma_serialization",
-        "MetricThreshold": "tma_serialization > 0.1",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of machine clears relative =
to the number of nuke slots due to SMC.",
-        "MetricExpr": "tma_nuke * (MACHINE_CLEARS.SMC / MACHINE_CLEARS.SLO=
W)",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_nuke_group",
-        "MetricName": "tma_smc",
-        "MetricThreshold": "tma_smc > 0.02",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles, relative to the =
number of mem_scheduler slots, in which uops are blocked due to store buffe=
r full",
-        "MetricExpr": "tma_store_bound",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_mem_scheduler_group",
-        "MetricName": "tma_st_buffer",
-        "MetricThreshold": "tma_st_buffer > 0.05",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a first level TLB mi=
ss.",
-        "MetricExpr": "LD_HEAD.DTLB_MISS_AT_RET / tma_info_core_clks",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_stlb_hit",
-        "MetricThreshold": "tma_stlb_hit > 0.05",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a second level TLB m=
iss requiring a page walk.",
-        "MetricExpr": "LD_HEAD.PGWALK_AT_RET / tma_info_core_clks",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_stlb_miss",
-        "MetricThreshold": "tma_stlb_miss > 0.05",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles the core is stall=
ed due to store buffer full.",
-        "MetricExpr": "tma_mem_scheduler * (MEM_SCHEDULER_BLOCK.ST_BUF / M=
EM_SCHEDULER_BLOCK.ALL)",
-        "MetricGroup": "TopdownL3;tma_L3_group;tma_memory_bound_group",
-        "MetricName": "tma_store_bound",
-        "MetricThreshold": "tma_store_bound > 0.1",
-        "ScaleUnit": "100%"
-    },
-    {
-        "BriefDescription": "Counts the number of cycles that the oldest l=
oad of the load buffer is stalled at retirement due to a store forward bloc=
k.",
-        "MetricExpr": "LD_HEAD.ST_ADDR_AT_RET / tma_info_core_clks",
-        "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
-        "MetricName": "tma_store_fwd_blk",
-        "MetricThreshold": "tma_store_fwd_blk > 0.05",
+        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_bound =
> 0.2 & tma_backend_bound > 0.1)",
         "ScaleUnit": "100%"
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/cache.json
index 043445ae14a8..1500033ee19f 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/cache.json
@@ -1,22 +1,25 @@
 [
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
         "UMask": "0x41"
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
         "UMask": "0x4f"
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
@@ -25,6 +28,7 @@
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
@@ -33,6 +37,7 @@
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
@@ -41,6 +46,7 @@
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
@@ -49,6 +55,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in the L2, LLC, DRAM or MMIO (Non-DR=
AM).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD",
         "SampleAfterValue": "200003",
@@ -56,6 +63,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load miss which hit in DRAM or MMIO (Non-DRAM).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_DRAM_HIT",
         "SampleAfterValue": "200003",
@@ -63,6 +71,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles the core is stall=
ed due to a demand load which hit in the L2 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x34",
         "EventName": "MEM_BOUND_STALLS.LOAD_L2_HIT",
         "SampleAfterValue": "200003",
@@ -70,6 +79,7 @@
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
@@ -78,6 +88,7 @@
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in DRAM.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
@@ -87,6 +98,7 @@
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L2 cache.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
@@ -96,6 +108,7 @@
     },
     {
         "BriefDescription": "Counts the number of load uops retired that h=
it in the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd1",
         "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
@@ -105,6 +118,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked for any of the following reasons:  load buffer, store buffer or RSV fu=
ll.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.ALL",
         "SampleAfterValue": "20003",
@@ -112,6 +126,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a load buffer full condition.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.LD_BUF",
         "SampleAfterValue": "20003",
@@ -119,6 +134,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to an RSV full condition.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.RSV",
         "SampleAfterValue": "20003",
@@ -126,6 +142,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that uops are blo=
cked due to a store buffer full condition.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x04",
         "EventName": "MEM_SCHEDULER_BLOCK.ST_BUF",
         "SampleAfterValue": "20003",
@@ -133,6 +150,7 @@
     },
     {
         "BriefDescription": "Counts the number of load uops retired.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
@@ -143,6 +161,7 @@
     },
     {
         "BriefDescription": "Counts the number of store uops retired.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
@@ -153,6 +172,7 @@
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
@@ -165,6 +185,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 16 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
@@ -177,6 +198,7 @@
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
@@ -189,6 +211,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 32 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
@@ -201,6 +224,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 4 cycles as define=
d in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
@@ -213,6 +237,7 @@
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
@@ -225,6 +250,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 64 cycles as defin=
ed in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
@@ -237,6 +263,7 @@
     },
     {
         "BriefDescription": "Counts the number of tagged loads with an ins=
truction latency that exceeds or equals the threshold of 8 cycles as define=
d in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.",
+        "Counter": "0,1",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
@@ -247,8 +274,19 @@
         "SampleAfterValue": "1000003",
         "UMask": "0x5"
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
+        "UMask": "0x21"
+    },
     {
         "BriefDescription": "Counts the number of retired split load uops.=
",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
@@ -258,6 +296,7 @@
     },
     {
         "BriefDescription": "Counts the number of stores uops retired. Cou=
nts with or without PEBS enabled.",
+        "Counter": "0,1,2,3,4,5",
         "Data_LA": "1",
         "EventCode": "0xd0",
         "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
@@ -268,6 +307,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -277,6 +317,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and modified data was=
 forwarded.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM",
         "MSRIndex": "0x1a6,0x1a7",
@@ -286,6 +327,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, but no data was forwa=
rded.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_NO_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -295,6 +337,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were supplied b=
y the L3 cache where a snoop was sent, the snoop hit, and non-modified data=
 was forwarded.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
         "MSRIndex": "0x1a6,0x1a7",
@@ -304,6 +347,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were supplied b=
y the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_HIT",
         "MSRIndex": "0x1a6,0x1a7",
@@ -313,6 +357,7 @@
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
@@ -322,6 +367,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to instruction cache misses.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ICACHE",
         "SampleAfterValue": "1000003",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json =
b/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
index 30e8ca3c1485..484d8b3167f0 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/floating-point.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of floating point operation=
s retired that required microcode assist.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.FP_ASSIST",
         "PublicDescription": "Counts the number of floating point operatio=
ns retired that required microcode assist, which is not a reflection of the=
 number of FP operations, instructions or uops.",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "Counts the number of floating point divide uo=
ps retired (x87 and SSE, including x87 sqrt).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.FPDIV",
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/frontend.json b/tool=
s/perf/pmu-events/arch/x86/alderlaken/frontend.json
index 36898bab2bba..2a68f9969da0 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/frontend.json
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
@@ -9,6 +10,7 @@
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
@@ -17,6 +19,7 @@
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
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json b/tools/=
perf/pmu-events/arch/x86/alderlaken/memory.json
index 863a3ba2b4b2..619488d42a4a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer is stalled due to any number of reasons, incl=
uding an L1 miss, WCB full, pagewalk, store address block or store data blo=
ck, on a load that retires.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.ANY_AT_RET",
         "SampleAfterValue": "1000003",
@@ -8,6 +9,7 @@
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
@@ -15,6 +17,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a DL1 =
miss.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.L1_MISS_AT_RET",
         "SampleAfterValue": "1000003",
@@ -22,6 +25,7 @@
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
@@ -30,6 +34,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a page=
walk.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.PGWALK_AT_RET",
         "SampleAfterValue": "1000003",
@@ -37,6 +42,7 @@
     },
     {
         "BriefDescription": "Counts the number of cycles that the head (ol=
dest load) of the load buffer and retirement are both stalled due to a stor=
e address match.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x05",
         "EventName": "LD_HEAD.ST_ADDR_AT_RET",
         "SampleAfterValue": "1000003",
@@ -44,6 +50,7 @@
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
@@ -51,6 +58,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -60,6 +68,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that were not suppli=
ed by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
@@ -69,6 +78,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS",
         "MSRIndex": "0x1a6,0x1a7",
@@ -78,6 +88,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that were not suppli=
ed by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
         "MSRIndex": "0x1a6,0x1a7",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/metricgroups.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/metricgroups.json
index 7b2049cd2694..40984c23a6c9 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/metricgroups.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/metricgroups.json
@@ -1,26 +1,23 @@
 {
+    "Flops": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
+    "Ifetch": "Grouping from Top-down Microarchitecture Analysis Metrics s=
preadsheet",
+    "Load_Store_Miss": "Grouping from Top-down Microarchitecture Analysis =
Metrics spreadsheet",
+    "Mem_Exec": "Grouping from Top-down Microarchitecture Analysis Metrics=
 spreadsheet",
     "Power": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
     "Summary": "Grouping from Top-down Microarchitecture Analysis Metrics =
spreadsheet",
     "TopdownL1": "Metrics for top-down breakdown at level 1",
     "TopdownL2": "Metrics for top-down breakdown at level 2",
     "TopdownL3": "Metrics for top-down breakdown at level 3",
-    "TopdownL4": "Metrics for top-down breakdown at level 4",
+    "load_store_bound": "Grouping from Top-down Microarchitecture Analysis=
 Metrics spreadsheet",
     "tma_L1_group": "Metrics for top-down breakdown at level 1",
     "tma_L2_group": "Metrics for top-down breakdown at level 2",
     "tma_L3_group": "Metrics for top-down breakdown at level 3",
-    "tma_L4_group": "Metrics for top-down breakdown at level 4",
-    "tma_backend_bound_aux_group": "Metrics contributing to tma_backend_bo=
und_aux category",
     "tma_backend_bound_group": "Metrics contributing to tma_backend_bound =
category",
     "tma_bad_speculation_group": "Metrics contributing to tma_bad_speculat=
ion category",
-    "tma_base_group": "Metrics contributing to tma_base category",
-    "tma_fetch_bandwidth_group": "Metrics contributing to tma_fetch_bandwi=
dth category",
-    "tma_fetch_latency_group": "Metrics contributing to tma_fetch_latency =
category",
+    "tma_core_bound_group": "Metrics contributing to tma_core_bound catego=
ry",
     "tma_frontend_bound_group": "Metrics contributing to tma_frontend_boun=
d category",
-    "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category",
+    "tma_ifetch_bandwidth_group": "Metrics contributing to tma_ifetch_band=
width category",
+    "tma_ifetch_latency_group": "Metrics contributing to tma_ifetch_latenc=
y category",
     "tma_machine_clears_group": "Metrics contributing to tma_machine_clear=
s category",
-    "tma_mem_scheduler_group": "Metrics contributing to tma_mem_scheduler =
category",
-    "tma_memory_bound_group": "Metrics contributing to tma_memory_bound ca=
tegory",
-    "tma_nuke_group": "Metrics contributing to tma_nuke category",
-    "tma_resource_bound_group": "Metrics contributing to tma_resource_boun=
d category",
-    "tma_retiring_group": "Metrics contributing to tma_retiring category"
+    "tma_resource_bound_group": "Metrics contributing to tma_resource_boun=
d category"
 }
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/other.json b/tools/p=
erf/pmu-events/arch/x86/alderlaken/other.json
index ccc892149dbe..54ddbe2b3b9b 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "This event is deprecated. [This event is alia=
s to MISC_RETIRED.LBR_INSERTS]",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xe4",
         "EventName": "LBR_INSERTS.ANY",
@@ -10,6 +11,7 @@
     },
     {
         "BriefDescription": "Counts modified writebacks from L1 cache and =
L2 cache that have any type of response.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.COREWB_M.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -19,6 +21,7 @@
     },
     {
         "BriefDescription": "Counts demand data reads that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -28,6 +31,7 @@
     },
     {
         "BriefDescription": "Counts demand reads for ownership (RFO) and s=
oftware prefetches for exclusive ownership (PREFETCHW) that have any type o=
f response.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
@@ -37,11 +41,20 @@
     },
     {
         "BriefDescription": "Counts streaming stores that have any type of=
 response.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xB7",
         "EventName": "OCR.STREAMING_WR.ANY_RESPONSE",
         "MSRIndex": "0x1a6,0x1a7",
         "MSRValue": "0x10800",
         "SampleAfterValue": "100003",
         "UMask": "0x1"
+    },
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
     }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/alderlaken/pipeline.json
index 846bcdafca6d..f05db45578ff 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "Counts the total number of branch instruction=
s retired for all branch types.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -9,6 +10,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_CALL",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.CALL",
@@ -18,6 +20,7 @@
     },
     {
         "BriefDescription": "Counts the number of retired JCC (Jump on Con=
ditional Code) branch instructions retired, includes both taken and not tak=
en branches.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND",
         "PEBS": "1",
@@ -26,6 +29,7 @@
     },
     {
         "BriefDescription": "Counts the number of taken JCC (Jump on Condi=
tional Code) branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.COND_TAKEN",
         "PEBS": "1",
@@ -34,6 +38,7 @@
     },
     {
         "BriefDescription": "Counts the number of far branch instructions =
retired, includes far jump, far call and return, and interrupt call and ret=
urn.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.FAR_BRANCH",
         "PEBS": "1",
@@ -42,6 +47,7 @@
     },
     {
         "BriefDescription": "Counts the number of near indirect JMP and ne=
ar indirect CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT",
         "PEBS": "1",
@@ -50,6 +56,7 @@
     },
     {
         "BriefDescription": "Counts the number of near indirect CALL branc=
h instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
         "PEBS": "1",
@@ -58,6 +65,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT_CALL",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.IND_CALL",
@@ -67,6 +75,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.JCC",
@@ -76,6 +85,7 @@
     },
     {
         "BriefDescription": "Counts the number of near CALL branch instruc=
tions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_CALL",
         "PEBS": "1",
@@ -84,6 +94,7 @@
     },
     {
         "BriefDescription": "Counts the number of near RET branch instruct=
ions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_RETURN",
         "PEBS": "1",
@@ -92,6 +103,7 @@
     },
     {
         "BriefDescription": "Counts the number of near taken branch instru=
ctions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -100,6 +112,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.INDIRECT",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
@@ -109,6 +122,7 @@
     },
     {
         "BriefDescription": "Counts the number of near relative CALL branc=
h instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.REL_CALL",
         "PEBS": "1",
@@ -117,6 +131,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.NEAR_RETURN",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.RETURN",
@@ -126,6 +141,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_INST_RETIRED.COND_TAKEN",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc4",
         "EventName": "BR_INST_RETIRED.TAKEN_JCC",
@@ -135,6 +151,7 @@
     },
     {
         "BriefDescription": "Counts the total number of mispredicted branc=
h instructions retired for all branch types.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
         "PEBS": "1",
@@ -143,6 +160,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted JCC (Jump o=
n Conditional Code) branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND",
         "PEBS": "1",
@@ -151,6 +169,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted taken JCC (=
Jump on Conditional Code) branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.COND_TAKEN",
         "PEBS": "1",
@@ -159,6 +178,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct JMP and near indirect CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT",
         "PEBS": "1",
@@ -167,6 +187,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near indire=
ct CALL branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
         "PEBS": "1",
@@ -175,6 +196,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT_CALL",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.IND_CALL",
@@ -184,6 +206,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.JCC",
@@ -193,6 +216,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near taken =
branch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
         "PEBS": "1",
@@ -201,6 +225,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.INDIRECT",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
@@ -210,6 +235,7 @@
     },
     {
         "BriefDescription": "Counts the number of mispredicted near RET br=
anch instructions retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.RETURN",
         "PEBS": "1",
@@ -218,6 +244,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
BR_MISP_RETIRED.COND_TAKEN",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0xc5",
         "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
@@ -227,6 +254,7 @@
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
@@ -234,6 +262,7 @@
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
@@ -241,6 +270,7 @@
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
@@ -248,6 +278,7 @@
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
@@ -256,6 +287,7 @@
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
@@ -263,6 +295,7 @@
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
@@ -270,6 +303,7 @@
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
@@ -278,6 +312,7 @@
     },
     {
         "BriefDescription": "Counts the total number of instructions retir=
ed.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc0",
         "EventName": "INST_RETIRED.ANY_P",
         "PEBS": "1",
@@ -286,6 +321,7 @@
     },
     {
         "BriefDescription": "This event is deprecated. Refer to new event =
LD_BLOCKS.ADDRESS_ALIAS",
+        "Counter": "0,1,2,3,4,5",
         "Deprecated": "1",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.4K_ALIAS",
@@ -295,6 +331,7 @@
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because it initially appears to be store forward blocked, but subseq=
uently is shown not to be blocked based on 4K alias check.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
         "PEBS": "1",
@@ -303,6 +340,7 @@
     },
     {
         "BriefDescription": "Counts the number of retired loads that are b=
locked because its address exactly matches an older store whose data is not=
 ready.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x03",
         "EventName": "LD_BLOCKS.DATA_UNKNOWN",
         "PEBS": "1",
@@ -311,6 +349,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to me=
mory ordering in which an internal load passes an older store within the sa=
me CPU.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.DISAMBIGUATION",
         "SampleAfterValue": "20003",
@@ -318,6 +357,7 @@
     },
     {
         "BriefDescription": "Counts the number of machines clears due to m=
emory renaming.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.MRN_NUKE",
         "SampleAfterValue": "1000003",
@@ -325,6 +365,7 @@
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
@@ -332,6 +373,7 @@
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
@@ -339,6 +381,7 @@
     },
     {
         "BriefDescription": "Counts the number of machine clears due to pr=
ogram modifying data (self modifying code) within 1K of a recently fetched =
code page.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc3",
         "EventName": "MACHINE_CLEARS.SMC",
         "SampleAfterValue": "20003",
@@ -346,6 +389,7 @@
     },
     {
         "BriefDescription": "Counts the number of LBR entries recorded. Re=
quires LBRs to be enabled in IA32_LBR_CTL. [This event is alias to LBR_INSE=
RTS.ANY]",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xe4",
         "EventName": "MISC_RETIRED.LBR_INSERTS",
         "PEBS": "1",
@@ -355,6 +399,7 @@
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
@@ -363,6 +408,7 @@
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
@@ -370,6 +416,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to fast nukes such as memory orde=
ring and memory disambiguation machine clears.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.FASTNUKE",
         "SampleAfterValue": "1000003",
@@ -377,6 +424,7 @@
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
@@ -384,6 +432,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to branch mispredicts.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.MISPREDICT",
         "SampleAfterValue": "1000003",
@@ -391,6 +440,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to a machine clear (nuke).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x73",
         "EventName": "TOPDOWN_BAD_SPECULATION.NUKE",
         "SampleAfterValue": "1000003",
@@ -398,12 +448,14 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to backend stalls.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALL",
         "SampleAfterValue": "1000003"
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to certain allocation restriction=
s.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS",
         "SampleAfterValue": "1000003",
@@ -411,6 +463,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to memory reservation stalls in w=
hich a scheduler is not able to accept uops.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.MEM_SCHEDULER",
         "SampleAfterValue": "1000003",
@@ -418,6 +471,7 @@
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
@@ -425,6 +479,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the physical register file una=
ble to accept an entry (marble stalls).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.REGISTER",
         "SampleAfterValue": "1000003",
@@ -432,6 +487,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to the reorder buffer being full =
(ROB stalls).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.REORDER_BUFFER",
         "SampleAfterValue": "1000003",
@@ -439,6 +495,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not consumed by the backend due to scoreboards from the instructi=
on queue (IQ), jump execution unit (JEU), or microcode sequencer (MS).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x74",
         "EventName": "TOPDOWN_BE_BOUND.SERIALIZATION",
         "SampleAfterValue": "1000003",
@@ -446,12 +503,14 @@
     },
     {
         "BriefDescription": "Counts the total number of issue slots every =
cycle that were not consumed by the backend due to frontend stalls.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.ALL",
         "SampleAfterValue": "1000003"
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
@@ -460,6 +519,7 @@
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
@@ -468,6 +528,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to the microcode sequencer (MS)=
.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.CISC",
         "SampleAfterValue": "1000003",
@@ -475,6 +536,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to decode stalls.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.DECODE",
         "SampleAfterValue": "1000003",
@@ -482,6 +544,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to frontend bandwidth restricti=
ons due to decode, predecode, cisc, and other limitations.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH",
         "SampleAfterValue": "1000003",
@@ -489,6 +552,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to a latency related stalls inc=
luding BACLEARs, BTCLEARs, ITLB misses, and ICache misses.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.FRONTEND_LATENCY",
         "SampleAfterValue": "1000003",
@@ -496,6 +560,7 @@
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
@@ -504,6 +569,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to other common frontend stalls=
 not categorized.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.OTHER",
         "SampleAfterValue": "1000003",
@@ -511,6 +577,7 @@
     },
     {
         "BriefDescription": "Counts the number of issue slots every cycle =
that were not delivered by the frontend due to wrong predecodes.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x71",
         "EventName": "TOPDOWN_FE_BOUND.PREDECODE",
         "SampleAfterValue": "1000003",
@@ -518,13 +585,23 @@
     },
     {
         "BriefDescription": "Counts the total number of consumed retiremen=
t slots.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "TOPDOWN_RETIRING.ALL",
         "PEBS": "1",
         "SampleAfterValue": "1000003"
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
+        "SampleAfterValue": "200003"
+    },
     {
         "BriefDescription": "Counts the total number of uops retired.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.ALL",
         "PEBS": "1",
@@ -532,6 +609,7 @@
     },
     {
         "BriefDescription": "Counts the number of integer divide uops reti=
red.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.IDIV",
         "PEBS": "1",
@@ -540,6 +618,7 @@
     },
     {
         "BriefDescription": "Counts the number of uops that are from compl=
ex flows issued by the micro-sequencer (MS).",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.MS",
         "PEBS": "1",
@@ -549,6 +628,7 @@
     },
     {
         "BriefDescription": "Counts the number of x87 uops retired, includ=
es those in MS flows.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0xc2",
         "EventName": "UOPS_RETIRED.X87",
         "PEBS": "1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
index 8bf020a9dfa8..7c0779c74154 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
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
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json
index 163d7e7755c4..bcf275cd592a 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-memory.json
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
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json b/=
tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
index 2af92e43b28a..1ac5b5ef8094 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-other.json
@@ -1,6 +1,7 @@
 [
     {
         "BriefDescription": "This 48-bit fixed counter counts the UCLK cyc=
les.",
+        "Counter": "FIXED",
         "EventCode": "0xff",
         "EventName": "UNC_CLOCK.SOCKET",
         "PerPkg": "1",
diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json =
b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
index 67fd640f790e..ad2b1349bab4 100644
--- a/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
+++ b/tools/perf/pmu-events/arch/x86/alderlaken/virtual-memory.json
@@ -1,6 +1,7 @@
 [
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
@@ -9,6 +10,7 @@
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
@@ -17,6 +19,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks initiated by =
a instruction fetch that missed the first and second level TLBs.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.MISS_CAUSED_WALK",
         "SampleAfterValue": "1000003",
@@ -24,6 +27,7 @@
     },
     {
         "BriefDescription": "Counts the number of page walks due to an ins=
truction fetch that miss the PDE (Page Directory Entry) cache.",
+        "Counter": "0,1,2,3,4,5",
         "EventCode": "0x85",
         "EventName": "ITLB_MISSES.PDE_CACHE_MISS",
         "SampleAfterValue": "2000003",
@@ -31,6 +35,7 @@
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
@@ -39,6 +44,7 @@
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
index ec40215377f3..519842e52fcb 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
 GenuineIntel-6-(97|9A|B7|BA|BF),v1.27,alderlake,core
-GenuineIntel-6-BE,v1.24,alderlaken,core
+GenuineIntel-6-BE,v1.27,alderlaken,core
 GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
 GenuineIntel-6-(3D|47),v29,broadwell,core
 GenuineIntel-6-56,v11,broadwellde,core
--=20
2.45.2.627.g7a2c4fd464-goog

