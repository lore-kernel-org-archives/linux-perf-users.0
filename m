Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526DA2FC875
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004128; cv=none; b=l9/c/niyPNXSSMU5erHDUvg7HG9hbIJvJLjn3y/bsRi+DLUCYeROdIUHuN6Q5qgfu3aloHvEluQLdjH0nHVwx7L4YoFs3EpO69CeVz05hIhUZK+xGe0kNtZvO0l2OgyA1tfZgQJMad5JNtNYAUQ0ImzA81SqVcIyMDhnCBbER2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004128; c=relaxed/simple;
	bh=6Puds7ukp7NK3eXiev3oj5BPu6JssTIFLo4kpaVMr2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=O8Eem4njyOIB0OJCmxVQxtD3BvarrtG4vGJTJ80tJREEawSxXUTFSVXczc9uLSDbtb2yoIU9Vxc1UwY/Pw14vbxcXaXSK3FCeqcEBKWlMo7QgelD9Qp3qvES+B+Lgt+q7jj3PJuLuKAGTLbaMJJg/gn+5spntCbJ5lFG11fzoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0Ppu6P3; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0Ppu6P3"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f3710070so9724835ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004127; x=1763608927; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dXC0+97vfEs1vawtkRlPyHUCH9ZiV+8D6lRhd7+mBOs=;
        b=R0Ppu6P3JazS8uwgFsHkyNU5Poy5Rcf/WoPfXIVYPJTntVS7vYeXMCQZI74DUaYpfk
         Q+S9HegGyFL9kUU0ueaI2eciLOmS+eqe6EkMgLtyhDqfhDV3FSUtFzkTN5F22/miC+iv
         q9JsAFnNE1dV2AOi8SfC0iPvcWFShtaJK7+FZ2fnazerzjGyJ+JzHiT4S/0K1suJhOAt
         fWsZWtRWAmulT1y/yn9+yPtH1kC8Hpcoq/kVIuLG5swwNNyo83OGEUpLgLJy7QywZyUZ
         /9U6xkJDWNTBDwM8Y8yuGJcwdBZdo0gZ6LT6Z4ybk/EmFqVAkzPBZyrHmlnHMx5DTqy5
         O+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004127; x=1763608927;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXC0+97vfEs1vawtkRlPyHUCH9ZiV+8D6lRhd7+mBOs=;
        b=SRZ9OTM++wkAYfeYJ0XSL967EzaBB5vfEH35Rf10p7WbUL8E7TMZ4uOOWrXXX49dIX
         NoITgj2BmuVHxAj9/0D+im9YleYUDChdX5noGC9/iHJvo95PHRiC+yY6ro3riJADOGSv
         H5qMai7q3hUimvsugG3+XukQICDjN256jvzIxQLdBcFvS3PBhcBwEu/8DBkrq0paKuyL
         YMajoml1+pCmDe6BYXlQcgE8nxa2idfhCS1lxt13fuhQop/PR8srk8AutXfsrVA1d9Lg
         BqV74GKP9kltd3v3aElrs0rXIHTbQLgNaquf7RkD7yfOvX28een5OmEZYN/I78HhU83I
         UEbw==
X-Forwarded-Encrypted: i=1; AJvYcCVPMj73l0UMf+kwZWYqist0mTQNA/QJLJPueyG3EaOu2oT70VmQL/26egtWB1ZkERLqlZ5AgFuxoXF2cZRnTioz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Wzwqt+PZjZUFbmAEbLJLatiEs6Zp2bejLTfUsPw09xFXS2IP
	2ZJF009iZn09WAAY8mYrK0oRxStEYJvKTjdRx8T9cpeahaMkAhHs3CWNdXbrkbpjHB1IXODqQtS
	nlusi/5dokA==
X-Google-Smtp-Source: AGHT+IFx5FJDjsRa1PHy05Szhd2jrGdl02Mx46WTdNqzXpCHzpTCvTW6IDoV/Z082690acNLCItgodJqSQZ3
X-Received: from dlbdx8.prod.google.com ([2002:a05:7022:e08:b0:119:49ca:6b92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d05:b0:295:8a21:1559
 with SMTP id d9443c01a7336-2984edc8d26mr70401905ad.35.1763004126773; Wed, 12
 Nov 2025 19:22:06 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:26 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-39-irogers@google.com>
Subject: [PATCH v8 38/52] perf jevents: Add load store breakdown metrics ldst
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
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

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
2.51.2.1041.gc1ab5b90ca-goog

