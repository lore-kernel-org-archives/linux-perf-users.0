Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F62D2381
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697989; cv=none; b=Kx4kxv4FMnr0d5GWCqqpeDWNkPjMvMt4+XvzIK1dy0xqiCzTqEJ1DvMbocKcAMxqbywTKtRoYoZnnDnXK71JIyjjKh0VKafCErhPkmT15Rj6Gt3HQF5bkEXQs0eICJF6kS5TquGDaXPlRXV2fuNVR9JT5vWc4qN4dZT6dZFLrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697989; c=relaxed/simple;
	bh=5mmTiR/WJyjaVLTiTNGv2bo9L0MYRPzWYdyii7ZtuSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KsOr+zp+6u28AtdgNM5qkNYzMumRGCqVojCDAeUamZqTKs8WPbjWTIMIr740dpzV8TJDnhMfZoxP0ZR0LeHIpUVfrGbXtm1H1kSe7Ra1Sz/yyFIAhc4JRJve8EP7AbzU9ejaD/49sMNlEKrmoEIEdtc7LcC+LVPWzUVxZbWTvow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpFHUVmo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpFHUVmo"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc2a04abc5aso4765753a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697987; x=1765302787; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7HjkajWfkEC04/U222ST7CLZ7XFSPYL+9rF1yjcsAU=;
        b=KpFHUVmooT7SvVpSRGvXtL4HLXHFaMqGevj4C846oR9m/zpNMcikA52WG/lhE8z8x3
         2vL0vGbAlfyJu3/EKCc0s6b2kogoB+Etc6EjSrtNQl1Ou3Byikn+789aE1qhWrmPm7JH
         jcxs+FNOzp41dNqZXCzFJ8ymmuZjEEW5fhBpDpeJr1FckJomBIwsbHWFCYzsLhDOAn6G
         ZbZbxKuKi6rWA4cfL9Rr65adi9GFldTEwff4dBJ38oaT7GDg+CeGW2rgg4O+Mq2G2RbY
         wvkmw9iw+JrNHsk9zRPyhg6FNLGs4GebWwrsH3GHXv70fQPfY6SF9oHpWZnhMTHFpB5U
         NljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697987; x=1765302787;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7HjkajWfkEC04/U222ST7CLZ7XFSPYL+9rF1yjcsAU=;
        b=Ngd1cqiV6+3hwbx1edKDm3vUiQ5W1cE+BDsQMZa9jib76wxw8NFqNM/sZC8nR2y1FM
         3qgc4fyzW3baEOwMk4HZ78aNXBhcxUZdYadXAhJsBpoOQ7baab2ebYZMPUCAs7xP5GYT
         l7oTdiN2osPm63ZhwQKOrKpDEdxakcaTBOHPzGsOI6QAmBKAOjBzslr3Aue6hIm2JhEU
         s8zg9KtsVz7iDV54iroJlb8DV1XusuT4H8MhybSCYOmdDLG0RYDhDQdGbHQ1FkVjF+O+
         NRcH19JRNkWEaE95laxU1krP4vcvViXrMCAd1rpNgQStnluzj+nwkAqXy3hILynU4rPC
         dpxw==
X-Forwarded-Encrypted: i=1; AJvYcCVuPMACuHXbJA1wiox0SIaLrNVRSbdGyFlyNiX87qNDV6VoTdAqAQc/wpStjmzouZJEtL3eh+YRtAZZ+GnPnUke@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhetl6a3pcMKu0lZOTXDxOKWbBXACcFR7fRrm1FbiMsR0TiF3L
	SGxvKTHl/ve6P4aoqoYBGuPvwpUOK94uspkv7qAEycNR+jGbcf2TBth9ICsLxyU4WScf3LBwCuS
	SQuf4ZpkmSQ==
X-Google-Smtp-Source: AGHT+IFAIZahcGo8K4p7plFuV5Qd/nBrjV5LmDs7iw1PoHYNyRz1HcPjQAzcrleklbjkK/Ml/JItCFmoIo4z
X-Received: from dyhg18.prod.google.com ([2002:a05:7300:14d2:b0:2a4:5ebc:ca00])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8e:b0:2a4:3593:467c
 with SMTP id 5a478bee46e88-2a941761241mr13328248eec.24.1764697987373; Tue, 02
 Dec 2025 09:53:07 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:19 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-25-irogers@google.com>
Subject: [PATCH v9 24/48] perf jevents: Add RAPL metrics for all Intel models
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

Add a 'cpu_power' metric group that computes the power consumption
from RAPL events if they are present.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

