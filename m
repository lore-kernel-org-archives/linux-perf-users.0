Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D932D060D
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697877; cv=none; b=Cu63+H+Z8tC1LfCzY/uUm22EKu8A9Oqf5Dm1l1J0/XNp6teWS64ZiarlKjFm7dIke/Er6nYvFSUj2VP/T8eoawkcmgOANTe/GlmVoEJ7zQK/AQmfGBNQyDRxaBKj6aZuk4H8JqZX6GTJjrUnicZCzDR02nMwLEzHaflYCpl8mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697877; c=relaxed/simple;
	bh=zWsUZ4Jd4Lkf2jf3z0CVAWHU02kQFxP6PvAOmYI09OI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KOhW4hC2HHiEy4bpnpI3cPc47EGHK7TV83Hm1ZpmfOtfgUqWzn0v+sAwv1dc56QgSntW1Kvm+miICH0e3lmnlDRi3KSS1k3PD+THSoioJx1SbpUvfm85N+5KsWUZ4EaOnylrjyBPZRrV698eKK7CMqPbbO5n3uQ0wm5I8HjeOyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QKqxWUS3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKqxWUS3"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b98e6ff908aso12790413a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697875; x=1765302675; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6aZdi80Fw/yhQHCdjNqAk6626PinK1Z/Zi9xmvaQPrs=;
        b=QKqxWUS3EQfFd2MP14UFXPIpXBNeinF5//MY4+uRHuYCBNnU9GO/eBtIyd+rhsmadF
         Ggc2epk1CbCPUbmUGdzxCUFSFb1nDqTp4WJy388doM384N5Y+/K1ORxt9OusnIx45xlr
         UxzPD60R8VcRm/wXZ7Amwbng3XgPOLqQHec2FRni/msKiD10sl0K9V9lYi7JTRLJBdTg
         RNwt3zduM34gDnPtkq0sP4FOs+W4a5aTNssEkFS6zcK7QfqGuwLqUfvsDA4Utpm0BP6V
         dlRhjoBKB21vOklHAZEOAEq4nkwOudvv2LOMiUWlGAtBzugj19npoxRY9FJ8JYCBhLLc
         ev8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697875; x=1765302675;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aZdi80Fw/yhQHCdjNqAk6626PinK1Z/Zi9xmvaQPrs=;
        b=YUxW7l+be/t8u3ivqqD5qjBB0c7An4xJV/w+k8PnBRWx1SsDs5pgF4hbIXaTC8RSSw
         s9x/2ds/YyAWQ0xZP/EDH3ebCyu2iRQSYu/h7rTNar+MEk6AOwAq2LWboxfDv0DpPNtl
         3ebUbu3bVfaObc2ZZrvLZoneyMg5mrwffWjwS8cA1R9pZRm09Her7eINaU2ewA+sbCR9
         TgClPTxwOmZ42IgbgVylaeZlTVP+r9mJKaz1G43Jal491jKmT8KafSkB9fe3Z0gSAjnb
         77eV2DpJgM85j8OfEUx0C+dOqj7ZK7vwMhBYX1m9XQMZB2e9W33A7lHvWUGzFcWIaTvG
         WQ+A==
X-Forwarded-Encrypted: i=1; AJvYcCVQxgXQLIUOdAQVSqKbpoSDzgUe/nbGUnZFVHMT3+4QQCtBJW34ZP3Fq3QT/QcwtwZDWFaSriXsDo04D7ZV/eov@vger.kernel.org
X-Gm-Message-State: AOJu0YymoExY6wFxFLnxnqEFab74cH7A2Rat9hSpIuw3RxDXzQETUk/k
	o5DrAfBKHuMXFsmnXu4X+IYIFd6kBoCCqm/uLVTkN9qqK8KdEdCFsz28hPZdi3KokvKz/pBjF5p
	TYrqQEL/skA==
X-Google-Smtp-Source: AGHT+IHQ3drzwVFWP9Rr4fIeRTF6kB1LO25LBjckRv84mcshBe+KzpJd8FyPPHJt4tRinWRy6ElTcBm0c6S3
X-Received: from dycsa11.prod.google.com ([2002:a05:7301:10cb:b0:2a7:2596:88c5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3c15:b0:2a4:3592:cf79
 with SMTP id 5a478bee46e88-2a94189a935mr23692758eec.29.1764697875166; Tue, 02
 Dec 2025 09:51:15 -0800 (PST)
Date: Tue,  2 Dec 2025 09:49:59 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-5-irogers@google.com>
Subject: [PATCH v9 04/48] perf jevents: Update metric constraint support
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
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

