Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449C2DC76A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697994; cv=none; b=IsXYm99We9HsHN5/TtvVAbdsZdUns5Ib28toD4ohq46MMNpAVclkeCIolAyip/byx7IqVz9KUjitCdtiEEQb+49PckX1hNzMSwhPFPJcvnLksuJGX4wuzfG1PWPL5pwwFE4TNOnXVemhYSuGRH01fsU2oMw2ZJdp6kDbQzOeHls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697994; c=relaxed/simple;
	bh=zTw6DkOSVf0F/qSIutgGSo77kwsZlVorjN3UVKyYD4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KLYd2O8xV9c1Ktg5Lc8kfdB+xL2mwAr0KbLs8Smj/z4ZWnZdFc1fBOU483Xwon5Dt9SxFkYWoWhnumd56N53mbZFDg1Vy+WoTQBc5mpZ8BxX0hut5cgkvDwa6HEpAcQWHrbb4PiOHiyjhnOwVCULIFC2Z5/BuOKFneorB6YJnPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uazlIQ56; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uazlIQ56"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99d6bd6cc9so9498612a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697992; x=1765302792; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laLU+bqUZ9A8+QjLntZJgzdut2+Z8o5wBJOg4wKYbQM=;
        b=uazlIQ56lMyrFXr8g4CFNpQv066GmTBBfmXPRVAliCZf8Re7Jo2voq7jYUSVmYSjjA
         PyqN8ReET1aRmlN5Jf5nNTJQPNygCvjonsbudJRR2krRLb98EFUdWHAXeccvTPSHww+i
         e7IEDIgHCfpG/jzDWF/dJw3dl0UcOaGAKIVUZgHh3rEU6oF3RUKhUhuRA1tpGfVau3xQ
         /nlXukulMhZc3L4R6GA4Sd3AuGOFHAxJwwnF4E3ckZo+mG4xQXVyK90qzMq2A6KBqdOW
         eGAlK/BM0JgvmcmmWjTLw0k+ymPKFk6Yq9Kmx08xHvqT+MbWCpHqcdFx2UzlyP6PVIrq
         RG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697992; x=1765302792;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laLU+bqUZ9A8+QjLntZJgzdut2+Z8o5wBJOg4wKYbQM=;
        b=wSzLEYmPwfYhLmx5Jm4aNiNZD8aAO/aHUa1Ixz10YBVz6TRJTV9sohtsllN70mX+b2
         xhAKWRjVKxz8NrosmQ6/4xINVCraHwczJseWHbpOiZ2l29U6rTcG4tmnu1Epe6eGjVRC
         2lsGG92/G/SOETNtrHNqSEFzhxQbcaKY9Uwr5cyPtDs9Ds0brE91bcLWGJn7kAfLHF5R
         ko9AXzWYdpzGrO9R+AGXVGx1UVYgcL3yobrX4u0MSduGAd8Ie5uPs9frt9lBBh00k+75
         /rYZeaUFti+EuhdKvTq/hylFRmjGd67G/lIUVgoGLbFcJPyDmQnpob1D9ojOmH2M3N1m
         ZRFA==
X-Forwarded-Encrypted: i=1; AJvYcCWyAq5RSV0GLaDJrX6hAHDmQGylZ45MwyjKJ7Jq06WCXIUL16ETPz85Pypwa3Mxn6Kb/gnkozNamBSOQdDkia24@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+HBVwICi3YRCWLmDSzq3wreEojjFxO44u9LLfEIIS6T1WbFlV
	4CrPDceG59mi6eERiz0uSZglpzKaRbmmPi1G8i04M7vIpi4JOpDiXWDJKgko0C8TnRgbU2mXpet
	GpCaQe3UndQ==
X-Google-Smtp-Source: AGHT+IH0f740k1nynPkNZrGUCMK3taQuASVA8hxswR0DLqFkIfrVi05SRxI3QobJMtTWtRjWRWhckPqPEXmX
X-Received: from dybue14.prod.google.com ([2002:a05:7300:f64e:b0:2a4:7a56:1730])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6d21:b0:2a4:3594:d545
 with SMTP id 5a478bee46e88-2ab8fb2bccbmr225721eec.18.1764697992140; Tue, 02
 Dec 2025 09:53:12 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:20 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-26-irogers@google.com>
Subject: [PATCH v9 25/48] perf jevents: Add idle metric for Intel models
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

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

