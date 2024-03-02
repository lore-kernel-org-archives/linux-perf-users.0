Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988A8C1D
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Mar 2024 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341207; cv=none; b=r6ZSEBhjV5iaJg0PSSQia1HFKggY2fou5d2gXoWcNpMG78MaT3505fpOZst8XWTE32Q6X2KoTyozjyGxajEZqhD0zpXRlU0Gx1PrReHo0m1hyShlyhZVL3CT5lZTY6puEWhgrlCf2Lb6PqrWBwv7TKmN0RLHpKzlE/5pjOUTZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341207; c=relaxed/simple;
	bh=GN4Y68feIoyK84NORTnkVtG7K1dAvlvEPxB9mo8klN0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WY/jtcctyEPAm7969p/rS8WGtoHZAhJJPY6xN6LL7+kqR+WOhA6R33ow8x37mWeXdqYXWgxObU4nmHPwVvlTzQdx4xvO6JUhSCFED3bJKn3YUqzT0XmFutqRo2p4DqsyEZ36zc3CwKjyz9EuSK5Bf1oljpQ9XVHU+9pjmSEuAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lqMq4sXT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqMq4sXT"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608e88ca078so44288297b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 17:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341205; x=1709946005; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnw+7frKkpFIuv39tcYmSQZnvJ8fkaJfcm6LBjLqiJc=;
        b=lqMq4sXTlul76pp7I2oLoCW6U/v5uVo6CEQD4cpCawLPRu5lJlYZuqybKp+AQmLDnD
         jzTwNCgCke0KYsGqOlh25zFNKJDWjSbE+IPa2t3LMXjAcm/EAvQiKM1ofM4WwJINFBMZ
         LOs6NvatFNkFFHYQS8GQQDbN6+9zPaNNt75s76eoiZHXLXrxxRI+PeQOolQ+JjaI3sRm
         E0yxTt4tcA1cUPliGxbNqOfv6GghntCHwSIDBRJj4QY5/jdiA7DA0V0PjxB0L5XBvFIe
         6pPdr6LweaA3CrTkxDUq6i/91bBTdJWEh6lYfVZN+WJaVBMjYScUUcUW6vGEwENrOm37
         zmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341205; x=1709946005;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnw+7frKkpFIuv39tcYmSQZnvJ8fkaJfcm6LBjLqiJc=;
        b=XX5Y4M5fQln+IhMMT2e/EgB9WGiHgLwuAjE6psmp4+6qnmS9eDEdbVnGU+qJtxNsid
         UOaiUuwQNyKj9Z8I+brGCWUFiT6kq4OiQhZpsRpTsyqPVbMcJrqccfYb8lujkaxPAyod
         69Ym/vrK5oB7U0hs1S8drcHiGGLh+3bzFR3zoRvLM+Xr6Rl3VJXgUjlfhSXcv+itbIR+
         6P+uzpv1oM7MBFuRAocCZvu4HP/U82DeR0M4yk6+ujLXncBnkR7vAW1G8duB/kYwiop1
         au5nvF2SI6G09zdK0LzUnZTN0ytIyOZcxekyXInRQw3CLBzVdA61tmdPWw5uj9EbREXK
         xPVA==
X-Forwarded-Encrypted: i=1; AJvYcCXR8bpmg1fAYNKRvCPAV29wAVSwfJfU2xVUtUqXDX3xl2ZcrGf7reoD3JtQ211j1WL1hMcZ76u7x3lTraD0B5YB0WTYhxi7rwNWE5N8q7n+9g==
X-Gm-Message-State: AOJu0Ywy/L0XrdGw66XeotLS+YnhK/qXC7vWgRpzaXNUZP8OvqCHTd4C
	pxJ2T7FFfkpR8i7JNtHgJDia/GWUtEG51pkmx8Hzd04opHXSHZOfb0lVAVQXzbL2k/4RvufV+Aq
	D0p8V0w==
X-Google-Smtp-Source: AGHT+IGSC9+3nntnvVn949Yfko6YHSUhQm4BDhRAsWEHmwZNprbyUHHVU/oK4rtjeaejLT8hBHSD9mJ2bpp4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dc2:3441:897f with SMTP
 id w4-20020a056902100400b00dc23441897fmr721544ybt.6.1709341205149; Fri, 01
 Mar 2024 17:00:05 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:41 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 03/12] perf jevents: Add descriptions to metricgroup abstraction
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

Add a function to recursively generate metric group descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 8a718dd4b1fe..1de4fb72c75e 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -475,6 +475,8 @@ class Metric:
 
     return result
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    return {}
 
 class _MetricJsonEncoder(json.JSONEncoder):
   """Special handling for Metric objects."""
@@ -493,10 +495,12 @@ class MetricGroup:
   which can facilitate arrangements similar to trees.
   """
 
-  def __init__(self, name: str, metric_list: List[Union[Metric,
-                                                        'MetricGroup']]):
+  def __init__(self, name: str,
+               metric_list: List[Union[Metric, 'MetricGroup']],
+               description: Optional[str] = None):
     self.name = name
     self.metric_list = metric_list
+    self.description = description
     for metric in metric_list:
       metric.AddToMetricGroup(self)
 
@@ -516,6 +520,12 @@ class MetricGroup:
   def ToPerfJson(self) -> str:
     return json.dumps(sorted(self.Flatten()), indent=2, cls=_MetricJsonEncoder)
 
+  def ToMetricGroupDescriptions(self, root: bool = True) -> Dict[str, str]:
+    result = {self.name: self.description} if self.description else {}
+    for x in self.metric_list:
+      result.update(x.ToMetricGroupDescriptions(False))
+    return result
+
   def __str__(self) -> str:
     return self.ToPerfJson()
 
-- 
2.44.0.278.ge034bb2e1d-goog

