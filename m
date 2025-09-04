Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61D233722
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960350; cv=none; b=m9s864JjHktcjArpGeInxSJdLsY46ghxANVU+GrSQYtCWZlD5QKoDB+y88Z1S3X/kDBRE46SkSSjsHM8F5d4P8xecJucBL6MudkZ4PUDglj6XbN7rEDRqxmFr5Mfm1WjfaZ7ERN1XAWWUmmRjYNneR6vSz4TLZrtCvDZ6a99eVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960350; c=relaxed/simple;
	bh=ui2NdSfnCSI3LKNJX9yOFKQUdrXm+Z6DoI/4/pw3Rac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sJ0pICwV4bfIa5WV+GuRZmpyD1OauwCYCs//Z/0IJ/MkCm2eYD0ZhR+hQ8cHSr3a1vkjZ3aDLWXkUNXoYZDVWl5bzfZZENKXip3sDSJ8uUV55g2z9jCjbk1ayF5XkPQIcz1Cr1HM4joJPWjHydou8hrvJ8I3I8k5WjNP1mcX7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SwcugEqo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwcugEqo"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4c724d27f8so373725a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960348; x=1757565148; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rY976CsvGExY3BkK5ltk0kMiD/v7wyV09FcFSRUtR+E=;
        b=SwcugEqoec/1wzEA2Y8DGg+rxFpBz/3raSFWIJncK5pqjueIZNurvT5E/c+ZvYFh5P
         do7VcJFAf/ZF1YMUzZhaaG+x4jOodIO0zAJfseqJ8n4M0gBUDrH5mIKzq5d4oyqrlLov
         xTkeb/FgLbMhu+yMbQWa7GI873KeVLXtwV+6nfjDEUP654IEzEhJiREZB1QB5HmU6PFC
         C1a+NSVXJjPQZgOUIixiUHs89wJxEMVumhOGMoFnkNlmcAmAnTI+HA2JD4NnuoxW0Vr4
         Bg3qryQxZgeCPHQqIH0ED/jaFl/5R/J0gvcTjqMSmu1T7QGuV8x2DOSU7k5U1BKQK+SV
         nwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960348; x=1757565148;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rY976CsvGExY3BkK5ltk0kMiD/v7wyV09FcFSRUtR+E=;
        b=YXC2TJGb07aQxfXFFVf2yOSJQ7vzMua2Wz/mfytamNxWV9HkUeJcR/YQf6qmmkM3bG
         R3J3d7bTnU5YMZQEEwiDDi2K9LEiNmxSixZPhHi+49nUeOgfZ/xQO7UJ1khx8GyJ4bD0
         /7glkGKEflwBKR53kLAv+3U3rtj5tx7UMaELGXCTBr8xZ4stuZRIahhje/tNOUEXUFvQ
         RjQNoZoc8h35V674IqYwByma66H7lemSnTPpG4SYLIRuuAgYZ5uW4JNElsg7rowELHdY
         mszTpoJ33N7jUtBFyn1Ugjrd9oxVBhnYZB8biqWjy5t+DtnElu3WLLqW50eXxo1gYb0c
         Qnkg==
X-Forwarded-Encrypted: i=1; AJvYcCUZpjf8IvsntXAtvjWmZ2OIpyF+liAHPGrFUFonV+GkvaurJvVQEenXxx4DAksZo47yQDvr3DuBVip2oHoxx8cm@vger.kernel.org
X-Gm-Message-State: AOJu0YznZ+qtwDFYjchylFqlJ/KZAudD6rH6w3hQE3vxcgBojMAMC8AJ
	txn160Jpwdwno4XCZuYvmjvDUrnT5FUCH79v4bSYty6Tu4N3+B0oe++FtyrTzKBFlHu+OUdxiFE
	xLVFBj7fEWg==
X-Google-Smtp-Source: AGHT+IHQjGaaw0xJYft2AtK/lNOIJoRU1I5rB+ZoDKT0YFs3WNJS6Oo23FyOeJ+gplrMorT1zATLWNom1sBF
X-Received: from plgt2.prod.google.com ([2002:a17:902:e842:b0:24c:cd65:485c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e888:b0:249:1f5f:f9a2
 with SMTP id d9443c01a7336-249446d298dmr219922095ad.0.1756960347412; Wed, 03
 Sep 2025 21:32:27 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:32:03 -0700
In-Reply-To: <20250904043208.995243-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904043208.995243-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-9-irogers@google.com>
Subject: [PATCH v6 08/12] perf jevents: Move json encoding to its own functions
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
2.51.0.338.gd7d06c2dae-goog

