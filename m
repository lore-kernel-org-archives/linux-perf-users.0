Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573592DA756
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394513; cv=none; b=Tuoh54yS3Q+zYN0xhHmmCx6H1ZJKy4khNfbtarz98OaTPHWq81Itsf+zy/2aVRmoLb65sFogiQTd7IWv+VHPO+Hv1TQ16MfPihFyfL3EWc2sCRV3QmA1tLPjysr2sjaE82/+sCGXL6SbhzLr+sRYcSnTAiE4eXo+Fe6iCSRA1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394513; c=relaxed/simple;
	bh=Xahjj11AUcnz4050i4/m1I93SB+dwS7vmi/JPV4Fbis=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CwoaQk22YDJXV4McABuSIRGJu79MQGFTMJytQKBlwe72XRpbPm7w1XpGPq85Pho+PjwyLqsLwfU5bgBvXDym7yhG4nilGva/xkubP6diAzFkKthuZYjO8MHgRlnxDDevJlurJ4Gv0lIOUPS+pxo1VkXy69tXVJWIOkQW0m/Sf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g79cT2GX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g79cT2GX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba5f794825so51110505ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779394510; x=1779999310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/1UL/rG6WqCTeWWjqZI4SgCmVn7dOz4q+tIXiGvFkv4=;
        b=g79cT2GXH+Rw6W9PM/LW773UcoXmVcJ2nVrtleWqyLTZnLyu+bdHsQ3oTSN6eu6jmU
         lXcFA8aG8JurY/WFvQnX1+TxR4Vp9z1H4OnPxopwY5/aORDbyocuNu6bl8kdE3WseGNY
         Wk5AX2QEzLCsHsornFYnquK9J2VJoEuUV+72k2KrrIY6b5yCyTWDDed0WVNjuMe2J111
         q1uZBQM2kWX3jOZV3YDph1GKlea46PGnUToNcdcNfgCBaqZPdXnc9q86HJTe9rOGtrer
         I7fiDgk0LI2lJSXSrDfhtcXUHbnz4+j1+gXx/KkXO0ursdl54qqzxbGa3GXvNoKTQ2wK
         RXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779394510; x=1779999310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/1UL/rG6WqCTeWWjqZI4SgCmVn7dOz4q+tIXiGvFkv4=;
        b=duFmH/4+tEyEzXmXC5psmXicGK2O6FoU8D2c3fZW1lt/j06rlY/52whvbyROz6Hvoa
         /KsxYPV+gn3rKSyQn+EmH2moa268oeMFGEtCiHGdXF5ExcwElznMquLRB3gDI0CnOFGn
         6CQjc5xTXsIPfupC0KGXB95Clt2XnrvZhklf0W+O7uuSp93VrDbyfyMtikoRQvDSBDTK
         LhY1xYjntPt5cPPU1X6n434l004//VsOWFtIH7QzfeQZ8gmj1Fia3Ph88axUzSMyKphN
         K7L6xaNmGjIxHM/6ui/m3df+25mG/io0791e4K+cVxiqTcGUBfNA0PI7HAejYwYATetj
         qrUg==
X-Forwarded-Encrypted: i=1; AFNElJ/kgTm87cmr5SYw29qYRp8FFHqgz361u2aGD+tB9ni2efwJQCqDogzCQBJ97fgvghLlWFUb/Aw1E4E3ex5RKoRA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyhh+l5vVLKmexbU9q9Ov3xr9OmEaXTQfSKFXNizC76fiMhLE2
	PkzxWVMGhWJbuV3w9eq+fZ9gNwi4JlK4NszEMlH6s5X34nnrE+nwxDszY61Lc2g/DeBguF2NSQg
	XxksgOw==
X-Received: from plrp20.prod.google.com ([2002:a17:902:b094:b0:2b2:41fc:ea6e])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2388:b0:2b4:5cb8:99eb
 with SMTP id d9443c01a7336-2beb07e9e15mr3525535ad.27.1779394510222; Thu, 21
 May 2026 13:15:10 -0700 (PDT)
Date: Thu, 21 May 2026 13:15:03 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521201505.124690-1-ctshao@google.com>
Subject: [PATCH v3 0/2] perf stat: Fix uncore metric scaling across
 aggregation modes
From: Chun-Tse Shao <ctshao@google.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	sandipan.das@amd.com, leo.yan@arm.com, thomas.falcon@intel.com, 
	yang.lee@linux.alibaba.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes a scaling issue for metrics (like lpm_miss_lat) across
different runtime aggregation modes.

Uncore metrics currently use `source_count` to scale events. However,
`source_count` returns the total uncore unit count regardless of the
selected aggregation mode. When evaluating metrics in different
aggregation mode other than `--per-socket`, this incorrectly divides
aggregated uncore events against the total uncore count rather than the
uncores belonging to the aggregation, leading to wrong metric results.

To fix this, we:
1. Introduce the aggr_nr() keyword to the metric parser, which
dynamically resolves to the active units in the current aggregation
group (`gr->nr`).

2. Update the python metrics to use `aggr_nr` instead of `source_count`,
ensuring correct scaling across all runtime aggregation boundaries.

Before the fix (incorrect low latency in global mode):
  $ perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
  {"ns  lpm_miss_lat_rem" : "122.8", "ns  lpm_miss_lat_loc" : "114.5"}
  $ perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
  {"socket" : "S0", "ns  lpm_miss_lat_rem" : "232.1", "ns  lpm_miss_lat_loc" : "278.2"}
  {"socket" : "S1", "ns  lpm_miss_lat_rem" : "233.9", "ns  lpm_miss_lat_loc" : "257.5"}

After the fix (correct scaled latency in all aggregation modes):
  $ perf stat -M lpm_miss_lat --metric-only -a -j -- sleep 1
  {"ns  lpm_miss_lat_rem" : "231.7", "ns  lpm_miss_lat_loc" : "245.0"}
  $ perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
  {"socket" : "S0", "ns  lpm_miss_lat_rem" : "238.3", "ns  lpm_miss_lat_loc" : "249.4"}
  {"socket" : "S1", "ns  lpm_miss_lat_rem" : "259.1", "ns  lpm_miss_lat_loc" : "253.1"}

v3:
  Fixed based on Sashiko review:
  - Removed the unnecessary, copied `redefined-builtin` pylint-disable
    comment from `aggr_nr` definition inside `metric.py`.

v2: lore.kernel.org/20260521035941.3860145-1-ctshao@google.com
  Fixed based on Sashiko review:
  - Fixed `aggr_nr` setting when an uncore event fails to run
    (counts.run == 0) to explicitly set it to 0 instead of defaulting to
    1.
  - Accumulated `aggr_nr` when multiple unmerged PMU events are
    associated with the same metric ID to prevent incorrect scaling
    across active sockets.
  - Removed unused `List` import from `typing` in `intel_metrics.py`.

v1: lore.kernel.org/20260520180032.3045144-1-ctshao@google.com

Chun-Tse Shao (2):
  perf stat: Add aggr_nr metric parser support
  perf stat: Use aggr_nr scaling for Intel uncore miss latency metrics

 tools/perf/pmu-events/intel_metrics.py |  6 +++---
 tools/perf/pmu-events/metric.py        |  9 +++++++--
 tools/perf/util/expr.c                 | 26 ++++++++++++++++++++++----
 tools/perf/util/expr.h                 |  6 +++++-
 tools/perf/util/expr.l                 |  1 +
 tools/perf/util/expr.y                 | 24 +++++++++++++++++-------
 tools/perf/util/stat-shadow.c          |  6 +++++-
 7 files changed, 60 insertions(+), 18 deletions(-)

--
2.54.0.746.g67dd491aae-goog

