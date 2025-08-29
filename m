Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC22288F7
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440695; cv=none; b=EcUGDK311PvaM2m8A/xbF0VERVpXllwyV+5DnazFIef5cE3UxT24Rmya4WmxaXK2aOP67wjae6KbnE3IzJDQOxHVYItWstbBXmcVbig8edx/POOcd9c7F5AFQaqatJjcmuRvvrK6r+ilj/A0rYNUzh5Syca8hH4eBFUpZ61nvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440695; c=relaxed/simple;
	bh=SpHZZtQwYfFVz65RxEhRJc/KtRlCGOt7JG0Y1z/14D4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=g0oXNma0ajOmXhGMZ6WB5xG5Js+Slgl94Tl3uqOTLMuwTpN1B04dhvyyj2h7ZiCT7eyLbIN4l8BwLDSUA47qx+9mrcncRhO922OP8VBEddi0IT/9h94ubDbDWd3z6q37F4wkASffiqUIXNH3HIOXQmcMWsJmWdUZXUrjP7qMT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jzqAjMGL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzqAjMGL"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-771e1451631so3431772b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440693; x=1757045493; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UPsOCDYWJwD+xaSWmJwCuK47irDUPi7hVVc5CkF1JJs=;
        b=jzqAjMGLSkUpRAXTBjqN1I3HhgBMN2sZWC+FCHSdIouRmjqHVOVi6qZ94+yfy6Juch
         n1trr1n30NkTcxrn/yRpwhh6a2YHikrbK78F/ZQNPCUnenWROKA6s3OL9yKLqunFNbdB
         1KrFJh3Bf9/NKjmb64X9bB8tAjKdlZpJYbYMW5wj2UMHNeSnYJ+/qnfMTDE9XQCO9iuT
         rB2m48KP2BNWvQUpCnL8BBgqAWNEgMo1w8Www06uF2vcv9oBOVnAPDcjiEWSjiAHuQjt
         BUk2By9FLTAKs8sYafKfaffU9RN3PbJzei6D71mA6isO0TtUt0/1TinXNXr6UsAAUGWl
         Fjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440693; x=1757045493;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPsOCDYWJwD+xaSWmJwCuK47irDUPi7hVVc5CkF1JJs=;
        b=aqMfJMGPRUx4i4ePjy1DZ3TAsEtMMv43Upls2krCrMGo/mJxKx25NTihUSgzixznh+
         urZ6/n0ZaLzwfzfLTutibD9UTZUX9MBPj6cmiVkCM4TwCQ7qJcRK/HiP99tusUipopud
         XHtG9Et4qRS9XCNtzIXWphzgq39rLnrVlSldfWms7n03QO3lzHnOhPHJ1nxn/3LpdIHg
         gBbb51nso1nXqhEpIiGE7wxDDyGEZabK4UoTDltchRcq+mPFr6wLnO8aAkqFjY69rHp/
         dGU2kwKOfMxk2wEmiE25P1qI8oAnJnV0ODF1n/vfC8KcxXzRg4y0MpLwrLCj+LEvsiAC
         XHcg==
X-Forwarded-Encrypted: i=1; AJvYcCX2IEBwt5JW7e4GdnF8TnPj9lxdTcn2KTAZm/DLQ9gVL9JOfMWlmCUP2RjMZXlPGbOnwCiE74NwxqZdVtxs9CGA@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdmF32VpDWkDrCrlISHJThYhsaHsY4f4GnUIswGgMF/rwBhfT
	IzGVtuYXsnCUFKZ0FeR7KU1DtWb7NUE+Sm53i30sZ77HCA5gyFuup4RhfqvEE7u87tw/1QOfRE7
	vocv0fzTrZg==
X-Google-Smtp-Source: AGHT+IFz6NP3gaHSWZRuumn1l8T9ebsDEGoBkwBChpO4vMF/HUMHPf2iTXTP7nEWM2eSpRC637e/Lg/a+em5
X-Received: from pfbei15.prod.google.com ([2002:a05:6a00:80cf:b0:771:fbc3:2406])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:929d:b0:771:fbb0:b1cf
 with SMTP id d2e1a72fcca58-771fbb0b2b0mr17834069b3a.17.1756440693121; Thu, 28
 Aug 2025 21:11:33 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:43 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-3-irogers@google.com>
Subject: [PATCH v5 02/22] perf jevents: Add idle metric for Intel models
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index df4322ec82d9..0bb28f4c8316 100755
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
+      "lpm_idle",
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
2.51.0.318.gd7df087d1a-goog

