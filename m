Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E674C9D
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960860; cv=none; b=UoOfqJiMQ2wjuLbYksSFupLB/gLpwgg/BgPIY8OmzHzCaEtezMePGgy1odFqoPUA3dsFm1PHOCtsIbDx6y9csb/s3FQ5YFdjQpokTfEiMHJpVal+DlA7mIvQOz6iOQNbQzhfAeZPYxziFj1YbaRyNBoexWMLVKhacUvnoSXLdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960860; c=relaxed/simple;
	bh=oLI94Iflh8uQLTd7+P8OE3V+4yfuhYGVWELnDfXt3g8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DGQnrvds84zVONu6HlEHwuGGOoBx3AFf+O8hjJCNCZwjKBiCgds5QOTJtS1g9iiEZ4hswM5KUDbFs8UbcVyab4gO9ucyVtsLle12f5k3AVqd5dNJuZpoVt8wwzLG+NsQTx3+r+ps6POtdf89jSJ6Tl9oURzCjW9lWlqDt1EBR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YL9j4OSs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YL9j4OSs"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47174bdce2so413855a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960858; x=1757565658; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9uD2p0/mQh6PpuYl7n23G7juh2S4LC/aI0ScmrOZgw=;
        b=YL9j4OSsUqi/W4Flmjxhl76CtD9oFSE1Fx8olVne3/8C2zomX3o7XQacTEGJf39YBG
         B5ls6j1qZnAoUmzdO4EuW1QngQbSliY0KgZm5trZR8ULQoLpRW+xZ2qDuj2dw9ofOH2V
         9y5UR6oKT1eWPbv2Nixn3GRjjGWZK+j3JSj4ICFPYjT7mplALuSpKmBFSChThhkfIyW3
         1YrG4kD5mStus8J8fIMMarnq2Xpz+4GZZDeAiNlCk94PRoYfnDrzkB9PSlbh+NQauV3w
         YwRqJ4fyTX802HyMMx19HTby1sRo6gXW/z4dAERUdbz2Ow13SosoTxtDJ8UrqgzcfoM8
         wZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960858; x=1757565658;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z9uD2p0/mQh6PpuYl7n23G7juh2S4LC/aI0ScmrOZgw=;
        b=CLdfnbIiguSHVawXK5CZvlky1C9oFYBSgtGMpok2iuBQLdiA3M+EiJYZpU/2eyTlRV
         HKgrOekNCG65LG349EBJ0teYu4weZTbKoJY/2IdfGrqA/MkOwnXk4yjBGittfwaV/DHB
         U89e6EPesvqgVtr8LKjDQdCQsfdCfiQRjDvwsmUSnNh+xdstfddb3KxZf3L5R9k029SR
         VLumYNeR//l5wGZr/zOxdnsay2s2X7ALai/K+GK1JHoN0+Q/VxJ2r0JVV/wyAyb9vzpq
         prN0Mf9/BhKJNUFCEBNQGIyZo7fjR6/znXc5i8vegnW5oJ966WMFxSslLjmyCscFi8MX
         tEcw==
X-Forwarded-Encrypted: i=1; AJvYcCXNmeJ6i8keX+liKJb/fqb1TwU90IjDbXUD84M1U2pfUBMhWjGOYYszRCEptQy9IVU0dAzbimlVaOLozwFiF6jH@vger.kernel.org
X-Gm-Message-State: AOJu0YyIL94FFnQgHRtg6kesZh8oSwYXxmC8nRrLhlkgL2xtQ2scq+PN
	pE88TmnZ3I/1W6GiDicueFllSnEjWVyovTRfAIDp/lufj85tYQSY4GoK3ybT4uKucm9RXV6E6c4
	9opCnFyQzEw==
X-Google-Smtp-Source: AGHT+IEZTNzny8nCnS/OoFp5Js4cker1rmBa0hKUkGPm1w6KpFh0BNQa3Ut8xaPyvOn1DqmnqyOj7ZUYaER7
X-Received: from pjh12.prod.google.com ([2002:a17:90b:3f8c:b0:32b:65c6:661a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9183:b0:240:116b:cc41
 with SMTP id adf61e73a8af0-243d6e009damr23505558637.16.1756960858017; Wed, 03
 Sep 2025 21:40:58 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:36 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-3-irogers@google.com>
Subject: [PATCH v6 02/13] perf jevents: Add idle metric for AMD zen models
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 6fff81cd4db3..335e8a7e0537 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
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
@@ -12,6 +13,16 @@ _args = None
 
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
   """Processor socket power consumption estimate.
 
@@ -55,6 +66,7 @@ def main() -> None:
   LoadEvents(directory)
 
   all_metrics = MetricGroup("", [
+      Idle(),
       Rapl(),
   ])
 
-- 
2.51.0.338.gd7d06c2dae-goog

