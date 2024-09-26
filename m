Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFA316191B
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373057; cv=none; b=fpbgbZk+6rr7+AiekPBI7gnW50+oSCi7bPyzULVSekqBOwOxpLV+/QuHctppuVKqXuPBuUXxjpmSJyQfVk8PUB6ColkH2iPTO/foWLbtvguQvexJK4uMVD5rsRXM2QniJvoyB03UlbzckZxqRmRYvbdsYKeUiUXnWN52xFds+Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373057; c=relaxed/simple;
	bh=ICcVxv+UyFgPMNrlS4j3aiB4i7w/ckgDEbEFD25XhuA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gpm3QwCwOYte5i4nbzvKstK79p/U6WwgGH1dPrkkpd7hahBlfXjra4NsXZ+lb1kqWgUs4VbQnBQ0RQiAaO4Eln19sWaUDKV860wp6B75K8kR67MbU7vPhrhvB+Wzqi51Sma3CGc0sLFC7kpDZ/JfUmMzns4eFQWy09JPEizIU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gj8Iu4hI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gj8Iu4hI"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2261adfdeso13315137b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373055; x=1727977855; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4B9vpDYckgMVzZMwIS1VEulT7jmK7bkxMhwxzZt+RHc=;
        b=Gj8Iu4hIDjUYV6w6Vd7tk5muLbWJ3E2xwfAi+eyhK7fXzHnWS753eDjjiyRjrSkMYO
         QIAUraOxhZLyM7OoX1/Dm4hhDtPmxUFYY69ZHqc6jSjQ/tidImvRx/DEKgseEyMWTNUy
         fgWHRprQVgTMb4/KbusMcDn6d2xTAqfdTrb3wb+QMdLS2pGv+noK3B6jYyDyzh/BFAmw
         DeHLibX7Bfql1SJMBs6dASzKV71l9Gg0jdXm9/XsOGD1ZZ0elPb9gAmPX2rpsJ+xhbvt
         pvHHPBTgDaJymLC/TD4aXuxNsiGd0YdsbG4kb2egcbZa0MpB4ZysgJn6lfYF2kXYb2eI
         0eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373055; x=1727977855;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4B9vpDYckgMVzZMwIS1VEulT7jmK7bkxMhwxzZt+RHc=;
        b=ULruWCX4MJBRza9TvZflSaNJXphEh2kma4Hq84EF1uav5apqrXHOquiig1JKagGg3n
         ovEF78hbQ33/tUFCKETtkwAtqlklqw28JFcpXYgy0vjT0LmjnwrHD38n2geZO+7hGZ7q
         JgqDEFNPJpH7dCkpihIhnEykEQ/T15Vw0v9s4sQIaOrx6toi6gVhIZkHnHh0XvreJ6ET
         3wxsuciRfoOkaek0P9q62gdy2lBKfUK+A+9HrKotcNKRLzHq/Cv1jnnsLeUJpcLTp6ai
         QJmiI5qFi7R0KQbIib6YR93S2wVY2rCu56zbqvQ5b1RPM/f0ZtAvwjAQPfDrcq663Ptt
         zWBA==
X-Forwarded-Encrypted: i=1; AJvYcCXi7RIvcjWYi9j59PNc998IFpG82+X4L5du27Xz6nXKAHjJ4OWnI5cUsnqPtZA9ZriBLmeJ+exNvkzyGWrk13W6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl7grJmukNgc2iKy1NkZbLnoV5ISqpTl7Lu2o02OEvFvPf3rgK
	QXRFQOqS0hItVkpROg/Ajjl7IFMp8b5npXnt0J/e+1t6ITVgYt9xd3gEoup3dYQ/pwwsnnUSZRc
	mGsPGeA==
X-Google-Smtp-Source: AGHT+IHu1Wu1yvCEeVXIoy6Myp89+gmMr8a38UxhSha+KdoN53xDvk4XhZ7obE8Tjukw75hteMPc8VyI5Nyn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:690c:d8c:b0:6b1:8b74:978a with SMTP id
 00721157ae682-6e2475a7f4emr52837b3.4.1727373054895; Thu, 26 Sep 2024 10:50:54
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:18 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 05/22] perf jevents: Mark metrics with experimental events
 as experimental
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

When metrics are made with experimental events it is desirable the
metric description also carries this information in case of metric
inaccuracies.

Suggested-by: Perry Taylor <perry.taylor@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index e1847cccfdb0..5a5b149dd286 100644
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
@@ -30,6 +32,8 @@ def LoadEvents(directory: str) -> None:
           all_pmus.add(x["Unit"])
         if "EventName" in x:
           all_events.add(x["EventName"])
+          if "Experimental" in x and x["Experimental"] == "1":
+            experimental_events.add(x["EventName"])
         elif "ArchStdEvent" in x:
           all_events.add(x["ArchStdEvent"])
 
@@ -55,6 +59,18 @@ def CheckEvent(name: str) -> bool:
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
@@ -76,6 +92,10 @@ class Expression:
     """Returns a simplified version of self."""
     raise NotImplementedError()
 
+  def HasExperimentalEvents(self) -> bool:
+    """Are experimental events used in the expression?"""
+    raise NotImplementedError()
+
   def Equals(self, other) -> bool:
     """Returns true when two expressions are the same."""
     raise NotImplementedError()
@@ -243,6 +263,9 @@ class Operator(Expression):
 
     return Operator(self.operator, lhs, rhs)
 
+  def HasExperimentalEvents(self) -> bool:
+    return self.lhs.HasExperimentalEvents() or self.rhs.HasExperimentalEvents()
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Operator):
       return self.operator == other.operator and self.lhs.Equals(
@@ -291,6 +314,10 @@ class Select(Expression):
 
     return Select(true_val, cond, false_val)
 
+  def HasExperimentalEvents(self) -> bool:
+    return (self.cond.HasExperimentalEvents() or self.true_val.HasExperimentalEvents() or
+            self.false_val.HasExperimentalEvents())
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Select):
       return self.cond.Equals(other.cond) and self.false_val.Equals(
@@ -339,6 +366,9 @@ class Function(Expression):
 
     return Function(self.fn, lhs, rhs)
 
+  def HasExperimentalEvents(self) -> bool:
+    return self.lhs.HasExperimentalEvents() or (self.rhs and self.rhs.HasExperimentalEvents())
+
   def Equals(self, other: Expression) -> bool:
     if isinstance(other, Function):
       result = self.fn == other.fn and self.lhs.Equals(other.lhs)
@@ -378,6 +408,9 @@ class Event(Expression):
     global all_events
     raise Exception(f"No event {error} in:\n{all_events}")
 
+  def HasExperimentalEvents(self) -> bool:
+    return IsExperimentalEvent(self.name)
+
   def ToPerfJson(self):
     result = re.sub('/', '@', self.name)
     return result
@@ -410,6 +443,9 @@ class MetricRef(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, MetricRef) and self.name == other.name
 
@@ -437,6 +473,9 @@ class Constant(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Constant) and self.value == other.value
 
@@ -459,6 +498,9 @@ class Literal(Expression):
   def Simplify(self) -> Expression:
     return self
 
+  def HasExperimentalEvents(self) -> bool:
+    return False
+
   def Equals(self, other: Expression) -> bool:
     return isinstance(other, Literal) and self.value == other.value
 
@@ -521,6 +563,8 @@ class Metric:
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
+    if self.expr.HasExperimentalEvents():
+      self.description += " (metric should be considered experimental as it contains experimental events)."
     # Workraound valid_only_metric hiding certain metrics based on unit.
     scale_unit = scale_unit.replace('/sec', ' per sec')
     if scale_unit[0].isdigit():
-- 
2.46.1.824.gd892dcdcdd-goog

