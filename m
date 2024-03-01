Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C893A1C7
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318873; cv=none; b=uMRuj/QSg9MByNtoOzxjQdTmndUDsf3U1nun77WoxjsW8mTTr1ke+pc4lo9csQePHN9RcF44pE3tMS0MAf/jzLkAMGBco3+OpfIzubMhy154X/T8Bg/yiaikTX9dvxnKnumRKfUi2tDhRJJnA0leonMCewiPFX5cN0jwiGs31XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318873; c=relaxed/simple;
	bh=Dfpdo2YwplSQDWWpMc73Uzmy+I+y4UMFYX3EUMZzsvM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=a94qQvCl41scC26XVMImtrfoABsSAQgtBI3ElxpoK2guzL1EQ9mnACWcD6nYIl1rJXz7jlH3ZBSt3PgJjdCfq8pSIa16GIkKUNVTT0gZW8dnjSI9Me4Qwp1C0wa+MOHP2waPUQH1o/5fKd5Dk8oUG8CBazYEUcJXcuaQihCGr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P/lklG85; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/lklG85"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso4259713276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318871; x=1709923671; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1z+XJES0GLGr0Q8oaGDYo7B4O7AcfZJJPh1SyEgcrw=;
        b=P/lklG85DrBGjnJvJCtcGNEFpzfLaJUIxPTojlYtHk25zI5/skH/M+2+Kq8KB9Uo8l
         T6XMcL5z+eQOxZKBx0DGVZ/mo8mb5awbK6fKZfqyqwgBwCL6Bb+YXLi3UsyQnmNzhn/m
         yHLH+o7v4f1G3ThXg7VqYXxAjN1x3FsYxNDOEfraHFgwKrvlN07LQ0dvHb+GFnhUPxhg
         6e1+9BzYO1l1nem147r1x996ADOvDaZSkq1KUwcmoegCYhVB0N0k6knrgWrI6dnVXKRm
         7OFUkrMc27wuQ1u9R0Fm1o5qJdwrTPlITYSaWZqcLyzDJ4mBcZWwEReBAiao2R1gvvoo
         ZXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318871; x=1709923671;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1z+XJES0GLGr0Q8oaGDYo7B4O7AcfZJJPh1SyEgcrw=;
        b=j9Dlf3BImJgFKfMTBFgsSZ/hqsnJZTYGWFBxDIFEgyhlswVJ3kZx9/hbI5dW0NP8x3
         3GK+hUxJ8QpL90wSUiG3XGgJVKMqRSKq7NqOfW6aBpOjmks8LKXWx/8nJLeN3+rI9tXT
         c0ckrN6wZwrjmQCdIudMKdaT4mEHEIRN6nKlB8nNHM4C3MI5J2vq94MPDLrxGZvCCSlD
         PTwtx2rjFjOoq9fXVVE9LqMT4qKJAFad2gn9II24rAZVDCsOydWk2DVK6lglYZtIFMGq
         o7Mv9BLMfVQchW9V1sRLq+SBlISA6QTHS2kN1WD8g6Y+v9b6dxtY4pAPAgGwtzehE+0I
         D5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVp44t6T+PFlps+PS8mYgCLP+7890bNPoEXZCXdJaxl4+gn4tn4u809R7PM7QK/SdtyGYPrMoZqUibNC6mxvgypSZ3tcQ9Tj4IrFt59SdEWfg==
X-Gm-Message-State: AOJu0Ywq45MD/WyO616Ur1yBSgwbm5Hfmyh5KyqjB+0ULToa6t7lZzxh
	4rZ7BpdKgXRq9lqXGTEIsmDEnOeLquUpVbqyKeQVmnWJg8xJPTSV5rkhXQ+4vAuMVEcnb3MhEe8
	lsWjwVw==
X-Google-Smtp-Source: AGHT+IE7swfGJwI3V9dzGAzE/TRnoKRvinMgKdeoehfNQbwjNw+Yq8v26zjQO8zcLWZiVt3TQ2jWkWBGSWwS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:2690:0:b0:dbd:73bd:e55a with SMTP id
 m138-20020a252690000000b00dbd73bde55amr91844ybm.4.1709318871487; Fri, 01 Mar
 2024 10:47:51 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:27 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 02/12] perf jevents: Add idle metric for AMD zen models
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 4016ecee6464..fd3095cb5c1d 100755
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
@@ -19,6 +20,16 @@ all_metrics = MetricGroup("",[])
 
 interval_sec = Event("duration_time")
 
+def Idle() -> Metric:
+  cyc = Event("msr/mperf/")
+  tsc = Event("msr/tsc/")
+  low = max(tsc - cyc, 0)
+  return Metric(
+      "idle",
+      "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
+      d_ratio(low, tsc), "100%")
+
+
 def Rapl() -> MetricGroup:
   """Processor socket power consumption estimate.
 
@@ -39,6 +50,7 @@ def Rapl() -> MetricGroup:
                      description="Processor socket power consumption estimates")
 
 all_metrics = MetricGroup("", [
+    Idle(),
     Rapl(),
 ])
 
-- 
2.44.0.278.ge034bb2e1d-goog

