Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D002239E60
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440701; cv=none; b=t49CiWahxzqmLswsqabCfFrlOZQYj/d2uiqImx5RlP3AFlOSZCww+M78HuGgI9P36rgXXaDmRCkuQo3eEFnNoA66f5KunpG08QPiYWjZetxUGfTQJTHRKu172kv3MSByhFJudbbu5Phygr3VPtFtEv56QAtwrxuEVohphcR/Nmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440701; c=relaxed/simple;
	bh=MCG6CjoNW6uxd3dkTAQbhonZPPggN4P+ZXSpzIAMvPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iWua39E/pnK+MIy37Za12Xn6Ucml4bn09HefYZtfPAzNg5LJ44nupbVefyC3lrFQmt8MQKbNAgu+QWzDYgDOKr5p+hY8B/0wo2FlfV8/LPUPaj/+16sL1/W9qzM/YtxgYAcjC1eXYLJkeIBoZTbZMMOAlUo60DDzQjqEZzoEKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hq6GpZA0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hq6GpZA0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47156acca5so1356658a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440699; x=1757045499; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcVJ+u3sdC6BnMWHfOHUF/wdZM6izAkF1pUn3DY+eV0=;
        b=Hq6GpZA0HnP8SHNru10Fe0Q496kqLnnjgAd4zHN+XuEwtMgwUYcymMgPOjrIxJ0L7g
         ureQLEmPFp9eazB/5c0oOEXJTf6M1d8sBMdXKimt+M4fUH/HQtFnd/drj5BTJ1rgYV9l
         Nus1/6X+v0PnxTrnZi2DGxpwP9fxFihwxZATpOcrofU1Xp5B8W+t6WjeKh1tpZUBRjHM
         NOkE6J/SNICTG1jLswh26nz2eCjhcCJGJreBzuuXo+O6WygxCvXB1GG9smSa5Cst/5td
         adY82wPqT7ki5A02i4mzuVuu2Ldh4c4ky1K9sBAi7ymfKWWl5KCkbXXCHobsaAgb1hcg
         TO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440699; x=1757045499;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcVJ+u3sdC6BnMWHfOHUF/wdZM6izAkF1pUn3DY+eV0=;
        b=o8kSlVR1lXOaLAnD48OEotTiOY7wIh8yXayLg1Lyo87GPOePsj7BYFELRrQtuYwgOq
         3Z+LVoUO8q4VSIDbaaQRyVkz7YwPHLA5EoDQ1VYjb6fzTcHe7B4hXnLBti6o4syRJloh
         ypxd9nbXgA7NkE0AESZq/ptEVwWNWZYM+Y7Iebn6A3SuZY/xLYYjoBteFknvJrhHeTr/
         cymDiAVh4zJ/hKHQYXLEcTnNVn7bWEfestCsA2J3Q9jTYyMIuMMmTq2kMmyrdt3M6jo1
         tRBnhKAx2N7Wji73VNUo/hgui9oT31gwskpjmURU61mqFyqLo54YZAh9Q88U/dZDua7d
         3g0g==
X-Forwarded-Encrypted: i=1; AJvYcCWA9jj0WI7gyHkhs5oXXKVXwDiWdQ+4aNJmp81PPFglbp/8v0xWRwzHJrTEiQJPlRKZ+H2qPJy1tY227ODoRrbK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5s+rEf63paicj/MeSiDL2lHIgIPXRW5pAgCO+P7edl/ho3n/R
	juSikmSA5BFbfUf3VT3L2eEfLFoE6AgIHBKFM0PSWdW6yHNis2H1NMopKx8tI76DnwledqERs8H
	MxZt6SYnJYQ==
X-Google-Smtp-Source: AGHT+IFMf2p7oY8yto0U37ftJV8URBCPGTUxXUA8ACJh9GFlq97G4+JtuI0Gz8WySzkyYotspgt5TUkUvgtt
X-Received: from pjj6.prod.google.com ([2002:a17:90b:5546:b0:31f:6ddd:ef5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d93:b0:243:27d2:61cd
 with SMTP id adf61e73a8af0-2438fad28f4mr14375530637.27.1756440698627; Thu, 28
 Aug 2025 21:11:38 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:46 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-6-irogers@google.com>
Subject: [PATCH v5 05/22] perf jevents: Mark metrics with experimental events
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
index 4f62f252abef..b77485b47666 100644
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
       "context\-switches",
       "cycles",
@@ -31,6 +33,8 @@ def LoadEvents(directory: str) -> None:
             all_pmus.add(x["Unit"])
           if "EventName" in x:
             all_events.add(x["EventName"])
+            if "Experimental" in x and x["Experimental"] == "1":
+              experimental_events.add(x["EventName"])
           elif "ArchStdEvent" in x:
             all_events.add(x["ArchStdEvent"])
       except json.decoder.JSONDecodeError:
@@ -60,6 +64,18 @@ def CheckEvent(name: str) -> bool:
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
@@ -81,6 +97,10 @@ class Expression:
     """Returns a simplified version of self."""
     raise NotImplementedError()
 
+  def HasExperimentalEvents(self) -> bool:
+    """Are experimental events used in the expression?"""
+    raise NotImplementedError()
+
   def Equals(self, other) -> bool:
     """Returns true when two expressions are the same."""
     raise NotImplementedError()
@@ -248,6 +268,9 @@ class Operator(Expression):
 
     return Operator(self.operator, lhs, rhs)
 
+  def HasExperimentalEvents(self) -> bool:
+    return self.lhs.HasExperimentalEvents() or self.rhs.HasExperimentalEvents()
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Operator):
       return self.operator == other.operator and self.lhs.Equals(
@@ -296,6 +319,10 @@ class Select(Expression):
 
     return Select(true_val, cond, false_val)
 
+  def HasExperimentalEvents(self) -> bool:
+    return (self.cond.HasExperimentalEvents() or self.true_val.HasExperimentalEvents() or
+            self.false_val.HasExperimentalEvents())
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Select):
       return self.cond.Equals(other.cond) and self.false_val.Equals(
@@ -344,6 +371,9 @@ class Function(Expression):
 
     return Function(self.fn, lhs, rhs)
 
+  def HasExperimentalEvents(self) -> bool:
+    return self.lhs.HasExperimentalEvents() or (self.rhs and self.rhs.HasExperimentalEvents())
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Function):
       result = self.fn == other.fn and self.lhs.Equals(other.lhs)
@@ -383,6 +413,9 @@ class Event(Expression):
     global all_events
     raise Exception(f"No event {error} in:\n{all_events}")
 
+  def HasExperimentalEvents(self) -> bool:
+    return IsExperimentalEvent(self.name)
+
   def ToPerfJson(self):
     result = re.sub('/', '@', self.name)
     return result
@@ -415,6 +448,9 @@ class MetricRef(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, MetricRef) and self.name == other.name
 
@@ -442,6 +478,9 @@ class Constant(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Constant) and self.value == other.value
 
@@ -464,6 +503,9 @@ class Literal(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Literal) and self.value == other.value
 
@@ -526,6 +568,8 @@ class Metric:
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
+    if self.expr.HasExperimentalEvents():
+      self.description += " (metric should be considered experimental as it contains experimental events)."
     # Workraound valid_only_metric hiding certain metrics based on unit.
     scale_unit = scale_unit.replace('/sec', ' per sec')
     if scale_unit[0].isdigit():
-- 
2.51.0.318.gd7df087d1a-goog

