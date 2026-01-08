Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7F329E7B
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899498; cv=none; b=OjuLEIxTA9UmFSaiKEiygrFl9WerMQsu3wnCoNP/B0PATWnn7CkbnBzXVfOSDuVJJN2t+kE2cCK2Db0GjWD3cpOsZMZUOtyVX4toc1OybxLq0YvZFXuclf9X5yCg0+u9ZQnCwpzANEBJFJM0skWctZ9SL4pDUtWX/c3C3UiGnP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899498; c=relaxed/simple;
	bh=sYwyZW0LBQ597YLyTQ69dNu9phNlPd6GGL+UFrt/Z8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=i9p0fXTYXMnbwFTzSi5cCkYV+NBchVgNOEOhz5d5VRaOGhMH8OEqtnf1Y4lZl1sZI4xlX1N80RTmvgR2Uhro93akD+uJyAUU7Lew/q4vH7FlFY8iwE9E/Gn1aqEmjuxsrCpV3a/QxJcjIwStkVtPjhfHBVRr1CsxD+Bic7ZhQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1t/lCQu; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1t/lCQu"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12055b90b7bso249255c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899495; x=1768504295; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xiZgUA9BZXnU+zboVf8da2/7HRlOa+405JXsBRB3eM=;
        b=E1t/lCQuSXmgPEMNwX++UtCyRHSdhOzKn9wOPvhTGnYntxxqAX5etlhRnAEi0CauCI
         +1x1m4y2fp/DXFys3EItl1FA829RKZ6uutC1xF/tQQ/BU4xBvaHRYLoGA6K6WHvMA7Yd
         dV5ucXT7LsZdyNwqYvYzi+RWFohRX3GRr8uAyMxHbIb/3mYBjHKOC8loBTdKfVlDDIUI
         IYUv8dLwM+KRrRFg+C5UUDJPByV/9TkdijwXfwY4/pZN+cJ2A5OyACN5sWm99ytDoMJg
         jP1fFeVKDZ2Ujv0wKjUvvaDfeS4oVwTf8AO+XInt7jz8vW5oyVLnsz/POa75WiPsfVTj
         cOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899495; x=1768504295;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xiZgUA9BZXnU+zboVf8da2/7HRlOa+405JXsBRB3eM=;
        b=Tw6H2uQ6Qu2tbEWVNRQAbZbL7T9ruscNqeUN22XkGBMAbglWGmBeIgzQa4St4KesFR
         DyUZTyXccXzZI0mDwJbkwA8orSK9PIJ8bzATAswKTU/RHk393+JRr0PyYvEldIkwSlhX
         PzzIEGhDzhsfEY854tNlnwuJKndRZky/HFTKsvoZkKmRQZPNHKj5MvuQUmSE0naOgTSc
         G0NZRV6o23zEP5t9I+YLJRFkOE5wcM2NB8Clgr06zV3zoFfrt327ACbjcbW8HvTUnoQJ
         Nnkv68IxiOSYMI6e5308hNMSewYeO7QcV1Cg2t0HYKpyVDizl8XGsqEQfKOwTCUiOGc/
         kRew==
X-Forwarded-Encrypted: i=1; AJvYcCWd230dH6frUDMwzOVQnOcTNXj81b22Yq7+jDBKlxrGff9U17UhjDeO7m1gEelswzmZZ731/t4fcj90/x3Mvcug@vger.kernel.org
X-Gm-Message-State: AOJu0YykqVqpfF3NGDlueFLHOILV4pvGFFPXhLGfZ3vXESPlAfIRN9jC
	lKA0UvtaEAR8fJdyyKyYATBpwBC5dka8ppdbU9jMF3/sB5osLz2H41s3tfNkLExcvBJkOuSEVEP
	zheyj6k2aFQ==
X-Google-Smtp-Source: AGHT+IFEU0Ge3OyHwketfTl1l2kXLOptB8lTGAn62BI93wCkTMzUx4ghNN34AgBRlWNHycE+o4KU7eNO8/37
X-Received: from dlbqj18.prod.google.com ([2002:a05:7022:ec12:b0:120:5c35:c798])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fc0a:b0:11b:bf3f:5208
 with SMTP id a92af1059eb24-121f8ab6a1emr4896207c88.1.1767899494989; Thu, 08
 Jan 2026 11:11:34 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:35 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-6-irogers@google.com>
Subject: [PATCH v10 05/35] perf jevents: Add upc metric for uops per cycle for AMD
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

The metric adjusts for whether or not SMT is on.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index f51a044b8005..42e46b33334d 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -3,14 +3,26 @@
 import argparse
 import math
 import os
+from typing import Optional
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
-                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    JsonEncodeMetricGroupDescriptions, Literal, LoadEvents,
+                    Metric, MetricGroup, Select)
 
 # Global command line arguments.
 _args = None
-
+_zen_model: int = 1
 interval_sec = Event("duration_time")
+ins = Event("instructions")
+cycles = Event("cycles")
+# Number of CPU cycles scaled for SMT.
+smt_cycles = Select(cycles / 2, Literal("#smt_on"), cycles)
+
+
+def AmdUpc() -> Metric:
+    ops = Event("ex_ret_ops", "ex_ret_cops")
+    upc = d_ratio(ops, smt_cycles)
+    return Metric("lpm_upc", "Micro-ops retired per core cycle (higher is better)",
+                  upc, "uops/cycle")
 
 
 def Idle() -> Metric:
@@ -45,6 +57,7 @@ def Rapl() -> MetricGroup:
 
 def main() -> None:
     global _args
+    global _zen_model
 
     def dir_path(path: str) -> str:
         """Validate path is a directory for argparse."""
@@ -67,7 +80,10 @@ def main() -> None:
     directory = f"{_args.events_path}/x86/{_args.model}/"
     LoadEvents(directory)
 
+    _zen_model = int(_args.model[6:])
+
     all_metrics = MetricGroup("", [
+        AmdUpc(),
         Idle(),
         Rapl(),
     ])
-- 
2.52.0.457.g6b5491de43-goog

