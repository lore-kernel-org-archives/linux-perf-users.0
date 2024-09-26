Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807117C9AB
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372185; cv=none; b=ugZW712rMEKiI379ptR7uSWDBPRK4IjoBukYarCSqfJazyWIw2PBMePtbdH/m9HFbUpkYsISWDkyZzHkR02IXnaUnwpNV0qvDd2166mMa1Rclqo32FiAEigX2/tzAF+S5zIF4Dz5eYWDOWqSkmXiNe+Heqau5oCtRrIc2iDXYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372185; c=relaxed/simple;
	bh=j27L+GXsZRPzyM6oYjhYvobTFCzvOew+QVZrvE5Qf/w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WzWPzEH13Ud4u1911qe9roKZbJpsL8Zu00Sr4qqamuE1XqSuHvWyXNInSMzigbNqM+L22v9wSMJWBljPfl67kK21YWPDv8yLnqY6TfTkSpM8ZMmK76bvN43S51XHwIjHjXBOeitWYVQmxDNTWGcRCXrEr+ldVa2Xs1+Cb5q3vMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwTaSzPC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwTaSzPC"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e17bb508bb9so2074838276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372183; x=1727976983; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khk7+EiEpOodwHgWTt1yX5x0DBXiet2yqtmzphl8YmQ=;
        b=WwTaSzPCy6hsJN38tXzZ1MuPMPo3BpZ6SIMVAAizB5BpNFSryPDYNcFfDkFE5lBt6w
         CmlT6A9tbFJwIZuGHnV79GpUYRto9R9w6e4PN1z+b0JkjczA5V9tcdAaRcR6TAhMeU/+
         NG0qqTYHqD1Qt9h9mzrfW0urD/6VzILu1oPFyBDs2vyVNRBfGY+D/a3zjvUOCZawXYSK
         nWV1/6zQPfJJUDTi9xa6eW2P6FjesGsWlriZZvBjTVwkR6Tkis7AddOBtpiqEYiPJUmf
         hsQyhOu7HwhF7ziLpRc2fZlWKGjoWXP71pSVd/8W3pdCvsPr0nGNXo6Vl1hXBFEwFdeM
         Dy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372183; x=1727976983;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khk7+EiEpOodwHgWTt1yX5x0DBXiet2yqtmzphl8YmQ=;
        b=T33JypMPVpHoXG6ODmMWZimrSVhVfDxw+RT8rNe4QpcSkvk2zHrE5LIsrFhr4At3LF
         STsUusBpTE6SM1zqq9ISzC4I5CQF3I5iq7qMPl7kH9y2N1w3frql8QWAA4A6uCiER9/3
         DK9WGAi8aRvaPnRC8+dY3RYhqjIM6gbfOVGbAU8vP3oiPIClLl6PsU6Fq//R0wxnyzBh
         45v/4bvMJWruYopvIB1H52P3dtzD9UcU6H4HMvU3IpPNbsQYzX+xjZAby0PxuFRKTNnH
         CRVSvzTCegUKUPtx51UgGvmM1hSWdI5AZcVY3dHGmkfQNBjh1z3T5PbAuQs29+/Q+X1M
         YqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuYQkXbstZiy7mfMZLK/r/gPTu7ADd0JgpV5d+ImRNxOS0DFZRZBIvLLYwAOfpSS9d2UQryev5meLtJ0DOlnLO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0cERqS5ezQ8BsnYRxh1P62ghbhzz7hQti7aL1bEAMAqXuAqGx
	d/yNBaMDQxfOj8xqzeT06JbhBkBSaVwwWTMYVNwAzYSoc8bNAvzQxLV/myrHuFsoJZaVmGnJmr9
	mXKzHWQ==
X-Google-Smtp-Source: AGHT+IGKMpzXcgy3KQv4XDI/gMP78suYWexjnA14h0X+xSwR4o+sg1dvELNMVAsvj+AX4H3FE4TfaRTTuSHX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:6902:b25:b0:e0b:d729:ff8d with SMTP id
 3f1490d57ef6-e2604b3de26mr103276.5.1727372183273; Thu, 26 Sep 2024 10:36:23
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:49 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 07/12] perf jevents: Add threshold expressions to Metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow threshold expressions for metrics to be generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0f4e67e5cfea..e81fed2e29b5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -430,13 +430,15 @@ class Metric:
   expr: Expression
   scale_unit: str
   constraint: MetricConstraint
+  threshold: Optional[Expression]
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS,
+               threshold: Optional[Expression] = None):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -447,6 +449,7 @@ class Metric:
     else:
       self.scale_unit = f'1{scale_unit}'
     self.constraint = constraint
+    self.threshold = threshold
     self.groups = set()
 
   def __lt__(self, other):
@@ -473,6 +476,8 @@ class Metric:
     }
     if self.constraint != MetricConstraint.GROUPED_EVENTS:
       result['MetricConstraint'] = self.constraint.name
+    if self.threshold:
+      result['MetricThreshold'] = self.threshold.ToPerfJson()
 
     return result
 
-- 
2.46.1.824.gd892dcdcdd-goog

