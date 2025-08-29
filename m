Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B5C202987
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 05:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445570; cv=none; b=RMiyUa3mJD//+fIqOX1aw6GplYWI4tpbMSG6oUQmrZLB7jdFQvuQ/yf+Jfz4f6diQXCdu/kw2KabmivPzG6JSmiE/PoG1jpvkMWEwc4sjJudW9eJfEPebc7NB4oxPlqcMrhQgXY95p5q0KUAhaX/q/yE5bF5zILrNRjfLr0ZXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445570; c=relaxed/simple;
	bh=qhzqJB8xjjx7hDGsiqNEPrBT+3QQAgj7yc0dso5UGtc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iR9Ahq0BghKHe08kq9CnXltKiHV7alImcJisVj/LdqXBtmzcTL9QDrh6DCS+YD5tx+ckql4LYCR8qUP5qdNoiDGw2nMj6Qf2PCRxskJ4BGGdVlFWsuwR41HG45m2e+Vc0rA8GJhwL3t+Ajt3wJmUWpvsI4AEDuGd6+sPdZUiIlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmNaOEqw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmNaOEqw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246cf6af2f4so33940195ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 22:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756445568; x=1757050368; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpvVsEm8uCiz3vvKLatxB4dMae1DpSClGqRKsbH6ivQ=;
        b=OmNaOEqwUX4zzmqypzZDqE2uAnksfqCHIzxygyQAq5haJ4u6WZ63EtsGRBQu12KrxP
         2dRemGavE6ULbFS85GzdsVrsBJH1Ms+E0lMz1ABbRcQ/wIOkdLT/B/pPG3dEhCm1m1LB
         6Jnndt+jx2fyVLj1UYX2yY4WQcqFCvhxyuMN+4sPZsKC0PnC+WKno/wGCURtQHLoenCq
         VWiHpkKWn+iJf4tX6/poYyaz96AqNmOMJOsb4EiAzJ+IzNMZIaBpRYBrITE2rq70YoBl
         3H4dN+kswFIRb+Cc5egxp3c+9TZLw1hyLWV0vYa/CUvXjtLkeiF6UmHQ6Ovl19kh5gRO
         tQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756445568; x=1757050368;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpvVsEm8uCiz3vvKLatxB4dMae1DpSClGqRKsbH6ivQ=;
        b=JtvPrTP80n5YWuZXWFBokMYZa7J0ePLwHBWYxgsVSHJn59JN5KdmjQvG0bj3yTxR+m
         9olCD0bGp0XuHqsMswFpBYTOTIZ4oO0vqdobd1jM3bdd2PCGOjS4QEwpMBDsd+9YtMC6
         YbNclHRhhY39+C3GgKX6+/QJqIoKXzybBeUqvImqcHEJMzinRfuRQSxHee5b6O8PQjdX
         zyuaJEdniwkjfnL7KjkP0XX307R9U08mnQPBfOjPc2zwDT5aNWZivHpSNBs8f+ltrnt8
         19mOgdX3ZDn/iKPeV6Ym6kc5oTMPE9agjsjSWFrSc6FXT7XEBAwGBFcov+7xWKaO8gwV
         qfJg==
X-Forwarded-Encrypted: i=1; AJvYcCWky9RyZYt5tulLoELc0T47+6XtvjyhgEUvwIkxbjVEU3abcKM8qkk7zAd6ahJ7h6QErij7wr0KwmG1T855cx/b@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlNJAocctxdPNalscOAexPkgs/CKl6oo85wKBXDb1tX3ajLIX
	RyW5X+iVKOJR2yQM/WWoZd+vSJ3HnccD7iFD7CHwBbxK1AGf05LlvJabeLWq7Ttda2aEFgVthsH
	OVCjdkD92HQ==
X-Google-Smtp-Source: AGHT+IEuURIFdhc60Y7oiueRhiGe3lniJZNN2qIl7eyAybDR/lYTz6yTkgMcOHrIV8zSjhUwXzxVb1x9NUmN
X-Received: from plry17.prod.google.com ([2002:a17:902:b491:b0:248:6b51:1364])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a43:b0:246:adf0:c32e
 with SMTP id d9443c01a7336-246adf0c686mr237822065ad.40.1756445567979; Thu, 28
 Aug 2025 22:32:47 -0700 (PDT)
Date: Thu, 28 Aug 2025 22:32:33 -0700
In-Reply-To: <20250829053235.21994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829053235.21994-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829053235.21994-2-irogers@google.com>
Subject: [PATCH v5 1/3] perf jevents: Add collection of topdown like metrics
 for arm64
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Metrics are created using legacy, common and recommended events. As
events may be missing a TryEvent function will give None if an event
is missing. To workaround missing JSON events for cortex-a53, sysfs
encodings are used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arm64_metrics.py | 148 ++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index c9aa2d827a82..067ebbad1adf 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -1,14 +1,152 @@
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
+  return MetricGroup("lpm_topdown", [
+      MetricGroup("lpm_topdown_tl", [
+          Metric("lpm_topdown_tl_ipc", "Instructions per cycle", d_ratio(
+              ins, cycles), "insn/cycle"),
+          Metric("lpm_topdown_tl_stall_fe_rate", "Frontend stalls to all cycles",
+                 d_ratio(stall_fe, cycles), "100%") if stall_fe else None,
+          Metric("lpm_topdown_tl_stall_be_rate", "Backend stalls to all cycles",
+                 d_ratio(stall_be, cycles), "100%") if stall_be else None,
+      ]),
+      MetricGroup("lpm_topdown_fe_bound", [
+          MetricGroup("lpm_topdown_fe_br", [
+              Metric("lpm_topdown_fe_br_mp_per_insn",
+                     "Branch mispredicts per instruction retired",
+                     d_ratio(br_mp_ret, ins_ret), "br/insn") if br_mp_ret else None,
+              Metric("lpm_topdown_fe_br_ins_rate",
+                     "Branches per instruction retired", d_ratio(
+                         br_ret, ins_ret), "100%") if br_ret else None,
+              Metric("lpm_topdown_fe_br_mispredict",
+                     "Branch mispredicts per branch instruction",
+                     d_ratio(br_mp_ret, br_ret), "100%") if (br_mp_ret and br_ret) else None,
+          ]),
+          MetricGroup("lpm_topdown_fe_itlb", [
+              Metric("lpm_topdown_fe_itlb_walks", "Itlb walks per insn",
+                     d_ratio(itlb_walk, ins_ret), "walk/insn"),
+              Metric("lpm_topdown_fe_itlb_walk_rate", "Itlb walks per L1I TLB access",
+                     d_ratio(itlb_walk, l1i_tlb) if l1i_tlb else None, "100%"),
+          ]) if itlb_walk else None,
+          MetricGroup("lpm_topdown_fe_icache", [
+              Metric("lpm_topdown_fe_icache_l1i_per_insn",
+                     "L1I cache refills per instruction",
+                     d_ratio(l1i_refill, ins_ret), "l1i/insn"),
+              Metric("lpm_topdown_fe_icache_l1i_miss_rate",
+                     "L1I cache refills per L1I cache access",
+                     d_ratio(l1i_refill, l1i_access), "100%"),
+          ]),
+      ]),
+      MetricGroup("lpm_topdown_be_bound", [
+          MetricGroup("lpm_topdown_be_dtlb", [
+              Metric("lpm_topdown_be_dtlb_walks", "Dtlb walks per instruction",
+                     d_ratio(dtlb_walk, ins_ret), "walk/insn"),
+              Metric("lpm_topdown_be_dtlb_walk_rate", "Dtlb walks per L1D TLB access",
+                     d_ratio(dtlb_walk, l1d_tlb) if l1d_tlb else None, "100%"),
+          ]) if dtlb_walk else None,
+          MetricGroup("lpm_topdown_be_mix", [
+              Metric("lpm_topdown_be_mix_ld", "Percentage of load instructions",
+                     d_ratio(ld_spec, inst_spec), "100%") if ld_spec else None,
+              Metric("lpm_topdown_be_mix_st", "Percentage of store instructions",
+                     d_ratio(st_spec, inst_spec), "100%") if st_spec else None,
+              Metric("lpm_topdown_be_mix_simd", "Percentage of SIMD instructions",
+                     d_ratio(ase_spec, inst_spec), "100%") if ase_spec else None,
+              Metric("lpm_topdown_be_mix_fp",
+                     "Percentage of floating point instructions",
+                     d_ratio(vfp_spec, inst_spec), "100%") if vfp_spec else None,
+              Metric("lpm_topdown_be_mix_dp",
+                     "Percentage of data processing instructions",
+                     d_ratio(dp_spec, inst_spec), "100%") if dp_spec else None,
+              Metric("lpm_topdown_be_mix_crypto",
+                     "Percentage of data processing instructions",
+                     d_ratio(crypto_spec, inst_spec), "100%") if crypto_spec else None,
+              Metric(
+                  "lpm_topdown_be_mix_br", "Percentage of branch instructions",
+                  d_ratio(br_immed_spec + br_indirect_spec + br_ret_spec,
+                          inst_spec), "100%") if br_immed_spec and br_indirect_spec and br_ret_spec else None,
+          ], description="Breakdown of instructions by type. Counts include both useful and wasted speculative instructions"
+                      ) if inst_spec else None,
+          MetricGroup("lpm_topdown_be_dcache", [
+              MetricGroup("lpm_topdown_be_dcache_l1", [
+                  Metric("lpm_topdown_be_dcache_l1_per_insn",
+                         "L1D cache refills per instruction",
+                         d_ratio(l1d_refill, ins_ret), "refills/insn"),
+                  Metric("lpm_topdown_be_dcache_l1_miss_rate",
+                         "L1D cache refills per L1D cache access",
+                         d_ratio(l1d_refill, l1d_access), "100%")
+              ]),
+              MetricGroup("lpm_topdown_be_dcache_l2", [
+                  Metric("lpm_topdown_be_dcache_l2_per_insn",
+                         "L2D cache refills per instruction",
+                         d_ratio(l2d_refill, ins_ret), "refills/insn"),
+                  Metric("lpm_topdown_be_dcache_l2_miss_rate",
+                         "L2D cache refills per L2D cache access",
+                         d_ratio(l2d_refill, l2d_access), "100%")
+              ]),
+              MetricGroup("lpm_topdown_be_dcache_llc", [
+                  Metric("lpm_topdown_be_dcache_llc_per_insn",
+                         "Last level cache misses per instruction",
+                         d_ratio(llc_miss_rd, ins_ret), "miss/insn"),
+                  Metric("lpm_topdown_be_dcache_llc_miss_rate",
+                         "Last level cache misses per last level cache access",
+                         d_ratio(llc_miss_rd, llc_access), "100%")
+              ]) if llc_miss_rd and llc_access else None,
+          ]),
+      ]),
+  ])
+
+
 def main() -> None:
   global _args
 
@@ -29,11 +167,13 @@ def main() -> None:
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
2.51.0.318.gd7df087d1a-goog

