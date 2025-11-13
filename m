Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838A31619E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004125; cv=none; b=WMe2KdtKWWx0KUx9ORVnHtTEVqYkRgUzkTq/hrKgmq1KOU/jhfpFDovqYkxfWW9axf6FMV5N/lvqOTZP/NsTnxksncU13cFdjsRKrFxMmqhDUEtwfa14UrLhiLiwye5fUXkoTK2qcoXx7usDJAVUXLw9LvJSMdb06l8pH+2zAkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004125; c=relaxed/simple;
	bh=ReOI/yw7wKiQdecqgoKq7L03iNCYJDFt1sIl3LZIdPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=S3XVmf2SIVgR+w/Zli1EIeX0MTvB4nwothAbIpfRBuQtaQQf9BY9QLBVfT2URYuKilxnsFxRlkWgLdfSN++XLwnsYZZhVUZxHFgIR4qpO0jfbvUySgpVU4Q+ILkJwafP+5ZVuO/5AbouDTuOTK5BiumVmIFRmkKHkpL+hif7RB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hrvfzhlX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrvfzhlX"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297dabf9fd0so4715875ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004123; x=1763608923; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDpei4kCaCeIleN5UbRvrQ+OXCtwgMX3eQqxpgwlAMM=;
        b=hrvfzhlXLnvSHoUqjvM4McJKhrpRqPKr5YVYE9xY17CGjmB/xahJ2s6oMjMa1gNZGM
         uBgd0ihQ8zigY+LdKDrqGz8qHn4f5JUX52EnU0cP4nBK+I/ng/74QKCayKF0clz9Njo0
         qK+A97feHHEF5EuerMR9dSb+QKVasCGUXE6VfB0OgNsqSyv47oeAie/wmABjHCI35W4+
         HVQOPzdOU0ydqMXPQNg80IcXCoGRf4S0wyUBCHH2HHCo5btAZvDOcdN6D2guAsa+GnWy
         Cdt+AsNs5SWJkILUCRvO4P2jFg7t5FPTSMfSGh94+b55X/asVSgB3FnUh1xHNAX9FmK7
         7IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004123; x=1763608923;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDpei4kCaCeIleN5UbRvrQ+OXCtwgMX3eQqxpgwlAMM=;
        b=lVt914mE7CCM5UiPdnQlLpyEtmKERoLG2JmvTap9dK5/YYKbFJVwCt6HKK/AS1TmwI
         mBwWERS4o5i97DmFkzp5NgjI+Rri6pGppAhT8JPLFdC1Y2H8FPXL2ayWO8cN0suCwTsJ
         OuEYVi4MS0UhwTJzH1WHxdLIwE4MkiDsEQ0agKPwvKah2B8SvlQyVuNOQLEMbFQiRmT5
         t2z80AQW+56EdI5OgRZ8W4ZHUl0m3ZV0cPseY9spLeStRUo5N5jfcydpQDLA/CWm9dEt
         dM/rJ86kJ9B73LJmAo3re5Wv9s9mITRkA3xSm9R9KdzldC/kZ+pNO+Wh/yV+KPXc58eT
         DURA==
X-Forwarded-Encrypted: i=1; AJvYcCV/3yxTHzqFFbaoP8ZgUO02pfgD1t2xY67ri/HXWCnHomFBeOvSgrFXvdJRUKLn1pP/uWlBcuFZMmeFTIbqegob@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wzq1i+pT9xXBSPJbDNIleBu+L9fYZed+FW0f0VDA8M2WkNuM
	I+fxX44+BGFMqpBw3aLckro/nEHduAwJliBVx4sEE1JN1FKRZsqjoeKgFA1ZyRz33vGHt1UCKIe
	ML665xfQfhQ==
X-Google-Smtp-Source: AGHT+IEcHxhuA5X7tAwArcHTSLd4uPktHr67wK87JmqzBFDGMyDOjNJyoGY6BxIloszi7vK/EhVrRowzrs9X
X-Received: from dlbcy1.prod.google.com ([2002:a05:7022:b81:b0:119:78ff:fe1a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a28:b0:298:485d:557d
 with SMTP id d9443c01a7336-2984edcaaaamr65279345ad.45.1763004123184; Wed, 12
 Nov 2025 19:22:03 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:24 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-37-irogers@google.com>
Subject: [PATCH v8 36/52] perf jevents: Add ports metric group giving
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
2.51.2.1041.gc1ab5b90ca-goog

