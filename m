Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CF1946AA
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438312; cv=none; b=KSb9AbJX8BA0hFrzMMZ3KjeABlsML9I9+7f7vH0aATEZZnb6iHCQNef5NR9hI9v0eBdC28Y3iJhgiuo4P1Yb9DUOv59TQD7W2fOqdb2c/Yn8wBntewHrPQ80gbtJZAOGqWl+7+hpridy+IaWAUw/Zcx8xDv+UN8gE6CS9PLs/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438312; c=relaxed/simple;
	bh=ulhd6SIWCuSYAsAp5BTBuzPtj36lmz0hvxm8Tn9b1mA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GybcLgfaEjkOtIv4pwsOPSYXaH/3XBQkSbo50444nlw4sgenZidRMfX9JYuMFqfgkiAGvdhF1v0UBriKUZGzH2XdG9ns1JwDFbyDU6+G3A9dSHapJcAGF1DbnpyTfaFqsWfAjP6xEff0XjJC59rFHpC8eufOdz8Iap6107jSKOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2F8fQK/J; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2F8fQK/J"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457ef983fso32573395ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438308; x=1757043108; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gDSqJfxhe7LKyb+9xI4v8fjVARMypVtealD8aimELAs=;
        b=2F8fQK/J/V0q9s2x0pUqFimcveOTakLvcVnOJjrRnqfpd1F+bKAi8mZ37W4tCa6EWA
         Z2HIQMUVsYU6QWYPs0aiuNkGNlpP0sRMsqTp1GmgpdUVyDXP1g1uVCUG+2cvYM6ORPc6
         kgD++IWLIbVKNscquYekZn4xdz6Z5BZnsCF14ZyAj5KrBZ7moesaaHMW2r47kicSdY/r
         X13Brg372+zIZkjYLRw4+mcPHN3DKJh4q/ndDjqBvfr2TN3nyoAHFY/HS/hohkbgP8st
         v10xBjgMAFDz1P38FxMKs5ttTT8uEUbEj3nYg4FfALES1s2NyRXdvizk+TU3A4TAGfuK
         0Fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438308; x=1757043108;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDSqJfxhe7LKyb+9xI4v8fjVARMypVtealD8aimELAs=;
        b=GsoIQOjLNUMyb9U/6D7vyM6EWKsA3XX7YVmtRWF+sa45OUgZilbEKDOhFCuhH16sVE
         2VMh84F7TjExP6zW9PQFanN6dYYNtbUX/BjLMJtU0lrIFZs30/SmRWYfkc4QYWJYM3Il
         nV/q43Xx3z7zDITw4ON7xh6mm60GCQn/gwwTbr3xHFsMgpXyzsfJfXFuSLVa6wgPRB6D
         SVU5IhtYE+NitgqgeQK76HJXzYZbC5AcGEHygAELVnw1y60ekqP4Xq4Z3oOTd/fMFRim
         cAVyJsyjMn7jWBUHLRzQxu1D4u+Rm1bcJp34VTwMvCw+2sVHgsRuSWo2DRVuQkSRduhu
         E20A==
X-Forwarded-Encrypted: i=1; AJvYcCWGGQFFX+kX1rITvTFEzPpuSkG933T0Br0fn5R1y4vR3G5ug1JSiqH1cyfGk4w9sBzRvFoxzQjNaulp0xxI4vit@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3aPBnYG2klTg6Enj1awM+6YbrCb9bcOrF3S53MDMWMwqAHJE7
	fMa+y4K2/Yb7SHqGAV27VMHnSuCdrwpwsATfBJUrxG5dx0c70mYfcM+EB9RPPT5swAGpbiAxRgL
	/+X2XoN7GwQ==
X-Google-Smtp-Source: AGHT+IFKCLalt7wpZlr7xPd05a9xgJGKJaAUk64ncFuMeybW5fHsIY9RmdTWBRytsfnSngSg7LEBbvpGXOco
X-Received: from pldv13.prod.google.com ([2002:a17:902:ca8d:b0:248:eeb0:262d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec87:b0:246:255a:1913
 with SMTP id d9443c01a7336-2462eeb7630mr356787005ad.39.1756438308587; Thu, 28
 Aug 2025 20:31:48 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:26 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-2-irogers@google.com>
Subject: [PATCH v5 01/13] perf jevents: Add RAPL event metric for AMD zen models
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Add power per second metrics based on RAPL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 31 +++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 4f728e7aae4a..2261836eae19 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,14 +1,37 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup, Select)
 import argparse
 import json
+import math
 import os
 
 # Global command line arguments.
 _args = None
 
+interval_sec = Event("duration_time")
+
+def Rapl() -> MetricGroup:
+  """Processor socket power consumption estimate.
+
+  Use events from the running average power limit (RAPL) driver.
+  """
+  # Watts = joules/second
+  # Currently only energy-pkg is supported by AMD:
+  # https://lore.kernel.org/lkml/20220105185659.643355-1-eranian@google.com/
+  pkg = Event("power/energy\-pkg/")
+  cond_pkg = Select(pkg, has_event(pkg), math.nan)
+  scale = 2.3283064365386962890625e-10
+  metrics = [
+      Metric("lpm_cpu_power_pkg", "",
+             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+  ]
+
+  return MetricGroup("lpm_cpu_power", metrics,
+                     description="Processor socket power consumption estimates")
+
+
 def main() -> None:
   global _args
 
@@ -31,7 +54,9 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
-  all_metrics = MetricGroup("",[])
+  all_metrics = MetricGroup("", [
+      Rapl(),
+  ])
 
   if _args.metricgroups:
     print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.51.0.318.gd7df087d1a-goog

