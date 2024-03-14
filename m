Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D1946F
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395480; cv=none; b=JuCf35z9j41neR2s0NADklpM7vBMAGQrTsa1cqaRRg3izlmpECLAcDFXTChdhvvnWrxX9plZ4v+5OvJaEFUZ60VpDmTB11BVL5HX6nK0O/xSyr8XPLA6MwgJHbV/2K6jqoWcl6s+byEiCRTPX0cYD3fLnkeHj4YVb+NWxl2CFU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395480; c=relaxed/simple;
	bh=v0yqG1/eVUcfK+EPjUe4XPhP/J2eaY9fzjQzfVc6/H0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=akn45jsc99QAiwCRf7AfQ5CmverI6SDWA3KDHqBRRFJCUzoA62NzD5H66g7ZrJ2Q1bPKpStSuW5/Xj/Uy6O5Z40LLw/Nifiga26Sbg500i+KkZSEcTeZs73d720nlso3xTm9K1UpeViNDg8r/At0UsyNpgIHNJ7X6prZspm2+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGF3dDZf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGF3dDZf"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6fa0bso13985277b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395477; x=1711000277; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YCqK+HuTsy25M+g/yEFD0qCgc7u53JD83szShkckrSU=;
        b=OGF3dDZf2gu95++gEz9cRV7zwm6TKcwJNKRZQUqnWplbCDTVE3q2wn8SgQhKO4jkZY
         s08GfPEJEEVOEsyGkK6tFVIJutPfGTZwldy+H510Ji683cjGbj0F60Hr9M6XZcOa3Pw3
         ah3owNM7fOvVrJAinZKT6Nxa0oHKjltFLisKWUloRhKVA/X9Yo/QKYZb7btHGZQPyLeJ
         2zOdjWDXyeYzTTg1qyOFZgb73f6OPxT9gZPLnFHoS0Q4fwAcynr3lAaSjbayd93eBr7i
         3fQNV0CR6eEBweNbmlQDP6AsEf/2dzB3bV9QOb0h044aJE6Yq7QyGQSPvVVbLIFPJyci
         9Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395477; x=1711000277;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCqK+HuTsy25M+g/yEFD0qCgc7u53JD83szShkckrSU=;
        b=PwVlv+B9FAcRpe9iyO1W59fHAtRv5BaqCLg60bTSdNmvkFFSDJ02y3zHwTDRj+MfBz
         Xj+53mUbRFxL82R4ToanwpdugZagsBO8tSXyT25+NgIvleHpACwZwFb+vtwn0mvxtjYB
         dB2Pzt7v37icgLGE+aVa+X/ALY49U8gNVU6aqsPbcgnrdkUBxSdo1iz0VjvgZYQThm0M
         HY2nELLrIB9M8zwZXAqMMT26s7oLHvQ6WY8SvSEjiw+lF47IlsXUGIQvENm61fIneEqh
         SdwW2C5rWg74fltVNW44f85BRZyOj9+FpAI3IEaWM5FASkd0dhsACb3rAfhow18R85Jv
         fvJw==
X-Forwarded-Encrypted: i=1; AJvYcCXoiZrl/kArZlbQUwhn9hBziWGY84pgMFUQSvDM9iTQBdVuN6CpMczdSm5qtzYbDWCDgIwq6kWax5aUgNNNHKVDxfai22bOv9SSeTI+0Xt6xA==
X-Gm-Message-State: AOJu0YwbkhvP9C+DYA9NRLFvDddCIFV0JvEpaKdpcnb22qRHIOlknJl3
	BJVgRa0k77JXyTZQoOMVfuZPp9jy8fq4VLesrNAE7JdZ83mWDSGdH+WFOzGwze8BGoAFjv9o3JC
	dzPX26A==
X-Google-Smtp-Source: AGHT+IFhxtG7mMRDTi6SM6yIa7u6l7RWObt1YAjc3sEUyr42CneABw1rvByHjjYv+EGuqN6cKrznog0AtTg2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2504:b0:dc2:3441:897f with SMTP
 id dt4-20020a056902250400b00dc23441897fmr212987ybb.6.1710395477631; Wed, 13
 Mar 2024 22:51:17 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:50:39 -0700
Message-Id: <20240314055051.1960527-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 00/12] Foundations for metric generation with Python
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

v3. Some code tidying, make the input directory a command line
    argument, but no other functional or output changes.
v2. Fixes two type issues in the python code but no functional or
    output changes.

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
 tools/perf/pmu-events/Build            |  60 ++++++++-
 tools/perf/pmu-events/amd_metrics.py   |  42 +++++++
 tools/perf/pmu-events/arm64_metrics.py |  43 +++++++
 tools/perf/pmu-events/intel_metrics.py |  42 +++++++
 tools/perf/pmu-events/jevents.py       |   6 +-
 tools/perf/pmu-events/metric.py        | 162 +++++++++++++++++++++----
 tools/perf/pmu-events/metric_test.py   |   4 +
 9 files changed, 342 insertions(+), 36 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.44.0.278.ge034bb2e1d-goog

