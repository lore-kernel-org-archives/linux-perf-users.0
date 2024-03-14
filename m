Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321B2942D
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395983; cv=none; b=owxjMxBjNo7/qZ0DblVgogufTQq35qEODXJeEBoOY8u7mTF1wP81aeA5HkRqk8GTPX1jzJE9JYOVwLgQqJ5cQ61Cc8dpgBlinVB3QWKfdAR58Jwte1bhunOtZPNVC66BI33Eazrpqk1epFY/0Ud7YoLCz6okT0DRDGprmxti5uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395983; c=relaxed/simple;
	bh=OQajBVIwbLXlXH3seDBeY4/yU1jC4uwbycQvos7p61U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QlTCfJVRgRCyhE0rf90fC6I1HcU9iuxuXAYoW9i7lsD3tgfnXTcktOze1P+qnh3QMaY7hXmsacQsrdKe6RtpGdnBczK08IMFy1AKDRrhty4kl5gUtmOP558ZEc3Gi5H7/KRBRptFZozStMCR7EcvfHN5XeMJ6lADwPkJF+d5qLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uw6UsQ1u; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uw6UsQ1u"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so955180276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395981; x=1711000781; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dca7nBv5ffv1LpnnFFef+qmnX+jAjEuRfkSwVUElMaM=;
        b=uw6UsQ1u3QZk7Hq7vCjk4/cH2uTRyW57TWrydB7WaSl2OfYNtt2ftiWLUYN9JsI0vF
         f2vbh8b8LnJZznzBkEjSrVz5cn90y1VQcpmKhJLDqMfHZ1684PjgW2WWwjN/lvE9qUX+
         8YWgbm0Scij/la1XkDRjvBP1/Ess8hPt4FLlFD41mPApBzNEIo0NLWR71N7qJBfLMF6F
         pXaPAiG7U8ZhpXs8BfodAqQ1zg1nntrP3HRwqGfEs2KA8FYAXFfVa0M/KtiLkhp1QGqb
         TIWj7AD1FFoNulzupwqWST7jB4rY/DAY9PDBPnSnR9sZrGP9bH3tCB8ty9U0rUrw55yo
         Qb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395981; x=1711000781;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dca7nBv5ffv1LpnnFFef+qmnX+jAjEuRfkSwVUElMaM=;
        b=UiEpX+43jYNvjNhuRxIKvd0pQkGBbukohpnvo9Zr5UJLUmz9fj+CIoI028OeAhVj3o
         InRqovhRV0DAL4ScH7YDOv7le5ZFDZfK/HoOWIKemXIck3Ow2TFHbzmu4+Cgl6zm5Z+U
         aSbC/xi3iFZLYSIEToCXsyi7W5yRLoQJV/ty0AGWAcvotYH4AG6+SNqP4L31N0bAvYEh
         ce4VrRcH8mgQJC3mEFAApDDWIyUzJd7oiFCK0WY9zYzrc3b/407ndB79WVi0Vnqz4tsj
         XDnHs0H3SL7sD8ZhStHKwhkiJr5JcTyKxd3Mv58EWmfpquTfeW3iP2NeTgXZH2ijPoCr
         BtDg==
X-Forwarded-Encrypted: i=1; AJvYcCX1+dHo8YVJyEWEYh1m6TNNrBfSXBdUnhYieDxPuQqcIPXO4XcCvbL6ljDp2gDXJtvkYbUAufo6TwEysn8/qiTRECd3KVpP82Da8dg0Gp+EtQ==
X-Gm-Message-State: AOJu0Yz1dlDrrZQrZ5A3p8mzJsCkgpYU3ccnJJiJt3XRFMtZhFmcBxH7
	DMWGRIq9CFhdKsnpjno7QGKQC0uXn7i8vHlhK+5b89nn06XxdaOGcOO7nTlpEgra4mirK+GidHD
	b4MJDLA==
X-Google-Smtp-Source: AGHT+IE3q0P9tUDVg+d0BLMp1b5jR1m3PPrykyADgJLMI9+R/WuDbjv//oDHpHvz4iACeyIpNNOo/27VzaDB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:220e:b0:dcb:bc80:8333 with SMTP
 id dm14-20020a056902220e00b00dcbbc808333mr212170ybb.13.1710395981118; Wed, 13
 Mar 2024 22:59:41 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:01 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 02/20] perf jevents: Add idle metric for Intel models
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 58e23eb48312..f875eb844c78 100755
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
@@ -11,6 +12,16 @@ import os
 _args = None
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
   """Processor power consumption estimate.
 
@@ -68,6 +79,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Idle(),
       Rapl(),
   ])
 
-- 
2.44.0.278.ge034bb2e1d-goog

