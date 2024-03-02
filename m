Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E94B1775E
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Mar 2024 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341224; cv=none; b=rbKvJ9dpjJUPfgbgbvSb49HY3dSCGm0NguksL3e2RcW0wy0hgoXevEjcxNwjg80Nn8IVY1aMPjIOZOiJ33dv2eZYk+RErrY18lmofqllhdJuakwsO11bbDhckUgM9VFUDYinbDNVUv1IQ5bRCU576twbNL/AssVtpJLqnt88968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341224; c=relaxed/simple;
	bh=gNv29+h0IhWRsa2qydUVk3E45fI6zH8amlK1YqhsJZ8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rXtODrd++4AL7DNBSmU4qB5J80EHDotoMdkjP/1swO7C7NQ67Ncf50Bl1GtoLnazk0UYzy9Yb5TTvajBVLUE5GgGtWEQfH0mVukwT8pu117Mzj+0apSettiedC4mwtYDY2D9y0qWpQYm9lRKtn6Ld3Qlcch5GH9mvsOcAhXxhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vAYyEJkI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAYyEJkI"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dced704f17cso4669729276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 17:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341222; x=1709946022; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGG+6HzWesnJ1eAogyUwc6CZn4obQaKW0ElKvKW4EMk=;
        b=vAYyEJkIzKm3wM3sYfkjG86tfhIHfz0zDBxf4hrKBdXdaF8Q3BLphix7jN503LOtUr
         oRSN1f7cw2v3j3PIL5O6XBCvoVRNLZTGHGsPwq5PKq8MLlRe1xjNgO+FI4iPH0KcEHVX
         7ry9JV9SZ1wD/AkGaLxQKEATB9tQ8XA77wKH2YZ8VlTPXLTwwzuFncDvHqCqmjhnmbUT
         GhEGxGZbkKZ0fTd0BI7xLtTyBqXO/Eg6yKbVCAVFtSOPy+LVlbwt2OEDEHLVvOOQwGNG
         JeqgjYEwmaBarD2jEuVr74SS6VQk6MYNXnm2V3WwMM/WclQeIaxhNEEV0UXo92nXi77z
         t2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341222; x=1709946022;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGG+6HzWesnJ1eAogyUwc6CZn4obQaKW0ElKvKW4EMk=;
        b=qELpMO615V1OuA0bglfd8Ms2q1o0AAaXvaEOMZw+CnCrSbqVnTEXF1SGGlKr2JK81U
         +Xy2/PBTy+DLrZNoarFRscmSWardAua9cyrsAdT4BeG93Y/L5e2ywjZp4fIab7oH7Ha+
         X6fRPT1+eL2VdJvAn+GGKyWbsZBg9Dfzel810irXGghuj9KCzbp0kQe5zW5xfw9lDULI
         FUdyEtHskqeal4FOygOj3wZ2tzqzX5RVnDEzIWUr+rQuSc14EkyWOipnJaNp24DsnwcC
         wsWsf76cePCm7gDma0qvNeC7Ny5z94tdxB0SYe+UW2Vh31HhKjeiGYKuW+vvr5+wnVwV
         thlg==
X-Forwarded-Encrypted: i=1; AJvYcCXJy1NJ9wAkKG5cMbxEjzTZN+HV/lnOR1HsUIEhXgZUZcTcv6DCC/xaj7eDbJzn/kez84yYePnQ3gmAdfhbt96ElRYrLECnQ9rrWsGoL3s4Cg==
X-Gm-Message-State: AOJu0YxQcGmK3LJudNoLmUhHk9SoN1hlfHaPMfsG7+XnIkBlWz8y4Cpi
	GEuiAbo2DNVVF+28mB7M+0iB5HIWaNnAfj/j0TRfRIRBgeGMKhtOHt+KKJ3pQMe25w+k1xb1QcH
	GZTRprA==
X-Google-Smtp-Source: AGHT+IEDT0a1cF/COTR+zfNjTWLmtLyKszjeFVdW+uX9ckcDgw19khnjUVFTiddUyFxhTQ/IZ4Lq3aX/OMy7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:690c:fce:b0:609:e1f:5a42 with SMTP id
 dg14-20020a05690c0fce00b006090e1f5a42mr640571ywb.2.1709341222105; Fri, 01 Mar
 2024 17:00:22 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:48 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 10/12] perf jevents: Skip optional metrics in metric group list
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

For metric groups, skip metrics in the list that are None. This allows
functions to better optionally return metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index b39189182608..dd8fd06940e6 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -493,13 +493,15 @@ class MetricGroup:
   """
 
   def __init__(self, name: str,
-               metric_list: List[Union[Metric, 'MetricGroup']],
+               metric_list: List[Union[Optional[Metric], Optional['MetricGroup']]],
                description: Optional[str] = None):
     self.name = name
-    self.metric_list = metric_list
+    self.metric_list = []
     self.description = description
     for metric in metric_list:
-      metric.AddToMetricGroup(self)
+      if metric:
+        self.metric_list.append(metric)
+        metric.AddToMetricGroup(self)
 
   def AddToMetricGroup(self, group):
     """Callback used when a MetricGroup is added into another."""
-- 
2.44.0.278.ge034bb2e1d-goog

