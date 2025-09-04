Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B971F956
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960334; cv=none; b=FnAKL7hKbZtHQ+kYz3Uve0DIPW6HZR8+LPjLOL3Qmh/3cT5TWeI/4MzFfqPKVSSH/oaEOpPo2hp8fMqPHaiT/+wmLIxB1PtQ4G8Aew/glBQXL7ROHMvTPyD9qKUgmi8r/MDbp6S7PlXjFNsnEyWj4q4rA7Yu8cxCQCxrkRRanJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960334; c=relaxed/simple;
	bh=DvIG5o8VCkyG3+iiR4sChSkO9OI8QF9/LCRGzxfDy2w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=SOWjgTSWgk68Y2NCRfIoQZb3vXKK8zhn8hMYE+/SC3IUcw6mrSNB+CAvcBzKFG8pJUe1aw0wC4h3HvizfX95vIDZdTMvcQVHCsFD8Kj6IEO+H1rvcUczxnoz1BWWGANgvUI0rocuOuc9+O/77uOVmrOID+sEfvsePnyCSqy23Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DsN6GQFj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DsN6GQFj"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-329ccb59ef6so619357a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960332; x=1757565132; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GHFcid1YJGvMA53b0mQ4jgpmQ3mh9CCWTdzXo8lYr+4=;
        b=DsN6GQFj+bfc1qlJVGSWlrdLfc0ii9M0mkDcw5cBlTe+rLgPKJH2S8WCBn9y1XFNzO
         W7uWBJhkwisdgpJszlYZlJk2t8ato+oJaihOOzUJDI81qXNnkY4ShqQpa3AFNHehtADa
         9PdC20yaVpAVDtP6rfWl4QvLsL5AqX3yZWgzlwTfYG7yRUZrB9aQ6a1AxcCRvUwp3Bdt
         LZnR8bTA+Oh/2047uJ6CqmychIQG0mb1uGS1Qve1Xh70s0cNVfjkndKSSZ8XA2e6TlAO
         pY2FD/0JgxFKh4j6YKOZs0ZV34jtUtROmR5Nh6z629lSzaCEuATilvYjVK4mSzVSKM8+
         SE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960332; x=1757565132;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHFcid1YJGvMA53b0mQ4jgpmQ3mh9CCWTdzXo8lYr+4=;
        b=J9m0o5Ic9HuuRZDksDtiZEb+S4IdsLg4LbWILPzwSmAh0bwV559/+iM02mgdX2AvnJ
         BkZWA+jgu/zCAFOqeui/WHFwLoTwc42JklfLUztMBNhVyMs3kbf0mq7g54MCxWovn0fA
         riv04yRvx6zxrMMnLsQDARCtZL2+QdjL1hI5tYpt+ZO+u0NzlckxZShEbvtEFeQ6z4pq
         qxm0rMzNqoDHeM1TG7aI9aaHDoUpNZvgkCP6e9BKb3jsuTWG5wgku4x2Xj0cRICkQscn
         rUMc76QpxkQy6QR2yhRSpf9+VBLtSfqOba1WY03tofjqYJIIX4pKmaipk000jzqpHiDG
         V75Q==
X-Forwarded-Encrypted: i=1; AJvYcCWugJI80Eb5XUrJe5afizIhdDqzWK4wlb2odmmQCBRrQrDLSzZkSqvl/xblDrKU20Xvkk8lhDq9ocnPTrAqzj6t@vger.kernel.org
X-Gm-Message-State: AOJu0Ywni7/lF3OhxD+8I72SG8UCHTj3mXk60dL4uY7/67g3i54rvCvd
	CB0uwu+smvN8SYRdFAm+5yG9t8rAtf4b8eEfCasKHF7pYBDTb1qMyagov7RO+5TXVawxZrHmiwA
	t0NiWrBxNHw==
X-Google-Smtp-Source: AGHT+IG64Zkg/gWwEBGyrnEPbkucuhJcvWaoqMmMxF/dbe5BSOW8ZPSmgMkyoR5Ga5n7R1avRNQIQn0VjI+L
X-Received: from pjbsb13.prod.google.com ([2002:a17:90b:50cd:b0:32a:a943:aa8a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f08:b0:327:c417:fec
 with SMTP id 98e67ed59e1d1-328154515e3mr23532465a91.15.1756960332214; Wed, 03
 Sep 2025 21:32:12 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:31:55 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904043208.995243-1-irogers@google.com>
Subject: [PATCH v6 00/12] Foundations for metric generation with Python
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Metrics in the perf tool come in via json. Json doesn't allow
comments, line breaks, etc. making it an inconvenient way to write
metrics. Further, it is useful to detect when writing a metric that
the event specified is supported within the event json for a model.

These patches introduce infrastructure and fixes for the addition of
metrics written in python for Arm64, AMD Zen and Intel CPUs. Later
patches will introduce the metrics split apart by the vendor.

v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
    Das <sandidas@amd.com>) which didn't alter the generated json.

v5. Rebase on top of legacy hardware/cache changes that now generate
    events using python:
    https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.com/
    the v5 series is:
    https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@google.com/

v4. Rebase and small Build/Makefile tweak
    https://lore.kernel.org/lkml/20240926173554.404411-1-irogers@google.com/

v3. Some code tidying, make the input directory a command line
    argument, but no other functional or output changes.
    https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@google.com/

v2. Fixes two type issues in the python code but no functional or
    output changes.
    https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240302005950.2847058-1-irogers@google.com/

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

 tools/perf/.gitignore                  |   5 +
 tools/perf/Makefile.perf               |   2 +
 tools/perf/pmu-events/Build            |  51 +++++++-
 tools/perf/pmu-events/amd_metrics.py   |  42 +++++++
 tools/perf/pmu-events/arm64_metrics.py |  43 +++++++
 tools/perf/pmu-events/intel_metrics.py |  42 +++++++
 tools/perf/pmu-events/jevents.py       |   7 +-
 tools/perf/pmu-events/metric.py        | 168 +++++++++++++++++++++----
 tools/perf/pmu-events/metric_test.py   |   4 +
 9 files changed, 334 insertions(+), 30 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.51.0.338.gd7d06c2dae-goog

