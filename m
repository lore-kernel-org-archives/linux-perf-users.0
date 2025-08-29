Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F162459DD
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436866; cv=none; b=SDS+RwW6rsqIEyqRXdflxYebJ1Ll+RmxTmeXhEUIJw8iUqn4YOmueUS0wuo3F90l/atrJ8avM7uri1EWHGC7AdpTXXwB07cFBfCJxmGUmELEdlEetJTbWqsNat4pKUqSgOabz0zLgnhKwqtLGSt/SAyQ6eXzh9k7cqmYu4BPR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436866; c=relaxed/simple;
	bh=s70LreTJZvpj/UsPUpkL5mH/ObEy5UgYgmp7RgZyric=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kBhsC4DDwlCrmDAWraiP0+HRiaP1e7wnMuj/DAlR2Pb7yIBjxfc5qqEsrEc5eQG0ne+hPKj3b5g3QQWo8m9AY9Wy7WLhR4IbCS6DAarzTBU20TjpM7zcKMEyTbdRLZh2QTqOcjBbc+tHEI5PyYokBfk7WI7TV/+NvNh66Y+/YMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjgJY+L6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjgJY+L6"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-325ce9b32baso2008165a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436864; x=1757041664; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdhDBFzLixhDw1nJ2o5nfgu+L4QKWT2FN7h03sEUhSk=;
        b=LjgJY+L6B8ydp63HPto/iYa8CKeDI8XxbRSC4UU0FhySG6Kc67SElckYH4JkfLJcWj
         RnhLPRk8HktFoXT4Je9Kzxjh/gZZin4pNHY0ekR29JxeIsibpLdtsA/2rogMPKCyKeeT
         dkw/EvwHvEXaacvq8DTfa6DqUiaEqbAb5I8UC38NxKOSEx0Auh20L5FYFtwGIeR+Vqsd
         gw9M5QTMiaa8f8qs6YiOxPNO+K5yyHnFi6rZdOrZ0MoJiKt+iIK9HPCkTIIfqn9RZ7iN
         9qKZG0hL+IWV9bOW9CecjnPYzzr6oGYJ1EI5hq/gooky/eGgAkUhD4HaOAoiE1bSCHfe
         uxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436864; x=1757041664;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdhDBFzLixhDw1nJ2o5nfgu+L4QKWT2FN7h03sEUhSk=;
        b=hgEvsAHlvieCz2pQxZBn1G6oDxUS6h5QPBdg9D6+zOpHSrT8e0vhOnn1M/qUeode89
         1fFI54DyDakFmSsqU102Nh0A12w8rKthcdP1jH17OA7XJBk/b8pv4iv8ZKerPtIHyTnX
         84Y7YHJ1MdUUbYGTek1zi2T9ByjPuNFKX4U43TOUSi+nWewRLWw5jP3uxxvxOQBmQJKN
         9kxE5bFBnnseF4wxmy+T0Yx5/lRwR0+jjAGfqqV+nSLQwrCFTZRRqseae48yYtlOmgLx
         PSjnl+rmJIkRHbYOSPED/gsGjb1E+OR4rTek0AiUDAyWfTxflcbq23mXGOMcekYl/v0m
         4hrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDUDsVtGuP69MllWXqQwmuAdhtpdaEOH7iImyHpQnFpOYonnTS3y8vqyOrwdQDkgNUVA0ghsVo9leiMkLic+AK@vger.kernel.org
X-Gm-Message-State: AOJu0YxbAo5JULINgWc8TqQrvpUXqvZNI82nofrFkt3hBbkhkI+fM0iG
	DE03hX8s9la10JVhNm4G0Gs6hwjTmYlTgJSq7Z4SHJiSazx26+ZB8RuqkzCx7qvrDbHuquvct4r
	EnMemuXITUA==
X-Google-Smtp-Source: AGHT+IEbT+wkcETwIt3TUVHTdsXkGurRbI70ZJMFBroFp7ZiFb9MonRdrQNpj5wIIoMAOuAeZRG7Q1KXiLsI
X-Received: from pjbpd15.prod.google.com ([2002:a17:90b:1dcf:b0:327:e9ca:a5ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2683:b0:325:58f6:1f91
 with SMTP id 98e67ed59e1d1-32559056397mr24152621a91.11.1756436864622; Thu, 28
 Aug 2025 20:07:44 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:21 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-8-irogers@google.com>
Subject: [PATCH v5 07/12] perf jevents: Add threshold expressions to Metric
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
2.51.0.318.gd7df087d1a-goog

