Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468125D1FA
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915775; cv=none; b=Jm3X3O7gy9Gqy6bWmg9+WYU48xKOo4Agr/la0s/NImnwHSZLKYj31DV9iqfXPYGt7rHF7QoYgUMFaGmMQipz2Iio/n2GU5gLZPq4bn+wxbbz4mHU+E4AktrG655APwFw1tXBRq1SsUabVjVMGsQXY+kyXqNnsbjr26BNiBfB6D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915775; c=relaxed/simple;
	bh=Ayp5UJ5po3xqzSmNKz9lmgoFoJ0PtHgNI6fQbZIbiZU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=GTstoCd5XdXOzioAXnfFEAJLdxivAhuBusAQD8k6uolhyowKYnPW/nSj9e9vjU+xkyeh7RNzpiRQ6TuRkhepeMG//uVQD546kGKPwbeLVDs7R6l7m6PWjRdANZv89a+VJqIZ/7l9KIk5/Ev0bF6PG6j3FzMy+uUU9nj2otLDEEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kY55vHt+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kY55vHt+"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5740c858beso6946280276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Mar 2025 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742915772; x=1743520572; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SxYgSR+rs6fV7hfbOGIpD5imBossFIK7oKYgVysxITY=;
        b=kY55vHt+XDjGsxmAWJ6rK08QyHyI4TBa4YyhphtLjYqNZfHesleEQlNS/tEtqSfTgG
         nyTj5XvJTFr0RU0zMWrjEvY8/l0R7yn/SQ4UmC+vW9JaZ/BqMAnpPy0pw1hzf+JRLcxD
         xXRxTrhXR2NVAd20ylsExMGNirBvwT3YHKXvFlrJFKUEVc9gAjKwpgDT9s/a13h/f4D3
         FIKf/3vtDCFXwqmTPkToMUnN7Yg2p5ewkcLtA3N/fIutryklzRZZ0lL1+YQfuMDTg7UU
         pM7YxVo5DzH8JotfPndxgJkqkBX4lGB/Iu+05CBAt0m1cvYcM1Pv9Pcoy2JL95vxskv2
         7HEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742915772; x=1743520572;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxYgSR+rs6fV7hfbOGIpD5imBossFIK7oKYgVysxITY=;
        b=Dcb4LhoXfYQwc8rPHrPlQ2hfaHRQGj4MtiCMA380UJNs1/gstIy/ndQL8ZuX2u4n8V
         WU+LUdKYNPv8BZOabxHRJ8SUfSavL62g0sEkE16eUMF+rV7nC5lFnRc3gmwrTctVrttg
         LZeLT7yRk6101UP8YJ7BjuetFbOI4hHfkU8iE+22x7Z9AbTAPeaFz2zLcUEMBGQGAqFz
         LxDM1wMHEy3QtRgd6UQKZdAg86zOMZlZ9sd+KdHHvrgV+IC7pbzUZNFe0oEiOGLgZHal
         QKIWSKPP1vqug3i98UHzPypkLgxnc7lA9nXHmJXlEFzxNsunS+1qKVZkFBl9M9EUMeeA
         Elcg==
X-Forwarded-Encrypted: i=1; AJvYcCXXjgvcK4G8/6Z8yMZhQLPqqN0bDA3J4YZPfQ47znkKeojb+8NZSNCAfL2cGXnAXmsZj+jqZDbjNWJPtLbzXXYn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0b8B0pBSfooRQ6u4Dx6aX2ymN/NMdxv0iGy8REshN9v4SYRKV
	2k58Tr2qLrhwE2uKzHXtAdU9hpfD+dUXI0ZiVbw65v8TDPDGFm+WJtodSj5+tVRSTbyyhefaXh9
	PCpui/A==
X-Google-Smtp-Source: AGHT+IFWsvZ3MZTa1iXnnfjNdh2akMiPZ8iIMTPv9BKJDVoFdJ9VU7RjWDTGLmvkNqLH3bUcjLhu1d7Vc85i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:40b3:9c02:57a5:693c])
 (user=irogers job=sendgmr) by 2002:a25:ef44:0:b0:e64:e234:ef50 with SMTP id
 3f1490d57ef6-e66a4a89f91mr8741276.0.1742915772069; Tue, 25 Mar 2025 08:16:12
 -0700 (PDT)
Date: Tue, 25 Mar 2025 08:13:02 -0700
Message-Id: <20250325151337.13143-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Subject: [PATCH v2 00/35] GNR retirement latencies, topic and metric updates
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
  perf vendor events: Update sierraforest events
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
 123 files changed, 9866 insertions(+), 8780 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json

-- 
2.49.0.395.g12beb8f557-goog

