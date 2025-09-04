Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACCD253F1A
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960347; cv=none; b=HFXkGN40JiNslo5LSx7xjaodf6yW4qA86zvInDc4ahKmvaewZy7bbrjTV/AHlaHC8hjSNBtiCc3Hw82gC3KwPkkqt82o6/YFjZBJPM0/70ccDClOX+7REGxnRhc0UKtoRoR4Z8CcyL+FpJHvRhs1FtnlsNmmIXo6Rf23SW2+xNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960347; c=relaxed/simple;
	bh=6hx9FCGwo9obLiXV66ieeFUH9/2K3nzqZZDJWzXqIJ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=OIgSd9TMDccycA17aGiQX7Jo0Rnj4qZZXxLlgy7dbHg/ACn7KBfmBRgM2rfDY1vNptx8YnmGo+i2ydc7xPJThcS6f9l5atTEFuVtV2pYX6gF1dI1kh7qqYUUIB//FG6W+6E9QbMWH0UwIgy6F3PD8Vos26EzGvlD5JkZ1eV/Ql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lksqOCZ5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lksqOCZ5"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325b2959306so1075519a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960346; x=1757565146; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Cer2P39Ih4bfooa7p7nfW7RgyenKFu86JvHBS91XmM=;
        b=lksqOCZ50R3uneYiPkcq5/sLzyTP5KwjqtvNXbrj25WcbH3xjMyzfiGIRop7MAauSK
         oRGF/inDC/edsWOltreq+nXdz0hFQyNWS4gpZ8V8tmjeL8YaXS+/nzD/2Z97ysRv4Qpx
         TszOdadbSiW2whs1NqTfzvdetuk7qIbE5c7BtasWOKBCZUuxRYj+pqQH+bSW5geTht09
         ptF5PQyR0i13CiPyzmaVeYz+XeREJJUX+QOgKRPoYc3Ov5S7KXUFsLRjp0aTDNkwH3R9
         x7s7Oa2SOeovECzCcFPZBfcP8L1jmWu7UG/sJyne+7nUdHpsF8cTNeGsRkLvwH7ttfsC
         v5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960346; x=1757565146;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Cer2P39Ih4bfooa7p7nfW7RgyenKFu86JvHBS91XmM=;
        b=ALjzVPScKM3CG/lUQS1fXF8/0O216wwIZjHlp22sO/WJ16kwsoFUVcdF2qVt8pr9r7
         y/tr0wnYDyHF0K8LRbXDmLvFwHcbQxhzbS8qBroH/lYZFCwXFPzTP+0SFnn8UR9PJKDq
         7KDqeAjYEMkb8buTdZpTPUccXuEhIkio1oNwNqXUzAKdhQA3LAGlzEWsIqer9uzuqzAU
         v3aPJGpyZNx3SMEBbewLfG8BVEk8vsDrNvleTB2M7krvMur4LZqMEjra2B/4uOmSAS+b
         RXr1NDst+NytyJEn6UrqT4Gc7b6feLLRIxZKXepFSkzK90NXd8a1olU7Yn/SU86pS4kv
         kggw==
X-Forwarded-Encrypted: i=1; AJvYcCXeh6mXQsKSp/gITbwp+huiVRjRRNEvWXX6tDnVdxLqLYj9OskC6lgKi0Oqpaaw5yw0APZG2XLjzL6mCvptE2t0@vger.kernel.org
X-Gm-Message-State: AOJu0YzRy90Aa3v6wGN2Q+vRno6j2L/2f9dZNNS4Jt4E2I0w313g4TLq
	5FszLDTQXLO1PDisSfksv01g5+FbQREFfcAW5VayKgtA26YnhXs8XE3pT1qKKCkNdC2eXALJozl
	IVO7CiG/LWA==
X-Google-Smtp-Source: AGHT+IHyQxKJmyNAJJrGrigBYmDUy5dVHf2arQPFVlnAYLtEx1g3ARj3ZzOV6dXsOUyDoW+XNGxu58XXzmUX
X-Received: from pjbpb8.prod.google.com ([2002:a17:90b:3c08:b0:325:3ada:baa0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e12:b0:31e:cc6b:320f
 with SMTP id 98e67ed59e1d1-32815412adcmr18770023a91.5.1756960345406; Wed, 03
 Sep 2025 21:32:25 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:32:02 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-8-irogers@google.com>
Subject: [PATCH v6 07/12] perf jevents: Add threshold expressions to Metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Allow threshold expressions for metrics to be generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0f4e67e5cfea..e81fed2e29b5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -430,13 +430,15 @@ class Metric:
   expr: Expression
   scale_unit: str
   constraint: MetricConstraint
+  threshold: Optional[Expression]
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS,
+               threshold: Optional[Expression] = None):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -447,6 +449,7 @@ class Metric:
     else:
       self.scale_unit = f'1{scale_unit}'
     self.constraint = constraint
+    self.threshold = threshold
     self.groups = set()
 
   def __lt__(self, other):
@@ -473,6 +476,8 @@ class Metric:
     }
     if self.constraint != MetricConstraint.GROUPED_EVENTS:
       result['MetricConstraint'] = self.constraint.name
+    if self.threshold:
+      result['MetricThreshold'] = self.threshold.ToPerfJson()
 
     return result
 
-- 
2.51.0.338.gd7d06c2dae-goog

