Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDFF32ED27
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899521; cv=none; b=S6MIlRGmIWuRT0O9fbA7D5aeqPMrOo22FgTpbCY/BQR/txh1G7ltYGpVkIzeFCNg9pDaVFKyzckiLfNYz1iwf4RcCRTxD59s6CiiM3nWwd6Myb3bl2tpRCxqdFRyp32snZ2Xa85vZfCm4KjUp6lSF3E6tAE7TVy5PyzKtA1yP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899521; c=relaxed/simple;
	bh=Tg0u9xgINTvX1H6FGlOJHenHBu6latCGVtmFgleOH30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lG187ljPwIYGNljS3cmIL6CmPvHe6iGClZwyuRkGHNt3Ba1wSNfkauUQq8VVfEA7mKBupysPHhY3JJLhL7x5gCIbMEVuXjBYo87ddFkg1d/H3t4pk7fN6zhNejgwibT6SJora7MSDk1fFDbfSd0X51H7DD6EnFha1l/QL8GXxaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McqRQs4X; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McqRQs4X"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b048fc1656so4084551eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899517; x=1768504317; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6hcFPxi9yX1voNwD9X4pnHV7jvDzOlcX84euGlTBqw=;
        b=McqRQs4XGBSIDxm6ORpXgMhX0pSfdIRnxiUJwxqt2scDTi5aaNsvrhwt9vHR1C2M0S
         Oazphbmn9mhnxL4UGG+c1AuffqjureuwXArTBNcDT8eb8ZwJknlZcAsH8OSll1YOZm65
         sHlHpf7Sxb/KujWyIL21OnEfXp9Dczw38TQ2Pwd8nxmKC3huJo4TnzhnWKcSUOXVIqgZ
         8MHGNlZMLCHibZrvEYJXiHMNX6CGSNy3lvjzpmfRiKCmEF0KoM8Jjp2pAkGUGGiLYuLE
         xAkT17Mve0FxOCzPrfRoPywo6qXGbIVWIiV6Cb30llAF2hFwK/Vhc1cxqsasu46dcly7
         oUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899517; x=1768504317;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6hcFPxi9yX1voNwD9X4pnHV7jvDzOlcX84euGlTBqw=;
        b=UhDc9hdX26gYEDoGqxkaatAFhuTc6qqLmQpo3hRsataxk3w4Rze//Kr9AXb0eh+ez6
         h7JtPhEJY2eiL0AzxOIFTItlXKlljJPaQiwIs703n8Ay0oW5HCCX030AKgrh0uxONMI3
         UCzgqMoHvl1RTCMrvYIpb8tDMQVjuvoK6A32E/DwfX2pgm+lGMz/o/ZeSyfrhhJ5VPw1
         bSUa1XOrK5HM2pKTJKAyuoOi3JSsZTWvP2rvaRoF0dpQQgvht9kArvu5H/m+7quCejw3
         le46/IEbXQEB6idHeG4Zw/s3+DRB5so/C8ikEi3Ycf+vSN/52cTxeJUX/XhvTef+nrKv
         Heaw==
X-Forwarded-Encrypted: i=1; AJvYcCVAS2D02SODWh2oNUH6RAKxMn0HdiwJaP33Fl6J1uh+8Inug1HKRtR9AlrXb/Sog40LALtlj1FSHzpa8O1MXWIC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4+hF0XG8t66tFCVYaT2kLkafNz7UQbgnMFGFUvZXGUduaM4F
	0P14ZFJKOs7LMuCxQ/VRl3dtE8bfw5RjP7+Nu3M2eXKnrM+FsSAlRwiuydJ/ZNO2sVYMYbfsFGL
	Vvfcr30+bsw==
X-Google-Smtp-Source: AGHT+IFnXtL98LV7vbdXX6Sbkm44nwMtzEAp7tcF6f64Sgqk2vPXeIucA35xnhOTAotUYtCEXxX1u8HTolEQ
X-Received: from dyboe6.prod.google.com ([2002:a05:7301:3d06:b0:2ae:3555:a1b1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f54d:b0:2a4:61d1:f451
 with SMTP id 5a478bee46e88-2b17d224539mr4078280eec.16.1767899516637; Thu, 08
 Jan 2026 11:11:56 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:46 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-17-irogers@google.com>
Subject: [PATCH v10 16/35] perf jevents: Mark metrics with experimental events
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

