Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0918C71EA2
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143022; cv=none; b=YUmoqIDmNI1nuUgai93ayhllGITcxdvcoqsmWsVtuVig6pDDTNz6VbI+7bVcfgrwAK4FkFwXXxyto3wTdt+U22d04r3cwA98J5InjJS/2ToPAjW4J4bT5kunh5JE/GsHLQgP9iVCQweNXX3qOVfDmnFHhXsrfEFKNY3QNMINhn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143022; c=relaxed/simple;
	bh=YRU8U8+xDv3At1J+LdyKbbC3IhjldoIrvcOvRSvL8Lc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SUxHxuungUOsYYZM2aPQ8l34RWQ0c00EUOOiGDAmd/YWLncaXMUaN5PrIYAkc7S5wu1uyeOnQKAFxmHZ9JtyYE4w2dEEky+H+O7kt+Dimb297lQKbjkVpM+MUGv5nW6ktTOKo8bdkrqv9FlSrKyizw4hWSrxF4RjCzcIncyI5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9F7X2ms; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9F7X2ms"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6094c745eb7so229317b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 09:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143020; x=1709747820; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8Zy/5k2whAdLtuhk9uJVeAHCzZsg+vx3YKGl8xR8NQ=;
        b=f9F7X2msOY1NVT21sluW2WqEQpkqjyDTXXm/JcKw71RLTJhTUwAXnaJ7EUo8g6csX8
         Z+4OQBkSfcjeCIcyF/qEfQB6eFTLtGZufxDNi3JSmGwTyPuQqX+SPmoxHm60X4AIOrjf
         mO+WkQHnA+gE/f0dqvvv2sGd/xOA2stnvdIOFiXB/QAjMLnQn3thIlFSgUHq3lNYWPpW
         J7DzGig8oWnkHGropKNWn6+k7Af0lWOP7+NW38kYF7vjv5HVbjzU4G2aUpxKev3I+EPy
         Cp9Bpp+zjVovLF430B7DqwGHRmX8I6rlJGlIkoHX7QfdYRlvP6cKSaThGFYMPkpJ8JEJ
         TCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143020; x=1709747820;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8Zy/5k2whAdLtuhk9uJVeAHCzZsg+vx3YKGl8xR8NQ=;
        b=w2RF6EgUCntbQfwGw4ke7Tgl2j1nQuXmruHmjN7NQxlZvWDM18x7DEXNMjGGrzNkAu
         CTdf5PDDCc7ptkH/v51nx3g+A7OHw2ZrUI/LxEAvuniPnRDAN1LjVa8yLZjEpKOsmXJj
         fFF4giXmI/rLx60wMCiEA5+hLV6QA6YAufFrtu0nAKPqXcjtNjkPL0MNbQFQ1Db+HwFP
         Jm/vgqaF5yEYula1LmP+a/6Xk/zBsSJiwvw35KjLS5gNYen9RNe1DybLmfoqj4vHclBc
         auK0RTl/1URmQSxYUHJH9zb50hMDhi/gDv8qik14Ar4/0gtnI19AFTCqFONLl7MX+teC
         QiKw==
X-Forwarded-Encrypted: i=1; AJvYcCWo8S9JDqI0kZQ8j+hf96tCW1/nd1rb/R/vtLewwFjE6LibutU9zsnD2oJoR5HQ+piGZtrXxssz5v5pQK5MGBU+/6U00aAyWov4GVRIuICWxg==
X-Gm-Message-State: AOJu0Yyd41MzeW/ZI789+MeoAMnF3iolfHdbRkZbG6a4cgweJgOObMJd
	wPghePK0BNGLNsBfQqq+8LYDAokCt8B1BHJ6F3zwv3DCCDTklJaE+ihYE30kCr8kEJmJ9XwW81D
	kGD9Rkw==
X-Google-Smtp-Source: AGHT+IEcnVcrjIxKW/xI+Anl41wk+vCifvb4WaAzGRsYUsAhyybFt98vzONiKDo5dsLAiSQnVsJQbTzHM6eG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:dbe:387d:a8ef with SMTP
 id w4-20020a056902100400b00dbe387da8efmr157ybt.1.1709143019661; Wed, 28 Feb
 2024 09:56:59 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:15 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 10/12] perf jevents: Skip optional metrics in metric group list
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
index 8b37cef0256a..0326050f1e0f 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -492,13 +492,15 @@ class MetricGroup:
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

