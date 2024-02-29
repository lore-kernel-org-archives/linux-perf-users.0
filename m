Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875BD29CEF
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165911; cv=none; b=JAlCkU8BO5E1GjWQaxAKUg2UV4RIrjqrKHh7ZnstDahy3BtloHFAp6xctQ8er0OqI82EMTd6IpIAnA2GO41YLGF+a+kO4ZgnwkFzRuNnxRZCd86FgRSCCOF+Q0cFWija0KSXq9EkkwFcmsErFcXTtxh3txZyOAMMJelasAlrq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165911; c=relaxed/simple;
	bh=0Tn/XKuGhzhLwIG7EDYrZX1pefqdDM+We6EUBnwMtBM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ifB0kcTZwMwLM4qkba5enPJ+4cq+XB6EnKXa/qM1QyL9zfzdaXiqn18UZMH5AZlXrA//pkGuhZvTp5Cg5TY5Cfb/uppXfD4olr5FqDjrQ34pN3PcLeX3/eoJeb7LdeZoTjQZgUpoJE9guGIRywm51xjRjOtGQX8RC76EDReHC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZUShJLpk; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUShJLpk"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so527261276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165908; x=1709770708; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBsfDPoA8IcXye4Tq39UNHv/YJB+B2Yw2JoEeA/NWlM=;
        b=ZUShJLpk5bXaVGv/VL80hXq3ScNmqcPSBo8M3Pzq0EVTXHcNQi3yQ14zS2t+nXTd3M
         Iydmv/3GZlZYMTbUwgswjrvEWkEVq83AajGQX4eEUUApQkwM76aggmjret/+evsacPKv
         72AZJudzeeoxlgyCcfrKJL56oM3CSZdFZHZhHMXsMcS3fD+f9IYTZzPm0R4vIXauYSwf
         eWcg69kac+KeklqiN1J/lm6zvigElevbYqaJknZVe278xY3dP+Y5afsTDLgz7maAPv02
         eCFuzWfHxZXBrp+oHNCnQZZfTWkZtTR1TZjCZ0FnUGd47wfuwAgimIZScYQ2uzcj56t5
         +7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165908; x=1709770708;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBsfDPoA8IcXye4Tq39UNHv/YJB+B2Yw2JoEeA/NWlM=;
        b=Et2HU57vuyK7RQzR1zyt0vaQ7cmN2+VP7Dt2phitCErC+aWXoAXr6T86o2PgfdX5me
         n1nHmtTQrUmJVo9aOJ45NS7/TgBHRdN6LSEsqw4Bhwif4p6FcSy06tUHFrmPWv5X0tXy
         F7TWkR7DvDMWWIXtbMf2jdyPs0L05aZhES+jSL7tJsoNTZW42u9SKkKBQFVXpmqdPf+X
         VISPH9x75DrVEJodU25Kmfy8C8l6J9m+Y7Jop3CcFX4Y0CNASDaLCj5F04lec2PnXta+
         mCCDZ5izKOzGvXmBo6nDAcrOM+hoiQ+M8uiiuVu1v7g9Z1KHRD3sZciaxINqV/oK+3Sz
         LIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlw7c6C5eJbRAJ1Qaqyo+p/++GqH05OPa62SJrIQ5yctY6fSSWZFlj9aScm64wqfJbwehruC1IF+xbGZNKmUr25VEk4ZMt5MTZJD4L907eJg==
X-Gm-Message-State: AOJu0Yy83aoNDi44yqgFxX6sLSAWa6B2c2GZp5sKUel36idvI+r4dYIb
	Aa7h88VXZuNi3utq796eY9hf6hZ60XSuzkiKmOqtm1eechAAkeORzx8IpghEYHCYgkh9GEPIMm9
	Jnu8N4Q==
X-Google-Smtp-Source: AGHT+IHQCQ2IXOrY2mjPgDRIoa+ccqeHDBjD+E0ML9EWXecbomV9xJUTkP0nFIRphbrfqPVpoXr2Q4jlfvdV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1207:b0:dc6:dfd9:d423 with SMTP
 id s7-20020a056902120700b00dc6dfd9d423mr42833ybu.3.1709165908591; Wed, 28 Feb
 2024 16:18:28 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:47 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 02/20] perf jevents: Add idle metric for Intel models
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

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 5827f555005f..46866a25b166 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,7 +1,8 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
-                    LoadEvents, Metric, MetricGroup, Select)
+from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
+                    MetricGroup, Select)
 import argparse
 import json
 import math
@@ -17,6 +18,16 @@ LoadEvents(directory)
 
 interval_sec = Event("duration_time")
 
+def Idle() -> Metric:
+  cyc = Event("msr/mperf/")
+  tsc = Event("msr/tsc/")
+  low = max(tsc - cyc, 0)
+  return Metric(
+      "idle",
+      "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
+      d_ratio(low, tsc), "100%")
+
+
 def Rapl() -> MetricGroup:
   """Processor socket power consumption estimate.
 
@@ -52,6 +63,7 @@ def Rapl() -> MetricGroup:
 
 
 all_metrics = MetricGroup("", [
+    Idle(),
     Rapl(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog

