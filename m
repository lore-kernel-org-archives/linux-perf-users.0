Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809E190477
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737009845; cv=none; b=IFpb6t6IeNbnvUcTvZlVhPuQiOqMdMdIYokRT5O8CU65AzRWfOCbsv4kBdbJOssrl+nBGJv+B/NaSPs6X2za94smaEDTkaTw5mANhwh7mxQNjLziomCsHxoZ3QUd/ZU8dZJl3N+fGnYvuPh3f52G9WO816Gaix/dMt2m+MBnPtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737009845; c=relaxed/simple;
	bh=DYqTPngCK0y03gTNOCxHHHFo9XhzU/g9cpatDPZdUko=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=q/zRZW/jOqaRQOP3EAxlrJA3mcCmZchSAw87a+ZrBfBpceEk88lIDNCP6RnAP6eTS/iqwftKQY1p5hK0XgkDTsArM6Y1JYPFkNF+mB8+zXZw9xAydjfvf5opdUbAcvtvg2b7SgW357nqdTRDRHdLo582FHkDusFG1sE6KTBL/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cw2wKedw; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cw2wKedw"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e575dd2d472so1738565276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2025 22:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737009842; x=1737614642; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eQDcH25hXRdWt4MgBt/wKETvyV9BEDYZwg12C8WfIJo=;
        b=Cw2wKedweEf3Jd6BMz7qvww7UaPZGhd5rIXLA+jINHVkHG9+bxxGK2mn2A3dD9ACa2
         NljZtdxq5XFlwIpnTjqdQQtTAvLI6Q3Cv3RNHSoissxjNmuMpPeqx10x6D6oDItd2r2n
         /xSYt4JoE6UJCDtpbWqNZyOR/jZWiRa0Tsryh9MJ2V5hCz/SyX9odfnjkLGbyz1mAYVp
         bZM6j3mRiGdTid4b+c9kE0OPgZsSaMoqYEnC0Tx/4H3BgYs0P83GROdYiNL2xaw6fsM6
         KWWV95YnmaL7lpYPp0+TUZSG3zZrzF9IkT/M1jMFq8n33tJlF4sZSp3dy+zhETeI69Xs
         cP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737009842; x=1737614642;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQDcH25hXRdWt4MgBt/wKETvyV9BEDYZwg12C8WfIJo=;
        b=RysfH5qqjZlzNn/rPnkxSzW3tWe3GJNvU2GFR958p5lLe6cnmq1yyBwsgJvtpqhYIo
         Q2w15eHCHXnBQlFcilqsM2xBYwP01eeOMKuvArrE3oCZFVtZF6FCnE+rzZNtoDiFfObS
         +4rApFoZIPvM9K3lhACEDGtx87AjSpxKoYPVd8pK4i8DjuJnutAVIrdjrBb13pINeWL+
         AvNamtXQlKtuLrYFL/qmTcrCleunVM2QhWplVKrvYifeqBEnjhVGMxHazWENkrGjraHC
         IXZnD/jmijcf1FFyQjLqm+rNsTMUNKHegO9Jjya7Fo511KbRDs98xmCdmUb9lYcD8dox
         FuNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtutUDZUyHMM3BzDqrVfPo7t3tOV+WcRvKin3pXaAkCs/u6RO9yH8NVg1OvNgQQTNJAs0qQrETeo5A24y/aBQF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/qLTn5YGcyvpU8XRDLkTaqQCvkPpQ72rZiXZ/Wr8zoi3+436F
	pSzDK+gZrU1jprJixetk6hQxA2qvaycXgTlUDEulmu4fC0wNCJ6BzBFA97We2odhmVXQQL5WTQx
	O8qUtnw==
X-Google-Smtp-Source: AGHT+IFSnX2wWLD6G7QqQLjHJwkLDkO+2fytOLsm17LRdge6e0uiWjK22Jy2NxQb6VwrZpe+br8cxdmzky9p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7bd:ce19:c701:bfa3])
 (user=irogers job=sendgmr) by 2002:a0d:dcc5:0:b0:6e3:1627:e866 with SMTP id
 00721157ae682-6f5312d3b15mr803717b3.3.1737009841886; Wed, 15 Jan 2025
 22:44:01 -0800 (PST)
Date: Wed, 15 Jan 2025 22:43:32 -0800
Message-Id: <20250116064355.344245-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Subject: [PATCH v2 00/23] Intel vendor events and TMA 5.01 metrics
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
Add Arrowlake and Clearwaterforest support.
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

v2: Fix hybrid and Co-authored-by tag issues reported by
    Arnaldo. Updates to Lunarlake and Meteorlake events. Addition of
    Clearwaterforest.

Ian Rogers (23):
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
 .../pmu-events/arch/x86/arrowlake/cache.json  | 1471 ++++++
 .../arch/x86/arrowlake/floating-point.json    |  532 ++
 .../arch/x86/arrowlake/frontend.json          |  609 +++
 .../pmu-events/arch/x86/arrowlake/memory.json |  387 ++
 .../arch/x86/arrowlake/metricgroups.json      |  150 +
 .../pmu-events/arch/x86/arrowlake/other.json  |  279 +
 .../arch/x86/arrowlake/pipeline.json          | 2307 +++++++++
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
 .../arch/x86/clearwaterforest/cache.json      |  144 +
 .../arch/x86/clearwaterforest/counter.json    |    7 +
 .../arch/x86/clearwaterforest/frontend.json   |   18 +
 .../arch/x86/clearwaterforest/memory.json     |   22 +
 .../arch/x86/clearwaterforest/other.json      |   22 +
 .../arch/x86/clearwaterforest/pipeline.json   |  113 +
 .../x86/clearwaterforest/virtual-memory.json  |   29 +
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
 tools/perf/pmu-events/arch/x86/mapfile.csv    |   42 +-
 .../pmu-events/arch/x86/meteorlake/cache.json |  109 +-
 .../arch/x86/meteorlake/frontend.json         |   30 +-
 .../arch/x86/meteorlake/memory.json           |   22 +-
 .../arch/x86/meteorlake/metricgroups.json     |   10 +-
 .../arch/x86/meteorlake/mtl-metrics.json      | 3818 +++++++++++---
 .../pmu-events/arch/x86/meteorlake/other.json |   54 +
 .../arch/x86/meteorlake/pipeline.json         |   89 +-
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
 169 files changed, 38371 insertions(+), 8097 deletions(-)
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
2.48.0.rc2.279.g1de40edade-goog

