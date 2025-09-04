Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CC02222C5
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961221; cv=none; b=WStmbL6fLje50aMefXrXHDVpAe7qGNfLxHbhzC/Ap7ZWB/N+9Hjuk2r17VaRgrIO7VLJ4GVQDopaeCvKaFaTfO3nAHPTyUsp3hp2C6hgsrOpQgxAJTFKsTNpAw3Wdf/WgBThpbm+n9AVQ6HuCNHLUFf/odnjyvZXtov8Jbb+HHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961221; c=relaxed/simple;
	bh=6cSGTKSnTGH2Qc6S4lYcUebBr6/mwIVeBJ3QYJxoSN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TRvFeR2o0mRIWTwA7yMS8egzr/LOztAfK4qhdiaqpXyy4R9DMW3HgwFXhQ53lW0KGKyXkCtg+9RjLK51cWtB0eE1Rhw4GUMIfUOgDZ8jy/Jh76kpNmRfqwEuOCFneX3lYIbTDk/flVXR3a5zm+WuiywdgKn3df49NuSiK85T5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BDxeKVin; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BDxeKVin"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24868b07b5bso15156735ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961219; x=1757566019; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8P/veAk1QofA7phTO6Z5L/IvYDAAxC26ISaoB1KMoo=;
        b=BDxeKVinZ0uezfCDb7rolRBtKR74QQZqvpTlCxLAkwvbOaEqKLbiPS8aS+pj9LZ+64
         lSHqJYY91Rui3Mn6saSGZYhg8F9m+5fCCK/PGtUFdzbk50pJc2zXmLHE+51IEjNxdXWC
         JBbZN1VKd0/6DA3JH1t/qGIWuiHGKFejgsyuP7WlWR6uDzitq+xwRuHgEPh5PavIFXmE
         HPaG7zAc+bV4SwVmRZbrHmGV/jry+oq0Coew7FeIBKE1Nie3xSAfI+9sbvVSftSThzrT
         M0HYuatJ9Hua5l5L5sDwT3AalUzlpTo1WfZrqFLLdxIoGp8BTyJ/MRnxs/i0P5i1R4p2
         /JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961219; x=1757566019;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8P/veAk1QofA7phTO6Z5L/IvYDAAxC26ISaoB1KMoo=;
        b=Vp9B0Tm4V6ykKWUvs/P/TLSc8lflp8bGI48Nfjm03WKA1S7q/WNY7j6N3NsDyJAjGL
         Jf5ezWFkFZla/a0Zfl/5lDpMDFTXV/s0IWWYc2+w+IrE2ASWouZ4hYnLwQ/iwmmu+SU8
         2tOnrV24WyujCoU0/jq+9V1F/kNejfjMlsLi2qRcVYuTNjwKv2WKUKKsdPbe8UlLOCYy
         SLKG1XI4D+YD4OQPnv97MMz9XiM9lkTZrrHj4m4+AoyWDOARhnFcQqH6LE92UJVjvpMU
         z1dTYkTxqPRx1Usnco/EWO/J8y+OH3EOgIoMW9dwQvzpr2gZqd6g2U+WFCOcaI6rWcJQ
         Ly9A==
X-Forwarded-Encrypted: i=1; AJvYcCUIFSAHMqCpkMspcWPIz7LNsUFVefKpslwC2Asog1If8sOtu60Ug9UBVLdm9SHfjr1SHmEzLBlWZnZlPIXDwwBg@vger.kernel.org
X-Gm-Message-State: AOJu0YxtB1Px8G4iMb/BxwucLXVXs5Gdr5Fau94+1Im8x/lc7DksD7Zw
	0aeMoJOrI7GWqCcXPnjeS+JEFXv8UnAekp+xI5ee4PWBnQlDqrdHceqoxy+2Gu6OII2O+ijyV2r
	EQILtT/e70Q==
X-Google-Smtp-Source: AGHT+IG3qXljQYBVs9jDwDu4dhi6m61Vg/y9HfuIddMKpjtXWzfjSppXhzZAxHG2Lds2q4QynEEpS0LpEltH
X-Received: from plcb12.prod.google.com ([2002:a17:902:d30c:b0:24a:f84b:af0d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40d1:b0:24c:b83f:c6b9
 with SMTP id d9443c01a7336-24cb83fcb3fmr28056375ad.7.1756961219284; Wed, 03
 Sep 2025 21:46:59 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:32 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-2-irogers@google.com>
Subject: [PATCH v6 01/22] perf jevents: Add RAPL metrics for all Intel models
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
index 04a19d05c6c1..1de3c2b2187e 100755
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
+  pkg = Event("power/energy\\-pkg/")
+  cond_pkg = Select(pkg, has_event(pkg), math.nan)
+  cores = Event("power/energy\\-cores/")
+  cond_cores = Select(cores, has_event(cores), math.nan)
+  ram = Event("power/energy\\-ram/")
+  cond_ram = Select(ram, has_event(ram), math.nan)
+  gpu = Event("power/energy\\-gpu/")
+  cond_gpu = Select(gpu, has_event(gpu), math.nan)
+  psys = Event("power/energy\\-psys/")
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
2.51.0.338.gd7d06c2dae-goog

