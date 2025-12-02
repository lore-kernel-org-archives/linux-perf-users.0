Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF57E2DC784
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698005; cv=none; b=skFO816EC4KUNYrFc9IcXQuhcfug4rosOeoKNPZoeRv/t1y5c71TNBXeLluZJlG/495U1jNVCIHYARmMECFRT0+6j1kHLB5Eaew/UkTe9ZWxPyMKhLBn8DJj3yZoyT5CgooOoyHCHesEx/NoPqAn2Qiq2IZtCctYETgs343xiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698005; c=relaxed/simple;
	bh=nQD6YjF1A+Gidqbm6uH/d/x35ugs3Qa7WsbxftdnyMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=NE/jq+olrYKYBy5IhHVf2Kf8Tw10u2oXagoR5fqhMBf+E0qqCgGu8dU9bzbcy1zBeqWjkDESnJa+HY+POYeQTTgwZct5XQilXHb6CbPz2soUl4KDbr1rQrV7a4OfIpqzq7JcxUG6xBXcjtg4eIxwD3ZVEVEF97Z5Y0ryrml35Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjQ4bHfg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjQ4bHfg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc09a8454b9so12959329a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698003; x=1765302803; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gHJSTe4aMe6bAXe1JeM/T8TqsDQ9XRINjSJTN9OwkY=;
        b=WjQ4bHfg74h8KL/Ol/nQNkxi8FT6jZAM8bWXPjpME7dgE++C8fA4hs2PawKRd8/NwR
         U+b7w9hdrB2s+ZU0sPYCeNMLeCOahae9Mc5A2yMX0TXE6VMm+eVD80Xs2OrwIEPti8Th
         5lrduOTMe1RupfPJU2uzQ+f299wsJrN9lJYE5+cE+DfQxd+M6UCJQuVqXjXbG//lEa0x
         QQCsSXzt7S2rZDUT0IqwEBjzDw3FBF6U05KJmSe/uZPWkCZJkrFi5bKA0063AlK8NuY4
         l7kC9Qj1DL5ts/2zhzoRl7h8Fbg0qwadVQtpwRnovm/Ejn5o/WUCaWy2bD+Ba0C2Ix+5
         VhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698003; x=1765302803;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gHJSTe4aMe6bAXe1JeM/T8TqsDQ9XRINjSJTN9OwkY=;
        b=OPDkaZ6ZbXeocrIiHc5r99vrSV/vQRy5pKOCY1SW/Lj0c53A1vcllNMlhEE1kxedaB
         nfIBMLpR073hN7NxN52vFUbratDkqU5hnngSLguvynHFrAJ+WKKNgwRSYw1f1LNAqXdB
         F4/fXnJoSxjK8hJwN8VpCuePjt77KgnqvCUMdu0f/ONtImhUGxibOpz25jiOl/XuqtSt
         +VOrsrgjz9kjumh4mj8kjnVJAs/JyQZhDI7R5ylkoyiXeecTbnnh8uqsK3jncZ4CI9rM
         Lds+WsrBJcmoqQ3awbuxT2t9HUSLi2Uh/X1xgmvM5x9Ykr9iyPK7gfm2zf5ErLeL2lUy
         NhcA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0TMOEbi1Db8GRxmyW4IGW/vCC6egVxIhKme9DZ1SvN0pRz1kPjhvTE3RHYY0KUrYPFCD4hftU01mcwq44YOz@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvH0DtKNJWs204TVeFRY1sZmAsHx12/VAQF/HYwp/yQL+aE83
	NDU4zSy4mhPUet9jdXwAREVYMEIRn7SSVov/MceTQYOTq9gZyIrbL/JS6Y1uQbeZtGKATak1HMK
	w8Isq8Zi0bA==
X-Google-Smtp-Source: AGHT+IFtGKK6M98TpiWaOOglmbgfE8ItBlen87eSw5j2d80aWIc3gkf/1OFKU/1Xk4GAVABscB5PGsX6uQt+
X-Received: from dyctx12.prod.google.com ([2002:a05:7301:5f8c:b0:2a4:7052:5652])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3395:b0:2a4:65bc:4053
 with SMTP id 5a478bee46e88-2a9418c43c6mr13361844eec.38.1764698003274; Tue, 02
 Dec 2025 09:53:23 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:22 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-28-irogers@google.com>
Subject: [PATCH v9 27/48] perf jevents: Add smi metric group for Intel models
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

Allow duplicated metric to be dropped from json files.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 0cb7a38ad238..94604b1b07d8 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -3,9 +3,9 @@
 import argparse
 import math
 import os
-from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+from metric import (d_ratio, has_event, max, CheckPmu, Event, JsonEncodeMetric,
                     JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
-                    MetricGroup, Select)
+                    MetricGroup, MetricRef, Select)
 
 # Global command line arguments.
 _args = None
@@ -56,6 +56,25 @@ def Rapl() -> MetricGroup:
                        description="Running Average Power Limit (RAPL) power consumption estimates")
 
 
+def Smi() -> MetricGroup:
+    pmu = "<cpu_core or cpu_atom>" if CheckPmu("cpu_core") else "cpu"
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
+               f'Requires /sys/bus/event_source/devices/{pmu}/freeze_on_smi to be 1.',
+               smi_cycles, '100%', threshold=(MetricRef('smi_cycles') > 0.10))
+    ], description='System Management Interrupt metrics')
+
+
 def main() -> None:
     global _args
 
@@ -83,6 +102,7 @@ def main() -> None:
     all_metrics = MetricGroup("", [
         Idle(),
         Rapl(),
+        Smi(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.158.g65b55ccf14-goog

