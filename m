Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28AA1DE4EF
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756961584; cv=none; b=lB7OBBw67ZZ4NwWh92teb5CdQXsJECax8f7EEBZpEwQczwwBfnQDbG6nTyYvKiAe5Qb8tKz0zT8lS5LRi2q7etBtrgr8PDMQMui4W01OJ0pE+zgVF3qgiflj/TR10OfIq23hvzD1MfuwC/kxUVc8Jc9BH+bUdzHilSnaIXyOeHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756961584; c=relaxed/simple;
	bh=iX5MkaW6uk2g2lp1n8rPFpVA3WPaSAFcOC8TE7e0L0w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=jGqFuWPPA2ClD3TtGs57bzjWA+zWIF1fj0SlHmDQJ2QMjaA/aIwXwkQgyIs/Tb5tLt2hIkuDAsVNSFzoPeVKub1Bxfn0NPds9ZtaoivKl1bM67LH6Aw+0Uxpfj9mOgTYfMj1nJhx7tT/UY83B7y0w0IhFQE+v81/us2bHhD6uwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRafrtwg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRafrtwg"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-325b2959306so1103511a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756961582; x=1757566382; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zVVIKL+/pBsUpr0JnoqQzJtxWBTWc3EqNQldVIetYY8=;
        b=rRafrtwgYjsbM7Go2FmbTKMlk5xiYou02jEZ4uLplXaq/fUMxeLkiZfpnXC6/eJXFw
         4YRXtGZeg8UpZMa64xT1HoCKL6C9+RLVcxsx9F66mEvr578ESkD0LYBCaa1We8Su2mGe
         EOs0S2i/ALabPVBK/tSc0rZtvEzKt7O+Qma3PN2RJ+CunHr82IN8QDE6B7yPEaYF0GN5
         Ul9OtyrC3LKBX99+MPKHjzklXAi4MeQ6hu5+b8Mb0AtI7psYp3aMIvCaHsdHQzSGNfT5
         TnQlVgm+OHuokZzMKiP3UnwKgcQLRvnk+dFyMSI3pEeYFCOeVhzb+K8VVpS4bjP5m/PS
         r8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756961582; x=1757566382;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVVIKL+/pBsUpr0JnoqQzJtxWBTWc3EqNQldVIetYY8=;
        b=TFoL379xCkljRGrsOip/NNaYad+PCITcPjCe2/GMaq/W6+6DfzGkx29kvb7V5CP19K
         Gwqxzuo0OK4EfeE+er+d4wHFGxRtOB29XmMDsiUUpogsB1duCjmMgdtHSx8a8foAAOVW
         brfZDsTWpxnYpEVn9LDokgilMIuplveo2Bxzy+5N31l3Q0walQzjiZj6YYuBKD/k708R
         gEUQjwYXOus+XOX2k01hiMglKY5t0w3ohe7dlvXV1xZVpT2BST6GsCWJ/0PJNvffaMi6
         K/7zCrkP61urpYbsfhEs1Vk5dPwVSIDvTPsiO8c4Bu/36j9rfZnfVeptYHdX/ATEEQy8
         7TkA==
X-Forwarded-Encrypted: i=1; AJvYcCWZb3QEpEszbqgUrJAdmBk6LFHNgMbvLEABUog00KfxL0APhMd9j6rE3sbJPD1YinsDE0/7aldjPbVuc8DpN0XP@vger.kernel.org
X-Gm-Message-State: AOJu0YzceMIuvSE9IVSVzDXCdQAGbQGrNRLH3GEbl0cbNL+WYS/OZSNN
	Ufesrskf8YoIl7/Q5Ho/aKxy5kRP2OwrHmcfiyoGM09Nqaz98VScRxyP57NPAM9UVYPyUeVl/QQ
	Ec/k7rPoVgA==
X-Google-Smtp-Source: AGHT+IFrE+natmbYsPcjQsXWeAo4BZIt168836F2jRX8boByU9B0l1AypBGUCYZiBK3q+16r6SUw+H44qT+v
X-Received: from pjbov14.prod.google.com ([2002:a17:90b:258e:b0:321:c2a7:cbce])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:52ce:b0:327:8c05:f8b6
 with SMTP id 98e67ed59e1d1-328156df7b8mr21371154a91.28.1756961582264; Wed, 03
 Sep 2025 21:53:02 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:52:50 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904045253.1007052-1-irogers@google.com>
Subject: [PATCH v6 0/3] Python generated Arm64 metrics
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
	Benjamin Gray <bgray@linux.ibm.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Generate two sets of additional metrics for Arm64, where the topdown
set decomposes yet further. The metrcs primarily use json events,
where the json contains architecture standard events. Not all events
are in the json, such as for a53 where the events are in
sysfs. Workaround this by adding the sysfs events to the metrics but
longer-term such events should be added to the json.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20250904044653.1002362-1-irogers@google.com/

v6. Fix issue with '\-' escape not being '\\-' (reported-by Sandipan
    Das <sandidas@amd.com>) which didn't alter the generated json.

v5. Rebase. Address review comments from Leo Yan
    <leo.yan@arm.com>. Prefix all metric names with lpm_ (short for
    Linux Perf Metric) so that python generated metrics are clearly
    namespaced. Use cpu-cycles rather than cycles legacy event for
    cycles metrics to avoid confusion with ARM PMUs. Add patch that
    checks events to ensure all possible event names are present in at
    least one json file.
    https://lore.kernel.org/lkml/20250829053235.21994-1-irogers@google.com/

v4. Tweak to build dependencies and rebase.
    https://lore.kernel.org/lkml/20240926175709.410022-1-irogers@google.com/

v3. Some minor code cleanup changes.
    https://lore.kernel.org/lkml/20240314055801.1973422-1-irogers@google.com/

v2. The cycles metrics are now made common and shared with AMD and
    Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
    assumes these patches come after the AMD and Intel sets.
    https://lore.kernel.org/lkml/20240301184942.2660478-1-irogers@google.com/

v1. https://lore.kernel.org/lkml/20240229001325.4157655-1-irogers@google.com/

Ian Rogers (3):
  perf jevents: Add collection of topdown like metrics for arm64
  perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
  perf jevents: Validate that all names given an Event

 tools/perf/pmu-events/Build             |   2 +-
 tools/perf/pmu-events/amd_metrics.py    |   3 +
 tools/perf/pmu-events/arm64_metrics.py  | 150 +++++++++++++++++++++++-
 tools/perf/pmu-events/common_metrics.py |  18 +++
 tools/perf/pmu-events/intel_metrics.py  |   2 +
 tools/perf/pmu-events/metric.py         |  36 ++++++
 6 files changed, 206 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

-- 
2.51.0.338.gd7d06c2dae-goog

