Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D6222F1E
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142999; cv=none; b=YV8Moh3uhIFgDvunopvdAipfQ6+QI/1Fn80bG5RobDA1V2jQZ31Da9msVegTkimZBgSKnUSFPIYkv9HdfmMGa0n7CHu0tJUDXaBf79NpGbgP7OSfaqFniu7No/BTRfMNB6UVrwDwJq00TJgRDvVmLKHet1tkPUxbRHFEMoIL5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142999; c=relaxed/simple;
	bh=cOSS/1Ua9wq56tvIpYDJ8CrDZP5VRQvshAeIJk9Xvn0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=SYdnt23twEm2luJNUDmmdKueM+LCzYpalW6U5SWJc5dsGfy+GWqG1eM+BiRcWdmolJUdxwv3Yn9BQwp7i+a3ZOKqDGQTUfymh/dJOg3yqFuV/6BqWUaKfkKGfD2FlKdA0INEHusot9zwxWtu8dvDovjhgEm668PR6lFDwTv3MMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KB4hFA6Z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KB4hFA6Z"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608cf88048eso512287b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 09:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709142996; x=1709747796; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7O4CvRNZfn+UEjOY44M9tpmLWuj++SEP/MSXm3BejXo=;
        b=KB4hFA6ZCGIjV8ZDZ2C0v5HaRiY8o0Qy0YM5AcnAQumXn1cumOjPgQtGhugxnJMt1H
         7p3Cn8R3FtD0iaiyb2Y5GL7oEjB4ZkyLvOPBUUsRWVjvmco2EjzRqo9UpiKjkDpRtWy7
         gcTeJD76av4aFtra5aamnDpi4IYTp+/T2SJqrmTb6XbvH9MImc0r7vyoXpQNGIcM81S5
         XzDf9PgcGhDbOQXGKBAaB4PiFAlEx3zqBGv6kbX8C5Lt6kgyeeFYODwuNnsXzZkAxeAI
         CmlrUVEvFaBiIq4/638I6Qlw6G/7bsuuCmsWSaN21me7TpGqw82HyRX00uJQCIiksMFc
         rReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142996; x=1709747796;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7O4CvRNZfn+UEjOY44M9tpmLWuj++SEP/MSXm3BejXo=;
        b=HV4VY3GTNt7XSc5fDu9ElvV1kEUkRuNM03AJERBrzXjMKLJL+vvoNtDiJ26khrc5c5
         DzBfcrLDZzcXwECh9oLtCRKw2uOstuJHyFkWXR5v9jBZr+YmAUGtov4ylWmcbEqBIcb0
         4oT6cyPcUIJVcE0UocF0+Mk1CgVK0D9Nw7aK12ctewVO6A5M5+iBuUl6YEKzmhSWhgaW
         dZufMdne3++v2k1xgBXHzvERzFayeM8uiP5rMOiAzvaNRaTqG3gjaYO6U3jvX9SiM4uu
         nK9d/tAYpwcEXhcqE0ORnY8in1SDY0rN6eMYb2pRcbhEBPdklBGFPKM6KEJ8zkwfClHb
         mYqg==
X-Forwarded-Encrypted: i=1; AJvYcCVqgwr0aJFbEnv4day6kQb8bYOj5ZVxY9c8Agh+a463ZLiRQytmOhrFUVfwrtRkcTlfxTIMnoGEoTSMqHsTtNHMRsZWYaqZQvf0lAQo2xYrbg==
X-Gm-Message-State: AOJu0YyT85sXnvF/4DiLZYOKUXec43RAnNDIo2Wn4msYEJZb+4L95mEN
	tgK+Plhs5zeM9loCxr3SHmBYcG+uuHSKe/O19km7S5762LIknZj9xJR0E4wCL6VXbHzM5xLGBvB
	T/UVagA==
X-Google-Smtp-Source: AGHT+IHwE5Lde8r9OdRkQnnVGT5Vmdj0kN83iNwxsK7y0HzPs5jDUBlzWZZKIresVxcYRVTbmcpsx4U2SrNG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:72b:b0:dc7:68b5:4f3d with SMTP id
 l11-20020a056902072b00b00dc768b54f3dmr806170ybt.11.1709142996715; Wed, 28 Feb
 2024 09:56:36 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:05 -0800
Message-Id: <20240228175617.4049201-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 00/12] Foundations for metric generation with Python
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

Metrics in the perf tool come in via json. Json doesn't allow
comments, line breaks, etc. making it an inconvenient way to write
metrics. Further, it is useful to detect when writing a metric that
the event specified is supported within the event json for a model.

These patches introduce infrastructure and fixes for the addition of
metrics written in python for Arm64, AMD Zen and Intel CPUs. Later
patches will introduce the metrics split apart by the vendor.

Ian Rogers (12):
  perf jevents: Allow multiple metricgroups.json files
  perf jevents: Update metric constraint support
  perf jevents: Add descriptions to metricgroup abstraction
  perf jevents: Allow metric groups not to be named
  perf jevents: Support parsing negative exponents
  perf jevents: Term list fix in event parsing
  perf jevents: Add threshold expressions to Metric
  perf jevents: Move json encoding to its own functions
  perf jevents: Drop duplicate pending metrics
  perf jevents: Skip optional metrics in metric group list
  perf jevents: Build support for generating metrics from python
  perf jevents: Add load event json to verify and allow fallbacks

 tools/perf/.gitignore                  |   2 +
 tools/perf/Makefile.perf               |  17 ++-
 tools/perf/pmu-events/Build            |  60 +++++++++-
 tools/perf/pmu-events/amd_metrics.py   |  22 ++++
 tools/perf/pmu-events/arm64_metrics.py |  23 ++++
 tools/perf/pmu-events/intel_metrics.py |  22 ++++
 tools/perf/pmu-events/jevents.py       |   6 +-
 tools/perf/pmu-events/metric.py        | 156 +++++++++++++++++++++----
 tools/perf/pmu-events/metric_test.py   |   4 +
 9 files changed, 277 insertions(+), 35 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.44.0.278.ge034bb2e1d-goog

