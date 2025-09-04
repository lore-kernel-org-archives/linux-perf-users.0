Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D042246799
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961230; cv=none; b=osNqQG2YKI8eFWCntr53XO12IcIYOSPP5MrsgAAeNBCZMaqZKwdDZ8RryrX/Kqc4fGBIUAvwwUtYWkfjPlIkSObAwJk+DsvRfhPg/5IIhzHhzcnq89EA/y7Ofx35giRNeR6ELVGJMlhBi0XtTSeyh7RcYdZn1IbDlAhJfQTKB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961230; c=relaxed/simple;
	bh=UcY6aUQryoh8TWxf1R5rbeHWfSRESoDPu///WKm6rBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=F/Jf5uN5ONKxxxdsNle45RFilNFKKWW4P8V8gKI+E2fbMewIsimMBSgrnWNY4Rb63APRtLl8zVEBJY//m4IRjG53KEKQS6cZydKaY/hgaat+gFo0BfZTwYxcP0EOCuRj+bLBDevbIJXXOqtkGuNyfjthM6pRctuVKjcf8i0oH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpin8Zs5; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpin8Zs5"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581953b8so7128885ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961227; x=1757566027; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vy4CQkIGw7/lVdg6ICrys2SpjapcPPfaM0IjFTULfsw=;
        b=cpin8Zs5nAeBn31n/mLQMps/QqL3XKGsuiG799z9nO81a3FGaOIJcgMQsWP28oCZBZ
         a0vPb75c8IjKZj28k38kE4mbqEMhSBjRUf1b72WbeDJ7jfl8QbyIM32A6ek2wbYA4LTW
         /WMa0NRbYNGaGyIOY8MwpVK8R0NXRvZwWjoOA45CduVHrgjiVvGqflprk3l7uJn6VcKh
         sF7QjxiK0HY4fmM93lHrqgSLNFtfYM8WR6X6bEXxiqAh3NpeDw2rdme8yShhS3TEDCxJ
         s0f4FQO/a0xUQVgUPCJr1IumTH1NbZRCNDZmfEYPh5oE95Jz1clSKGKxw2amjiabLHm7
         /7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961227; x=1757566027;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vy4CQkIGw7/lVdg6ICrys2SpjapcPPfaM0IjFTULfsw=;
        b=ZCXLmTmx/kxRggl8IjJzqmkC4I3rAEZ6BeXCFhG6QTsaBDCvRqoY5oCeqLazj9SG1f
         NNedoy0So2QoGa1JH+hnywTzIetQA/iTUmCXYAh9epzA7FuHIykLLyy9vw7TZGWRLSxH
         pDYijflvjlKk5QWOQORhYIEP0O112ZagCjd5BlOhazMUrJ3rfub0thR7uye8nq5NCVaW
         htFGD7HNL+/0WLm1g/9aFcVjb5vDr2tN4TpvFA6EpfgEZwrDekxDGBzFeU/2HGUl2eGJ
         e+ZAjSuEKKBKa+4hN2Z9XskFK5RfUHH0CpusrZ2OagAtSlQZOW8g66bHSiq8pCL9wnEj
         cEDg==
X-Forwarded-Encrypted: i=1; AJvYcCVZpxfc5B/xvLX8f6dz3QhT8+8grYi5VXEl9BIW7ajv+WLe35TZRCptLjten/EDoI8QpQNgWdIN4WwrpI5qrGwA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx89bzcGMAdgbdWJZoVEl7KO2ewWGdcjyGp09w7JSQPZgPzTrO1
	4kgtlpS0A3rU1Sxo2XB+hSrbN9ucHNSJ4WcJz6O3u180XBVVfbJd7f2A5Z9BsyY3F0EM28401pJ
	F5zR7lIsp0g==
X-Google-Smtp-Source: AGHT+IGvaXhWFgpP2gOrDYUhC9zmZZdEJSiWs2T/nzXa5g5BaVwyIBI+T2aP0gEM+R4bWkCrZ2xoOk8Um3rr
X-Received: from pllm8.prod.google.com ([2002:a17:902:7688:b0:24b:66a:7448])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef4c:b0:246:8b9d:2519
 with SMTP id d9443c01a7336-24944a73e9bmr216703555ad.23.1756961226639; Wed, 03
 Sep 2025 21:47:06 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:46:36 -0700
In-Reply-To: <20250904044653.1002362-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044653.1002362-6-irogers@google.com>
Subject: [PATCH v6 05/22] perf jevents: Mark metrics with experimental events
 as experimental
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
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

When metrics are made with experimental events it is desirable the
metric description also carries this information in case of metric
inaccuracies.

Suggested-by: Perry Taylor <perry.taylor@intel.com>
---
 tools/perf/pmu-events/metric.py | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 62d1a1e1d458..2029b6e28365 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -10,11 +10,13 @@ from typing import Dict, List, Optional, Set, Tuple, Union
 
 all_pmus = set()
 all_events = set()
+experimental_events = set()
 
 def LoadEvents(directory: str) -> None:
   """Populate a global set of all known events for the purpose of validating Event names"""
   global all_pmus
   global all_events
+  global experimental_events
   all_events = {
       "context\\-switches",
       "cpu\\-cycles",
@@ -32,6 +34,8 @@ def LoadEvents(directory: str) -> None:
             all_pmus.add(x["Unit"])
           if "EventName" in x:
             all_events.add(x["EventName"])
+            if "Experimental" in x and x["Experimental"] == "1":
+              experimental_events.add(x["EventName"])
           elif "ArchStdEvent" in x:
             all_events.add(x["ArchStdEvent"])
       except json.decoder.JSONDecodeError:
@@ -61,6 +65,18 @@ def CheckEvent(name: str) -> bool:
   return name in all_events
 
 
+def IsExperimentalEvent(name: str) -> bool:
+  global experimental_events
+  if ':' in name:
+    # Remove trailing modifier.
+    name = name[:name.find(':')]
+  elif '/' in name:
+    # Name could begin with a PMU or an event, for now assume it is not experimental.
+    return False
+
+  return name in experimental_events
+
+
 class MetricConstraint(Enum):
   GROUPED_EVENTS = 0
   NO_GROUP_EVENTS = 1
@@ -82,6 +98,10 @@ class Expression:
     """Returns a simplified version of self."""
     raise NotImplementedError()
 
+  def HasExperimentalEvents(self) -> bool:
+    """Are experimental events used in the expression?"""
+    raise NotImplementedError()
+
   def Equals(self, other) -> bool:
     """Returns true when two expressions are the same."""
     raise NotImplementedError()
@@ -249,6 +269,9 @@ class Operator(Expression):
 
     return Operator(self.operator, lhs, rhs)
 
+  def HasExperimentalEvents(self) -> bool:
+    return self.lhs.HasExperimentalEvents() or self.rhs.HasExperimentalEvents()
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Operator):
       return self.operator == other.operator and self.lhs.Equals(
@@ -297,6 +320,10 @@ class Select(Expression):
 
     return Select(true_val, cond, false_val)
 
+  def HasExperimentalEvents(self) -> bool:
+    return (self.cond.HasExperimentalEvents() or self.true_val.HasExperimentalEvents() or
+            self.false_val.HasExperimentalEvents())
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Select):
       return self.cond.Equals(other.cond) and self.false_val.Equals(
@@ -345,6 +372,9 @@ class Function(Expression):
 
     return Function(self.fn, lhs, rhs)
 
+  def HasExperimentalEvents(self) -> bool:
+    return self.lhs.HasExperimentalEvents() or (self.rhs and self.rhs.HasExperimentalEvents())
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Function):
       result = self.fn == other.fn and self.lhs.Equals(other.lhs)
@@ -384,6 +414,9 @@ class Event(Expression):
     global all_events
     raise Exception(f"No event {error} in:\n{all_events}")
 
+  def HasExperimentalEvents(self) -> bool:
+    return IsExperimentalEvent(self.name)
+
   def ToPerfJson(self):
     result = re.sub('/', '@', self.name)
     return result
@@ -416,6 +449,9 @@ class MetricRef(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, MetricRef) and self.name == other.name
 
@@ -443,6 +479,9 @@ class Constant(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Constant) and self.value == other.value
 
@@ -465,6 +504,9 @@ class Literal(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Literal) and self.value == other.value
 
@@ -527,6 +569,8 @@ class Metric:
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
+    if self.expr.HasExperimentalEvents():
+      self.description += " (metric should be considered experimental as it contains experimental events)."
     # Workraound valid_only_metric hiding certain metrics based on unit.
     scale_unit = scale_unit.replace('/sec', ' per sec')
     if scale_unit[0].isdigit():
-- 
2.51.0.338.gd7d06c2dae-goog

