Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA013ADA
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395932; cv=none; b=CZTIboE4Q+QgPvd4RqM81qiurAUx4YRODdKVIwzXQ/BhjptnYtwtAX+B8wVnM6Ow7xMA/KYnxFivRghRIlFxHD3P6pc5ZvYC0mJkt3q6IAxY8iRa24+ooUFg0uGlXvctD9vWHCFM+Gd272BB0XmSspOLIdEOBGNKpf/Bh8WhD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395932; c=relaxed/simple;
	bh=ANNGBGcZ3vDgNq3zL21zrHIvWLxXdmT224ZJ8sCgbXk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iEIaXNaqcsxhfI4VAHiwvO3Kv8P+aCoeGvv6H3CSugCGfvAN0D/FGnMr/MlHJ9dFi2rGTYDQCuAgImMDqpNVM2+N3p1fOe74ZyQcFtMkBqTZ0IyPqnKLOEq3diiw/GcwXWqVostsdss4Pwsw8XHO+BRH8V0SO6If4he9eyWe8oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IgvQmxMm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IgvQmxMm"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a2386e932so13392217b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395930; x=1711000730; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEqFUQsewVgNTMEeM5wU4wFjtSmvLCXeb2V2OfeYmrA=;
        b=IgvQmxMmCCmcOuj/Cx6M8n7hVRHZ+64QVWIp1umzp4RWmVZlBKKlmNJlzOMhiLAKgU
         D2ehwpsf3jngvFbVUMYBsflj/GqFhSBes9fPwrXpRAlbs7hLwDC1qhu4CerFWh+vE+2E
         XewRJ/xPXUerSwhyoFsKT8lVDA99JORsRCNYHw939BsEaBWLURVle/CzrV0ExG1S/irc
         1vc4zWfxjPQ+mt6sKxvUBt5Gt26AyDxnxD1bb9qbpo5KSAjlCs8p6WIGa6/WMTG0Ry5z
         ohWBOMRyiyijPYl7Nk7LCbp2vJGfk8mwJPoB+ULQpjDczC7gjFnLmIEPPzbzauphBOHG
         CCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395930; x=1711000730;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEqFUQsewVgNTMEeM5wU4wFjtSmvLCXeb2V2OfeYmrA=;
        b=oBT6GOTPHdBjE/ggrjd98Hz6rbXlGvBWIp+MywH2CxZ3G/aCV1NdarCCW4/AvkBQLM
         vdhcvxjvOokbLMYmHOKARjb3FtPUm7rwQasOWjRN+kf3h2KqMOR5ob9qSb2wvLgnpZ9D
         Bd4YfyfC7gH0zQpXUuxLd7CQ2OdPnk38ImSKintzY3dlbhhjV6TQ8/v5xBPYjRWl1GK6
         5YlvLsiReAAu2k78GYSojtoNaoL794Z+h8BIlUZuhOeldRIWtm619Z9xJMfS4be7Yrus
         xaOfq4FbOp8qurj4930j0jnx5eOrFpT/wAUpEhHxX9O8TarQzJSQKD6pc2l+LJoVD/yU
         goAg==
X-Forwarded-Encrypted: i=1; AJvYcCWPET5TIupLTeJe2Qk1TvgT+qfUK+giKqHLHhfACsXsVild+BrzXav8ruDX8dvbhyapzvD30N3LXewHBC95Ea3CQLAlPz66nAbjrM6mhij1pw==
X-Gm-Message-State: AOJu0Yz5aBxVjojd4bKCdmULgZt+peGIQDC7LpWVpGulj1tgtez2kMwi
	fkFJxTBY3MvkaAfxh0wVHJd9I6LSJISLNRNcVic8/Cns5jSEm8MQT1Q7cK4/jHyUUc+Nivri0z8
	88b9u+g==
X-Google-Smtp-Source: AGHT+IHT5rYavCu3O8x9OWfHu1PU/pOaCHZYG/nQxLnQ3Zyb39rA6u658fANhWXSCYfWQxXIQEfB/afY9/d3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1a45:b0:dcd:88e9:e508 with SMTP
 id cy5-20020a0569021a4500b00dcd88e9e508mr252693ybb.5.1710395930282; Wed, 13
 Mar 2024 22:58:50 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:29 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 02/12] perf jevents: Add idle metric for AMD zen models
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

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index fd420466b999..e069b95d6470 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
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
@@ -12,6 +13,16 @@ _args = None
 
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
 
@@ -55,6 +66,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Idle(),
       Rapl(),
   ])
 
-- 
2.44.0.278.ge034bb2e1d-goog

