Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B05DDD9
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395484; cv=none; b=pwpbs0VNLWdwxgf1VdMR9jFeeNPDqbCWGVV+EZL9zkW5GEbmzohYv2G1WxaOXYSXRKmzcgFn9UrvT8CWK7fFbDikjeVuvn+ukuUA70XL1DQMRo2+gZMrdfAvl6S27nYBH07hqRhhVyVcRnhhFj6zIKg/vA69JaYvh2pK3mauVEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395484; c=relaxed/simple;
	bh=hLfRLYYEBDGHVllbq1W2MRKFt2uEVseZ3ckqP7HQcJs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AmNGKoR/uHbZn39VtirD/6/AH7O8yXOBgfUX6oqYpiJuypcqucsm/ZprQQZvymwi7lBqGIzcmuGZukIsianugDZ+6lGiFS/mrzsELQ5n3R2/XpQX/FbnmNE8m6WMrbbGsgEBDqhlRKL34DH7eJtOD1+a3Z3NPRNDs+3hYRsiDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvYfaUPj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvYfaUPj"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso1338585276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395481; x=1711000281; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KxFo9HXrMBHPfRGQr1WhtYDEqITe1Fw0obEsjgP5vwk=;
        b=vvYfaUPjXrX5FwXQ52ksdJXqqZpVHMCEtLRQBNlEu5W3jpwxXl3pVw9Ppz2lIm/uT4
         U5PH3DAndc7Y0z2jiKU4i21S/DBhYKhGBp2P3tXkOo4Lm4cMCeC+pTQzdJWMwqcq+y2Y
         T9mEZSqQYF4eLTsHw2Jlw592pCVuX/uWQalrPGXWD8EDVoAJJDefFFHn5fQ8PwAoOsOZ
         4k3XhaZUll0e/tOuY5mNkPf69ZyckGhnmQ9p5fDDQjreCRwXpxfLj46v0VwS6KDVaLe5
         8XnnbHpcE7i/V8lRKIlqwzV/Zbp3hDwRKftiwQPjsEL7gdcFzZRZNf40v2qrZ6+AgcuR
         L7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395481; x=1711000281;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KxFo9HXrMBHPfRGQr1WhtYDEqITe1Fw0obEsjgP5vwk=;
        b=rlhjK08QkFVHBC4Ho9RI3HFysllsMfxqmZ4lybTik6xQflt8t0YEn3hM/ARd1lPXh1
         vfKrsJCNi3/TlCVkXbVvWKpRGgRIOKlhXD05FaWM5w5OaqUGRtVr2Xjf2Bai2CfmHl4v
         mYjvf2FCJIrjvGb7Or1uPOiuZzET/yYBhiq743DQ/ESiKa1VpkyZj1piac+SZOgrfh83
         xqUOgmR+QtyrTslic7n9zbWRXLE6QvEzYhXDXV0VlBH2jyYjlU+gW8xrNiyf8pfnos2/
         dEDE2kedtStkeM3pd6+D1hZ3vKWWJ3EBmogD6rnr4FT44if0/wV951O8GOTAg0eNzs0E
         ln+w==
X-Forwarded-Encrypted: i=1; AJvYcCVKbEUXVp0FeHI73YULf/gFOZTGciTkiNq/MgDpu9RKfOvyyu0qZWlBwzkXJWYv/QgpDv9Zb6XI5hR+rEszNni7mlszGN5iHsORADFtMMUARw==
X-Gm-Message-State: AOJu0YzygnO+uJqJxGtIN49HzbAWsJ/GO/s3hAoPYyZN35PzRijT8cna
	VEojWd95MyummmscmQYUU6ZaC3lwlMzZ3ZYzjK3zPyYmpc3imK3zuObDTMI9KvaRfWDYiV4ghIl
	9IArNMQ==
X-Google-Smtp-Source: AGHT+IEX3XhByYWB+A84RZSWQnLA6MNuWBZhhdltJMDC98o5Yyv1SEyQ5sd3VauVnhEwit4sY9Nz/bnRToWj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dbe:d0a9:2be3 with SMTP
 id w10-20020a056902100a00b00dbed0a92be3mr255447ybt.3.1710395481665; Wed, 13
 Mar 2024 22:51:21 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:41 -0700
In-Reply-To: <20240314055051.1960527-1-irogers@google.com>
Message-Id: <20240314055051.1960527-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055051.1960527-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 02/12] perf jevents: Update metric constraint support
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

