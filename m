Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BA7314B6B
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004115; cv=none; b=GpYyJfWsXUigd+sqXOtPAz4nf64SmvxfsSbabxyM0diiYQp9nuIQzfu3aBD8B0gZph0ofKPUFU1XlE7+IhwYwP7v1HSOv7jNr6181D+An72G86+9qq1gJG+n4zHWFCVqlWAaDZVEzMVdw1ilXT7RQ+BM4I0W/Mf975F91YtfuOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004115; c=relaxed/simple;
	bh=Jy2cgwkW8egeRyoWoxnsS1FRkzQntRaPKtYKZlle4Ps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=O3ornAIdIgQ7HR3M68m7EWiFRUD1BlZPul94VjWod76cfl4dzg3CEv34Kts6hk7etNdKhlS/k17NFpnue6kY7L8m6iF1/kleJMoAdCPLrdPG/+apFukbm2Z5JQKMu31gc2HQhOFx2AzHcfetCw4e8w0wWO1FiiAnPJ0GX6ys0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGVU/pAi; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGVU/pAi"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3416dc5752aso1031723a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004114; x=1763608914; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=be31O21DKqYdn30DBEEULDpa1ih1KG6OFOnoEGhmwyw=;
        b=hGVU/pAi0fF+Jca8P0saH5+hxdzyys6U6qHTBT7iDAAFDQnOvEIfh7dAMWcUkBohfq
         YWbUgfbO7nd3Y9OCPAsEBRG03O0uTVgeyYKmiNrP0ozmF1OIPQrMhuiyqy01WrPLjduG
         0Hduv9lmzdBBIJC4nfPl1Sx4HnvU2UuYIpmQbI7YWTlZxIz54/NZCDBqipI5jMWhAoxv
         bYS5ZaLlpHT15V6/fDdPi6mB3n/Y9VmO0q0XlXdR/rY/WRCKDNkAzb65KOPk/zHcAxQy
         tHAZqBAiJhjvzXv52e+fci3GSyrudmtHeZL+V7be3bsUIWEjeKaRLoxitqGZ1oujBOHF
         DvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004114; x=1763608914;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=be31O21DKqYdn30DBEEULDpa1ih1KG6OFOnoEGhmwyw=;
        b=xQhTUA93Mb5rOEVKF3xugV2BgPeKvK2s3u+ltTajG6+h70fB3eSJ43vtkNMwEbx2PG
         +wIP//wMGxRbEJEygkH/7qIfTFdQQXfDGIVoflW4bnNMZjtnYe9ED/K2zoDQkLlczF/3
         zUtQmklWddr1FqxQ+sOpm3CYsr+AFd4R2PPWxAG6dGuGgqjKvE2iMjxDjUZK83HJ3/5F
         TeyViHYPtbXpqzKvZmDqHH4j/edX6ggjx6HaUV+0CVNwRpWQK0CGpOYvYZvRcY0hlUsG
         5WAUtUa7u/qIw1Sd/pn7RlVDKVcrnxwMpGZ2+kORCegERx7+4Y6Baa02Y7aDOoxySi0t
         kEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAA/Wr6ZQr31ZzPpQNGeggkbPIG95e5Oa/i/xGOoS4+ZBaWMU45NzJX4WQntdMLkVF1ZKubZXRVEUkirDzb6QM@vger.kernel.org
X-Gm-Message-State: AOJu0YzzxQR7xL/ca4dNq1XwYLWGgAW8I7hovGZw5yUfgAHnpdEJTrsd
	uI2ZlsQReAQICEAKnayR1cRRSqh5+J7WjuCGiofwjHqt/dBbtFY4jJ347xHidwwn0lc2Abnvj3L
	EjmzUe5Bv0Q==
X-Google-Smtp-Source: AGHT+IE6YGfKGpcdjFv8IxcY4PacpJlwo1E8Hps9mVUIZNRMceoNams458BhggmeInfaI8A1J6bJLKwpOd5E
X-Received: from dlbuy1.prod.google.com ([2002:a05:7022:1e01:b0:11a:1004:5049])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7d2:b0:330:6f13:53fc
 with SMTP id 98e67ed59e1d1-343ddeda65bmr6317047a91.27.1763004113656; Wed, 12
 Nov 2025 19:21:53 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:19 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-32-irogers@google.com>
Subject: [PATCH v8 31/52] perf jevents: Add smi metric group for Intel models
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

Allow duplicated metric to be dropped from json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 0cb7a38ad238..94604b1b07d8 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -3,9 +3,9 @@
 import argparse
 import math
 import os
-from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    MetricGroup, MetricRef, Select)
 
 # Global command line arguments.
 _args = None
@@ -56,6 +56,25 @@ def Rapl() -> MetricGroup:
                        description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
+def Smi() -> MetricGroup:
+    pmu = "<cpu_core or cpu_atom>" if CheckPmu("cpu_core") else "cpu"
+    aperf = Event('msr/aperf/')
+    cycles = Event('cycles')
+    smi_num = Event('msr/smi/')
+    smi_cycles = Select(Select((aperf - cycles) / aperf, smi_num > 0, 0),
+                        has_event(aperf),
+                        0)
+    return MetricGroup('smi', [
+        Metric('smi_num', 'Number of SMI interrupts.',
+               Select(smi_num, has_event(smi_num), 0), 'SMI#'),
+        # Note, the smi_cycles "Event" is really a reference to the metric.
+        Metric('smi_cycles',
+               'Percentage of cycles spent in System Management Interrupts. '
+               f'Requires /sys/bus/event_source/devices/{pmu}/freeze_on_smi to be 1.',
+               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
+    ], description='System Management Interrupt metrics')
+
+
 def main() -> None:
     global _args
 
@@ -83,6 +102,7 @@ def main() -> None:
     all_metrics = MetricGroup("", [
         Idle(),
         Rapl(),
+        Smi(),
     ])
 
     if _args.metricgroups:
-- 
2.51.2.1041.gc1ab5b90ca-goog

