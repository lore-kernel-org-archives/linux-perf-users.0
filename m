Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762822E337F
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929699; cv=none; b=IG59IiTLMnzE9qA5gKIyljoCQ4nal31xAiJtiVMvkdu6CeRbvi+Po76CginPdImFIMH4LMV75W7SL7CmLFxXAhHgQIEbs4DOaZRoJ8dBuyNMxo33EbLlkxxZY7ahdAjuERBHvWWRJtMxEtjaXXpLL3SvfZKOxJDPMv7+haWWT30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929699; c=relaxed/simple;
	bh=KGzHV4AGIWKrWBs1lNyAyJSkG6Kr/7d+ZtUTrUzoltM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=p+fIT4zWITyckImQ6DhX2gh9+H0O0IcMguN0F9jFkL5dSelclECaocu3UMZ7Zdp4Lxn9J80AEECH5PZEQD1ZwYBB2bXvJe0gDM4+Ip4PZZCCFwMyHkEZzTrKMkPFGfrogKDgkkGBypRB34hoZ23e0NFLStLWv80bNXhvaTjNxvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ok+ZvhLK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ok+ZvhLK"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6feb1097d64so72093167b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742929696; x=1743534496; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uBgRAC9f4JnjWelcmYNHs7Pp0auWj+zKsfRjzsiOuOE=;
        b=Ok+ZvhLKqWLvzmu4P8yyCPUGq/W6jSwhi4pJApfECkp5ARqRbHfJHTdFBQo6/56ITt
         BPDVhO4bYiBHH9sX+G8yvvICrG35C3Epnr1iq1O/Pek2uxOGq+5Hg1v9CyMtLaJsiGqN
         r6ouEXbsC9z0aLvh9JhZVeApsVqo3NtpN7c/yPHtNVQN6Nkge8Wp5lksIDQuiNw+HF4O
         TiESh5U5BHqj0TlO0uZ/2bbSvMAjHMW2OEaW/sjJXxo8QYpnvcrfPFbVKX30XRw4/ASf
         DsukmJZrZWHfL4q+zu3HDIDVH1DtI0E90hvOJ9Dvk/mw4tIsQCaOc/wMx6YW1TZSk03Q
         yZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742929696; x=1743534496;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBgRAC9f4JnjWelcmYNHs7Pp0auWj+zKsfRjzsiOuOE=;
        b=Nvx09TkcLemhrAiQXoRdsT3jl1SC3eZXn14KHZBourCDI0OVNi7fQdkfj3BkHj056t
         MDoHxC6EvSlEeDjwjGMqK4QOP8oPoz04qostZcWu/6cZ1+huOnYV3IEUqQ9RLeEptSv+
         Xu0bnU1t3Hev1Phj3VBWXQbLN2XCObVwOthw5D30/1AWFO7ClmjnpL8jO8+lvgzukxmN
         GS2EYzHY2nEHJe3p6NLjgBoAPPH5S2DGzDooaRdRMNNH6/kJYI3juhseczzYQxa41nxM
         D2GHqBrqyljyRr/t/2cETxDlov793U0Yo9/A2OHfVAqBmEjrkJcW+R/qarjqrDwcpopf
         2MsA==
X-Forwarded-Encrypted: i=1; AJvYcCVN2Nj0oQ5RFXGNUw8IHvLg4kQJdmoFlahDZ5IkKu3ghl3lWVqN0mT+SkqnktBOWpTshSvds5Xpr9xhBS2WmbOJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+2EKtLKMxWQwA9MHwSopGiti+VAPp0NwqeP5+PjZUgg36o3v
	LyPExectD+2/zL1LFDBY1mvQnFGU8oLs5ADj+Z0lgwVguiFduBYM270Bky2XNW03M0TY4//PRkQ
	raMM5Ig==
X-Google-Smtp-Source: AGHT+IGAKdzIs/Clx1y3Haxe/UdhJ2d3DkeWzX+qLahE7GCEo49gMzjMNt+pjgHbeS0mptlL4XsdCUR7phOx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:3b0c:e5d7:4752:a58])
 (user=irogers job=sendgmr) by 2002:a05:690c:4809:b0:6fe:dd5d:d6fa with SMTP
 id 00721157ae682-700bace6faemr134227b3.6.1742929696301; Tue, 25 Mar 2025
 12:08:16 -0700 (PDT)
Date: Tue, 25 Mar 2025 12:03:16 -0700
Message-Id: <20250325190352.59241-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v3 00/35] GNR retirement latencies, topic and metric updates
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add default mean, min and max retirement latency values to GNR
events. Update the topics on a number of events previously
"other". Switch TMA metrics to the generated version. Add TMA 5.02
metrics for sandybridge, ivytown, ivybridge and jaketown.

Events and metrics generated from the data and scripts in:
https://github.com/intel/perfmon
and:
https://github.com/intel/perfmon/pull/298

v3: Generate sierraforest metrics from the spreadsheet using
    conversion with the core type of crestmont.

v2: Fix arrowlake PMU/cpu prefixes.

Ian Rogers (35):
  perf vendor events: Update alderlake events/metrics
  perf vendor events: Update AlderlakeN events/metrics
  perf vendor events: Update arrowlake events/metrics
  perf vendor events: Update bonnell events
  perf vendor events: Update broadwell metrics
  perf vendor events: Update broadwellde metrics
  perf vendor events: Update broadwellx metrics
  perf vendor events: Update cascadelakex events/metrics
  perf vendor events: Update clearwaterforest events
  perf vendor events: Update elkhartlake events
  perf vendor events: Update emeraldrapids events/metrics
  perf vendor events: Update grandridge events/metrics
  perf vendor events: Add graniterapids retirement latencies
  perf vendor events: Update haswell metrics
  perf vendor events: Update haswellx metrics
  perf vendor events: Update icelake events/metrics
  perf vendor events: Update icelakex events/metrics
  perf vendor events: Update ivybridge metrics
  perf vendor events: Update ivytown metrics
  perf vendor events: Update jaketown metrics
  perf vendor events: Update lunarlake events/metrics
  perf vendor events: Update meteorlake events/metrics
  perf vendor events: Update nehalemep events
  perf vendor events: Update nehalemex events
  perf vendor events: Update rocketlake events/metrics
  perf vendor events: Update sandybridge metrics
  perf vendor events: Update sapphirerapids events/metrics
  perf vendor events: Update sierraforest events/metrics
  perf vendor events: Update skylake metrics
  perf vendor events: Update skylakex events/metrics
  perf vendor events: Update snowridgex events
  perf vendor events: Update tigerlake metrics
  perf vendor events: Update westmereep-dp events
  perf vendor events: Update westmereep-dp events
  perf vendor events: Update westmereep-dp events

 .../arch/x86/alderlake/adl-metrics.json       | 485 ++++++++-------
 .../pmu-events/arch/x86/alderlake/cache.json  |  77 +++
 .../pmu-events/arch/x86/alderlake/memory.json |  55 ++
 .../pmu-events/arch/x86/alderlake/other.json  | 196 ------
 .../arch/x86/alderlake/pipeline.json          |  67 ++-
 .../arch/x86/alderlaken/adln-metrics.json     |  54 +-
 .../pmu-events/arch/x86/alderlaken/cache.json |  50 ++
 .../arch/x86/alderlaken/memory.json           |  40 ++
 .../pmu-events/arch/x86/alderlaken/other.json |  98 ---
 .../arch/x86/alderlaken/pipeline.json         |  11 +-
 .../arch/x86/arrowlake/arl-metrics.json       | 562 +++++++++---------
 .../pmu-events/arch/x86/arrowlake/cache.json  | 148 +++++
 .../pmu-events/arch/x86/arrowlake/memory.json |  11 +
 .../pmu-events/arch/x86/arrowlake/other.json  | 193 ------
 .../arch/x86/arrowlake/pipeline.json          | 163 ++++-
 .../pmu-events/arch/x86/bonnell/other.json    |   8 -
 .../pmu-events/arch/x86/bonnell/pipeline.json |   8 +
 .../arch/x86/broadwell/bdw-metrics.json       | 256 ++++----
 .../arch/x86/broadwellde/bdwde-metrics.json   | 180 +++---
 .../arch/x86/broadwellx/bdx-metrics.json      | 268 +++++----
 .../arch/x86/cascadelakex/cache.json          | 404 +++++++++++++
 .../arch/x86/cascadelakex/clx-metrics.json    | 389 ++++++------
 .../arch/x86/cascadelakex/other.json          | 404 -------------
 .../arch/x86/clearwaterforest/cache.json      |  20 +
 .../arch/x86/clearwaterforest/other.json      |  22 -
 .../arch/x86/elkhartlake/cache.json           | 192 ++++++
 .../arch/x86/elkhartlake/memory.json          | 202 +++++++
 .../arch/x86/elkhartlake/other.json           | 394 ------------
 .../arch/x86/emeraldrapids/cache.json         | 100 ++++
 .../arch/x86/emeraldrapids/emr-metrics.json   | 471 ++++++++-------
 .../arch/x86/emeraldrapids/memory.json        | 170 ++++++
 .../arch/x86/emeraldrapids/other.json         | 328 ----------
 .../arch/x86/emeraldrapids/pipeline.json      |  58 ++
 .../pmu-events/arch/x86/grandridge/cache.json | 150 ++++-
 .../arch/x86/grandridge/counter.json          |   2 +-
 .../arch/x86/grandridge/frontend.json         |   8 +
 .../arch/x86/grandridge/grr-metrics.json      | 521 +---------------
 .../pmu-events/arch/x86/grandridge/other.json |  28 -
 .../arch/x86/grandridge/pipeline.json         |  51 +-
 .../arch/x86/grandridge/uncore-cache.json     |  45 +-
 .../arch/x86/grandridge/uncore-memory.json    | 338 +++++++++++
 .../arch/x86/graniterapids/cache.json         | 122 ++++
 .../arch/x86/graniterapids/counter.json       |   5 +
 .../arch/x86/graniterapids/frontend.json      |  21 +
 .../arch/x86/graniterapids/gnr-metrics.json   | 483 ++++++++-------
 .../arch/x86/graniterapids/memory.json        | 130 ++++
 .../arch/x86/graniterapids/other.json         | 237 --------
 .../arch/x86/graniterapids/pipeline.json      |  52 ++
 .../arch/x86/graniterapids/uncore-cache.json  |  42 ++
 .../graniterapids/uncore-interconnect.json    |  90 ++-
 .../arch/x86/graniterapids/uncore-memory.json | 240 ++++++++
 .../arch/x86/haswell/hsw-metrics.json         | 206 ++++---
 .../arch/x86/haswellx/hsx-metrics.json        | 222 ++++---
 .../pmu-events/arch/x86/icelake/cache.json    |  60 ++
 .../arch/x86/icelake/icl-metrics.json         | 385 ++++++------
 .../pmu-events/arch/x86/icelake/memory.json   | 160 +++++
 .../pmu-events/arch/x86/icelake/other.json    | 220 -------
 .../pmu-events/arch/x86/icelakex/cache.json   | 273 +++++++++
 .../arch/x86/icelakex/icx-metrics.json        | 399 +++++++------
 .../pmu-events/arch/x86/icelakex/memory.json  | 190 ++++++
 .../pmu-events/arch/x86/icelakex/other.json   | 463 ---------------
 .../arch/x86/ivybridge/ivb-metrics.json       |  76 ++-
 .../arch/x86/ivybridge/metricgroups.json      |   5 +
 .../arch/x86/ivytown/ivt-metrics.json         |  80 ++-
 .../arch/x86/ivytown/metricgroups.json        |   5 +
 .../arch/x86/jaketown/frontend.json           |   8 +
 .../arch/x86/jaketown/jkt-metrics.json        |  40 +-
 .../arch/x86/jaketown/metricgroups.json       |   5 +
 .../pmu-events/arch/x86/jaketown/other.json   |   8 -
 .../pmu-events/arch/x86/lunarlake/cache.json  | 122 ++++
 .../arch/x86/lunarlake/lnl-metrics.json       | 556 +++++++++--------
 .../pmu-events/arch/x86/lunarlake/memory.json |  44 ++
 .../pmu-events/arch/x86/lunarlake/other.json  | 353 -----------
 .../arch/x86/lunarlake/pipeline.json          | 187 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  14 +-
 .../pmu-events/arch/x86/meteorlake/cache.json | 179 ++++++
 .../arch/x86/meteorlake/memory.json           |  44 ++
 .../arch/x86/meteorlake/mtl-metrics.json      | 549 +++++++++--------
 .../pmu-events/arch/x86/meteorlake/other.json | 140 -----
 .../arch/x86/meteorlake/pipeline.json         |  44 +-
 .../arch/x86/meteorlake/uncore-memory.json    |  18 +
 .../pmu-events/arch/x86/nehalemep/cache.json  |  32 +
 .../pmu-events/arch/x86/nehalemep/other.json  |  40 --
 .../arch/x86/nehalemep/virtual-memory.json    |   8 +
 .../pmu-events/arch/x86/nehalemex/cache.json  |  32 +
 .../pmu-events/arch/x86/nehalemex/other.json  |  40 --
 .../arch/x86/nehalemex/virtual-memory.json    |   8 +
 .../pmu-events/arch/x86/rocketlake/cache.json |  60 ++
 .../arch/x86/rocketlake/memory.json           | 160 +++++
 .../pmu-events/arch/x86/rocketlake/other.json | 220 -------
 .../arch/x86/rocketlake/rkl-metrics.json      | 385 ++++++------
 .../arch/x86/sandybridge/frontend.json        |   8 +
 .../arch/x86/sandybridge/metricgroups.json    |   5 +
 .../arch/x86/sandybridge/other.json           |   8 -
 .../arch/x86/sandybridge/snb-metrics.json     |  36 +-
 .../arch/x86/sapphirerapids/cache.json        | 150 +++++
 .../arch/x86/sapphirerapids/memory.json       | 170 ++++++
 .../arch/x86/sapphirerapids/other.json        | 378 ------------
 .../arch/x86/sapphirerapids/pipeline.json     |  58 ++
 .../arch/x86/sapphirerapids/spr-metrics.json  | 465 ++++++++-------
 .../arch/x86/sierraforest/cache.json          |  20 +
 .../arch/x86/sierraforest/memory.json         |  20 +
 .../arch/x86/sierraforest/other.json          |  48 --
 .../arch/x86/sierraforest/pipeline.json       |   8 +
 .../arch/x86/sierraforest/srf-metrics.json    | 204 ++++---
 .../arch/x86/sierraforest/uncore-cache.json   |  32 +
 .../arch/x86/sierraforest/uncore-memory.json  | 240 ++++++++
 .../arch/x86/skylake/skl-metrics.json         | 367 ++++++------
 .../pmu-events/arch/x86/skylakex/cache.json   |  74 +++
 .../pmu-events/arch/x86/skylakex/other.json   |  74 ---
 .../arch/x86/skylakex/skx-metrics.json        | 385 ++++++------
 .../pmu-events/arch/x86/snowridgex/cache.json | 192 ++++++
 .../arch/x86/snowridgex/memory.json           | 202 +++++++
 .../pmu-events/arch/x86/snowridgex/other.json | 394 ------------
 .../arch/x86/tigerlake/tgl-metrics.json       | 383 ++++++------
 .../arch/x86/westmereep-dp/cache.json         |  32 +
 .../arch/x86/westmereep-dp/other.json         |  40 --
 .../x86/westmereep-dp/virtual-memory.json     |   8 +
 .../arch/x86/westmereep-sp/cache.json         |  32 +
 .../arch/x86/westmereep-sp/other.json         |  40 --
 .../x86/westmereep-sp/virtual-memory.json     |   8 +
 .../pmu-events/arch/x86/westmereex/cache.json |  32 +
 .../pmu-events/arch/x86/westmereex/other.json |  40 --
 .../arch/x86/westmereex/virtual-memory.json   |   8 +
 124 files changed, 9983 insertions(+), 8867 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json

-- 
2.49.0.395.g12beb8f557-goog

