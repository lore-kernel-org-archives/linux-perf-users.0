Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD73F54D1
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300325; cv=none; b=IxNlAkmoLNnsawPSItQcZsDAeP+YG7yQiAp7j+zBZSlS0RVnAGG7XcYfmoTeUa8Yk0u0El0snQVxy/f+xArGYQ1VfmhVi2xbPs7PYZGT4xpYEDNGgvwAbOfQN8oca1wEX14WLsbbwRq1Gp5MZUj85LP4O6xcnblhnPEp6O8Qip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300325; c=relaxed/simple;
	bh=sIEA+CmW18QpPvy2pvsIC0vFH+Tb50rCXUcoDoQHWNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P13O31roONFI1kDPij9BULZHjQ6m7/l35HJu5jYWKmH7RbjNr/FKGdyYvQPFjwl4UBAOPgBeEBqSj+Dy6+BBz73hrHq8n57EZ/qMPV+qdtl6hSaQhkS6cBsbvMzBdWjIKcwiu7qzFD4RHn///lWk17crQs4yaVxqVcHcNADK/aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfc3plLn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfc3plLn"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2babbeff9e4so55989085ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 11:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779300322; x=1779905122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/4UM21HNphfC3/apIv+GViPAA1EhF64J1eocrwZvEY=;
        b=lfc3plLntnGsLxA67uvIETlkc11aaU44hAXo1MFTuA/fSKiJC8fJdpCwxVjf4K6BhK
         RWuhyOBa6WkU8pjobHJJcsDMeM8aCuvXI6Q86U/BVfdkpVtLaBugdBRnEWDrD7+038rK
         P2/CFsRCeX0YK9anyRuRG8SrNTGIMKnN0AE3GiqO1VAt+0ZbgV9Sme+qrq01kv0d09F7
         5KR/Gv3oQBue0o/+4sy21RzKfLKRAmGsHDp7zKTopbKJmjpND3gxs8dCVmVUEy25oyMe
         biwZjIB6S2Fue6ckYKpHojvHrsZkDU0FWv0uqO18MGHzjVrksTkxGKrKNqnsLjlKMwA4
         gAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300322; x=1779905122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/4UM21HNphfC3/apIv+GViPAA1EhF64J1eocrwZvEY=;
        b=C6bnBE9tuGpOhC3ZcJexb+rsmUPJoglncjoCxCLyebE7jH4YDzf+tIEM3WBR3xRrDk
         oBKEQB69jczmCIGwmAYo5uHGpn0ycIrSLPGikSrnn0U96WKb6no6438axrscHHdl/95G
         6G83fKOdHiBdcD43AZBXuo0deoCCn+BglnoRL5jxXYEMBn34qhF7aMS73tCJx7tlA3Ro
         Ow6eqLxk0v9Ej6T5zHKFZZpZ3oAh0EUSCLKNvGBKL8OZrp+yS83/Dlp4GnCrugqE1oJO
         qcUdhYu6S+IvBW6SZXLus771q4atn6fezARs/Z1fE42IXsu6GyL88Qf2nMWmEp0mE4ds
         JQJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wUESU6nJeoH8waV7505Z2RRFfFtMUaTVobMmw2/3+nK9dU+kQzZst9B+NYJY2K08LRRDUZ+5T9pDlRW3jOhVT@vger.kernel.org
X-Gm-Message-State: AOJu0YyAb9OmNNqzwuGCe6yVUN4exVtra70qiAee/OGA/OeUJlMTuSW2
	vPc4CH+I1+OqJnNajTH1aFMLBhgDYHp7k6csd4u/VuvATbOv6pVoBzuaDTuKNwGiYojHf9J3mrF
	CM32kZg==
X-Received: from plkk11.prod.google.com ([2002:a17:902:c40b:b0:2bc:c1af:322f])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aef:b0:2bc:dc1c:438e
 with SMTP id d9443c01a7336-2be9d40fc9amr4566345ad.11.1779300321595; Wed, 20
 May 2026 11:05:21 -0700 (PDT)
Date: Wed, 20 May 2026 10:58:22 -0700
In-Reply-To: <20260520180032.3045144-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520180032.3045144-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520180032.3045144-3-ctshao@google.com>
Subject: [PATCH 2/2] perf stat: Use aggr_nr scaling for Intel uncore miss
 latency metrics
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, sandipan.das@amd.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update `metric.py` to support the new `aggr_nr` keyword in the python
metric generator. Replace the usage of `source_count` with `aggr_nr` in
`IntelMissLat` inside `intel_metrics.py` so that uncore latency metrics
(like `lpm_miss_lat`) scale correctly on multi-socket and SNC systems when
aggregated globally.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/pmu-events/intel_metrics.py |  8 ++++----
 tools/perf/pmu-events/metric.py        | 11 +++++++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 52035433b505..50d5a20fa354 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -5,9 +5,9 @@ import json
 import math
 import os
 import re
-from typing import Optional
+from typing import List, Optional
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
index ac582db785fc..424659b021ff 100644
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
@@ -576,6 +576,13 @@ def source_count(event: Event) -> Function:
   return Function('source_count', event)
 
 
+def aggr_nr(event: Event) -> Function:
+  # pylint: disable=redefined-builtin
+  # pylint: disable=invalid-name
+  return Function('aggr_nr', event)
+
+
+
 def has_event(event: Event) -> Function:
   # pylint: disable=redefined-builtin
   # pylint: disable=invalid-name
@@ -762,7 +769,7 @@ def ParsePerfJson(orig: str) -> Expression:
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

