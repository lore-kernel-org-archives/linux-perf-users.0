Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCF62942D
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395985; cv=none; b=tXhhkgnERZsXf2eS4ApFzdCIfAhE5xt4SVk+EfY4kxWbexzPU8SkDInpHczWPULIWxNuKPv/LCtGP9Xago7PijKsfZ4QwyuR3sTWy2vC3ggqSjHh3ymwjk5yHiCyhEzfivpiKRongT/lV0hO6lLf+bHLigZSW803SJkUu1ZTrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395985; c=relaxed/simple;
	bh=cCSe3xBYHq317mfPy7MagbKNpW1UoVS0ABuezkShy9Q=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XLIecPJoEiM6inUFz0zxheu3GMsxSHUu2wukcjXeG2ZR9se6XyWegW5+7VuftaTzw9VTFIu2qrzFi+pIRDbfQlozeXJxeVrIBNLqWZOUp2sG9q+kgCJxxUVfv8ck4xeM/qyUV01yvJxBFI7CIyz+8zih4Twc/h08jS2P7JxhwrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pStV3YOV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pStV3YOV"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a629e2121so11869347b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395983; x=1711000783; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+veiSuaqo+0WmGFGd8SW73u7DHqxbnCf8x6yupKtD1s=;
        b=pStV3YOVX8Jcbj3uaMoU5XRlXBHKihx9wOOx6KtDZgAYLOehiP8IPJG+GmxDAXKgbb
         Q6I/Dpp74X4KvDnin9qHeKZMRDhwdmgWMY6dXxZ6D/zZiNJjckk1CUA/AKCezp1bWrA5
         4yWBrasyqV9j9a+rlHVO9cuHT5HiGXOGXUjZ9rORXUjsXPMOVTukmg2HITF9TanZ8LYt
         jhVWfJtvLujFx/9TM/FcJ3UfQcv32d798xFTHFc5/tj18XoXMDfFrupb6NL6mwRvk5fn
         /xsUvfNuAAACgGvxWtstZivRgxtHagb8EPwPUq+NQM2bIZpfl2hBrhBxWu48XQUQU7/v
         VSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395983; x=1711000783;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+veiSuaqo+0WmGFGd8SW73u7DHqxbnCf8x6yupKtD1s=;
        b=ty9OTSUpIB5MkzkQSeCpaWnpFPp6Rd2lzULymZTx3hyDFHkXV+HoWW7bmfvxV4h94U
         TWYzevF8G/J46/tjZ9WId9BWlECKOkGZ84fteK9VV8gHvIYZmkC1Js8tgHZA2GKUMmwz
         2FV99GT7tc+n0mnFdUnBUIOXuyPpb0hfZ6rcAD+oKGqfCdAFyVUk/ztcdf1Hxqa1sY7q
         UbdwGmAklTd3B/DCLca6z7lsLwJcXbJOKvVBna1y1bFvh/N9Mz2KEh6YXBGQOSQYvkd/
         iRvLa1dPFFSQe/6tMzHQHc7rlCSFpQcEs/VBSXKl7NEcNCmpoFKt7TI+kJ+XSMU5NTJI
         h79w==
X-Forwarded-Encrypted: i=1; AJvYcCWfCdB1co5t0ZQihQ6e09Ywoer2WkO4/HzyYmEVFVe9RGdN/Wmko4IkO/WNSHDMMfLLPX9mTzvoqeQDllJk4rnR+DTXDJN8NgRuS/zLCuHsNA==
X-Gm-Message-State: AOJu0YzWgaEM3AIiiAXeBpb9Os+1JzpDX/F8UXeqF0Sy+GnLdPTCijuy
	H/14nUdyUpN0jszn3ttfKeQXpKciHuh6HZ4SCCzSZeVvA5V5YXp012Gn58GuX7MkH2xlmoscc+r
	c248cQg==
X-Google-Smtp-Source: AGHT+IEzFwG3kjeE10nJw0pr6EwNRZ5U8tke7krs3iomuop09QzxhoLt+T1Qb3x2zno97wzCFNTWUvdibRro
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2181:b0:dc7:49a9:6666 with SMTP
 id dl1-20020a056902218100b00dc749a96666mr255019ybb.3.1710395983180; Wed, 13
 Mar 2024 22:59:43 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:02 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 03/20] perf jevents: Add smi metric group for Intel models
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow duplicated metric to be dropped from json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f875eb844c78..f34b4230a4ee 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    MetricGroup, MetricRef, Select)
 import argparse
 import json
 import math
@@ -56,6 +56,24 @@ def Rapl() -> MetricGroup:
                      description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
+def Smi() -> MetricGroup:
+    aperf = Event('msr/aperf/')
+    cycles = Event('cycles')
+    smi_num = Event('msr/smi/')
+    smi_cycles = Select(Select((aperf - cycles) / aperf, smi_num > 0, 0),
+                        has_event(aperf),
+                        0)
+    return MetricGroup('smi', [
+        Metric('smi_num', 'Number of SMI interrupts.',
+               Select(smi_num, has_event(smi_num), 0), 'SMI#'),
+        # Note, the smi_cycles "Event" is really a reference to the metric.
+        Metric('smi_cycles',
+               'Percentage of cycles spent in System Management Interrupts. '
+               'Requires /sys/devices/cpu/freeze_on_smi to be 1.',
+               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
+    ], description = 'System Management Interrupt metrics')
+
+
 def main() -> None:
   global _args
 
@@ -81,6 +99,7 @@ def main() -> None:
   all_metrics = MetricGroup("", [
       Idle(),
       Rapl(),
+      Smi(),
   ])
 
 
-- 
2.44.0.278.ge034bb2e1d-goog

