Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B33D512
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395981; cv=none; b=Y16lWqu55rWVU4jFIovuB1ab4zwNyREBtY+gP10QcMRg3PZ4F/9V0mLr2lCCwCMxgsDe3Y8lh2NGq/jmoX3/fyZxyBowGIOPkMwTkTk4TpK3xLVFU9DOnbkhuQiDPiEAeLjdsS8vIYIdXDKg3t25GMlgPLTmEMCQWpi+JXHNtdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395981; c=relaxed/simple;
	bh=RoaV1PGHpB7iF+mzzYLJ0/v6xXT6l3SZAuzH3D8tIYE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=J2NVYUmWGYWgvAHa366atl5imkjjdW/nKmBKQBw5Ywxax4XqAMTsHh+Qf2EcQGyau6/iklUr4w2U6LeVB10mpK32OMK330okMq6VD0oDBCqdnWJ2vvwIOMH5UkBF9H6RAdq06iHDgxLlTsntg4rr93aF1vLOcGzvAkhDNfERv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMQKKVpm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMQKKVpm"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0a5bf550so12016987b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395979; x=1711000779; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpyhD4Js3wJeDTz3uN0UEDz2T8BCDX/cFh8ndCI6xOc=;
        b=eMQKKVpmarxTCEqfJ5/+YdsflY/IyFOviGs99c2eH4IB8SDWOboxbZpunqMwZnpseF
         CO9ARn1xaKLftS8zAJKWoyssx6NZdpTa0WaZOz8vAcUuStsbCPnmLDI18bf9DB7Gc5bI
         SOimIugGT8lDELYYX0TCYfCoWEw+BY+KzA4PTysL1o4oklUbimKeEtWaQasdM1u+0/qc
         i4XMTzEmWz3vMtt8hbmR2VMA6Y7MOoRUfDfeRKVLkP6H+TpIM8Es+kTE6eNpVPwQLSdd
         eZ+4fmjqTRbdObNfS8nyIZAyoZQaZAXSJ2U/G1HP3HgJoOFYUmIQ47A4ssh7TVc/vKaG
         wung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395979; x=1711000779;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpyhD4Js3wJeDTz3uN0UEDz2T8BCDX/cFh8ndCI6xOc=;
        b=RkqgXReI7AOnAceMXPOecpsPTinnGkzXLXP1CJA4YR0ooVZzGZl8AsVtdw5xcAFs1j
         7/5qds+T+P+WDTV8k8hvKN4UVUom/WPjuks1b0y43+fkco6C4FqQ405CUG674mAFyQ5d
         dZ9LIFwg1+5oyiCKM12weahclK+KN/gNoIi8zuN1xsUafK/7y2As2c0lEt5T1df8JTJI
         QYuyzVyM+VBKQ8Ngq9hhxwchV9FayhQL3a0nIuH/dMrKWeBMiUMC4T7wns18/SPxTv7e
         YKyPpW/zwSnDCntCOgwg8AnxAJXwSvNEkeIJiD5+kbITqb+/kSW9rm+ewGto32yAiYkx
         efGg==
X-Forwarded-Encrypted: i=1; AJvYcCXoePqmazL5L5GG4wH0GiC/jcbh8I6uwB2kl1zgcy0c9G3Q7PJYTWF9cZCRoC8VcfqjBBwulmxiiyWMDPWsGvTdXGMvY7Q2q5PTxWsGXrm1+Q==
X-Gm-Message-State: AOJu0Yy4oG/oxjjXW5Rc+QQXapr7q/ZIFWDkVTsfIRIK44OY4cqp5JRN
	JACTT3BKbiLciNKeFZ3LVRjx99nQCe7TqGmsezEV/xYqYvvIPMcXuF/MH4u+brDMKXQmfMFpkU8
	5rMRV4w==
X-Google-Smtp-Source: AGHT+IG1J4Jc5hyWHjED6a03IGV2XHl621GM4AHi1LarrkTaUZeYHjyI667L69+bKaCy3v7R4rM9qXfHQnlj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:690c:a15:b0:60c:ca8a:4c10 with SMTP id
 cg21-20020a05690c0a1500b0060cca8a4c10mr172343ywb.2.1710395978939; Wed, 13 Mar
 2024 22:59:38 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:00 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 01/20] perf jevents: Add RAPL metrics for all Intel models
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a 'cpu_power' metric group that computes the power consumption
from RAPL events if they are present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 45 ++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 04a19d05c6c1..58e23eb48312 100755
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
2.44.0.278.ge034bb2e1d-goog

