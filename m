Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D112320A3E
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004153; cv=none; b=VOLjL4xnsRwGkppyWG9GUdy7U+nB9wFzZlLZu5Lmg1FOam+gp1d+FYUPC+Qk8GWuyxQHEOgmz5XnhGIZ9c1r1B87a+EXpXOjpzNbpAqqEfSCDTEnZOoTSuQdYA0caeghE95CypxL47AcOMMa4BRoG0xpNMvms/E60DlRqziH5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004153; c=relaxed/simple;
	bh=EWVkfWqqYmbyjAo4nAJxatebtVSY1toHimrIScc33EE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kqOzTRXeGpu5ACIBfwicSBlv++NRyi6GETfzh7zMwGA1vMPWyqglLffDTsU2c+sSfdT6X3rC784ZeU0X1Igum4AyA2+Fvi0Gvt7wQqzbfkb9BsNAXo84+15BgVpMTakaygSXOjmnKHtcN+vuANIg8aB1F2JBNcdv6RSJoB5dIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SJda9TOZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SJda9TOZ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295fbc7d4abso3148015ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004151; x=1763608951; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrSg7omVnmpP0rBqjcVXTJz9l1QAuCL3y7FniiXAyiQ=;
        b=SJda9TOZx/ZxjWU6wGAENMlw492+cOBYcZvm9PNPyfhsqGeYtr6xUUzt4aBZfYIRHb
         084aY+bEabnH/2ZU5sz6u8lr0X677C7tAexh0ANgUu3Bovw1tpVyuwX90L/syL9vqPp8
         9rU7PPb53aLngNJ3z0X4E8EpwQLCDMe2Q2zC3JZxePFoe+0lXlN4Ze4upqPYzrDUpR0H
         YKz3QjLzdSGmIFpOsHL60Gw+VkURa44z7MDBpdPHChIorlCGa2azolZprEp15eK5fRAe
         SvOMvsfJeOfHz6IvIzK8tYCn8f8IJaGd2QSpc9RSD5cu8c5DL+znNAVaH9zhE5AgaNM7
         QBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004151; x=1763608951;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrSg7omVnmpP0rBqjcVXTJz9l1QAuCL3y7FniiXAyiQ=;
        b=fAIeEBrKMfZgSeO7LyCigYOtaa2WI616oWMNoNLW09JDjmm6svgqzEdCvnYbk5B2sI
         53RlqSqdCQwoXXe8bhmKyy//YjYUHc2E1NCl0h0zxBIlRy/zim0e/+uCntzWrx1ac8Lp
         JBGpZ7PYekYtRrsI7gYQIXWPpL2V8JnO9ifCLc5wif7NMQGfkedObs+LOU4mI/H5EelW
         UnlOG+RnnmJvoLb0ClRK7GsmZZ2fyBmP9cyIf8jWdlL1fJXfyoYgQywlPQ3Km7IVz9Lj
         4iV4LT/5tj15WsJ7ToB3WdZcciFF0nrQTBRb42ZjtUyD7cvxXGtNBJn6lkNsTR9oQl77
         8moQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfxg+Iz8wNitWL/wk8azNPY09Qmf1drZTGUqtZ7SJlbaOTe66NcdpmrOdtcRTRcT1RLvH2xTdSZvJ9t/CgyJsk@vger.kernel.org
X-Gm-Message-State: AOJu0YzAECacpPjOtSVAXPXECl6/TZLmQXAUjaTgZ5aMkbTitO7d0aUf
	5J4XW0eCbaX+LmrKXWplamVqlZsaLlUWHmqu99E+a7SzGiNNhnXy265W6rju7MweS7f1FIYQocr
	Mc7yV8FgKbw==
X-Google-Smtp-Source: AGHT+IGOxhLpT19n0pWCaBa8YeErZkfPs0LRwBwiEB80qpJZFDciKQrG45pU5mVxAVZQo34jnYygsgguea5q
X-Received: from dlbur6-n1.prod.google.com ([2002:a05:7022:ea46:10b0:11b:d67:8ccd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f711:b0:295:98a1:7ddb
 with SMTP id d9443c01a7336-2984edf345amr69415045ad.61.1763004150490; Wed, 12
 Nov 2025 19:22:30 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:39 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-52-irogers@google.com>
Subject: [PATCH v8 51/52] perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
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

Breakdown cycles to user, kernel and guest. Add a common_metrics.py
file for such metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build             |  2 +-
 tools/perf/pmu-events/amd_metrics.py    |  2 ++
 tools/perf/pmu-events/arm64_metrics.py  |  2 ++
 tools/perf/pmu-events/common_metrics.py | 19 +++++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py  |  2 ++
 5 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index f7d67d03d055..a3d7a04f0abf 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -44,7 +44,7 @@ $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
 
-GEN_METRIC_DEPS := pmu-events/metric.py
+GEN_METRIC_DEPS := pmu-events/metric.py pmu-events/common_metrics.py
 
 # Generate AMD Json
 ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index b2e3e2883022..5bc53fcf6448 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -4,6 +4,7 @@ import argparse
 import math
 import os
 from typing import Optional
+from common_metrics import Cycles
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
                     Metric, MetricGroup, Select)
@@ -694,6 +695,7 @@ def main() -> None:
         AmdSwpf(),
         AmdUopCache(),
         AmdUpc(),
+        Cycles(),
         Idle(),
         Rapl(),
         UncoreL3(),
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index 9678253e2e0e..ac518e7f1120 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -3,6 +3,7 @@
 import argparse
 import os
 from typing import Optional
+from common_metrics import Cycles
 from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
                     LoadEvents, Metric, MetricGroup)
 
@@ -173,6 +174,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         Arm64Topdown(),
+        Cycles(),
     ])
 
     if _args.metricgroups:
diff --git a/tools/perf/pmu-events/common_metrics.py b/tools/perf/pmu-events/common_metrics.py
new file mode 100644
index 000000000000..fcdfb9d3e648
--- /dev/null
+++ b/tools/perf/pmu-events/common_metrics.py
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (d_ratio, Event, Metric, MetricGroup)
+
+
+def Cycles() -> MetricGroup:
+    cyc_k = Event("cpu\\-cycles:kHh")  # exclude user and guest
+    cyc_g = Event("cpu\\-cycles:G")   # exclude host
+    cyc_u = Event("cpu\\-cycles:uH")  # exclude kernel, hypervisor and guest
+    cyc = cyc_k + cyc_g + cyc_u
+
+    return MetricGroup("lpm_cycles", [
+        Metric("lpm_cycles_total", "Total number of cycles", cyc, "cycles"),
+        Metric("lpm_cycles_user", "User cycles as a percentage of all cycles",
+               d_ratio(cyc_u, cyc), "100%"),
+        Metric("lpm_cycles_kernel", "Kernel cycles as a percentage of all cycles",
+               d_ratio(cyc_k, cyc), "100%"),
+        Metric("lpm_cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
+               d_ratio(cyc_g, cyc), "100%"),
+    ], description="cycles breakdown per privilege level (users, kernel, guest)")
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index d56bab7337df..52035433b505 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -6,6 +6,7 @@ import math
 import os
 import re
 from typing import Optional
+from common_metrics import Cycles
 from metric import (d_ratio, has_event, max, source_count, CheckPmu, Event,
                     JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
                     Literal, LoadEvents, Metric, MetricConstraint, MetricGroup,
@@ -1095,6 +1096,7 @@ def main() -> None:
     LoadEvents(directory)
 
     all_metrics = MetricGroup("", [
+        Cycles(),
         Idle(),
         Rapl(),
         Smi(),
-- 
2.51.2.1041.gc1ab5b90ca-goog

