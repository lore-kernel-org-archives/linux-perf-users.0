Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323222BEFF6
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004064; cv=none; b=JYOMkFs3OkKYBIh15beqlXFkjFnQhcKUeSyK14d+t4JcdwurmZfw7UjO+V8kg4Szigm9usZB5dxdCcQ2vFXRIY3q9/rzhXLGlTInTYgyjHn8mN1ZVSicRZaFCqvcpF0sh75ZOJmCXrHgFmJQEYOOaFVymEFe62G3fMnRO54x5sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004064; c=relaxed/simple;
	bh=tYsowJQC3XmZaz5ErIOGUojnYFS6/SkntpcCg4rFgo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jEhF6U1bsqbFyaUdQvSYs5CCr8/7X3HtInV1ikSAtVZXkHyKHjpmuSy/8U4qnq2ky0Gyp3eV+QYHYx+Q1f3P1qfCRp07Eo0Wlr3lMMI3Zxera6g7Jo06IRsFHtHLsxsjGIKcQ+s7gv38mGk76D8++qWR4yh9FW0HD9nKxDAeeTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oFpDxLJ5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oFpDxLJ5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29809acd049so4379305ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004063; x=1763608863; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MFgvesH+kTyveYGZlQiv6HZpbvhsLLX1RvQTQqUiK+A=;
        b=oFpDxLJ5oYnkzTKgURYMDND6WXpyXycqLZc44AB5lKBAuFuEnOwpXQ+nqV5X/uZKvH
         WFnufcRg2h1QyF29b0RY6JzqJbvZzQRZ1p6rnNJJgjR2+vo9lSEhWvfJaDbzNQAe5/aS
         uXg4FOpARDlN2QRs+C+pWW+DyY2Bvj8CR+GCAuWEqjtyceD+eNVtK7Gi/OyZPlxgKkrx
         pAP55U0FIioKTR2KZXWUAwUlsr3xS96ekIm5YR+Wyb7qKhR36nB3EjPt+4xDITTZ/e9F
         J5LJrq895NEDgwJi0st8xKqONGp+0M8w7TfIEq+W/0md+eU1ocxAKXNBzyGAn3GMOzn/
         fkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004063; x=1763608863;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFgvesH+kTyveYGZlQiv6HZpbvhsLLX1RvQTQqUiK+A=;
        b=TTNqba6b0aEZFC7Hd+ozdozbZ5ZJH9zrHkA9nBfA9Z9DsEWQPFF5f9eUXDYiCqmqUf
         0TgPzYoKpDkixigCVOD7cNRo1kmqD20Tnv/RMj6fLsfPLJvzv9DAE2+8l2RWmF9b/J48
         r3HT6FTC/i8/CmTyYyFJ4K8xJinom/hHJDe20DFjsF9yN8s8NEPUmUKdPYE8LCwcFrY4
         uXacaSS5zfKnBZrESIqvOTvjw32suk7JxUl3qFGXzERgpajdX+ezvu/FkfAg9DCcQmYt
         CegvRv7LlCrRxeQ4sM1a0V22LLFmcA2GdKEU0m/53pO3fF/z+9aJRbL4s12ElEUGgmmg
         7hVg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Q4/l1ZuEWlkqJ0eUJ8M3edkaFvJlH7fRaoQ8S2ywI40aKCpUwnA3Rbd8gRFSTmdUPyilmxgP6eqjwJ89pPNo@vger.kernel.org
X-Gm-Message-State: AOJu0YzZEpmGivWK9MUo0FgAkC/QkQU8UZDRpCAnAZkNR3ieSrV5jcuZ
	4ozFmj4bdbGgkN94JWoW/DAfAR7hrBwoLZcCzL44Zh9do/nHeL4JAVunbmRd8SNWv5mmfMUt/9g
	8co50UxuJ8Q==
X-Google-Smtp-Source: AGHT+IGlhJYGQ3CNKn2dsb3mcAqgi6aTk5XGGTBtc5HoSql/Tn+WinTVMANEpovmiHc8WXVQH6mRoOwsyhC6
X-Received: from dycry9.prod.google.com ([2002:a05:7301:1009:b0:2a4:791c:9e95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c7:b0:267:f7bc:673c
 with SMTP id d9443c01a7336-2984edccae7mr65593405ad.44.1763004062470; Wed, 12
 Nov 2025 19:21:02 -0800 (PST)
Date: Wed, 12 Nov 2025 19:19:52 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-5-irogers@google.com>
Subject: [PATCH v8 04/52] perf jevents: Update metric constraint support
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
2.51.2.1041.gc1ab5b90ca-goog

