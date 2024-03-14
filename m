Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8D405FD
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710396000; cv=none; b=l9vo3RCHfVU0zSXAyFdSDhXlAeIxQiYLdo3sf5pOwXjPXIN/eLZzLPzorWS4X9attz7x7zIwo2Umb8SfNxX3W98hFaUt89vZ4qugeQ8Y65LuMgoNDc5Tz6RAAJ9V0XBdNyQCzqIqiZcGGSRs19iV0AkWv+spoJAkWZHgOWwV0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710396000; c=relaxed/simple;
	bh=xtWp/os77FuNv6nPjjXYL4rEIzSmfCuzd+IK8xkj2yE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JWsnJ2WP9OocumdRQcq7X2WIsrLWp/HodCTAB/LhHmA49tQQYU9MvcUdjRgd2LG6pnVKQh7YwW/3zr0IoQrUAdO2wX6TRiEiSREE6t4DzyJx7JjGm2pPqXAOoTNPG2F+C7x+deQTkAgY19p/D0ejuX0Pn682uSSqWwfk9h79npQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVJOyGMf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVJOyGMf"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fe434210so11146667b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395998; x=1711000798; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2fqg3EeqdVKSD6hHFpARrgrIQYOAIUvUSGX0zthwymQ=;
        b=tVJOyGMf8bD8yTeti1L+a0XeRJjll11lkbRs9h4xTfg76mNkdLCktnfRNP23i/6zeu
         IT7qDYDm0RP6FEgutf6m6/XtvtkGp2DjnW3p5NGAI0BtQHY7du2+NHpngZLKhQw56oJB
         +n+04bUS1SJTr/hLqCnyRRG6enGYTEFTG1Uh81OaxNvld4rP6KaBjdt9LqLuALoJQTTN
         tBKmHJgLAZ1Ea4zYh+39ALNGvdjz4tIz6LC2MRH7StDIgwt/Xe78l/bV1zbJezWy2lz1
         8YZessk789ac5io7gn3j3YDQJjEWprlUFE2ZrYFLfPI+Rd26qtn312hsS9FvZpau+UBu
         uIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395998; x=1711000798;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fqg3EeqdVKSD6hHFpARrgrIQYOAIUvUSGX0zthwymQ=;
        b=d+CVNRZBnarKBrLXy37IvvXoUv6hgftvkGYJ8wHziTinXiHwyqQjVY2kl5s6Fwap1u
         oHKoFE0FwlbfkkyFVQ3qdwndoQTJd0iLSe+VHWJHrEojRR5gytpQUS9BSmB+tXCtHWf+
         7nqftSRMDTQDwdc1Tscgx15gU7ZUQdfYP+dLiatVqbgmALzWVKGsa5Eao7NbvM+2zmxM
         UAeYTsC5F4C3+A1UbgPM3PlxJXFFdtAH0rQeNsFaHLknWsdDodJbMsmQaBDJukEGD3GI
         /w9duVkDboAL+FPv41Zaq6Igp8xrPhbxy38QARomT/b2CaQDAnYVDquf4AF+PONjTKqO
         dodg==
X-Forwarded-Encrypted: i=1; AJvYcCUaXxtA7NZLi9xx7+vIPGC/rW+NLMyMKK6jhA0kjLXcqU7YWHy6i+piznSqVziNjz6JVZ0sa8Mp+gYZYlo84ChKxJoTLBkvoGLA2j/X/rdsBQ==
X-Gm-Message-State: AOJu0Yz3NHJ++i98mJ8ox1SWnSayMVluThx47c0oqZyIRaeOo+b5rCRK
	GWrPdtZMPu12ogqO62t//UWmUN+KlSAYDurHQEwOhuZ0ZJDOCjjQwtGQWGoHoO8rbsQ+Tt0YGWi
	62vkQcQ==
X-Google-Smtp-Source: AGHT+IHUMcZuKn2Q0djcMQG4CWwtVgxjzUZW8HhN3F/IZn5XjFbhraj9iGU9PFaTm8wkVBScuQOWVBUsRENB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc6:44d4:bee0 with SMTP
 id w4-20020a056902100400b00dc644d4bee0mr27738ybt.7.1710395997689; Wed, 13 Mar
 2024 22:59:57 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:09 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 10/20] perf jevents: Add load store breakdown metrics ldst
 for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 86 +++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 9ef30e5d3e25..4ac419212b3d 100755
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
@@ -508,6 +508,89 @@ def IntelSwpf() -> Optional[MetricGroup]:
   ], description="Sofware prefetch instruction breakdown")
 
 
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
 
@@ -537,6 +620,7 @@ def main() -> None:
       Tsx(),
       IntelBr(),
       IntelL2(),
+      IntelLdSt(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.44.0.278.ge034bb2e1d-goog

