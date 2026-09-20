Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22F3CF21F
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881782; cv=none; b=PMQm8dkptQyuorzTt6MeKhOUF9kqsm1rpfIA1/zkpfRRburM6haxWitUro+V9UEhSTzbzn8+uTJMpJV848T5vwhNKE3vjVtUAeX6WAcI4k8yTWPnSODkGf+y06QwjZei1v+6mJZpjTUIg938aIifQjD3yCkNnlIhnGukIekcwsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881782; c=relaxed/simple;
	bh=pHuCKMTo2/IIdNC+ao5cmuSFkwYjPZOAL9KGRsWLCOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mzybORzLNW4qKGJLZm8L/PhdYlRf2PWxnIwcIJA+HXPg4oCkMDviXHZdj4eQePHaTQtTeL613ucuDJYOVKW7ke6Jt+Rt+h8m4gLS4l2Lh8dIWatyq0jLbWENt2FUKqKYYErw0T6lL4bqYiCWVTdlc/4lMgOLOJHT6jlaE36WqMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l7Mk7KFU; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l7Mk7KFU"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e3dad7ab3so2859242a91.2
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881778; x=1790486578; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8iSN2Ub/1Z1l0Jwf7ZnJ9y0uzT9ZCvykKRibJ/T31UY=;
        b=l7Mk7KFUSdMAlQw4h87gfPd5U48tIWg9ZpB3ZNi3EMEG9FGFtq8uqUyRjIEdwhN0pC
         wBzzkH/HiZjdkHFTmRsYU6yOzgfmVnaQBxPLcjAwLG8i/b/w2m3vuor3q/JTnv56VSow
         IFoRmxLEkZsij3/Dp1Gz+lNU1siVBYq4G6u3zT8yxVWFsXSbAaLUGMCLYyhAiU6dttyQ
         4Z2VyrAWzApbbVdTWk/nyIc58GbTxfq9WVZLh+xMXktZ6rYYP6Gq0k/MB48y14KwBtQK
         QSP2mpOruk4fuLC/KqI1K/DVhkRRJ1EECBhTD8RNEEYeAkqd0b1tftqnBINItjiCUW4q
         xt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881778; x=1790486578;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8iSN2Ub/1Z1l0Jwf7ZnJ9y0uzT9ZCvykKRibJ/T31UY=;
        b=bH5xkmGwnzbdNPeox19/jEn4H00+W8dPc5orhISGzsfpFY+VgWw7E2mqE3eGdD2PfK
         WplZ369SFqf45vjo4+nQh3kcxPvajRm0WmmAULEii7iIxwDtULrlK3UhAHi2feT+lma8
         IH7Y/l9vi89L4e6gItIyccw0SmB6pefR6oHrL/fTg2trDnKHMaqqY8JBdKP8j8FGOzeu
         Fo+hRpNT9lvBlJ3j6fW9KEydYIVTaLAPvAWtSmz04u4fNbOdl5vlnZkmogYTURLpxSiY
         qPZAaE8+eUA2QaqDK6abwYH4qHEFBzZQ+gkVmBMuTvJry/9tBuw4La7jDgr8+BU1siqe
         TwAw==
X-Forwarded-Encrypted: i=1; AKwUvByF5+YBwCgQAfalVTL1PBs1Go0GTV6p87xtllPrQEF3ebGT0gnt08YbR6m14/P1FEcZWt5jHUtrx7ExaOf57yfB@vger.kernel.org
X-Gm-Message-State: AFuF++mHa2P6wnqU4E98x0v9tsN1lVDVXQWmEafLwdMkblBafDwA1I/h
	ODrHp++mkTk6RdFDC4ngBZ1spu5Ap/5vTCzUAwc5cl7SfU+XyNiFdmhymnn572nZFD98Av/mzfk
	XxmwoLwD0/g==
X-Received: from dlan4-n2.prod.google.com ([2002:a05:7022:eb44:20b0:144:d065:6639])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:1042:b0:39e:93f8:eb07
 with SMTP id 98e67ed59e1d1-39e93f91acbmr3414163a91.40.1789881777490; Sat, 19
 Sep 2026 22:22:57 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:03 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <339d7d6a5c9d2c4900871cf1221e7bb67dd99ec2.1789880842.git.irogers@google.com>
Subject: [PATCH v1 11/49] perf pmu-events: Clean up mypy and pylint issues
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Clean up mypy type errors and pylint warnings across the pmu-events Python
scripts (amd_metrics.py, intel_metrics.py, jevents.py,
make_legacy_cache.py,
and metric.py) in preparation for making MYPY and PYLINT build tests
opt-out.

In addition to type annotations and unused import/variable cleanups, fix
three bugs in intel_metrics.py exposed by static analysis:
- Fix references to undefined 'args.model' (instead of '_args.model')
  inside
  try/except blocks in IntelL2() and UncoreMemBw(), which previously threw
  NameError and silently disabled Skylake/CascadeLake L2 silent eviction
  adjustments and uncore memory bandwidth JSON loading.
- Define DC_WB_U and DC_WB_D before their first use in IntelL2(), fixing
  an UnboundLocalError that silently dropped the l2_out_rate, wbn, and isd
  metrics.
- Fix Event-to-string comparison and addition in IntelFp() by comparing
  and modifying 'f_assist.name' instead of the Event object 'f_assist'.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py       |  10 +-
 tools/perf/pmu-events/intel_metrics.py     | 259 ++++++++++-----------
 tools/perf/pmu-events/jevents.py           |  77 +++---
 tools/perf/pmu-events/make_legacy_cache.py |  34 +--
 tools/perf/pmu-events/metric.py            |  58 +++--
 5 files changed, 210 insertions(+), 228 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index dccfcacaf148..cf8b68954737 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -70,7 +70,6 @@ def AmdBr():
         ])
 
     def Conditional() -> Optional[MetricGroup]:
-        global _zen_model
         br = Event("ex_ret_brn_cond", "ex_ret_cond")
         br_r = d_ratio(br, interval_sec)
         ins_r = d_ratio(ins, br)
@@ -156,11 +155,10 @@ def AmdCtxSw() -> MetricGroup:
 
 
 def AmdDtlb() -> Optional[MetricGroup]:
-    global _zen_model
     if _zen_model >= 4:
         return None
 
-    d_dat = Event("ls_dc_accesses") if _zen_model <= 3 else None
+    d_dat = Event("ls_dc_accesses")
     d_h4k = Event("ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit")
     d_hcoal = Event(
         "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit") if _zen_model >= 2 else 0
@@ -173,8 +171,8 @@ def AmdDtlb() -> Optional[MetricGroup]:
     d_m2m = Event("ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss")
     d_m1g = Event("ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss")
 
-    d_w0 = Event("ls_tablewalker.dc_type0") if _zen_model <= 3 else None
-    d_w1 = Event("ls_tablewalker.dc_type1") if _zen_model <= 3 else None
+    d_w0 = Event("ls_tablewalker.dc_type0")
+    d_w1 = Event("ls_tablewalker.dc_type1")
     walks = d_w0 + d_w1
     walks_r = d_ratio(walks, interval_sec)
     ins_w = d_ratio(ins, walks)
@@ -266,7 +264,6 @@ def AmdDtlb() -> Optional[MetricGroup]:
 
 
 def AmdIotlb() -> Optional[MetricGroup]:
-    global _zen_model
     if _zen_model < 2:
         return None
 
@@ -322,7 +319,6 @@ def AmdIotlb() -> Optional[MetricGroup]:
 
 
 def AmdItlb():
-    global _zen_model
     l2h = Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
     l2m = Event("bp_l1_tlb_miss_l2_tlb_miss.all", "l2_itlb_misses",)
     l2r = l2h + l2m
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 9780bf978a41..497d8fd05e09 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -5,10 +5,10 @@ import json
 import math
 import os
 import re
-from typing import Optional
+from typing import Optional, Union
 from common_metrics import Cycles
-from metric import (d_ratio, has_event, max, aggr_nr, CheckPmu, Event,
-                    JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+from metric import (d_ratio, has_event, max, aggr_nr, CheckPmu, Constant, Event,
+                    Expression, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
                     Literal, LoadEvents, Metric, MetricConstraint, MetricGroup,
                     MetricRef, Select)
 
@@ -90,7 +90,7 @@ def Tsx() -> Optional[MetricGroup]:
         # sysfs version so that we can detect its presence at runtime.
         transaction_start = Event("RTM_RETIRED.START")
         transaction_start = Event(f'{pmu}/tx\\-start/')
-    except:
+    except ValueError:
         return None
 
     elision_start = None
@@ -100,7 +100,7 @@ def Tsx() -> Optional[MetricGroup]:
         # case. Again, prefer the sysfs encoding of the event.
         elision_start = Event("HLE_RETIRED.START")
         elision_start = Event(f'{pmu}/el\\-start/')
-    except:
+    except ValueError:
         pass
 
     return MetricGroup('transaction', [
@@ -139,7 +139,7 @@ def IntelBr():
         br_clr = None
         try:
             br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
-        except:
+        except ValueError:
             pass
 
         br_r = d_ratio(br_all, interval_sec)
@@ -171,7 +171,7 @@ def IntelBr():
             br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
                             "BR_MISP_RETIRED.TAKEN_JCC",
                             "BR_INST_RETIRED.MISPRED_TAKEN")
-        except:
+        except ValueError:
             pass
         br_r = d_ratio(br_all, interval_sec)
         ins_r = d_ratio(ins, br_all)
@@ -199,7 +199,7 @@ def IntelBr():
             br_m_cond = Event("BR_MISP_RETIRED.COND",
                               "BR_MISP_RETIRED.CONDITIONAL",
                               "BR_MISP_RETIRED.TAKEN_JCC")
-        except:
+        except ValueError:
             return None
 
         br_cond_nt = None
@@ -207,7 +207,7 @@ def IntelBr():
         try:
             br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
             br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
-        except:
+        except ValueError:
             pass
         br_r = d_ratio(br_cond, interval_sec)
         ins_r = d_ratio(ins, br_cond)
@@ -222,7 +222,7 @@ def IntelBr():
                    "Retired conditional branch instructions mispredicted as a "
                    "percentage of all conditional branches.", misp_r, "100%"),
         ]
-        if not br_m_cond_nt:
+        if not br_m_cond_nt or not br_cond_nt:
             return MetricGroup("lpm_br_cond", taken_metrics)
 
         br_r = d_ratio(br_cond_nt, interval_sec)
@@ -247,7 +247,7 @@ def IntelBr():
     def Far() -> Optional[MetricGroup]:
         try:
             br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
-        except:
+        except ValueError:
             return None
 
         br_r = d_ratio(br_far, interval_sec)
@@ -284,7 +284,7 @@ def IntelCtxSw() -> MetricGroup:
         ev = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
         metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
                               d_ratio(ev, cs), "loads/cs"))
-    except:
+    except ValueError:
         pass
 
     try:
@@ -292,14 +292,14 @@ def IntelCtxSw() -> MetricGroup:
                    "MEM_UOPS_RETIRED.ALL_STORES")
         metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
                               d_ratio(ev, cs), "stores/cs"))
-    except:
+    except ValueError:
         pass
 
     try:
         ev = Event("BR_INST_RETIRED.NEAR_TAKEN", "BR_INST_RETIRED.TAKEN_JCC")
         metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
                               d_ratio(ev, cs), "br_taken/cs"))
-    except:
+    except ValueError:
         pass
 
     try:
@@ -309,12 +309,12 @@ def IntelCtxSw() -> MetricGroup:
         try:
             l2_misses += Event("L2_RQSTS.HWPF_MISS",
                                "L2_RQSTS.L2_PF_MISS", "L2_RQSTS.PF_MISS")
-        except:
+        except ValueError:
             pass
 
         metrics.append(Metric("lpm_cs_l2_misses", "L2 misses per context switch",
                               d_ratio(l2_misses, cs), "l2_misses/cs"))
-    except:
+    except ValueError:
         pass
 
     return MetricGroup("lpm_cs", metrics,
@@ -327,7 +327,7 @@ def IntelFpu() -> Optional[MetricGroup]:
     try:
         s_64 = Event("FP_ARITH_INST_RETIRED.SCALAR_SINGLE",
                      "SIMD_INST_RETIRED.SCALAR_SINGLE")
-    except:
+    except ValueError:
         return None
     d_64 = Event("FP_ARITH_INST_RETIRED.SCALAR_DOUBLE",
                  "SIMD_INST_RETIRED.SCALAR_DOUBLE")
@@ -352,21 +352,21 @@ def IntelFpu() -> Optional[MetricGroup]:
         flop += 16 * s_512
         d_512 = Event("FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE")
         flop += 8 * d_512
-    except:
+    except ValueError:
         pass
 
     f_assist = Event("ASSISTS.FP", "FP_ASSIST.ANY", "FP_ASSIST.S")
-    if f_assist in [
+    nmi_constraint = MetricConstraint.GROUPED_EVENTS
+    if f_assist.name == "ASSISTS.FP":  # Icelake+
+        nmi_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
+    if f_assist.name in [
         "ASSISTS.FP",
         "FP_ASSIST.S",
     ]:
-        f_assist += "/cmask=1/"
+        f_assist.name += "/cmask=1/"
 
     flop_r = d_ratio(flop, interval_sec)
     flop_c = d_ratio(flop, cyc)
-    nmi_constraint = MetricConstraint.GROUPED_EVENTS
-    if f_assist.name == "ASSISTS.FP":  # Icelake+
-        nmi_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
 
     def FpuMetrics(group: str, fl: Optional[Event], mult: int, desc: str) -> Optional[MetricGroup]:
         if not fl:
@@ -421,16 +421,17 @@ def IntelFpu() -> Optional[MetricGroup]:
 def IntelIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
-    low = tsc - c0
+    low = max(tsc - c0, 0)
     inst_ret = Event("INST_RETIRED.ANY_P")
-    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
     core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
                         "CPU_CLK_UNHALTED.DISTRIBUTED",
                         "cycles")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+
     ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles)
            for x in range(0, 4)]
     ilp.append(d_ratio(inst_ret_c[4], core_cycles))
-    ilp0 = 1
+    ilp0: Expression = Constant(1)
     for x in ilp:
         ilp0 -= x
     return MetricGroup("lpm_ilp", [
@@ -465,7 +466,7 @@ def IntelIotlb() -> Optional[MetricGroup]:
         + Event("UNC_IIO_IOMMU0.1G_HITS")
     )
     total_miss = Event("UNC_IIO_IOMMU0.MISSES")
-  except:
+  except ValueError:
     return None
 
   miss_rate = d_ratio(total_miss, total_miss + total_hit)
@@ -508,7 +509,7 @@ def IntelIotlb() -> Optional[MetricGroup]:
             "100%",
         ),
     ]
-  except:
+  except ValueError:
     pass
 
   return MetricGroup(
@@ -519,59 +520,92 @@ def IntelIotlb() -> Optional[MetricGroup]:
 
 
 def IntelL2() -> Optional[MetricGroup]:
+    assert _args is not None
     try:
         DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
-    except:
+    except ValueError:
         return None
     try:
         DC_MISS = Event("L2_RQSTS.DEMAND_DATA_RD_MISS")
-        l2_dmnd_miss = DC_MISS
-        l2_dmnd_rd_all = DC_MISS + DC_HIT
-    except:
+        l2_dmnd_miss: Expression = DC_MISS
+        l2_dmnd_rd_all: Expression = DC_MISS + DC_HIT
+    except ValueError:
         DC_ALL = Event("L2_RQSTS.ALL_DEMAND_DATA_RD")
         l2_dmnd_miss = DC_ALL - DC_HIT
         l2_dmnd_rd_all = DC_ALL
     l2_dmnd_mrate = d_ratio(l2_dmnd_miss, interval_sec)
     l2_dmnd_rrate = d_ratio(l2_dmnd_rd_all, interval_sec)
 
-    DC_PFH = None
-    DC_PFM = None
-    l2_pf_all = None
-    l2_pf_mrate = None
-    l2_pf_rrate = None
+    l2_useless_rate = None
+    try:
+        DC_OUT_U = Event("L2_LINES_OUT.USELESS_HWPF")
+        l2_pf_useless = DC_OUT_U
+        l2_useless_rate = d_ratio(l2_pf_useless, interval_sec)
+    except ValueError:
+        pass
+
+    hwpf_group = None
     try:
         DC_PFH = Event("L2_RQSTS.PF_HIT")
         DC_PFM = Event("L2_RQSTS.PF_MISS")
         l2_pf_all = DC_PFH + DC_PFM
         l2_pf_mrate = d_ratio(DC_PFM, interval_sec)
         l2_pf_rrate = d_ratio(l2_pf_all, interval_sec)
-    except:
+        hwpf_group = MetricGroup("lpm_l2_hwpf", [
+            Metric("lpm_l2_hwpf_hits", "L2 cache hardware prefetcher hits",
+                   d_ratio(DC_PFH, l2_pf_all), "100%"),
+            Metric("lpm_l2_hwpf_misses", "L2 cache hardware prefetcher misses",
+                   d_ratio(DC_PFM, l2_pf_all), "100%"),
+            Metric("lpm_l2_hwpf_useless", "L2 cache hardware prefetcher useless prefetches per second",
+                   l2_useless_rate, "100%") if l2_useless_rate else None,
+            Metric("lpm_l2_hwpf_requests", "L2 cache hardware prefetcher requests per second",
+                   l2_pf_rrate, "100%"),
+            Metric("lpm_l2_hwpf_misses", "L2 cache hardware prefetcher misses per second",
+                   l2_pf_mrate, "100%"),
+        ])
+    except ValueError:
         pass
 
-    DC_RFOH = None
-    DC_RFOM = None
-    l2_rfo_all = None
-    l2_rfo_mrate = None
-    l2_rfo_rrate = None
+    rfo_group = None
     try:
         DC_RFOH = Event("L2_RQSTS.RFO_HIT")
         DC_RFOM = Event("L2_RQSTS.RFO_MISS")
         l2_rfo_all = DC_RFOH + DC_RFOM
         l2_rfo_mrate = d_ratio(DC_RFOM, interval_sec)
         l2_rfo_rrate = d_ratio(l2_rfo_all, interval_sec)
-    except:
+        rfo_group = MetricGroup("lpm_l2_rfo", [
+            Metric("lpm_l2_rfo_hits", "L2 cache request for ownership (RFO) hits",
+                   d_ratio(DC_RFOH, l2_rfo_all), "100%"),
+            Metric("lpm_l2_rfo_misses", "L2 cache request for ownership (RFO) misses",
+                   d_ratio(DC_RFOM, l2_rfo_all), "100%"),
+            Metric("lpm_l2_rfo_requests", "L2 cache request for ownership (RFO) requests per second",
+                   l2_rfo_rrate, "requests/s"),
+            Metric("lpm_l2_rfo_misses", "L2 cache request for ownership (RFO) misses per second",
+                   l2_rfo_mrate, "misses/s"),
+        ])
+    except ValueError:
         pass
 
     DC_CH = None
     try:
         DC_CH = Event("L2_RQSTS.CODE_RD_HIT")
-    except:
+    except ValueError:
         pass
     DC_CM = Event("L2_RQSTS.CODE_RD_MISS")
     DC_IN = Event("L2_LINES_IN.ALL")
-    DC_OUT_NS = None
-    DC_OUT_S = None
-    l2_lines_out = None
+
+    DC_WB_U = None
+    DC_WB_D = None
+    wbu = None
+    wbd = None
+    try:
+        DC_WB_U = Event("IDI_MISC.WB_UPGRADE")
+        DC_WB_D = Event("IDI_MISC.WB_DOWNGRADE")
+        wbu = d_ratio(DC_WB_U, interval_sec)
+        wbd = d_ratio(DC_WB_D, interval_sec)
+    except ValueError:
+        pass
+
     l2_out_rate = None
     wbn = None
     isd = None
@@ -583,43 +617,24 @@ def IntelL2() -> Optional[MetricGroup]:
                          "L2_LINES_OUT.DEMAND_CLEAN",
                          "L2_LINES_IN.I")
         if DC_OUT_S.name == "L2_LINES_OUT.SILENT" and (
-                args.model.startswith("skylake") or
-                args.model == "cascadelakex"):
+                _args.model.startswith("skylake") or
+                _args.model == "cascadelakex"):
             DC_OUT_S.name = "L2_LINES_OUT.SILENT/any/"
         # bring is back to per-CPU
         l2_s = Select(DC_OUT_S / 2, Literal("#smt_on"), DC_OUT_S)
         l2_ns = DC_OUT_NS
         l2_lines_out = l2_s + l2_ns
         l2_out_rate = d_ratio(l2_lines_out, interval_sec)
-        nlr = max(l2_ns - DC_WB_U - DC_WB_D, 0)
-        wbn = d_ratio(nlr, interval_sec)
+        if DC_WB_U and DC_WB_D:
+            nlr = max(l2_ns - DC_WB_U - DC_WB_D, 0)
+            wbn = d_ratio(nlr, interval_sec)
         isd = d_ratio(l2_s, interval_sec)
-    except:
-        pass
-    DC_OUT_U = None
-    l2_pf_useless = None
-    l2_useless_rate = None
-    try:
-        DC_OUT_U = Event("L2_LINES_OUT.USELESS_HWPF")
-        l2_pf_useless = DC_OUT_U
-        l2_useless_rate = d_ratio(l2_pf_useless, interval_sec)
-    except:
-        pass
-    DC_WB_U = None
-    DC_WB_D = None
-    wbu = None
-    wbd = None
-    try:
-        DC_WB_U = Event("IDI_MISC.WB_UPGRADE")
-        DC_WB_D = Event("IDI_MISC.WB_DOWNGRADE")
-        wbu = d_ratio(DC_WB_U, interval_sec)
-        wbd = d_ratio(DC_WB_D, interval_sec)
-    except:
+    except ValueError:
         pass
 
     l2_lines_in = DC_IN
     l2_code_all = (DC_CH + DC_CM) if DC_CH else None
-    l2_code_rate = d_ratio(l2_code_all, interval_sec) if DC_CH else None
+    l2_code_rate = d_ratio(l2_code_all, interval_sec) if l2_code_all else None
     l2_code_miss_rate = d_ratio(DC_CM, interval_sec)
     l2_in_rate = d_ratio(l2_lines_in, interval_sec)
 
@@ -640,35 +655,15 @@ def IntelL2() -> Optional[MetricGroup]:
             Metric("lpm_l2_rd_misses", "L2 cache data read misses per second",
                    l2_dmnd_mrate, "misses/s"),
         ]),
-        MetricGroup("lpm_l2_hwpf", [
-            Metric("lpm_l2_hwpf_hits", "L2 cache hardware prefetcher hits",
-                   d_ratio(DC_PFH, l2_pf_all), "100%"),
-            Metric("lpm_l2_hwpf_misses", "L2 cache hardware prefetcher misses",
-                   d_ratio(DC_PFM, l2_pf_all), "100%"),
-            Metric("lpm_l2_hwpf_useless", "L2 cache hardware prefetcher useless prefetches per second",
-                   l2_useless_rate, "100%") if l2_useless_rate else None,
-            Metric("lpm_l2_hwpf_requests", "L2 cache hardware prefetcher requests per second",
-                   l2_pf_rrate, "100%"),
-            Metric("lpm_l2_hwpf_misses", "L2 cache hardware prefetcher misses per second",
-                   l2_pf_mrate, "100%"),
-        ]) if DC_PFH else None,
-        MetricGroup("lpm_l2_rfo", [
-            Metric("lpm_l2_rfo_hits", "L2 cache request for ownership (RFO) hits",
-                   d_ratio(DC_RFOH, l2_rfo_all), "100%"),
-            Metric("lpm_l2_rfo_misses", "L2 cache request for ownership (RFO) misses",
-                   d_ratio(DC_RFOM, l2_rfo_all), "100%"),
-            Metric("lpm_l2_rfo_requests", "L2 cache request for ownership (RFO) requests per second",
-                   l2_rfo_rrate, "requests/s"),
-            Metric("lpm_l2_rfo_misses", "L2 cache request for ownership (RFO) misses per second",
-                   l2_rfo_mrate, "misses/s"),
-        ]) if DC_RFOH else None,
+        hwpf_group,
+        rfo_group,
         MetricGroup("lpm_l2_code", [
             Metric("lpm_l2_code_hits", "L2 cache code hits",
-                   d_ratio(DC_CH, l2_code_all), "100%") if DC_CH else None,
+                   d_ratio(DC_CH, l2_code_all), "100%") if DC_CH and l2_code_all else None,
             Metric("lpm_l2_code_misses", "L2 cache code misses",
-                   d_ratio(DC_CM, l2_code_all), "100%") if DC_CH else None,
+                   d_ratio(DC_CM, l2_code_all), "100%") if DC_CH and l2_code_all else None,
             Metric("lpm_l2_code_requests", "L2 cache code requests per second",
-                   l2_code_rate, "requests/s") if DC_CH else None,
+                   l2_code_rate, "requests/s") if l2_code_rate else None,
             Metric("lpm_l2_code_misses", "L2 cache code misses per second",
                    l2_code_miss_rate, "misses/s"),
         ]),
@@ -706,7 +701,7 @@ def IntelMissLat() -> Optional[MetricGroup]:
                                 "UNC_CHA_TOR_INSERTS.IA_MISS",
                                 "UNC_C_TOR_INSERTS.MISS_REMOTE_OPCODE",
                                 "UNC_C_TOR_INSERTS.NID_MISS_OPCODE")
-    except:
+    except ValueError:
         return None
 
     if (data_rd_loc_occ.name == "UNC_C_TOR_OCCUPANCY.MISS_LOCAL_OPCODE" or
@@ -752,8 +747,8 @@ def IntelMissLat() -> Optional[MetricGroup]:
 def IntelMlp() -> Optional[Metric]:
     try:
         l1d = Event("L1D_PEND_MISS.PENDING")
-        l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
-    except:
+        l1dc: Expression = Event("L1D_PEND_MISS.PENDING_CYCLES")
+    except ValueError:
         return None
 
     l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
@@ -764,8 +759,9 @@ def IntelMlp() -> Optional[Metric]:
 
 
 def IntelPorts() -> Optional[MetricGroup]:
-    pipeline_events = json.load(
-        open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
+    assert _args is not None
+    with open(f"{_args.events_path}/x86/{_args.model}/pipeline.json", encoding="utf-8") as f:
+        pipeline_events = json.load(f)
 
     core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
                         "CPU_CLK_UNHALTED.DISTRIBUTED",
@@ -777,11 +773,10 @@ def IntelPorts() -> Optional[MetricGroup]:
     for x in pipeline_events:
         if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
             name = x["EventName"]
-            port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
-            if name.endswith("_CORE"):
-                cyc = core_cycles
-            else:
-                cyc = smt_cycles
+            match = re.search(r"(PORT_[0-9].*)", name)
+            assert match is not None
+            port = match.group(0).lower()
+            cyc: Expression = core_cycles if name.endswith("_CORE") else smt_cycles
             metrics.append(Metric(f"lpm_{port}", f"{port} utilization (higher is better)",
                                   d_ratio(Event(name), cyc), "100%"))
     if len(metrics) == 0:
@@ -800,7 +795,7 @@ def IntelSwpf() -> Optional[MetricGroup]:
         s_t0 = Event("SW_PREFETCH_ACCESS.T0")
         s_t1 = Event("SW_PREFETCH_ACCESS.T1_T2")
         s_w = Event("SW_PREFETCH_ACCESS.PREFETCHW")
-    except:
+    except ValueError:
         return None
 
     all_sw = s_nta + s_t0 + s_t1 + s_w
@@ -857,6 +852,7 @@ def IntelSwpf() -> Optional[MetricGroup]:
 
 
 def IntelLdSt() -> Optional[MetricGroup]:
+    assert _args is not None
     if _args.model in [
         "bonnell",
         "nehalemep",
@@ -882,12 +878,12 @@ def IntelLdSt() -> Optional[MetricGroup]:
     LDST_PRE = None
     try:
         LDST_PRE = Event("LOAD_HIT_PREFETCH.SWPF", "LOAD_HIT_PRE.SW_PF")
-    except:
+    except ValueError:
         pass
     LDST_AT = None
     try:
         LDST_AT = Event("MEM_INST_RETIRED.LOCK_LOADS")
-    except:
+    except ValueError:
         pass
     cyc = LDST_CYC
 
@@ -945,8 +941,8 @@ def UncoreCState() -> Optional[MetricGroup]:
         pcu_ticks = Event("UNC_P_CLOCKTICKS")
         c0 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C0")
         c3 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C3")
-        c6 = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
-    except:
+        c6: Expression = Event("UNC_P_POWER_STATE_OCCUPANCY.CORES_C6")
+    except ValueError:
         return None
 
     num_cores = Literal("#num_cores") / Literal("#num_packages")
@@ -981,13 +977,10 @@ def UncoreDir() -> Optional[MetricGroup]:
         cha_upd = Event("UNC_CHA_DIR_UPDATE.HA")
         # Turn the umask into a ANY rather than HA filter.
         cha_upd.name += "/umask=3,name=UNC_CHA_DIR_UPDATE.ANY/"
-    except:
+    except ValueError:
         return None
 
     m2m_total = m2m_hits + m2m_miss
-    upd = m2m_upd + cha_upd  # in cache lines
-    upd_r = upd / interval_sec
-    look_r = m2m_total / interval_sec
 
     scale = 64 / 1_000_000  # Cache lines to MB
     return MetricGroup("lpm_dir", [
@@ -1014,7 +1007,7 @@ def UncoreMem() -> Optional[MetricGroup]:
                         "UNC_H_REQUESTS.WRITES_LOCAL")
         rem_wrs = Event("UNC_CHA_REQUESTS.WRITES_REMOTE",
                         "UNC_H_REQUESTS.WRITES_REMOTE")
-    except:
+    except ValueError:
         return None
 
     scale = 64 / 1_000_000
@@ -1035,16 +1028,18 @@ def UncoreMem() -> Optional[MetricGroup]:
 
 
 def UncoreMemBw() -> Optional[MetricGroup]:
+    assert _args is not None
     mem_events = []
     try:
-        mem_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
-                                    f"/arch/x86/{args.model}/uncore-memory.json"))
-    except:
+        with open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                  f"/arch/x86/{_args.model}/uncore-memory.json", encoding="utf-8") as f:
+            mem_events = json.load(f)
+    except (OSError, ValueError):
         pass
 
-    ddr_rds = 0
-    ddr_wrs = 0
-    ddr_total = 0
+    ddr_rds: Union[int, Expression] = 0
+    ddr_wrs: Union[int, Expression] = 0
+    ddr_total: Union[int, Expression] = 0
     for x in mem_events:
         if "EventName" in x:
             name = x["EventName"]
@@ -1059,17 +1054,17 @@ def UncoreMemBw() -> Optional[MetricGroup]:
         try:
             ddr_rds = Event("UNC_M_CAS_COUNT.RD")
             ddr_wrs = Event("UNC_M_CAS_COUNT.WR")
-        except:
+        except ValueError:
             return None
 
     ddr_total = ddr_rds + ddr_wrs
 
-    pmm_rds = 0
-    pmm_wrs = 0
+    pmm_rds: Union[int, Expression] = 0
+    pmm_wrs: Union[int, Expression] = 0
     try:
         pmm_rds = Event("UNC_M_PMM_RPQ_INSERTS")
         pmm_wrs = Event("UNC_M_PMM_WPQ_INSERTS")
-    except:
+    except ValueError:
         pass
 
     pmm_total = pmm_rds + pmm_wrs
@@ -1101,7 +1096,7 @@ def UncoreMemSat() -> Optional[Metric]:
         sat = Event("UNC_CHA_DISTRESS_ASSERTED.VERT", "UNC_CHA_FAST_ASSERTED.VERT",
                     "UNC_C_FAST_ASSERTED", "UNC_CHA_DISTRESS_ASSERTED.DPT_ANY",
                     "UNC_CHA_DISTRESS_ASSERTED.DPT_NONLOCAL")
-    except:
+    except ValueError:
         return None
 
     desc = ("Mesh Bandwidth saturation (% CBOX cycles with FAST signal asserted, "
@@ -1116,11 +1111,9 @@ def UncoreUpiBw() -> Optional[MetricGroup]:
     try:
         upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
         upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
-    except:
+    except ValueError:
         return None
 
-    upi_total = upi_rds + upi_wrs
-
     # From "Uncore Performance Monitoring": When measuring the amount of
     # bandwidth consumed by transmission of the data (i.e. NOT including
     # the header), it should be .ALL_DATA / 9 * 64B.
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 860027bb71b2..e853a06cbade 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -3,7 +3,6 @@
 """Convert directories of JSON events to C code."""
 import argparse
 import csv
-from functools import lru_cache
 import json
 import metric
 import os
@@ -22,7 +21,7 @@ _metric_tables: list[str] = []
 # List of metric tables generated from "/sys" directories.
 _sys_metric_tables: list[str] = []
 # Mapping between sys event table names and sys metric table names.
-_sys_event_table_to_metric_table_mapping = {}
+_sys_event_table_to_metric_table_mapping: Dict[str, str] = {}
 # Map from an event name to an architecture standard
 # JsonEvent. Architecture standard events are in json files in the top
 # f'{_args.starting_dir}/{_args.arch}' directory.
@@ -38,7 +37,7 @@ _pending_metrics_tblname: Optional[str] = None
 # Global BigCString shared by all structures.
 _bcs = None
 # Map from the name of a metric group to a description of the group.
-_metricgroups = {}
+_metricgroups: Dict[str, str] = {}
 # Order specific JsonEvent attributes will be visited.
 _json_event_attributes = [
     # cmp_sevent related attributes.
@@ -124,17 +123,17 @@ class BigCString:
 
   def __init__(self):
     self.strings = set()
-    self.insert_number = 0;
+    self.insert_number = 0
     self.insert_point = {}
     self.metrics = set()
 
-  def add(self, s: str, metric: bool) -> None:
+  def add(self, s: str, is_metric: bool) -> None:
     """Called to add to the big string."""
     if s not in self.strings:
       self.strings.add(s)
       self.insert_point[s] = self.insert_number
       self.insert_number += 1
-      if metric:
+      if is_metric:
         self.metrics.add(s)
 
   def compute(self) -> None:
@@ -313,7 +312,7 @@ class JsonEvent:
           return int(val, 16) == 0
         else:
           return int(val) == 0
-      except:
+      except ValueError:
         return False
 
     def canonicalize_value(val: str) -> str:
@@ -321,7 +320,7 @@ class JsonEvent:
         if val.startswith('0x'):
           return llx(int(val, 16))
         return str(int(val))
-      except:
+      except ValueError:
         return val
 
     eventcode = 0
@@ -436,15 +435,15 @@ class JsonEvent:
         s += f'\t{attr} = {value},\n'
     return s + '}'
 
-  def build_c_string(self, metric: bool) -> str:
+  def build_c_string(self, is_metric: bool) -> str:
     s = ''
-    for attr in _json_metric_attributes if metric else _json_event_attributes:
+    for attr in _json_metric_attributes if is_metric else _json_event_attributes:
       x = getattr(self, attr)
-      if metric and x and attr == 'metric_expr':
+      if is_metric and x and attr == 'metric_expr':
         # Convert parsed metric expressions into a string. Slashes
         # must be doubled in the file.
         x = x.ToPerfJson().replace('\\', '\\\\')
-      if metric and x and attr == 'metric_threshold':
+      if is_metric and x and attr == 'metric_threshold':
         x = x.replace('\\', '\\\\')
       if attr in _json_enum_attributes:
         s += x if x else '0'
@@ -452,24 +451,25 @@ class JsonEvent:
         s += f'{x}\\000' if x else '\\000'
     return s
 
-  def to_c_string(self, metric: bool) -> str:
+  def to_c_string(self, is_metric: bool) -> str:
     """Representation of the event as a C struct initializer."""
 
     def make_comment(s: str) -> str:
         s = s.replace('*/', r'\*\/')
         return f'\t/* {s} */\n' if len(s) < 80 else f'\t/* {s[0:80]}... */\n'
 
-    s = self.build_c_string(metric)
+    s = self.build_c_string(is_metric)
     assert _bcs is not None
     return f'{make_comment(s)}\t{{ { _bcs.offsets[s] } }},\n'
 
 
-_json_cache = {}
+_json_cache: Dict[Tuple[str, str], Sequence[JsonEvent]] = {}
 def _read_json_events_impl(path: str, topic: str) -> Sequence[JsonEvent]:
   """Read json events from the specified file."""
   try:
-    events = json.load(open(path), object_hook=JsonEvent)
-  except BaseException as err:
+    with open(path, encoding='utf-8') as f:
+      events = json.load(f, object_hook=JsonEvent)
+  except BaseException:
     print(f"Exception processing {path}")
     raise
   metrics: list[Tuple[str, str, metric.Expression]] = []
@@ -493,7 +493,6 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
 
 def preprocess_arch_std_files(archpath: str) -> None:
   """Read in all architecture standard events."""
-  global _arch_std_events
   for item in os.scandir(archpath):
     if not item.is_file() or not item.name.endswith('.json'):
       continue
@@ -533,13 +532,10 @@ def print_pending_events() -> None:
   if not _pending_events:
     return
 
-  global _pending_events_tblname
   assert _pending_events_tblname is not None
   if _pending_events_tblname.endswith('_sys'):
-    global _sys_event_tables
     _sys_event_tables.append(_pending_events_tblname)
   else:
-    global event_tables
     _event_tables.append(_pending_events_tblname)
 
   first = True
@@ -560,7 +556,7 @@ def print_pending_events() -> None:
       last_pmu = event.pmu
       pmus.add((event.pmu, pmu_name))
 
-    _args.output_file.write(event.to_c_string(metric=False))
+    _args.output_file.write(event.to_c_string(is_metric=False))
     last_name = event.name
   _pending_events = []
 
@@ -596,31 +592,28 @@ def print_pending_metrics() -> None:
   if not _pending_metrics:
     return
 
-  global _pending_metrics_tblname
   assert _pending_metrics_tblname is not None
   if _pending_metrics_tblname.endswith('_sys'):
-    global _sys_metric_tables
     _sys_metric_tables.append(_pending_metrics_tblname)
   else:
-    global metric_tables
     _metric_tables.append(_pending_metrics_tblname)
 
   first = True
   last_pmu = None
   pmus: Set[Tuple[str, str]] = set()
   assert _args is not None
-  for metric in sorted(_pending_metrics, key=metric_cmp_key):
-    if metric.pmu != last_pmu:
+  for m in sorted(_pending_metrics, key=metric_cmp_key):
+    if m.pmu != last_pmu:
       if not first:
         _args.output_file.write('};\n')
-      pmu_name = metric.pmu.replace(',', '_')
+      pmu_name = m.pmu.replace(',', '_')
       _args.output_file.write(
           f'static const struct compact_pmu_event {_pending_metrics_tblname}_{pmu_name}[] = {{\n')
       first = False
-      last_pmu = metric.pmu
-      pmus.add((metric.pmu, pmu_name))
+      last_pmu = m.pmu
+      pmus.add((m.pmu, pmu_name))
 
-    _args.output_file.write(metric.to_c_string(metric=True))
+    _args.output_file.write(m.to_c_string(is_metric=True))
   _pending_metrics = []
 
   _args.output_file.write(f"""
@@ -659,13 +652,14 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
   assert _bcs is not None
   if item.name.endswith('metricgroups.json'):
-    metricgroup_descriptions = json.load(open(item.path))
+    with open(item.path, encoding='utf-8') as f:
+      metricgroup_descriptions = json.load(f)
     for mgroup in metricgroup_descriptions:
       assert len(mgroup) > 1, parents
       description = f"{metricgroup_descriptions[mgroup]}\\000"
       mgroup = f"{mgroup}\\000"
-      _bcs.add(mgroup, metric=True)
-      _bcs.add(description, metric=True)
+      _bcs.add(mgroup, is_metric=True)
+      _bcs.add(description, is_metric=True)
       _metricgroups[mgroup] = description
     return
 
@@ -673,11 +667,12 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   for event in read_json_events(item.path, topic):
     pmu_name = f"{event.pmu}\\000"
     if event.name:
-      _bcs.add(pmu_name, metric=False)
-      _bcs.add(event.build_c_string(metric=False), metric=False)
+      _bcs.add(pmu_name, is_metric=False)
+      _bcs.add(event.build_c_string(is_metric=False), is_metric=False)
     if event.metric_name:
-      _bcs.add(pmu_name, metric=True)
-      _bcs.add(event.build_c_string(metric=True), metric=True)
+      pmu_name = f"{event.pmu}\\000"
+      _bcs.add(pmu_name, is_metric=True)
+      _bcs.add(event.build_c_string(is_metric=True), is_metric=True)
 
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   """Process a JSON file during the main walk."""
@@ -787,7 +782,7 @@ static const struct pmu_events_map pmu_events_map[] = {
 },
 """)
     else:
-      with open(f'{_args.starting_dir}/{arch}/mapfile.csv') as csvfile:
+      with open(f'{_args.starting_dir}/{arch}/mapfile.csv', encoding='utf-8') as csvfile:
         table = csv.reader(csvfile)
         first = True
         for row in table:
@@ -881,8 +876,8 @@ int pmu_metrics_table__iterate_tables(pmu_metrics_table_iter_t fn, void *data)
 
 
 def print_system_mapping_table() -> None:
-  assert _args is not None
   """C struct mapping table array for tables from /sys directories."""
+  assert _args is not None
   _args.output_file.write("""
 struct pmu_sys_events {
 \tconst char *name;
@@ -1484,7 +1479,7 @@ def main() -> None:
       except Exception as e:
         raise RuntimeError(f'Action failure for \'{item.name}\' in {parents}') from e
       if item.is_dir():
-        ftw(item.path, parents + [item.name], action)
+        ftw(item.path, list(parents) + [item.name], action)
 
   ap = argparse.ArgumentParser()
   ap.add_argument('arch', help='Architecture name like x86')
diff --git a/tools/perf/pmu-events/make_legacy_cache.py b/tools/perf/pmu-events/make_legacy_cache.py
index 28a1ff804f86..b224544f85f6 100755
--- a/tools/perf/pmu-events/make_legacy_cache.py
+++ b/tools/perf/pmu-events/make_legacy_cache.py
@@ -61,7 +61,7 @@ hw_cache_result = [
      "misses"),
 ]
 
-events = []
+events: list[dict[str, str]] = []
 def add_event(name: str,
               cache_id: int, cache_op: int, cache_result: int,
               desc: str,
@@ -87,10 +87,10 @@ def add_event(name: str,
         event["Deprecated"] = "1"
     events.append(event)
 
-for (cache_id, names, ops, cache_desc) in hw_cache_id:
-    for name in names:
-        add_event(name,
-                  cache_id,
+for (cid, names, ops, cache_desc) in hw_cache_id:
+    for cname in names:
+        add_event(cname,
+                  cid,
                   0, # PERF_COUNT_HW_CACHE_OP_READ
                   0, # PERF_COUNT_HW_CACHE_RESULT_ACCESS
                   f"{cache_desc} read accesses.",
@@ -100,27 +100,29 @@ for (cache_id, names, ops, cache_desc) in hw_cache_id:
             if op not in ops:
                 continue
             for op_name in op_names:
-                deprecated = (names[0] != name or op_names[1] != op_name)
-                add_event(f"{name}-{op_name}",
-                          cache_id,
+                is_deprecated = (names[0] != cname or op_names[1] != op_name)
+                add_event(f"{cname}-{op_name}",
+                          cid,
                           op,
                           0, # PERF_COUNT_HW_CACHE_RESULT_ACCESS
                           f"{cache_desc} {op_desc} accesses.",
-                          deprecated)
+                          is_deprecated)
 
                 for (result,  result_names, result_desc) in hw_cache_result:
                     for result_name in result_names:
-                        deprecated = ((names[0] != name or op_names[0] != op_name) or
-                                      (result == 0) or (result_names[0] != result_name))
-                        add_event(f"{name}-{op_name}-{result_name}",
-                                  cache_id, op, result,
+                        is_deprecated = ((names[0] != cname or op_names[0] != op_name) or
+                                         (result == 0) or (result_names[0] != result_name))
+                        add_event(f"{cname}-{op_name}-{result_name}",
+                                  cid,
+                                  op,
+                                  result,
                                   f"{cache_desc} {op_desc} {result_desc}.",
-                                  deprecated)
+                                  is_deprecated)
 
         for (result,  result_names, result_desc) in hw_cache_result:
             for result_name in result_names:
-                add_event(f"{name}-{result_name}",
-                          cache_id,
+                add_event(f"{cname}-{result_name}",
+                          cid,
                           0, # PERF_COUNT_HW_CACHE_OP_READ
                           result,
                           f"{cache_desc} read {result_desc}.",
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index ce025675898c..92144c5d8024 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -6,18 +6,16 @@ import json
 import os
 import re
 from enum import Enum
-from typing import Dict, List, Optional, Set, Tuple, Union
+from typing import Dict, List, Optional, Sequence, Set, Tuple, Union
 
-all_pmus = set()
-all_events = set()
-experimental_events = set()
-all_events_all_models = set()
+all_pmus: Set[str] = set()
+all_events: Set[str] = set()
+experimental_events: Set[str] = set()
+all_events_all_models: Set[str] = set()
 
 def LoadEvents(directory: str) -> None:
   """Populate a global set of all known events for the purpose of validating Event names"""
-  global all_pmus
   global all_events
-  global experimental_events
   global all_events_all_models
   all_events = {
       "context\\-switches",
@@ -30,29 +28,31 @@ def LoadEvents(directory: str) -> None:
     filename = os.fsdecode(file)
     if filename.endswith(".json"):
       try:
-        for x in json.load(open(f"{directory}/{filename}")):
-          if "Unit" in x:
-            all_pmus.add(x["Unit"])
-          if "EventName" in x:
-            all_events.add(x["EventName"])
-            if "Experimental" in x and x["Experimental"] == "1":
-              experimental_events.add(x["EventName"])
-          elif "ArchStdEvent" in x:
-            all_events.add(x["ArchStdEvent"])
+        with open(f"{directory}/{filename}", encoding="utf-8") as f:
+          for x in json.load(f):
+            if "Unit" in x:
+              all_pmus.add(x["Unit"])
+            if "EventName" in x:
+              all_events.add(x["EventName"])
+              if "Experimental" in x and x["Experimental"] == "1":
+                experimental_events.add(x["EventName"])
+            elif "ArchStdEvent" in x:
+              all_events.add(x["ArchStdEvent"])
       except json.decoder.JSONDecodeError:
         # The generated directory may be the same as the input, which
         # causes partial json files. Ignore errors.
         pass
   all_events_all_models = all_events.copy()
-  for root, dirs, files in os.walk(directory + ".."):
+  for root, _, files in os.walk(directory + ".."):
     for filename in files:
       if filename.endswith(".json"):
         try:
-          for x in json.load(open(f"{root}/{filename}")):
-            if "EventName" in x:
-              all_events_all_models.add(x["EventName"])
-            elif "ArchStdEvent" in x:
-              all_events_all_models.add(x["ArchStdEvent"])
+          with open(f"{root}/{filename}", encoding="utf-8") as f:
+            for x in json.load(f):
+              if "EventName" in x:
+                all_events_all_models.add(x["EventName"])
+              elif "ArchStdEvent" in x:
+                all_events_all_models.add(x["ArchStdEvent"])
         except json.decoder.JSONDecodeError:
           # The generated directory may be the same as the input, which
           # causes partial json files. Ignore errors.
@@ -65,7 +65,6 @@ def CheckPmu(name: str) -> bool:
 
 def CheckEvent(name: str) -> bool:
   """Check the event name exists in the set of all loaded events"""
-  global all_events
   if len(all_events) == 0:
     # No events loaded so assume any event is good.
     return True
@@ -81,7 +80,6 @@ def CheckEvent(name: str) -> bool:
 
 def CheckEveryEvent(*names: str) -> None:
   """Check all the events exist in at least one json file"""
-  global all_events_all_models
   if len(all_events_all_models) == 0:
     assert len(names) == 1, f"Cannot determine valid events in {names}"
     # No events loaded so assume any event is good.
@@ -96,11 +94,10 @@ def CheckEveryEvent(*names: str) -> None:
       if any([name.startswith(x) for x in ['amd', 'arm', 'cpu', 'msr', 'power', 'cha', 'uncore']]):
         continue
     if name not in all_events_all_models:
-      raise Exception(f"Is {name} a named json event?")
+      raise ValueError(f"Is {name} a named json event?")
 
 
 def IsExperimentalEvent(name: str) -> bool:
-  global experimental_events
   if ':' in name:
     # Remove trailing modifier.
     name = name[:name.find(':')]
@@ -447,8 +444,7 @@ class Event(Expression):
         error += " or " + name
       else:
         error = name
-    global all_events
-    raise Exception(f"No event {error} in:\n{all_events}")
+    raise ValueError(f"No event {error} in:\n{all_events}")
 
   def HasExperimentalEvents(self) -> bool:
     return IsExperimentalEvent(self.name)
@@ -655,7 +651,7 @@ class Metric:
 
     return result
 
-  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+  def ToMetricGroupDescriptions(self, _root: bool = True) -> Dict[str, str]:
     return {}
 
 class MetricGroup:
@@ -667,7 +663,7 @@ class MetricGroup:
   """
 
   def __init__(self, name: str,
-               metric_list: List[Union[Optional[Metric], Optional['MetricGroup']]],
+               metric_list: Sequence[Union[Optional[Metric], Optional['MetricGroup']]],
                description: Optional[str] = None):
     self.name = name
     self.metric_list = []
@@ -696,7 +692,7 @@ class MetricGroup:
       result.append(x.ToPerfJson())
     return result
 
-  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+  def ToMetricGroupDescriptions(self, _root: bool = True) -> Dict[str, str]:
     result = {self.name: self.description} if self.description else {}
     for x in self.metric_list:
       result.update(x.ToMetricGroupDescriptions(False))
-- 
2.55.0.1082.g2b9226bbc0-goog

