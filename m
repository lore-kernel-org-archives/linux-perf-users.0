Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF212D739F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698047; cv=none; b=emG89RKQMHGUmLhieT26NHXegB5HPwCnLDZ07xCcB5A89svgcbDl/V1ktA2qPfOPQ6AnW5Gb0im5cI22n5RyQvrUt82Z/XS4mJlPQQrdsvxn/RT59Aah94DALZ2gVGeTOLN7zY++xeaJE87VbzWSXxs7SnIt0KxCEuXil2+S9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698047; c=relaxed/simple;
	bh=MdildCZuHQi1N2sFW7TIzyHHrQRJl0MB7grRBCGObhQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nOIQ0wkpCqxbVr+H4oH2S4xnd9dCAER3TbE+1X8zU5Jna1TK3D8OG34s5t3GtJGFMaaYV/c4EAPncskVp1CsgcspDfQhQGd/snfh1kohgzS9e+QsCjvPxd12fb6pBHWfGKfOZ+U+pjdJMm/ouuJKbA70q7HK2CsoOnFsipOT1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAJ77Fn5; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAJ77Fn5"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bf222e5b54dso39839a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698045; x=1765302845; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GprBI0OyNPCgpyQHkdm+/+qtKOSxDhG3Yekl66gcRL8=;
        b=UAJ77Fn50HKk3g27O4KDvAiHAe2ktWWijSy5jiLiQvN3t1lySqddUnLLpnK9IfjSZn
         4QccsQCRaiXFPOp4KXfsxM7oudHwRmrqeQeGLBEZ6P/sSlLirmlfG5mfpZWsOuEPm1a/
         FkQ9GJhdfL+5pO4DkkpNqea8UO15Ln15TQpJ1Lfnls8UoQ2VN01l0ZOx00G7FDY09XND
         s9aTCLMqUmoI03G5WH31dCZiNZEjoZuAJ4SJADyAyJ7xXZrHGjrnK2lwtaG9N5hjs1va
         SxO7h6P1A+mPhStkWoH9oEOA0edBPcyDGNKA0kQGk+bxffDlF16LgwsBDhUmCKE+Z93W
         QnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698045; x=1765302845;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GprBI0OyNPCgpyQHkdm+/+qtKOSxDhG3Yekl66gcRL8=;
        b=re3xTh2b2Rwzw3uZSgN6eJjQCqJvcw96RzwK1lDwBcPCie7e96uYYhzr8eZu270Eat
         6W23tf69EgSMetWv+1JMtrxyaq5F6imB0lppjoHFy8i9tSnGipS/5QVjWNQr+PCvcAR9
         G8NtHyvlmtusYkVmOpgHSlLd+TjeV8LhMvoauEvp20HcYctaHOgIIsGczKsUO6XJEv9E
         JiNeDO6XbwFvGyigqF5Ck1V6pfeKKYtEYttpNlfzSJbzvrYDelDg7L2NL+sKeTRSEIot
         8i+vK1XKwFGLsGL6ICxtH1wc0p4uoDuh31uOotiUcAeD++Ygdysg7Pz9laU6J7Rir6YI
         FG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOyOotrNBpizsVEu826L8PwuoZYFX07atLPDk+N9hkLgIg09FYjQkxyMYsBzt5JJr/E8fKRP8sGKTeueHqFvzz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy895vAFEiCU5sb/LxBi7nSxrEJYwpSQBZpPZXNI/83LaxXcO0Y
	DuOUQOW/0ljPYYpnQJPhVHlBZM/MGAjGewFic/ouzjpzsFggl+hB3/kkf8ziPmHSJWKu2An6rwX
	GsFy2Y4PxpA==
X-Google-Smtp-Source: AGHT+IFQqxDux4d9d+UfYuF+LS8E/y91MF/mnEEf+Ve/0BeI7sPqmS7eEam9HtynDSrKXUmGkAJSLWJ7iG0K
X-Received: from pgbdp14.prod.google.com ([2002:a05:6a02:f0e:b0:bac:a20:5edf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a0:b0:35e:8b46:c116
 with SMTP id adf61e73a8af0-363e8c6fd2emr4284025637.4.1764698044611; Tue, 02
 Dec 2025 09:54:04 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:29 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-35-irogers@google.com>
Subject: [PATCH v9 34/48] perf jevents: Add load store breakdown metrics ldst
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
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

