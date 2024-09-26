Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9F157490
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373049; cv=none; b=MyqeECyye+nvcx0kV7LPdxUpyIDPHM4MmABMVw6I7Od8TrsCRDrQuMnJjhaiLoBT1bQ2Dvab4wV8Am4ysdIOClljz6vxieBWbGvMgZhWgwdNqDyPilWAJM4pojmBkLvVoIJMtDed4dCOtOsdwO8ClmExwM7UFXtXzTIe5CvWsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373049; c=relaxed/simple;
	bh=yvWeBnYlH5KHJguhy5lABIEriYvuqSdXJ0LPNpZjZm0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BqL0nnUmgj8E2748xJut7T+nwM8hzAN4R+1KkrgoQ6lspUSU6S4GNV2w9rbwMTEWSZMa2yVI0fMwP85iscTLaLKiqnUdnOwPIHLvJxjMQ9eSiumIrc7gnYfy/X07jnC1k9JGLg/UZP5BFXRO/ChPyJyXRS04yrpnNISBsDHLbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdVC9bpU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdVC9bpU"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso2218858276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373045; x=1727977845; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hibi5LL08muBMKadiUp2UP2j1gIebwFeSAhkpXeIPd0=;
        b=hdVC9bpUvPUfLaQrkEY7mkyhknRcSl53Z2bsYTsK3jODq2Z2RivArl0+EoRnwwcKPL
         AGO7qim+dTHY/AyJeK65e2xvkoCMJZOOlMOTVwMEncvGPJxylEVnK/CSaAxGY7qaUqTn
         ujn8FTsBduPBRvZx8Aq2/JLZIOFKRx5p2B+nhU/PK+uMQP3oZX4vYV/oNsFpZYthed0k
         csLZ53u5CEW6CE9/N6HpwVnpfud+s5gwCsInOm/wtQM9lAOnJfgUdoQ9VoeObXRywmLi
         RNpWIsfgEkxrTE5gHr5/N3zlMqVvUItQnOAvj4rrFAnPbBRzl9R5sXcsoNInTezHtpIN
         vNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373045; x=1727977845;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hibi5LL08muBMKadiUp2UP2j1gIebwFeSAhkpXeIPd0=;
        b=kHA68G0bOJQuAbbmlFA9VKnaI3SBsrBnB1nYepm/ZvMfJqy4feYY9xwnC6EuQ6lQg2
         VYx60Z0yAp4e54E4O8JiSaDg8cg0Kq+dgjCxk1acvDPghd/XWew2uBvCatBLxkRsCIus
         mBNesA9sKV1/Gz8K5xMV1ag4PTUe1kh0WY1jBp9UVWkCJ7hDl6zsqRCgMA5LpI69iVno
         lyB6PBIcxQaAe6ImWRbgU8Nnj61GR/PoicvUwEZSG/01Ss1zGP0ugNotbwmLhJUqiixt
         oy5hIpAk/gQrkHk0Vmr7JimVeDwfI6BaP7ZcR+RZFzF39m46b+No4BzZM+FlRVwQ6gWt
         qVaw==
X-Forwarded-Encrypted: i=1; AJvYcCU+o4jAgB2rWwOFHjRxBuh6l8kKPt91seT9YnUeqkn9Vbf9ELN5si8h6IPSqJgbuWUiqCWiHDQcXrNjb87Psa0b@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Zp643eXa3d0c5hy/neBP+l/qGMM8PnD+r39hKpMqPr+A4KeG
	jZLuUmnjtA7A4Cp5edX5YDwMueCaWWKQKqkmfSBULVI4Kv+fth3hP0EhekD/iJ/kovRvlZc9iTc
	DjQwA1w==
X-Google-Smtp-Source: AGHT+IGjtALdnf6ddGtFaEXP98ir997IggxkQYyuuX+1kTF4EPazuXun9mwMq1dzOgF5lYkIa0aTZ/WZxsII
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:904:0:b0:e11:6a73:b0d with SMTP id
 3f1490d57ef6-e2604b7c3f5mr185276.6.1727373045453; Thu, 26 Sep 2024 10:50:45
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:14 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 01/22] perf jevents: Add RAPL metrics for all Intel models
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
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
2.46.1.824.gd892dcdcdd-goog

