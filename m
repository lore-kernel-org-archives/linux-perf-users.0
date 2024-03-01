Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523C39AF4
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318871; cv=none; b=T6481gOTG5/dLaYP3tqncDX9Kp/G1MOANXHYyAdmd0FmJMBi1SaMrcY6ldOSTSDWF3kwzn89YNWSBS5Rbhvn0wo+u+g4N8pQ7ijTyT5RTspjOLlLEFhvibjaSDPE3bFYiQOVKVjlm4HkTb+gzRpD/M72ZUMBiZaXOHFqbjBkF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318871; c=relaxed/simple;
	bh=RzPNAkcYFaWtPD0d/orbD+ZkcQxuwvwqzQzOuKyN1IE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eSrb+hxAde04YLPmqAhP72AK5Z/jVz8zs+RSUe/dsBys92MpXr+Ww1113vxK+48tiM2sjFEXaHNaDoD1L+/ZmwlDep9WyRLpEjFHoEKGjOV/X0QzDikBXO1XG4qVaS6uTEsTuo2DG8yrk1pp3CcwiK5t02kB4Hs/63pReIZwUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Sixqs21; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Sixqs21"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-607e613a1baso43882787b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318869; x=1709923669; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pr4WIv++H0HDAnrGFLxDjHsCZ1ntGDE7FfUCE5Wa1h4=;
        b=1Sixqs21LI2Q8+b0hz22jeQsPK1Pyp9lTx6foX7/mvlu6EFagVWgAQEuXAyZ0XCcqG
         ZcwV+01ok3ktnDlZDOyFjV6Xxsd4mZDTwY5OzLL2pdeqv6RgLO+arZ+OE+PxvULqgK8q
         t6KjhC9HldfqmksE9Ago7BrxJ3Xn9r9GTis+S6+8iTJyt7gieellQSWgzbzNHZ7gYZo2
         FnKX++BZL/NCfWKKxjo1yBglhKwcbxeu0PQj+WR7alTlaXYi8x5ZpAf4/0L5yIsLdtL/
         aFyAQ06PiVeKpwkjAnBnF3FNsWGpExPKauxuT/yjiJgkKRGT13PyLb2JWH41SAnZ1M3i
         ebJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318869; x=1709923669;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pr4WIv++H0HDAnrGFLxDjHsCZ1ntGDE7FfUCE5Wa1h4=;
        b=B26RmxPz8s3qBXMLs7I3gzvHNpj2wrPEyB59pmTHy2g/mBKtwmAaoV0ckWIezhrcfs
         1pya++rRscrtYkvt85ul9r9fCP06mogJ6I0e+EbZuTCP9jiRWO3D00BcOMc4Wz2Z1ZrP
         3u82fcwKMRQS/4auBxNVoCQ3M/C2ncprhleKe4S/Lr9Bt2yMPv6yp2HsUgoo40HWthbH
         ihiZjVA7TBx96rs4carcY7dNv70NWKUAhP//UGDisnFPnFwAuGNoAVGxPbNf/RcsXlET
         ZTOh6J68z0mJbBH6J5kdkHg0J9fHalEnwFsZiVqy8rt9HdwKFqgUen9iqWiAPvvJKuS0
         IFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEoT9BXw6m1YZu+v7kGombQM0BhhmU1HI4voWxsLcTSsUxvf9zOeycKySKHR0XPRZQ8qU+EMp4OQn3TJ8fgKh3YUVd1mCly731LQenvtiOtw==
X-Gm-Message-State: AOJu0Yw1iwSV6T0qRcomBY7Ls9xpn6WCjY627KedLSimKtYqLRilM+GB
	KzrAvxCl29wq7WM2SzIsT2/KT8GLPEvID3RjXznY5u5tgnjEq1EUYAwf+bp98/MW1Otc/XZA43x
	7xL/LNg==
X-Google-Smtp-Source: AGHT+IFm0q/+8fcaHJsyvMKBQbXB7wGuaoK+1iVffALN1FvhwatbmfRhWbsjMoCKbxv+o3p2hxkXyZpnsI7s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:2688:0:b0:dc6:eea0:1578 with SMTP id
 m130-20020a252688000000b00dc6eea01578mr531960ybm.13.1709318868700; Fri, 01
 Mar 2024 10:47:48 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:26 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 01/12] perf jevents: Add RAPL event metric for AMD zen models
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

Add power per second metrics based on RAPL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 30 ++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 227f9b98c016..4016ecee6464 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -1,9 +1,10 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
-from metric import (JsonEncodeMetric, JsonEncodeMetricGroupDescriptions, LoadEvents,
-                    MetricGroup)
+from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
+                    LoadEvents, Metric, MetricGroup, Select)
 import argparse
 import json
+import math
 import os
 
 parser = argparse.ArgumentParser(description="AMD perf json generator")
@@ -16,6 +17,31 @@ LoadEvents(directory)
 
 all_metrics = MetricGroup("",[])
 
+interval_sec = Event("duration_time")
+
+def Rapl() -> MetricGroup:
+  """Processor socket power consumption estimate.
+
+  Use events from the running average power limit (RAPL) driver.
+  """
+  # Watts = joules/second
+  # Currently only energy-pkg is supported by AMD:
+  # https://lore.kernel.org/lkml/20220105185659.643355-1-eranian@google.com/
+  pkg = Event("power/energy\-pkg/")
+  cond_pkg = Select(pkg, has_event(pkg), math.nan)
+  scale = 2.3283064365386962890625e-10
+  metrics = [
+      Metric("cpu_power_pkg", "",
+             d_ratio(cond_pkg * scale, interval_sec), "Watts"),
+  ]
+
+  return MetricGroup("cpu_power", metrics,
+                     description="Processor socket power consumption estimates")
+
+all_metrics = MetricGroup("", [
+    Rapl(),
+])
+
 if args.metricgroups:
   print(JsonEncodeMetricGroupDescriptions(all_metrics))
 else:
-- 
2.44.0.278.ge034bb2e1d-goog

