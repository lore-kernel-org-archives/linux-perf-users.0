Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F921519AD
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738776714; cv=none; b=AzrEvXJoDXnfMuj0RDhspB7CNiKR+hs8MD+S/Wp1hy7Pz8qR7lTQhxY4iMjBh8GkJ62XuPadp8Qz/KbJRNte8T+xakH1sL/QQTuZky0tPMqGS8RFMG30A+QuGl1DqumvURkavBgn2el3xqipl+YJLZjvTmQwFD8baaHy/FZECWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738776714; c=relaxed/simple;
	bh=rVT4AdJ5el4gGW+ht5V1eCInh8fgNBWymEDsNQFLyDw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=UkYpUVABJch1BoTBVIQx2pAKNrw8MuPK1gJZ5uy7fU49sQOGOt81JRpL039nMictaMpHWz009OOL0z8nCi8I2AQkVLX4O9gkMPNpR8ppEv1CZLl5ugUOcuIwvQUeckzN4/4hozyloR7I/OI7B2dgVV9qH8oAiQKGAWEvPyo4TGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9juS58s; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9juS58s"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5af19d9746so1500156276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738776711; x=1739381511; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P3EmG1pEOQRdr2TDnbar09cWaeYFqoH5G6cz0QNnEnE=;
        b=M9juS58s1xCtcC63wzULvQEmihnqhb31qCGugtr2bbD5GepAtamMyA/p3+C2Sn+9Ad
         jJ3ldsBrVyjd2we1wvYua1AQWx/kb9z5KfjzQuVgedovwYUUwy1UITQ7VR5OTaGUNUso
         1KCvIVMflF71KPUdf3Dyn8k0dmXm2B0p8hSzLlkJ+JsPFwoZMsRu550tpFvbEIok3FzJ
         hM2RO34OOQBEuQodqU5wdIard9q+pOUFjghY7kU1LIa4oTJZYQ0eqUugZVNqwHmJVBNs
         ubGFC5Yfz4qEWmck/+c32Ek9+i9Z8RHulY9RXrwb/lM2zj9ShDAri/Lk15XaHOy3N9mP
         tXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738776711; x=1739381511;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P3EmG1pEOQRdr2TDnbar09cWaeYFqoH5G6cz0QNnEnE=;
        b=d9x8ENNJjPnxeFaLcuv0NnCAbaI2cyw+z4xQmidddgAYiQKkcwk/A7jax2uxTYwlzE
         H2Vc3iuJwZ5cVl/ERbi4YBeRBenjEpzH4lJCo7qzYvA5Pg1sOcBheLpmqdgpkqmclabQ
         Hw7yxUtLDvYFOPomodLDa+ypYQq3n/8Bo//QdRGfABDar48BD6jVP+AqaDTTgZe6Qk8R
         Fc2iM2dpvgv/Ac2def+8crTviX2uaBQ18VH+/voJ33rt7XqmhZP8xYATbwEDrlu7q5DW
         wxKK5zCg4VHw29bxPbm4NL+E8fHgwEFfU0b5c1Ly2I0uwwca+0nEe1y8w+vSSbm0CbgT
         sX8g==
X-Forwarded-Encrypted: i=1; AJvYcCVhukMs2K98Il87eUXcgB4aTqniZ3hcSlVYR/d0fmICJkQrekJLFdWmW6F3RbDxQDeUKc6HdeSv1dJ8LXgKgVE6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HvypUjLRBbA5w+bT8VyRzRXibl5L9NEvZMrrljfk4P5wmykX
	QH0RUQpkXfugw9vrmSry9NFOOFFV9EulEZq5cU5Y9OgBr/a8En6INXb9R63n1ndIQyQwMYkfEo2
	dmdpymw==
X-Google-Smtp-Source: AGHT+IFECnXAUjF0yV5yitOcLR+ESI2qq4RwHFeLXATKivtjx57i7Ry0SvUzn8yT9AuJxiRGUV26wQ6P3dT0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:34a2:aced:a7fd:972a])
 (user=irogers job=sendgmr) by 2002:a25:d351:0:b0:e30:d5cf:775a with SMTP id
 3f1490d57ef6-e5b353c799cmr925276.6.1738776710790; Wed, 05 Feb 2025 09:31:50
 -0800 (PST)
Date: Wed,  5 Feb 2025 09:31:16 -0800
Message-Id: <20250205173140.238294-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v5 00/24] Intel vendor events and TMA 5.01 metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Update the Intel vendor events to the latest.
Update the metrics to TMA 5.01.
Add Arrowlake and Clearwaterforest support.
Add metrics for LNL and GNR.
Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.

The perf json was generated using the script:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
with the generated json being in:
https://github.com/intel/perfmon/tree/main/scripts/perf

Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
<caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
Weilin Wang <weilin.wang@intel.com>, Kan Liang
<kan.liang@linux.intel.com> and Thomas Falcon
<thomas.falcon@intel.com> for helping get this patch series together.

v5: Remove Valkyrie metrics mistakenly added on atom. Ensure "perf all
    metrics test" doesn't skip for missing events.
v4: Fix TSC events on hybrid mistakenly specifying the core PMU
    inhibiting the use of the msr PMU.
v3: Fixes for hybrid metrics that were missing PMU. Update to the
    latest events.
v2: Fix hybrid and Co-authored-by tag issues reported by
    Arnaldo. Updates to Lunarlake and Meteorlake events. Addition of
    Clearwaterforest.

Ian Rogers (24):
  perf vendor events: Update Alderlake events/metrics
  perf vendor events: Update AlderlakeN events/metrics
  perf vendor events: Add Arrowlake events/metrics
  perf vendor events: Update Broadwell events/metrics
  perf vendor events: Update BroadwellDE events/metrics
  perf vendor events: Update BroadwellX events/metrics
  perf vendor events: Update CascadelakeX events/metrics
  perf vendor events: Add Clearwaterforest events
  perf vendor events: Update EmeraldRapids events/metrics
  perf vendor events: Update GrandRidge events/metrics
  perf vendor events: Update/add Graniterapids events/metrics
  perf vendor events: Update Haswell events/metrics
  perf vendor events: Update HaswellX events/metrics
  perf vendor events: Update Icelake events/metrics
  perf vendor events: Update IcelakeX events/metrics
  perf vendor events: Update/add Lunarlake events/metrics
  perf vendor events: Update Meteorlake events/metrics
  perf vendor events: Update Rocketlake events/metrics
  perf vendor events: Update Sapphirerapids events/metrics
  perf vendor events: Update Sierraforest events/metrics
  perf vendor events: Update Skylake metrics
  perf vendor events: Update SkylakeX events/metrics
  perf vendor events: Update Tigerlake events/metrics
  perf test stat_all_metrics: Ensure missing events fail test

 .../arch/x86/alderlake/adl-metrics.json       |  914 +++---
 .../pmu-events/arch/x86/alderlake/cache.json  |  292 +-
 .../arch/x86/alderlake/floating-point.json    |   19 +-
 .../arch/x86/alderlake/frontend.json          |   19 -
 .../pmu-events/arch/x86/alderlake/memory.json |   32 +-
 .../arch/x86/alderlake/metricgroups.json      |   10 +-
 .../pmu-events/arch/x86/alderlake/other.json  |   92 +-
 .../arch/x86/alderlake/pipeline.json          |  127 +-
 .../arch/x86/alderlake/virtual-memory.json    |   33 +
 .../arch/x86/alderlaken/adln-metrics.json     |   83 +-
 .../pmu-events/arch/x86/alderlaken/cache.json |  227 +-
 .../arch/x86/alderlaken/floating-point.json   |   17 +-
 .../arch/x86/alderlaken/memory.json           |   20 +
 .../pmu-events/arch/x86/alderlaken/other.json |   81 +-
 .../arch/x86/alderlaken/pipeline.json         |   97 +-
 .../arch/x86/alderlaken/virtual-memory.json   |   30 +
 .../arch/x86/arrowlake/arl-metrics.json       | 2755 +++++++++++++++++
 .../pmu-events/arch/x86/arrowlake/cache.json  | 1491 +++++++++
 .../arch/x86/arrowlake/floating-point.json    |  532 ++++
 .../arch/x86/arrowlake/frontend.json          |  609 ++++
 .../pmu-events/arch/x86/arrowlake/memory.json |  387 +++
 .../arch/x86/arrowlake/metricgroups.json      |  150 +
 .../pmu-events/arch/x86/arrowlake/other.json  |  279 ++
 .../arch/x86/arrowlake/pipeline.json          | 2308 ++++++++++++++
 .../arch/x86/arrowlake/uncore-cache.json      |   20 +
 .../x86/arrowlake/uncore-interconnect.json    |   47 +
 .../arch/x86/arrowlake/uncore-memory.json     |  160 +
 .../{haswell => arrowlake}/uncore-other.json  |    0
 .../arch/x86/arrowlake/virtual-memory.json    |  522 ++++
 .../arch/x86/broadwell/bdw-metrics.json       |  312 +-
 .../pmu-events/arch/x86/broadwell/cache.json  |   10 +-
 .../arch/x86/broadwell/frontend.json          |    4 +-
 .../pmu-events/arch/x86/broadwell/memory.json |    8 +-
 .../arch/x86/broadwell/metricgroups.json      |    5 +
 .../arch/x86/broadwell/pipeline.json          |   10 +-
 .../arch/x86/broadwellde/bdwde-metrics.json   |  256 +-
 .../arch/x86/broadwellde/cache.json           |   10 +-
 .../arch/x86/broadwellde/frontend.json        |    4 +-
 .../arch/x86/broadwellde/memory.json          |    6 +-
 .../arch/x86/broadwellde/metricgroups.json    |    5 +
 .../arch/x86/broadwellde/pipeline.json        |   10 +-
 .../arch/x86/broadwellde/uncore-cache.json    |   28 +-
 .../x86/broadwellde/uncore-interconnect.json  |   16 +-
 .../arch/x86/broadwellx/bdx-metrics.json      |  344 +-
 .../pmu-events/arch/x86/broadwellx/cache.json |   10 +-
 .../arch/x86/broadwellx/frontend.json         |    4 +-
 .../arch/x86/broadwellx/memory.json           |    6 +-
 .../arch/x86/broadwellx/metricgroups.json     |    5 +
 .../arch/x86/broadwellx/pipeline.json         |   10 +-
 .../arch/x86/broadwellx/uncore-cache.json     |   28 +-
 .../x86/broadwellx/uncore-interconnect.json   |   36 +-
 .../arch/x86/broadwellx/uncore-memory.json    |    1 +
 .../arch/x86/cascadelakex/clx-metrics.json    |  767 +++--
 .../arch/x86/cascadelakex/metricgroups.json   |    9 +-
 .../arch/x86/cascadelakex/uncore-cache.json   |   60 +-
 .../x86/cascadelakex/uncore-interconnect.json |   11 -
 .../arch/x86/clearwaterforest/cache.json      |  144 +
 .../arch/x86/clearwaterforest/counter.json    |    7 +
 .../arch/x86/clearwaterforest/frontend.json   |   18 +
 .../arch/x86/clearwaterforest/memory.json     |   22 +
 .../arch/x86/clearwaterforest/other.json      |   22 +
 .../arch/x86/clearwaterforest/pipeline.json   |  113 +
 .../x86/clearwaterforest/virtual-memory.json  |   29 +
 .../arch/x86/emeraldrapids/cache.json         |   28 +-
 .../arch/x86/emeraldrapids/emr-metrics.json   | 1036 ++++---
 .../arch/x86/emeraldrapids/frontend.json      |   19 -
 .../arch/x86/emeraldrapids/memory.json        |   15 +-
 .../arch/x86/emeraldrapids/metricgroups.json  |   10 +-
 .../arch/x86/emeraldrapids/pipeline.json      |   23 -
 .../arch/x86/emeraldrapids/uncore-io.json     |  218 +-
 .../arch/x86/grandridge/grr-metrics.json      |  284 +-
 .../arch/x86/grandridge/pipeline.json         |    3 +-
 .../arch/x86/grandridge/uncore-cache.json     |    4 +-
 .../x86/grandridge/uncore-interconnect.json   |   60 +
 .../arch/x86/grandridge/uncore-io.json        |  214 +-
 .../arch/x86/grandridge/uncore-memory.json    |    2 +-
 .../arch/x86/graniterapids/cache.json         |  130 +-
 .../arch/x86/graniterapids/counter.json       |   24 +-
 .../arch/x86/graniterapids/frontend.json      |   24 +-
 .../arch/x86/graniterapids/gnr-metrics.json   | 2313 ++++++++++++++
 .../arch/x86/graniterapids/memory.json        |  121 +-
 .../arch/x86/graniterapids/metricgroups.json  |  145 +
 .../arch/x86/graniterapids/other.json         |  109 +
 .../arch/x86/graniterapids/pipeline.json      |   40 +-
 .../arch/x86/graniterapids/uncore-cache.json  |   48 +-
 .../arch/x86/graniterapids/uncore-cxl.json    |    2 -
 .../graniterapids/uncore-interconnect.json    |   87 +
 .../arch/x86/graniterapids/uncore-io.json     |  280 +-
 .../arch/x86/graniterapids/uncore-memory.json |  122 +-
 .../arch/x86/graniterapids/uncore-power.json  |   98 +
 .../arch/x86/haswell/hsw-metrics.json         |  260 +-
 .../pmu-events/arch/x86/haswell/memory.json   |    2 +-
 .../arch/x86/haswell/metricgroups.json        |    5 +
 .../arch/x86/haswellx/hsx-metrics.json        |  296 +-
 .../arch/x86/haswellx/metricgroups.json       |    5 +
 .../arch/x86/haswellx/uncore-cache.json       |   28 +-
 .../x86/haswellx/uncore-interconnect.json     |   38 +-
 .../pmu-events/arch/x86/icelake/cache.json    |   34 +-
 .../pmu-events/arch/x86/icelake/frontend.json |   17 -
 .../arch/x86/icelake/icl-metrics.json         |  849 ++---
 .../pmu-events/arch/x86/icelake/memory.json   |   13 +-
 .../arch/x86/icelake/metricgroups.json        |   10 +-
 .../pmu-events/arch/x86/icelake/pipeline.json |   30 +-
 .../arch/x86/icelake/uncore-interconnect.json |   76 -
 .../arch/x86/icelake/uncore-other.json        |    2 +-
 .../arch/x86/icelake/virtual-memory.json      |   18 +
 .../pmu-events/arch/x86/icelakex/cache.json   |   41 +-
 .../arch/x86/icelakex/frontend.json           |   17 -
 .../arch/x86/icelakex/icx-metrics.json        |  852 ++---
 .../pmu-events/arch/x86/icelakex/memory.json  |   13 +-
 .../arch/x86/icelakex/metricgroups.json       |   10 +-
 .../arch/x86/icelakex/pipeline.json           |   30 +-
 .../pmu-events/arch/x86/lunarlake/cache.json  | 1352 +++++++-
 .../arch/x86/lunarlake/floating-point.json    |  484 +++
 .../arch/x86/lunarlake/frontend.json          |  654 +++-
 .../arch/x86/lunarlake/lnl-metrics.json       | 2722 ++++++++++++++++
 .../pmu-events/arch/x86/lunarlake/memory.json |  262 +-
 .../arch/x86/lunarlake/metricgroups.json      |  150 +
 .../pmu-events/arch/x86/lunarlake/other.json  |  496 ++-
 .../arch/x86/lunarlake/pipeline.json          | 2105 +++++++++++--
 .../arch/x86/lunarlake/uncore-memory.json     |   36 +
 .../arch/x86/lunarlake/virtual-memory.json    |  428 +++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   42 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |  109 +-
 .../arch/x86/meteorlake/frontend.json         |   30 +-
 .../arch/x86/meteorlake/memory.json           |   22 +-
 .../arch/x86/meteorlake/metricgroups.json     |   10 +-
 .../arch/x86/meteorlake/mtl-metrics.json      |  994 +++---
 .../pmu-events/arch/x86/meteorlake/other.json |   54 +
 .../arch/x86/meteorlake/pipeline.json         |   89 +-
 .../pmu-events/arch/x86/rocketlake/cache.json |   34 +-
 .../arch/x86/rocketlake/frontend.json         |   17 -
 .../arch/x86/rocketlake/memory.json           |   13 +-
 .../arch/x86/rocketlake/metricgroups.json     |   10 +-
 .../arch/x86/rocketlake/pipeline.json         |   30 +-
 .../arch/x86/rocketlake/rkl-metrics.json      |  849 ++---
 .../x86/rocketlake/uncore-interconnect.json   |   10 -
 .../arch/x86/rocketlake/uncore-other.json     |    2 +-
 .../arch/x86/rocketlake/virtual-memory.json   |   18 +
 .../arch/x86/sapphirerapids/cache.json        |   30 +-
 .../arch/x86/sapphirerapids/frontend.json     |   19 -
 .../arch/x86/sapphirerapids/memory.json       |   15 +-
 .../arch/x86/sapphirerapids/metricgroups.json |   10 +-
 .../arch/x86/sapphirerapids/pipeline.json     |   23 -
 .../arch/x86/sapphirerapids/spr-metrics.json  |  968 +++---
 .../arch/x86/sapphirerapids/uncore-io.json    |  138 +-
 .../arch/x86/sierraforest/cache.json          |  130 +-
 .../arch/x86/sierraforest/counter.json        |   24 +-
 .../arch/x86/sierraforest/frontend.json       |    8 +
 .../arch/x86/sierraforest/other.json          |   20 +
 .../arch/x86/sierraforest/pipeline.json       |   46 +-
 .../arch/x86/sierraforest/srf-metrics.json    |  308 +-
 .../arch/x86/sierraforest/uncore-cache.json   |   61 +-
 .../arch/x86/sierraforest/uncore-cxl.json     |    2 -
 .../x86/sierraforest/uncore-interconnect.json |   87 +
 .../arch/x86/sierraforest/uncore-io.json      |  280 +-
 .../arch/x86/sierraforest/uncore-memory.json  |  122 +-
 .../arch/x86/sierraforest/uncore-power.json   |   98 +
 .../arch/x86/skylake/metricgroups.json        |    9 +-
 .../arch/x86/skylake/skl-metrics.json         |  684 ++--
 .../arch/x86/skylakex/metricgroups.json       |    9 +-
 .../arch/x86/skylakex/skx-metrics.json        |  740 +++--
 .../arch/x86/skylakex/uncore-cache.json       |   60 +-
 .../x86/skylakex/uncore-interconnect.json     |   11 -
 .../pmu-events/arch/x86/tigerlake/cache.json  |   45 +-
 .../arch/x86/tigerlake/frontend.json          |   17 -
 .../pmu-events/arch/x86/tigerlake/memory.json |   13 +-
 .../arch/x86/tigerlake/metricgroups.json      |   10 +-
 .../arch/x86/tigerlake/pipeline.json          |   30 +-
 .../arch/x86/tigerlake/tgl-metrics.json       |  745 +++--
 .../x86/tigerlake/uncore-interconnect.json    |    4 +-
 .../arch/x86/tigerlake/uncore-other.json      |    2 +-
 .../arch/x86/tigerlake/virtual-memory.json    |   18 +
 tools/perf/tests/shell/stat_all_metrics.sh    |    8 +-
 174 files changed, 30290 insertions(+), 7314 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-memory.json
 rename tools/perf/pmu-events/arch/x86/{haswell => arrowlake}/uncore-other.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/lnl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/uncore-memory.json

-- 
2.48.1.362.g079036d154-goog

