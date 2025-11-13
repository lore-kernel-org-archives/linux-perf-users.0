Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50493203AF
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004151; cv=none; b=YeNn4ibhO6OpFcRixU06Udz3gfaLa54MRx8j+TS0eBBMK2WQXbTpSdANi2ZIml12o/xTh6rgathDJkhlT7mEK5bn2oy+AaSjnb02zX++//fY4NxvH9ueFgm5EijIDePMtA9Jc2GxVVTcEjz3b8+7/c6lFdHJZFjD2I2AgjspsL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004151; c=relaxed/simple;
	bh=gx3ZMnSYtNIuR3G6XwpmhwyPw3htrhCWEk6aSMYO74o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=THfvA5NKDdU6ipAcC1ZIcrWOnPedEd/UWuXwbExh2ebI0i3NhrvmUMDWFuq2F0jM5corgOnKQtV+yYcrpM2DMzDq7oL+VZwMr8URzta2HQH/3ZRcQa5i+AvPuDpunmjYn0scP0IAk6W2rX8FiKCiN2kzpwtOjvHwB5He5e/9ots=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2iBnDHp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2iBnDHp"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3418ad76023so813999a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004149; x=1763608949; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Py7UXsECNzbINGh7G1N+IUTfJZI2trHuRJHUZOKXcoE=;
        b=o2iBnDHpzugsrfhhHGTzGzEYBPwYISIvs9YMnSbc1cbSGI5vH59FGmIVXJe3llgr8s
         0HjGnOVDfy0WjrVvucSfjhKImvSY5qhffnMRsaZahh3LqAgn2zXZQ7fgTDJHL6XgBzKN
         7o3oQtGOGAdgGeglipzl5spf2+vhyil3vrQkg9UTQWTQrV0a+Rm9XhyXLs9OGEeJbGKL
         sqAv+cJO0t+NfkxwF4SoTuIBQ4r4K2O2K7N2W+X6ZEzKa//qvX6R4HiXzxmWmIBp33yz
         b+G4EAaOYGXTuKno2mt4rCuT4/PEi+fGjpOyuy4ZJMcgX2z6I2+4oPk3kMSNy50Unhg0
         JVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004149; x=1763608949;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Py7UXsECNzbINGh7G1N+IUTfJZI2trHuRJHUZOKXcoE=;
        b=vB7SIk5PYdO1ri9Gb9/IGWnJjQixzPCLFkl53jwuEawpBj4YShYLqn1x2CiVwRMhkj
         GEXy8KawlDLfuUK2MFA6AkrNXyV3GmUVGlaJRLmck5NVmWGwKn9Mhl+Xx1pIixveWziG
         izwKzAXvY8q/8+0mvdr6XtDLde6vOmyReW62jjXITO88g0rkeJRA7+E4MBR8V1L/Ln3m
         Rq9OmGsFWxeOahBMdNpJI4c6CMD5vWCkyZ98h5fA0td3F4kCiCAH5ZCKaVSpEf5wkqrS
         JLr/xY4oiq/5BDHg7JJo2lWzy678J7JFcbZY8d3X4Fjl6N+tMEg+By9ycZ7YaInnhILl
         rumQ==
X-Forwarded-Encrypted: i=1; AJvYcCULtbVhyCnv4H35p7UwOo14YcrjrBa9l3GSeqT6zbti7tv7iS4zyAmcoqiv9vp+tdp6wJnEVX4pBtIa7td0pA50@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg75y3KChrr3nAjKq0TM2tbLzTDcnBRtGb7LSNGJ+QiLpohbNZ
	JGpuBa3SVMR7Bg/f/iSan7rEswhCL/KwQcn6G6MiPaXFsm5jYNSCcvp4mWh+i8y5tZpgaKUFvI1
	cjHZZ+n66eg==
X-Google-Smtp-Source: AGHT+IFnpk6PysmHuavubxWMqAYlCEJEyOobEwOluQgkYTeGg/TSO0+cKMWOUVR/Kv+k72uf/DWMPvDPKgbr
X-Received: from dlbqc12.prod.google.com ([2002:a05:7023:a8c:b0:11a:3b81:6bc6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e948:b0:298:2e7a:3c47
 with SMTP id d9443c01a7336-2984ee01fb9mr61445375ad.42.1763004148816; Wed, 12
 Nov 2025 19:22:28 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:38 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-51-irogers@google.com>
Subject: [PATCH v8 50/52] perf jevents: Add collection of topdown like metrics
 for arm64
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics are created using legacy, common and recommended events. As
events may be missing a TryEvent function will give None if an event
is missing. To workaround missing JSON events for cortex-a53, sysfs
encodings are used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arm64_metrics.py | 145 ++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index ac717ca3513a..9678253e2e0e 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -2,13 +2,150 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
 import os
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from typing import Optional
+from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup)
 
 # Global command line arguments.
 _args = None
 
 
+def Arm64Topdown() -> MetricGroup:
+    """Returns a MetricGroup representing ARM64 topdown like metrics."""
+    def TryEvent(name: str) -> Optional[Event]:
+        # Skip an event if not in the json files.
+        try:
+            return Event(name)
+        except:
+            return None
+    # ARM models like a53 lack JSON for INST_RETIRED but have the
+    # architetural standard event in sysfs. Use the PMU name to identify
+    # the sysfs event.
+    pmu_name = f'armv8_{_args.model.replace("-", "_")}'
+    ins = Event("instructions")
+    ins_ret = Event("INST_RETIRED", f"{pmu_name}/inst_retired/")
+    cycles = Event("cpu\\-cycles")
+    stall_fe = TryEvent("STALL_FRONTEND")
+    stall_be = TryEvent("STALL_BACKEND")
+    br_ret = TryEvent("BR_RETIRED")
+    br_mp_ret = TryEvent("BR_MIS_PRED_RETIRED")
+    dtlb_walk = TryEvent("DTLB_WALK")
+    itlb_walk = TryEvent("ITLB_WALK")
+    l1d_tlb = TryEvent("L1D_TLB")
+    l1i_tlb = TryEvent("L1I_TLB")
+    l1d_refill = Event("L1D_CACHE_REFILL", f"{pmu_name}/l1d_cache_refill/")
+    l2d_refill = Event("L2D_CACHE_REFILL", f"{pmu_name}/l2d_cache_refill/")
+    l1i_refill = Event("L1I_CACHE_REFILL", f"{pmu_name}/l1i_cache_refill/")
+    l1d_access = Event("L1D_CACHE", f"{pmu_name}/l1d_cache/")
+    l2d_access = Event("L2D_CACHE", f"{pmu_name}/l2d_cache/")
+    llc_access = TryEvent("LL_CACHE_RD")
+    l1i_access = Event("L1I_CACHE", f"{pmu_name}/l1i_cache/")
+    llc_miss_rd = TryEvent("LL_CACHE_MISS_RD")
+    ase_spec = TryEvent("ASE_SPEC")
+    ld_spec = TryEvent("LD_SPEC")
+    st_spec = TryEvent("ST_SPEC")
+    vfp_spec = TryEvent("VFP_SPEC")
+    dp_spec = TryEvent("DP_SPEC")
+    br_immed_spec = TryEvent("BR_IMMED_SPEC")
+    br_indirect_spec = TryEvent("BR_INDIRECT_SPEC")
+    br_ret_spec = TryEvent("BR_RETURN_SPEC")
+    crypto_spec = TryEvent("CRYPTO_SPEC")
+    inst_spec = TryEvent("INST_SPEC")
+    return MetricGroup("lpm_topdown", [
+        MetricGroup("lpm_topdown_tl", [
+            Metric("lpm_topdown_tl_ipc", "Instructions per cycle", d_ratio(
+                ins, cycles), "insn/cycle"),
+            Metric("lpm_topdown_tl_stall_fe_rate", "Frontend stalls to all cycles",
+                   d_ratio(stall_fe, cycles), "100%") if stall_fe else None,
+            Metric("lpm_topdown_tl_stall_be_rate", "Backend stalls to all cycles",
+                   d_ratio(stall_be, cycles), "100%") if stall_be else None,
+        ]),
+        MetricGroup("lpm_topdown_fe_bound", [
+            MetricGroup("lpm_topdown_fe_br", [
+                Metric("lpm_topdown_fe_br_mp_per_insn",
+                       "Branch mispredicts per instruction retired",
+                       d_ratio(br_mp_ret, ins_ret), "br/insn") if br_mp_ret else None,
+                Metric("lpm_topdown_fe_br_ins_rate",
+                       "Branches per instruction retired", d_ratio(
+                           br_ret, ins_ret), "100%") if br_ret else None,
+                Metric("lpm_topdown_fe_br_mispredict",
+                       "Branch mispredicts per branch instruction",
+                       d_ratio(br_mp_ret, br_ret), "100%") if (br_mp_ret and br_ret) else None,
+            ]),
+            MetricGroup("lpm_topdown_fe_itlb", [
+                Metric("lpm_topdown_fe_itlb_walks", "Itlb walks per insn",
+                       d_ratio(itlb_walk, ins_ret), "walk/insn"),
+                Metric("lpm_topdown_fe_itlb_walk_rate", "Itlb walks per L1I TLB access",
+                       d_ratio(itlb_walk, l1i_tlb) if l1i_tlb else None, "100%"),
+            ]) if itlb_walk else None,
+            MetricGroup("lpm_topdown_fe_icache", [
+                Metric("lpm_topdown_fe_icache_l1i_per_insn",
+                       "L1I cache refills per instruction",
+                       d_ratio(l1i_refill, ins_ret), "l1i/insn"),
+                Metric("lpm_topdown_fe_icache_l1i_miss_rate",
+                       "L1I cache refills per L1I cache access",
+                       d_ratio(l1i_refill, l1i_access), "100%"),
+            ]),
+        ]),
+        MetricGroup("lpm_topdown_be_bound", [
+            MetricGroup("lpm_topdown_be_dtlb", [
+                Metric("lpm_topdown_be_dtlb_walks", "Dtlb walks per instruction",
+                       d_ratio(dtlb_walk, ins_ret), "walk/insn"),
+                Metric("lpm_topdown_be_dtlb_walk_rate", "Dtlb walks per L1D TLB access",
+                       d_ratio(dtlb_walk, l1d_tlb) if l1d_tlb else None, "100%"),
+            ]) if dtlb_walk else None,
+            MetricGroup("lpm_topdown_be_mix", [
+                Metric("lpm_topdown_be_mix_ld", "Percentage of load instructions",
+                       d_ratio(ld_spec, inst_spec), "100%") if ld_spec else None,
+                Metric("lpm_topdown_be_mix_st", "Percentage of store instructions",
+                       d_ratio(st_spec, inst_spec), "100%") if st_spec else None,
+                Metric("lpm_topdown_be_mix_simd", "Percentage of SIMD instructions",
+                       d_ratio(ase_spec, inst_spec), "100%") if ase_spec else None,
+                Metric("lpm_topdown_be_mix_fp",
+                       "Percentage of floating point instructions",
+                       d_ratio(vfp_spec, inst_spec), "100%") if vfp_spec else None,
+                Metric("lpm_topdown_be_mix_dp",
+                       "Percentage of data processing instructions",
+                       d_ratio(dp_spec, inst_spec), "100%") if dp_spec else None,
+                Metric("lpm_topdown_be_mix_crypto",
+                       "Percentage of data processing instructions",
+                       d_ratio(crypto_spec, inst_spec), "100%") if crypto_spec else None,
+                Metric(
+                    "lpm_topdown_be_mix_br", "Percentage of branch instructions",
+                    d_ratio(br_immed_spec + br_indirect_spec + br_ret_spec,
+                            inst_spec), "100%") if br_immed_spec and br_indirect_spec and br_ret_spec else None,
+            ], description="Breakdown of instructions by type. Counts include both useful and wasted speculative instructions"
+            ) if inst_spec else None,
+            MetricGroup("lpm_topdown_be_dcache", [
+                MetricGroup("lpm_topdown_be_dcache_l1", [
+                    Metric("lpm_topdown_be_dcache_l1_per_insn",
+                           "L1D cache refills per instruction",
+                           d_ratio(l1d_refill, ins_ret), "refills/insn"),
+                    Metric("lpm_topdown_be_dcache_l1_miss_rate",
+                           "L1D cache refills per L1D cache access",
+                           d_ratio(l1d_refill, l1d_access), "100%")
+                ]),
+                MetricGroup("lpm_topdown_be_dcache_l2", [
+                    Metric("lpm_topdown_be_dcache_l2_per_insn",
+                           "L2D cache refills per instruction",
+                           d_ratio(l2d_refill, ins_ret), "refills/insn"),
+                    Metric("lpm_topdown_be_dcache_l2_miss_rate",
+                           "L2D cache refills per L2D cache access",
+                           d_ratio(l2d_refill, l2d_access), "100%")
+                ]),
+                MetricGroup("lpm_topdown_be_dcache_llc", [
+                    Metric("lpm_topdown_be_dcache_llc_per_insn",
+                           "Last level cache misses per instruction",
+                           d_ratio(llc_miss_rd, ins_ret), "miss/insn"),
+                    Metric("lpm_topdown_be_dcache_llc_miss_rate",
+                           "Last level cache misses per last level cache access",
+                           d_ratio(llc_miss_rd, llc_access), "100%")
+                ]) if llc_miss_rd and llc_access else None,
+            ]),
+        ]),
+    ])
+
+
 def main() -> None:
     global _args
 
@@ -34,7 +171,9 @@ def main() -> None:
     directory = f"{_args.events_path}/arm64/{_args.vendor}/{_args.model}/"
     LoadEvents(directory)
 
-    all_metrics = MetricGroup("", [])
+    all_metrics = MetricGroup("", [
+        Arm64Topdown(),
+    ])
 
     if _args.metricgroups:
         print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.51.2.1041.gc1ab5b90ca-goog

