Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF69367F40
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539567; cv=none; b=FLwlkmtvvNnRRkjqf7q4VWMxU3CEsUVjvFH4Xl/M21bQin5/WcZ0yeHQy7UYiyCh4NJM02OJ8lwUcV8E37QpQM5s4MpD+b26H7k9EULcnFJ/0VlBxHV12/W8xJDK6kMQWHuwnAiy1dmSE3gOEJp93ca4WcpD+VOmsRhEaUwdRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539567; c=relaxed/simple;
	bh=G/uAvahxqJcRd5BleQ08IDyOIhEFgPbCXkArIUPFs8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MRJWm4QamQbaWKrzxN5WmTga/wldVUL0UUYUr1b72G1JpfTHVujFiSXb0TmPp1GNdAR53NbyJKsbLXI2K7tMZPVBDDhKta0Cp/XpnIeZiiWcW/vmN/CTFXMq/WG7DC0eGijxbK5Gk4wWctdLx1IPYB6Q3MMtB/MjmEew14x5Mbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxyKjzvW; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxyKjzvW"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b715b26fc3so8096217eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539565; x=1770144365; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojqL+aHY7ws3pOSR/jykm3GApScz0VMEtLVUVjH0CII=;
        b=FxyKjzvWvevzn8Dy+YPVFyFWeyI6JQjbOCOdc9cEDjlvwbyrPcaxWJNjSUdOyc1Dvd
         GORKO1t31FC3LaX+SkFUMCnfRKr0iXnit3G0Sn4vddssruFhKRboQ7ylEI+L8eu5U8Xc
         4YeSB5cw6KDr8+AF/j24KWrQ0v1vP89CL55u/7kphIl1L4OV2hpOaA88wHIe0RKjjRcS
         1iL2fTtvlU9SILQD/1Rzaa9MEvkBOw5VWBrC69+ZhizHGdIadPFVdzy+dOHaUuxwym7t
         gLDDYiWT6be5tB1FEMrlLqPK7TUYVN8mQVAb81vfxRxpw2LFg/BRv4sy22n7CRbbvMt5
         9UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539565; x=1770144365;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojqL+aHY7ws3pOSR/jykm3GApScz0VMEtLVUVjH0CII=;
        b=I7azqAt17bz/koFz5HnDT15ZyKEzziRzZ/qzm4xaSSJNrN3zH7kiAvk20uvmnY1L2x
         le8DKA3R3/2lh1Uh5iAzY8aFMo5mnRFoSC9g4PFDQuyRRiYTkUKyiefu7sURpRN9oh0J
         PaWJ7ALdYdp5F+uk4HBHSD7m3/0WqIHZ7gDme4f9YTn6+cBagt/GwxRG13cLq7qKdwrk
         1ucUXqJ1Yngd8h1UZVi96hqmaOYb3vaJP/nPW7I4AZ+MuzeOXAzm7TPVi6RP/C1hoSZl
         MWx/e28YGyu7sUPLN47nQJwvOa9YXDAm5cQI6ImtbShjJl+SRYktzk47304/CPsw1nRG
         G68w==
X-Forwarded-Encrypted: i=1; AJvYcCUNYDOXKSo1NDZDC4yiP0B4mle9Igw6DZcpuqgk7D7+irsKTW/D1Tz5eNDpYdBYdYsKrKA4+Pa2F2loHlK4S3JB@vger.kernel.org
X-Gm-Message-State: AOJu0YyRiMjMhLlJ+1w0AXDuiC8faP9yE8IxYe1mhM1foyUwqA8Ey68T
	YAKZZxMJC4Nna3wfvFZdBBhG5R2j3Nk6yfQDEsZrCYZRLuVyiF3PK2wIvE3tD2t4ctVGwRfFLYS
	zqYhnoNyyLg==
X-Received: from dymh30.prod.google.com ([2002:a05:7300:1c1e:b0:2ab:9e42:f552])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:230b:b0:2b0:520c:df62
 with SMTP id 5a478bee46e88-2b78d9193bdmr1734981eec.19.1769539564966; Tue, 27
 Jan 2026 10:46:04 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:51 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-21-irogers@google.com>
Subject: [PATCH v11 20/35] perf jevents: Add ports metric group giving
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
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
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

