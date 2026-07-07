Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B722346AE1
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 03:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395660; cv=none; b=nq+oTbUqd3SQ38bdYcvJ/RJn1S4ZY+vFAOW3MdKgQPBBUg1lt3v/43xljBBeSSidSUa8qwkKBueiwNIoCpX1RRJYCfaLlU5v4NETYJhW/WE1zgOlaxWZONt/xG2EAL+c1+H9gpfyCVkLrcDg3pWv+cvCfgT22RSeTZEcGvNnmew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395660; c=relaxed/simple;
	bh=O4Kn5CMQmTFxlMt4hQ0PzKqQxr0B0/nrLMbN/7vKKMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=LpBetY/MRk9iTvav8EOmNG2GIXLYVt/tLmhow9gHRD5uYqr73FjUDx/KisnuioR5jKZRySvHvh7E+r2YTWsi0p6QYoxQeamu3jVkd69fUuzDpOgebgPuyd8tpqq0wjCJ4lFYFSDPwnSAgyBtVWDD75u4xYdA95VCMqWVAKxe6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EuRN6tFE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EuRN6tFE"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c916d17dd43so5885145a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 20:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783395659; x=1784000459; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CsDXe1v5Yo3JHd9RLVvZOlR8owebFTjjFe9MxBHmp9A=;
        b=EuRN6tFEG/lZWJ5sOUu32Jm0ujbUnQTBFfrUgX+kyy32rWPEHTrntMlz8gci4zpVzg
         KJ8DTfWFn8oYRLAY0EndFXBlYlPIfaTll5PCDdwC+kFt0sAdhWF6z/d7jz0m7DKNqhoI
         sZ3a4vKiEeh+D+nvqg5H3a+KK7RYZtQhD9/3oY4IAN9xDo5YgX7SwdOlF3Ns/3dLDI/4
         b/YndITL8FRYgRS/mGPoGnUspvN30vj877uEdcNJmmW604OIOjQzM0XMeCvAWK6b+f+J
         XOdV90WBFYatOdwRIqlQ9YNrMYbKwpHSE8FFnD2Z6FPF0Q1ZxcsxbouKyE2f6HawCCgu
         AHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783395659; x=1784000459;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CsDXe1v5Yo3JHd9RLVvZOlR8owebFTjjFe9MxBHmp9A=;
        b=NJ19c/VwxiEQ3kE48Ia9yq+podFu+zBOMN/S7/uVGUQ1Zl9ZxC4xE3Zxp0y0zzB0L8
         g802GFMkjEGJoiGykyxJcacZKngYLKttRLodvMMz6mndPPIw8632AIqkEarS5RbNVQog
         KkroOouVUBQAs07ZN9EorQkWDTN0MOxgzWHvZ4A+s9/CXuOcmUIHSd/TkDsRQCFcsW53
         7Jkvd1m3XX+wR5RkjUzXT3wq2Y4/+OKcHkqzQHAPcvSSyCN0MBiEFGaqpT/tt/ix9qP1
         zAzLhJ5/H7VDBSQJpGmfcgd72osbqUBUSR/adUg1jnK+T5e+DzDLIy7eZRhMIjzdWOXK
         a67g==
X-Forwarded-Encrypted: i=1; AHgh+RqiQLpi75k0uSERX5sI3A5CtY+/7OOaEcHuYZV94fNazvJldmt71k2+DTkqWd8UDcYlO4gclazaHBQIkpaihlIY@vger.kernel.org
X-Gm-Message-State: AOJu0YzOq6tebths7kz4CuUPSWwXXyz+2x5Rsg05uHFr5PQXf5yw1sUK
	kiTU0+eQus8T3LxtMfotA6SQpp2JYBvsIbfRDLJ1kW9qr9/L8R2+AzadWpDk/TOezfcXT9iUklD
	8icvL5efOpA==
X-Received: from dlzz15.prod.google.com ([2002:a05:7022:48f:b0:139:af25:feea])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3981:b0:3a2:dabf:fef9
 with SMTP id adf61e73a8af0-3c08ed5558emr4036820637.27.1783395658584; Mon, 06
 Jul 2026 20:40:58 -0700 (PDT)
Date: Mon,  6 Jul 2026 20:40:19 -0700
In-Reply-To: <20260707034019.241762-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707034019.241762-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260707034019.241762-4-irogers@google.com>
Subject: [PATCH v1 3/3] perf jevents metric: Add python type annotations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Sandipan Das <sandipan.das@amd.com>, 
	Chun-Tse Shao <ctshao@google.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"

Make mypy clean.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 11c7162825f4..ce025675898c 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -276,7 +276,7 @@ class Operator(Expression):
     lhs = self.lhs.Simplify()
     rhs = self.rhs.Simplify()
     if isinstance(lhs, Constant) and isinstance(rhs, Constant):
-      return Constant(ast.literal_eval(lhs + self.operator + rhs))
+      return Constant(ast.literal_eval(lhs.value + self.operator + rhs.value))
 
     if isinstance(self.lhs, Constant):
       if self.operator in ('+', '|') and lhs.value == '0':
@@ -298,7 +298,7 @@ class Operator(Expression):
       if self.operator == '*' and rhs.value == '0':
         return Constant(0)
 
-      if self.operator == '*' and self.rhs.value == '1':
+      if self.operator == '*' and rhs.value == '1':
         return lhs
 
     return Operator(self.operator, lhs, rhs)
@@ -316,9 +316,7 @@ class Operator(Expression):
     if self.Equals(expression):
       return Event(name)
     lhs = self.lhs.Substitute(name, expression)
-    rhs = None
-    if self.rhs:
-      rhs = self.rhs.Substitute(name, expression)
+    rhs = self.rhs.Substitute(name, expression)
     return Operator(self.operator, lhs, rhs)
 
 
@@ -382,7 +380,9 @@ class Function(Expression):
                rhs: Optional[Union[int, float, Expression]] = None):
     self.fn = fn
     self.lhs = _Constify(lhs)
-    self.rhs = _Constify(rhs)
+    self.rhs = None
+    if rhs is not None:
+      self.rhs = _Constify(rhs)
 
   def ToPerfJson(self):
     if self.rhs:
@@ -407,7 +407,8 @@ class Function(Expression):
     return Function(self.fn, lhs, rhs)
 
   def HasExperimentalEvents(self) -> bool:
-    return self.lhs.HasExperimentalEvents() or (self.rhs and self.rhs.HasExperimentalEvents())
+    return (self.lhs.HasExperimentalEvents() or
+            (self.rhs is not None and self.rhs.HasExperimentalEvents()))
 
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Function):
@@ -683,7 +684,7 @@ class MetricGroup:
 
   def Flatten(self) -> Set[Metric]:
     """Returns a set of all leaf metrics."""
-    result = set()
+    result: Set[Metric] = set()
     for x in self.metric_list:
       result = result.union(x.Flatten())
 
-- 
2.55.0.795.g602f6c329a-goog

