Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29719D082
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733783291; cv=none; b=MWilf7Ae66yz+8TjwyPjT0y0vUtxDQXNbhO/bfn06V9pwkdQSYg3F5REyxY0f69sVSByAOIEAuHW6znigujsgteTuzBNiRyt2DVsX3YohB2jqL8lOo9BB4psSWwFP0Z2fq7VWvbYlnlimcolq60w4ZhjPnnCKqm/DY9eBflhqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733783291; c=relaxed/simple;
	bh=Yq8NdC3qDqJWNhvNan96lK4uZBel+m4hl5J1b9MZ4MI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=oVI1wspxCNglBlga5Co+CfGM9+VUa1itVajVM8y+xTX3RivqEZ/WDVdi8HWNnMwr2n4VYsPb2g2JwM/hcRgOb3ZKjhbJB1NkAn1oWXhmjNGzQETP0Fjh/dwz67ElpXj0/bchPUtc/LnqKurVQXfrZ0aKxhwmmKINaPprgr2gI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sp8aXDl5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sp8aXDl5"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3a0d165daeso6927691276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 14:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733783287; x=1734388087; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5jx+lb0HfYxAcbFSBMDC5/59RbnwioOXwChBaauCLXw=;
        b=sp8aXDl5DifWMyv+mhPSW8ESjpy8GsTEHrUx9mOW6edc4v6ICQZe9JXxB+IEKHNvCU
         ssNlWR62FSfGArMuiUENgadneZfUCz+sngZR/ZSl2zHW1Phwws7Aw620/0Mv6r9Rf0dU
         G1hlWZWvYz3k5lFbXQ4AOZct0sSipR2NqTjx9ypBUfvadp8qzzcfp8UML5XsqednsbUy
         xTwV5ORCpIyyAmF+lwqnwVEaYCdhnCSbRaylkDaeQQVUHUVx1qyjM6W0pF71zE3BIxwB
         9LdgGNKgScqx/ey/yQYQdRkGDEpMCp4/L6kHlQymDMTrYeQGn6G+p4YXsE6soDqvQy45
         iajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733783287; x=1734388087;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jx+lb0HfYxAcbFSBMDC5/59RbnwioOXwChBaauCLXw=;
        b=oXecjmD2F3E5rQW/+HGNQ6sYzu5Ugo6O3S35H03BXAzrkRoK7wX6s7rugNG0hav0ts
         VFQ/mVfD8aVod4kaaJsqHyLxexDi37BE8zdQt8rI0hX1zRUPxxlacjnZ5U2zjCqfB/fq
         a6qN6tJwZmtJu1PIrttN8vWRNpLiCQcVhf3n9LsNOLMpQAVHu2tVoXgAJy1kCqddjHzl
         zOouvFV63buBHdAFaFPSQtCJT1g14GuM4zgZ65U7ehHZVGeNUNCqwuddRBeCVv866lU7
         J84PWSkh1YpglZ4tzR8iSBPnNiRJHUSZoNukNB/yp+05Qrb05H7HcJtMJAvIs9TZSo20
         Y1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXHkDGNJrujQIEn1XL/J0AK1UcU/xb6/DQ48XLMno27dLXuxUjF5OmE5scEeOdLOtBibBodlEg7YMFd5k13UPHV@vger.kernel.org
X-Gm-Message-State: AOJu0YySBaJZMAnRSxCXMDjFKGCiYmZbdxBRgsxOGJLnWIQjZEY9wsfY
	omjTfDmKVgiZg7ysoW/3pG4R2OP0BO8nPucfa4ipd8RyMgqGbdSBXvB1kWL80xLQkSeFkDCqAXP
	ChcTOWQ==
X-Google-Smtp-Source: AGHT+IHtkTxdkdMh0WUKYHRhPpRZ5PQYA417juPHmeOywOOYq0TsIXjq4WvcZfBs0esf6STStb/95fwD6lvh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c8f1:280e:e8ad:32])
 (user=irogers job=sendgmr) by 2002:a25:aa71:0:b0:e39:7f7f:92c4 with SMTP id
 3f1490d57ef6-e3a175d1278mr25360276.0.1733783287391; Mon, 09 Dec 2024 14:28:07
 -0800 (PST)
Date: Mon,  9 Dec 2024 14:27:37 -0800
Message-Id: <20241209222800.296000-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Subject: [PATCH v1 00/22] Intel vendor events and TMA 5.01 metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Update the Intel vendor events to the latest.
Update the metrics to TMA 5.01.
Add Arrowlake support.
Add metrics for LNL and GNR.
Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.

The perf json was generated using the script:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
with the generated json being in:
https://github.com/intel/perfmon/tree/main/scripts/perf

Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
<caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com> and
Weilin Wang <weilin.wang@intel.com> for helping get this patch series
together.

Ian Rogers (22):
  perf vendor events: Update Alderlake events/metrics
  perf vendor events: Update AlderlakeN events/metrics
  perf vendor events: Add Arrowlake events/metrics
  perf vendor events: Update Broadwell events/metrics
  perf vendor events: Update BroadwellDE events/metrics
  perf vendor events: Update BroadwellX events/metrics
  perf vendor events: Update CascadelakeX events/metrics
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

 .../arch/x86/alderlake/adl-metrics.json       | 3637 ++++++++++---
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
 .../arch/x86/arrowlake/arl-metrics.json       | 4597 ++++++++++++++++
 .../pmu-events/arch/x86/arrowlake/cache.json  | 1444 ++++++
 .../arch/x86/arrowlake/floating-point.json    |  532 ++
 .../arch/x86/arrowlake/frontend.json          |  609 +++
 .../pmu-events/arch/x86/arrowlake/memory.json |  387 ++
 .../arch/x86/arrowlake/metricgroups.json      |  150 +
 .../pmu-events/arch/x86/arrowlake/other.json  |  279 +
 .../arch/x86/arrowlake/pipeline.json          | 2298 ++++++++
 .../arch/x86/arrowlake/uncore-cache.json      |   20 +
 .../x86/arrowlake/uncore-interconnect.json    |   47 +
 .../arch/x86/arrowlake/uncore-memory.json     |  142 +
 .../arch/x86/arrowlake/uncore-other.json      |   10 +
 .../arch/x86/arrowlake/virtual-memory.json    |  522 ++
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
 .../arch/x86/cascadelakex/clx-metrics.json    |  767 +--
 .../arch/x86/cascadelakex/metricgroups.json   |    9 +-
 .../arch/x86/cascadelakex/uncore-cache.json   |   60 +-
 .../x86/cascadelakex/uncore-interconnect.json |   11 -
 .../arch/x86/emeraldrapids/cache.json         |   28 +-
 .../arch/x86/emeraldrapids/emr-metrics.json   | 1036 ++--
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
 .../arch/x86/graniterapids/cache.json         |  110 +-
 .../arch/x86/graniterapids/counter.json       |    2 +-
 .../arch/x86/graniterapids/frontend.json      |   24 +-
 .../arch/x86/graniterapids/gnr-metrics.json   | 2311 +++++++++
 .../arch/x86/graniterapids/memory.json        |  121 +-
 .../arch/x86/graniterapids/metricgroups.json  |  145 +
 .../arch/x86/graniterapids/other.json         |   99 +
 .../arch/x86/graniterapids/pipeline.json      |   40 +-
 .../arch/x86/graniterapids/uncore-cache.json  |   14 +-
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
 .../arch/x86/icelake/icl-metrics.json         |  849 +--
 .../pmu-events/arch/x86/icelake/memory.json   |   13 +-
 .../arch/x86/icelake/metricgroups.json        |   10 +-
 .../pmu-events/arch/x86/icelake/pipeline.json |   30 +-
 .../arch/x86/icelake/uncore-interconnect.json |   76 -
 .../arch/x86/icelake/uncore-other.json        |    2 +-
 .../arch/x86/icelake/virtual-memory.json      |   18 +
 .../pmu-events/arch/x86/icelakex/cache.json   |   41 +-
 .../arch/x86/icelakex/frontend.json           |   17 -
 .../arch/x86/icelakex/icx-metrics.json        |  852 +--
 .../pmu-events/arch/x86/icelakex/memory.json  |   13 +-
 .../arch/x86/icelakex/metricgroups.json       |   10 +-
 .../arch/x86/icelakex/pipeline.json           |   30 +-
 .../pmu-events/arch/x86/lunarlake/cache.json  | 1322 ++++-
 .../arch/x86/lunarlake/floating-point.json    |  484 ++
 .../arch/x86/lunarlake/frontend.json          |  654 ++-
 .../arch/x86/lunarlake/lnl-metrics.json       | 4611 +++++++++++++++++
 .../pmu-events/arch/x86/lunarlake/memory.json |  262 +-
 .../arch/x86/lunarlake/metricgroups.json      |  150 +
 .../pmu-events/arch/x86/lunarlake/other.json  |  496 +-
 .../arch/x86/lunarlake/pipeline.json          | 2104 +++++++-
 .../arch/x86/lunarlake/uncore-memory.json     |   18 +
 .../arch/x86/lunarlake/virtual-memory.json    |  428 ++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   41 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |   20 +
 .../arch/x86/meteorlake/frontend.json         |    9 +
 .../arch/x86/meteorlake/metricgroups.json     |   10 +-
 .../arch/x86/meteorlake/mtl-metrics.json      | 3818 +++++++++++---
 .../pmu-events/arch/x86/meteorlake/other.json |   22 +
 .../arch/x86/meteorlake/pipeline.json         |   57 +-
 .../pmu-events/arch/x86/rocketlake/cache.json |   34 +-
 .../arch/x86/rocketlake/frontend.json         |   17 -
 .../arch/x86/rocketlake/memory.json           |   13 +-
 .../arch/x86/rocketlake/metricgroups.json     |   10 +-
 .../arch/x86/rocketlake/pipeline.json         |   30 +-
 .../arch/x86/rocketlake/rkl-metrics.json      |  849 +--
 .../x86/rocketlake/uncore-interconnect.json   |   10 -
 .../arch/x86/rocketlake/uncore-other.json     |    2 +-
 .../arch/x86/rocketlake/virtual-memory.json   |   18 +
 .../arch/x86/sapphirerapids/cache.json        |   30 +-
 .../arch/x86/sapphirerapids/frontend.json     |   19 -
 .../arch/x86/sapphirerapids/memory.json       |   15 +-
 .../arch/x86/sapphirerapids/metricgroups.json |   10 +-
 .../arch/x86/sapphirerapids/pipeline.json     |   23 -
 .../arch/x86/sapphirerapids/spr-metrics.json  |  968 ++--
 .../arch/x86/sapphirerapids/uncore-io.json    |  138 +-
 .../arch/x86/sierraforest/counter.json        |    2 +-
 .../arch/x86/sierraforest/other.json          |   20 +
 .../arch/x86/sierraforest/pipeline.json       |    3 +-
 .../arch/x86/sierraforest/srf-metrics.json    |  308 +-
 .../arch/x86/sierraforest/uncore-cache.json   |   28 +-
 .../x86/sierraforest/uncore-interconnect.json |   87 +
 .../arch/x86/sierraforest/uncore-io.json      |  280 +-
 .../arch/x86/sierraforest/uncore-memory.json  |  122 +-
 .../arch/x86/sierraforest/uncore-power.json   |   98 +
 .../arch/x86/skylake/metricgroups.json        |    9 +-
 .../arch/x86/skylake/skl-metrics.json         |  684 ++-
 .../arch/x86/skylakex/metricgroups.json       |    9 +-
 .../arch/x86/skylakex/skx-metrics.json        |  740 +--
 .../arch/x86/skylakex/uncore-cache.json       |   60 +-
 .../x86/skylakex/uncore-interconnect.json     |   11 -
 .../pmu-events/arch/x86/tigerlake/cache.json  |   45 +-
 .../arch/x86/tigerlake/frontend.json          |   17 -
 .../pmu-events/arch/x86/tigerlake/memory.json |   13 +-
 .../arch/x86/tigerlake/metricgroups.json      |   10 +-
 .../arch/x86/tigerlake/pipeline.json          |   30 +-
 .../arch/x86/tigerlake/tgl-metrics.json       |  745 +--
 .../x86/tigerlake/uncore-interconnect.json    |    4 +-
 .../arch/x86/tigerlake/uncore-other.json      |    2 +-
 .../arch/x86/tigerlake/virtual-memory.json    |   18 +
 161 files changed, 37876 insertions(+), 8004 deletions(-)
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
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/lnl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/uncore-memory.json

-- 
2.47.1.545.g3c1d2e2a6a-goog

