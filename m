Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4767B2D77F5
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697946; cv=none; b=JluNiGdLy4H1bCxB9RpySh9NrB92dMT/Tm1y4PVX5e5jLU0PHPWePclLK5IQQ9Z1jPw5/Ykqp8U22/66fCw6HemcSXLTM8xmygdRMNpEBqe8WYz4twURePv0R/akJJgTmlrW/bVxS30pJxPSJ5Ynw6nxDCQxoLLWqXr4Vpen7wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697946; c=relaxed/simple;
	bh=AyZA4nD7jh5kb1lPGF2MDaVZ/tkGQEyjyH8++oUHFGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=S/5UX+q4iJxeIAbwAk+XhItLAgyghf+QsoxNKDDhLXvzoNTS+RLcWIGIQylcENYYbq2x7ggs1ZR1/8hHzKC4IHjF6/UX7qS4D4OqedlD2bJFm0SYPyiYfZ1Ouvs4pWfHwz/IBrJO8Jj6UnCpKRCf5KQKiW6aKiqAqSo50zwOlOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=faKp60jZ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faKp60jZ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b98e6ff908aso12792715a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697944; x=1765302744; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lWESTB2UTGcAg+Bqss+YoR/rSNf4J9eOBW+DXHV/2E=;
        b=faKp60jZtmY3yxYtU4oIAcP9k7qBVZ3QxYAdhl38/5kagD5YLQvluPVdQ+a6xvuxy9
         S/9C54di55Jb5TOWxrEvmVgU/SvTYNTT8zp55s99yc2CE3ghasJefEOix2vELUrcwnYo
         HQ94Uhbbcprt3CQz7UU2K+TjHG1B+KEKZQnMq2tA/v5/jDkCubpDzUP+qM1v5tVG90KH
         FF2oNKsGc480n0ILft27hwR4p8G8Q4R5dz/W9/15nyC8JIJNPd/gQ5ED7r54Pi48kCbX
         q5/u3DQjV4Uw27zci/5SMjQryx/L2YxwUP4ssoLh4+oLDzht6P5Zd93oglnDC7UC1rmv
         I1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697944; x=1765302744;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lWESTB2UTGcAg+Bqss+YoR/rSNf4J9eOBW+DXHV/2E=;
        b=cVEfDYtrBDEY5DBOLBDN3aRbiHdRLVxXAnGzOz8iZbTB1/wzKZPxYzrg2j9XnFOM27
         5TH2Eo3l6FO7jhxoLFBei17zVQwJZ/gXePYY2ckQL5gLYIY6yFxEYzp4yN1zG2Hz3CRE
         8mZhHbOinVGhd+AFoMxZQukO8c2fs59mCdid6HhHAfntrkTMiEGQEPg2k8SZS/LtBZFa
         lMrk1f2rPYLwQ7B2qXGilVxvx1NVJBXU6E3pIcqgOLPv6Ra6kFeHqzJu1dQ5BJtYn2tO
         /Am1HpMryATHLWmdCzxlJjYY9/30gu/V2PaSPOobRpEH9QHsD5hbRndIcRwRSIDqkidT
         wnnw==
X-Forwarded-Encrypted: i=1; AJvYcCV1/y+S7eZp3EDUsG6vb3icPNIzzaNBDLwG+szKXJgRiJnrbmogWd/Zim5spzFy0nwDaKS6GBsCu1wWIsIE9CYw@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvOeUb52Zxl7oe5tqNaNsUZnIgiEMQzvB0dRGDLkCeMrROoD/
	rBPcRcOUYcZxEklGGJ6YUPrxHv0zUGeD49h+TP/9O+6SqVrF3QszPpCqOp+y1MvDLlJb3JoDhTx
	hbzCgF9dFAg==
X-Google-Smtp-Source: AGHT+IGHRBUPQQI/Ixl6furUweurkhLLHHi+K7hWEgwf6CovRvn8iSd9kk5hxy9K0HFykKH3Edpqp6VZSQlX
X-Received: from dybms17.prod.google.com ([2002:a05:7300:d511:b0:2a4:559f:7c4e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ec96:b0:2a6:a306:eff5
 with SMTP id 5a478bee46e88-2a941581a8dmr17218723eec.5.1764697944468; Tue, 02
 Dec 2025 09:52:24 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:11 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-17-irogers@google.com>
Subject: [PATCH v9 16/48] perf jevents: Add idle metric for AMD zen models
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

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
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
2.52.0.158.g65b55ccf14-goog

