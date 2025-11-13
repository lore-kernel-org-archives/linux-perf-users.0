Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D428CF5D
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004073; cv=none; b=YzXL2QigZBE69N7pSKQM9nKE6rrAv/3OJMd/7RGMt/U+9U+wVPfVwSP81Eiw99+2gKgkui7THfKTtT6VPZIq9hUuHYB69c9CEq4rCzj7Q2V68GDTP+0JoO44lvPU7jvDSwk4fAv8S7OQfh+5R1UPPWhTTX0bEV+YTftp0E10X4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004073; c=relaxed/simple;
	bh=d0Ep0VIIIs9k/3jv4T0ZT3I0MIVW8QcIX/tWtlgIghI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YGjRokAgO5+Ibboa447/3aSO1Y1tW0LQZgx55RvWA+O3SmndJ5Jr8isw7hXbhKf+qAAz+TtOjvUq8+fwrcaealyFrp32Y3YyPRC5RJGP/EYDtZwtHESWQ89SGN0cw0IjxhBH4xc6by4aBYUylxnz2R9yWs5ndpiGFttDEY0PY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UGt3fbxu; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UGt3fbxu"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297fbfb4e53so6647775ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004072; x=1763608872; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2z0t93p1I7hhdevKfjgdZ8asRVsm/YfKaf+NS7xqbWw=;
        b=UGt3fbxu89gb54sGORtH8nqHFQn8XaQ6dg4TFIVOCp9gSUxu3QnxrxLiF/clKr75ew
         2p4DKiJXGVshQJkSp1Yb0Gj9WiQv+37DB3+9FvoTP0Obo78qUVzy9f+IgTngY7Vns9Ji
         0CI64jGyVfc/Rag+m7yKtG/NuvqXUXdgqdu9OEDMIyzY0ZxZQTgicf1hPpWLVV4voeLz
         2ogEile8I2c9DCCBWqgU3WPn2qIyVoM44YYCHXlwbp3/bh/r62ELzkiBuv0G0IwLIo8+
         LMpKhexeBx7QFV5DlQvIycpuwGbpCSiG+eTu6quiPaKph6/3EP/EQv/l31Lqic88pywd
         aqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004072; x=1763608872;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2z0t93p1I7hhdevKfjgdZ8asRVsm/YfKaf+NS7xqbWw=;
        b=gNUAZyYiFu3Yo4a1XJ6zAwzxZ6dlJlTvs4PkUflSJJB36oQ/ANfw8xyoEqMy2kc+nl
         9dyRjhGoEnRyMwc5CiGEYU0Paj/XxFMMj1pnZGcAaX2kb+r/POFezGu12R2eQZBjwdrD
         c2lrep1CULF/xKFX6Thp6VbBE/nVIz3CMlJywYLw7ZfO+szXAevQD3YAEzR7K1n40mZ1
         mqpwz3bNL/AlAfjuXoDyzL+gHzLBg1Z8bbybkX3XQeXg3yd9j35DD0Po/LPOcp63aAIL
         eJt8fL41waM2iCE6jP2haviHIO48W4/jFblD56P4BIHZ1d/6pNX9n4zSAmfcadX3WsRH
         AywQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGyTWSeymNadJ133wWTJU5saCXTR1FHponRzv3rGuoUAW/2tUAeDSzW05flPi+QpCoC2yOv9iaahA37RruZh1u@vger.kernel.org
X-Gm-Message-State: AOJu0Yy994lbS1prXvOrhrS2O6OhS78g2muxLK51DV0JpuWUxb1jXkVH
	zsbCc0ZdU61s114tgRqRHMmIYCe+bGTlGPl1epsBs+yRbXiuRqYYxLW7UQn0U6+bwQh/g6rtYXO
	z69KHWFRdOw==
X-Google-Smtp-Source: AGHT+IHGXwP8nxSNqOZtGTpxELzvSp9/lGNgnf9Laege7IXTYMU1vrjNxTAmdYNaC59qJtJcrvWyZ+7XLRc4
X-Received: from dlbdx18.prod.google.com ([2002:a05:7022:e12:b0:119:49ca:6b96])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccf:b0:297:f8d9:aad7
 with SMTP id d9443c01a7336-2984ede5755mr65012275ad.50.1763004071922; Wed, 12
 Nov 2025 19:21:11 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:57 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-10-irogers@google.com>
Subject: [PATCH v8 09/52] perf jevents: Add threshold expressions to Metric
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
2.51.2.1041.gc1ab5b90ca-goog

