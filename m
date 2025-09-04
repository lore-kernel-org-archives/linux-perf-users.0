Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510A2749D9
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014909; cv=none; b=aTWMGrA1uGr10hfmlnLRy3fI45+Ei31v+WrtKFNl37T9K2uuCDJEW1FMrmOEsz/fDLvzpOb0tnBhPSGjv5zlz55Mxz8qEqyGNLI7r0uM7fNKFgBR3IbgFtAT+3NF+HVkrn5+Vo6XFbsYt+ZyZ5VXFgR/8Dh+ujlka7IJt3h+ds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014909; c=relaxed/simple;
	bh=8Qgz52f57UhF7KomPwilxplwWCb+TwVqL8lCDntWYII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KbZRRXUdTxmMbOZZP1k5inwbMdETDApcWBpwi174Epx5gv73HTSNxJu9ZbXhwH6uvVm9rP0+mrYlYy2aI8qzCZTzThVSwjhvbs+bY7QzZUWsGZgTfY+z2WyupNOFnSI0VZwK2GisgkwM7zoGAb7h+0cLl7VV8qTu58LjEr9a9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qD1UmyGS; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qD1UmyGS"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7725b4273acso2432592b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Sep 2025 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757014907; x=1757619707; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xclq2MGVC7rkfUK9h+4MV5IK6jborDnuJjtuAiVTYcE=;
        b=qD1UmyGSrpo2Kgsjfbkepqplwdzn+HQ1gBYQxYzFYxLA7qOF34+RXTRLGomLzGrpDG
         R7+bEBDN/8tnvvEtMPAllQGPl1XoBK2fJv0OVI+sGeQQ3vuH6l0gff5ykCzpUOdhjp65
         PykGWgJI+Tp4x86CBqWKQbSqML4AxfUcU0ZCZBLCl2Nwdd+vLlkvBo8z28awp/9c7UA2
         0ZqSI1pifMHFutkI8G2v1sfNxigj82xj769B0OW+Cok3kalbhnEuP9rvbNSLjz0RChWq
         /B+l5/wkz5valz3qbi3H3i3sQgKD4uzd9kjTNI8ol5ARdJ7Xfc8XbOeJuQs3AOPU5M8V
         njkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757014907; x=1757619707;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xclq2MGVC7rkfUK9h+4MV5IK6jborDnuJjtuAiVTYcE=;
        b=pQvvk9vl8XOT629Q9E+eTsExXFItRUzPKG6zjtdjf0OJleqAJ6+r3FfpVHLw1kKi26
         xT4Ksfg7bhzTmFT1uNjtUMfnZaTxnZODH4pNR63bVP1jAbEeQ/1Zayp3cFTo/xlKGNMW
         dilwoeIHKGxYqYRsUp7BG0rGsGZPq3aBQ3ea2x1uPb+rtuJT01H2MT+cM6zD6CcRI0AI
         SBW5MJiiv5GZXIo7oELxYt2obV30fSCVnskhkOXGzsA1S8ggAKIBr8+4kyPYWetcps91
         MDIBuIE1ly+cudbufxHIh/NcVv6zdC6A7N/VRNFfE8H3Ovu7whv4eADQrUsc47WkvrW8
         6WOg==
X-Forwarded-Encrypted: i=1; AJvYcCVZQtlpQkkfYwFLin4NOHggxL3kZZZMWwgkBjdSdI0O6xNSLLJ6XTvns9JWCk4b3gTTy6xS7CybEpLx4Zy+30QY@vger.kernel.org
X-Gm-Message-State: AOJu0YwTNqajpSshHEmWqopHqCj7+e9UAElUydrdqHqA2qWHiGb2Qx+3
	w/tHAwjPRPA+nuYr6LGHq3q1gFA8Q/OiGL0TFXN2+KtFK2+ZE/NoiuFEp2obBjEFGZLLMR7YP3M
	7hH8MdsKMvg==
X-Google-Smtp-Source: AGHT+IHChfCsheafXwGRPCoPayd4Q6g0+hElq5XOLUv4yZ1Ai+aMoCnYSeBLG05xgUy1ynLbwRzgZ7XGMreV
X-Received: from pfqy12.prod.google.com ([2002:aa7:9e0c:0:b0:771:fd7c:50e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2449:b0:24c:f8f:2b8e
 with SMTP id adf61e73a8af0-24c0f8f2c67mr4763633637.44.1757014907225; Thu, 04
 Sep 2025 12:41:47 -0700 (PDT)
Date: Thu,  4 Sep 2025 12:41:38 -0700
In-Reply-To: <20250904194139.1540230-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904194139.1540230-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250904194139.1540230-3-irogers@google.com>
Subject: [PATCH v7 2/3] perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
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
	Benjamin Gray <bgray@linux.ibm.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Breakdown cycles to user, kernel and guest. Add a common_metrics.py
file for such metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build             |  2 +-
 tools/perf/pmu-events/amd_metrics.py    |  3 +++
 tools/perf/pmu-events/arm64_metrics.py  |  2 ++
 tools/perf/pmu-events/common_metrics.py | 18 ++++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py  |  2 ++
 5 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 366cd720659a..b2c557ad9964 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -43,7 +43,7 @@ $(LEGACY_CACHE_JSON): $(LEGACY_CACHE_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(LEGACY_CACHE_PY) > $@
 
-GEN_METRIC_DEPS := pmu-events/metric.py
+GEN_METRIC_DEPS := pmu-events/metric.py pmu-events/common_metrics.py
 
 # Generate AMD Json
 ZENS = $(shell ls -d pmu-events/arch/x86/amdzen*)
diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index d971fbf40318..5dd6e7288d24 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -4,6 +4,7 @@ from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
                     Metric, MetricGroup, Select)
 import argparse
+from common_metrics import Cycles
 import json
 import math
 import os
@@ -594,6 +595,7 @@ def AmdUpc() -> Metric:
   return Metric("lpm_upc", "Micro-ops retired per core cycle (higher is better)",
                 upc, "uops/cycle")
 
+
 def Idle() -> Metric:
   cyc = Event("msr/mperf/")
   tsc = Event("msr/tsc/")
@@ -676,6 +678,7 @@ def main() -> None:
       AmdSwpf(),
       AmdUopCache(),
       AmdUpc(),
+      Cycles(),
       Idle(),
       Rapl(),
       UncoreL3(),
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index e8016dec1c87..4599cb5c52e7 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -3,6 +3,7 @@
 from metric import (d_ratio, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
                     LoadEvents, Metric, MetricGroup)
 import argparse
+from common_metrics import Cycles
 import json
 import os
 from typing import Optional
@@ -172,6 +173,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("",[
       Arm64Topdown(),
+      Cycles(),
   ])
 
   if _args.metricgroups:
diff --git a/tools/perf/pmu-events/common_metrics.py b/tools/perf/pmu-events/common_metrics.py
new file mode 100644
index 000000000000..4ae3b0687a8a
--- /dev/null
+++ b/tools/perf/pmu-events/common_metrics.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (d_ratio, Event, Metric, MetricGroup)
+
+def Cycles() -> MetricGroup:
+  cyc_k = Event("cpu\\-cycles:kHh") # exclude user and guest
+  cyc_g = Event("cpu\\-cycles:G")   # exclude host
+  cyc_u = Event("cpu\\-cycles:uH")  # exclude kernel, hypervisor and guest
+  cyc = cyc_k + cyc_g + cyc_u
+
+  return MetricGroup("lpm_cycles", [
+      Metric("lpm_cycles_total", "Total number of cycles", cyc, "cycles"),
+      Metric("lpm_cycles_user", "User cycles as a percentage of all cycles",
+             d_ratio(cyc_u, cyc), "100%"),
+      Metric("lpm_cycles_kernel", "Kernel cycles as a percentage of all cycles",
+             d_ratio(cyc_k, cyc), "100%"),
+      Metric("lpm_cycles_guest", "Hypervisor guest cycles as a percentage of all cycles",
+             d_ratio(cyc_g, cyc), "100%"),
+  ], description = "cycles breakdown per privilege level (users, kernel, guest)")
diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 36b6c4704522..463d9f056bf2 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -5,6 +5,7 @@ from metric import (d_ratio, has_event, max, source_count, CheckPmu, Event,
                     Literal, LoadEvents, Metric, MetricConstraint, MetricGroup,
                     MetricRef, Select)
 import argparse
+from common_metrics import Cycles
 import json
 import math
 import os
@@ -1069,6 +1070,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Cycles(),
       Idle(),
       Rapl(),
       Smi(),
-- 
2.51.0.355.g5224444f11-goog

