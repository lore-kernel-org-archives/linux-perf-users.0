Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B676322B7B
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899495; cv=none; b=kJi9TMCLuxjwTjviqy2n8hes0uiQO7P9AeWD6q/YjicFmY2Ld7ZQFVZnoDyYX0llxCcSehfmJltDe3N3tYlgxJI5lSG1NY1Q+CaKU9JAIr92vNtDjQFtxVqpKGceYmUco4Zy7fXQ3M8pk9EHm1r3V0Hox1Dz+4ywxZCQ1BW0Vtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899495; c=relaxed/simple;
	bh=3dzH9klhwyq4bIO5RZyfc4K/bXsuFAcPH6T9odgWY5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bSVZFIJK64Km+SJq8rtawt/T0kOZCa+m8FWlmE8hfxlhhEbmyug3L3tzlRt2DZ7+QqTSzw4j1/nalkFAKNJs7bQ5dahbl2dXPGpresf0ENN++rVjpiywTfUqZ86Ni8WfeZ4bZ6s1EN3BS0ChF5WeMu8zNp9e6GN2sSjR8Y4znx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LtoO3Wsx; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LtoO3Wsx"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ac363a9465so2578343eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899492; x=1768504292; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVpNkInAkg5hK1ZT/Ec1Y6M//ts4yyfB9sxqK5ohOKU=;
        b=LtoO3WsxCBUFM6aKblFSmueZRWCNuAqe5v9OaNXphWMK5QI+cwmJbQMTdQDyTcQ7b+
         X6PRXSCSL1nvmKG3n426YTQf8uEJA12oxNzHGC+jqZ3UfYPodn96A+SpSSViVQ8HK/Ah
         gGbYzH3qo24eUItUhOdv3wsuvkTDG5FNbIgvg3aMS0F7zlJkkuBQ5yFnTCWsOyVciRnN
         9rUKSZSy9unt0uWOL0vjLwCg2WAz4IINQLzQ05eI+3QXXWIham3+cnfpsdWnj3bsvWr0
         HkTH1b0MPHyabv0pZTSgJz7kdsDu2ZPsNxkAewsxz8eYEmvlKSx7ElxEqOsXxyOkwp7a
         7yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899492; x=1768504292;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVpNkInAkg5hK1ZT/Ec1Y6M//ts4yyfB9sxqK5ohOKU=;
        b=pJwQRhBUEC6biiKV0Ss7IEkeQxhYouweIdPoK4ZohD+rE5SXMTZI8407U7BqR+vB65
         +Xsgp+upOG0sDMLxES6WAGdl9kQJq/3UQvX/N1AQQNG9AAZY+BeCJvmxQLsVFkI5ZdUA
         +vVOpJO+ZICQrqO5awEfMIx0JXmnLrKVSG34tzEXJXUrBSmHfTQNLnXPlOrXh9l5mOOq
         8WKVUeISxtEQhxpin7b0JI1iS6IQeTEPpfFwg3fOX9obR8BieQYXNO1njL+/WcW45YVt
         LY7sgAtMPetcmRWd+Y8EoH3OWxNO756KAFFBSz0kfwaC+tBCC1aPNwCCeSM54P8Xg7Y2
         fx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXA3eGDcny6WwhV84Iwxrt914q/K7bCzHy5VxgADEldb741e8JxNU01cK1OJpe1PXNSc56GjBp9KlyGieNU5RO7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8WudL1phQ4fiSXwvuv2Fx3eHF+m/t29+QFpCDMmFSDAb1w6i/
	HWU25xKpeerub8ZHeU/XVCsXojlL/tjX/EB520tFNQQ6kJ4IE5MNHcWiXQwQscM+dMX5E1X+N1o
	6aI2rg7CZzw==
X-Google-Smtp-Source: AGHT+IFSzMDUJYZjjH2WbaulVMFC/bdYdVGekkeGgpMpVS1oIkOVX6/sDF1nJr5rF9ce0hLscstavVSdPFK1
X-Received: from dlbti9.prod.google.com ([2002:a05:7022:1b09:b0:11a:44f1:daa3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f89:b0:11f:2c69:31
 with SMTP id a92af1059eb24-121f8b9e384mr6553673c88.46.1767899491609; Thu, 08
 Jan 2026 11:11:31 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:33 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-4-irogers@google.com>
Subject: [PATCH v10 03/35] perf jevents: Add RAPL event metric for AMD zen models
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

