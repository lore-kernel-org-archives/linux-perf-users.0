Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0311F4613
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 07:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413168; cv=none; b=siw36ad4kXrBw20dzJNQkuQnbbbfDfpVG691uHVquekDpRpX6MwpswS+8SOOPxMMxwmQzFLPRqxTlYOqt0es+oGUdJ12RSg7/8as3zXXy0pPWB/WaJCnamOXfSFO7N9uRrGZUbYAehW9z1nKLxNCJZZVfqLbbFm7nZ0VYjBvtRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413168; c=relaxed/simple;
	bh=8+UjpKx3squMeS7nyaGruzQoVuSi87GO0yVUBKl3Qyo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=nniwIrLFuiodPSYncHbRaekLbBos0jmUWAXK+D2Vy/XzLQ56zkbuXzmVDRcEtNKwWVGI9QIa0eJhTo4PhBySvaxdtnxc6PfGB0gW98ozfliWzWwVqzatXZ2ebuZfndxzFdveZ0Q9BWb3D9cu4nOOnDcX2KpU3/IlNy9vZPq7as0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SfvhulN8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SfvhulN8"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so585987a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Nov 2025 23:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413166; x=1763017966; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v4AmNcR9EOtX+2dOeKak8qyt5fZmS72AO2PYyA6g9WI=;
        b=SfvhulN8H7Vh0/S420WL5mPYvJIMgvCalOhwBzn6q+tJnr9w7d8TxBgCnd1pkyX+2g
         fmIHt9VkUMtBHkCZNgYpp90ijcC4tyz/jqFcQawsV/dMRfZMy2um60dpjBQwm9uVNufp
         2tB4BUaHRGm817tIFJ9eyQdHFqKv7206h/ybU24m18mvL3ec11BoAEwIGIlN2srrVV1M
         E4lxYbZh33WZVsxkEAWnd/nCdjpmRcbutPTcQrgeUUjYcq10z5kDUGc/CBLaXUkRM3dJ
         I/m4UngaaccTNCaagXVCwsQtx6DBYL7SNKTz3i8MHHGG8qJ4j7gcasidbeettU6JRLUQ
         931g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413166; x=1763017966;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4AmNcR9EOtX+2dOeKak8qyt5fZmS72AO2PYyA6g9WI=;
        b=FHJrVQCjZDqc01v95LfAy0pHFtgyXGwmRfFyFePEPy/yzt1mAbqqUg+Am/e14hKqn6
         FQ2loUp+tQE3WXKPpSV6Ytc6/Y6xhltw70MWs95rKPX4faModcIIoui/3cFaE+kawA7C
         ND5xyPNHdtr8ectaStlk+k7pvFCzHsANHSXb7eHEaTeuGxhy5KD01lJyS5phtmXpcmEN
         amIHDJUK1Egf2btpmL2BTNRxGO1ZByq8Edtxqq93AyY0IXJw5WGQ7EIfxFKEHr43RrRy
         G3cp6fQAQYlzS93pPlCdoik1OyHjiYTR0YL+7jivKKeOWWnKclfsSJnfuviHJQwFA3+n
         /t+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2n7AUTPhnTEqDJBa1r+BzgjCI1c75bjEaXe1RRWLRQr6BvthlRNxK5sHeKCOivwW/DTWMGFtY3lPwfs6yw2HY@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtBP6cCX7HUqhQLYv+p5VBsdG1rqNYNrpIGR1bGmxalWjb49F
	TdM2m2armOroewQY6a9mr+DcmvIE0eVXJzwZEhc+TJ6eYSuhZs+J/JYUjxLMDiJvfvOg/6cZUi/
	8ZSFL/vJueA==
X-Google-Smtp-Source: AGHT+IHAS3m5ak0ZRegf6QrMyqscQrZnjpyohHkKP5bd2DSeRdq8p6CNdzksY6FKjWbFLaKHEVFP+yk8y4mc
X-Received: from dlbqj7.prod.google.com ([2002:a05:7022:ec07:b0:119:49ca:6b88])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d11:b0:246:d43a:3856
 with SMTP id adf61e73a8af0-34f83d0f86fmr7785627637.22.1762413165966; Wed, 05
 Nov 2025 23:12:45 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-1-irogers@google.com>
Subject: [PATCH v3 0/9] perf stat fixes and improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

A collection of fixes aiming to stabilize and make more reasonable
measurements/metrics such as memory bandwidth.

Tool events are changed from getting a PMU cpu map of all online CPUs
to either CPU 0 or all online CPUs. This avoids iterating over useless
CPUs for events in particular `duration_time`. Fix a bug where
duration_time didn't correct use the previous raw counts and would
skip values in interval mode.

Change how json metrics handle tool events. Use the counter value
rather than using shared state with perf stat. A later patch changes
it so that tool events are read last, so that if reading say memory
bandwidth counters you don't divide by an earlier read time and exceed
the theoretical maximum memory bandwidth.

Do some clean up around the shared state in stat-shadow that's no
longer used. It can be fully removed when the legacy json metrics
patch series lands:
https://lore.kernel.org/lkml/20251024175857.808401-1-irogers@google.com/

Change how affinities work with evlist__for_each_cpu. Move the
affinity code into the iterator to simplify setting it up. Detect when
affinities will and won't be profitable, for example a tool event and
a regular perf event (or read group) may face less delay from a single
IPI for the event read than from a call to sched_setaffinity. Add a
 --no-affinity flag to perf stat to allow affinities to be disabled.

v3: Add affinity clean ups and read tool events last.

v2: Fixed an aggregation index issue:
https://lore.kernel.org/lkml/20251104234148.3103176-2-irogers@google.com/

v1:
https://lore.kernel.org/lkml/20251104053449.1208800-1-irogers@google.com/

Ian Rogers (9):
  libperf cpumap: Reduce allocations and sorting in intersect
  perf pmu: perf_cpu_map__new_int to avoid parsing a string
  perf tool_pmu: Use old_count when computing count values for time
    events
  perf stat-shadow: Read tool events directly
  perf stat: Reduce scope of ru_stats
  perf tool_pmu: More accurately set the cpus for tool events
  perf evlist: Reduce affinity use and move into iterator, fix no
    affinity
  perf stat: Read tool events last
  perf stat: Add no-affinity flag

 tools/lib/perf/cpumap.c                |  29 ++--
 tools/perf/Documentation/perf-stat.txt |   4 +
 tools/perf/builtin-stat.c              | 189 +++++++++++++++----------
 tools/perf/util/config.c               |   1 -
 tools/perf/util/drm_pmu.c              |   2 +-
 tools/perf/util/evlist.c               | 156 ++++++++++++--------
 tools/perf/util/evlist.h               |  27 +++-
 tools/perf/util/hwmon_pmu.c            |   2 +-
 tools/perf/util/parse-events.c         |   9 +-
 tools/perf/util/pmu.c                  |  12 ++
 tools/perf/util/pmu.h                  |   1 +
 tools/perf/util/stat-shadow.c          | 149 +++++++++----------
 tools/perf/util/stat.h                 |  16 ---
 tools/perf/util/tool_pmu.c             |  78 ++++++----
 tools/perf/util/tool_pmu.h             |   1 +
 15 files changed, 395 insertions(+), 281 deletions(-)

-- 
2.51.2.1041.gc1ab5b90ca-goog

