Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248DF2E5B21
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143864; cv=none; b=Yig9vC9L1AnJLM8wtg1mBIIxPg4c7AJXvjo19hvq0MT4wjOsxTiLM7TwZgCqtTfQkjjEizlsBaZgQLUDm+KJAQRoziZ0hDaaUzJ+v/XSdIJFaDXWLYU1ipNG0Hx82epucEnU0o8kA42BNi1GADnhB48spRZkh1f4oAW9+rIyiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143864; c=relaxed/simple;
	bh=PrJeS5pOrMvDVW9prhG1ZdLgnyWfgZo1TSbC8C7U+j8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KPtiBsqc1qxRwsuWyZRvQfKIwNKlTKdckHGb249/kvU7KaotAB6zI1PmayzYw+q2F4dCbvg3Mv0k5i5S2IdlqTJJYGpMlnqO7s6llUt3f4v1ZdBY8NwV9Ue73xvQfCBKMYdYWmWcYyiMY15KvJ5XdJFvWOJmkuUwyf+U3VFKFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kAt4lI3v; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kAt4lI3v"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so5595277eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779143862; x=1779748662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGty+mNfP/r8NU1YUN9QiD+4rGzw8XBJGEVRJSP65lA=;
        b=kAt4lI3vp0RrTrI08TshnkMTCMaN4sxbMJ0hF2nLErmgqDBHVPNdPRScxeyJZfmsfd
         LOELZ9UPZ3Y6SZntQCdAXaxPrIUTSOzsbLunkhznHxLSLTnje/0YSEZS1ez0FqAiuGsO
         eTYvx2Xmk2PO0QapstFVYqKMwh9VKV3nVN2xpmGzUC4EAl3J63Z5l+7nbqG1xJROLE/i
         t7aWQBk3wtC2nzQymfYdJNMv/ZU6bnUY33ac8eAwsyXRLjMaMTKYse62rPn3h96QO97s
         CLqamwflPFrAaF4wwb9jZkohZN2oCeSypj7tJjxDjYsmLPoVYHi/Eooho1O1mJFA4dT1
         Gwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779143862; x=1779748662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGty+mNfP/r8NU1YUN9QiD+4rGzw8XBJGEVRJSP65lA=;
        b=JmwrbqUrvUkCssg+yJ4WblypeYffFOZ5GOYN1gU94SK83fCUjzyq7OrLX+9Ljngg24
         o7GGTl3Q+XaxYV9YCml2LzHF110RIwZXC0TB7DeDCDr2RHMIzInXryVmWbzkdyRcBU7h
         FHZjdRvyughTmWDkDppPi7hBAdRpeZ4OYk2u1lCwHpxlHAU1J7Lh45c6MNozxH3Dhami
         eFYkdfYZpwNLPtiuZCX4GcwbzxmGkxLmbsfAEscfgG7HhBM67Fg0FMyQFAFE/QkmII4a
         lWm+eam01jgz/+ABQrH6cCBRwfGVlA7xz6+jTIK91FAMA6KRXAT1uTC1lCA1Sqf/i2fh
         kX3A==
X-Forwarded-Encrypted: i=1; AFNElJ992oHVqTtnXT1uMwk3RvoxuB+42PSOUnNDMAwrOhVTkzWdCX1ebhl+3hZAS+GInbPhDE6VBDhX9hjBnx4FxSxx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfzcckkih8/lzwLPpu55HrCq0wlk+1h8twO4sWY+w+Xu7p2PCt
	6tmaxyVEbDFF5xdAR6ySYk36xudzNOmv2ame6TJN1lexqj1lQtVBGdNR3kZDSRNTQocx/0/Dydd
	b8SlGj6+vRw==
X-Received: from dyay16.prod.google.com ([2002:a05:693c:62d0:b0:303:9286:5378])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7490:b0:2dd:c066:c02
 with SMTP id 5a478bee46e88-30398677242mr7852686eec.22.1779143861820; Mon, 18
 May 2026 15:37:41 -0700 (PDT)
Date: Mon, 18 May 2026 15:37:31 -0700
In-Reply-To: <20260518201419.2943132-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518201419.2943132-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518223733.3034897-1-irogers@google.com>
Subject: [PATCH v3 0/2] perf tool_pmu: Support enable/disable for tool PMU events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, nigro.fra@gmail.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

A regression in perf stat was reported where tool PMU events (like
duration_time used in CPUs_utilized metric) incorrectly included the
delay period when using the delay option (-D).

This series fixes the regression by making tool PMU events
(duration_time, user_time, system_time) behave more like regular
counters by implementing proper enable and disable support. They now
correctly accumulate values only when enabled.

The first patch implements the core enable/disable support for tool PMU
events, and the second patch adds a shell test to verify that
duration_time correctly excludes the delay period.

Changes in v3:
- Refine group handling: only manually enable/disable group members when
  the leader or member is a non-perf-event open PMU, as the kernel allows
  grouping of software and hardware PMUs.
- Fix a file descriptor leak in evsel__tool_pmu_open() on error paths by
  explicitly closing the successfully opened fd before exiting.
- Synchronize the 'disabled' flag for all group members in enable/disable
  paths (both per-CPU and batch loops) to prevent stale disabled flags.
- Add explicit early exits to evsel__tool_pmu_enable() and disable() based
  on evsel->disabled to protect internal metric state.
- Add an upper bound check in test_stat_delay to verify that the delay was
  actually excluded.

Changes in v2:
- Implement evsel__tool_pmu_enable() and evsel__tool_pmu_disable() to
  avoid ioctl failures in batch evsel__enable() and evsel__disable()
  functions.
- Correctly iterate and enable/disable tool PMU events configured as
  non-leader members of event groups.
- Correct the lseek() arguments order in the read_stat helper:
  lseek(fd, 0, SEEK_SET) instead of lseek(fd, SEEK_SET, 0).
- Introduce INVALID_START_TIME (~0ULL) to prevent erroneous large delta
  accumulation in evsel__tool_pmu_read() if /proc/<pid>/stat fails to
  read in enable_cpu (e.g., process exited).
- Improve test parsing to use LC_ALL=C and cut to be robust against
  different locales, and use awk to dynamically compare duration_time to
  time elapsed with a 200ms tolerance (avoiding loaded CI false failures).
  Also added a lower-bound check.
- Fix style warnings from checkpatch.pl (line lengths, braces, and blank
  lines).

Ian Rogers (2):
  perf tool_pmu: Make tool PMU events respect enable/disable
  perf tests: Add test for stat delay option with duration_time

 tools/perf/tests/shell/stat.sh |  53 +++++++
 tools/perf/util/evlist.c       |  10 +-
 tools/perf/util/evsel.c        | 196 +++++++++++++++++++------
 tools/perf/util/evsel.h        |  15 +-
 tools/perf/util/tool_pmu.c     | 253 ++++++++++++++++++++++++++-------
 tools/perf/util/tool_pmu.h     |   4 +
 6 files changed, 432 insertions(+), 99 deletions(-)

-- 
2.54.0.631.ge1b05301d1-goog

