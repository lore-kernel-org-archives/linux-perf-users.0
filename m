Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B012E6CB3
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395656; cv=none; b=n/EG71x0un9tQE1ikVDBrV8oEIJbrjIsOZHSIKJZQ55GqJLUNmqW3DEFuDhLEtpm2/brHtrueGcHXK/WQqL0+EglB9SG82kx4vjtdnKuq5B51ut4xXXzyzE8TmeiVL+qiQBXyBymvY536aPkPiXbCkgGB7s1lqtNqrIC2CX8TNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395656; c=relaxed/simple;
	bh=WXALug6l0e27cyvCMGUVPbsYCMjf5hkaYfszqO1i+3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=s99+KMWQaStIZXgJ3FRkJmht66QaLCKt+ZrhqOC2a3XAeU7v7ir4FfaIh2c9XR5h7amUf5ZwQOvbrf86/9kyj0a/SYL1CLi4oKea8Z+hL6D0zOSt52P/xMGpwFjGm57s2bkChN1miz+YPzy08cH8hQswfN6orxc4zEcbimJmUuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apas9krV; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apas9krV"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c89956023dbso5065791a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 20:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783395654; x=1784000454; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjpnkPaIgY/iDWGY/mqjsKH8PJ4AujF/cifBEMqlEH0=;
        b=apas9krV1utiT6FjknhqRzzPL6MXX0W53KL3SnSWzhe9qK3NCV1/PdRQpSjpAKovqW
         l8pciXNXgdNw+eGBGhAunvHwxrSgIWCAb/FTp6XuVGS/XS5mhL9uRpdgrrdHFnYJ+lDI
         +4SBpQt0xK0UzSmJCa7cEnq6A28RlDLsHiHlnHWdGMLDnZM0SiT8zTlKIduE+ttSDAmC
         1alVdug/IEy+CDQkHqiHvRMwUYPWebhPJ4joMVtDbpd5ZKHZrlGcxuZ1w3M9sofacGol
         YWkRyT/SC9OPtM1JPBu7zCp5vCnkEjCdv2Ofh5M1PSA0TvP/27c0Zn6sYgPhFOwQ6UHx
         Mykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783395654; x=1784000454;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjpnkPaIgY/iDWGY/mqjsKH8PJ4AujF/cifBEMqlEH0=;
        b=pMZXKhaZ6207JaHzJMcuf/1ixnZRp6nnht9XsmX1SDkMnmSb0JTPFleG9uo4emFFYv
         Zym59Vqo8XtRb/iT8EpMHWU1IJctcOXMzFV4PP1Q1jl6MkwiNxaeZdQ/n1jUzskUStLW
         L4ACi8VgIwqSjfUFWCLVUpZatgI75b5DprAIdioyoFBk+Zdhjr4RCKYBArKvoX1gyc1V
         4DOBZkappqHwwu2TG6ZVHrx2wZHA0mbBmkiL3BZIhF6O06ezgolCPwAE1+c5qFYM9LzU
         Lsz8Z0bwYHkcJWh3r0kvWN+jpXne2XlpO52v30lwONP66ucVHrYZTTNCFIaL1PfiLAf7
         rLjA==
X-Forwarded-Encrypted: i=1; AHgh+RrKAgeSx6YHN36jSV3Al596aEV2mQ3f9BU7OAEig77cNrDnF/txOqqMwkvs831xQKUSYIkdLwjIy9xe0JI6YamG@vger.kernel.org
X-Gm-Message-State: AOJu0YzlL4NVMxRT1DgMtl7EIkcEZrfZ08nE2tByO4HBSLaYJRl1InOu
	FfiZ4G0xvZ3AMuPkaRyJe111s39GsK39QeDmWHkrZNZAsASe8zzMF7tZf/tG0e+528Hm1Vwub6b
	+vQnvBAlgVg==
X-Received: from dyz8.prod.google.com ([2002:a05:693c:4088:b0:311:6294:c296])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a8:b0:398:9379:d04d
 with SMTP id adf61e73a8af0-3c08eddf51cmr3968091637.24.1783395654323; Mon, 06
 Jul 2026 20:40:54 -0700 (PDT)
Date: Mon,  6 Jul 2026 20:40:17 -0700
In-Reply-To: <20260707034019.241762-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707034019.241762-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707034019.241762-2-irogers@google.com>
Subject: [PATCH v1 1/3] perf jevents: Add more components to the metric
 sorting order
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, 
	Chun-Tse Shao <ctshao@google.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"

Nazar Kazakov reported non-deterministic builds due to the metrics
being reordered in the jevents.py output. The metrics were largely
only being sorted by name, add in the expressions and descriptions.

Reported-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Closes: https://lore.kernel.org/linux-perf-users/20260706175624.692736-1-nazar.kazakov@codethink.co.uk/
Fixes: 40769665b63d ("perf jevents: Parse metrics during conversion")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 5 +++--
 tools/perf/pmu-events/metric.py  | 6 +++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 376dc2d24162..3c6cfeefbd5d 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -570,13 +570,14 @@ static const struct pmu_table_entry {_pending_events_tblname}[] = {{
 def print_pending_metrics() -> None:
   """Optionally close metrics table."""
 
-  def metric_cmp_key(j: JsonEvent) -> Tuple[bool, str, str]:
+  def metric_cmp_key(j: JsonEvent) -> Tuple[str, str, str, str]:
     def fix_none(s: Optional[str]) -> str:
       if s is None:
         return ''
       return s
 
-    return (j.desc is not None, fix_none(j.pmu), fix_none(j.metric_name))
+    return (fix_none(j.pmu), fix_none(j.metric_name), j.metric_expr.ToPerfJson(),
+            fix_none(j.desc))
 
   global _pending_metrics
   if not _pending_metrics:
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index a91ccb5977f0..11c7162825f4 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -623,7 +623,11 @@ class Metric:
 
   def __lt__(self, other):
     """Sort order."""
-    return self.name < other.name
+    if self.name != other.name:
+      return self.name < other.name
+    if not self.expr.Equals(other.expr):
+      return self.expr.ToPerfJson() < other.expr.ToPerfJson()
+    return self.description < other.description
 
   def AddToMetricGroup(self, group):
     """Callback used when being added to a MetricGroup."""
-- 
2.55.0.795.g602f6c329a-goog

