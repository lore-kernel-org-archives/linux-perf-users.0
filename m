Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBEF30ACE7
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004088; cv=none; b=aR/NMwe6MidBkh2x+DKgjfLH7FFG85i6r6SuTk+6ey61VhB1JE5cx5Qbkv2UPXBlQiABUfF9Zl97VfJxXDnRUXdqT7kw7HjVWG12PKGhDmPiLkzgQn/lbIn2jJj5qQ5IFD4SLmnRiOWyWxrmlk6CrrRXNzzeDbsp0FG5RcvZ2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004088; c=relaxed/simple;
	bh=B8lkbetWKiGNIsi91sd8YrgblwbzZ9lrZIRvSGABaSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XW350bknPcwUamPzNX4JEHbumRUtccXbAjqFLQHglY+uTjgkU5RM6kqR7atLtt8R5rH0rzBO1eu8DJntIHx1aKbViuG1os55QyR9DU13fM4QlHcO2vMjJnO7B6c8sQVNsuYLpgIXRMPn2HEnkeChLzyxejys1D8A/AaL7pWNp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/3YZ651; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/3YZ651"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29845b18d1aso4340255ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004087; x=1763608887; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GojlKXXeIlWC1RlOdbmNF9Co4cMdGfhXPPYbUElx0PE=;
        b=l/3YZ651OWUXlfGPzSFHq5kDMDijdeiG2WQkkYS0bp7zAe7xVtH75bpzbDZC9LvzVY
         Rm4niXI+n4dm99wil+AATajAowXSfTjRf29NfALKdVYOf9fpwOumHcLe4aAyGVNpPSYp
         AaPGFOm+l/Af1tcfb5p9gVD0bBlM4BWVj+NKkE3lkwt6OyeBQGGw5XULNXJ/nmGdZq8E
         30VVAMzf1r63WNED6FXtQc8jJEyOxFBkrDWgloYQlbDOV9VSvulqKzPZL8byjTNgkopB
         mPu5CeucO2M65gzLHK7iTacQupWzvTkdpjCDz1GQCfn0QcCTRkQGe08p5KFjXdVUr01s
         yyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004087; x=1763608887;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GojlKXXeIlWC1RlOdbmNF9Co4cMdGfhXPPYbUElx0PE=;
        b=YFLSiOy2vdQlH27/QIqwKpl92btNBZ7zk8l3gK+1ETaDSTKcYs3BP/U1WwYkXpEHhg
         +IxxJPJx2sCN+AKA9haWjSkuVSAN6DOCO4ucba679sr3lUXCPe2hqQwN1qbSQ2iihFKP
         C5iMpQfqnW+iunHU47I+qzPhD2yiGm5vksEc73716cDrqPsaMoHr67UGB0Z1ks6YAlwO
         f27mn4s3rOilkGVb8EYfrC7bICIajjMXlcBMpICnHYGGBf8n5cjOM0yPQiPAgAcU3MAn
         GO9UJ3p18+U1aO7VDiUcQ4gy/YeXHF1/6XDnphtq15tz0e7jdzhokHUyQbOhXwGTuoNF
         WAxg==
X-Forwarded-Encrypted: i=1; AJvYcCWW7FBryAo8VMtOanhIOWPt1J6eoUg0yI6zA31Rg6ZeejhimeS9lrhVbu83ULFxXM+/IlmZlkwmgOZ32xyYjGwr@vger.kernel.org
X-Gm-Message-State: AOJu0YzqY4c0QFkZo+5ds8jzJGP50EtO820P8wPDflxsmtwu3uFfg1pF
	4x4g8QV0L4wGKuWilWbuuw1np/1q08ZpkxIZRaA8Hu35F/ckGFf+nv1EWeMW7zuJpkJrA8RV+Zg
	/JaIgYGeIxQ==
X-Google-Smtp-Source: AGHT+IHsv0wCUr4pcyK7ZKuQfbUgkUGpid5htJyGlM0w6i46UINI2OHaBEkE4F63Sjg9i6YhTCkUksnrBVuN
X-Received: from dlbbs33.prod.google.com ([2002:a05:7022:921:b0:119:78ff:fe12])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b8b:b0:294:f711:baa
 with SMTP id d9443c01a7336-2984ed2b6e3mr66202765ad.2.1763004086743; Wed, 12
 Nov 2025 19:21:26 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:05 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-18-irogers@google.com>
Subject: [PATCH v8 17/52] perf jevents: Add upc metric for uops per cycle for AMD
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
2.51.2.1041.gc1ab5b90ca-goog

