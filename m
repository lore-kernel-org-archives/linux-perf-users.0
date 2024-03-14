Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E4134A6
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395930; cv=none; b=NdXQob62LbmCe1NEgQVD27bA8w0m0A/q0dQQ3MZq/x8J3zPXitwX0mdRcgsiDn/gUwt/3obvek3ObV1CKS1VVmHlouV4XRlxcZwsys/Rw7+UeanVfubpLumrEsnxMdPNj4bKVO0fxGaMrX9RERa1VlJMGebJRQ7RcskzrO9DcP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395930; c=relaxed/simple;
	bh=IAzSrx8t9wZGU/Nqcs1fpbJl37Ev3p1nvjGgwwav/B8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=szHrD2DfBdP7A35likj5NcXksxaAC+3LXWVtXv7GlKgZXs0z6GN649vwjtnXRKr9Cy7JDmBt/2rgzfXJs+23rTP5yVjLXxXLdgzJCsJOidvD0Wav9y6aYHENqVYuRzFRtnnszLpQsnA9DmNEdjpx6GudO4Mmhrnr7zCsSDbI10s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3pU4Z77X; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3pU4Z77X"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a5374f3bcso10747497b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395928; x=1711000728; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDxyhheMDipyi/5Jry1qvhK6C7MfhuZSSv07ekPBo4g=;
        b=3pU4Z77XoAJ4GqJpDD1QGphlJfbiRYlR5HxkcBwd2g2FTAIQhz0KfVd2Ruca2mdPgv
         3rk/NBofn7KMdYz8xbE6mz75zRv8S+IqRDwlnusAiCkR154IHGzAIzj5cYfMgQoOVn9i
         oTmZ40X2hEdSTnD//G5aNgRsEurUTeMkxTRyIkfp8Y2QxeJ8JdsDaq/LOmeRkgVNMqCT
         LgrpNDj99rvGxPWwo+kbdvg5bYfGIiS9G4WE/ILz11yr38sDsUDn0xAiecVnqDaqTbHk
         TmPxMQ5tcN1P7yHhYOVTD5o2Pi+k6Ni5sVNOyAGvt6v4dTBvKb527hR/AGTnuI3fJ8fG
         X/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395928; x=1711000728;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDxyhheMDipyi/5Jry1qvhK6C7MfhuZSSv07ekPBo4g=;
        b=GqT/JmzqksOxxqC2sNMgLSfeefH4UXbydi3YZGQUnStiKMrK+hS7XSIWu5HPTKYWdh
         XHYGeZecHDbWRW6LY2mTF5rQndemB/CSjXrnwfNMa/jn0/1BxzopGPRIK/79Db0pz49H
         BcAifSrCftkwOiBE09sxK57SsUjW//kZjqZVtFWb5k6a1YmO7snrc3s82KqsKMddm6cA
         0km6NvGpIQPQjBOYIe+9vK9HPnV9bCHgXc+3Ji1QfJKfzIOC8K8Qkf389i22zFCUjDCx
         OMe5zrG0XaPdpkP43GI5FK2KYCXhxm21iPer5PYqTdKARgTCnlFAqRQeg7znVIo1FHtI
         Y6oA==
X-Forwarded-Encrypted: i=1; AJvYcCXMb8SI4pkr/Xd194KXj8ONytjRrzKlu03LMf8LwPjsv43wR6W5oneJmS+yMFpFwRXpGpAHZSc5jWpEm0WkJiVxz+LOyBG4+MoKr3YpTefuDg==
X-Gm-Message-State: AOJu0Yx+GQ2M5wjB02mGAmpwjUa0M4uEwF+qGxxZa3ByqOaNUHbh/dt6
	0BZMzoA2YxXf+BKNIyEeX0AEG5irGhgApVJv0PSYvUFCvScznlwM8YtJaVShjiEk7z9zQgCeX3A
	f7KJmFg==
X-Google-Smtp-Source: AGHT+IHRwEuxnC8JO0B+y1dFjOphGJq4fjARgojy/F0zQnf1VZ05Ad0QH5HbS6Pih4J/wF+nsi85MX6ELHTb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a0d:e210:0:b0:5e6:1e40:e2e3 with SMTP id
 l16-20020a0de210000000b005e61e40e2e3mr149832ywe.5.1710395928192; Wed, 13 Mar
 2024 22:58:48 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:28 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 01/12] perf jevents: Add RAPL event metric for AMD zen models
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
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

Add power per second metrics based on RAPL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 31 +++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 4f728e7aae4a..fd420466b999 100755
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
+      Metric("cpu_power_pkg", "",
+             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+  ]
+
+  return MetricGroup("cpu_power", metrics,
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
2.44.0.278.ge034bb2e1d-goog

