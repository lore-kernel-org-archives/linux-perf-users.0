Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1393081B4
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004085; cv=none; b=SUhwQZV3N+GNX/24cyY5A4qLJ/c53b6IdfG8c3blEDCEAG72rtZk66016TyRvBjGE6VP4PEtPtxL/B7ufhgJD7BLg3dO0Hoqeur9kZ+skJ04M237x+TAAi/BTzqAXpf0/QZXQTtSg4XSUlIS6/Vwzdf/prNwfIuBH5m2sp5Tp8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004085; c=relaxed/simple;
	bh=LzY4F0bP9vooYdMwnCs0XOQfXqV24IvjMtZPzidXt0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PSmBB1/sDKGXoZRn7eiz2NqLo4xMdWAiXuRf5febyWuK8/+otOVGU2v80pca300sxklXNqJt2e3IJhsUPkNdBjMumRazjoV7yXQggQyCC7YUCXwSCV77wCcbUhEE8PIXaL1ScsCwHavfNq1aMQRpqQQ+AyN2hhwBje6z8/ud+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=emMhvJEk; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="emMhvJEk"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297ddb3c707so3234695ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004083; x=1763608883; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHgdVqMo2mfd/A30qebWWpCOmKjeXKhdLt2i5lPgFpw=;
        b=emMhvJEkA1egMsRNAROoW91QCuBkynbacncHk8Xixl0xgDemWcz6sTXiS1FaT72sY1
         kZxq6aVtY2bXzILLAphVwZHP88LPSaBmOtD1Cd1UK9HMyH8RKDzsps5XV7Xjg0yKqV6R
         ykr8NixSIBuY2KJLuEVm+rbFn4cvFKEDRElKIB0VLpToFrojud/A43U5I+g56gWYdIXV
         JfYjkjcaZQuGEp8lESEbDml5fLAnZITG+LinPpbF6Cm/HRs2tYf0vyBUEpCiS/wXCOeA
         DHwYOK0QqN6efLj4fS1vLlUpKJA87UTwfQDyTClz8+Acjecq7z7jX1+78MWFGNlHDzvu
         Se6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004083; x=1763608883;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHgdVqMo2mfd/A30qebWWpCOmKjeXKhdLt2i5lPgFpw=;
        b=Zvp7Ecktqf2XuOIAEOh1KzTISBhBwlxhf7vfEHJT8b6MPgREg7IXsLUyLVCEKt5Axt
         xfJQt8k7vVS648XWNXWlKFiuFRYyftmC1GvRD/KSmHYWHhUXz4lNEAzEKnOwCN4gPbiq
         S+X5dTV/VVnq1DJB+BeI2MQwbtUTUEOw7No8EhTQH0XMYxtB0FswLOrBqFBngJ+vonQE
         SoTDyo51ntUQ6jNojoCnfdhxR7kFH0wUKzPrhBrgfMH8YKBbVrTIHKWApqecClRcWljL
         Q7RpYMbQ0FBIPly8jVA0tJbNp7vZWLr5Fu9dWr/MhZFZNVr4wVditCUj459q6RrdqkiE
         RrZA==
X-Forwarded-Encrypted: i=1; AJvYcCWQiNaQYSxt5mMQ51w6PbHK4Zxr705H/MiOd1rwIGhY53Bt7otCGhKfue1drh+I5fqPyu7mFVvthuu7uJgwWPOP@vger.kernel.org
X-Gm-Message-State: AOJu0YyXppV5O0xY6h+fEE54XD/T2vYxBmF2NYt1DL2cJJqJ3KMvXjoJ
	y+E5R+KeEGauFL53nQGmqxKCej7F8SfaGQApGXlGVaBLP431qH5EDvq3c8ObnyrrC7MyZaVMfrI
	vuKR8Tdwdpg==
X-Google-Smtp-Source: AGHT+IHI5BfWqNRWeHHy2eWM6vhQvh8vGmp+McD2FeB5AvGV3o0zzmWwQ4Ynyvw++nC0h7QZGP4/SJ5hwi4G
X-Received: from dlbbq7.prod.google.com ([2002:a05:7022:6707:b0:11b:65e:f6a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19ce:b0:295:70cc:8ec4
 with SMTP id d9443c01a7336-2984ede8153mr74025065ad.51.1763004083198; Wed, 12
 Nov 2025 19:21:23 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:03 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-16-irogers@google.com>
Subject: [PATCH v8 15/52] perf jevents: Add RAPL event metric for AMD zen models
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
2.51.2.1041.gc1ab5b90ca-goog

