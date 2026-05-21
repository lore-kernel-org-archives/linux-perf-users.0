Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5DC2DAFBD
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394514; cv=none; b=G3NiyrVMG2nkzyHac5jLsIc/XdGQO0xSeJn4xDb0DBXJJUDzq0tFBXqxEHl9NYHK2QgqogW7XrxanfebA8dncqZbj87r6M+m/wn6V9M0v2na2fbSTXGou3yGuS6Ee+W72heXasbzhhYUirwiaiK5IDBQZwIjdeTnBA5d3O/07r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394514; c=relaxed/simple;
	bh=1nopkE7ABcqxCFr7tFm0Jk9AQ2twaOaENXt9n5Rfr/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Va4n00+hOIWmQ9+L7mDYRAOx8Usg8Hp7hP9IG/T9CWcf2li10+BYA2D9ol687ULzwj9oDYyajppKuGEmdv0dJeExpmpGN1OiPBVbPWfII8gai4HJENZV1WQIJiFum+SbC9rBS4etaFI9RvpMgaKcGD/8F7xJ2vfGfiSnZNRYm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R4/TGgOB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4/TGgOB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2babc42244aso155949335ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779394512; x=1779999312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBnOYBVXmHtY2VWhsrZ8/NjRHULzNCf4oOIydFbNlGM=;
        b=R4/TGgOByuMfCaA0C9Q+NUKLOHFtV4JK9c6R8phxqbTq9Wn6GTFsD9bWmiN7YR9NL+
         1w/RvmoI6ft7mekEX7AhMwGBEUl91clTycyn9mUS+72j8fwmKQL1DrRPeuXGIxY8FETz
         zHcYIYVIZZh4Sdcjcv2uYNsWs+alD4sgVmB7ZaMkUHL/IYU5p0agv4NszACx+GTg615T
         A7B0eG4Mz8ZB1zIOHBHPjj9qafL85AEfPOeCf/pR5nHjA7fj6SqFvB9E6jb8oTMZ0A3r
         uIOI2UT2ggTdmiBi5z1+0H67k3RIsQfJxOu6pVsoaGaPm2zGZLHpcXGDE+45iC+kt1OW
         k8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779394512; x=1779999312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBnOYBVXmHtY2VWhsrZ8/NjRHULzNCf4oOIydFbNlGM=;
        b=PaCfMVhmMfBgoDPL+aJ8wmUxiNx05TkrLOkDJDgxMjdc/BELuxboPlvsFle6e3Yz3I
         +usZ1IhNRqJS0C3Dnw9blIciQigk1pdr8ccG5R+ykCKe4HaYdSQt4moW6ai5w56v2ipw
         jTSrfJWjDquQ+GFMiZXPTc2/vavYrTOfvVTdOoDcxZq2mtqIMtecMpR9F7d+k+cuNxZP
         t1e1LZdzcC648hlZdjwjJEFcqEwKEWXa66qFFOl/JEi49lcMbKaVRV4DBADvRZDJdILu
         KPKnk0bgtetP3glCsPh+AnJYcY53WGf8Bvx6Ksi/JzxjRIpOvfCYXQRqvPbldN+mREp+
         cF7g==
X-Forwarded-Encrypted: i=1; AFNElJ8LvY9+oG8XvB3Wjn0tQ5F89UolzIMF25sAV/bdXsn+I3s2E847sbtSE7qNUTWDGpKTn2OZtPUpfcEcRxgKHwmv@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2aqZeBlmj87XMFJSewy7p2OdxOyBz7rWvYkLkqS97ehQlNxT
	vweojr1dyBmUK+D8sI8hcMZiBqiYfRTxL/60JukE8NzQEMKf5qFoBKaBGLrP0KKmRQSYWukDv7x
	zJHpfkg==
X-Received: from plbjc8.prod.google.com ([2002:a17:903:25c8:b0:2bc:db13:463a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64e:b0:2b2:50bd:83b3
 with SMTP id d9443c01a7336-2beb035c826mr4541675ad.10.1779394512273; Thu, 21
 May 2026 13:15:12 -0700 (PDT)
Date: Thu, 21 May 2026 13:15:05 -0700
In-Reply-To: <20260521201505.124690-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521201505.124690-1-ctshao@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521201505.124690-3-ctshao@google.com>
Subject: [PATCH v3 2/2] perf stat: Use aggr_nr scaling for Intel uncore miss
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

Additionally, update the validation bypass logic in `CheckEveryEvent()`
inside `metric.py` to whitelist 'cha' and 'uncore' events. This
prevents validation failures when compiling metrics referencing these
PMU-specific uncore events.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/pmu-events/intel_metrics.py | 6 +++---
 tools/perf/pmu-events/metric.py        | 9 +++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

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
index ac582db785fc..a91ccb5977f0 100644
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
@@ -576,6 +576,11 @@ def source_count(event: Event) -> Function:
   return Function('source_count', event)
 
 
+def aggr_nr(event: Event) -> Function:
+  # pylint: disable=invalid-name
+  return Function('aggr_nr', event)
+
+
 def has_event(event: Event) -> Function:
   # pylint: disable=redefined-builtin
   # pylint: disable=invalid-name
@@ -762,7 +767,7 @@ def ParsePerfJson(orig: str) -> Expression:
   # Convert accidentally converted scientific notation constants back
   py = re.sub(r'([0-9]+)Event\(r"(e[0-9]*)"\)', r'\1\2', py)
   # Convert all the known keywords back from events to just the keyword
-  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event', 'strcmp_cpuid_str']
+  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'aggr_nr', 'has_event', 'strcmp_cpuid_str']
   for kw in keywords:
     py = re.sub(rf'Event\(r"{kw}"\)', kw, py)
   try:
-- 
2.54.0.746.g67dd491aae-goog

