Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32B82DEA6F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698035; cv=none; b=dRz8LHa09gScd+Iwrpj4keGqHG/r8ZK0vbRXtozPrZlFObhH6WkD7SOo0u8rHD6IwxAQShr7jyNKU/BrK9KHx6MhT+m08qmBe11YlZvPzyYOznJdzCXmpI1qiIwY9s9rtsagXaTSGZlA2iX2U36OuMoNkZ+T/Q9KNnFw2PeMI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698035; c=relaxed/simple;
	bh=f/zAPLMgLEoZV5Qea+vBOLAPk45QdYaXzdW1d7eayBM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=J6Zm6zfk4fuMI0jCkuK+FjzjqmcRyZJCChowOLDU6/KVlyJP4dnTXVTSqv1ascZUtJ2j+5JcWAvHNzUC5qb4Zd/DELnPc7xHu6l5WufDuQFBEqBPMrlCMkvhR7TDVV0ymhuyLLUilKVXi/3LapbOd2k7tHFXZ5ulAKyd2HFzKQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/7voazM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/7voazM"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-be8c77ecc63so4805230a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698033; x=1765302833; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHpRFpym5+i6zLNza6g5W+ofHyML5n4SAWgymZ5csvA=;
        b=e/7voazMBRn+GNkiYpuZPw9aGWvzqbWHM/DnBxxt77zL/j16lCXpDPNMEPcIM8YY2n
         VOKTzmOXY9VPWVg08NBh366QY7uacXmGSljXDkwvA7LnlGa/gzEeTZFL0n/Gsv72BBI1
         SM9A/fpzFmlVl/y3k64d8fu+dGtkBbYYox0v+8UXmG7g5WofAqIgx12UW7ZYvbNb2+vt
         GepsRia++kdGlCLzafOYvaOy8hIwvNdWLXHmUzGwMw8wxRGC3SJKTS88AmRF9ZJvc6RV
         0AcLT8mHsL8V3ldhrs9Ly+sbrSWyzaHJYmnC8fOx8855mYtjjrYae0+HCApbS5bA2kuE
         GO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698033; x=1765302833;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHpRFpym5+i6zLNza6g5W+ofHyML5n4SAWgymZ5csvA=;
        b=oTMCMPFe+alygrU3DxmQ94PMRovEPoppDZes5h8BVz+EKgHgHXpr6d8n8YzQ+sT8bS
         rQW8p5s2WrqM5+Aa1SHb+BGCfdp7Gfzm/jBaJK93LEd5NjM0xbbtfnhKFvrs/gGI3vbm
         Vxq8fC0bhseM12bbw+KZSnrbzi0MRArdtt4Wos9Z4TltvneHI3WM6pZwQywXc8pmp84w
         7KZcuviwkoE2StcjmIZLXCkAK3jEuedLCA/gKU7ZeC9ltVpEbod4XxreOrzq92syNnNW
         RhIMdrktt34oYT/njv5xPO4VIoy8mBpLfcnxBkf0cvRV9oKKeewqtK/rtBYhm7cyKB7s
         w5Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWJblD6WQrhIOtx2IGVsaMvGh0KIEi/h+Q4AFMb3eIot9GPyAzm4x4IY9EQKXse2Cj3kqpa2fP7bcyU1fiJyIhE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbwzq3x8XCucnpouvelAw8XsqTu65V/CdILUsYEcjW4+VShojL
	3u+QSkWVQnEAHDe4hs24sVywwrdR2tEDRmlvyhGsXuUkEjHpEK1JTmxbyAupxf3DYz70fE7OGOF
	1zln2WTAjjg==
X-Google-Smtp-Source: AGHT+IEqAUTg+KXUlvohtFVJIF0Rt6q8c/u7JtQImlQYGxMu83U67D973qgRjEufUnMTwIPUrLipMkigq1So
X-Received: from dyboy20.prod.google.com ([2002:a05:7300:ed14:b0:2a4:4bd0:6ed8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8008:b0:2a4:3593:c7e3
 with SMTP id 5a478bee46e88-2ab8fb873e1mr160771eec.35.1764698032849; Tue, 02
 Dec 2025 09:53:52 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:27 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-33-irogers@google.com>
Subject: [PATCH v9 32/48] perf jevents: Add ports metric group giving
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

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

