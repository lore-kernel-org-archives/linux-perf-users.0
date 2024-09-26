Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B818455A
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373072; cv=none; b=M/6GDPmIGIDqDG+NYCwWoxvjHvu+EMlpHh2zlTvK+4/d5wUqG0lB2pAKHC01jX3iIH8/BBezKd5g/HMDN2QoyMNTqOSS60U9QIxo35gIwhVeMioqBpSopZEXtC6f0flMNiiL2Tlkhdwc8ggde0f1UitD+MeOZ4ayKXTvOad9UkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373072; c=relaxed/simple;
	bh=xiYlCcj55q/KTy38gNYIg9xqcm3mQWwU1zaCis09kco=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EA+rRgW7n7fOmaoe7R0lW/JZ+BAL8LntG/w3Fo072p8MBEmaz195DF5XBK0/2htionCx8KLx3mM8aB8N7M11C+lj9GJCZSr3PclmzF+qAFuEjxLAkyQChGxRXS3YSBZwPNeUn85cJ2hDbZrRH+UquEvx2gX4EaKEtZw/f8MT1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h40Wt5TT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h40Wt5TT"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2146737f2so23667147b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373069; x=1727977869; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYgybefDNqgi10ykyol6GXFWf2oN+4a+ozUSONYeQto=;
        b=h40Wt5TTvQUph1wWY5BFoMvvEMOanioQP6VKSoN6lrcVHDVmuelCHUg/to0bPyWCqv
         QE1tFgeQZxwfhCfCPj74dWkXUEvmGwKQmdxbfrJoN39AMZ9rFp0m9quhNe0YevYDvL5n
         ThjI3meFsadGLgzJ5XUphq8SvRfLalayWp+TALpZvTA+IFumVhErUlDifUiLLU2NDI14
         MYX1zwmFQ6OFBXKO2JDwZPDGstl4GWzO4uw8wRX645KsdNcOEhEog9+ZnlFj+7dG9LMk
         Q3DbDcv2HnUt0dzHZiP/p2p/R4sHGx2HVdUCJea9U4Hmp7FoBPYTbVAfvz3mCPFQuqeH
         VedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373069; x=1727977869;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYgybefDNqgi10ykyol6GXFWf2oN+4a+ozUSONYeQto=;
        b=WWwFFZtwSyWDmSc25JTlgHQ+fjmlLWCQELzN5BrEBLTUMx82kOI7VGBhn7K1Ux2GUf
         U3Hct/8pedvxtnvjz3v+bhsfP5xBuXLLW/36MMGXiAsOaDzPhMsvbUxJM92I6LhcjShF
         hEw7Omz6kKzzf6r1cJ/fjyopyCqg/gznct6khXKFpZWtayXEFnDYCdkAV7SmigQNKFlV
         e8C1RaEx5L64YjClFY3KzCuNY2GI2N8+ZQ2hsR3aTq/EYkY3Ae+NW2kkq8Do6v8vqY/p
         cJdtPC3CMfACQymdR6wT/OLeph3iufw+LlSa3HLFrGd5ZHEeieaT3cP7tmCR1hkIeLnY
         3KRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGhit6Fhsitu+42xl08FU1O30jt6k/c4VQsQymVs3RMMB+FwpxS5JaTRa+H0tPm704bknT3uPAR3cdxQNoo0Fw@vger.kernel.org
X-Gm-Message-State: AOJu0YwBeXfgnoRYIIAyipcEKUvB8H7kV0efvo1DAUyBdaVzdSFpVzXq
	BOyZ9WGRI5M2IpoM9bffbregChvcEtz7zp5NucACZBY/ErTGm6Xb6OSjaBenltOfUyk+JNyRx4g
	iaKceuw==
X-Google-Smtp-Source: AGHT+IHQ92aHOX0/N/oCEF9QBP095GGMFbhVR9c/HKIZodCC4REiJ40TGb7Xaeh61No0JuXwRBjIbb+ISZi8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:6902:1363:b0:e0b:fe07:1e22 with SMTP
 id 3f1490d57ef6-e2604b109cdmr224276.1.1727373069192; Thu, 26 Sep 2024
 10:51:09 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:24 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 11/22] perf jevents: Add load store breakdown metrics ldst
 for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 86 +++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 4ddc68006b10..d528b97e8822 100755
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
@@ -509,6 +509,89 @@ def IntelSwpf() -> Optional[MetricGroup]:
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
+  return MetricGroup("ldst", [
+      MetricGroup("ldst_total", [
+          Metric("ldst_total_loads", "Load/store instructions total loads",
+                 ld_rate, "loads"),
+          Metric("ldst_total_stores", "Load/store instructions total stores",
+                 st_rate, "stores"),
+      ]),
+      MetricGroup("ldst_prcnt", [
+          Metric("ldst_prcnt_loads", "Percent of all instructions that are loads",
+                 d_ratio(LDST_LD, ins), "100%"),
+          Metric("ldst_prcnt_stores", "Percent of all instructions that are stores",
+                 d_ratio(LDST_ST, ins), "100%"),
+      ]),
+      MetricGroup("ldst_ret_lds", [
+          Metric("ldst_ret_lds_1", "Retired loads in 1 cycle",
+                 d_ratio(max(LDST_LDC1 - LDST_LDC2, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_lds_2", "Retired loads in 2 cycles",
+                 d_ratio(max(LDST_LDC2 - LDST_LDC3, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_lds_3", "Retired loads in 3 or more cycles",
+                 d_ratio(LDST_LDC3, cyc), "100%"),
+      ]),
+      MetricGroup("ldst_ret_sts", [
+          Metric("ldst_ret_sts_1", "Retired stores in 1 cycle",
+                 d_ratio(max(LDST_STC1 - LDST_STC2, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_sts_2", "Retired stores in 2 cycles",
+                 d_ratio(max(LDST_STC2 - LDST_STC3, 0), cyc), "100%",
+                 constraint = ldst_ret_constraint),
+          Metric("ldst_ret_sts_3", "Retired stores in 3 more cycles",
+                 d_ratio(LDST_STC3, cyc), "100%"),
+      ]),
+      Metric("ldst_ld_hit_swpf", "Load hit software prefetches per second",
+             pf_rate, "swpf/s") if pf_rate else None,
+      Metric("ldst_atomic_lds", "Atomic loads per second",
+             at_rate, "loads/s") if at_rate else None,
+  ], description = "Breakdown of load/store instructions")
+
+
 def main() -> None:
   global _args
 
@@ -538,6 +621,7 @@ def main() -> None:
       Tsx(),
       IntelBr(),
       IntelL2(),
+      IntelLdSt(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.46.1.824.gd892dcdcdd-goog

