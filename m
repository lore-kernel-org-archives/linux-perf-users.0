Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE121F0E2E
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436856; cv=none; b=D7gRZStta3UnluWVcpOsCwB43eHfb6Vp9DxoPyejcxNbq+IONx3eMkNFcahKGXghJq6Fx2tpnr3ogzWBSra/+iun4fdt9gNLGHvy3qimCIYRLUCSHkHwGbnPJxqJMhInL/6l1amfUZt1/AnLpHZ+N5P27yDQE2EeW91MlJPM5Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436856; c=relaxed/simple;
	bh=myK8Ob4Z+6xtsYGnGS9ULJ3rDZoc2c71W+1gOq8NKi8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=tnyEsDRbwOdK47XQzS/yu3IJw3DH2tjddPOjJ4+AcWz5kRnAiHhzjK/mhG80AMDXoFkCnsIz920p8mB86irqCx6DJ2GhOcgunsFmutfcWm3uIhokVUalQjP/Mmg3UP/Jq6+NWFN31Vm2caDmc5a8YN8/e+C5Nr4hG5yQwgneYDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xE6QN7La; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xE6QN7La"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e931cdd05a8so1927027276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756436852; x=1757041652; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qh3dRbQ2YjEIVqs97MUtbBBgOVsFDMVUksL5khpmJT8=;
        b=xE6QN7La11NR+OgASaAX/EV3xx++BMVLf+TZo8wLKzHwAvuzuIcNw91Gn+Mcf2YzZY
         CawY1Kbm1KfnTLtshTsxKQT8XYoLS/tek5RDSWA/05u15NkPmnOhwq0+RAVriw9bUgMT
         6T1nnqwhm5+IUdBsiS9C3eTxY91PbGgmWfiujTvfSnzJQL6Ip/EidevRs6k0b5j2D3HA
         AAZoco4igWz8ExOvujUb0YjuwWW8L0Ppvtc0OTE2gbE5/atGO/Ro8OawRahfbboiJcss
         HD1gc2A2vfAs11w3Jmp80amWDnpdKJFEifJSew4UpTNCq0uNcdSSf/JJoNMi+BX/4QaX
         NNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436852; x=1757041652;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qh3dRbQ2YjEIVqs97MUtbBBgOVsFDMVUksL5khpmJT8=;
        b=L9k5FKTZCNjbnCn/9TvKFEtCyovL7ylpb+wVHMiT93CrO8zfDf6K3GAAULfy8KGgha
         hMbSGldpAPxrYSnTqlTDyOS6ZGcH3wMvB6V2GCRKVUjOMKzyakZVVUEmC3C2htAOjnX9
         T0UNdQLIzK95Q5PGWqCVCS8lkiUB3XF6A6ICWz5YjwnZG6dB5V7Rv5SEPquq8ufds0HV
         rcTFXPWDqX0WDHcokHmg5Td9o3YNKtYVg4TtAT4MBzrDx8KBLFSsHrItor9j1+ef1Yct
         1l4xIvm/84XHzYfdj0PqFHSWDa6LHvPuaMcxx+04e9CiBjQWCG1v2PrU6cYkt8tRzr/q
         7INg==
X-Forwarded-Encrypted: i=1; AJvYcCVnYwdjn01RlW4aAoOzxyDBsazjnmIPnDE9KJgxrgsXrCMfbUv6tsYsdhFqYveFu837wBaQ8spvf1y7MnGxw/hS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cP9WkDkbT/By02EWrqq2C1fi+ypdq4S4A7A6B/TyLs3Zyc7s
	NKdNi4rvyyuKi9UESmgAebrBkl3XCc/HK1wvFrXTc4dzCrS3jA+IrwZsVxNz4pfMGdiEf0puw1O
	upKITTrAz4Q==
X-Google-Smtp-Source: AGHT+IEVlqUOzA+dwPlYTvOtuR3xWLzmYPFD7Sdkj/WOvIopxDYefZlt2klRgo2irI/knjbDpLzFNt5MwzSY
X-Received: from ybey192.prod.google.com ([2002:a25:dcc9:0:b0:e96:dc7f:dbe3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:1083:b0:e96:f9b8:ba7
 with SMTP id 3f1490d57ef6-e96f9b81721mr8563691276.28.1756436852119; Thu, 28
 Aug 2025 20:07:32 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:07:14 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829030727.4159703-1-irogers@google.com>
Subject: [PATCH v5 00/12] Foundations for metric generation with Python
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

v5. Rebase on top of legacy hardware/cache changes that now generate
    events using python:
    https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.com/

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
 tools/perf/pmu-events/metric.py        | 167 +++++++++++++++++++++----
 tools/perf/pmu-events/metric_test.py   |   4 +
 9 files changed, 333 insertions(+), 30 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.51.0.318.gd7df087d1a-goog

