Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DBA4C9D
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960856; cv=none; b=gYQRzsuG8zbeCr8/uINnOnA8N0r6dRqZleB5QI9+jy1MM3y22ZwfzBho1Nh6CNlKekH4KIIfzUNDBbRGIEnv2eL9OU6bkh0qg7TLDyuD+NpM5ZlKDVr3hjxze2d5BuxP6MXlLcolIDbp3JrdyxIePb8V1BNlmMKB0jVzv6SE1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960856; c=relaxed/simple;
	bh=3UYR0WoZ1zL2pVGefElUsFUIYeMwhfjbJ2rM8h8NONc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=qve8QCgMKaYi9lEIOPNy9Y8AtASGg/VBz37n19SkkztXJhtoGSqxrDe3CelAOlr/gKba0Y19UycyxvhMMeWutzCN/mkL0tSV+FWoNbDwCotf7QlzOGboWHfyg0y5ARLi7yeQ6FBhLArDr7KqcGHb18FE+zTMpiMezwR8KdcSC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDCBJwty; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dDCBJwty"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-324e41e946eso940157a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960854; x=1757565654; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HzQv/lagePpG7xWFpE+ZsPirtdk207E1Fg5LDYpwofI=;
        b=dDCBJwty2ByIEEFk0KJxyH90HP55i6UO0/o4yn6ngw6VbGXtflFYx8ltBdeT9YQwPr
         5udvhW8+sJqOa8Lyu6kyastTIsbrK04RcS76x3327uYsU89JB+BKbM8jS+AihJGvX2vz
         l6YXO30K5kbG3xHr4D/mBq3z+nTGhuSX8rOCIluJ7QOSR40t+cZ8KDo5xu1XpZfTlfln
         N/XO+zFAPH1T7tAVpn9OkSbH/RWKraGrFabeyoYmvtFOoV2QVAmQyHAkDYJ0ZRRaz81g
         gFW6bqBo8/7dc5GrcDvuMbjuHmlTEpYH8ggaZ1potVGfjvSu76VYNDom//upRtVzTHve
         gOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960854; x=1757565654;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HzQv/lagePpG7xWFpE+ZsPirtdk207E1Fg5LDYpwofI=;
        b=tTYzy7Mg4qWBxgKCsDyLoRVagYrwtC8pZISIhVQSyTlCZycqaEkJvSmOhUzwo+lFLO
         7vb3BEtIvlFhzJVTHEfblzLfZ6/QyYVg2KYppBlCjIOOaANIaJcTIT+5TgcYomNLbHrw
         FiukrPYz5RRLmqMPCKG5xiOMEvxKhe/syuw5rDKAkBBuMxuR2+ruOB69Q6NPCfUO3MUy
         0QaY0TcIQH4n+MXHKHzRla4/yvudQ4Xhdlxoq7rFxEAvZrFDgMKErlc/pStngQx7swLd
         uys6Lb/GpKcmCgAGrw6eIh9Nzc7l1yHC/uLQn3ALFuhvgywUEpEeAHcU5Ef4I2RMdRw7
         tLbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSReiW0eUJgLNBBISVwI1FN6wB/Acvlw7IHqpB4LY/xZs/2nwES21XqF+fWB7kQ9iK3D/ijHh8bIB6e6MPWwW6@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKwyKwKt2/7ZacRej+g5FFuMMwJ4CJcc+vHm9XtSEEEn43SMS
	IpxFhb/vX6rw8H/p7jD25Mxt4bXHYgj/YsVjdxgWW9VLbfOAONpiI5oHXn2wO9v/EHtMKkpudCG
	1nWPwhm4cqg==
X-Google-Smtp-Source: AGHT+IGWvlUfT7YlzLGhL+DTGadzUln5a39hY7lZcp3nYP4NGePK9a4wtXFYXfErKJnzw6eXWMWuXJdblobF
X-Received: from pjg8.prod.google.com ([2002:a17:90b:3f48:b0:32b:50cb:b92f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1845:b0:32b:9ede:bfd2
 with SMTP id 98e67ed59e1d1-32b9edec1b8mr63933a91.22.1756960854284; Wed, 03
 Sep 2025 21:40:54 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:34 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-1-irogers@google.com>
Subject: [PATCH v6 00/13] Python generated AMD Zen metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Generate thirteen sets of additional metrics for AMD zen.  Rapl and
Idle metrics aren't specific to AMD but are placed here for ease and
convenience. Uncore L3 metrics are added along with the majority of
core metrics.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20250904043208.995243-1-irogers@google.com/

v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
    Das <sandidas@amd.com>) which didn't alter the generated json.

v5. Rebase. Add uop cache hit/miss rates patch. Prefix all metric
    names with lpm_ (short for Linux Perf Metric) so that python
    generated metrics are clearly namespaced.
    https://lore.kernel.org/lkml/20250829033138.4166591-1-irogers@google.com/

v4. Rebase.
    https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/

v3. Some minor code cleanup changes.
    https://lore.kernel.org/lkml/20240314055839.1975063-1-irogers@google.com/

v2. Drop the cycles breakdown in favor of having it as a common
    metric, suggested by Kan Liang <kan.liang@linux.intel.com>.
    https://lore.kernel.org/lkml/20240301184737.2660108-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@google.com/

Ian Rogers (13):
  perf jevents: Add RAPL event metric for AMD zen models
  perf jevents: Add idle metric for AMD zen models
  perf jevents: Add upc metric for uops per cycle for AMD
  perf jevents: Add br metric group for branch statistics on AMD
  perf jevents: Add software prefetch (swpf) metric group for AMD
  perf jevents: Add hardware prefetch (hwpf) metric group for AMD
  perf jevents: Add itlb metric group for AMD
  perf jevents: Add dtlb metric group for AMD
  perf jevents: Add uncore l3 metric group for AMD
  perf jevents: Add load store breakdown metrics ldst for AMD
  perf jevents: Add ILP metrics for AMD
  perf jevents: Add context switch metrics for AMD
  perf jevents: Add uop cache hit/miss rates for AMD

 tools/perf/pmu-events/amd_metrics.py | 654 ++++++++++++++++++++++++++-
 1 file changed, 651 insertions(+), 3 deletions(-)

-- 
2.51.0.338.gd7d06c2dae-goog

