Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59CF32939B
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539552; cv=none; b=umo1q+emsupLItjPcF7rqD3BJku47NIxMB9FEflkcG8yZmGklqFipJZb7uBs0ozWG8/tBJbz2BF9BEGf7FKsE28kfvDEinhl1eCuWXa8cv/tFMcNwo6GsBPyULX4zctR+v+ENbLaF8gN3cTsdGB0I4vABdvBZgm9S2V3h+fZidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539552; c=relaxed/simple;
	bh=4YZdNHoD4OVwl+Z+UboY1dxnW9GaDyHi2p47czxKHP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=WE05VkZf+02vUR5tTi6KVjcJQQwz0eWv9ar4OrOl/D/ti3Yn/FjTx5IA5USU9jDMkX6Tcl59Jpm/weaaHinMG3LgpyNPjMTz8pxSRhHnqdw2Y7DoQsDj40ADHRqO171j+GI+WbcG3vU38yTuVrVx/p5kuSnqsIhdR/c9kc1UKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8nUJ/nP; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8nUJ/nP"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b74aff34efso4922550eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539550; x=1770144350; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ml2Rrb34ZIoAiVgzhWpgKhiTIZVKvjCF+KWI69P37pc=;
        b=P8nUJ/nPOWeLeOCSwadKKaS8IRtd9R/BFbLISxHtw6WHF7XrNox9ZPpCUtcKcYoHNY
         2L5Q9VpgwAtV3zPRxzGNr0qfBiSYwFLSoqZnFbpiSQBFyW40EJnKolJilORB2m+fALLm
         88QOI9XjfGUBxxP7nVHuTFc4/YHKnzcWFSEPlEYVcY1pfogjUI7bzJ7JzuyWoKXSjV49
         qrn9WlviOqoNnFpvD0PCCrS/I53CcJS9BeL97NN/liHyGbLbAqF6buI34j5/318dstKS
         vUb5T3XTTs9/3qc5GoyTMuiZwpgWN9IzKenl4P2VLCSnlDpQpBMczO1gqZUCWsvxqcNn
         vWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539550; x=1770144350;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml2Rrb34ZIoAiVgzhWpgKhiTIZVKvjCF+KWI69P37pc=;
        b=P0Xtpfm0DzClZGlqoy8x6II0ypwHX8zZj5XceKQLoImoA6YlF30lc86uxMspnTVT5s
         KHzJtO8u6JQHNo8yFtFAhDXEkwgajF178JJAwfQToEM5AyQdDm2Qv7cXcvzH6/m2Zai+
         1VSvcUgfLLY7GXd2n+mycrXoN/fMWHMmkcCgreD+D4xXtxxwgkmn6NT9ndsK3CwHzbTo
         p/46Jn8QurPTlKyenKKflLGdBDYXNQPLYRIOTY4SN0ygoD21VqWK81OyvVH9qxKDLoYD
         aGjv6n7QvBffiqq8MBjaegiK/U74GGqKMuIs/IFZA5pDKBPegSLK1btY0LtyyOpnGEPA
         jfRg==
X-Forwarded-Encrypted: i=1; AJvYcCVJPnAU7rSCTYoZ2ZuhXF1rC8a7F5sMLJKCUxoZ3eqV/tTHGX4o8qxHwOa84NkDFUP8qDNHwwpXJCwmHiBgZ+vz@vger.kernel.org
X-Gm-Message-State: AOJu0YyzXR0Mn5+f41miLRGsR9avjbEuhRaSnqUCg8fOllc75TBUHpvD
	jvZ+iljwFHHld0gY9/RpOc0YpTzoFVCyMdeFzI0i4pR+I/ccguAGDJF6Oq6RgYpNPSS2gpdnjJM
	FIXIxP6NETg==
X-Received: from dycnh8.prod.google.com ([2002:a05:7300:ce88:b0:2a4:6ffc:87c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:688c:b0:2b6:f0fc:8c47
 with SMTP id 5a478bee46e88-2b78d9147f6mr1565661eec.16.1769539549765; Tue, 27
 Jan 2026 10:45:49 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:43 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-13-irogers@google.com>
Subject: [PATCH v11 12/35] perf jevents: Add RAPL metrics for all Intel models
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

Add a 'cpu_power' metric group that computes the power consumption
from RAPL events if they are present.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 44 ++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index b287ef115193..61778deedfff 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,48 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
+import math
 import os
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup, Select)
 
 # Global command line arguments.
 _args = None
+interval_sec = Event("duration_time")
+
+
+def Rapl() -> MetricGroup:
+    """Processor power consumption estimate.
+
+    Use events from the running average power limit (RAPL) driver.
+    """
+    # Watts = joules/second
+    pkg = Event("power/energy\\-pkg/")
+    cond_pkg = Select(pkg, has_event(pkg), math.nan)
+    cores = Event("power/energy\\-cores/")
+    cond_cores = Select(cores, has_event(cores), math.nan)
+    ram = Event("power/energy\\-ram/")
+    cond_ram = Select(ram, has_event(ram), math.nan)
+    gpu = Event("power/energy\\-gpu/")
+    cond_gpu = Select(gpu, has_event(gpu), math.nan)
+    psys = Event("power/energy\\-psys/")
+    cond_psys = Select(psys, has_event(psys), math.nan)
+    scale = 2.3283064365386962890625e-10
+    metrics = [
+        Metric("lpm_cpu_power_pkg", "",
+               d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_cores", "",
+               d_ratio(cond_cores * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_ram", "",
+               d_ratio(cond_ram * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_gpu", "",
+               d_ratio(cond_gpu * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_psys", "",
+               d_ratio(cond_psys * scale, interval_sec), "Watts"),
+    ]
+
+    return MetricGroup("lpm_cpu_power", metrics,
+                       description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
 def main() -> None:
@@ -33,7 +69,9 @@ def main() -> None:
     directory = f"{_args.events_path}/x86/{_args.model}/"
     LoadEvents(directory)
 
-    all_metrics = MetricGroup("", [])
+    all_metrics = MetricGroup("", [
+        Rapl(),
+    ])
 
     if _args.metricgroups:
         print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.52.0.457.g6b5491de43-goog

