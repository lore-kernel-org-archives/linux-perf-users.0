Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233E1313524
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004109; cv=none; b=Mg5YnivzGeV43R6pr6aTwRiwjMu4upqGcGDwQ1fJFSdCmm5WEs5HrW9Z6LYAafBWLMUhNjG48B8PyKCghY13KJHUP15qQCDGlpiArlS8D7TFRoDyGurlcleuGzkxcdRkUzGB3BOjZfT3VkIoVACnB112jgwH2spmlgNDGwlZH8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004109; c=relaxed/simple;
	bh=r2UrYhm61SD5yyLdoCmXN9BNEALAkgCmf/uykNFhzbs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=W1JF5j6Zu7iIMHIMXIoTQiWw933twjKaawmp/c6jafOraG0NfLvHcdBVZ/N2vaFRhMxQpU2vtP8o7PNiIXMnnVdyLANJelSIyXTJoobwNgZr8NOyRjxniaLaFHVljwSpqdv1fkBDLNbQgOT/x6vhdyQqWL/wlvGzPyreUwqkoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izCYTE7F; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izCYTE7F"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297dabf9fd0so4714235ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004108; x=1763608908; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JoGi9rMbDF7B/whY6ilXVrwbEGhJJ6yZ28PC3lW6tN0=;
        b=izCYTE7F1/Y0wzt59eV3A133BZqfMPLJXeOYBHfPMvFNiZG1/vfn8sddTI5nY7Ke1Y
         wH5zDiexe2A2eb2I5gv+DEKzSeCpLHnHoYPSlrgBQKGiRTbMbz05eCsSxPkiyPj4QemQ
         NMGjR/D9EF/AhgFaSSwqCnHNHqP444MFlghbMu5qw+IcWJdifpHoDHR9vFUfvfiLHGdK
         hFP8MegcK5oKfRIUa/CUxu63gEgw+OWZAud1YbNJFvJHpBRAg2SoQ6nyrume5oQlWZAy
         DFOdpP/bOabjlKFcVmBhVN6sVJmEvhy+4uqNxDZezyK62FzyJKPzAlLQTiJeRI87FFgO
         cnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004108; x=1763608908;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JoGi9rMbDF7B/whY6ilXVrwbEGhJJ6yZ28PC3lW6tN0=;
        b=ZLhB8UsGVWyje2R3BRKQb0J8lJ3zyQa96B8LCq5DpfBnMZsX0uA6VVP7WCmRrpuQXl
         MabOSJn8t0gG1NnVAS1hDyq5EYu9TeGc0lKOG9x2sH/+TzDLAUVOoxOA3riAaNI/cUWZ
         iz6TefvlzsD5RE9NAhZrbUThD+ohxk4NUk7WrvMLvHcGv45eBivxpyvCAYg5r1iiidT3
         92+LXZofC63rN76G+wViAM5yVQiDZYkSI9YTuTVTga9RGYvKO0buZ4fuU8DAhHimI3Uu
         7HYAe4fmheaYLth6gtXMivb38T3TtFpgcn8GQRZVsAGDH4nx9lDHAHI21gJ2NqOmrgJk
         5lnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwOSZorCL/bbH9W2C6lD4Ehqyh5i0FYR+zxRtFuWrUp37fH7yY5sbkKiuumdgG4D5IF3KICARp4N8g3X706B40@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVMFsR6ruZhd7EeXjjY+H05tenUEaOvaiSQNk8ekf8n4XY9EB
	AC9zdARzNAuJiUldD6+1m+zV3g3ql5Awtvgi54WJaSwUH8tlux8A6OY0aeHb6kOCmY379YKS3Fz
	ciukiXON2eg==
X-Google-Smtp-Source: AGHT+IFQG9GOkIf+nEvNCrJHxVthUiVLmkbajCBpSFkcPYvO21PGGwzhRTrNJ9xIQOxHi5Yji/heyhnMYr9K
X-Received: from dybkl22.prod.google.com ([2002:a05:7301:d16:b0:2a2:4de5:16b9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c6:b0:290:c0d7:237e
 with SMTP id d9443c01a7336-2984eda983dmr72287705ad.39.1763004107564; Wed, 12
 Nov 2025 19:21:47 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:16 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-29-irogers@google.com>
Subject: [PATCH v8 28/52] perf jevents: Add RAPL metrics for all Intel models
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

Add a 'cpu_power' metric group that computes the power consumption
from RAPL events if they are present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 44 ++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index b287ef115193..61778deedfff 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1,12 +1,48 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 import argparse
+import math
 import os
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup, Select)
 
 # Global command line arguments.
 _args = None
+interval_sec = Event("duration_time")
+
+
+def Rapl() -> MetricGroup:
+    """Processor power consumption estimate.
+
+    Use events from the running average power limit (RAPL) driver.
+    """
+    # Watts = joules/second
+    pkg = Event("power/energy\\-pkg/")
+    cond_pkg = Select(pkg, has_event(pkg), math.nan)
+    cores = Event("power/energy\\-cores/")
+    cond_cores = Select(cores, has_event(cores), math.nan)
+    ram = Event("power/energy\\-ram/")
+    cond_ram = Select(ram, has_event(ram), math.nan)
+    gpu = Event("power/energy\\-gpu/")
+    cond_gpu = Select(gpu, has_event(gpu), math.nan)
+    psys = Event("power/energy\\-psys/")
+    cond_psys = Select(psys, has_event(psys), math.nan)
+    scale = 2.3283064365386962890625e-10
+    metrics = [
+        Metric("lpm_cpu_power_pkg", "",
+               d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_cores", "",
+               d_ratio(cond_cores * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_ram", "",
+               d_ratio(cond_ram * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_gpu", "",
+               d_ratio(cond_gpu * scale, interval_sec), "Watts"),
+        Metric("lpm_cpu_power_psys", "",
+               d_ratio(cond_psys * scale, interval_sec), "Watts"),
+    ]
+
+    return MetricGroup("lpm_cpu_power", metrics,
+                       description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
 def main() -> None:
@@ -33,7 +69,9 @@ def main() -> None:
     directory = f"{_args.events_path}/x86/{_args.model}/"
     LoadEvents(directory)
 
-    all_metrics = MetricGroup("", [])
+    all_metrics = MetricGroup("", [
+        Rapl(),
+    ])
 
     if _args.metricgroups:
         print(JsonEncodeMetricGroupDescriptions(all_metrics))
-- 
2.51.2.1041.gc1ab5b90ca-goog

