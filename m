Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F32472A8
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440711; cv=none; b=UHCWxR2v8dp0mfAkfQs+Am1RxDq7hRWS+LvBlaN1Vc0Bd0jTy4BRKoOwJcttGuGA5ldDB7uwgrw2qiV6qndyDhYnlavE0FEigHMFIXVxFXpPywMhwqgB9VplzZJwlipw81Fc9r50WZuc7Sj5LMxVcOVR9AkxcWjMReUFTq2sRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440711; c=relaxed/simple;
	bh=iQ0JxbwfKDxqvEgTX3uSAYFB+KqUzk+ISHbXFJ36mxU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YU9lhqpyTGnPaRy01A0BxRJdPKsVy9gQ7DGRXpIaZIN+Fy73KcVEiwKKUBFaH1h5okRnMTwfx5OFJyzxK6AoYLOnmwqfaTpA/UTlf5q1psCqLDMkTGbZ4OFz0XjFOppFkuOAAiAOTTDsSsUwvhNfPHyF4XtLqL+eYpDOQUMnJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiWGIvIz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiWGIvIz"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b47630f9aa7so1394708a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440709; x=1757045509; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7lU92ZApmkWPRDApvNzDuJBwqNr0PRLP3cl0lgj5yrM=;
        b=NiWGIvIzlpV4TD0r0clpp3qMgpETPHlDUkCtdmJBAcJS9s/fgXpXOx/i4s8MuHIwkc
         /RC6Ez4hSdgv1V1/lzKJJTGmcW19LbFssUGjLn7D8jRlOyWBtgu3xpyfD/ozsJRzJc5Y
         1e/KOcwilkQ/TNs8XVyZnsnOniPfJulQ6sH2Snf0W/PLtJWFWuGzyLnzslzZLsp+9c8S
         iWqakVkAeJbml0VIzeUaTyfSrqr/uUNfeQdQTdNBxOR5kYw3R6MBF+rooAuLEwNhdvMp
         VjGM676FKchNmyk4TxlWzNajYkGSJxKepcb7Vb8lqiM6q69eZS6OPL/1JVN2P3MXYmLk
         iGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440709; x=1757045509;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7lU92ZApmkWPRDApvNzDuJBwqNr0PRLP3cl0lgj5yrM=;
        b=EOS8/XOBre0VVi5kf3EgTc/y56SbJwnryaiyzajM95RBgG02vLzwEbBTk0j6GfrN4+
         lfjV3qDMcW8ALjRGwbwaM9Nk7iNTWxyrAkkBJrDHg9f5u4lhtaAPD3gz/DkolnPP0aob
         SlimsYtrhyPl7zz0bIL0Q5Gk70qe0y90fTzeDNcZWkDqlDSyNj9Xbemw2JZUgcxnVvqX
         bxAo+wkDNP3ZRXhvlZ8TPLttK4hdvz2CwLoi4J/OO3C4cNI+scFcInK79XW5e5R2Alem
         2CLuGeg9gEVCnLLGg14/VmIH1utdRksId3Sc2krQYjGhUJCPmwX4kAexmzjp/9rStQNg
         Uq7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQ5GUore5cpNo/yO9jYm+WLNf38ejH/4shUo0CWMGxpT7Ml6Zpt7yNK0Tw7i5FNKHyqwxnHOWPxeXGRk33/bTU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmp52WtuOrPKOKF17x74AYy35BDqeWNYDN3BeYQtuYnZuD0NrP
	/kTjmRTXBBJ5kpZ3XEUIzOsvn6jldt/4tEG3AK3yHFL6jDOK5SVun7qVl9Klgx6uDLX9pyzdLFr
	DprbwPgZIrw==
X-Google-Smtp-Source: AGHT+IFEdDkRRitZ8GEh7HxeyHdlak/t/w7h0SDQCKXO1VCeMBEVCX7vgWnKpqZrSQdfvYpWowv8d5mJsJ+k
X-Received: from plrs18.prod.google.com ([2002:a17:902:b192:b0:237:cedc:1467])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cc:b0:246:a543:199
 with SMTP id d9443c01a7336-246a54304demr302132845ad.54.1756440709309; Thu, 28
 Aug 2025 21:11:49 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:52 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-12-irogers@google.com>
Subject: [PATCH v5 11/22] perf jevents: Add load store breakdown metrics ldst
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
index 1bac424aca6a..03983107c5c0 100755
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
2.51.0.318.gd7df087d1a-goog

