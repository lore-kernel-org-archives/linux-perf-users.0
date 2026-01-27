Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C0329C5F
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539537; cv=none; b=kY1pQ3XQKw2Xgm4+G5vjRJlbMBT8m/A7PIQcmRJE7lEuIm6bnEzM5ii/xZXUYny2sjLBn51UshF5Morf5MlR8XqgOSXqqfX14lQ7/QtnDKY2rrPhy2ylM/0vAJgSblzlWSbPflMlsRFEhgcvxNomYCUumcH5JzeuVchclnh3eak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539537; c=relaxed/simple;
	bh=sYwyZW0LBQ597YLyTQ69dNu9phNlPd6GGL+UFrt/Z8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Q7MMVIai60Xx+IFs0dqTl5PyoswcrFYR9pVIkCtSFK7GFd9xQ2keiJ5Q3Xzk+x6FmlaP0df5DcEP//UPbNGZKt7oc27SdOjNR97mmU/DQMJjoCKAlmogsbhqJSLgGqYSUkEzpw0rhW8Nw/t8YYsJgy7qz3UD0okXKzpiyxABRL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahzeF/SO; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahzeF/SO"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b71c5826fbso6470349eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539536; x=1770144336; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xiZgUA9BZXnU+zboVf8da2/7HRlOa+405JXsBRB3eM=;
        b=ahzeF/SOLyKd6UHNDcRrRNmqpuQ/Z7bvgJfUM0lCO44PepWK5OkgDr8xFBoJG1G72W
         v5g2/f1YLRsfucPWPScFOQdMkOMCTk/LCgwl8XDt2KCyvOeyhPfog03y2yvyHGgfdQos
         SIQhqr2BG4R5fiNNXxCxevXMb7vfJAYzEZsQANMhcQy4F2GFWSc194t6rHWNvd+V17nz
         Ccqan1bdFcOIMhusXLu9N+f5yqTonxrhfAqxoPIVXp1kE1L2knBJogr1St0f9JbT7g49
         dOUZyAahBNYAGwiJxGnMI8nU1BSwt+2ZC/ryErz0wlHprht17F167Z38xzn/0k/J81id
         L9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539536; x=1770144336;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5xiZgUA9BZXnU+zboVf8da2/7HRlOa+405JXsBRB3eM=;
        b=UYPh1rFMYmk73C4nqyP/9QnKXtEc410fiNPBpr14zrCGAjlxNyUE1wO74i3JYPn4kg
         DNU/RgJiRAB3RsYB6BvNRIrtyisixghoafyO/vFAdS5qKd4XgQRMCETykU7xf+BdAVB/
         a3syYfKelSLlVPVUzlTxN2Fw2RZ5Ln5qaGmHVgd9ipP+vA2YKAhkY02c3WImwpocfsQY
         S7el6oHmsAlMwRvLWgVZPrmKig80V2dS0F7ZfBa8sDJ8t1rNrI3j8SSY1UQppT0MwrAZ
         Fd0vy9jvR+vf85+CbhDdbvp/vBb1YgAt47C/+nhkbVwTxY0SyhhdInbt9B8d1+U8N2hv
         ZCCA==
X-Forwarded-Encrypted: i=1; AJvYcCVEwiHOWWs2fqitRGIedy6PWl8MmCBTWo/M/4dEKkdtz76jPIETTBP+C1ujmMklish6t/ELffOYsWzttFMp132R@vger.kernel.org
X-Gm-Message-State: AOJu0YzOnJioIZ8MCJzqUIQZ8Y4zg9Z++lwrGeyhHn61dnbLzBBP/zsi
	NI7GxluDwrxZkwBVJTp59zw0nP5eDED6vnhTml3ori6EHpIr7smnS083+hZeNc72AoaX9NYaQxn
	rc8KqpmW2gA==
X-Received: from dycqw12-n2.prod.google.com ([2002:a05:7300:c00c:20b0:2b7:96fd:3374])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ac90:b0:2a4:3594:72ed
 with SMTP id 5a478bee46e88-2b78d9d6c90mr1415898eec.28.1769539535565; Tue, 27
 Jan 2026 10:45:35 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:36 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-6-irogers@google.com>
Subject: [PATCH v11 05/35] perf jevents: Add upc metric for uops per cycle for AMD
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

