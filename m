Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE632900A8
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697906; cv=none; b=N2TxRqOABsatVmryF5kmixiOMxpd5AOOT0B3MHghWz9WAS/saEJYCzQbm1WsI3QwNIZw8g0MW8T8TMq82fV26TD2Zdyki9IljV6H8v+7yTtD0LCB836vWR+xw6TV5CotQAM8iP2g7dM8D6r1zyDLU8+WYkbHUPplSGviNNveBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697906; c=relaxed/simple;
	bh=BP5K1yNmV+fzvwoM7+qXdRZARDVkRPG6KnFEWZqwj8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RKerWsGEHha1CD10Rn0NtbrOCfVaQkZlZyGwEslWBCe/XUVwhTUcS4C3WJHy4kR317LlFZ282LaVV2u7UjgGb6qsynXIs4O0euiHgDSMI8JlrD8su6bUULmzlU07UXEof7J+tiua83S1C21pYkXUue0vjJCYVT9QXzy4PWq3U78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ED9vMH5Y; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ED9vMH5Y"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so8220009b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697904; x=1765302704; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIeUnJ76mKBdAthG0dR8rS5beZM54LxeWcR6Dr60V84=;
        b=ED9vMH5YQ+mO61r436I57XXM53OrvePH6qY/X4CREaeRcq0QfXjKmpqLjKaS6mpsTT
         RP1C7BJb7UwN/+ESMdnZs53vGkI9caLHdrofy/2+Wwdq63vj6iTlQTKgWmi3r3vQLhdq
         CqKbApSjbLMHopDMSeO117UoccJmuOWOcyeEjSUuhlLc8nBGA+tkO/GTD7SdcUDheD44
         pgreP5xaEdXTVcHsEyv/OHaORR1nBnt/jtnrwzvGTTqJpz2FNzdHFyY2ym1JMHMbLloj
         f50Ia9v/lxAe0J6EwB6ajwhIZwQkONjMbw/rsisnFhiDZEnphgKBOqWtue/wfndHTAqc
         l8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697904; x=1765302704;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIeUnJ76mKBdAthG0dR8rS5beZM54LxeWcR6Dr60V84=;
        b=Fuf7QUUFF2gM5/6OHTOTMsnxobPDmwpIdM22v2zUwMg54AhRQRp5/SMRmsHI1jiBSk
         L/6ZY7BDg/SCYKg3dn+0pvZ1qps4w+KlyTg9puptM+TwDA3IB8zQ+aP1ilDhNqC9wRjx
         EwJBeXwc8AFkGzi5IO64MxZ/VKQYgYWBvyK0GV6vbFxyYwgPDpwJVdJBRtsHe7PAdb+i
         U1lQRXoDCa+8yBhPqR10UK2rq6g2L2SwdvWRljvnWAyHC7P1AoxM48Navc4OdbnQ+Z6b
         BhriIo/tuHPhkFRh25qfQzUNqbRUJWOvcVpuJpN2TsvGpwKKfTNQyDj7/fpPUcIGK5fO
         hjKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz8Ohzb4hT4xksRlzHNEboidwIBwX8gyTl47TBZ6aY5vV6VJfOnxNe/2wPPfyiWPz3ki5tM09dz6x6YpOyEIXZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFQdvHZSZsiZKrIt0CaxIKFPdhBiuMXHoKsGjIoD7Xphr84ik
	BE+vtxyxT8kE45YA2sNMVTeZOdccDTqXeGuZfBpJOKRpaV0jAEqotChmIZQ6gqtLesgiK55t2mn
	7ZbOiKXMdvg==
X-Google-Smtp-Source: AGHT+IHvb1qeaxiTG81I4noZ/gle4HLUSIqMbbC+FqzFhdsIxKzhepumNWxOHgHA+a0wGz5hw9lu4ub+cam7
X-Received: from pfblg22.prod.google.com ([2002:a05:6a00:7096:b0:7dd:8bba:63a0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3291:b0:35f:aa1b:bbfb
 with SMTP id adf61e73a8af0-363f3a15315mr440587637.50.1764697904358; Tue, 02
 Dec 2025 09:51:44 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:04 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-10-irogers@google.com>
Subject: [PATCH v9 09/48] perf jevents: Add threshold expressions to Metric
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
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

