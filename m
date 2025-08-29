Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146A224AF1
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440693; cv=none; b=LrKiJZbYztqP2rKg5hsU5sJwoJIqXglpb+80q//4Pj28Ivjk1h38JlGU/hHGIcJsi3Oi5eIJUy1kCq9E2QXPDgfB98upEFjDiUj7ZCu5q5sxF3Cs8SleYZurx5F/iDXlqvoq1duTd+pT6R5kStro0Y8PWrdyEqTGdrH4rVywMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440693; c=relaxed/simple;
	bh=X53nJP/mZS69ATwldN5hzVeFfJtRGo/KKlDopKhn654=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aCWmyMH410q6+3EF9tDnS2bUu++wZtmQ1K5GotJfyiumyZO2IST7KsB7KOYWl2b0OwK4T55N7Jcxue8FK3kjkpQ0ZR3X39q2MZWwQssDtjAvxrsJSehkTMZ0HJN8ByjyxCKwEg75g2d2YRAMRQJCBoW6obtpyOp7QCgw6cjGqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SuOgsGsH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SuOgsGsH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e72dfbso2448330a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440691; x=1757045491; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwyQMYLw0FpA9KIhHv/Z7rR87mgRlDW94bg1brpZvR4=;
        b=SuOgsGsHK7316pBCftFv9kpKJtnaHTtrNOzVMs/ViCawNH4x8kLzujw2kX1S93YwP5
         ggNNvCnZbp0PI0tAzFXbAxiNb0VymsPyiKZ43peT1I/4NeN++OjowpPEEY59aGBeRutS
         Mu0rlG0g/vyx7qXZpwWyUlFLrtY37EE491FdOttbDekBU44RiIH52IJM2YMCnWAmIoI3
         AVLPneuCaIcO4NxpXeUrJA78nwrEiYtLAQOMazZZxd/R5wPGIsn3J1J0brj2HNWIdz5L
         yLEGKrtU1ujzLsxzXdAzmPP8SSJEdF1emxpdHLPuYTArc74HNIq7AjqOM3iXTsjDNUcV
         NiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440691; x=1757045491;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwyQMYLw0FpA9KIhHv/Z7rR87mgRlDW94bg1brpZvR4=;
        b=AJ/SbN4jgBZx+bgy9nOz7X2d9+NJAxDmoPHPwIRbgt+1PBvQDpSeSAp9m2pIwsPTfR
         FPn5EXZPYC0d3uk+BJcclgkIYyLcnhUeyGkP+46O+/iJaAv6LP6ULQDQCI2Vweh1/Md4
         AM+l7u18s1tnvjdsqP1oSH2Ay2bfwR4H34ggWUrPo03SzyUAfcURwh+CdboDNjpw0OTe
         czEAge0NNxR0Y1biwVopFXHPDPN1sknjfDFnKFah/CJtVKunf+GCwaREfsurxi5QqmkT
         SxQqHtcArIzGO0j7iAgLajdtPGGVN3lQI75RPIA7hdCfgc75dRYhMdHGa1KXjQ2M1u7/
         1Bxw==
X-Forwarded-Encrypted: i=1; AJvYcCXKk55QWdifhvna7V2R5ozoRVbRnqdKnMqthqPwNM28hp5a1OGqytW0Fx6HT8Y0+SRynpp/5yBrSOv+eaTFx/P7@vger.kernel.org
X-Gm-Message-State: AOJu0YyRG+Xwz2zFbUwLKd94GiDduM2l8JpIs990YIpZh/1j5jc/1g/J
	HAX03dt+BUanryuChwuncu+zh5T8LprEWU+iJAjje/ab7AfShjCIORfrpptalgzG8Yuk9eGP4c5
	uZnJ3gwYAIQ==
X-Google-Smtp-Source: AGHT+IGm9qOaeF502kiWAPj5LuS4z4uHx+FEp9wstbo7flY1Wq6p+EFdIC0W7y/pGCJIh9prVw+wf0JZrWmJ
X-Received: from pjj15.prod.google.com ([2002:a17:90b:554f:b0:327:e8e0:b288])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e18e:b0:327:e6b0:c515
 with SMTP id 98e67ed59e1d1-327e6b0c875mr1352918a91.9.1756440691249; Thu, 28
 Aug 2025 21:11:31 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:42 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-2-irogers@google.com>
Subject: [PATCH v5 01/22] perf jevents: Add RAPL metrics for all Intel models
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
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a 'cpu_power' metric group that computes the power consumption
from RAPL events if they are present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 45 ++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 04a19d05c6c1..df4322ec82d9 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,13 +1,49 @@
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
+  """Processor power consumption estimate.
+
+  Use events from the running average power limit (RAPL) driver.
+  """
+  # Watts = joules/second
+  pkg = Event("power/energy\-pkg/")
+  cond_pkg = Select(pkg, has_event(pkg), math.nan)
+  cores = Event("power/energy\-cores/")
+  cond_cores = Select(cores, has_event(cores), math.nan)
+  ram = Event("power/energy\-ram/")
+  cond_ram = Select(ram, has_event(ram), math.nan)
+  gpu = Event("power/energy\-gpu/")
+  cond_gpu = Select(gpu, has_event(gpu), math.nan)
+  psys = Event("power/energy\-psys/")
+  cond_psys = Select(psys, has_event(psys), math.nan)
+  scale = 2.3283064365386962890625e-10
+  metrics = [
+      Metric("lpm_cpu_power_pkg", "",
+             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+      Metric("lpm_cpu_power_cores", "",
+             d_ratio(cond_cores * scale, interval_sec), "Watts"),
+      Metric("lpm_cpu_power_ram", "",
+             d_ratio(cond_ram * scale, interval_sec), "Watts"),
+      Metric("lpm_cpu_power_gpu", "",
+             d_ratio(cond_gpu * scale, interval_sec), "Watts"),
+      Metric("lpm_cpu_power_psys", "",
+             d_ratio(cond_psys * scale, interval_sec), "Watts"),
+  ]
+
+  return MetricGroup("lpm_cpu_power", metrics,
+                     description="Running Average Power Limit (RAPL) power consumption estimates")
+
 
 def main() -> None:
   global _args
@@ -31,7 +67,10 @@ def main() -> None:
   directory = f"{_args.events_path}/x86/{_args.model}/"
   LoadEvents(directory)
 
-  all_metrics = MetricGroup("",[])
+  all_metrics = MetricGroup("", [
+      Rapl(),
+  ])
+
 
   if _args.metricgroups:
     print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.51.0.318.gd7df087d1a-goog

