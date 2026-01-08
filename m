Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4669329389
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899514; cv=none; b=ByW6aIepZwSOkTYOvm5b4TcmJcy1NxBltGw6juecigu+WkViEMgt0vA1yci8Byolw6S22HTP5Re6b0TrM8wUL4Hkovo0HKfZ3Av/cIZRmMsYvrhzhN+LLf/gsceCqMPebZVBC09b+0yBWwYEdqaf4+YFBxHxjRzBGmvbPO0KBhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899514; c=relaxed/simple;
	bh=4YZdNHoD4OVwl+Z+UboY1dxnW9GaDyHi2p47czxKHP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OOvbRhDMEMY5KD5jQPOUPQ5h/l1EYi+MIZdw8KAVccJo7BDZX6OyC8rl7G3IpMTbkWMUBHGgJPLSj4Lgf1rsfcxtgEeWRrfWOdiuHFg5+7+g7KtuJd7ouQTwKRvQ451r3kiFwJVG5PMwaxcnGyesk2pzJGKMPWIlNCjQ8OdK6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZGTvF5Yh; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZGTvF5Yh"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ae32686ed0so269003eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899509; x=1768504309; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ml2Rrb34ZIoAiVgzhWpgKhiTIZVKvjCF+KWI69P37pc=;
        b=ZGTvF5YhduVU4Gis7/cljVJ2pQGGHoiNFofLNEfaOtCRs6c6wrDq9zE8tXm++fXQCZ
         p5w52CcKmF8oh/LJPKni0aA01M69OLlC/TBaqp3+kULmdcQMHaoa+UYjC390iJpc5xZ6
         pmWnedvNWnwQHKH4VY6rXES2vI9BYoCc9dQx03zChbQqsFjEfmaP6yH7QIDa+3U28FUk
         DkN5WTdHIbtAxO8Y9pvspVzmMqL9s92KNQ6rDslDKJrbIhrSEs4fsi41/VESm8KKFKgb
         N6AaisrsxGXsBbEnkoIF3ywawax5/hRDB1ZBveGz/ykolr3nTH4bSdrrNSGISj/x82l7
         WC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899509; x=1768504309;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml2Rrb34ZIoAiVgzhWpgKhiTIZVKvjCF+KWI69P37pc=;
        b=HuHtsvHjVD2VQIMQvZ6VGPaDS7Fv4RYwuCDKmbVVZhXzqt30riVfRdk9tTmkBzN5UC
         j+WZ1AarfiuOHoNha/teetr3x0sHEjhxrSm++ORIjRNngHFHaAQWgET/z9p1ilHwR/tX
         X6XlzOKs04DV2dXYh5hrxTdwTlBS9VWk5bAgixKL0Z31fQnRJhECIM1REFWtw/4XRMY+
         M+RgduAgvVa6nkKxHKv+4ExxeHt2Iiwflk/l/fOFZRLZvkmfxAmSH5hUjOBorQkzEHw8
         NXGWHyt5yVvZuFp+n/K41vo8yo6KE1aVEVWAAtaNqe5r7GqxA/evDfX/Qc5hO3RMzx5/
         QIzw==
X-Forwarded-Encrypted: i=1; AJvYcCXISlZUwk2ccEG8SKLE/Y7C7PpK+2kkVl8x7TukcFLJKokbo82rvAwgLhI+dWd5keaADMAnMjEiFMHcU4P8VtZt@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVynP45YFfVVGgEBbGHBIJEM7PSvN4K5pC6GAs588UTKnVa4b
	o6ls6j88fNNxnM5xdjzLi4IxHUix6QkIGbBW7qUzWG+kqXMzzD9tKtDzuVdSghCRozW6R9OiITj
	U6XMSaXeRKA==
X-Google-Smtp-Source: AGHT+IHoiPGHBovETyUcjQ2WmUMUU3CaN+Uazo3cs7yqtLWEn8FJr6Btj82A1YTfCuiVTgb+PwR3cXLrlNJU
X-Received: from dycaj16.prod.google.com ([2002:a05:7300:fb90:b0:2a4:7a56:1730])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2215:b0:11b:9386:7ed1
 with SMTP id a92af1059eb24-121f8b72712mr4738901c88.46.1767899509296; Thu, 08
 Jan 2026 11:11:49 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:42 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-13-irogers@google.com>
Subject: [PATCH v10 12/35] perf jevents: Add RAPL metrics for all Intel models
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

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.457.g6b5491de43-goog

