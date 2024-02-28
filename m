Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415615F301
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143003; cv=none; b=EFd0+oo3xJ1ff3qoFLumVbyzb7TPnrU0++Yy5S2bJRwB71pGObOL63z3oRMoEt2Z3057IdM0dlvAEA6jKQGJb6XORRW4v5hyeHhwmMvnC2pcAYVwEBlcIty/2fYAbwiGn3ubwSWz80lCOPIi+Zvil5tytjDvOFUZunblbSiE9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143003; c=relaxed/simple;
	bh=hLfRLYYEBDGHVllbq1W2MRKFt2uEVseZ3ckqP7HQcJs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VDWSiCrc0f1+skUb1EOONgIY+6Wgdbpz1vtB/8ykXxIjrBjoFlYunRqKpxsfP/zqsmZn5cURE0kmBNNA/BLlLq5eyzNoI3V7EwCVT5QC1gz0WfUeRipfxerfgaTmgBIZ0TDK1j2LRrciBQcDIXptO+CrtsqsJLJ3mONogYzvQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EEQMlXMe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEQMlXMe"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6093a9ac959so133767b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 09:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143001; x=1709747801; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxFo9HXrMBHPfRGQr1WhtYDEqITe1Fw0obEsjgP5vwk=;
        b=EEQMlXMehu2kkINHdKC4Nd90tvMYxa42cvHMTpxCitmdYviHQUgpN+hq4ZFrc6hL5p
         qQ8RN9xKRkNh1YwK0hg+cSJhqznjAdT/m2SFIEkF050SETIOeHcqkzjZsdDNdQ52BB+x
         120WcQK22Nmbi1m31nlqNCcj1rGAY6DWb/s1pUtVUnX0s/SLIrRZhfeI2/OIXzKZcNGD
         RlS28cgdukAFdY6OSS6+cS4ahgtI2kP2kwiGH5XquVCN1iGxyU3GVNgmsLBto6KYNvxf
         zZxJAgd35Xm92L8Qsty0WO8KJHtJbF+8o5W6fPY8uIb85jJYOxZw90/S9bPf+Dyzcluh
         j3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143001; x=1709747801;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxFo9HXrMBHPfRGQr1WhtYDEqITe1Fw0obEsjgP5vwk=;
        b=NAVx1qWeEOArOPrB5DBNLg/ris5rkdfNYVT/ZaOrxgeUIPXUprmzn5S/NF1789WR9d
         Hh6aV21thioKp4oCpzrTCP4PaAA5o9cocRkUSAQO/gch7WUd+YOuPt8BP0vl6gBZVUeu
         WBCirIPbaFGehFrvOzJAFFWebonkAWsVKMVjJ2I2A+8qAhTHzYVigUKjlK9oKonOCowk
         pwQ33CpvH+eTrPowDRoER1PMZcEt3dCYfvS18bmaIsWBiZF/Nfi7MdtYLfoGU0i9RTlb
         RzuIoQxq6l70Hp5Ws0Hi7e0yUJJ9/eYX+E127wny3ROWOK55VBHFnNJbdvNUjaZgIr3G
         /AFg==
X-Forwarded-Encrypted: i=1; AJvYcCVut9rokgLjLq+4eQseDJVzcHGqfg2t9vsMbwFi+w/z7+L9AlVsCptE7VNTTxPS0rhn6Cm/niRrCOWdyvE8qJL+eAHnVypuHkPZOFt6/EBtjQ==
X-Gm-Message-State: AOJu0YwYHOpEapKZFbi1AoeKtrKR7jw0cGZHZH+XWrrD8fyZgLcQHIMB
	i6ZanQLTLOPzSB2unBDijb+b3Hlh8zY5+/pjzAA+975hCXC4fWQ3d6N/PkoLmkCmHx1xtMGhd4b
	agIcHCg==
X-Google-Smtp-Source: AGHT+IEq8GXay4myjejAWocOtx6DX9DWikTGDj1T+upRTt2z9E4btVYwgR/ZsPdoTsHZzGcTLK4aFbpA6w+l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:120a:b0:dc2:2ace:860 with SMTP id
 s10-20020a056902120a00b00dc22ace0860mr115ybu.2.1709143001286; Wed, 28 Feb
 2024 09:56:41 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:07 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 02/12] perf jevents: Update metric constraint support
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

