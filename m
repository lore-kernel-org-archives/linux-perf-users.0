Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613067;
	b=W8rpu3MJguoNQwjUpaBTljgc8Li3yoAFJ/dG6sva+szPdrZJHaOsDk8tXy10PV5A3WUb
	 AEMxlzT4v2cE0nQQK9jovazgvriNJInlF1KgIc+UvYTr7Mln2fWiFARzJ2MVJx7fD4HCw
	 LJVAwjTAqvNQR/G7PPWpbA/1iy9nIhdu4H2CX4rhbmwgHlrs7k60SV4HAoebkS1TGKQiN
	 USdq0GBaopRx7YEG/trr+XS6XqG8bT43SOC+rjP0w5szIfkYPGBOFlC7UoG47PEVz8WNR
	 8RF+kpsEwYa7hRQ/oi0NrxH4PjgBuVjpNEgpb0A6lRSJz34J6RnZhoOaDQuGKMJrdaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pLVDazk80F7b1+gU0y/P4r2tn7cr2nu0Ac2cq7/r4wY=;
	b=V2w+a/3Gkx8h7aq9IyQQS+HOBeJB2pW5pfvcxqyCFdbt29K9frXwimJ8xQvPpjSdclnR
	 wCo6iXBH2qBybwaeuvuuCQB0Ox/pOjcVoliUr3S7mWeFHbSQZJCP4n7NNA/okxBDYHR5k
	 BXTpo37eLPp68/kHggzsrInyabQ0kKyWxb/ZmXTbMdGjmlzRZYXJyjL9WQ+HfWzfqfU24
	 4kobXaMaFQbjS38tJ+pSRz3GiPQ+GIqiJ5wQUfeiMklKoaq/XqJoTWU2ZcCk5iLN7/zxI
	 5VtUmZaR6K9bRfbmuvdu3JRtM6iq6P65c4lDJBzuBABqcV/tOVJj4IuG6Yn6sa2WNxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NzY50ccz;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5744A606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 23:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5744A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NzY50ccz
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-378722fd4a3so1759873eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 15:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794613063; x=1795217863; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLVDazk80F7b1+gU0y/P4r2tn7cr2nu0Ac2cq7/r4wY=;
        b=NzY50ccz/hhazGI8QtYwyxsiLQbMVRZD29wX/MqU7LgmYwR1bMnL71saNXWA4ajLhl
         ZAYr9xSzYwlDurFqyVrHqYXf1q05Tg6dIlQhY25O8sNZp74I3RxSst/zjS7FQa9dEF1y
         dOw5cg36g0UZ7BMLAiB6HfZETsS1DyUgPHvzkCSwmiAPNANCLYwC8WYkB9fpUimDSQMy
         0Y+BF8kw+KLoWl2Tuw/kCUUydTzx0p7h6QMCU6CJeAh0Oom00nuWKNCfrAuQ5psmCDPl
         wgpFqhHB1OeszrevL7ZuxAYP9s5B8OGyLUR3jlv3HLPpOvU1NlRcKA7ithsVdIzp2oa2
         vGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613063; x=1795217863;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pLVDazk80F7b1+gU0y/P4r2tn7cr2nu0Ac2cq7/r4wY=;
        b=PtLFvp3gopgwYRr7U1wAO+mu5pYICn7TMfRIhGgEDVATi55scKUvAzmVKpQDlHdl6G
         GVQzpIrJK0cJU/0vdAcgBgS+h57fLxkbvFrkhzvNwffdJkEVmvHLb4PykkaaFX2E5PT6
         Lh9mx/Pe/y4cktvWv7c3GAn8VBd/C3qSN51Ovnt0wamM2QjQbFz18h4yjJL9Od+nK7Tv
         79tnPdiBHVYhY8mH6Bee415pg9oJNq52bCf6m4jtRWqCjbV0jrSOFmKAjZudJ+2TBs8X
         IQWXxn4mBVPpS2+v4oc32ii93LTR7rCEPsoUdEnCj9G4aoL7hxOEwRLT4I3Ql4xDpyk1
         POEA==
X-Forwarded-Encrypted: i=1; AL+hErHKapLbIXqCMi1fS17UXulWKaSrsQYWk1vAsxRu12cLHLInrkdxdUPzC0/2s0xL8/+ZEyjGOxVgimpPBRIAU049@vger.kernel.org
X-Gm-Message-State: APuU4Z95iIuPEuT7vobl/AMF/QOVC9xD56FrpGsmpy26AJN5+v5M/54M
	sk7zl86nohlfzFb3b3ukis1eLqRuDUtgNSDGIg77ruPn9/6ItWVTYQqngftCKc0N24Hce1XBgRw
	tTFO3oqQr8g==
X-Received: from dlbur9.prod.google.com ([2002:a05:7022:ea49:b0:1b3:b4b8:1a68])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ed02:b0:1a3:9936:d11e
 with SMTP id a92af1059eb24-1b50313d85emr3571276c88.41.1794613062929; Fri, 13
 Nov 2026 15:37:42 -0800 (PST)
Date: Fri, 13 Nov 2026 15:37:35 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113233739.3626499-1-irogers@google.com>
Subject: [PATCH v2 0/4] perf tool_pmu: Add procfs memory, network and
 schedstat events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Add tool PMU events for memory usage, network activity, and scheduler
runqueue statistics based on procfs data in /proc/<pid>/statm,
/proc/<pid>/smaps_rollup, /proc/net/dev, and /proc/schedstat:

- Patch 1 adds 26 memory_* events (such as memory_rss, memory_pss,
  memory_uss, memory_size, memory_swap) aggregated across processes in
  system-wide mode or read per-process. Per-process mode holds a
  /proc/<pid> directory descriptor and opens statm/smaps_rollup on each
  read (observing post-exec address spaces without PID-reuse races),
  deduplicates sibling threads sharing a Tgid, and falls back to wait4
  rusage ru_maxrss for memory_rss when a forked workload has already
  exited.
- Patch 2 adds 16 system-wide net_rx_* and net_tx_* events from
  /proc/net/dev, tracking deltas across enable/disable transitions and
  handling mixed CPU-map event groups safely. Per-process and cgroup
  modes are rejected with -EINVAL since /proc/<pid>/net/dev reports
  statistics for the entire network namespace rather than an individual
  process.
- Patch 3 adds 8 per-CPU schedstat_* events from /proc/schedstat,
  tracking per-CPU deltas across enable/disable transitions.
- Patch 4 extends the 'Tool PMU' unit test suite with tests for memory
  events (including multi-threaded Tgid deduplication), network events,
  schedstat events, and mixed CPU-map tool groups.

Because these events are exposed on tool_pmu with JSON descriptions,
they can be used in metrics, listed via 'perf list', and inspected in
the Python ilist application.

This series was developed and reviewed with assistance from an AI coding
agent (Gemini 3.1 Pro) and reviewed with Sashiko.

v2:
  - Rebase onto perf-tools-next (adapting to reads_only_on_cpu_idx0 and
    tool_pmu enable/disable support).
  - Restrict net_* events to system-wide mode (-EINVAL on per-process or
    cgroup open) and report deltas over the enabled interval rather than
    cumulative boot totals (Namhyung Kim).
  - Fix unpadded /proc/net/dev column parsing after ':' and fix memory
    unit scaling and statm field offsets.
  - Open /proc/<pid> with O_DIRECTORY for per-process memory_* events so
    post-exec mm_struct changes are observed, deduplicate threads sharing
    a Tgid, and refine the wait4 ru_maxrss fallback for memory_rss.
  - Handle non-leader attr.disabled and mismatched CPU maps when single-
    CPU and per-CPU tool events are grouped.
  - Add per-CPU schedstat_* tool PMU events and 'Tool PMU' unit tests.

v1: https://lore.kernel.org/linux-perf-users/20260104011738.475680-1-irogers@google.com/

Ian Rogers (4):
  perf tool_pmu: Add memory events
  perf tool_pmu: Add network events
  perf tool_pmu: Add schedstat events
  perf test tool_pmu: Add memory, network and schedstat tests

 tools/perf/builtin-stat.c                     |  81 +-
 .../pmu-events/arch/common/common/tool.json   | 300 ++++++
 tools/perf/pmu-events/empty-pmu-events.c      | 422 +++++---
 tools/perf/tests/tool_pmu.c                   | 689 +++++++++++++
 tools/perf/util/evsel.c                       |  53 +-
 tools/perf/util/pmu.c                         |   4 +-
 tools/perf/util/stat-display.c                |   8 +-
 tools/perf/util/tool_pmu.c                    | 916 ++++++++++++++++--
 tools/perf/util/tool_pmu.h                    |  52 +
 9 files changed, 2316 insertions(+), 209 deletions(-)

-- 
2.56.1.703.gf848ed807c-goog

