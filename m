Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0121D58B
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445573; cv=none; b=I1mV9919gkyRX0Js4RFPPJ+wmSoAYuFo8ycKomG2F5zbCT1SlBHESFM6xp2CDAG2LzABJguhrJGNNaXGL2j0F0NyswvHTE14uYmFqv0ykEvcOdJHW3C2LYC2O0/yCMZAxgS81Xbcgo2rtM+ms8LuuMebr1JX534o9H9+uh6lFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445573; c=relaxed/simple;
	bh=it8j8dZw2hH3hfJIzrCp2+2K3wRWlp/OcQFxPc0uJwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Yz290sBXZAQvXFDjN9/wUtGxX08FDl/Y944KCvuEedATkRzjVywRAAVVdcbrLcKmIjHAhUfejRjlRHiJd0RpKbKdiIghTS61nza7tPsJhMfa3OH3MyAouEObFOEBL5l7H+nnjIcmUwXIAvyc47JA+x5Sq5zajKmQGM9jURTUv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZfCnwGA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZfCnwGA"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-248942647c5so29631605ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756445570; x=1757050370; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzE0wXAU7cnYqxcpRkXupDScvkyCa8YNaf8qlEhk8pI=;
        b=2ZfCnwGAY4B91DspBeY9wuLWRJECuYxUKzVWZDXD9L3nmaBWkuohAjRnf49I3j2U/q
         pKcxOqsuWnySgakEq6P8wd31ftxLU3uDAIqlSynDyGSePvOEpjcE4EGqoqnIWOduxZ1l
         6Fc+9hTntfDOaLWJAWh2UhjsscTpEqgD5qpmHxX4S/mAwxwo0hN6k7DTbXpPnUCy3KUu
         /o+uxosGaT5U2sSMi/7tWthQgX/K1Yd+PHD+sofKNWZ9pSK0A1vxlsy7yPfazu6gbJAH
         s+oNmEQ8ZcwsWFkbIFtWRNQtFl6gu1TbXqm++Zh3r1QZh46xz+14PJ0oJ6SVevEjtjVo
         ifhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756445570; x=1757050370;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzE0wXAU7cnYqxcpRkXupDScvkyCa8YNaf8qlEhk8pI=;
        b=DHuzSS3dH+2SBhMN5QFLX7lYaCzANoUeFpzq0seqKY3invGrq7hsvmJJLwyr6p57+Y
         /E1WM+1iSxl0KMK/l0zL/aIp2A+PQriATN44wjK6A7Hg6uUvTgpOCUgCxtYr6o2hlMe5
         36yDdzlBVhdbdfjQmCb5DkYUc2Jy4H8FO2ygA0A9wjsQnJQf5vfyFkENXE3IV30oCeld
         TH/LXMEGcY/o7wD8ENjYN65Puntz1jtkwvvVYvmElzD5qB0kU9uyPA3vwkraH0fKx8X4
         LZDIJD60MUJE+hDUsUI18K+Hg6gyGJuhvE+s72kf2+86T3CfRdY084c1utk8PCCb6aQm
         DIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtq0+zsYJqQnGvQuFJnTTjxJJSPwGwIvHY5tpwDPPatDdlXDjCg58YqFZ/F8avz5OQUtU7HJQSlF8zf5hP6rsj@vger.kernel.org
X-Gm-Message-State: AOJu0YytNTc5V7dgYyrRuAZNwIOYBeOgUEczobEJdSKHBfEhTVgR8JLv
	K6ybSovzW4PJOD4E+RfH+VuZG7ycb/FKQZKRJnjh0TQxrUUcQ372VjaphuzN/dWRyLpNDqdNYIv
	tHgV8Vs/uag==
X-Google-Smtp-Source: AGHT+IHyWL6/xZiKJHFYuVy4cbafKY/q5bdEKjNpIn0+uzqogCQZ4/QSuzN08I0TigrmzzWWT6/hXMsxRzw/
X-Received: from plez4.prod.google.com ([2002:a17:902:ccc4:b0:249:1128:5827])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da84:b0:246:80ef:8808
 with SMTP id d9443c01a7336-248753ada95mr153418385ad.3.1756445569918; Thu, 28
 Aug 2025 22:32:49 -0700 (PDT)
Date: Thu, 28 Aug 2025 22:32:34 -0700
In-Reply-To: <20250829053235.21994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829053235.21994-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829053235.21994-3-irogers@google.com>
Subject: [PATCH v5 2/3] perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
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
 tools/perf/pmu-events/metric.py         |  1 +
 6 files changed, 27 insertions(+), 1 deletion(-)
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
index d51f4c3fe0cb..2252894633b0 100755
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
index 067ebbad1adf..5e9b37693a8d 100755
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
index 000000000000..6a44e5756cbb
--- /dev/null
+++ b/tools/perf/pmu-events/common_metrics.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+from metric import (d_ratio, Event, Metric, MetricGroup)
+
+def Cycles() -> MetricGroup:
+  cyc_k = Event("cpu\-cycles:kHh") # exclude user and guest
+  cyc_g = Event("cpu\-cycles:G")   # exclude host
+  cyc_u = Event("cpu\-cycles:uH")  # exclude kernel, hypervisor and guest
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
index 7250e8c8eeba..eab69474e141 100755
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
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index b77485b47666..315350f3b6ed 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -23,6 +23,7 @@ def LoadEvents(directory: str) -> None:
       "duration_time",
       "instructions",
       "l2_itlb_misses",
+      "cpu\-cycles",
   }
   for file in os.listdir(os.fsencode(directory)):
     filename = os.fsdecode(file)
-- 
2.51.0.318.gd7df087d1a-goog

