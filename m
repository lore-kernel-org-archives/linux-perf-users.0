Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349940870
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143015; cv=none; b=rKYOGKLT9RFyaj+i8AzNjaWwmk/RlPBc7ECuHSQstv6/IQPT+V59P36Cv/Olg1H/Fj5RyDOqA/ROC+vr5/761szrqR6Gzuj+oVN3LKimPHYrUSQsCx57AkTSNecASUvVoiQyLvtFlqDMN4IQ21nfy8ytB7WM8vdaSHjs4W+YbA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143015; c=relaxed/simple;
	bh=VDOIZB9jv6XKeIi5ciBHo1jjSFStukj9iwmjW2zydxI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YipT75Ij1S/8eP2UXf/S03JPe3JCATsPJZ4LZrOMSMRlx1amcVcen9RWLLQsXGqyYGLE8KzCCWO0O7q8yXpgjVrEOqBUxy91760E9RgILWQxIpShrca+klb7+ZM95tmK/w95hHWlOQqpsHNpbNKOWKmVllHGWCCtP1488khXBns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpcmE+ak; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpcmE+ak"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6081639fecfso270427b3.1
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143013; x=1709747813; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dr8pGAPnm6Hh2FHAABPwd7yyauYEbKCnKNWRhMVNf9o=;
        b=qpcmE+ak8GjFEcjjdFkETjUC44tRTp1X5zI7spij8h5ZqwGauVrdz39torUqmyakhb
         kY7c3u1JI5O+uRPz6EwHqvaEYDaQjgymxmFRHZibiFPRo5PFpK6sat+uPOFfKfocYRrB
         Pqgdse6NZc4AkhFwHW4eM5E8xTZsAVJYFOxoSndpQ+PLVRzEp94Y/n5784mdCviLkfDO
         nLcEwjP8TvIjx6sCc57WejRH93dQ/5WuCP45QsqAsOc/oklBg6W+WWBS0lDvtdfpaHaz
         ilBkC8iOQtvvXUBESENQoI30bqghCEal08tkdUIRUuJBsgtJHHpMRLcRupnqqWCMAXrX
         RRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143013; x=1709747813;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr8pGAPnm6Hh2FHAABPwd7yyauYEbKCnKNWRhMVNf9o=;
        b=GUDbUpNDk3MFTWeBicS3XFTFYfErg0qGndOpdQCSrDoG0Gi7SrqPm6WwV47k9Sk6V/
         ymfJJkd4HL/JXrGR9iP2AoPrR7HGZCAJSPHPPdqo+NARWNSq/xpmIKoOeWF4xRFQ20At
         Q4aeNORBBmteQPn43WJlnrAo/aK7+L4rNriJ9uIsQX+OMYjNzeqKYJ+mTEDP6QmKUZu4
         SqS/svAf+OtTDOLPghTidApZecJdOmDtPtB7X0FWPU/afqFvGwgfwXmxhvPJa8CESJ8f
         2Z+eKNQMqhntqU/cS+miXE+nJVQ4M+L+tDfotTN7WWz6WStCc3ICrUQ0ClAmnzFY9Mko
         bpJA==
X-Forwarded-Encrypted: i=1; AJvYcCVKUb8KtwMOaAT2J03NmQXxjO5otM0EdsrXQre0+vBCtVP0WdGe2A2ovs39qx0pmc5fvc3pEyPAXtnLoSP+wUjYcoWZXvbyy19klhYHwclXgQ==
X-Gm-Message-State: AOJu0YwMXkIdp06GvT6aBqd9XdQOTVZTVE2eRWEv1sHRyCDAdvDlGd5z
	1m3Y5KvDsOLyxE5+h9UvUtqjdsHqVy3upnmH5XvSUABg/BAzFa7t3tLhko7YON4AhvxQrjSBsui
	WGjn0FQ==
X-Google-Smtp-Source: AGHT+IH6/L4/fl5k3WMgjzNZDKuBn6F6mBEdOU4E1X3sxhco++aAA3eC4ZMTl4TJDhuVG+tVrXm0l4xms2Mn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a0d:cc57:0:b0:609:3c40:e31c with SMTP id
 o84-20020a0dcc57000000b006093c40e31cmr379602ywd.6.1709143012824; Wed, 28 Feb
 2024 09:56:52 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:12 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 07/12] perf jevents: Add threshold expressions to Metric
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

Allow threshold expressions for metrics to be generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0f4e67e5cfea..88022b7f08f4 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -436,7 +436,8 @@ class Metric:
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS,
+               threshold: Optional[Expression] = None):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -447,6 +448,7 @@ class Metric:
     else:
       self.scale_unit = f'1{scale_unit}'
     self.constraint = constraint
+    self.threshold = threshold
     self.groups = set()
 
   def __lt__(self, other):
@@ -473,6 +475,8 @@ class Metric:
     }
     if self.constraint != MetricConstraint.GROUPED_EVENTS:
       result['MetricConstraint'] = self.constraint.name
+    if self.threshold:
+      result['MetricThreshold'] = self.threshold.ToPerfJson()
 
     return result
 
-- 
2.44.0.278.ge034bb2e1d-goog

