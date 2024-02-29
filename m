Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C71E538
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165750; cv=none; b=VPmJtiEqZvF5bHxQ/BsmHxu6+aiJaOIeCrDTs65sJPu6GttLmUUJ3MWT3lOSqBa8q0dICLh6RRMOaj6utTOaJTyAIbChjPRSEciymWx2Je29rVmaOhTUcS408s/Q8mA3UNHLkSkNPJZ41+LHYg5BgWKcetjsikY59nHZuTnOFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165750; c=relaxed/simple;
	bh=Dfpdo2YwplSQDWWpMc73Uzmy+I+y4UMFYX3EUMZzsvM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=B3aQRkh6yq52uKdVZZ7TtRl/lOa/Wh0L5B4zFJCbj0xUenXpNMdh8kW6RxiSxzgXIYBDcn78TsnlKzJ03EvhaBzCBhn+L0U0wQkOlSr3yBdSNPvYH8DyeDHtR+F4OpsMg8qtcxmWPnCllVH/1hH8ll/DAvJt4oQalsgVvVyl6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1BLPzBn8; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1BLPzBn8"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso6397867b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165747; x=1709770547; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R1z+XJES0GLGr0Q8oaGDYo7B4O7AcfZJJPh1SyEgcrw=;
        b=1BLPzBn89W0Tdh3j9cdOTO/vJxleAcibZR2pwDCEc3w7FJEci1cEqUW4A4vaqVm0h6
         dBNXFhyhMgcGeV20wGtNfnuNdEBLENpXkQ97/sorr8IYcvKRyXj7H2Cxr+1KjpdBUABS
         NVYkXl9LlD9cAqBVkdUqbyo5pnxtwTn7cXKmuqPobO4J7DaCGUBYWxafTIWXn5GW3kAs
         J1UYAIpKs4fB73cs3y+5wy5Jyw2Q84D8RfDxX0Z575hcvliI7t20GxQVoXUHwpTbej4D
         ucyNOr/rtSYZTgZhdkjPj8FoDqcHkANMrxug3uUcz2s6QXF53S2MaKnP4viceufBmv0s
         xDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165747; x=1709770547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1z+XJES0GLGr0Q8oaGDYo7B4O7AcfZJJPh1SyEgcrw=;
        b=T6yn3E385mUExl3qBQZChMHm/U8LAIyYdlYUu8SHX3pjC0YoMVENWdZFDEj5jSRo2j
         ik7En3UlX9HCXYaYXAd/j1kdPWx5JdJ7jUGHQUQWw4dbVzZeF7sSTGctAFsdaylGaSFa
         4aBsNef5LImpbdWasrax4exfOcGyr8rEGDvS1pWg70evGN/u6XcjG6knctYk0tvnrj00
         Dwu6iyIZDx8pDXDpGzOrsXhOus2hpYYhRSyahiykh77qUmviY3VLilb3JNXIlGcfxuSw
         W7qs4j6TNossqWfhsmxLOyK7EOLa6nPmq3USKig5gW0SzbpVai0L0exlAdlHEO+8sh/R
         IhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9I9Jy12esaLOU8Qv4sLxYHJFQtMqSbcV5YttOo+uuUEoHG73qby8IOj+NJMqtpT5EdU+DaY0t/RXuhfIujgIo9wKYfUe68tBwn+y9aAXGbQ==
X-Gm-Message-State: AOJu0YzAnbUSlqaMglDllbK+YqO6XkKbr20q0SSvn/SngvzOIOEScdaZ
	FiacKPK7+hrEFHC5fma56aStkRqEYUFoM1Qzww044EFwboCRD7XzfgDjXvcUPUdoGEy0vo0AQcH
	gtXUtfQ==
X-Google-Smtp-Source: AGHT+IGZ2G5HVElLXvbFoGXcebpq9RsE79E/PZGstTBYxPQKg/pbonCsSFVPw3r4QeMKxfTeLw7P4boJe3U/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:3505:b0:609:343e:db43 with SMTP
 id fq5-20020a05690c350500b00609343edb43mr117344ywb.5.1709165747562; Wed, 28
 Feb 2024 16:15:47 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:26 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 02/13] perf jevents: Add idle metric for AMD zen models
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

