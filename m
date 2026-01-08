Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE6331A77
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899531; cv=none; b=ZUP/1Azfv73T5Jzt5+9fv8aRPPWBVCxWf804OOpAeRec5/hS+KXw3hqV6euXVxeKpti8Ymct0Qlf6FOWzjiBvd2g2aTY1wgPAEnQhFcltS5oHBc4A4HIeSByW87dIvErq3rMtJBo4HDveRdRJF2REfqMdNLTKNJcrbhhah/qxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899531; c=relaxed/simple;
	bh=jxPbqZjiKeqXjVKXPNpmd0p+gzDjnPXntJAsQ5FCjdo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=I+ozegt4pMvTSD0AZhUwJk/KINCS9Y4iK/T/tHlnAijJHJ9JP91JiUCXGx8hW0dNsjqqZB+2dFuLvNljfqVWSBazCkUXklp+YuGBzVJzOS1BDb37puNchFqR0ognO2mVwXm/L8k3eLxsFBSKarUWRKVO/F6auOSI/AuiqHWvEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EUyGp8t7; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EUyGp8t7"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b04f8c5e84so3136383eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899528; x=1768504328; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fORtvInl785vwPPesserRrCS7Xt/2I1SnOVTrAyhACY=;
        b=EUyGp8t7XsBujsANSbVjJq90Wx77jmr+5SUre3IjLX7JOScsb3JEaSy3dWEltIu+pr
         61vjL8Q+AtlaO6rFMIyKeNzgrc2OL1iiRxymNo8kyolCPmKAuH7gQ29x2h4uifK1Mia+
         3ipR6Y5muryhXlClJsTu6A6a31RDd+o9h0fiLUYzHOcuMJDqRQcOvBzSGcVbzNlAY8Gy
         V1m9bfdntMA3i2ziOW0+i8pr5Zp58N6O2n2bOL8POhX1HrQeus9Kt4PWC57iW2FrH1JW
         vnMTi2X6AOWBxVUatKP0//+JjV4yA2DllH5I3pj6pxcJcsP4gRc3UdAFGwjLyVpLqxJL
         tC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899528; x=1768504328;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fORtvInl785vwPPesserRrCS7Xt/2I1SnOVTrAyhACY=;
        b=GwC/3AxOgO+D37PpU4erUEGrBf6g9iRYw9X295t/qhlUnstHLSluZlLaHPTDc6rdZu
         pqgHY7rU6VsgioB2fq3OnlvNR2jTN4ISmT/AeOt8oWWHD7eMfJAmkHGDretes5RCQewU
         KxsqxRF4s0MxGVd6+jfr2g5JzGoO8kQH/EkWeQAR/o0yj+CR6ayrqfZZA3UHIl2Goa0t
         T/oiGKgd8d/hwixLyajWvPjy20zgXcyNPpKzfOxhq6W3cd6wTAdV2vVHRIw9rEQNorhf
         Z5hE3JJPyOwL6Tk6D6TyPvhDw4A/XNf2jotFucbvLiZo6OK0ts66RYrJAtXpLxcVBCRW
         L5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWjtqeMfEMJA1p6yaioCpWuTZIA5lo9KK5pFRT9I2OBOKsBkxg35/5IDKYs10KIMiA90d81qXwaet+Au8vG4B7@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUWZ41PPNpDNY1PUgsDAkIOKHZpTNTGUBunPMoqL9Fs2Izb/D
	eWj6OI7E2hHCWNzWFlI1IG5WQI7VpfmAUSXQUtSq+Xgp5rwFdiGI7mbKjgN2oqvM2ZBp/YWDxHg
	zxfUq+kIhGw==
X-Google-Smtp-Source: AGHT+IHBRe+I469gsI8wG2MCYndkl11DNmiNwCcvYdIv+OZiEHSifKbRNNtDi8/xdu49fd+M+B13jfcsXSYz
X-Received: from dykj3.prod.google.com ([2002:a05:7300:7b83:b0:2b0:4cb3:1106])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:dd98:b0:2ae:4ffc:d84e
 with SMTP id 5a478bee46e88-2b17d31c886mr3664757eec.28.1767899527895; Thu, 08
 Jan 2026 11:12:07 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:52 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-23-irogers@google.com>
Subject: [PATCH v10 22/35] perf jevents: Add load store breakdown metrics ldst
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

