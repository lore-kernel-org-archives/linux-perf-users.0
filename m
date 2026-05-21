Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB701385D82
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 03:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779335987; cv=none; b=lf7Njdr8DNmsaBwFdaeHJ8N3mk6/eavGJ1fl4Zc5EplhVnZOHGOQD2n+liIEVmokfbY9mHYO1BWMgg+IJHYmzh+Rdh+1g0k0a6AjwUQfMNEaka8QS2YW2zwp7RiYPkgrdT7+bZGUczmQK4hOI+pcqHjTMpUjISziuEtl6LQFbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779335987; c=relaxed/simple;
	bh=hHIiGfiRCJvMdXu777Y0UycAEYG/2nUPbfHXTSnwQ90=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NPz0HDt0pRg9Xi5e9DpmGXNvyJsjx56HPxFFN4I2H/9xK6T7+LnyN0V7zySMcr9Vk1z9x5Bs5htD7vKurClnOTeLkKQxeZt1ZjGZRgcMKWcrx4Yrqt/swvikPND4/jURKEwbewVnmFR7mGoed6W3G4ee7PcLLETA+1dquKKrmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=da2qhXvb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="da2qhXvb"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8292a9605aso2773012a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 20:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779335985; x=1779940785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yQ77DZfbwsrnILOc/RgYDHWIc2cWyZADC9dRzxGrBLQ=;
        b=da2qhXvbeTiNQ/r53EVlV31lVft2XbB/j/71Wga9kLzn7FUjG8pqB8Y7VXwA9BNTvL
         AnzYY2qaKvxkv3W6EJcoIAgYhDVPOSH7Ma5W6BAEQ/7DFDZdNYSgPv2xUy1U/ZuHxRIS
         ukShE9TInl6wtrWxgGAeRjXJVRTdJec0ULYJeWNN0t/u6Mh/b9POSyoesgOdnf6VgqAj
         07VMv/hURZCqdkBL1IFathf+xehkdHemKZJZTVOCF9l9254h/e7H6Y9Ko3pznjEFo/Dg
         +Lns3dlVsbFVzhW6falETQXarVz31XJz/hY5D48nIlTlkdmkCujtxHsjWF503SFNYRcj
         DQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779335985; x=1779940785;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQ77DZfbwsrnILOc/RgYDHWIc2cWyZADC9dRzxGrBLQ=;
        b=e+No1tXcCTguYMEyP8mx2ktrAsLYFc+RDVYz9TXjmIeyzkZibtwpOBOt0ogknaXxhc
         2tsdeZ3dSQxkLjjox2JAnwGQuz4WBX17nrRogQirLvV2wZHfPRINN1XipunioqRLmMRl
         wwYQAlJOYz71p+xTWYs2YltncGiZXXsa8C7qldckjialh1rOjE9d5QWu7isA9xBe/gkw
         z8jX5vPWaZCrNmq2ZprcqWBfwDPdSonQR9ZD2oLbWOBJeIAP4kRpKcrSFZ7jTTMmRPkO
         H1kEkK/eUT6LLh5SlAnv3r0CwhbgWW92FERz7Bri+4RbZXJMW9UueId9wmNDCg2j0WiT
         wSGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZAElNjG0kywfV2B7ztUO/wmHvoRCfiFn/L9yzaAEVEcr0+DWuWV8gtQsLoE5b/SpXUtoFLGhmTvJ8xoAsCMZk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5pwVfglJOQPj9Ij/WQ/6qS6zYJQMAXKjXGPvDdHocvIkhkG3p
	VvkUEHZDvAVcxg45vhVvjB6MiQvbzZ0aUb6bIYcOpr4Vg8NwQiiwEvZdl5KF3Uj/A838Y91T9/r
	9QrZvtw==
X-Received: from pfblg3.prod.google.com ([2002:a05:6a00:7083:b0:82f:bf29:61aa])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d98:b0:398:840d:39aa
 with SMTP id adf61e73a8af0-3b3087f7df0mr1286580637.29.1779335984754; Wed, 20
 May 2026 20:59:44 -0700 (PDT)
Date: Wed, 20 May 2026 20:59:39 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260521035941.3860145-1-ctshao@google.com>
Subject: [PATCH v2 0/2] perf stat: Fix uncore metric scaling across
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
group (`aggr->nr`).

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
  {"ns  lpm_miss_lat_rem" : "232.0", "ns  lpm_miss_lat_loc" : "235.7"}
  $ perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
  {"socket" : "S0", "ns  lpm_miss_lat_rem" : "218.1", "ns  lpm_miss_lat_loc" : "183.6"}
  {"socket" : "S1", "ns  lpm_miss_lat_rem" : "232.5", "ns  lpm_miss_lat_loc" : "259.6"}

v2:
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
 tools/perf/pmu-events/metric.py        | 10 ++++++++--
 tools/perf/util/expr.c                 | 26 ++++++++++++++++++++++----
 tools/perf/util/expr.h                 |  6 +++++-
 tools/perf/util/expr.l                 |  1 +
 tools/perf/util/expr.y                 | 24 +++++++++++++++++-------
 tools/perf/util/stat-shadow.c          |  6 +++++-
 7 files changed, 61 insertions(+), 18 deletions(-)

--
2.54.0.669.g59709faab0-goog

