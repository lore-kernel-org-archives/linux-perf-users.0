Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543E15C146
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372473; cv=none; b=MXFRJzePARHnJ99e+dEaOfkSEBaHRbsHj9FgkNFlX96qv2ZylXMJ0sBdMEl11R7L+5gCX0PFPX1w8hIUge+F6heQH9x/cLZh/G0+RZmShmGVlMfbB11jQ11B37OAnzI/nM9Gb+S6BHmF4n3oFnhJ/BYPFI8WroeIEwWQVSvlBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372473; c=relaxed/simple;
	bh=mFTVg8j/2TtNOjQAzKLb7iKFXXB4OcAiF3vc13n5L/U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=U3TQYsML50aJIBomNUelwDQxga9dw6kn3bTuF55/DKuEHhBoVyavU3ZuQkCL2i/UzKfCREYn36U7v2qNK9t5ROf0ZIn6s99pl9Qq6CbPEHxYhtyc1j47IOvVll4y1f6i/Kl0oWMcA2JnQW7Zq+HQho6jAO4aGxvg8wG3DTmoSB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKOGfK3n; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKOGfK3n"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d683cfa528so15913877b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372471; x=1727977271; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkBPEGtCIqqpDTU10F4DiWYCLZlPnDuDYEfthWZqk8w=;
        b=VKOGfK3nbJ7kiHyGDrbvJp4kNLMXgZsMCBtQna0cZUy8GcTuhc3isduvQTxcf9xpbd
         QJWwXifL+stCW67Y/MunYMH24A31RFuM7ZYr8GTHreyOD0SQWjLf/BJTdF/Tisgd5hgu
         CPxeqcFo5M7qclPZLYywo+Zr9s4tKxX128JicfFkXWvuhvhj1SJeTJJN5EKd/77V4h52
         qxrs8Z/TMykV8VxqYyNW8Q/cYN+RswvBJGgs/29Hja2NSKV+IEbrb6i6+k+/i2ntEeQj
         WUDrosVJ+4BR7BsS1ekDlkgPTe5ObHWCq869c2tSk4zL5eBPrsVFqrHZ6JN2zgBoK4YS
         ILuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372471; x=1727977271;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkBPEGtCIqqpDTU10F4DiWYCLZlPnDuDYEfthWZqk8w=;
        b=orAe3uZ85N1oUM/+YN6lp9cX6mUXbkNzr7q37rrgpytRzJfwfVR1PnqOOMHy0cw1Vq
         Wdcs1isD95VM7SvRHCLYM/aRaBwJL/p0NSQ1Io/8yEgrwvdXl/czK2qJWJwx4l+iyg+s
         Ey1T/wxSktcluuQZJB/bA9hBVdmzZ9P0XEFD6MrZgW8BBdfr6ZrRosOf+yRcDmFY3O5M
         Jo6QbNLGaO+ToC72vrHva/k36SAiQp3OVIoj3Fko7cQdkLoJjmIvVtge6bVcR9Nm6+nG
         kktXePcSbPPgpIMM1cVTt1DKxVuJfkjlhdxcp0T5uSP78aSt7Y56QI9YynAUQqD7mzWo
         vsaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrkJBlDDen4eh9EhtCC/o/K/Zac4FMqN6pJ7CoFWewNJRElgtk7hwEhczNvp5IH+VUO1rgWoFL6vEAKXU45zbC@vger.kernel.org
X-Gm-Message-State: AOJu0YyFk3sM5QndrSvXfQhoEhcp0djdmdJFmaA2dAfwE4CNz/rEHJIH
	ZGz4dqrsrVpLH+ABkSsR9Acc73cp9edFMhglbKla549vl5ihIQz/NpTEUfHaBuzeAP4TpfkRsRc
	+Jxc7Hw==
X-Google-Smtp-Source: AGHT+IEsDmssvQzOzmmDQdM5hEeFK3/Hl8Kz/QYxQji/WFLMpyjk+anR4B/fLMlnQmOaBrUNCkDYFubVGPsv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:690c:6892:b0:6db:89f0:b897 with SMTP
 id 00721157ae682-6e2475a33eemr24147b3.4.1727372470702; Thu, 26 Sep 2024
 10:41:10 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:50 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 01/12] perf jevents: Add RAPL event metric for AMD zen models
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
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
2.46.1.824.gd892dcdcdd-goog

