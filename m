Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF1328638
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899495; cv=none; b=Z/zwOZ6BCBwLL/aEfjCsgyCcP4Dpu5pT99Ph0vQCayIZ4ITYPuEHZvlsHwyxUQ/2pZcNoXtKj6+X6eyUqP9I4sHa9PQb7xpAttN/Gj1dzxLhpy5g132YGSn0sETGUl/L1VYIyWrXQ3TE6bqULw9TrrSmfrmcIzmoXFaTLLGWH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899495; c=relaxed/simple;
	bh=y6hlwpTyHyOifmLqzqFarB+CugLw8uac40XfiztNF7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KfnPppWy/LOjH8DyWf72r9SLecJ1YuXkupk3xWGTXSdUEGTwGL1bKvq74z4DhPaCpYY44duRJ9IEUTC1EOHn/HoMKg6X194KgY3qEEvyt4btG/npMrBCgSwVS3UDCB9jbyu9CZDaHu/GqQKZy8nR5dXsXHzc3NwjtjM2BQoKF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9iSqIkq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9iSqIkq"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f1f79d6afso51902875ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899493; x=1768504293; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vi5rn8mItqo/t2QexpWzl0At3V2hkxYPVO28WOkSCSo=;
        b=A9iSqIkq9EPOykJ3tbBmdl/X43tB8QJ6XSYpLGAp4VGrt0CDpnmkoZlYisZIyR48J8
         D9jrCd2mLq5jPE+AMuTF4swvKj6BpHpK4y3H2sB6IdnLs5FOS54jMGqcGvgBKOnKSghG
         fAxDT7E2TL+uAL1tCPSP4HSzA3BCfqyNRR7kXdM5mInVQChQfrHxUnSQVI4jlDDGIILG
         p0Lg9/h5Gi+p9rB/ad9+kKEtxF7aojI/7F0xpPFujxJMQvGEEDIMcew2gGRZQO3Lg8nO
         gRyoBSJHeUZaQZ/KqXXLyxEG50NE23WCkwnj4e5ryVHkkLFxaJ6Zk3TG4kxMlLhDYybO
         9CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899493; x=1768504293;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi5rn8mItqo/t2QexpWzl0At3V2hkxYPVO28WOkSCSo=;
        b=PLEaTp092wdOl6OUIQhdzk4Nr3rfNPEmjKx5+px2Hm74cNxBGSTuj9RasS1BqblMtN
         DbztidcbYft3Avj41VeS3ZRm+S1dBlFMtPtVrTk/M8N3XSiU3iUBNBCEucyW3Oy+mOOk
         pBBQ5EHmqJuxbrGoN8xfXVtUqtDpK5+8XSKDEhv6HVDSpVEI6TG36Dw7izf1G6isuWqs
         wNRxxD8Nw4qcjXxv7mrbXwr6RgpEVGZsRAxT8sbXbWtdkw4xWsiB20Wiva5J37HgQov+
         iKDjPIvNI7s7LIiL6fKzssz0XGQ0NX7LWygCKPAigYp/Sv8AMiiGSPrlE4T0czrs3H1C
         iWkA==
X-Forwarded-Encrypted: i=1; AJvYcCUrZ/LP7o0DbHwKq6dCNEA3mJ2eghSrW61o+1hJKsjb+OdXgtC7oNqwL2MvObSZ3zJ/+iS7TloiZ5iYKlM/9Bme@vger.kernel.org
X-Gm-Message-State: AOJu0YzocWWSC8Lm8I+sfPps6I8LJDYbi+DIj+3ikrQ3ZNwgZ/cIjucK
	9Gvswom+OjE4N0IZn1JDqRs/KvWocS/MhkDyqbeaTWgfgXVHRFjNB5QRmzZtglPT7rG1hBefxT6
	AFdmQYAU7RA==
X-Google-Smtp-Source: AGHT+IEh2Nm3AEerTFyG9iH4PkrMdqN5IsgekSkj3asg4NS8UH2QINNjmyaIwH4+eyZoyequr6fcZFPWutBc
X-Received: from plwh18.prod.google.com ([2002:a17:902:f7d2:b0:2a1:3dae:8f1f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c5:b0:2a3:e89c:593e
 with SMTP id d9443c01a7336-2a3ee41f181mr79090735ad.4.1767899493387; Thu, 08
 Jan 2026 11:11:33 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:34 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-5-irogers@google.com>
Subject: [PATCH v10 04/35] perf jevents: Add idle metric for AMD zen models
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

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
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
2.52.0.457.g6b5491de43-goog

