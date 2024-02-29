Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B02E63B
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165913; cv=none; b=l7ycK/VOdBBs28E8MZrOmcHnTxa6MAlB+zyxxyHn7EVDQUT+BiCtY2gfquZrUsxo+dT6AZbgEhm7rRXd0k/PEsGVlD1/BOezQwXmjA5J3tJDqiaJCEZurkrwsuh3H3n3kRBJbyUuA9M4jQuWQDv6sCvgFfyttz2ZsoSnLfWAfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165913; c=relaxed/simple;
	bh=HP0z9zpsAm/qTeZtLVT9exF49dLNPcCcFWKRdfJf6nA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qDi3zdGvvq0Lfa4aZMhDCMTmYi45ylKRbZe9QYITgn3ktGNv5bot9/fsXGE54mN9BZ3yT6Z25hFU8c/V4NNkJBjVqXsWhudP+nPb/gZOjZF1Dg5JmH/BtIzSdcivDw6wVXmk14ZCNCuxyL8srSrREsYUEPT2FHBYSiMwuZRNjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0DKo0cfc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0DKo0cfc"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6093c69afafso5830457b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165911; x=1709770711; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSyxWL9CUFX3fE6recAd0yV0Q+Es3D3sjDkm1nLuaoo=;
        b=0DKo0cfcYcLlMxdtDJlIhQjM0JdBLbm+JXZENN+2tKejdWX1G7fxC3qGsvv/0o9QfY
         Kq6wJqvoWwfj7anM2JiTkQ5H/be0aWKSpXJ6TNqhnbatjobhcx2Sg9IvfRzcitJ2oVU2
         bJ4ZUSVPWwBjrzOmZmFThh5pDkVBDAP8pDm0hBq5NIJaBuhAggkD/bJnKPnJpKhqmrbY
         hQluloJt+DHG2MUG5XhJJ1IK+TfO8xrYvOiABGzPJ8MruRpNsYpUEpMVBb8SSx8imRRP
         T2GyKNxhhIqZ8+BgUsACa7zX5mroqqVkS3ouudEN5f6QtlgkvbTQ2hMMEIV44mDu7mko
         fCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165911; x=1709770711;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSyxWL9CUFX3fE6recAd0yV0Q+Es3D3sjDkm1nLuaoo=;
        b=ls/eqYqA5qOVenU7Rm8cb9G4TuDGdHTza3NkMKtsg73MlCclDY2T9PKnjmSUmFv9wq
         fw5AtnQ+JTFmH31CgExZoAcPT0MPvRT8/7kldL2PZVbvzJDM6QzBpvzGmYliKbI5M0bA
         r9MUQX0ZgOC8CrAAWMj+vbAE3kX9Jg61V1ULq/yLIO970YXcSw7wSJDWbDIppl4vF31w
         +dUx1nt50KgFZFgeyDHonhQc4kXrtqZl7xNKu8tFyAcRevsOCOVngfHix3xTzkxVAYbu
         PF5Vy1xJLWg6AiN26Oybagl/vVBdUFzeLn6yvUkk5n0IFVYOuenfWa6Zc9+LaznA5pIi
         BZtg==
X-Forwarded-Encrypted: i=1; AJvYcCUBcN+UosHw3SFAPrSdPVbeFRUKv7D8HVIUFFrS4qDIyYYPAn6kPCm3xL5agdZnkMg25BXo0/9cmmBDj0ni1GCUyZ3NC3MzQpzthWv94mp5FA==
X-Gm-Message-State: AOJu0YzJv91mwMBn6bNBQfgNFRN2FRyQUU2rtdQvjp7ZktIb+M1V4A5T
	EdT9fDgxDe5ktaZEkHyDeLTVgnAGpeWTBzem4189nJdocfrFd+e7QSzH/y8mmF6mktoA21qOD65
	8D1ReRw==
X-Google-Smtp-Source: AGHT+IGkLWovybGk6gwh+A1P85UnzlqVNysPtM89sVktgUn5ygdnsQY6ps7QDV7yq7flJSk6HvCEYq3tHXLQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1885:b0:dc6:b768:2994 with SMTP
 id cj5-20020a056902188500b00dc6b7682994mr43238ybb.0.1709165911067; Wed, 28
 Feb 2024 16:18:31 -0800 (PST)
Date: Wed, 28 Feb 2024 16:17:48 -0800
In-Reply-To: <20240229001806.4158429-1-irogers@google.com>
Message-Id: <20240229001806.4158429-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001806.4158429-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 03/20] perf jevents: Add smi metric group for Intel models
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
 tools/perf/pmu-events/intel_metrics.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 46866a25b166..20c25d142f24 100755
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
@@ -62,9 +62,25 @@ def Rapl() -> MetricGroup:
                      description="Processor socket power consumption estimates")
 
 
+def Smi() -> MetricGroup:
+    aperf = Event('msr/aperf/')
+    cycles = Event('cycles')
+    smi_num = Event('msr/smi/')
+    smi_cycles = Select((aperf - cycles) / aperf, smi_num > 0, 0)
+    return MetricGroup('smi', [
+        Metric('smi_num', 'Number of SMI interrupts.',
+               smi_num, 'SMI#'),
+        # Note, the smi_cycles "Event" is really a reference to the metric.
+        Metric('smi_cycles',
+               'Percentage of cycles spent in System Management Interrupts.',
+               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
+    ])
+
+
 all_metrics = MetricGroup("", [
     Idle(),
     Rapl(),
+    Smi(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog

