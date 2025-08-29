Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78958242D72
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440708; cv=none; b=cfeCaKS6Kt9L7hBya4luh64bxCIrB6bABymzYyJSd+L5+e4Vy8WvMZXNZtgyEN7Xux6rqdf/s3OfGUIhSs+jr60SYJdkPKKXX/qGMn8Z7SBXFMOUB8TSaUs2CVuT9b/xyK0Iq/0t+mFB0JsYT+2CmbkvVS2ZyjLtxhwpwOijCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440708; c=relaxed/simple;
	bh=zfYwywDhmS19+ihI/5ySZ/K6DgzjXK/uqOpp9y8XCrQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=urwoTX6kw9o9hle+wAM5H9Y0FAi/iOI3wmusraqD8qaDPLYk3Dc+gPmDTRUFTNgmYpI6EqaR5fAzI5CDca2RCw+y6jqI31lx7XksFmonu57hWF7w9BBp/hMt3UZ02T13Nxiiqa7HGebx8ib8sCApLXXZqrn0PIzCo3ekg3yh/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6cvOE4V; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6cvOE4V"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e55665b05so1479620b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440706; x=1757045506; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhKeHAvUy0hnoIlAuEt/dp1Klyhju1nBf8M9CfS8ME0=;
        b=t6cvOE4VY7XkaqIGO8P0bSq+PMr9nOZc7VLUy7MMCTTsAPej3QpKM61a/c2tvF854T
         YY0YL5Hh1BSac3J0ooUiJg4FisQGBLuV4vOKZuZAdEwKAN7vkSQ6tH6ChdOja3m3LBcD
         CF3ENYUf29Jhu+6LZdGu0kHByPpFxcwtDINt7YrLeuX/MFmUEVZ3BeaDLv5haIO0Bjay
         XMHnb8Bofrrdi7Xm3EaGRc6Af2E3qP71k1SfgXeHUZE10+3PP9lpol4XQRcNlXSrZfxp
         hdYj1h6clqSDSe8jBSqD4T2OM/6vPrqHVOB4VuFKnZkOR64PDSWsh+tRsDqHttwB1TLB
         floA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440706; x=1757045506;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhKeHAvUy0hnoIlAuEt/dp1Klyhju1nBf8M9CfS8ME0=;
        b=LzyjAxkcyIaUhwZ0QELxP5u0HTQC5qr/Qo+7G2EqhyY5GPl00hzlJsr+CxWIl/pYYx
         Djo+luWEyp5ZuokF0kOb+k8spdsb3Z2r3XYNSNI5TuGQqXIWKK4HqxfBsB1MFXSNnL3L
         BetDZAJNtOb0pfdsfg0RG6t/QS1COa0ovP7Z5+xdSu8+nQO401QyG7+IXb7gvCBMbIOE
         lPW2SOYmPNINDjfPmh05Uf186gUR0uqjVqLW/5zKO+gxO1R2V5q2aUHx7oYbYxl7rf8i
         FQvU+0eT/oNlrMVhXg3OfGHczmab6DBy8kivX6vqEzo9bxV1iRbOfnc7WZr78ClnO6iG
         /A/w==
X-Forwarded-Encrypted: i=1; AJvYcCW0S9GU7Z3EDRPa8nQdxQLI5EMeSROeEWfyVS0PmK5r3bw/ntEB6eO/sgeUaAFs03oJxwrHR96niqbV1xofk0OU@vger.kernel.org
X-Gm-Message-State: AOJu0YyjA3NmP6suWp2zT4rPBU+CJSTMvWCsQWX1oOKDlLfPd+UuxLMC
	pAikwk5klB/7DLFnqm6o33KSVKDddrtoOMiSg1LoQjAHgkUiIvo3dKNFbOU370S9ZK3MzrR7T+y
	17gBcUugXFQ==
X-Google-Smtp-Source: AGHT+IEmlXJ0ceJYM48S+eToRHxpgYs5lELUmy1KTtYP3hiRwrvVoykzf2TNA73kX+gCQtzXj7UqdHnIIn31
X-Received: from pjx5.prod.google.com ([2002:a17:90b:5685:b0:31f:3227:1724])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7286:b0:243:ae10:2433
 with SMTP id adf61e73a8af0-243ae1026c0mr8637290637.40.1756440705784; Thu, 28
 Aug 2025 21:11:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:50 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-10-irogers@google.com>
Subject: [PATCH v5 09/22] perf jevents: Add ports metric group giving
 utilization on Intel
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

The ports metric group contains a metric for each port giving its
utilization as a ratio of cycles. The metrics are created by looking
for UOPS_DISPATCHED.PORT events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 33 ++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index cfeafb58e8b4..288903707bc8 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,13 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, MetricRef, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
 import os
+import re
 from typing import Optional
 
 # Global command line arguments.
@@ -261,6 +262,33 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelPorts() -> Optional[MetricGroup]:
+  pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
+
+  core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                      "CPU_CLK_UNHALTED.DISTRIBUTED",
+                      "cycles")
+  # Number of CPU cycles scaled for SMT.
+  smt_cycles = Select(core_cycles / 2, Literal("#smt_on"), core_cycles)
+
+  metrics = []
+  for x in pipeline_events:
+    if "EventName" in x and re.search("^UOPS_DISPATCHED.PORT", x["EventName"]):
+      name = x["EventName"]
+      port = re.search(r"(PORT_[0-9].*)", name).group(0).lower()
+      if name.endswith("_CORE"):
+        cyc = core_cycles
+      else:
+        cyc = smt_cycles
+      metrics.append(Metric(f"lpm_{port}", f"{port} utilization (higher is better)",
+                            d_ratio(Event(name), cyc), "100%"))
+  if len(metrics) == 0:
+    return None
+
+  return MetricGroup("lpm_ports", metrics, "functional unit (port) utilization -- "
+                     "fraction of cycles each port is utilized (higher is better)")
+
+
 def IntelSwpf() -> Optional[MetricGroup]:
   ins = Event("instructions")
   try:
@@ -353,6 +381,7 @@ def main() -> None:
       Smi(),
       Tsx(),
       IntelBr(),
+      IntelPorts(),
       IntelSwpf(),
   ])
 
-- 
2.51.0.318.gd7df087d1a-goog

