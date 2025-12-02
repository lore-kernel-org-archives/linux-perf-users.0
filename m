Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71672D77E6
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697941; cv=none; b=Z05MPyLYeuDH8KzX0YJ+QpCPw2WkjWRmblj3/NRmltL0PI+Yf6O8XHXeLAtxZ6jBGpcfDDz0ZOhC7yJQ3Rv4PY1O/nmUSdESFQBG3l+3zs3Z8NQrzJan3NeZH7u+vU5O6DhUlM6EIgHMbF8llWyD3sRTdk4ynDmV4BhjzknLXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697941; c=relaxed/simple;
	bh=aC0ClnaOCDbka6f2nE4FIDoOpTexC/qr6xL0cZlaMLQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZtAqxIM7xyw8E4NhEzAFdfTjDpjiVOj1seubEpG7z9mQ0Y1X+vhZC05kk13Ar5FUYHFdwrG5AOT9C67vxZ4tcZ7jldRKABjUXruGDcuceEXI64YIbs6Zr79CI2t8BTdVX8yBtJHRof8sUpBr/AADl/gW7Yl4lTwoz/ebAJSNm7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E8ASHopn; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E8ASHopn"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc2a04abc5aso4765202a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697939; x=1765302739; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aC/ZNL6aOKThcJb9XJfnDozw+ZaZ4uOwoV5u7yjR4g=;
        b=E8ASHopnuX/z8R8pgLINrAw4tAg9P9Fa2Nxf3QxLqUMaeKtYdBqdhTcTF1+1BTkm2M
         /mlRkfFnh1p9u5aa+u4xWfpH9PK9QA+C7KsEHQxy1NEDW/PTgp3YN6uC3aMglorV06WK
         emDdP6cqwCXEW8pJLmKbCvRU3gucY2W+d1pAUvp0J0IF7mPwAgkPro6huUu9Rd0CObJh
         Xb6jADrCEK9HAxIzLzw+qcmr0tdBZwvUiEcuM/+PQszmOVOAgaUBl0k66hfY+ecOgahd
         alJJ6s8e3GBaU9Y+K0fcMEaTXAPPYpabNj3KWylHxxDdMPBy0coG5ejOoiqg79Mr52j1
         Po1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697939; x=1765302739;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aC/ZNL6aOKThcJb9XJfnDozw+ZaZ4uOwoV5u7yjR4g=;
        b=pIeeCnrg0iESxCqiDFEY7s99izA8XwXqpbzPR1I3ZdUyqWSORaURepp1NFia6UWirD
         rkXc8O914UCQ7+/G1zo7Rwx9Kr+76EGuerut/TXBuKHs6PMBbuNpd8zIFEO0EtjmI/Bc
         4O4ha32+GUeR8TkIIeSrttk0b4dEB7/oQ3FQdgLmLZZ2Swv9oxKoHGGsUszgD4mYJGAd
         RaXcea9JMUOWXb8rK50x0AAhLqa5ZJ1x7TcDixvJPQNlFcdVNWEJ/PJRaxi9XWWdwCnK
         L5cJWvqxz9Yo2g5LckdoU8y7CV/syT/uGfjgDZQ8ZVCDL0f0rI6AwmKM89u3iK2v7bC/
         gDGw==
X-Forwarded-Encrypted: i=1; AJvYcCVg6g4wWlGvfSn6AtU0/BfFUllVhIikKZm/7+bFuqvxiPACRa7s0jno1f9mE8dB/D5+EcOBuZxFLQukzzEtlSNZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcWBie3E3hv5tH2U+ekXOfW78sQ8Tg+xou+csqVq4b3Wd2Fy2
	UeuMKx97HOWBVPlBsGtKr1y4lba6RgUTMCa2xWA3qH0Kv7OPxUW/l3xPq+EpCw6EWpD0jbZvdKX
	XmuCHiIdjFA==
X-Google-Smtp-Source: AGHT+IEr2zTfjSV0R8S290usnwVG6hx5qBVtmwN91OndNlA0hS2VO+EG7I+di1Z4TXBKtu798+++4CZvsYVt
X-Received: from dybhe38.prod.google.com ([2002:a05:7300:e1a6:b0:2a4:6ccf:64c6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7fa5:b0:2a4:4bbe:4a94
 with SMTP id 5a478bee46e88-2a94188c823mr20914804eec.29.1764697939002; Tue, 02
 Dec 2025 09:52:19 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:10 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-16-irogers@google.com>
Subject: [PATCH v9 15/48] perf jevents: Add RAPL event metric for AMD zen models
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

Add power per second metrics based on RAPL.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
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
2.52.0.158.g65b55ccf14-goog

