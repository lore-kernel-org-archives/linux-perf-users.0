Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9488A32AAD3
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539536; cv=none; b=e3F5ubSdxdsdvu/JNIVq8+0hEHSUEtbSTyy0Kj4wbujnp3aRr8oM5Qhe7rhjrIMTAL4pWzXz1gs5hfYP6VdLJjqK5feEtyfUOuj0dv7XzjNwjRG1vsi2ljTXymwCySOHSbpNXFHnpEm2JtENM64/RbxLuQs3TkqZsIUcjAfnWzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539536; c=relaxed/simple;
	bh=y6hlwpTyHyOifmLqzqFarB+CugLw8uac40XfiztNF7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eXn5yNc3TiD+wOUhUQN659xgOo/GsGMl9zcDzAXRcXH4DYFJ0VGx4QDvHuX+PuYpJSxk0TYwiLy5jNJpMAYIN1SFtPFIFVRwsTmJutuRZAgCp6VbiU3joA+oL2z6DOEuzlH0RVd8of00ecVyI4bRg/XgQL5Kl0ucivhzhlydgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gl860AFn; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gl860AFn"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-123349958b2so18715350c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539534; x=1770144334; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vi5rn8mItqo/t2QexpWzl0At3V2hkxYPVO28WOkSCSo=;
        b=gl860AFnD7poKzs1aaF9TeU63uSr+tYofAQ0Ma2NVPvyeJ38xX8FLqMciTzDgzlceA
         jrk/yUveVLmU7W8L9blPttrK506IBbUWpk1/r/eLJBdkhlfOPt7Kv2cdZKY2J3p68ebr
         e6FGo24DYNJC9w7RDjFHZf0tr+QYzTE1KUXL8ki1K/UNsrG7OMcmLSGpyLW+8k58g/oB
         NR/65jALrrdHqGZjEALVY42l9Aen+sLZz8T0wYtFiuQrd2h6WeCGUcBghdueKkC+wHeZ
         77Hz5euL6cCrwi6hy3XVHQpWcAa42kr/J5qTtGMswiRJFCL7S/aG3UAGaQD27w0h7c7B
         YmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539534; x=1770144334;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi5rn8mItqo/t2QexpWzl0At3V2hkxYPVO28WOkSCSo=;
        b=ZIqXNeBjkYrEJ9OK4zG91H+tIRa/c4kYLLcKvOATXNzRHpVAgDobWUO3wg3wuXEWOP
         reYF4rYy/QKqgBu9kcu9gh7MdeusDImb5o9YVrsAhlvEfrJ382dDboBcfDVdlnEXyB5t
         r+btSUhUPtted7vLC3Jsq4S/qBgJPEL22uh8hOD5voWBkFWI2XJ2aU0Ow3wkFfwmlmO3
         1qZqJdWJqBtZCu7f5KwTUU+5rTNnq8Gv3uM9ObimPhHuIYu9NSVhgHuDfkT2bmznon0R
         xpA22xc9LtM6l79NYEjFPvuh0cuIxYvq5ptM3WpLJ1f9hsJmH8tCbmBqIbmZMYCatVXB
         lLzA==
X-Forwarded-Encrypted: i=1; AJvYcCUTkNU8w0Tm0YrQCJmIy7+u46j1B46JcQrwctmNPOc96j9aJS+9j2L7PVwuVhFZTvaPkadxlFmwIA04H8NUPpUT@vger.kernel.org
X-Gm-Message-State: AOJu0YwdLh5GcLPZMDNHYzxM0IYMEzwsIA1tEASWCFGI5VwwfcOcv/lj
	sh+BFmW+Hz3u2LLPayRsbhOeHBw6/KJcnsMDc/idLluvV8vaigRLdoEFWxRfGEJ5fpUH0iS1581
	9GBRgkY1cTg==
X-Received: from dlbui15.prod.google.com ([2002:a05:7022:3d0f:b0:124:a6fb:f902])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1283:b0:11a:962:99c2
 with SMTP id a92af1059eb24-124a00c5619mr1796958c88.38.1769539533625; Tue, 27
 Jan 2026 10:45:33 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:35 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-5-irogers@google.com>
Subject: [PATCH v11 04/35] perf jevents: Add idle metric for AMD zen models
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index b6cdeb4f09fe..f51a044b8005 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -3,8 +3,9 @@
 import argparse
 import math
 import os
-from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
-                    LoadEvents, Metric, MetricGroup, Select)
+from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
+                    MetricGroup, Select)
 
 # Global command line arguments.
 _args = None
@@ -12,6 +13,16 @@ _args = None
 interval_sec = Event("duration_time")
 
 
+def Idle() -> Metric:
+    cyc = Event("msr/mperf/")
+    tsc = Event("msr/tsc/")
+    low = max(tsc - cyc, 0)
+    return Metric(
+        "lpm_idle",
+        "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
+        d_ratio(low, tsc), "100%")
+
+
 def Rapl() -> MetricGroup:
     """Processor socket power consumption estimate.
 
@@ -57,6 +68,7 @@ def main() -> None:
     LoadEvents(directory)
 
     all_metrics = MetricGroup("", [
+        Idle(),
         Rapl(),
     ])
 
-- 
2.52.0.457.g6b5491de43-goog

