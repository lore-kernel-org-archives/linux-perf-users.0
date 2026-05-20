Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B773F44D9
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299534; cv=none; b=IwhDbREkggYXFdvlKKZB6RZDaIFh0seV4Ui6+5TiTxEbfB5b6UGxvNB3jtVMSpgjTHUoIzedGCdP0qN6BiFlyaPRQ5awG6zp0dvRSVEgY9WDO/E247RWIizF4J6+uuQYv80l/qSbLfGnG9aMgDWqVeTmXQvzzCTmXZaLgWWyxnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299534; c=relaxed/simple;
	bh=EEXHGVwWM1C0H1nnRpc8yiySS0LXmvI2LknDeL+xV0g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lNnI5swx0FsjKLLYXifiBMcHlpxQ89Nw+f6GekJjDQogGgPTmYDpSwrsSpk0eLE+pOT2qh9C5ubx8SrAktXo4S08j0ZtoN9EUggmA/OfaZxpRfS+cu3th7wsjAFfx9/di+J7tzz8Z2JkY+gnLjh7/oHVwSsEaPNhRWDydAb4jP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QETtCW5k; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QETtCW5k"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3684cb22502so4887248a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779299532; x=1779904332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2U3FhCRfMHQDfxrNN/JYZhtih6t6My6+As1AAp0KQI=;
        b=QETtCW5kLmvHmS2wXlZKqF4WjFZ4X/+2FKJa5v1Shhv4CzX2ZZuVc9y2W+PeJMCgYS
         nPGVKtJMF+gjmI2OdSjgEd0k9PLAO9jodW9/vDmgmENUHmXf/0VB915XVZChjHft5w0M
         4hRrIZCMRj5C6y/3/m6d3bIHCNBOP0gkRXNX/pdu0EUaSQU0NoLmfpomcGw65m+ZpycQ
         cNvDnGWGktmyWf3Vml0Nx5FvVLJ3cVmFGAMx15p/xXshvYumwZx7wgyqQHnkaW4bbbHc
         4+ow9Rxx0ozhkNFBqFbjEqOxFMhRdlVj+pZ4S9rcu7xb+GRr5Xg4vOderLzrMFxl0Pjl
         TQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779299532; x=1779904332;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2U3FhCRfMHQDfxrNN/JYZhtih6t6My6+As1AAp0KQI=;
        b=p58oovX3Q7nY4C/8iP62gTfoUxtXwo8qlV9j5mvzm2XaEpw4+wTm6pE7aMv9sRkE2X
         GYFXqtYJzMUH0KTPl2m97SnCkNcIUwI71IhM6RMHuaCLQvZFwKaaJCmnTaG5kB6d0oF6
         XU2ZopV1Prprzp7mfCrwMkTUNcnT1J70VBfmy9zqYnbMBi584SPD9ot6fS8PPKyz5xWI
         fl+6U5AqzGbdMexweF+iuJwXiczuL54ERrf0sk+EKKCTuN6lZ6DZbzcprAkJ1Dw8Qhep
         1um1x08ZBbjWXXcKdjhP3d5TFlnx3vVbhFq23XQ9CzlkMuP8Dy2IoztgR/Ago4ijbY3d
         vH5w==
X-Forwarded-Encrypted: i=1; AFNElJ/0hLfPMp4Ruxn5IjvSrQree2JWUZ5RM75sIoj1PUwKYO1Du+jzxRQLhWL0CBRoLuFfoP/IzS2V50fbFtfR6/50@vger.kernel.org
X-Gm-Message-State: AOJu0YwA6KG0bWMJhS3uw20NIO/h1AJvgWaxyntlSMGl3HbTYV47IaVS
	vrZxrOjGKqbt64EVx57mFA79bP6O7aAbno9Rea/6oKSs9iArdnAWYkGZu+ibVAzbzDdFLJoBVIz
	XL1GQrg==
X-Received: from pjbjs11.prod.google.com ([2002:a17:90b:148b:b0:369:2b54:e186])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:568d:b0:368:6ff3:6678
 with SMTP id 98e67ed59e1d1-36951cb832cmr27002510a91.20.1779299531975; Wed, 20
 May 2026 10:52:11 -0700 (PDT)
Date: Wed, 20 May 2026 10:47:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520175038.3039546-1-ctshao@google.com>
Subject: [PATCH 0/2] perf stat: Fix uncore metric scaling across aggregation modes
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, sandipan.das@amd.com, 
	leo.yan@arm.com, thomas.falcon@intel.com, yang.lee@linux.alibaba.com, 
	linux-perf-users@vger.kernel.org
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
  {"ns  lpm_miss_lat_rem" : "230.0", "ns  lpm_miss_lat_loc" : "220.8"}
  $ perf stat -M lpm_miss_lat --per-socket --metric-only -a -j -- sleep 1
  {"socket" : "S0", "ns  lpm_miss_lat_rem" : "232.5", "ns  lpm_miss_lat_loc" : "269.9"}
  {"socket" : "S1", "ns  lpm_miss_lat_rem" : "225.7", "ns  lpm_miss_lat_loc" : "262.3"}

Chun-Tse Shao (2):
  perf stat: Add aggr_nr metric parser support
  perf stat: Use aggr_nr scaling for Intel uncore miss latency metrics

 tools/perf/pmu-events/intel_metrics.py |  8 ++++----
 tools/perf/pmu-events/metric.py        | 11 +++++++++--
 tools/perf/util/expr.c                 | 27 ++++++++++++++++++++++----
 tools/perf/util/expr.h                 |  4 ++++
 tools/perf/util/expr.l                 |  1 +
 tools/perf/util/expr.y                 | 24 ++++++++++++++++-------
 tools/perf/util/stat-shadow.c          |  4 +++-
 7 files changed, 61 insertions(+), 18 deletions(-)

--
2.54.0.669.g59709faab0-goog

