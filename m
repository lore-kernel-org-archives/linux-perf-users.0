Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D49322A0A
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899515; cv=none; b=TeRzvbtigqWo97qXYcL8f1HAH+AxzZDPyy2y1PXAaBgHPOoQhxYoz/6kYLg3WkV6wKGdySewxFPSRbXBXHcyEBFDqwVz58m3K98KmwgWCDGtHBl0bNtOrShQQNJDVgmN9xrF1nP23xItyj0D9B9XYX1B2ps/T+uRINK0zNHikbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899515; c=relaxed/simple;
	bh=4pM2tdD652IcZD8wzPhrvfuqgRtHqz0V8U/ipI7rM2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PHuTia3zXKfKCmD/cE214lkT87Z2Uv2/jJ1I9T4X089uHE3z3C/VyBZkw5NIxDc/bR27k2Cq2OzidIFUHxQIidTyCQH1r1BU6CtUmjyTIApaYOXL/GmDMeMMYY7QaZ+i5thTZOcNL65T4jtsvMzs7OnUTfMlIOqaoqTzhp85dAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iG/cq0kM; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iG/cq0kM"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b0530846d3so2780717eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899511; x=1768504311; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4BlKuWwvBoHJMjQiget3mJt2hAfQGaEdqNx0fF+IWg=;
        b=iG/cq0kMgUx0Nbq+2jsDgsUJFVR6/R3hvmO/7eSuFJKAKouABrEgyHpdn1ioojyDqh
         fgHQmENIFBpxKolgytZDO3gJuPbzZBdBiLfx+6gk4UQqFdJSK75SGeGbmzHaBQHMBABJ
         uyTSOsm4Zhff8lAS0lpERfqykH4wiRaQfhec783HW9ZXcZU7Fv4LxqmU+0qRws3OYoeZ
         krBtIT+hJiJeeytgJsTtUY0HlMq2bj4iHWSLByWPQ71i2+Hf/W6N/AfbtnqIQM4jALSq
         o1nIK2uEkt8MWAVx+/T9v2cOdP5XdV+tLSfuNYeQKctJxlak+rjFQgAqL9kuXel/JmB5
         hUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899511; x=1768504311;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4BlKuWwvBoHJMjQiget3mJt2hAfQGaEdqNx0fF+IWg=;
        b=pCrxiJpKQU84akLUOSmhJ26uWUvUaubtFGV6hWmAUyFsVStx+max3QYWHNAC1WXNWc
         9AXlSh5FYdho9exmhgbvufL8kIZpE85UBpHs8Qh2SvXwAbPg6uIOYo9RcbfJ8UesF8p1
         /GugFYYuD4VVx+Fh7s+u9lxqeDX4rhitu/zkZ8KymHskRvI+N32fYga+IlBjCZXyDO7e
         O0MzcebLVx9tFxyKDAxgPo7iEwgeMSAoMmjlYMNhIzC4CgGZTBLmuJVPO82Gl7Ill2cq
         iicQneQxiwH6Fq/JGiZDQYT6WGuNYzw1EKEYr/j8YWyACK0807TC4BQl54ho7spxcFc+
         nH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUzLllypJafbdcV+S/DyKGFG52+vumV/Ml42l9JCWWRowod1MfXe0EzQdRJriPCD7gJR0dL8Sf8Ewzo2dwe/hP@vger.kernel.org
X-Gm-Message-State: AOJu0YyyhV++mg+vQQRmlzWs38QS9wqAUyUbUZlACAhZlE/wF1x6hqdh
	WXOH5pCToRRoHp/lXBfpn8TitmgmAevnybkBP2W2UcbTnqIDun3JvOxC056aJTSPZUhvCtvMfJ9
	Mt+p54FL83A==
X-Google-Smtp-Source: AGHT+IFBdZ9YGtBDf20j4auioQ8fS0JHTCtar4eY+lDnx8UdCh0olNr5kj0gIYkLSwrxUvuXTjL9a9JTc+3i
X-Received: from dycrq5.prod.google.com ([2002:a05:693c:2c05:b0:2a6:a19b:9a22])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2583:b0:2b0:58aa:8852
 with SMTP id 5a478bee46e88-2b17d2b0aa4mr4993331eec.22.1767899511325; Thu, 08
 Jan 2026 11:11:51 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:43 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-14-irogers@google.com>
Subject: [PATCH v10 13/35] perf jevents: Add idle metric for Intel models
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

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 61778deedfff..0cb7a38ad238 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -3,14 +3,25 @@
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
     """Processor power consumption estimate.
 
@@ -70,6 +81,7 @@ def main() -> None:
     LoadEvents(directory)
 
     all_metrics = MetricGroup("", [
+        Idle(),
         Rapl(),
     ])
 
-- 
2.52.0.457.g6b5491de43-goog

