Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8FF3E485
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165915; cv=none; b=eoTPZ9kkO0h6iO9yzvfImheaYur6Jc3XtcsFkJUiC+Xst8ppH1PnJ6z0+Of9jnd0T2ubj4g3dJjVdbkmL4T4Twf1WmY0Ii8/B9m5XREDIM//PWAGDRxNHVB7O9eqbKo7t0wPiwna2F2ganRkihV9/pxyFAz56Wz0jqbk0Hh7WoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165915; c=relaxed/simple;
	bh=OmwxBjnIGvz+HpCZV0zi77V/88wRlOeFcpNY7K4ifsw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tp5WdOTgo80WuINC2zFWM2G0R71jzi21azvGFIZWb5y9HNuDj3JydjTgN454VsBjL5+OXoU0Zsd2+ViCW0aehCXBezW6XLz5thzdKjss3nqIPymCbh7jFl0mtAR9Y+C9oApJ8vyQoU8L5J/djh8gP5B5U6N9hQh4nv4w0sTfYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kU4+lA1v; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kU4+lA1v"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso637544276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165913; x=1709770713; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0JvchFYB4X0MvBleracqYs3OMeU4l9tJWCec7y6q3w=;
        b=kU4+lA1vHpZlDtSYyQVmEqdMYtzbTNAl9JAhc+YlQASrTBVwKHTrDpbRrDRvzkd1wa
         5m15EGPbVBtoxxaQolL5ls7vXYVOt5lyf7taw91lUTMd7bRN9/PjhnKC6sYb9SfOR7TS
         UpPOYIwwGN7+KlWO0liZAJyZ+Coxt64rYyNxFUYDQI78mcsmQS25tOrECNYq0Rc5u+/t
         R3LwjWQgVX5QajjMz1jS07+mbgVTi0cfLBz8Xx2P5pHO3QMeBccy0emf+Q/bpufeoMbW
         4KdsmNplZXb3Ec/vJEhmhQ0ajrMnf3axysXmdEebjbFGBtKRLDgB+vnH/LwHekB1kO2R
         es7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165913; x=1709770713;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0JvchFYB4X0MvBleracqYs3OMeU4l9tJWCec7y6q3w=;
        b=JEbSE2exrncpN+lcpl/IK12KqInMLeXQgITPv9BuGYGBBUxmWMo6a3eqk76i5Ro+go
         cPidwbZe1BJI9WMjrVgblRD7cvXYDehBnPXIjHgFewoZlk5Vd+rcVGLRRGToWuyyLLjI
         Pcj5aEs0o+Ha1vCIdPVLl11QxbDXKsGJlnXxTS2W4Vd5jUpEJHZdnN47+ioToFqtvDXV
         pJTevFEzOTFgNQvky9uBRqklSR/11p1aiqVTPHdc7pdBtvBO/URIt5wedvj1U7NF8uQF
         cNS1kyiGn/8/vD/BDeYNycIFC3sOTzw9vqpUKJyVLumTDyE+LfYWAsu9fVNJzbOzthR2
         5Wug==
X-Forwarded-Encrypted: i=1; AJvYcCX+gP6EqhwpuH8vL6ELIkB4eSOoSpMe3pdoTtGR8Ozt3kyC+XocPI6LepaGMkonRFbRsV6wHpSC7DCp3PDiwIBzpW04tkF1UuZ3XucC24KxjQ==
X-Gm-Message-State: AOJu0Yx3Sp3woXrbPf6OWjDXAKf0apa6T+BT840GpuP4wh4BojtOwA/U
	w46y1R1Bjf6dL+uPymEk5JYrv3QQzReak73MI8Nd0snowrFoXCmBqs9g3FpKUpFJJCt+JHILR5i
	NtIs7mQ==
X-Google-Smtp-Source: AGHT+IF4yyKMvNlhv6U8pRqNcLZNCYg3Z26k0Gc0xtubKv4Xv2n8sOabvsJGIRYNUOBQTrCaMmLreqpr4qjp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1244:b0:dc6:e20f:80cb with SMTP
 id t4-20020a056902124400b00dc6e20f80cbmr44028ybu.3.1709165913274; Wed, 28 Feb
 2024 16:18:33 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:49 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 04/20] perf jevents: Add tsx metric group for Intel models
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Andi Kleen <ak@linux.intel.com>, 
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

Allow duplicated metric to be dropped from json files.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 51 ++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 20c25d142f24..1096accea2aa 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -7,6 +7,7 @@ import argparse
 import json
 import math
 import os
+from typing import Optional
 
 parser = argparse.ArgumentParser(description="Intel perf json generator")
 parser.add_argument("-metricgroups", help="Generate metricgroups data", action='store_true')
@@ -77,10 +78,60 @@ def Smi() -> MetricGroup:
     ])
 
 
+def Tsx() -> Optional[MetricGroup]:
+    if args.model not in [
+        'alderlake',
+        'cascadelakex',
+        'icelake',
+        'icelakex',
+        'rocketlake',
+        'sapphirerapids',
+        'skylake',
+        'skylakex',
+        'tigerlake',
+    ]:
+        return None
+
+    pmu = "cpu_core" if args.model == "alderlake" else "cpu"
+    cycles = Event('cycles')
+    cycles_in_tx = Event(f'{pmu}/cycles\-t/')
+    transaction_start = Event(f'{pmu}/tx\-start/')
+    cycles_in_tx_cp = Event(f'{pmu}/cycles\-ct/')
+    metrics = [
+        Metric('tsx_transactional_cycles',
+                      'Percentage of cycles within a transaction region.',
+                      Select(cycles_in_tx / cycles, has_event(cycles_in_tx), 0),
+                      '100%'),
+        Metric('tsx_aborted_cycles', 'Percentage of cycles in aborted transactions.',
+                      Select(max(cycles_in_tx - cycles_in_tx_cp, 0) / cycles,
+                                    has_event(cycles_in_tx),
+                                    0),
+                      '100%'),
+        Metric('tsx_cycles_per_transaction',
+                      'Number of cycles within a transaction divided by the number of transactions.',
+                      Select(cycles_in_tx / transaction_start,
+                                    has_event(cycles_in_tx),
+                                    0),
+                      "cycles / transaction"),
+    ]
+    if args.model != 'sapphirerapids':
+        elision_start = Event(f'{pmu}/el\-start/')
+        metrics += [
+            Metric('tsx_cycles_per_elision',
+                          'Number of cycles within a transaction divided by the number of elisions.',
+                          Select(cycles_in_tx / elision_start,
+                                        has_event(elision_start),
+                                        0),
+                          "cycles / elision"),
+        ]
+    return MetricGroup('transaction', metrics)
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
     Smi(),
+    Tsx(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog

