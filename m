Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF11E260C
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154893; cv=none; b=TO8eS5FSTfQCDWHf3E2hH2IYYUWWLecqW+t2ujgWBJvNtKPQga/XbsLmSqdrT7Na8IyzZSxfxixHwmvKO9854l9Slc5MWkY9y01fMBcM64kz8uBCpqI2ZBYtqgqCjyo/5P9s60cO/iat7LoL+TQ8trxotpAdpVHnU6qNclF50GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154893; c=relaxed/simple;
	bh=6y+6BoieF8jdX2EKpR5KBqIE77dEBMo24XqSAA88/2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FobFDK4GrMiwHNUGWdvPWYR0A/KSG7yzVlrVYORf7raJ750nVey8KuX8Rj7T4ysijDu3R9aUVlElDk8y4ib/DIsKJu2RX+B9zPdtDn98aFEMcrKpCQRK5GlOJBeNqRKaM6fF/1Io5v6ofs5LFYFTxuBJQJyo5hAoYnCmmuwg7Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+3GXibh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+3GXibh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36781927b4dso1798781a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779154892; x=1779759692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xarshINCVZO5Z3cnn55LXhYuhNCXd111rOYgmE9Mn8=;
        b=J+3GXibhqRgObv6F8iNV3Jt/2J6CczlScaOnlzFdqCRmz87r2gyHzZVQ2JVU8w459V
         ta3bl5brkyIEbDiWCV1yvfp3wmQlB0OoGlx1bMng4j3jV+3HMFvVUgz26hl5n2e3GPP7
         hiKobQJE4JydoUhc3oDCfN16tHqhv88TCF5/ege9g8xfPTndxlNA6xUYOpSWfvQLzHJr
         tK3Sxzra3nOEGZKJOEUSFDJSk6iNIbE5gVPNZcTWUJqmLI6PhMFIxaU4TIbDKl0eI/DP
         vh794GlCRegVOQIZPDeFy6K7uB3urEuC81SpOjUevUqHyT0Kxg8LMznZfa7gv7/GwhRn
         oB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154892; x=1779759692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xarshINCVZO5Z3cnn55LXhYuhNCXd111rOYgmE9Mn8=;
        b=M4Lzqa9OmQY6P5YhEnpSJowxZ+6FGEZ0vh8o6TPnIV8ZmiNKx1QokZAEcFtODfyn4n
         EGUVZR9pBugL+PSKVHcXgsBZxpsejiUvCxMiMXmcqG7nyNxa+Z4uXceUhIAJFEKbvhzK
         BACJbUgVV51jp1C4Nwsi7wDp9/m7Z72qqDwU6SsXnSNI00eeBs6dk3QUQ7lyFRW3bNWN
         y8quIMx9SOqMJxMnEotCbWzQcNeQshJsmobQBwVzZrDCIwqjPpgFUlumKawMRPn5k44r
         t0PXAz5LwWwS9EKYr7G3uAxQj8q7v/MKAYaFGEjTMZtX1Qlcpjv1ZOq0HCs5Kem0tRgJ
         3ZaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Pcg3MPB+m/sEE39FjJvkHIr61UgFX4URo+sebekhVqiMRfLRgISaqrwTbqY6osY6XMavlv1MLpiOczn5KjO88@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DLpmVnQkdxn7PNUSyRJpc6x1KH8L77VDHQnkHRz2cwMv01OJ
	CTZhW5NoOmHThWDRuhNp4DpCOXpD/b/HnRqQd400K9K6FXCYVGokXQ2Dy6Js0B/QTpfXmVisRrd
	XBu1iX7dxjQ==
X-Received: from pgk14.prod.google.com ([2002:a63:a0e:0:b0:c6d:c043:2cb4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a9:b0:39c:126c:93b5
 with SMTP id adf61e73a8af0-3b22e7df668mr21169075637.21.1779154891640; Mon, 18
 May 2026 18:41:31 -0700 (PDT)
Date: Mon, 18 May 2026 18:41:04 -0700
In-Reply-To: <20260518223733.3034897-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518223733.3034897-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519014106.3089452-1-irogers@google.com>
Subject: [PATCH v4 0/2] perf tool_pmu: Support enable/disable for tool PMU events
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

Changes in v4:
- Update evsel->disabled immediately after the leader's own enable/disable
  succeeds in evsel__enable() / evsel__disable(), preventing state
  inconsistency on early return if a member fails.
- Remove evsel->disabled state changes from within the CPU loops in
  evsel__tool_pmu_enable_cpu() and evsel__tool_pmu_disable_cpu() to
  prevent __evlist__disable() from skipping disable_cpu calls for other
  CPUs.
- Make *start_time = INVALID_START_TIME unconditional in
  evsel__tool_pmu_disable_cpu() to ensure safe inactive state invalidation.
- Address a checkpatch warning regarding unnecessary braces for a single
  statement if block.

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
 tools/perf/util/evsel.c        | 197 ++++++++++++++++++++------
 tools/perf/util/evsel.h        |  15 +-
 tools/perf/util/tool_pmu.c     | 250 ++++++++++++++++++++++++++-------
 tools/perf/util/tool_pmu.h     |   4 +
 6 files changed, 430 insertions(+), 99 deletions(-)

-- 
2.54.0.631.ge1b05301d1-goog

