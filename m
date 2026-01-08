Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925F330D27
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899526; cv=none; b=SOGGA55w7xX5iLQcj25PEw1tSGQjP4XDKO+H780RzqBlf7E8rg2MnsMCtvC83z3cgTr374u7CgAHNoKO6h0zt6BF+yLOAMprm5Vj0qVZthE/N4/wPnpc6aDrXWN/oe0NPIvverLwxQPM/qPAiltkjMWuuO4tNwlSCs3LRPYbCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899526; c=relaxed/simple;
	bh=G/uAvahxqJcRd5BleQ08IDyOIhEFgPbCXkArIUPFs8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jqaQJXrnopsmDH0n4TG70WthZGIBWTsqhVOdSneeKd4lttl7XNyd/qSm821xEBhuQodmwl6g0u0PwiQZr+BL+J/ZF9gWTr6coxmWAkLjV80hTEuiOh4c7tSjaIrBUvkmO9epPyyqqz89TpzLqj4qx0z3CtdAZJ7XU+ITegtJi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1feFSti; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1feFSti"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11b9786fb51so16879772c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899524; x=1768504324; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojqL+aHY7ws3pOSR/jykm3GApScz0VMEtLVUVjH0CII=;
        b=c1feFStiDRNcHLY07j2RG9iYkhWuR3TH7DuN/k2DU26skYKdGeDJLHf0LmmN+6NLZ4
         jyvkNh+DU7DEdE2GaTAE/n4jsEE/pVJlDl2jRB6tzL/gZop8j+eA4lVSt6lO6hTA9FJt
         5SaqSlFe/UMclHVS603pzo5CY9MLtX2rx27vU18dDtumCCC5tQ8QeccwLvGG0WjFo4ma
         DiIsNdKtxisrCI8D26tyE9x82aHcRsxDOIsl4prm0utB0VMEnPXxmfx+CUiqWNkcTHfb
         4Ynr32Z45gBfOYQp0zaQD14jWMdHJ0as5bNmBvMWreSOjvpAU7Tn8KCad5zXmZAeM8+x
         YMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899524; x=1768504324;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojqL+aHY7ws3pOSR/jykm3GApScz0VMEtLVUVjH0CII=;
        b=ZvCo1Wub6A+1j33bPZnvukfr1Hiu/jJtamva7Gl3M4k54xQ3UEt6xaJUYu2c69xLyD
         OBSZYUX91Cf3reEX9A8LtPOYAgCHNJmG/zBMMPsxIRr6QD/5KNavlAvQf9V2SE0cVGlB
         IwFn2koJcNeHSxkdc9Rocn0sjGrl1qXxvu4W8f6gGfVl1FbYMtXZ56Q/XDA4Ia151era
         8HPgRL3NNQ8eBwW2eDDKTb1ImPUaA4i5pdJe31wbcaDLC87NJ2crfa/draGdlRbGpk53
         S7MhldX9L6Yu8CLtReoeNNfwjO4XMNjhcUMv6qDyXYOSKF5YU/j+DBDbyDhjSDctY3fB
         WweQ==
X-Forwarded-Encrypted: i=1; AJvYcCWke1he6ZODobJb1Uq99vAujNyQs7tgBF2KLv0nMsi2gvvy1+DpyV/SS/Kg9/Eft3RYe4Y46Fxx0jMI9CgB9hkQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQbEnV2g1dDeLDcaqmSQgfqy3qFTbhfDDeaDrciaJkBHjGHEz
	TjZl8Bkt+3AAxMnzE4lRgSQEwFesXZxb5O4WZMHGCgsIL++wraKDcepEcjgBEkOA59Rj+dt450s
	hI5d4CpbJkg==
X-Google-Smtp-Source: AGHT+IGomg2BUUO7ZchHKJFVKs9B9ALyziFsaz4zSsSc7du5ZfNpdlJkL+TAHifGZjktDI9GF7xqdUI6IPbg
X-Received: from dlxx12.prod.google.com ([2002:a05:7022:408c:b0:119:49ca:6ba4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:609a:b0:119:e56b:958a
 with SMTP id a92af1059eb24-121f8ae5f51mr5270520c88.15.1767899524232; Thu, 08
 Jan 2026 11:12:04 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:50 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-21-irogers@google.com>
Subject: [PATCH v10 20/35] perf jevents: Add ports metric group giving
 utilization on Intel
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

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 35 ++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 919a058c343a..7fcc0a1c544d 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,14 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
+import json
 import math
 import os
+import re
 from typing import Optional
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, MetricRef, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, MetricRef, Select)
 
 # Global command line arguments.
 _args = None
@@ -261,6 +263,34 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelPorts() -> Optional[MetricGroup]:
+    pipeline_events = json.load(
+        open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
+
+    core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                        "CPU_CLK_UNHALTED.DISTRIBUTED",
+                        "cycles")
+    # Number of CPU cycles scaled for SMT.
+    smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
+
+    metrics = []
+    for x in pipeline_events:
+        if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
+            name = x["EventName"]
+            port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
+            if name.endswith("_CORE"):
+                cyc = core_cycles
+            else:
+                cyc = smt_cycles
+            metrics.append(Metric(f"lpm_{port}", f"{port} utilization (higher is better)",
+                                  d_ratio(Event(name), cyc), "100%"))
+    if len(metrics) == 0:
+        return None
+
+    return MetricGroup("lpm_ports", metrics, "functional unit (port) utilization -- "
+                       "fraction of cycles each port is utilized (higher is better)")
+
+
 def IntelSwpf() -> Optional[MetricGroup]:
     ins = Event("instructions")
     try:
@@ -356,6 +386,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelPorts(),
         IntelSwpf(),
     ])
 
-- 
2.52.0.457.g6b5491de43-goog

