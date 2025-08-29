Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFD248F62
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436868; cv=none; b=fjxvy8up0lvQdEpvi8CcqH7TQNjYbANRsTXs/D2gvHPBGr1cHnOjrMIr8lwrrt82LZ8p8oA1LX9LsTzIMzLYRKrk85ip0x75QAN0H9Ddmpxp3QVGOHWRVzjDmMTLYazFAbTNI0uFy7sC7Gb8+VjkK2+ULHUxcjdEApS2V9wDSTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436868; c=relaxed/simple;
	bh=EojQsIdJN1GuyaOl2KgVOYpdyL7ZGtnSEaoqswJcMlE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HN+3JJKZlQCqdjRS9xkUzvYFHpZc8P1743RtdPvH9cRvz5aTHq3/usH1uAmwXkMKA+EnOmSPesOjWA9F7lnzcCJv3uzt04SMXe6zSIL7SRUfiTfTKApAjEE1rsQXqz3Oan9nPhI1P9QZ///qk/aqugKuiX2NnWODPQQs1Vz9UoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ZtlC7wG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ZtlC7wG"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471737e673so2513171a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436866; x=1757041666; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpvrhTjgsn/qk3aSFs928zmUukaE0KfqqZKqz4DFQQM=;
        b=4ZtlC7wGQZzmdh+q7kP4d2YegWDu7ArJj07kTpbUOi/HbtXnA9a4P7WHjxM/ywQou3
         BkeGAOUaCcJz8PrOGVU9F0tp0db9eqmcH+ogT7B60uKKY61wKQXlPsn7LQK8u0imgNbd
         kTneuZZwkOe2HKW4aHlbMcr8BSZRw8mUBX3Q5UZqujpxC6OAQm6qkIdZxoJt1Ige+y4q
         rsB1gW/WTWu34BQZWowR/ATd8dP78B+JHZogEu5yvEGJ2POLr/YdeqVkLm9I+b7Vzrmr
         P5qCHXdfP7oSAsviOaAh8q65aFWc6dtUgZN/jH4BmnnpNvrzLa651Y721F9zXVOuUIHJ
         y0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436866; x=1757041666;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpvrhTjgsn/qk3aSFs928zmUukaE0KfqqZKqz4DFQQM=;
        b=iCdKMnEAM61Ade7owRUlExpZ6HG/xZKBW7dZMoEhoUn9K2hLRvXieg//zdmOaeYpSL
         SjZazAz0jPcFJyriEhhqtIP0MOAoUihGiBpp46LNePxz3CSYvMezW0Px/WCEYFPWTbHL
         yTSfdopcaOVBG5SPwnydAUQZ7IW4Va7rEq/+vB/+BupyJM+tLz7X9BIaNo7VeWR1qn3e
         9aW/DrnIcD0flf7DsF6QJSdIYCeZkEGK5WMfWTiBXtf3PZNNb/ab0oYMBqoqQWzNszN3
         unJYiGdkdKiuRhQbtSbFob7QoqBNtBQWmNETJVXeOQR1uofFehCpURb7QTdfr7gi8s5j
         UwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjBUPkmBmGzJ+Dst0Pwxy4cbTak2R+ksGtI7Ms/23pONmiZH5U2C/C8G1q9UgLcOp4qf4wbF8OcZLiiG7/M3mL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi3X5HaxVaxScpEN/PHY0sd6cew26i/hZLGFfQ4u7x794kd18A
	Y21E0W222xauX1ORuEAulFl94p2+C+sg03EpwY+40LiKpRmjh0/AZmuSSElbZbwPPxQkO5yrA37
	z3zJziQhhGQ==
X-Google-Smtp-Source: AGHT+IFZRJlDlWDv4YCFoPK8CVnuDonQ45vbo7lM64LoLVkiN6b58RAMtn1zVT5LsWMELR8lo5acltefU4lK
X-Received: from pjxx6.prod.google.com ([2002:a17:90b:58c6:b0:324:ed49:6c92])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:244d:b0:243:bcff:b436
 with SMTP id adf61e73a8af0-243bd0036aemr3707842637.34.1756436866203; Thu, 28
 Aug 2025 20:07:46 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:22 -0700
In-Reply-To: <20250829030727.4159703-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829030727.4159703-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-9-irogers@google.com>
Subject: [PATCH v5 08/12] perf jevents: Move json encoding to its own functions
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
2.51.0.318.gd7df087d1a-goog

