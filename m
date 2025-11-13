Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F63081B4
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004087; cv=none; b=rTbpH39zErB1Xkc5pfVnadkETn9aArWQBQvjvr4SDtl7SGUXpE7shO9SJDrWFXytnkXFg7ZGGxuzr/0zLq104vKNnO/uHvyfFhDOuPGtVgfmwtRRMBHgztsbi2+dmYlvgfmWL7DvRVN2pkk+PWF0unpoe4VlnfI6FLw0ZRd9e+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004087; c=relaxed/simple;
	bh=tPaHLz6/sx/PNrouhhyClDy1OLIFmrT7WhjKHR7NKag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=c/NeSyjwXBQlturzrq05OoJ2IAxHEm19jGmH8bhCgO+yX6z09BUALn5vyEdmOkeeeVvCygL2uTUIJyrbKCg3lxURtAKFAtWFbO3v4TboiXBoNE4wbuWQZRTJmwO4WOoAtfvSRTCSkykgLzgmtUO5aWLr1LeQFcb8OzXvLe9B2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uk02rAYq; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uk02rAYq"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b98e6ff908aso895059a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004085; x=1763608885; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsMM9QEsECyOcBMHtXCKN3W3Gqp+i9lInQz4MeIZgto=;
        b=uk02rAYqTV/oLM8BV565k+ESpMtIjEscnr53EmHpB7IcIwkgu2Ahz5KqoK7KpvYf7I
         2QlI+hxKrrluSRit9aLlKmTm0GAwcVAQM2iB8kw4IM/DrwJu/Y3RiRgyLnowHrSxK/lm
         KunvPdrSMNA/J+IPXciTrk9+UX+NX6nM9E2IRZq+2JHj94ZdyM0ZFDQOXbyfHgnQTjiL
         57J2uT0sbO2SkaGBOE7hsP2avzMXyD4fJbh42OLZSikldT9tyuql81hsMAzUDC6Sh5bB
         fcZ9Nok4e6y0Cq85ob2ZxYnjvq1kq0eSdHf4tz9AGrfUJ6SUUktoT/Fa7zHgWEaqqU1B
         wNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004085; x=1763608885;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsMM9QEsECyOcBMHtXCKN3W3Gqp+i9lInQz4MeIZgto=;
        b=k/+MTWbMYkvuKRgFm6bkCPz7a02fGqYR6dZzCmSC2DdU3uumIjeNrCOHpDTCUhCaT8
         1Wk8ISwCxAflA9CH15bVnEs3V/2ssRa1J1/5SU1G66Rm+eHoZZU14h6wTjPADYops4gG
         0uMVFiRxG9347eNupSsi8WEZgJktoVLzBXGqQSJouvQwWXrNr2P1ItZ2HY/yUctUuksq
         0z8n8Th0mZNM84TuSA9RSBW9fZ/6XzQXKMAmtHmbznUTUiTUfiUT3PHz7/96gcl5z+7o
         aMd5y4wdoK+3aL2YuYPqNG2iSlDXPPboCBBqwwvsAxrwQrDZWPz39xu2Vr5hhjcrcqAN
         v1Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVXcjLf0acyPXnYBLLWArQmbT9p71HfGqGFMy4XdrrzZBM28UUlhd8M1XVA2/jMaqHrzZ6zdV5/UTuCg2T+18Si@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6GGsOikI3t+zoXnM1Ux/GAfS6P3iwmB3WatOC8r/WAn89INij
	s8KxHMynyY4qBSWj9rPl455MAuoJJ1wGdncLkdFCQEtwvXjj/R8ZQOKHT0osMOXRLP9PvSzIsLf
	iLiJFzzgMoA==
X-Google-Smtp-Source: AGHT+IES3t7VXixdqeqHO/Do+uvYp9CnzR3bamBcvHkXUs5IlqTBbD1sPeuUjAt8+AMfG8wD09hHje3Ql05G
X-Received: from dyx20.prod.google.com ([2002:a05:693c:8214:b0:2a4:6312:d053])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1611:b0:33f:9581:5d2f
 with SMTP id adf61e73a8af0-3590897fcd7mr7693689637.3.1763004085140; Wed, 12
 Nov 2025 19:21:25 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:04 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-17-irogers@google.com>
Subject: [PATCH v8 16/52] perf jevents: Add idle metric for AMD zen models
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
---
 tools/perf/pmu-events/amd_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index b6cdeb4f09fe..f51a044b8005 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -3,8 +3,9 @@
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
@@ -12,6 +13,16 @@ _args = None
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
     """Processor socket power consumption estimate.
 
@@ -57,6 +68,7 @@ def main() -> None:
     LoadEvents(directory)
 
     all_metrics = MetricGroup("", [
+        Idle(),
         Rapl(),
     ])
 
-- 
2.51.2.1041.gc1ab5b90ca-goog

