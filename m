Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAF710A1A
	for <linux-perf-users@vger.kernel.org>; Sat,  2 Mar 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341209; cv=none; b=miLX/b+WLmyENXVYHwSpnBmkHblETfJOQOFukAmUQ6WilaS8I6DVMMte7/ebsbzuHGLJ1GxI4mM4+ggf3bhrL/ggL3c3B8Zu6WnxtXBMW6l1B63rCkaISrwa2zcsiWz6Coz/Y2zxJnLmvPqMsLTyP+MozzVfQeTUqcky3Pt4O7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341209; c=relaxed/simple;
	bh=0IeSdmWuvcjIVBTAhF6kJkhdSlGmwLTCZHLsTn46VzI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ezpP4ybvMIezYSwWqrsIMlpAG9qIzUoJx+gJwmLRngP4xDDYXrWHBgtZQV++xuUCl8wyMgEKitpBdVZr8c44yFvCXJzofBH1YIa9tMQFN6F2ETlTGZ2fRx2CFTb1F6H1noBTgqqL7Fh1FHVjUHodpz3dG1sqTuTZpCFyTQuWJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSUiKKTZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSUiKKTZ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so4230963276.2
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 17:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709341207; x=1709946007; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0l9FS4zSa3KVc8IImImj1SVx9SNoPylTIMS2zSJSapM=;
        b=hSUiKKTZMo51O4TPXi6JpFPqXDNBdygWk1alNNT5UMxotiYh9mVdfQhPB97foUdymr
         GdZNLnjq8z2Q8tLWlM1Q2vk4nhV9Rb4An47vFsQVVnbcb0uIkhakLLDsx0H3ojz422vr
         DhD/BoXxAMunHTqXPJ195BYsv/Ak3mbVzjC9Fni3/s5YkIQ4cGpGcgmfBEZPA8V4e4U7
         AI1+2gjO9kx+wbxvdDL06vD7QZVdEh5ONgYkjkv9rb7UqVSbCibY+VAgEshDgSPjEkOM
         d59LTJDnFVa3jYvaFFZT0+jI9pgGNYAbKSzWfSIepmM8TYxUCURGsZt58QAveSQlo4kR
         o6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341207; x=1709946007;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0l9FS4zSa3KVc8IImImj1SVx9SNoPylTIMS2zSJSapM=;
        b=G/A7pIw/cMhWeYZ6E/Ey6KlLw2oZ44z+viXcs9pFPh+1HDimcFLw9RnFjXhgMkp9bb
         ElPtRQ0SQTeNFlq4p/Ssw/6qIhe3aJxS28uio9thK/u+hyJnut4qEs1HSOgrHVhrYzow
         0mPL6lBgCW9usASqhTg5Y0kKhRF8Z/PUYaiT2WaJydI1ZUgr8tSEgN/C2Fvxg3tM9gqs
         l13mIH1SqC7Yqxk5DQInWolDfTsW5VQfi/5sFhXMTUHrervlSpkuBdVMURaxiwkd1gk8
         X5DCa1ZQY6utRIYcmxqCrLFXpMZU2aBbTsZQmbDoQ3ZDWpxVxeubbsn1geWHycfBfWTr
         A1ng==
X-Forwarded-Encrypted: i=1; AJvYcCUKN8K4WHFlKGIjsr7usLfuv0ayTxhexX5rsrIurJj8Z8/mcihhyTgJWZpzmY5jo/ENt7nvZ7OvVA54kfqDpTne3Zp7M0k1b+giAU/7SX2rzQ==
X-Gm-Message-State: AOJu0YyClDGogA4pKNVOUDKXU9rC2iV5oTsb8g/hkFgWV7dKgSycxVnZ
	ri+FG/dJbUSHAAc4QReJZkAHF0Fa2YqxlSSlq4C1/ZmjOd1goDBbcSwpc59Wds7G1naN5IO8P+o
	rCiqm0w==
X-Google-Smtp-Source: AGHT+IEQee9PfjFdXuUYu9MVUX0jdxHct00/YpnBO1NYBsQS8Ffo5pjwxRJKYNCHuvXSoGCpETDnvS0yQNPf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:aba7:66c5:3365:7114])
 (user=irogers job=sendgmr) by 2002:a05:6902:1142:b0:dce:5218:c89b with SMTP
 id p2-20020a056902114200b00dce5218c89bmr130999ybu.5.1709341207587; Fri, 01
 Mar 2024 17:00:07 -0800 (PST)
Date: Fri,  1 Mar 2024 16:59:42 -0800
In-Reply-To: <20240302005950.2847058-1-irogers@google.com>
Message-Id: <20240302005950.2847058-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240302005950.2847058-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 04/12] perf jevents: Allow metric groups not to be named
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

It can be convenient to have unnamed metric groups for the sake of
organizing other metrics and metric groups. An unspecified name
shouldn't contribute to the MetricGroup json value, so don't record
it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 1de4fb72c75e..847b614d40d5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -455,7 +455,8 @@ class Metric:
 
   def AddToMetricGroup(self, group):
     """Callback used when being added to a MetricGroup."""
-    self.groups.add(group.name)
+    if group.name:
+      self.groups.add(group.name)
 
   def Flatten(self) -> Set['Metric']:
     """Return a leaf metric."""
-- 
2.44.0.278.ge034bb2e1d-goog

