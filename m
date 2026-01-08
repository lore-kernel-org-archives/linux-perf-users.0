Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B816833986A
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767907637; cv=none; b=hzo26TOiGw8Vg8nkXUgwbxCa8MvJxDd6jKRHRw6cEgqaf41CjlZAbMuc+JY0/O/ATKJTUFJl3Iv0wA6tlerVuBQaNCtZS4ROhtFf+YMoYyGJpH6Abect03w1bjBzxdbwCA2p/7cjDOHq1ejdPg+W/jYHns8Zp8N9zrZe7yXF0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767907637; c=relaxed/simple;
	bh=LeqtgBJPe3g55xa94sjBSL4AcnLeDmG/Kl0HaLcJ2hw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Lcf6Z5zSWQMAtZ3GYj5ertiishRdA7byksLKtmvhlib02KJVYIKKiQt5Hm7FXuUn3uT/xSxwV4AxieXUg+9pWkhB+xucDceTTXH3cb9sZXTdjCmiLpdI9zvi6VuyB5vt0PQJyk13dFiJKFRWFSxTXNKLH+XVp4K9JOxbylrhczQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YonlKML6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YonlKML6"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a0f47c0e60so77734045ad.3
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 13:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767907635; x=1768512435; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p086liaD/KQKFAJCJmw+dgvkW+7Z68Z14bHFI3MN/3g=;
        b=YonlKML6nrRqNGoBcHmFJbiaxFf+QF3nBg5a75Kgb4Qa2eEYzSejon6kIR6sQeom6r
         vwClm6344TDCAPFtBRhzpSHWOvRXeO7PjMoC/3GQzd+bbyj/dJmNvCHUfYJ7cZLYa0n2
         z06f+Yb5UQdqPGMfNuBogFAXqHWzlt6l55KXs2TUgw2x6+poORioEsjIIwB/AD8dZoo4
         CXZpdW8TWeQUj623z1uXUx80b5LOdsNqXxIYTqGKJYP1L99NaBoEv+QeM4OgkqzBKG3k
         AWAuL72INwMyYvY6sFrtNZwIRrhWqGAILPL4oniXecvFNuJpkwp6uZKtnTDmDBCdtR4P
         wsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767907635; x=1768512435;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p086liaD/KQKFAJCJmw+dgvkW+7Z68Z14bHFI3MN/3g=;
        b=v5xEjhGxszW1te6tL29LQzj2+eSJ6/4vpTaLcWeE312VRuKpVzpyBatoDKLxuk6dIg
         XTeNq4NwIIL+kX5dWBoohbrmdccfNmnOsuqb9oRg4e5AabEszsx4lKG/53mk+DElLLQz
         j5QySsaK6SvoJYeG4hqyu72adgZIc3FIRXFG5l/kB9WzHCRWWkPLAMnNr1QldtG1c+W5
         2VXid49D/9mbZn20TgAD+es2zgBebbCu9saTSP4kF2Wtsm5Fws4Kj4xfSR/n9wPj9ry9
         J7w1n1ZuGwqTNgQmdtd+SiKRbk/XgQ/9+kOeGY1G3Cg3Nbqsv+RvR9kxr1P2FCbQK/7P
         EnIw==
X-Forwarded-Encrypted: i=1; AJvYcCU3kRdWVv13wawaaaD3V+9NUuiu7y+ITB9Ip3tWDPzy3m0Jryy9mYItCb4OXz1hQyh/bLzHsoeK/3BdDyLvn5dA@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvZTAZgbdflfl5I2o7jHYJxh6u8s4FzGx6/v8LugLm4CJyQ1d
	0Bw11qg06NV7ZGLm1nzJgxd58zsG9QWPJrDWBaMHSoL+/r6C3dG/5xH42slCoit21BC+HjMz20d
	KVPlmbke+NQ==
X-Google-Smtp-Source: AGHT+IFp5FjA7Cjuv+s2vsf9WyoqQr9/PFEL77kx5cC9ZHQxA7057WV5eMo9ydyYYUXJZkbl/675oMiNU/Lu
X-Received: from plbke11.prod.google.com ([2002:a17:903:340b:b0:29e:ebb4:3936])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234a:b0:298:2e7a:3c47
 with SMTP id d9443c01a7336-2a3ee49c6cemr72179935ad.42.1767907635059; Thu, 08
 Jan 2026 13:27:15 -0800 (PST)
Date: Thu,  8 Jan 2026 13:26:49 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108212652.768875-1-irogers@google.com>
Subject: [PATCH v6 0/3] perf stat affinity changes
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

Change how affinities work with evlist__for_each_cpu. Move the
affinity code into the iterator to simplify setting it up. Detect when
affinities will and won't be profitable, for example a tool event and
a regular perf event (or read group) may face less delay from a single
IPI for the event read than from a call to sched_setaffinity. Add a
 --no-affinity flag to perf stat to allow affinities to be disabled.

v6: Drop merged tool event change. Move TPEBS fix into its own patch
    1st.

v5: Drop merged changes. Move tool event reading to first
    patch. Change --no-affinity flag to --affinity/--no-affinity flag.
https://lore.kernel.org/lkml/20251118211326.1840989-1-irogers@google.com/
    On v5 there was discussion with Andi Kleen who points out that
    affinities will work better with real time priorities but using
    this requires privileges.

v4: Rebase. Add patch to reduce scope of walltime_nsec_stats now that
    the legacy metric code is no more. Minor tweak to the ru_stats
    clean up.
https://lore.kernel.org/lkml/20251113180517.44096-1-irogers@google.com/

v3: Add affinity clean ups and read tool events last.
https://lore.kernel.org/lkml/20251106071241.141234-1-irogers@google.com/

v2: Fixed an aggregation index issue:
https://lore.kernel.org/lkml/20251104234148.3103176-2-irogers@google.com/

v1:
https://lore.kernel.org/lkml/20251104053449.1208800-1-irogers@google.com/

Ian Rogers (3):
  perf evlist: Missing TPEBS close in evlist__close
  perf evlist: Reduce affinity use and move into iterator, fix no
    affinity
  perf stat: Add no-affinity flag

 tools/perf/Documentation/perf-stat.txt |   4 +
 tools/perf/builtin-stat.c              | 114 ++++++++----------
 tools/perf/util/evlist.c               | 156 +++++++++++++++----------
 tools/perf/util/evlist.h               |  27 +++--
 tools/perf/util/pmu.c                  |  12 ++
 tools/perf/util/pmu.h                  |   1 +
 6 files changed, 183 insertions(+), 131 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog

