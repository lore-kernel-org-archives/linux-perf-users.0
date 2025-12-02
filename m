Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4D2DCF4D
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698012; cv=none; b=RoUnUHzhQdiw/W7RMGCGyANnUbNkltLsupkOwTUHRQ0grsRsdkjxNPNTu0kFNXfwNmqodK/2DwGFB6d1E3eDueuv2XfgQOYYxlyai+DSkbmFyDZrXHP8EScuZUfxNP1EXrwsRZe+jLSfHVO4BLCrp4NIRKhx3y4fAWudv47o9CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698012; c=relaxed/simple;
	bh=MZXPJkMLlvQNY7LHqMpGBAhv97bAcZIryty0ZB5qdjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=FogdkSZL6UUflCrRG/yUoqm4ENIDPwY3C1TAZ6xtuvPQBlyHa85w3hroATnfL77bQ6EG0AQsuVMMmH5u1Lzk/09BBu0AOwu3QT/pm8wqp/2m5+FOZtgIAOWmIdZFcIkdoB3uQCbWgn1jiRBjMGNCXbyz3tRXrD6R+looFnURRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcGtmwUq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcGtmwUq"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297dabf9fd0so75112385ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698009; x=1765302809; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yKsrOLMclOdMSfZ+6mo1yB+Cr3YWn8XAIMVSOQS/0A=;
        b=HcGtmwUqgrOxpCs6Sj1Ixtcy7mcDHImackitLrxcRAJwp4cGOEClyyOYwxwSVSjhuw
         OPwnXjlZ9bLaDQsmkrXDktzhSMfRJY4HrlyU/+s8Mpde3HL0Sz1OBwhzNgHoyBNJ+XQE
         uGC9FfsSivXQWy3AOG1TOg4+hWchtGXrnlU1P0GEnCuMRl3MKABAmHppdWTk+li8xZXN
         gbjr9g2lvLs9ZT85hzQHYMVvrXSw+EH2JRZo+tW4jNwDegJR9NipSbD27HiSxpFIK4bL
         RWlxrgIHH5Wc4SDo3I6dLyTuoS0EHPctvLRdjstkygHIYsfmtwjyYMvA9gNMnnwFDFr7
         ht3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698009; x=1765302809;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yKsrOLMclOdMSfZ+6mo1yB+Cr3YWn8XAIMVSOQS/0A=;
        b=Co13CtxeS/oM5lwkF4wvlSlO6qu94WXMjM4Q/lrTPwklvkUXB6+ntD4LTcP5JaojHH
         q8giUCTrAtCrRPdunSiEQiNp8Aq5G8aKy+/c5HQYt6EsKg4wI+MeqvlbjZJOsTYMfjjX
         vd9QYbS2YXJGWbbFQg1gLNLpOVnYHEBc1tWT7+IohFf20p3f5lRArrkXirutyeDkjeOa
         Zug5RPVCpSpcHMDhXkvo5eSozreQYH9M4EbJ8GI5NOVjjV3wDzifrw1jSIemJ8BhuIH7
         W53WOUyXXHn6LYfvyibvEXeg132lGLrdVf8B+AMWLTuSYJHeE7Xmz42uAgltLBcdUs6Y
         Gzcw==
X-Forwarded-Encrypted: i=1; AJvYcCXVN6K+q9kFxdYUl3TdRilOmB0+cMmqT8nPucEAZEyXebgMIpUMUlXlaOVlpgtG44oFPkvPejIeW+8u1+0fdB2Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzopbcmkvawZXWuxu4trd6cEUWyn/zCvp0MTCkZlJAgIQBbfW/9
	HJnoTaO4+pVCK6JBjTuNr0n/XvGpKH03LuOtM4kQi8PzYf+pTNLm5DurxgpVyuLg7LHOJxKO/1r
	wnuOXWShXlw==
X-Google-Smtp-Source: AGHT+IFSIde/+fPa+0ZqRrpBH+S18iPNZHaJ0ifGIDW2rIQ4u05BWtnonHxrlryeIKv0J8KmlzXSZM6K5qoW
X-Received: from dybmz9.prod.google.com ([2002:a05:7300:d4c9:b0:2a4:6f9d:b3cb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6a9:b0:11b:9152:b3ad
 with SMTP id a92af1059eb24-11defcfa65fmr154636c88.31.1764698009304; Tue, 02
 Dec 2025 09:53:29 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:23 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-29-irogers@google.com>
Subject: [PATCH v9 28/48] perf jevents: Mark metrics with experimental events
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
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When metrics are made with experimental events it is desirable the
metric description also carries this information in case of metric
inaccuracies.

Suggested-by: Perry Taylor <perry.taylor@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

