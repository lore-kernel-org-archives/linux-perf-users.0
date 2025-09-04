Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D12690D9
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961241; cv=none; b=fMWNPeb+XWMImFZ3lEeFuU8pcmFjnPQMt/wECiOjL8+wUkxzd6VAM7z8cO6ex3g0TWd/SfeJ3yFT0YHmiMvPQqZSOVJi+AfZZ1dFmnq9aOcjJ3ycIBS2RSQE7ZFhGM5yENv3KUJw+niKeHb/hSATyM+3hoqRKoVQgVEPbnbBjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961241; c=relaxed/simple;
	bh=EE2z15ts/NqbyN6rtQ/GuVgF2ic+BRGEZfEG9IgdK0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HhEA2hQAPtMHa1pmP36FjDF/ISGQU4eA5Qn9lcKiNrrjzcR/5Mxje5Mn9FsT1vlKkYGUysph6+UQtbcqWM7gXIyrJ50dGb9NQPkyX4h3EPgH8rVb70VhLqIvEIrFR6naiwjU4XbOnYfNcoZrQOJ83OCy+TzwS0iOpX9OZETduE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTjILD/D; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTjILD/D"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24c99bd543aso9801945ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961239; x=1757566039; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tl1q00Wukbhdt0sUNZX/FIHb4T0EyXRhrnNhUM4NP2E=;
        b=iTjILD/DklhhrQjCOeGB7nVMgBc+LZaWdeiGr/pFmtFVEVbprtdx680XS7CSn2qTXG
         Rd9DMXtCMgHDTu4ZMj5I1NP/BfLuJuqDeEE1crXlOJCQm9VA/pM8fSqgnEraiLzOBBMF
         ffjD95/KwrlHY3gvQemfLF4Yp4wcOdCOpomkb5Zxx4YJmE9DfcgWUNRbZmmVjumJDNYp
         8ZcwAFwWw8kSpA/3Bg7uKNyJEwQ2y5z73eVGx6AW26XCgLNorF01xnMb5eqoo2ao7wb0
         lFNccqOTjKok8lRRnkQ/HVr5Gmw4biNR9HsHalFgsXRmfjDBDoy/CDgggy83KAC/YSjF
         n/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961239; x=1757566039;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tl1q00Wukbhdt0sUNZX/FIHb4T0EyXRhrnNhUM4NP2E=;
        b=OQL3xw6YqqDTzk4L0SOPK45ks4IznxQ27KB26vrNVk/EQfsQUWAEuabc5h4VXGY/XF
         NSSlA8ZqNbNc5ECj6xGweWeXsmaS7ppGt3o70vJbNHIvm20oDvhhMi1XBnke/2KnguFv
         Q4wyXVZszcWuXWxI7beNnRWBlJa3wERiPi5ecoYu/porufHVrHT5mxVx49wGqc0r0I9O
         NPVIVo49pvId0brOqt2Ir/18F1+KT8jPQlNOfEA1sdd00Qf740nWVXytFXKg8+6EDMFx
         dRkYjtVv4yeczIRm2BGeLDkGX8o2ArRlUlOdxPjGwSRLWzlAHkStCT5vHYI35pSmueJQ
         GIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn/iuzh9sYJStEwU8nqAODg0gxdvmKhJHTHFodGNUP/qDe5q8BHddhLl3W8Bm8XVdSkN9IuTkPiR7IvtvxfUNi@vger.kernel.org
X-Gm-Message-State: AOJu0YxDe7H+qu1jJKAT8pJv3cM9iqzhilgYC8Yvvt78BBcELuXx5Vz9
	TXJ3XoTJqTTxB0/7Gi2D1/erVjQffi6q5tTgB0REtGNJAZMESEWJAaiEIRb+ppJpuN4F+5uiagB
	A+Uyft6qmSA==
X-Google-Smtp-Source: AGHT+IHoS/tP8rMKrHLJT7dStJ5bpDC3epz4vkfMmgq5L2Tw4ODSuYSKv+PmSGpTBaEk2hlfPYjrm4OJlyAg
X-Received: from plhu3.prod.google.com ([2002:a17:903:1243:b0:24b:1657:c088])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef11:b0:248:c8eb:9ae4
 with SMTP id d9443c01a7336-24944b19dcamr220749805ad.33.1756961238438; Wed, 03
 Sep 2025 21:47:18 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:42 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-12-irogers@google.com>
Subject: [PATCH v6 11/22] perf jevents: Add load store breakdown metrics ldst
 for Intel
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
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 86 +++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index c3677807136b..040dbca0a74e 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
-                    Metric, MetricGroup, MetricRef, Select)
+                    Metric, MetricConstraint, MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
@@ -522,6 +522,89 @@ def IntelSwpf() -> Optional[MetricGroup]:
   ], description="Software prefetch instruction breakdown")
 
 
+def IntelLdSt() -> Optional[MetricGroup]:
+  if _args.model in [
+      "bonnell",
+      "nehalemep",
+      "nehalemex",
+      "westmereep-dp",
+      "westmereep-sp",
+      "westmereex",
+  ]:
+    return None
+  LDST_LD = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+  LDST_ST = Event("MEM_INST_RETIRED.ALL_STORES", "MEM_UOPS_RETIRED.ALL_STORES")
+  LDST_LDC1 = Event(f"{LDST_LD.name}/cmask=1/")
+  LDST_STC1 = Event(f"{LDST_ST.name}/cmask=1/")
+  LDST_LDC2 = Event(f"{LDST_LD.name}/cmask=2/")
+  LDST_STC2 = Event(f"{LDST_ST.name}/cmask=2/")
+  LDST_LDC3 = Event(f"{LDST_LD.name}/cmask=3/")
+  LDST_STC3 = Event(f"{LDST_ST.name}/cmask=3/")
+  ins = Event("instructions")
+  LDST_CYC = Event("CPU_CLK_UNHALTED.THREAD",
+                   "CPU_CLK_UNHALTED.CORE_P",
+                   "CPU_CLK_UNHALTED.THREAD_P")
+  LDST_PRE = None
+  try:
+    LDST_PRE = Event("LOAD_HIT_PREFETCH.SWPF", "LOAD_HIT_PRE.SW_PF")
+  except:
+    pass
+  LDST_AT = None
+  try:
+    LDST_AT = Event("MEM_INST_RETIRED.LOCK_LOADS")
+  except:
+    pass
+  cyc  = LDST_CYC
+
+  ld_rate = d_ratio(LDST_LD, interval_sec)
+  st_rate = d_ratio(LDST_ST, interval_sec)
+  pf_rate = d_ratio(LDST_PRE, interval_sec) if LDST_PRE else None
+  at_rate = d_ratio(LDST_AT, interval_sec) if LDST_AT else None
+
+  ldst_ret_constraint = MetricConstraint.GROUPED_EVENTS
+  if LDST_LD.name == "MEM_UOPS_RETIRED.ALL_LOADS":
+    ldst_ret_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
+
+  return MetricGroup("lpm_ldst", [
+      MetricGroup("lpm_ldst_total", [
+          Metric("lpm_ldst_total_loads", "Load/store instructions total loads",
+                 ld_rate, "loads"),
+          Metric("lpm_ldst_total_stores", "Load/store instructions total stores",
+                 st_rate, "stores"),
+      ]),
+      MetricGroup("lpm_ldst_prcnt", [
+          Metric("lpm_ldst_prcnt_loads", "Percent of all instructions that are loads",
+                 d_ratio(LDST_LD, ins), "100%"),
+          Metric("lpm_ldst_prcnt_stores", "Percent of all instructions that are stores",
+                 d_ratio(LDST_ST, ins), "100%"),
+      ]),
+      MetricGroup("lpm_ldst_ret_lds", [
+          Metric("lpm_ldst_ret_lds_1", "Retired loads in 1 cycle",
+                 d_ratio(max(LDST_LDC1 - LDST_LDC2, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("lpm_ldst_ret_lds_2", "Retired loads in 2 cycles",
+                 d_ratio(max(LDST_LDC2 - LDST_LDC3, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("lpm_ldst_ret_lds_3", "Retired loads in 3 or more cycles",
+                 d_ratio(LDST_LDC3, cyc), "100%"),
+      ]),
+      MetricGroup("lpm_ldst_ret_sts", [
+          Metric("lpm_ldst_ret_sts_1", "Retired stores in 1 cycle",
+                 d_ratio(max(LDST_STC1 - LDST_STC2, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("lpm_ldst_ret_sts_2", "Retired stores in 2 cycles",
+                 d_ratio(max(LDST_STC2 - LDST_STC3, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("lpm_ldst_ret_sts_3", "Retired stores in 3 more cycles",
+                 d_ratio(LDST_STC3, cyc), "100%"),
+      ]),
+      Metric("lpm_ldst_ld_hit_swpf", "Load hit software prefetches per second",
+             pf_rate, "swpf/s") if pf_rate else None,
+      Metric("lpm_ldst_atomic_lds", "Atomic loads per second",
+             at_rate, "loads/s") if at_rate else None,
+  ], description = "Breakdown of load/store instructions")
+
+
 def main() -> None:
   global _args
 
@@ -551,6 +634,7 @@ def main() -> None:
       Tsx(),
       IntelBr(),
       IntelL2(),
+      IntelLdSt(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.51.0.338.gd7d06c2dae-goog

