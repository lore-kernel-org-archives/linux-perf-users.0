Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E317E7472
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165908; cv=none; b=oDaueH75Xx1G+UbnX+kE6sR8mRkVQd6HbwtyEdckSEuaWVuycmDarsVLmZU74PVR1DLqn5L0I1H0LJpa7dZ8dM/PD8OOnsBU8eht8377DzqlDGymJ3q2uo+NFPKdA/u/1UohLvK7Xp02v9ZEEuWEq2gHoheZNhaJhnScPbJophI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165908; c=relaxed/simple;
	bh=jivBKkzQZhLPmhBpl6x9D7v0XnWYu3hl5fkynoO+b40=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XlPnU3liTVu5WlV0MXvkpR69VMYRu/AFp/a03lTnEglknBoP70UGLPOnTK3gKWCVR21UiaQhGovTVnrAXRq619i4eA5qyJWJ2qHSGk529Auy8l8/Xa7hShzV4UdcK6w/vcbiKGpmind0Q8IG4XLjwfYKbVZN88x5uOj87TxhBrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I0WnU/Ok; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0WnU/Ok"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so773780276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165906; x=1709770706; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEMsyy5Q+PTsgySwyrGbe044hOYiMe9dS9kqphPNxSM=;
        b=I0WnU/Ok+6DOlzzv9M1+5GNoocjSra7ld/yQ+J2ANNcBBZMzNL76zYqsK6mDQNbC1f
         bxkMUNy3j8Q8ZNrTyIyjS0DICXnBmtgMM6EJYeBCfk0ViohHEvGoRPoExUZbxF2ACCrD
         MC7LqWtt6AEgrTMMdgncGxVqp42XLtrtBf0bYol3yIttyNRV04ACZmDRQa0aVadihBpN
         5I3mEp99+hQ50oWG+4llp9hYHkGEl5hI2UqOKOsoWLWE0TW9PKhvFzT8vu0DyFFk09FL
         LNBUttCq0P5M9z65lVkf0F2Whv6uAyPGyfStEJlGE8UA1OHW/ZRlSDfEmqFMGdojKeXH
         w2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165906; x=1709770706;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEMsyy5Q+PTsgySwyrGbe044hOYiMe9dS9kqphPNxSM=;
        b=I683ZlDCJqt14hjccjVOfHyGAW0qhFm3nvF/hb3Kr6tHUUfo+Ga1nBj7PrG8nBRO0R
         1iobjszdphapj64QOcIck3PcTyXF84kyvvpEUKScnlAtnBgQIM2awj/JvpxZ/qhjFyZK
         u9r/ClnQnJYE+Kcz79UqACy75daUDoSoMhnT1CBqIoeGf2xyzyTytdcu8Vm+ce3oZsYs
         6KPqsBwHEBu5R2RU1BHwTGy30b7V9FAyxxU8X+ENu6iCw57yOWdPoNMUaePtLb1GK+p4
         GbXCOf11Hw+ziKOIK+TNhax1f2uF6Pghhjw5MQZ4uMY/h3F/EEwHn+fppO/NrWqvUeYo
         MJeg==
X-Forwarded-Encrypted: i=1; AJvYcCW52b6QYPePq6VFB745IuM94N5wFGI1F0vKqhlzQT9rTnFgYhkS7VlMgpi/oVL0rbrrAa1Fv5wB5X3fina1tt7eFfmBJ1UgmRRQeakxUdRiWQ==
X-Gm-Message-State: AOJu0YxDQbMGYocz+S15W1DYyLncdRKrXO08MKY95Kkc0LbPaFn720OI
	kHqDLUheBHx52/YARaJE2zd9UkjHtgcuMq1DGGYOQlIBxMHWzcu3PYq0ghJad7e8RIx2Cghp7Lo
	LUVoTmw==
X-Google-Smtp-Source: AGHT+IFDt2aybnwQo+NdWOIX4ENwZ5YTevONu6KTkETRd5htUgYOnqX0uWvjFZTSCaLLq4fF+RMjldYEARlS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a5b:392:0:b0:dcc:5463:49a8 with SMTP id
 k18-20020a5b0392000000b00dcc546349a8mr45568ybp.6.1709165906002; Wed, 28 Feb
 2024 16:18:26 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:46 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 01/20] perf jevents: Add RAPL metrics for all Intel models
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a 'cpu_power' metric group that computes the power consumption
from RAPL events if they are present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 45 ++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 4fbb31c9eccd..5827f555005f 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,9 +1,10 @@
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
 
 parser = argparse.ArgumentParser(description="Intel perf json generator")
@@ -14,7 +15,45 @@ args = parser.parse_args()
 directory = f"{os.path.dirname(os.path.realpath(__file__))}/arch/x86/{args.model}/"
 LoadEvents(directory)
 
-all_metrics = MetricGroup("",[])
+interval_sec = Event("duration_time")
+
+def Rapl() -> MetricGroup:
+  """Processor socket power consumption estimate.
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
+      Metric("cpu_power_pkg", "",
+             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+      Metric("cpu_power_cores", "",
+             d_ratio(cond_cores * scale, interval_sec), "Watts"),
+      Metric("cpu_power_ram", "",
+             d_ratio(cond_ram * scale, interval_sec), "Watts"),
+      Metric("cpu_power_gpu", "",
+             d_ratio(cond_gpu * scale, interval_sec), "Watts"),
+      Metric("cpu_power_psys", "",
+             d_ratio(cond_psys * scale, interval_sec), "Watts"),
+  ]
+
+  return MetricGroup("cpu_power", metrics,
+                     description="Processor socket power consumption estimates")
+
+
+all_metrics = MetricGroup("", [
+    Rapl(),
+])
 
 if args.metricgroups:
   print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.44.0.278.ge034bb2e1d-goog

