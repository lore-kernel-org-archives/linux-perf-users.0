Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDDF3F9F2D
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300278; cv=none; b=uJEqx1nITKyUdyh3mVw6vLAYxkyJ8UOVKfIVAarHhfYdlpIwAPAO4Wp8kO9cFdTOtxTkB7n5IpNbB4ZoKWbawbTHe4ZBe1mJdKmgjgmfymRi0SVujaFwXje/ixj1COB8B9mOEEfBNPCCw1OlXiDxtYkOdy6Xl5Iq/xo1mwLzuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300278; c=relaxed/simple;
	bh=EEXHGVwWM1C0H1nnRpc8yiySS0LXmvI2LknDeL+xV0g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DHxnAhdRWcd3cTi1CEeO8/16lU4wILzHSRTR1guoN0x3hcKGxpfh4UC6PK8bZmyw6iw2vyGTsKWl4+ZzfmX5MAjCMNfBFTnkUwj/kIP7t1lphytHvtSPlpslUwM+xMVhBJm6QLAW1/nxnFh2iUp5CItBuiudZKuYlQM5jC1nwFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pu4pf0yq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pu4pf0yq"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd00a65673so37924395ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 11:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779300277; x=1779905077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2U3FhCRfMHQDfxrNN/JYZhtih6t6My6+As1AAp0KQI=;
        b=pu4pf0yqX90a8NW+K8NxtNFAEnr9Orh/EZdxu0/8sxOAqyYDR54yX6UXevA+w7Ap2k
         VAKYY7hI8Yk/5KVN6zyF86miEB7m+pwC6dgIp5gdFM/RjXyRoSDnKRLzr7C/NtLbP5lj
         UhLG+s6/o5datzTFmPAT0ER4+zZZoSrinmNwL3ZBYOXRYvTejREcGKroaRnqGFjTJSuj
         0nF6ADvcTZFO7+M04FI3NqHvUPlIxCXBrhtaxRHxKYdbFSJBzmPgRUK7AxlAVZOIuS6S
         Lvnjf9o3fiMz1aa/WvRXr5276gB/BfmWnkFDlCmXI2dkziH9vV9QVnpzx0sYjKTFuyOw
         0bXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300277; x=1779905077;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2U3FhCRfMHQDfxrNN/JYZhtih6t6My6+As1AAp0KQI=;
        b=VNDHqH2cMMA2xkwVoA/hho5TkZNXjW1yjpPlDqilccz5+9Y5Xj00ea5dciuZJ2dnnb
         u2Xoy91LzeZUOLMUDvkM7qBR7RkzozJmBG3xAZ1vcHXJ/ehPMVe54nTb/9HUT6AbZil2
         SwGO9Zgv4nDoaTnojNAzWA+4BWnhBeo0gUg0XcOyaVTidEtmxz6tejLfE2g7pAF/O1Xm
         LerCvRmQRfisGIZuf1yXEgzQGf3IIBHES3RrHtrTFXfTkksNh9vKPevPLDqhnQ6JdNw+
         zpV2/z/ZraZXP39kINMe9TGLls5mzSIAuQNNPi6FtjvDKbrZKSELgmOtEz4AV6HKxQvC
         yFYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AlXk8lQ3Guoct8bFKdVGd4hnWSVpn9m2l0bftdSOhQxFn75/YSftZwu8QkI3Nym7aqFk9IxfMjG4wmvkj5T9L@vger.kernel.org
X-Gm-Message-State: AOJu0YzT67p76nS52483Ji1YVO79fbb+ngtIkCr6UJmLm9iF9GfZpzmU
	3ayULS9lV71fDfQ1Tg1eSLPlyzbINFMYMdfwegsJrHubxOn0j9tJdpcccW/e+8iT7NXCHobWORW
	J1I+DDg==
X-Received: from plsr2.prod.google.com ([2002:a17:902:be02:b0:2b2:48d8:c695])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c9:b0:2b4:64cf:e8f8
 with SMTP id d9443c01a7336-2be9d3dfde3mr4719195ad.2.1779300276371; Wed, 20
 May 2026 11:04:36 -0700 (PDT)
Date: Wed, 20 May 2026 10:58:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
Message-ID: <20260520180032.3045144-1-ctshao@google.com>
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

