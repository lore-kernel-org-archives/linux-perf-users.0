Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E023D280
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961588; cv=none; b=crl9c7pZQp1g/WHfOwNgdrCZaEQEDhfSaWgb0pExO0ND9QF91pOl7/GlhcPHIAFtnQtQb3/SiMPhd4BAGcDWykN4yMRkMKjYiI/unbXn0OmodePkcNyR1jl0PMras0pHSuXyZ+LG3B3OU/ioeaFO2j+xf9z2Gln8tnaiIPpuPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961588; c=relaxed/simple;
	bh=DxqALzct7pjSC7q6i3UumoTchp1X2Vgr5qrDJZaBNHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cKVfe/6GEgcM9tKQgjqTOO61h5u2OgxAAO/n6AdPK4WmiPy0VjYZ2Ne3ojXoX7cufoq+p8zfNxG2zhYC/ijrthnz6hTlOAtc5JUlV4hfREjNGnA6N4j1WZLmb2VBnUBDfZbJyiK57efUWC/3OkMtDB+XjQW5TJJ8FBlQUMRGdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKjQVH6w; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKjQVH6w"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445803f0cfso9861965ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961586; x=1757566386; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6fcB2Hn+kdC3nY9KK6yt1lH6XCY5pViALcFk/7zZSc=;
        b=dKjQVH6wgmrxGkEPzq6P/LhliUoLbs564AnlFVBat1tdwy0k9u3ncFYUhDiAZsY8Ut
         7DxH+1jW9Zg/oWuClMONCR25sNNr2loUsa6xPjHVYEvt01egGZEOMRaRGQOH4+lVIDED
         GNqQbBmByUFKLyipFhDLXEn8VSp72qUq3QXe52YTJob51rE7Ucu5xXZf3C62rdf1AfP8
         f/X2yaQBrBwlgsIx2hKF4Ib1J8WLhbVqc9CTkuT14BVLvP7AIzWCSmmCjFfDVmn2mifq
         fhHHqrFOVBkFhSgJwHFCKXe8iDticeeUiUd/77/+dQT6i2xtEcvv3rRJmNjlSlEJoC52
         7DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961586; x=1757566386;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6fcB2Hn+kdC3nY9KK6yt1lH6XCY5pViALcFk/7zZSc=;
        b=F56CNMNjgkyNAJbN9EbrHBP0AfG063E7CdC1XNoUY8m2Lyf0l0RF9hEhP01DuWH2df
         bARWOr7jZ5CfusW2+II3N82mOHeRr/g/9i11SQCZR7YjretdWWl5oJptglQ1z3zVgWW5
         ct0I51S+flvM23Cxm7G8/7wz5iNMAPezLbky2cM2smq5bYweLU89/9NcjBT1IpoJwpn7
         awk3OGAYlP+3RQl9ukIr0pI4RGp86c2JLmTSxyxmnpMIO6+BMlrfeB3GcBhH6aISI2Tn
         w01c3yiRi1mYau9vdB5RJ2+bSXInsILd4fLJnm8P+794+baedOE+g4F9mK5sxe4j47Lv
         mLLg==
X-Forwarded-Encrypted: i=1; AJvYcCVpJ4ucgUYA8xOZTi6ZlykdSrR6aqMZUSmJwgzIr+IlTJ3SxgMi/+25/rN+9KaUmqN+8O2SahwKTaBt8eVhAm0J@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5yX7gLtDhQHArv+6a8EQKum8fs2oRyC4in1O4o2tH/bgOAy5
	icmeW3Tped4KUxXD8AekNKUtFMs9U7nO24O5VR8x3pv/Sf2GGEazIOoJCxr0QkJcfG8JtB4FzuE
	s0uCKoLlJDA==
X-Google-Smtp-Source: AGHT+IHGNByFi2JyIa9qM97FWwXg54d405XOJ5XY/sCItp8tCQjC6nz4qMPhTde5FarXaF7IrT7/bnriXOLQ
X-Received: from plbmn8.prod.google.com ([2002:a17:903:a48:b0:24a:ad96:175])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e550:b0:24c:a417:4490
 with SMTP id d9443c01a7336-24ca417470fmr53348385ad.5.1756961586201; Wed, 03
 Sep 2025 21:53:06 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:52:52 -0700
In-Reply-To: <20250904045253.1007052-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904045253.1007052-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904045253.1007052-3-irogers@google.com>
Subject: [PATCH v6 2/3] perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
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
2.51.0.338.gd7d06c2dae-goog

