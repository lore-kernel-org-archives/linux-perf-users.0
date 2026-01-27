Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69938367F36
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539571; cv=none; b=TXDYBJvYu7hB6ZpW1TFNRHPuO0Z/ENb+KyiLkgCD8AhUimmzeuVDppN32sVWNAdlY1K/EpXyBhws3Q2G+P0ED8K07u79+rBJxBQ54ETrOCqSzA0i8o9IPIKyCG1w0v2v5GO7ETCPYQCJ41aNgCNaNHmTFCFpvmVh0G0ThnaG5TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539571; c=relaxed/simple;
	bh=jxPbqZjiKeqXjVKXPNpmd0p+gzDjnPXntJAsQ5FCjdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=qJXfiGHK+c8Bbn7W/G52o6jHLiM1YcgAsIdRTQMiLPGvsbG+Mz5dqFebb25TjSI2r6eezLhSq1b0nhE4B2FVae8ElRyB0t47SnL/FkpThWiKhpJQqDw256ru11479nDwd7qFdDU7qFCxxqj7ZMKSAa6UlZSw9xLMMVB0ETW8jRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVuDQXTQ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVuDQXTQ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1248da4d2d6so4567227c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539569; x=1770144369; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fORtvInl785vwPPesserRrCS7Xt/2I1SnOVTrAyhACY=;
        b=sVuDQXTQRYC1r2YsgmVfokEQie5/rMlefWY/GO11YlORSyza/MyjwsUbJay8YubLZy
         bPhTrEZ3dwkhRRMpZWYtWSp+EfoPte0zw1f+SWHikMXXtqEY5tZkHwUfG3wf9mymFfF7
         uxIZSMtGwRChXxADi8QbvGO5sqOqygGxUQ51yqnkYi05ZEmdt1LaVzUDWT7uE5tN3hJc
         DZ/VgYigcQas99gtxfCWsthJpDe7v9alg8n9HcxRM+rvy210PZT+rtGrMq5oiBmaF6ko
         F1ha6pmTubxURxIB8j6Q4KFz+dE1moMBYizWqeUftryEa1vv8EU54zBteNgmFntK6fBE
         J4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539569; x=1770144369;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fORtvInl785vwPPesserRrCS7Xt/2I1SnOVTrAyhACY=;
        b=YQyairZj9Bori9wvtMMs1XWpM90XWB9CXgln0exrYzSVXHX8tY7r04i2RTZ9Zr6wQ0
         TbxswZi41QcDBW4LzXOljwQ649s5DWOxOVySfujNKC4/20bG6N81EOZ4P+YD6YYkZYu1
         FMTr2g60olWGEtx8Ijycuu6nfOhgg0t1Hg48gSX8LF3CX3CZuTuNk8ZGPCXx/VFegCUn
         gDfB93HsugvoHoncNma9G841ES1x62gR1rrY0lD+wpYt3/8y7318QEp+5yJ0+qCfZ0/P
         GN8ao0FHmcOpHVsVCW1muPtiNdySuzs268DMoMKqyibr2QZvuv9tPhWPXAeno4oBMyOv
         NNgw==
X-Forwarded-Encrypted: i=1; AJvYcCVjqncwxEZ8iMEfxYaJoT4VirTVk1haV5JitciUPUn+JqWm5i8TGWuXyJ8vXud6NxIkAOO9a5VFYaMbzWN05Lp7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5H8E7xQWT9FfFL2oeTsd75Mgh/Vh+k7DXf4VAgBBCesKZKp9
	zInk7SFFGBKFHwXGXx5oyEHgZo4k31KSHG472v0g5Xop+1FHb3VJJVJ6i62tX4NSMjIGBu1l1FJ
	g4GJDUKlP1A==
X-Received: from dlg33.prod.google.com ([2002:a05:7022:7a1:b0:11d:cf4c:62ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b99:b0:11b:a36d:a7f7
 with SMTP id a92af1059eb24-124a009996amr1475905c88.16.1769539568559; Tue, 27
 Jan 2026 10:46:08 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:53 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-23-irogers@google.com>
Subject: [PATCH v11 22/35] perf jevents: Add load store breakdown metrics ldst
 for Intel
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 87 +++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index d190d97f4aff..19a284b4c520 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -8,7 +8,7 @@ import re
 from typing import Optional
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
-                    Metric, MetricGroup, MetricRef, Select)
+                    Metric, MetricConstraint, MetricGroup, MetricRef, Select)
 
 # Global command line arguments.
 _args = None
@@ -525,6 +525,90 @@ def IntelSwpf() -> Optional[MetricGroup]:
     ], description="Software prefetch instruction breakdown")
 
 
+def IntelLdSt() -> Optional[MetricGroup]:
+    if _args.model in [
+        "bonnell",
+        "nehalemep",
+        "nehalemex",
+        "westmereep-dp",
+        "westmereep-sp",
+        "westmereex",
+    ]:
+        return None
+    LDST_LD = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    LDST_ST = Event("MEM_INST_RETIRED.ALL_STORES",
+                    "MEM_UOPS_RETIRED.ALL_STORES")
+    LDST_LDC1 = Event(f"{LDST_LD.name}/cmask=1/")
+    LDST_STC1 = Event(f"{LDST_ST.name}/cmask=1/")
+    LDST_LDC2 = Event(f"{LDST_LD.name}/cmask=2/")
+    LDST_STC2 = Event(f"{LDST_ST.name}/cmask=2/")
+    LDST_LDC3 = Event(f"{LDST_LD.name}/cmask=3/")
+    LDST_STC3 = Event(f"{LDST_ST.name}/cmask=3/")
+    ins = Event("instructions")
+    LDST_CYC = Event("CPU_CLK_UNHALTED.THREAD",
+                     "CPU_CLK_UNHALTED.CORE_P",
+                     "CPU_CLK_UNHALTED.THREAD_P")
+    LDST_PRE = None
+    try:
+        LDST_PRE = Event("LOAD_HIT_PREFETCH.SWPF", "LOAD_HIT_PRE.SW_PF")
+    except:
+        pass
+    LDST_AT = None
+    try:
+        LDST_AT = Event("MEM_INST_RETIRED.LOCK_LOADS")
+    except:
+        pass
+    cyc = LDST_CYC
+
+    ld_rate = d_ratio(LDST_LD, interval_sec)
+    st_rate = d_ratio(LDST_ST, interval_sec)
+    pf_rate = d_ratio(LDST_PRE, interval_sec) if LDST_PRE else None
+    at_rate = d_ratio(LDST_AT, interval_sec) if LDST_AT else None
+
+    ldst_ret_constraint = MetricConstraint.GROUPED_EVENTS
+    if LDST_LD.name == "MEM_UOPS_RETIRED.ALL_LOADS":
+        ldst_ret_constraint = MetricConstraint.NO_GROUP_EVENTS_NMI
+
+    return MetricGroup("lpm_ldst", [
+        MetricGroup("lpm_ldst_total", [
+            Metric("lpm_ldst_total_loads", "Load/store instructions total loads",
+                   ld_rate, "loads"),
+            Metric("lpm_ldst_total_stores", "Load/store instructions total stores",
+                   st_rate, "stores"),
+        ]),
+        MetricGroup("lpm_ldst_prcnt", [
+            Metric("lpm_ldst_prcnt_loads", "Percent of all instructions that are loads",
+                   d_ratio(LDST_LD, ins), "100%"),
+            Metric("lpm_ldst_prcnt_stores", "Percent of all instructions that are stores",
+                   d_ratio(LDST_ST, ins), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_ret_lds", [
+            Metric("lpm_ldst_ret_lds_1", "Retired loads in 1 cycle",
+                   d_ratio(max(LDST_LDC1 - LDST_LDC2, 0), cyc), "100%",
+                   constraint=ldst_ret_constraint),
+            Metric("lpm_ldst_ret_lds_2", "Retired loads in 2 cycles",
+                   d_ratio(max(LDST_LDC2 - LDST_LDC3, 0), cyc), "100%",
+                   constraint=ldst_ret_constraint),
+            Metric("lpm_ldst_ret_lds_3", "Retired loads in 3 or more cycles",
+                   d_ratio(LDST_LDC3, cyc), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_ret_sts", [
+            Metric("lpm_ldst_ret_sts_1", "Retired stores in 1 cycle",
+                   d_ratio(max(LDST_STC1 - LDST_STC2, 0), cyc), "100%",
+                   constraint=ldst_ret_constraint),
+            Metric("lpm_ldst_ret_sts_2", "Retired stores in 2 cycles",
+                   d_ratio(max(LDST_STC2 - LDST_STC3, 0), cyc), "100%",
+                   constraint=ldst_ret_constraint),
+            Metric("lpm_ldst_ret_sts_3", "Retired stores in 3 more cycles",
+                   d_ratio(LDST_STC3, cyc), "100%"),
+        ]),
+        Metric("lpm_ldst_ld_hit_swpf", "Load hit software prefetches per second",
+               pf_rate, "swpf/s") if pf_rate else None,
+        Metric("lpm_ldst_atomic_lds", "Atomic loads per second",
+               at_rate, "loads/s") if at_rate else None,
+    ], description="Breakdown of load/store instructions")
+
+
 def main() -> None:
     global _args
 
@@ -556,6 +640,7 @@ def main() -> None:
         Tsx(),
         IntelBr(),
         IntelL2(),
+        IntelLdSt(),
         IntelPorts(),
         IntelSwpf(),
     ])
-- 
2.52.0.457.g6b5491de43-goog

