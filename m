Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5CD32AAC5
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539535; cv=none; b=Zd4jXTwS6KijtsLDiU0NDY5SkZ+P0qiQRpTZFWF+aSrRyU8lYWZvG7736GnLrSd1tD3sCgkWxErjAfLhD3MZrJZltgCkHssTHs5ka3+D4abvIOlJhsshFNUnrTul1VmskCR/gQCaCj/FYHIUz9JRan63s9lzKbSlQ161Ez/PHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539535; c=relaxed/simple;
	bh=3dzH9klhwyq4bIO5RZyfc4K/bXsuFAcPH6T9odgWY5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cy85j2TPlK54T+C8Rp5nfr34GmHD9W5vhxH9L4Sm/Fv8hv+xIo6J+m6ujhkmE23gYFaCLPCYme/0mnghRSAgnZLDjjhUaQrSiLApPjY1WDwnLYfHSI5um1gL9XZAbKX4f4UPWqxCNU0op5B4LgOfw2J9d+MtL+ht1J5mZaWLx4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CSKC6wjN; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CSKC6wjN"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b74aff34efso4921265eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539532; x=1770144332; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVpNkInAkg5hK1ZT/Ec1Y6M//ts4yyfB9sxqK5ohOKU=;
        b=CSKC6wjNaU5PWr9Ys50aKWyBT4xMrkouEKDetTIEtOndcyL4PV9HKfSzezlTNhdR5Y
         k1cu8r1+AL9lphcLa89PYEQCa71c3NGjK85gvwpJ2+RhYMxbapBwfm5WXrxBNK0cQtIk
         H00JQdXZwqJjKtV8+2DtsdWuteN3drRcrkyy6cVAzQvciYyR81tOm8s6IzgApacMziIq
         7oNIREdARUNs8ju+BEHWlQsit3+oRXUr4bX8nY2nqWKfWLBregE3BjPJuWQj+8uW0rg4
         5xY6d2Vpk1RImmVeVz4BHO4sCc16caU/UciN8jJgPEUDOy6PR2yyUHPZRkuvRytcG/Rq
         CExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539532; x=1770144332;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVpNkInAkg5hK1ZT/Ec1Y6M//ts4yyfB9sxqK5ohOKU=;
        b=m7pDYcaBkTPk4xUsmAoE8ZuH/IQ4WlrVPv7MF5Gt+ET9ao0NCokjeIOlUYYSoRmHNw
         ydcnQjRvUIPRoWLVoY1PI3rKenMmObtu37V38xcfbeiBKw0GKJOGtkYIQIJf7O2l6bMI
         TdxYftMoCSRMwBBLbWfeb4qC36EqYjW9VNaGdj9LbrWHA4fSbs4HFBEJYWQIOSFBj3eg
         mHWebzJQCpRYX0GBmOlmik8SlmHuj3lWJtGcD5RL7CUyDX2vuqpzh3MXnI+msNrO/3XQ
         mCdgmCRqeislmz0d4lKKJaU+pLRuB6daRcuOyZ5SKJ95me/tGH3VbKNVuJITkBDSgfDj
         /blw==
X-Forwarded-Encrypted: i=1; AJvYcCVdo2RZF2JIR/12YnEpayxz4I0X8ReQU9GrP6sqGVEfLv4tXLkKYlJDCtU89Zh5MtL/xMFO1rQkjP2MejhyFiD0@vger.kernel.org
X-Gm-Message-State: AOJu0YwvmWiNPxMzeKWcUx3S14kQ8SzSmjMVbxmJA9dxwK7BZ6J+7UPv
	6ygUY9EaKnmj3B9W3mZa+cvPlgReS3JROt7bDaMr5GVWZXduGAqF9gCNwlimYvm7ly5FWGm2I8O
	XN7ZbokQhSQ==
X-Received: from dlg25.prod.google.com ([2002:a05:7022:799:b0:124:9b94:b216])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1926:b0:2b4:7205:c385
 with SMTP id 5a478bee46e88-2b78d55db67mr1510838eec.0.1769539531682; Tue, 27
 Jan 2026 10:45:31 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:34 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-4-irogers@google.com>
Subject: [PATCH v11 03/35] perf jevents: Add RAPL event metric for AMD zen models
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

Add power per second metrics based on RAPL.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 31 +++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index bc91d9c120fa..b6cdeb4f09fe 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,13 +1,36 @@
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
+    """Processor socket power consumption estimate.
+
+    Use events from the running average power limit (RAPL) driver.
+    """
+    # Watts = joules/second
+    # Currently only energy-pkg is supported by AMD:
+    # https://lore.kernel.org/lkml/20220105185659.643355-1-eranian@google.com/
+    pkg = Event("power/energy\\-pkg/")
+    cond_pkg = Select(pkg, has_event(pkg), math.nan)
+    scale = 2.3283064365386962890625e-10
+    metrics = [
+        Metric("lpm_cpu_power_pkg", "",
+               d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+    ]
+
+    return MetricGroup("lpm_cpu_power", metrics,
+                       description="Processor socket power consumption estimates")
+
 
 def main() -> None:
     global _args
@@ -33,7 +56,9 @@ def main() -> None:
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

