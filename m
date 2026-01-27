Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14169364EBE
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539593; cv=none; b=Vw6ZMQ38W51IvLNqZ07RDjiH8db1FdaiGj7Ezo7bYheyj6d56iseF6jsti7tZTZ1/sxHiUE4p72D4digkcYeb+zAL0nLJ12+5aFsEFB3LPaBxNJO8fHhgNF9iKIXgM6xzYmZIGtVO/P5BDEpcCQ7wAMrabODoV80fp6ftaz8XSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539593; c=relaxed/simple;
	bh=1zUi4F0wnFrKUNubA5dgAmMBGudhKmfRBZtS61CeTbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WyKkiWF4IOobPnLKlBuQ20qu0zYopLmj4JFhknP5mf5HLm9XH74UOmT0JZwDiwGokql2PMdaey36NTEBZrVONFvjXSwSDS82Mx+4n8+7Rx1QmqMAoRtEi0IYUaFD1Xl9bM4coF36dKEqsegOnZfTLWnn9ShD9iIFZhhLcT8kyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBUnFBWo; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBUnFBWo"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124743cf760so5124715c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539591; x=1770144391; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpcaviiC3LGw00gXygGe2ykJpAMPCjE5SQ665o5d7iE=;
        b=kBUnFBWoH+jsZOhcMyaUKR1xZm3A9haJp5GdmM1rupdSXaeF3tgV1cnW1C+jjD8U0A
         GVmTu7E+ZmC9FICkWV+V2OZCQj2IKDFp89wBmhEuy9NwadYTE1AhPyL66gt/MzSSYAsC
         6pgHPglmKjLqBBAmBuBTrlYAbEkTEP++TqG7O6kEysIHmU7FlYl9bErUw52D8+Z2Xuj0
         6pKlOGc3/vUM/EWFHOv5dXCl79YfiOiwZUjbCR1DLF9b+Wo73KY8vqxxSotUgtOIJgM+
         SNJF1oMCIqQZmpFqFhRWxZSB1FCklgXmTKPMRz1oRY40EjxRxh7mPzZAVrAT0e+yz7Fi
         n33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539591; x=1770144391;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpcaviiC3LGw00gXygGe2ykJpAMPCjE5SQ665o5d7iE=;
        b=pk0KiGapdaGPYtvzRYs4Pi6SfmTA2LgP6Q66dad8habGxdLl6liVV735eUD/Bmb9oW
         7edtdESsuQppXQdpDHCkBE6a9oxLcgymaz4E5mIRfRESNbvMOn81gRZo5/JCcTeszPVN
         qAOPvhntX5lH9Qed+L1fAnEsmDbkMibRQHqfT27oPu4olLjec6kplFdQNimQArFAksqO
         RIke5fHv6vgdMr2BS21IjXzjFPoCyJv5hLALZDKaMaVLS0XbT1YrMRmwOygo56adadzP
         7j71yAVAsDQd6eMmioCpUyKcV75S3UbkO5I5c25QpQapFL9chbQcPbGD6X7X0Dh/UYgD
         +jvw==
X-Forwarded-Encrypted: i=1; AJvYcCX9fJm6wTce6yIlEihEk4eLQAkAwYhG+4iwP3dhaNZUCJobUFTmupKJ9WCdtBGexR7uD3/j5gvsIUKrIx4HtitJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/NiAw4qLiSp6jeJlOHBwGyOAjgyM1MP3FgrChO8b/C1pYrZM0
	y+JgROhGEr+Z2xFNBzaKm5FqxkaZos54C0hJKAlXBtPjcejsZil1e9BEE85JkO/uI7wKDqNplYw
	Vj7C0SzsBjw==
X-Received: from dlbeb5.prod.google.com ([2002:a05:7022:d45:b0:121:7b85:782a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:c94e:b0:11d:fcb2:3311
 with SMTP id a92af1059eb24-124a00c7d5dmr1467924c88.27.1769539591175; Tue, 27
 Jan 2026 10:46:31 -0800 (PST)
Date: Tue, 27 Jan 2026 10:45:05 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-35-irogers@google.com>
Subject: [PATCH v11 34/35] perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
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
index 4878d922a732..537d27851ca9 100644
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

