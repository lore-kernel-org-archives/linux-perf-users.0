Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D919263F45
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925320; cv=none; b=KC1Ka0LjsNjbL2iOyrkIAY07j20UHImtIXGnk7jAvK+fIeHho4gFQ2+EtBkBpKm4VP9uFKJaQakTe8jbgiD67dcdpKpPebnB5/La0W7aHf3j8Fba42D4hmKuC97xhmJi7uzq6Lni+5pN0e2lSrsWaEGKzDQS+TrjOgukWH2mEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925320; c=relaxed/simple;
	bh=KGzHV4AGIWKrWBs1lNyAyJSkG6Kr/7d+ZtUTrUzoltM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=S6G9EzH7tj9Vj5+L9XSTCzeWyQGAiBSe87ygRsTs5Nruqjq+1ljcw2Uwb0vNlXtTvRF8mNVlp61hTGgb9l1oEFxyx/kbpjZBF9x/1T+dxzQQqn4cX65dQZiFFi5sfeN1CRVouH2J38+k+pNbPUVFmsT/c9agrl299mIBrDLQFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSA0XLOn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSA0XLOn"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fecdb96e52so74968817b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742925316; x=1743530116; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uBgRAC9f4JnjWelcmYNHs7Pp0auWj+zKsfRjzsiOuOE=;
        b=bSA0XLOn3DRuEtCiA20G4nZ+mGO4lkpimrMA0pVt3V3C1aGL+ZV/7puAf7iFg8Cztf
         OLbBqyZzZcoeBo1uE8Q1mqkfvghCgMlz0oG3RATXF6d3C0WWFzFC64KFC1L3n9Q5aTqR
         VANiQl2O+YP3Ol/Y3PO3UbZFxyOQ1moe9ASUJ6JrsTjpkdrJ8OZdey3MBbsNR4qMXvzd
         w5UguAuj8Kog1+s4X9XSr2G3kL6UlYBbkz9xSC1QE8gjFkz5N7mjBwlyCBV1R016mpem
         nWsYjycoupROyz3ja4MjXcGWkt6ZAJidadpfhLb8n47b15FFAPlCyEWAiMsAMNShsa1y
         BmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925316; x=1743530116;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBgRAC9f4JnjWelcmYNHs7Pp0auWj+zKsfRjzsiOuOE=;
        b=nfopHtYO9ZOMdNvHLcUJWDb6mV7003bJHd/3q6CeqVZUkEvawiNzWM0FmWjvxr0ot3
         58zjeUhj/CfO1bLyajBqgVeug9GRUSRpg3K/Rl1stus+oRR1FhOji2Pb9p0iaVR9hjVC
         nr57wCD9ZmBIRsStPZIuW+BT8+wMXCgau8mljWCBgODaz7YrTqK2gmwXAW8iMwntRiXY
         cZGDiQ7V8TxhxFTXkZDi0+heVkUFhIpQnMDzqAeXEKCeN5Xi6dI69MOD+aqvjEajR6zE
         hYu0HQ8SsCasA8hlApRMi+cGMun3/50diEd3tU2UGWHYfmTondhz7LFbyx8JbMq2jRp4
         SZLA==
X-Forwarded-Encrypted: i=1; AJvYcCVodls2g1kjTgRSxS70Ajw71lMcFgsjUX+/aWyrQ+evq6ykxENYBqFZtWdeDR3yabTuHzTPJCpiG2ZQ0SLie8AB@vger.kernel.org
X-Gm-Message-State: AOJu0YznR++wwiEFBgdS9eYHoaDevdoPAXTjmLfWF2gMeUnaq8GP2mD6
	O72D2mZKclMIq/7oYPZkOKPt92Rn7JmzJdqrobDc15a3Hfr8YI+JSaRYcSNuudwP0LM/cAX3igr
	G1vJ2Gw==
X-Google-Smtp-Source: AGHT+IEQjv86YSRpdGGZjCOeQ9VtsOyJ19HXz7nY8/VPacYn7WQZlrVV6rVPEofn0tCVoa6ypQpU7PBLRMcw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a81:f00b:0:b0:6ff:6fa4:ea5a with SMTP id
 00721157ae682-700ba9bd6aemr112607b3.0.1742925315784; Tue, 25 Mar 2025
 10:55:15 -0700 (PDT)
Date: Tue, 25 Mar 2025 10:52:02 -0700
Message-Id: <20250325175238.50097-1-irogers@google.com>
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

