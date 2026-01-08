Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5114D3382C2
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899551; cv=none; b=Pylx5Vh78KbCeO4jpppS71d3FTYxikUGIaIBFBGBoK4z3k4Swu3IBhp4CL6LsDqazVD0zrNZntDxZl5m0s9YjGiWp24SF8Fp3CFIpqVfwRTbI0yORe/BQzxnl+dPCmEsndYqg7qigacX0WxmOZThTTTPpaG1xSaHFsusYtgMwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899551; c=relaxed/simple;
	bh=mOVt9AZW6S2rBaj6ZNmLMFxelgMYa7fw7fq68S6sjjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QG6FdOMbAdgXbPd+g8L8fCnCRIX0ku0lMvsWzJEA0j+I60P/OAax5SWROSC/kfnu2/Ut0c5+svuT0IMvqBCPXQPwcI//Wak16x2Pqa1dE8R1AnDGFN4hgjGIMWl19a6sf+alFLRJVA0hXC8w7s7eGlrY6hcCa9h4lSZ0wpC41rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tOcRoer1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tOcRoer1"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c52ff723c86so923627a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899550; x=1768504350; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1b1fHSq3cwPxRtHZEmKHroJ3vQkOF9iI72kRm1MyK0=;
        b=tOcRoer1FgcrJM34LebG8rIKwTfTY3bWAh4xJQF/HpqDMyc/TZ4DibpWI8EXkwFnUf
         PfF8iMig1kHml16XnIIXZf9z/sH+ZtZDwPJsw2ZQLK1dphlWuL7zGcdlmWdRY8s7n8nI
         XOGTx2Dy6s8Z8E2TUvt1LMbPZ7S9PDkMNFCkWxILJY6OZAd/SUYJmmyo+DpRwdknHicE
         NyO+mX4DiiwdA2oIxkTjROXKcdz+9MQh46PZjxvQutgAgXxQD6bcZzbuEer3pn7vKCxn
         tPmeepsxDdj1FKszPrQKokpFN01qBEgX1ngz/9KiwkRv8rZU1lHQHC6GqvFRjHG9xImu
         +qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899550; x=1768504350;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1b1fHSq3cwPxRtHZEmKHroJ3vQkOF9iI72kRm1MyK0=;
        b=g+fJuJxs8B98wWX6cgZLoNW6RvlzVdmZVW5r6Q3HuGiZ4TNVLH0BNJEOsoXFJt1yTt
         qriPsmj9Nct1v/ABPfNLau4H0Hvekpen7pMBc62Neyd67u07hQ7g9YMDwb6iihy9oYdV
         /Es0NkaqkxYYk1I/NhNAdG4CkDlScRA+dgRf0i2qvzFJ/sY3qYf/s9e2hF9Drdgs6DXF
         tHSF+BQg3us7v0Krk4+k+D60MSF7sKxQ3FvjoyronEn1z6KrpduhQmP5y/icIwOYVQGb
         pn6OgU2lGkh7I3vFRvRczRZF7UoIdlhXiUXT1WIy0NP3hLfW2B1J36rDve/Kb9dUGEQY
         qrEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtLS4atMrr93mDxSVpVmPJPIdU45I8RjEzRUscz4dH+JM7oIDnsVFtpjLmk9EdyTrv1IiTlbcBTCFIyfobFCd5@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40NQkSNNOu5Wi8Yev4ToHFaKmQT+0z/uF7cLcyiGPfOwEjAag
	JdOfpmFW3TZITzz1EJBd4zOD3NzfrwW8cCiJzJbdG07eFtm4tk+tvlUMHh/76A8dIbwdflB5v7N
	J6cMjs6wG4Q==
X-Google-Smtp-Source: AGHT+IFhzyUTizDytRZ/tHKIcIsThhmzWzk6DTPFJP6fIaQ2IZDM03AIDcT9u8rB2+BEGPJERwGv4iLL0OXJ
X-Received: from pgdk10.prod.google.com ([2002:a05:6a02:546a:b0:c1d:e051:4d17])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244d:b0:361:63eb:d024
 with SMTP id adf61e73a8af0-3898f897040mr6722875637.23.1767899549575; Thu, 08
 Jan 2026 11:12:29 -0800 (PST)
Date: Thu,  8 Jan 2026 11:11:04 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-35-irogers@google.com>
Subject: [PATCH v10 34/35] perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
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

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build             |  2 +-
 tools/perf/pmu-events/amd_metrics.py    |  2 ++
 tools/perf/pmu-events/arm64_metrics.py  |  5 ++++-
 tools/perf/pmu-events/common_metrics.py | 19 +++++++++++++++++++
 tools/perf/pmu-events/intel_metrics.py  |  2 ++
 5 files changed, 28 insertions(+), 2 deletions(-)
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
index 83e77ccc059e..e2defaffde3e 100755
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
@@ -475,6 +476,7 @@ def main() -> None:
         AmdItlb(),
         AmdLdSt(),
         AmdUpc(),
+        Cycles(),
         Idle(),
         Rapl(),
         UncoreL3(),
diff --git a/tools/perf/pmu-events/arm64_metrics.py b/tools/perf/pmu-events/arm64_metrics.py
index ac717ca3513a..4ecda96d11fa 100755
--- a/tools/perf/pmu-events/arm64_metrics.py
+++ b/tools/perf/pmu-events/arm64_metrics.py
@@ -4,6 +4,7 @@ import argparse
 import os
 from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
                     MetricGroup)
+from common_metrics import Cycles
 
 # Global command line arguments.
 _args = None
@@ -34,7 +35,9 @@ def main() -> None:
     directory = f"{_args.events_path}/arm64/{_args.vendor}/{_args.model}/"
     LoadEvents(directory)
 
-    all_metrics = MetricGroup("", [])
+    all_metrics = MetricGroup("", [
+        Cycles(),
+    ])
 
     if _args.metricgroups:
         print(JsonEncodeMetricGroupDescriptions(all_metrics))
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
2.52.0.457.g6b5491de43-goog

