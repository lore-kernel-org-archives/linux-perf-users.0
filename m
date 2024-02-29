Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D812B76
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165747; cv=none; b=nslTBYOeo+6hn4vIW2UbybRi6BJB/6gFZ6a0zsRC4GsqvrQktrx2WjdSyvLywnCVhNv0tTZBp5T1Q44qgdfkrIfQ8MVehPzudxIY0dK8P+mnCNE46jmtTqdsLzM7ivC4pmLNejIPmaRzvM1XMTrNSdOscc7HbVj3V+t1ayf6G/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165747; c=relaxed/simple;
	bh=RzPNAkcYFaWtPD0d/orbD+ZkcQxuwvwqzQzOuKyN1IE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bb6xmdTAEDbfctDuJJOPcP/hsiKLPM6rYbBnE/d+bweVKzbL22p4ElUQAu7jEdGOXEPdpLrVS5eKwCmuQtjP9ZXNOQLGFNgTACMV62lx8O0i7C80pNa71cZ9XBw+lxqkCRnM9nMu+Zie6iM22TfRTKZbhfZqUzjz5oDPiMeAxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DMwi+yyz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DMwi+yyz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607a628209eso6340707b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165745; x=1709770545; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pr4WIv++H0HDAnrGFLxDjHsCZ1ntGDE7FfUCE5Wa1h4=;
        b=DMwi+yyzPIDxeLUohhLyyw3Uevex68cK35ybDsd9KNGqd5SNUEO+hP4KOObu+/rKfw
         ENWiNj3If0uSM/Uwa8D4vEqKIG8socREWoXrjYocmcqu5lcC1Oj37X1/OaDtAY2QDU1G
         4VwYHXwkdWkzcMK9CgFCiqSYSu3GGGmXC2Q7NLcd7XZ6XUG+TgZ9o8wEHWYKk0wuX5rz
         d+fEvZHCeVQ/rPbkm3TScoMWPqsvOP4ttNrLwj/40Tsn2eDO91cYQf+oGjqkZZ1FyyIq
         FxcVLi4FQqGU1f86EZ/LPi2tBMz/HXBYP71Ae2g3HP4dmJPHCdBygcllzM7cv75nFVT/
         +fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165745; x=1709770545;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr4WIv++H0HDAnrGFLxDjHsCZ1ntGDE7FfUCE5Wa1h4=;
        b=TlKuB9QdcP3W9v0ToCWx+6GCS7HdYmYpEb0sLs0avPOM/grMnPZ6nLLAJ5Ord+PQqn
         oHMgbghwhzHstLfPZh7vgESrJm80vx/53PwSH4iX1zs/ndgR8odTOA8zmJ/ZHdrqXTNw
         E96iOWcaGXeL0EWjrtN7qv3hEgvDWqTusao6p3AFND9CtHUClTzXghYUwE8/0HBr8eBQ
         mxOPwzqEML/074YC98nS/ElK8QC6Wv6LPIY7PiP1xjRO9QMNi4itXRiPfJy5RSXvdnH+
         kwkJtxZj+KBNvyY2P0kfjLtlCiQkNpFMCzRgkZptsOzE++s4pMGXsFww4U+33LOLMZrG
         yr+g==
X-Forwarded-Encrypted: i=1; AJvYcCW8z0W4K98o6jyoPbeUbPm8qwnfaf/nl/ZRCFtwcTvUUoLVoPUlI9l+pOFmDlSINUkKIlxDvSUjGZx8GsZfq8jmphbtWFud99JrML1OX6wwxA==
X-Gm-Message-State: AOJu0YyhYFdL2c157Ev8Jo/JQoacPpN58bfkxZ59Q7JmdxYugqjXZjJM
	7EvaxIQGheFbNd1CMTuMCU6XtJE+EffeB64LjWTfG+ytiamUIPKPzDhQ6k+0KN4eIwJvHXeWmom
	ExNSK4g==
X-Google-Smtp-Source: AGHT+IFAGDlooaxb4JUzFOd4FVURqFLJ3cLhFWTMF7Ek4ZhqqGZ3hz7Iz/E+Wym48GXf3UUgFDjuVIILXDdJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a81:9a86:0:b0:608:bee6:150c with SMTP id
 r128-20020a819a86000000b00608bee6150cmr153903ywg.8.1709165745002; Wed, 28 Feb
 2024 16:15:45 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:25 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 01/13] perf jevents: Add RAPL event metric for AMD zen models
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
 tools/perf/pmu-events/amd_metrics.py | 30 ++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 227f9b98c016..4016ecee6464 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,9 +1,10 @@
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
 
 parser = argparse.ArgumentParser(description="AMD perf json generator")
@@ -16,6 +17,31 @@ LoadEvents(directory)
 
 all_metrics = MetricGroup("",[])
 
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
+all_metrics = MetricGroup("", [
+    Rapl(),
+])
+
 if args.metricgroups:
   print(JsonEncodeMetricGroupDescriptions(all_metrics))
 else:
-- 
2.44.0.278.ge034bb2e1d-goog

