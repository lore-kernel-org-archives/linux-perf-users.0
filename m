Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08772386424
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335990; cv=none; b=rVx1ZeKQJDC9ospFoTtovBW5m2va/QOwgFGDrxQtucCtMMQWY9IOv/yPEZF6K0IoEsenmYqqnDl0SjUFXB29D42B/AYsgDnCBPGKMNI3e8o5QMQPvMqtbjjq4M24yRUPJxkELeMqH6vWdcfOXwnz+IeBnNqNLg0FDP5jLHg3j5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335990; c=relaxed/simple;
	bh=oIraJFcdmCZeZxqwqAXFF/MvJAlmRPO/Y9o6YnJ1k2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HZ5Z/u/eB1NgiQ0swMYSOwKYXSY78Mg0oq2BJQcMgHURDMlwheOnV1+wep3DjBM39Hdta4f31pmSY188SVOSnGhoyUmy2dILgYetNPqojF8GYZp6HfLGai/Q2wNejKIUb+MkcoxTOmMvJH5Wcs6SlviGYD/AqxqegJdsLm4ZZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tvk/pgEh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvk/pgEh"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so3025363b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 20:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779335987; x=1779940787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Km7j/1fh2HMB9gyR4gTuaHGP0nXdKFB9TrlgcUk5uNw=;
        b=tvk/pgEh4wCHrSa+WIuM9D2SKqwm7f2dPK4BQIgDiM8WPnri3S1VPS7aj2BOb+6Mb2
         V0JnfIhLzrF1Oi19+OVLbeat8y+t7i7LbXBFa1fDFIZPilX53toCCnN7XYvqhyX30+Nk
         tS7pqb5FEazWxoYYRY/ogglUoBiiDySjmqG7bX4Wa7r3nA6aYRpo02F27bq2LBJKspWR
         NbdfoYBS0ff7Y9T8BxyNphvlAfzTIY2FyAP47i0C+y6X/SnGK0YpgtYeL90VHQQYjz1j
         4K3ZZudan4AzN9EIOsXaEcimxfrG3kEFyRG+J4yOscvFYde92CqHplHBKGXVb1sjIVdK
         qYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779335987; x=1779940787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Km7j/1fh2HMB9gyR4gTuaHGP0nXdKFB9TrlgcUk5uNw=;
        b=p4FJAHNq+Da7wCKcat/s53OM2tLHkJhz89dC5lbwsSBsAP9nGoBgszZlTCY7SqQexs
         g30pSC0xzJhnij3tv089iw/4Jm83gjFPFIR7oDsSA5cLpmAk/pK56pCG0r0mhgAUbniQ
         RM0Jal4vs7Y/wdEv3064w8SGy0uuGWrDPrjyGetvtxpR8UfO9FgwEQEFpkzotLBXj0i4
         szvICinANoEZd/jAB2/4iWl1F33P413mOEELWMWuHbJCTGobXZipEb4J+UGvveYX/v5S
         KjRI9y5UQSYb1MC2rnGQrzTV+MijeMPwlx4B1vvcFsaTQEBK8bC2aiUFGZXPtR3D22yy
         daRw==
X-Forwarded-Encrypted: i=1; AFNElJ/Caq+EhfWxZ/tNJelVpthq/I63+knlp5+4VBFeBrxjP1pgG0Er2v+0Nn3Pff7mM48MTJ92FXcnpo3IABD8Z9Qb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy56+ywX3hl4NlMIiQqc4FkjcGv87CM6nzJsDZ2WdU9zTNw/BwR
	gYTun/Rik4iikDqUoQcTBr6CTzq38CC7SMef8RpcmkJUt8Y3iI0FmQd5G70yTx2bl7Oii+tW3sW
	m9RR5qA==
X-Received: from pfbik6.prod.google.com ([2002:a05:6a00:8d06:b0:835:394c:6e39])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88cd:0:b0:837:d746:8e1a
 with SMTP id d2e1a72fcca58-8414ad4a498mr1255250b3a.22.1779335986920; Wed, 20
 May 2026 20:59:46 -0700 (PDT)
Date: Wed, 20 May 2026 20:59:41 -0700
In-Reply-To: <20260521035941.3860145-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521035941.3860145-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521035941.3860145-3-ctshao@google.com>
Subject: [PATCH v2 2/2] perf stat: Use aggr_nr scaling for Intel uncore miss
 latency metrics
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	sandipan.das@amd.com, leo.yan@arm.com, thomas.falcon@intel.com, 
	yang.lee@linux.alibaba.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

Update `metric.py` to support the new `aggr_nr` keyword in the python
metric generator. Replace the usage of `source_count` with `aggr_nr` in
`IntelMissLat` inside `intel_metrics.py` so that uncore latency metrics
(like `lpm_miss_lat`) scale correctly on multi-socket and SNC systems when
aggregated globally.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/pmu-events/intel_metrics.py |  6 +++---
 tools/perf/pmu-events/metric.py        | 10 ++++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 52035433b505..d99c7dd43797 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -7,7 +7,7 @@ import os
 import re
 from typing import Optional
 from common_metrics import Cycles
-from metric import (d_ratio, has_event, max, source_count, CheckPmu, Event,
+from metric import (d_ratio, has_event, max, aggr_nr, CheckPmu, Event,
                     JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
                     Literal, LoadEvents, Metric, MetricConstraint, MetricGroup,
                     MetricRef, Select)
@@ -674,10 +674,10 @@ def IntelMissLat() -> Optional[MetricGroup]:
     else:
         assert data_rd_loc_occ.name == "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_LOCAL", data_rd_loc_occ
 
-    ticks_per_cha = ticks / source_count(data_rd_loc_ins)
+    ticks_per_cha = ticks / aggr_nr(data_rd_loc_ins)
     loc_lat = interval_sec * 1e9 * data_rd_loc_occ / \
         (ticks_per_cha * data_rd_loc_ins)
-    ticks_per_cha = ticks / source_count(data_rd_rem_ins)
+    ticks_per_cha = ticks / aggr_nr(data_rd_rem_ins)
     rem_lat = interval_sec * 1e9 * data_rd_rem_occ / \
         (ticks_per_cha * data_rd_rem_ins)
     return MetricGroup("lpm_miss_lat", [
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index ac582db785fc..6bce4eeed875 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -93,7 +93,7 @@ def CheckEveryEvent(*names: str) -> None:
       name = name[:name.find(':')]
     elif '/' in name:
       name = name[:name.find('/')]
-      if any([name.startswith(x) for x in ['amd', 'arm', 'cpu', 'msr', 'power']]):
+      if any([name.startswith(x) for x in ['amd', 'arm', 'cpu', 'msr', 'power', 'cha', 'uncore']]):
         continue
     if name not in all_events_all_models:
       raise Exception(f"Is {name} a named json event?")
@@ -576,6 +576,12 @@ def source_count(event: Event) -> Function:
   return Function('source_count', event)
 
 
+def aggr_nr(event: Event) -> Function:
+  # pylint: disable=redefined-builtin
+  # pylint: disable=invalid-name
+  return Function('aggr_nr', event)
+
+
 def has_event(event: Event) -> Function:
   # pylint: disable=redefined-builtin
   # pylint: disable=invalid-name
@@ -762,7 +768,7 @@ def ParsePerfJson(orig: str) -> Expression:
   # Convert accidentally converted scientific notation constants back
   py = re.sub(r'([0-9]+)Event\(r"(e[0-9]*)"\)', r'\1\2', py)
   # Convert all the known keywords back from events to just the keyword
-  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event', 'strcmp_cpuid_str']
+  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'aggr_nr', 'has_event', 'strcmp_cpuid_str']
   for kw in keywords:
     py = re.sub(rf'Event\(r"{kw}"\)', kw, py)
   try:
-- 
2.54.0.669.g59709faab0-goog

