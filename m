Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064263CB
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Mar 2024 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341205; cv=none; b=OkbyG1DFleakk1tTmTh684RqNy6+l1bmP35QFedI/aghMlFriVofufiG5QVloRPCC2wTV1q5Y9Pdwy+IIFO90J5rb/KM+8qtTu8PDpLNIHClB8SGY62QOMuDSyza5Ot5caugnNWPEvR3V4hOMvN0PPPk0LYnqR6p2UpT/6y1AaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341205; c=relaxed/simple;
	bh=hLfRLYYEBDGHVllbq1W2MRKFt2uEVseZ3ckqP7HQcJs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CIgsCuCFekDqrEB4qp4fXEDQ15wc+pBDqFD6nSrqQE6U7LRjKJIoIVQnkapd03y7rRwbYNUEclBoQFlkFdSSXTt4PjKc/YBui2W0RYKDbEvba1ZQwZyXUvSOTEZB+bAt8bWWM1hcAbbDf2mKx9wvVzsKd5xRWboiGBEGRaQI/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFk8W1dH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFk8W1dH"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so5227211276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 17:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341203; x=1709946003; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxFo9HXrMBHPfRGQr1WhtYDEqITe1Fw0obEsjgP5vwk=;
        b=AFk8W1dHLucI1lzV9klBxz+8G+cQ/sXQjH2CxBpRsZQwpR38Ri68XuEv5uSefbaDDv
         9PusemxFaGn+WxpkCXDjwhcrLlrA7+lXHeOJLdsLFWohYIJo2Ao1mbK6YztCF8NeuR1P
         9wibUWh2mP6xD94pZ8fVzbhpG+bBkgCEudKC3epFPaAXvOtYAYUBt+Jr6Dn5/Uz3WNPg
         ESSkDfNL4qPCNvJPZPwPFBFW/A2HAznQvxis7ROGx2CAcREa2h8pPMZEMcKaN6qK6S8N
         DegiEgPqYqmzNZOMuldmg3Ci2iNzN6QcsRleOYlKEuGM3/Yy97nKFR7NWXP5YIqppC2u
         EzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341203; x=1709946003;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxFo9HXrMBHPfRGQr1WhtYDEqITe1Fw0obEsjgP5vwk=;
        b=Zn+3q/fHXTWIFZK6JgN6DYM7g/WGLqSiPgM6FA7h6leFI7x5VDnSsnkzN9Km01hUsU
         QjIzPiyFhvbO2BwUMUvb4LHCQ3G8uN8DtqAxnw+x/PHAKWfPFGeDVQ7c0UKU0A8ChcUp
         cdpEsAJrAsdzBONqQZy9eOOyt10q+E5cdR9OjjPi/970x5IYMnV/7/Um3THJ2lUqU/f5
         Rl+/AaoIfIcbzjAHKMsjnspeLcfDcmdV8xEQA1Xk0FCpn/Wn2hMVg/PdLPLF1HhABvN0
         mktAKeOpbymSu8l4Xa/V+iA9X4cCi8XfEZabazvMuc8cjItG5jzEqLrR0/IwnqBwj2ww
         SfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXapkTYLiEeZV9riYKEYYvKrkwkRmQ2TL6gxTfs3cuC2zjhR6o4R/QjlqOB7uipIqqtIimKhaHUDtx6mMZMfcOhOMSyc2ihNU+1Mqqk7wnUCw==
X-Gm-Message-State: AOJu0YxNWc/vDHUQ6g+dNASC5DZiyXCtwVkUFgL9ajgstkRTOUEik7Yo
	nN0yCNk5gPNWK2dGT2Ro86ayncO9jPcUU8ViOJcOkvPG5McrhmczzuuL/pW2vHPumrLGkBdaGIX
	adPmnSw==
X-Google-Smtp-Source: AGHT+IELbTz3gewzuBUQeWefqRwNUhsFbXWyJjPH4NG6Rd6XYYHISDWKcqTJ9Xd+wlGNJZUgpVUuazYRvO5P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dc7:5aad:8965 with SMTP
 id w10-20020a056902100a00b00dc75aad8965mr766000ybt.0.1709341202870; Fri, 01
 Mar 2024 17:00:02 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:40 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 02/12] perf jevents: Update metric constraint support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Previous metric constraints were binary, either none or don't group
when the NMI watchdog is present. Update to match the definitions in
'enum metric_event_groups' in pmu-events.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 92acd89ed97a..8a718dd4b1fe 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -4,8 +4,14 @@ import ast
 import decimal
 import json
 import re
+from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+class MetricConstraint(Enum):
+  GROUPED_EVENTS = 0
+  NO_GROUP_EVENTS = 1
+  NO_GROUP_EVENTS_NMI = 2
+  NO_GROUP_EVENTS_SMT = 3
 
 class Expression:
   """Abstract base class of elements in a metric expression."""
@@ -423,14 +429,14 @@ class Metric:
   groups: Set[str]
   expr: Expression
   scale_unit: str
-  constraint: bool
+  constraint: MetricConstraint
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: bool = False):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -464,8 +470,8 @@ class Metric:
         'MetricExpr': self.expr.ToPerfJson(),
         'ScaleUnit': self.scale_unit
     }
-    if self.constraint:
-      result['MetricConstraint'] = 'NO_NMI_WATCHDOG'
+    if self.constraint != MetricConstraint.GROUPED_EVENTS:
+      result['MetricConstraint'] = self.constraint.name
 
     return result
 
-- 
2.44.0.278.ge034bb2e1d-goog

