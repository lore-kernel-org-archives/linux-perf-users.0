Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3293A302151
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004075; cv=none; b=KDjUQofGQdowoY5rwONQht6W2HWASP/Uy8FYu0oxqOhYKmJfEzpnFVDL3jX6pDNVevRuBRmUTDqUeZNsvTJ6biG5mfVLfw4cwTHHacRGeSSrN3/kQOJMaLM++7CSzEZ91h/nZkoOI2aeOEkWrxj3ms1f63e36zlTPzIgVVXx+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004075; c=relaxed/simple;
	bh=l8YI2kijCrvx8hpO3K53GLyELF8uGdR0pAwA2XzQtu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hAo/m4wzl0fYHU0w7OBw+D/oN2FQOJAKYNbE4derGCX2mdvslzGfkWpfI2/d4wXVdy9Srlem4v9NAqru/nJ5RbIdHeNasFvwUIGeMLeXjJNXmB1ESNgYQk9wbnxDMZuxbpctw4CUSdA3wkMWsQciAJajoOewyE1WKNSY0q5Je+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1qGVfBI3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1qGVfBI3"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295592eb5dbso4391005ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004074; x=1763608874; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eW7d37sVo4I2qTdDjDtWxDxMAZ85R454kXJd8JyW8PM=;
        b=1qGVfBI3FPFW+WlwS7fCsYDuQZCmTaTbmq5au8u7vkf5Fu8NemhqWcMUECTfZi6uJW
         ycuRePCzWVfcv9F3Oqy2sKIxMtW63oDZ8jHUSLLqPiceeipkCaRZS4sO6hsdwE1L0+xj
         tfEYJizmeE+FZvptM9uBauq+dlyX4X8IS8Uw8wzUEPpq7TFCvLZy1b6+sLRgl6UoowJV
         WkLyOF/dG/lSJuryToQDXX/KsfoHxMC3EEyQX84p6IjVrOexSbJH89A2a4LcAfnXMDxu
         GxDZbzAd7MS4LEWn72QusmHOEqVhWdsQj/0g8R0Na6SKpEAZPwKCYdOt94dvukwKZwm7
         nFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004074; x=1763608874;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eW7d37sVo4I2qTdDjDtWxDxMAZ85R454kXJd8JyW8PM=;
        b=r4soh+hVdArIn2mhfzrjMYW10avFLxIzK5yyhqQrg7PGC8+Ds/8Lb96Cnmbwqj7A9e
         mgAn4AclmUSmuYo+NmidTNReVaRBl0rbg87iLf3BnjJB/XDN2ofhPGUEifUiz5ElAUyD
         qHHu3lD/lvZqOji3c6mGd3kHuQKdnjxkd3wZVd+R8aG9JAUu/Ee6bW5mv5ykPMKTqPtk
         7aQ5wJWgo+5olIzmcU66ZRwM1AIPe0gVRGtxiBgc/8Zq2dDz34qjCjbp9YZ7ro/C0qGp
         MXzAMOpWed9PMYmG3MMj6CzfFszXuEPq1YSP44bpS5OKMT+KR8KHblLe09Ao6Rpap4o4
         A6xA==
X-Forwarded-Encrypted: i=1; AJvYcCUtFvPCrKPOPBkHZKDUEIcItC6JS0k22Qpgq2O9GUBzpfca94iVSyM/M6jC1MI/hC6phirIvpNu57cLWMfiLAxf@vger.kernel.org
X-Gm-Message-State: AOJu0YyYlZgoBWyIRTJErFm8mTaXT8eN7dD1hX1DPlLIhi9G8JctyTxU
	E4E9lOZSxjS7/dTiQV1ccgu9Q5S38vo580wrA7r+UiIht21WBpbGdrXXJ1GeIiFsK1lv2DTnHiY
	AzxId4CAuMQ==
X-Google-Smtp-Source: AGHT+IEcnTx+9eVhJEewale9PaV7e8ZMaoXfn2kM7AawOJ/bTqz1khtL99S/1RU2BLIbUDH1LiKTinAZaygK
X-Received: from dybcr3.prod.google.com ([2002:a05:7300:ac83:b0:2a4:75f7:2135])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3b8b:b0:294:f711:baa
 with SMTP id d9443c01a7336-2984ed2b6e3mr66196885ad.2.1763004073616; Wed, 12
 Nov 2025 19:21:13 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:58 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-11-irogers@google.com>
Subject: [PATCH v8 10/52] perf jevents: Move json encoding to its own functions
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

Have dedicated encode functions rather than having them embedded in
MetricGroup. This is to provide some uniformity in the Metric ToXXX
routines.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index e81fed2e29b5..b39189182608 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -484,15 +484,6 @@ class Metric:
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     return {}
 
-class _MetricJsonEncoder(json.JSONEncoder):
-  """Special handling for Metric objects."""
-
-  def default(self, o):
-    if isinstance(o, Metric):
-      return o.ToPerfJson()
-    return json.JSONEncoder.default(self, o)
-
-
 class MetricGroup:
   """A group of metrics.
 
@@ -523,8 +514,11 @@ class MetricGroup:
 
     return result
 
-  def ToPerfJson(self) -> str:
-    return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
+  def ToPerfJson(self) -> List[Dict[str, str]]:
+    result = []
+    for x in sorted(self.Flatten()):
+      result.append(x.ToPerfJson())
+    return result
 
   def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
     result = {self.name: self.description} if self.description else {}
@@ -533,7 +527,23 @@ class MetricGroup:
     return result
 
   def __str__(self) -> str:
-    return self.ToPerfJson()
+    return str(self.ToPerfJson())
+
+
+def JsonEncodeMetric(x: MetricGroup):
+  class MetricJsonEncoder(json.JSONEncoder):
+    """Special handling for Metric objects."""
+
+    def default(self, o):
+      if isinstance(o, Metric) or isinstance(o, MetricGroup):
+        return o.ToPerfJson()
+      return json.JSONEncoder.default(self, o)
+
+  return json.dumps(x, indent=2, cls=MetricJsonEncoder)
+
+
+def JsonEncodeMetricGroupDescriptions(x: MetricGroup):
+  return json.dumps(x.ToMetricGroupDescriptions(), indent=2)
 
 
 class _RewriteIfExpToSelect(ast.NodeTransformer):
-- 
2.51.2.1041.gc1ab5b90ca-goog

