Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6E37EFE2
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269441; cv=none; b=N4vb+gpX0CHzRT4wlqytmOToeXFiSFVKn9GAKScTxJMKDfkUBCzpj00s/XZiOFFnMNOGn/YiAmFSYwGfGB0UKzMMQy1Ei1cFMkxsEUtLb4z1hfman7AKyMHpst2uYQ5oU2Kk7rG5K47DC1zuXlG/Figs0/dACqmtxe8AkX01x8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269441; c=relaxed/simple;
	bh=4SoFhzVw/94tqvtflu+Tj1a78SUgPAk/QO2ub5Qe2cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WESPtt+QJQ7uKGhvPyCRsWliHCybPAeLFLy0ritl1zH7ao7K2uhBSIJwcdvW1S6OKgG7tesVZQsEamp/y9BCxGSDMkgTqlh3Azn/qX3GZ2D9O/T18hgB8bx0BdJAT9ZeWDFswvnbpNY4bHXV0DIA/5gl/a6RL68dxYyqak4nuFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5PzefRV; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5PzefRV"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33310847fcaso4088965eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790269438; x=1790874238; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cyXAOukuVR4PO1yjp7Vd0Zlf5j4zZeUYttuhWOvgjiE=;
        b=f5PzefRVcfcYBHgaMMbp9bgFk3SVqtuPZLAzUimB7ZhGOxIr8MEdfNUREtJTJ09URo
         eMBRbXD2coICtVwQ3JLDCKdGrGh4Hn560aCxdpgx8qttN+FzX2v9TfQaWkTrfVeR9Jkq
         nlqSSjHl2U8JFlRxQX2lCKPN295Y54u3ZHTJCfjxlDNHImPn9FyouWrbfrJiD5SrtUWm
         dBpGJ3ORqpUpHgJAl7YCU+xX1OynICkbhICgpL1Ce/2RnPe+2n4YGsnHUiVBlenP1gef
         lFHYU6YWJKS//jqp4UQjuBdyGGZwzkgGebl+NA0N5x85ztUaS5SO1NfwcoyoEh0B8l3E
         Y4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269438; x=1790874238;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cyXAOukuVR4PO1yjp7Vd0Zlf5j4zZeUYttuhWOvgjiE=;
        b=X1T//GWgdbglnN3SqwjkFw+5mHOqLq87jlSzc7t2WJrZKOhBv9mPjTdE0bBQxk1b5E
         uZgqiVd4lZgYSabSj0xxB3p81rpzvhuIcU5nA+dRdzFjyOlhIXt2cadUqG1Q2AIsr5w1
         OyZZ81byCA1+q8c2/caXyVsfhB2hFBAm1fqe12BBykffLFYlYiuimdSxk8LEaeM7QEUa
         ohi4kN4SYEemDGde60y3gULEiwPqav91mrodJHR6/RBNCxdLuPE52SLKxfxDzCCPhyip
         KaZfqNsB4JUA7Ff/r3OG9PSeuk0NukzDVsYdC++VONs5O75rVHnNyb1HTM5J7l7cv2c2
         Nu+w==
X-Forwarded-Encrypted: i=1; AKwUvByuUyjT1earlzUOE90aGmQaXghaD/TI445u6CmXdyBYWTuDUWGcrv/SaiV1ofvstXWl8chMQmhrsxc0PcmZtTDo@vger.kernel.org
X-Gm-Message-State: AFuF++nabpksIpnd2vRwluQnDkP7PPnsT5WLzeQXFqmn/KmQ98yOhOxH
	AHo1RON2VHNhhQePAsVfqBm2HpTiXb7mQmyUcmJY46y5dJ/BlEJgsbiYfbBijak3z4YYc78YgpZ
	3V4ve94yGEQ==
X-Received: from dlj31.prod.google.com ([2002:a05:7022:51f:b0:144:fbc3:1059])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:98f:b0:143:298e:459e
 with SMTP id a92af1059eb24-14503fd98bfmr3578370c88.41.1790269437794; Thu, 24
 Sep 2026 10:03:57 -0700 (PDT)
Date: Thu, 24 Sep 2026 10:03:20 -0700
In-Reply-To: <20260924053645.3555041-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924053645.3555041-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924170346.3872848-1-irogers@google.com>
Subject: [PATCH v2 00/26] perf vendor events intel: update
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, edward.baker@intel.com, perry.taylor@intel.com, 
	eranian@google.com
Cc: adrian.hunter@intel.com, afaerber@suse.de, ctshao@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mani@kernel.org, mingo@redhat.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Sync the Linux kernel perf PMU event json with the latest upstream
Intel perfmon repository. The updates were created by running:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py

v2 adds fixes for a number of umask encodings a bug caught by Sashiko
in v1. The fix to the perfmon converter script is in:
ttps://github.com/intel/perfmon/pull/388

v1:
https://lore.kernel.org/linux-perf-users/20260924053645.3555041-1-irogers@google.com/

Ian Rogers (26):
  perf vendor events intel: Update alderlake events from 1.40 to 1.41
  perf vendor events intel: Update alderlaken events from 1.40 to 1.41
  perf vendor events intel: Update arrowlake events from 1.20 to 1.21
  perf vendor events intel: Update broadwell metrics to TMA 5.2
  perf vendor events intel: Update cascadelakex metrics to TMA 5.2
  perf vendor events intel: Update emeraldrapids events from 1.24 to
    1.25
  perf vendor events intel: Update graniterapids events from 1.20 to
    1.21
  perf vendor events intel: Update haswell metrics to TMA 5.2
  perf vendor events intel: Update icelake events to 1.25 and TMA
    metrics to 5.2
  perf vendor events intel: Update icelakex events to 1.31 and TMA
    metrics to 5.2
  perf vendor events intel: Update ivybridge metrics to TMA 5.2
  perf vendor events intel: Update ivytown metrics to TMA 5.2
  perf vendor events intel: Update jaketown metrics to TMA 5.2
  perf vendor events intel: Update meteorlake events from 1.22 to 1.23
  perf vendor events intel: Update novalake events from 1.00 to 1.04
  perf vendor events intel: Update pantherlake events from 1.07 to 1.08
  perf vendor events intel: Update rocketlake events from 1.04 to 1.06
  perf vendor events intel: Update sandybridge metrics to TMA 5.2
  perf vendor events intel: Update sapphirerapids events from 1.39 to
    1.40
  perf vendor events intel: Update skylake metrics to TMA 5.2
  perf vendor events intel: Update tigerlake events to 1.20 and TMA
    metrics to 5.2
  perf vendor events intel: Fix clearwaterforest umask encoding.
  perf vendor events intel: Fix lunarlake umask encoding.
  perf vendor events intel: Fix sierraforest umask encoding.
  perf vendor events intel: Fix skylakex umask encoding.
  perf vendor events intel: Fix snowridgex umask encoding.

 .../pmu-events/arch/x86/alderlake/cache.json  |   4 +-
 .../pmu-events/arch/x86/alderlake/memory.json |  13 +
 .../pmu-events/arch/x86/alderlake/other.json  |  10 +
 .../arch/x86/alderlake/pipeline.json          |   6 +-
 .../pmu-events/arch/x86/alderlaken/cache.json |   4 +-
 .../pmu-events/arch/x86/arrowlake/cache.json  |   1 +
 .../pmu-events/arch/x86/arrowlake/other.json  |  19 +
 .../arch/x86/arrowlake/pipeline.json          |  10 +-
 .../arch/x86/broadwell/bdw-metrics.json       |  51 +-
 .../arch/x86/broadwell/metricgroups.json      |   3 +-
 .../arch/x86/broadwellde/bdwde-metrics.json   |  49 +-
 .../arch/x86/broadwellde/metricgroups.json    |   3 +-
 .../arch/x86/broadwellx/bdx-metrics.json      |  63 +--
 .../arch/x86/broadwellx/metricgroups.json     |   3 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |  94 ++--
 .../arch/x86/cascadelakex/metricgroups.json   |   3 +-
 .../x86/cascadelakex/uncore-interconnect.json |   6 +
 .../arch/x86/clearwaterforest/pipeline.json   |   3 +-
 .../x86/clearwaterforest/uncore-cache.json    |   5 +
 .../clearwaterforest/uncore-interconnect.json |   2 +
 .../arch/x86/emeraldrapids/cache.json         |   2 +-
 .../arch/x86/emeraldrapids/memory.json        |  35 ++
 .../arch/x86/emeraldrapids/other.json         |   9 +
 .../arch/x86/emeraldrapids/pipeline.json      |  10 +-
 .../arch/x86/emeraldrapids/uncore-cache.json  |  42 ++
 .../emeraldrapids/uncore-interconnect.json    |  12 +
 .../arch/x86/emeraldrapids/uncore-io.json     |  54 +-
 .../arch/x86/emeraldrapids/uncore-memory.json |  10 +
 .../arch/x86/graniterapids/other.json         |   9 +
 .../arch/x86/graniterapids/pipeline.json      |   6 +-
 .../arch/x86/graniterapids/uncore-cache.json  |  15 +
 .../graniterapids/uncore-interconnect.json    |   2 +
 .../arch/x86/graniterapids/uncore-io.json     |  12 +
 .../arch/x86/haswell/hsw-metrics.json         |  49 +-
 .../arch/x86/haswell/metricgroups.json        |   3 +-
 .../arch/x86/haswellx/hsx-metrics.json        |  61 +--
 .../arch/x86/haswellx/metricgroups.json       |   3 +-
 .../arch/x86/icelake/icl-metrics.json         |  84 ++-
 .../pmu-events/arch/x86/icelake/memory.json   |  24 +
 .../arch/x86/icelake/metricgroups.json        |   2 +-
 .../pmu-events/arch/x86/icelake/other.json    |   9 +
 .../pmu-events/arch/x86/icelake/pipeline.json |   9 +-
 .../arch/x86/icelakex/icx-metrics.json        | 101 ++--
 .../pmu-events/arch/x86/icelakex/memory.json  |  24 +
 .../arch/x86/icelakex/metricgroups.json       |   2 +-
 .../pmu-events/arch/x86/icelakex/other.json   |   9 +
 .../arch/x86/icelakex/pipeline.json           |   7 +-
 .../arch/x86/icelakex/uncore-cache.json       |  79 +++
 .../x86/icelakex/uncore-interconnect.json     |  22 +
 .../arch/x86/ivybridge/ivb-metrics.json       |  51 +-
 .../arch/x86/ivybridge/metricgroups.json      |   3 +-
 .../arch/x86/ivytown/ivt-metrics.json         |  63 +--
 .../arch/x86/ivytown/metricgroups.json        |   3 +-
 .../arch/x86/jaketown/jkt-metrics.json        |  41 +-
 .../arch/x86/jaketown/metricgroups.json       |   3 +-
 .../pmu-events/arch/x86/lunarlake/cache.json  |   3 +
 .../arch/x86/lunarlake/pipeline.json          |   2 +
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  26 +-
 .../pmu-events/arch/x86/meteorlake/other.json |  10 +
 .../arch/x86/meteorlake/pipeline.json         |   6 +-
 .../pmu-events/arch/x86/novalake/cache.json   | 500 ++++++++++++++++-
 .../arch/x86/novalake/floating-point.json     | 423 +++++++++++++++
 .../arch/x86/novalake/frontend.json           | 147 ++++-
 .../pmu-events/arch/x86/novalake/memory.json  |  24 +
 .../pmu-events/arch/x86/novalake/other.json   | 213 ++++++++
 .../arch/x86/novalake/pipeline.json           | 508 +++++++++++++++++-
 .../arch/x86/novalake/virtual-memory.json     | 173 ++++++
 .../arch/x86/pantherlake/cache.json           |   3 +
 .../arch/x86/pantherlake/other.json           |  10 +
 .../arch/x86/pantherlake/pipeline.json        |  10 +-
 .../arch/x86/rocketlake/memory.json           |  24 +
 .../arch/x86/rocketlake/metricgroups.json     |   2 +-
 .../pmu-events/arch/x86/rocketlake/other.json |   9 +
 .../arch/x86/rocketlake/pipeline.json         |   9 +-
 .../arch/x86/rocketlake/rkl-metrics.json      |  84 ++-
 .../arch/x86/sandybridge/metricgroups.json    |   3 +-
 .../arch/x86/sandybridge/snb-metrics.json     |  35 +-
 .../arch/x86/sapphirerapids/cache.json        |   2 +-
 .../arch/x86/sapphirerapids/memory.json       |  35 ++
 .../arch/x86/sapphirerapids/metricgroups.json |   2 +-
 .../arch/x86/sapphirerapids/other.json        |   9 +
 .../arch/x86/sapphirerapids/pipeline.json     |  10 +-
 .../arch/x86/sapphirerapids/spr-metrics.json  |  93 ++--
 .../arch/x86/sapphirerapids/uncore-cache.json |  42 ++
 .../sapphirerapids/uncore-interconnect.json   |  12 +
 .../arch/x86/sapphirerapids/uncore-io.json    |  54 +-
 .../x86/sapphirerapids/uncore-memory.json     |  10 +
 .../arch/x86/sierraforest/uncore-cache.json   |   5 +
 .../x86/sierraforest/uncore-interconnect.json |   2 +
 .../arch/x86/skylake/metricgroups.json        |   3 +-
 .../arch/x86/skylake/skl-metrics.json         |  59 +-
 .../arch/x86/skylakex/metricgroups.json       |   3 +-
 .../arch/x86/skylakex/skx-metrics.json        |  94 ++--
 .../x86/skylakex/uncore-interconnect.json     |   6 +
 .../arch/x86/snowridgex/uncore-cache.json     |  68 +++
 .../x86/snowridgex/uncore-interconnect.json   |  10 +
 .../arch/x86/tigerlake/metricgroups.json      |   2 +-
 .../pmu-events/arch/x86/tigerlake/other.json  |   9 +
 .../arch/x86/tigerlake/pipeline.json          |   7 +-
 .../arch/x86/tigerlake/tgl-metrics.json       |  82 +--
 100 files changed, 3279 insertions(+), 786 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

