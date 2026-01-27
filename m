Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE9366077
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539559; cv=none; b=IlkKaXejTJ1IsyF0EdDnlmZqjcYQNbh3unm7QvK0zr2DQodMsfx+UnvCho+C+Ng8f1eLGHSpG3ttAEmKaoywn4MOaEE3ImDC75x5IKwkRg2x6Tnhc8+9jH3FP/3RsqZ4wtag0JXaNvyXilNrKTMP5KBnKM0nJHFo7QLa0DIxU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539559; c=relaxed/simple;
	bh=Tg0u9xgINTvX1H6FGlOJHenHBu6latCGVtmFgleOH30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=XJkcIPzipNZXfS8ToIvvlDSFgOOPR3gUS5AkXI7z4NQ5BP2luFlxVzto5hfXeWgHPMuYKdR9xKKPNV9DkuWGgQSL+bV4nMsmqbPkSFSMAuYpYFcKf63P16otmuv2nX3oQu72SWssVuwxKS+p8tibYf+GJE3kbUtckyVSo8NU5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEwtQxXX; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEwtQxXX"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b738854780so6598489eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539557; x=1770144357; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6hcFPxi9yX1voNwD9X4pnHV7jvDzOlcX84euGlTBqw=;
        b=bEwtQxXXM9DPR/NmuS4/qRLFp6uPpjwRTzH6Vod4t81L94wWcZ2Co1p27k8+dJsEJV
         huWuQKBPuyNT+I/hnE4JaVs2xeJoIAwhnJpSEzKx9crfwokXw30Xwvxh6umUuRGqvvk/
         xQYZfrilku3x+MRUikx2mCNNzuO37tLnTUpqjg+g6MMH3svHSl+f6A+0JcrVFAymv6wl
         0R3q/sf5QAg0ZCdL6WFn2ZTbq5hfwIvNVvCt/hIUdyrkxhh7gnwaqRnaVBciDreKA0nG
         fREi93xNwhra9Cm2zyxkteUJfWUmUs//qSN8Bzi8uxTk29VSIplI3hugL9x9e52zV1W8
         L5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539557; x=1770144357;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6hcFPxi9yX1voNwD9X4pnHV7jvDzOlcX84euGlTBqw=;
        b=G2yoSZOJ+rMWkcd6rL40Km+QZXCDXH+vsB+O31feT1tOA1S42UfS6mW4EF1yvZrEUs
         RKUrZkQ06mOhJCowjx9MotxOx8MMZLKTswwKlFt4iv96zH/xK3idugA1JD7YeuPNuz/M
         ea7/eI2h/XU6zv9Qizqkqa0parfRT5MN1tD7Bte0amv4dLspscsP9YUNwCkB1bIPr2bW
         iUacEBFyeFFRcf62e4fXeIfLYyEQDVIw+teHSOcpRqc5WlB+uuqwy8FgkEKfZoBufzl8
         +3D68z0Y58AG0lGuL8eLWg2Tb7XOrxhv+SV2sMNqKn4ds+NpyK2ogLK2TGrsaTKTtowp
         DPmg==
X-Forwarded-Encrypted: i=1; AJvYcCVgAfaTXxO6vUSHkFLg2Gs9klEwsjgC/f/sIuEGxphE1vjWFvv+uVNBNxkMosW9lZ+gn9zZAA/pzVndWFZ35hNF@vger.kernel.org
X-Gm-Message-State: AOJu0YztMkJvlkSzujJvUj/Qe85cf9XRQzJ1fZLA3Lum3saOXJEWPJ6c
	TaVsRHwHdD56+qmntPIoEpP1jcmui1Yqi5IQI7v/+xKdGTvwm/6vEWpk6hxC7HZ1TmFWZ5KK3jB
	FZO0kWoiklA==
X-Received: from dlai16.prod.google.com ([2002:a05:701b:2710:b0:11a:51f9:d69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1284:b0:123:35a4:e8be
 with SMTP id a92af1059eb24-124a006ef1cmr1274154c88.13.1769539557024; Tue, 27
 Jan 2026 10:45:57 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:47 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-17-irogers@google.com>
Subject: [PATCH v11 16/35] perf jevents: Mark metrics with experimental events
 as experimental
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When metrics are made with experimental events it is desirable the
metric description also carries this information in case of metric
inaccuracies.

Suggested-by: Perry Taylor <perry.taylor@intel.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
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
2.52.0.457.g6b5491de43-goog

