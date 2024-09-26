Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033F816190C
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373438; cv=none; b=JsrTEgblvTaxgcXScyHCUSLyDmBKUa5FHeYvMJNvtJUg2Ia+2RzeilnGNDhvjDbA0RqGg+5BCobBv90a4Q/pj/3AbHIP/AnNZGy7skjkS1BMdwW7HF1CDek4evDCXG0W4xuOp9OZeZce0m3Lg/0QTq4cAr/BHRevAW+F0yGvVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373438; c=relaxed/simple;
	bh=ZTK92q4RFLPAjkGGa1skdj3VateibzHP+LCLYx3sGUM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QVAst8WiFuenLxH2nEfYYD215HcwQmQPUxzK+bQfktw93qwORlOeIZva18m7lsm4b+NeJqwVxEGT8Uwntev8VKZUgE/Lxuv+33u0RCQ1Fwbkc/wbEDxcMRLQHvzjJ+bp7bAVHFvuo2QIZeTqJRzJRFCt3gZdCsK+V8QgUmuHaQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WQuJ97Dt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQuJ97Dt"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso1946546276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373436; x=1727978236; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cU9C0fTropODlwtsKfLgQvitpR0/EKmE15ZjjPFd3T8=;
        b=WQuJ97DtUi+ym/S8AfK6MFKSSIEU7pvIeV8hthdTTiIoRHPiiWbJ8y/AXFnfkqEfCh
         jRyStps5VihjTP3Ac/0D9eJ5uQxMms14Bi/bXwk2LbHeJYWMm8eXaDM/TT3hJyYg4Crh
         fxlPcDWHoMmRpptOcB3ik0k/5Tn63G8m6GWKuZ4YzHdmfeL3aNCOS7rZUw5KsmXMB6kX
         yS4L5+P23qWHi4kZMFkhTZaJ0oLR8RS14FyCpij/sSz5kj2I6bwvwukwK0Aw0BErhIxL
         KOT/HKg6uIfGTBSFbQS2zNUNxb+pkmDTBbXLSfOotIjBHgnMR8hZcwMLI7CN6GYZMDIG
         GxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373436; x=1727978236;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cU9C0fTropODlwtsKfLgQvitpR0/EKmE15ZjjPFd3T8=;
        b=JgThRbiAhtrZwG+/jIABXOYJnz5aEX9Ww2aHQ7wwqq/GSJ7VEkTRN5taYrsx8y2MQ8
         Md2+toPiYaqj2z7QAfKcyozqEoD+cRe5LcTUL5df9ZjMm3qu4VtdfEaZLMF8QV/5bqmH
         Gu/eJ62va8/N7+kAk5zTSzy1xEfkwg3eybcUPipgx8tx0HPpahlFzBYMCSx84orhWMW4
         +mCy5fQKY04TrRzj+6mvIZ3xcyCWKgBGidYeHYtEhLVYia/OGCXBB/YPGcVgYxiA2k9n
         JlQfWurD2kkXf7Ytp1rTEU0to5l04TWmngS2m9+SzwE4DDmhdh9wZyqsz2ae9tAcxEP/
         UNhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMG9a96ZdP+dUs9EJ4+6unVSyaJ97iGGYUc86/aO1dMxgi1s6bRWoPs3SpN0gAz2FNY06eX/lo3El2+ioanv+o@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoa5NcXubOhUR0ek0vg08YikcRgw9Re8Xm+h21efOf9yMsp+eH
	Aj2mAtnCbm+Hb+QXtf5OExjgSYeflJ7nuZ2qWtMTovlOQL0Tuc8PpzMF1ILajgsTZMBkhRPqWoN
	9+aIBPQ==
X-Google-Smtp-Source: AGHT+IGZTKE/arBaRbJS0gxjAawvx07pjVPcwCbA6PFVXac/4RN2WY4fB7ZyIiQfxj5MwsRwWPvZhHjJO9F+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a25:ab08:0:b0:e11:69f2:e39 with SMTP id
 3f1490d57ef6-e2604c7b4cbmr203276.9.1727373435939; Thu, 26 Sep 2024 10:57:15
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:57:08 -0700
In-Reply-To: <20240926175709.410022-1-irogers@google.com>
Message-Id: <20240926175709.410022-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175709.410022-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 1/2] perf jevents: Add collection of topdown like metrics
 for arm64
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Metrics are created using legacy, common and recommended events. As
events may be missing a TryEvent function will give None if an event
is missing. To workaround missing JSON events for cortex-a53, sysfs
encodings are used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arm64_metrics.py | 147 ++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index c9aa2d827a82..bfac570600d9 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -1,14 +1,151 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup)
 import argparse
 import json
 import os
+from typing import Optional
 
 # Global command line arguments.
 _args = None
 
+def Arm64Topdown() -> MetricGroup:
+  """Returns a MetricGroup representing ARM64 topdown like metrics."""
+  def TryEvent(name: str) -> Optional[Event]:
+    # Skip an event if not in the json files.
+    try:
+      return Event(name)
+    except:
+      return None
+  # ARM models like a53 lack JSON for INST_RETIRED but have the
+  # architetural standard event in sysfs. Use the PMU name to identify
+  # the sysfs event.
+  pmu_name = f'armv8_{_args.model.replace("-", "_")}'
+  ins = Event("instructions")
+  ins_ret = Event("INST_RETIRED", f"{pmu_name}/inst_retired/")
+  cycles = Event("cycles")
+  stall_fe = TryEvent("STALL_FRONTEND")
+  stall_be = TryEvent("STALL_BACKEND")
+  br_ret = TryEvent("BR_RETIRED")
+  br_mp_ret = TryEvent("BR_MIS_PRED_RETIRED")
+  dtlb_walk = TryEvent("DTLB_WALK")
+  itlb_walk = TryEvent("ITLB_WALK")
+  l1d_tlb = TryEvent("L1D_TLB")
+  l1i_tlb = TryEvent("L1I_TLB")
+  l1d_refill = Event("L1D_CACHE_REFILL", f"{pmu_name}/l1d_cache_refill/")
+  l2d_refill = Event("L2D_CACHE_REFILL", f"{pmu_name}/l2d_cache_refill/")
+  l1i_refill = Event("L1I_CACHE_REFILL", f"{pmu_name}/l1i_cache_refill/")
+  l1d_access = Event("L1D_CACHE", f"{pmu_name}/l1d_cache/")
+  l2d_access = Event("L2D_CACHE", f"{pmu_name}/l2d_cache/")
+  llc_access = TryEvent("LL_CACHE_RD")
+  l1i_access = Event("L1I_CACHE", f"{pmu_name}/l1i_cache/")
+  llc_miss_rd = TryEvent("LL_CACHE_MISS_RD")
+  ase_spec = TryEvent("ASE_SPEC")
+  ld_spec = TryEvent("LD_SPEC")
+  st_spec = TryEvent("ST_SPEC")
+  vfp_spec = TryEvent("VFP_SPEC")
+  dp_spec = TryEvent("DP_SPEC")
+  br_immed_spec = TryEvent("BR_IMMED_SPEC")
+  br_indirect_spec = TryEvent("BR_INDIRECT_SPEC")
+  br_ret_spec = TryEvent("BR_RETURN_SPEC")
+  crypto_spec = TryEvent("CRYPTO_SPEC")
+  inst_spec = TryEvent("INST_SPEC")
+
+  return MetricGroup("topdown", [
+      MetricGroup("topdown_tl", [
+          Metric("topdown_tl_ipc", "Instructions per cycle", d_ratio(
+              ins, cycles), "insn/cycle"),
+          Metric("topdown_tl_stall_fe_rate", "Frontend stalls to all cycles",
+                 d_ratio(stall_fe, cycles), "100%") if stall_fe else None,
+          Metric("topdown_tl_stall_be_rate", "Backend stalls to all cycles",
+                 d_ratio(stall_be, cycles), "100%") if stall_be else None,
+      ]),
+      MetricGroup("topdown_fe_bound", [
+          MetricGroup("topdown_fe_br", [
+              Metric("topdown_fe_br_mp_per_insn",
+                     "Branch mispredicts per instruction retired",
+                     d_ratio(br_mp_ret, ins_ret), "br/insn") if br_mp_ret else None,
+              Metric("topdown_fe_br_ins_rate",
+                     "Branches per instruction retired", d_ratio(
+                         br_ret, ins_ret), "100%") if br_ret else None,
+              Metric("topdown_fe_br_mispredict",
+                     "Branch mispredicts per branch instruction",
+                     d_ratio(br_mp_ret, br_ret), "100%") if br_mp_ret else None,
+          ]),
+          MetricGroup("topdown_fe_itlb", [
+              Metric("topdown_fe_itlb_walks", "Itlb walks per insn",
+                     d_ratio(itlb_walk, ins_ret), "walk/insn"),
+              Metric("topdown_fe_itlb_walk_rate", "Itlb walks per l1i access",
+                     d_ratio(itlb_walk, l1i_tlb), "100%"),
+          ]) if itlb_walk else None,
+          MetricGroup("topdown_fe_icache", [
+              Metric("topdown_fe_icache_l1i_per_insn",
+                     "L1I cache refills per instruction",
+                     d_ratio(l1i_refill, ins_ret), "l1i/insn"),
+              Metric("topdown_fe_icache_l1i_miss_rate",
+                     "L1I cache refills per L1I cache access",
+                     d_ratio(l1i_refill, l1i_access), "100%"),
+          ]),
+      ]),
+      MetricGroup("topdown_be_bound", [
+          MetricGroup("topdown_be_dtlb", [
+              Metric("topdown_be_dtlb_walks", "Dtlb walks per instruction",
+                     d_ratio(dtlb_walk, ins_ret), "walk/insn"),
+              Metric("topdown_be_dtlb_walk_rate", "Dtlb walks per l1d access",
+                     d_ratio(dtlb_walk, l1d_tlb), "100%"),
+          ]) if dtlb_walk else None,
+          MetricGroup("topdown_be_mix", [
+              Metric("topdown_be_mix_ld", "Percentage of load instructions",
+                     d_ratio(ld_spec, inst_spec), "100%") if ld_spec else None,
+              Metric("topdown_be_mix_st", "Percentage of store instructions",
+                     d_ratio(st_spec, inst_spec), "100%") if st_spec else None,
+              Metric("topdown_be_mix_simd", "Percentage of SIMD instructions",
+                     d_ratio(ase_spec, inst_spec), "100%") if ase_spec else None,
+              Metric("topdown_be_mix_fp",
+                     "Percentage of floating point instructions",
+                     d_ratio(vfp_spec, inst_spec), "100%") if vfp_spec else None,
+              Metric("topdown_be_mix_dp",
+                     "Percentage of data processing instructions",
+                     d_ratio(dp_spec, inst_spec), "100%") if dp_spec else None,
+              Metric("topdown_be_mix_crypto",
+                     "Percentage of data processing instructions",
+                     d_ratio(crypto_spec, inst_spec), "100%") if crypto_spec else None,
+              Metric(
+                  "topdown_be_mix_br", "Percentage of branch instructions",
+                  d_ratio(br_immed_spec + br_indirect_spec + br_ret_spec,
+                          inst_spec), "100%") if br_immed_spec and br_indirect_spec and br_ret_spec else None,
+          ]) if inst_spec else None,
+          MetricGroup("topdown_be_dcache", [
+              MetricGroup("topdown_be_dcache_l1", [
+                  Metric("topdown_be_dcache_l1_per_insn",
+                         "L1D cache refills per instruction",
+                         d_ratio(l1d_refill, ins_ret), "refills/insn"),
+                  Metric("topdown_be_dcache_l1_miss_rate",
+                         "L1D cache refills per L1D cache access",
+                         d_ratio(l1d_refill, l1d_access), "100%")
+              ]),
+              MetricGroup("topdown_be_dcache_l2", [
+                  Metric("topdown_be_dcache_l2_per_insn",
+                         "L2D cache refills per instruction",
+                         d_ratio(l2d_refill, ins_ret), "refills/insn"),
+                  Metric("topdown_be_dcache_l2_miss_rate",
+                         "L2D cache refills per L2D cache access",
+                         d_ratio(l2d_refill, l2d_access), "100%")
+              ]),
+              MetricGroup("topdown_be_dcache_llc", [
+                  Metric("topdown_be_dcache_llc_per_insn",
+                         "Last level cache misses per instruction",
+                         d_ratio(llc_miss_rd, ins_ret), "miss/insn"),
+                  Metric("topdown_be_dcache_llc_miss_rate",
+                         "Last level cache misses per L2D cache access",
+                         d_ratio(llc_miss_rd, llc_access), "100%")
+              ]) if llc_miss_rd and llc_access else None,
+          ]),
+      ]),
+  ])
+
+
 def main() -> None:
   global _args
 
@@ -29,11 +166,13 @@ def main() -> None:
   )
   _args = parser.parse_args()
 
-  all_metrics = MetricGroup("",[])
-
   directory = f"{_args.events_path}/arm64/{_args.vendor}/{_args.model}/"
   LoadEvents(directory)
 
+  all_metrics = MetricGroup("",[
+      Arm64Topdown(),
+  ])
+
   if _args.metricgroups:
     print(JsonEncodeMetricGroupDescriptions(all_metrics))
   else:
-- 
2.46.1.824.gd892dcdcdd-goog

