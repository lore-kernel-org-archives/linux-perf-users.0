Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD32E9EB5
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698083; cv=none; b=YMya22BRdSMRpNi4VNMypWsDW0Bh3l0qNvEFX056Nd4C0T6NPZIiUIZxiM0uzPGVEkaQASVi9F0evzdO2IcdNhWCu/+sfk0xWoRJOejqQvwjL1N6iMCjTLW+Wf8TkXBBztcPmnqvFifmQdymuzcjr1dIsgT32XIt1JeIdanW8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698083; c=relaxed/simple;
	bh=+iI3/RRys0ZRhLM9cNs5BefDAmUIJNTObN9HhULHALc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pVVlG/HIjF7EEo32RkK0MPs0wK1RDOAj0TvPXIBmVm46H5HulKN6nyICdHuyOpyCRatei4vdX1NboivPXzOrsuA8ohcPy1OdpVMMZeLrYuOZYSooQJmJmmUrYfPw+fL/Uf6X22JaQ0Nf/1hkrotFBv7xd14QG0lhZPQna2NijBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bf1WRijG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bf1WRijG"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bf06c3426b7so2091515a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698081; x=1765302881; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cu2vPTI9LaETUdBm3mb11MohpnaEsDC5BcvlAfrGK2k=;
        b=bf1WRijG6MtmY+Nfgtawhn6ZEHJM9H3BYWF9D7h5JRGvsv3gHCUKj8bhDqGAlFkZx4
         CeY0Z7vtejBXejc4P3O0HSidQwRWmV00NXxTrzdRvceFhTZ4tKRQTINgoWPcXi5rFcxx
         HXMQCU1plu7ybRXbcnscQJcVR+mI+UEBuix5swuv+OgxN6XNDeokfnMUTetop9pBpphr
         Vceoa0EQBabsmhLERET5ExAWCGXyou9ejQeEOTW1PzdcXOpRDaTYY+B41ehGgUb7ZIIS
         Kul09FMHD/pbZzLeP63/OUed82BZo59enguHGw5sh1o0lAXTV5WbHXVvcrabxqoF8PIU
         hALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698081; x=1765302881;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cu2vPTI9LaETUdBm3mb11MohpnaEsDC5BcvlAfrGK2k=;
        b=hxddslwDUb/HOBrXqRHp6/yisXtk8a/e99ovDrlEHawfFXcLA+D20kVOneoP340oCQ
         pY+LEJcXGjJTcPbFIIUpm2E44rmW1PZZxO0Jr5a9F4sIMcLITfN288XfXg6l4MXIkysC
         IrOIs57LqvJddQwHKL+7Yh917S0suX5+/4SUodI2PNbTWQZFhxPOIMeZppiWLUWfpsZe
         5myxhSdkad+dIrihL8X++vcRVeJvPwk2I7Ud27VmUm6etFP+lo/FsVcrRQ6ueMREXn4p
         3/YR69Mja5ci34NEaSzM4B5BlnTW2fSa9SOZhHfW1NBbiD8QS4bqJnlL20MiFQrUdoUi
         1ppQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6u84xm46YIdrPEiqHh/Lwdw8fl7TuAgK8AxFg/GFfnxkOZrVIXeMw/Vqv6HqDvYU6sZkswo2wxKM9UR+8sEI5@vger.kernel.org
X-Gm-Message-State: AOJu0YyXDxnM4quYQPt7RfB7QwWau3xOo4dVI57mGnrilgsuSITc5v07
	bz4XPLsNdZ2pBqxMYicBtAYkgoNMfmsZtHOS4jgFAim7S69t3Goq50+OfvWV9qTGuXJviokLqY4
	37Jl0HLIehg==
X-Google-Smtp-Source: AGHT+IEFfRd/wuwTqQ5tq5zrdmwgl+pFvx0xipfNPrPfbw+oe2CpL343WAcldvXMeEvlquJXTyA/76K6swaa
X-Received: from dlb17.prod.google.com ([2002:a05:7022:611:b0:11d:cdd1:432c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:698d:b0:11b:79f1:850
 with SMTP id a92af1059eb24-11c9d717901mr28443962c88.14.1764698080873; Tue, 02
 Dec 2025 09:54:40 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:42 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-48-irogers@google.com>
Subject: [PATCH v9 47/48] perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
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
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
index 780e611fe575..feb3b1fc5152 100755
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
@@ -474,6 +475,7 @@ def main() -> None:
         AmdItlb(),
         AmdLdSt(),
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
2.52.0.158.g65b55ccf14-goog

