Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021B338595
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135271; cv=none; b=Vk4H2gxsoAVJs8yCrG7Rm/Sk6nignvV9wnfSoiQVaE5xWbEoYG+g9qojWl6PJScHaw8QGaKsYgXyEle0owSBz4SSgOkT5zeRH7bjUuvNwsTV2pefRLGjdqXwvKq/bJocnjswHSZMOVBMFCbJ7yvb++CS0E3FNVVj8XvV/svqIXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135271; c=relaxed/simple;
	bh=0Y48nsZ/Ae9X++t9ZXNur/WZfEYDe/xxdJzZmQCuB/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iZFUj1UlD8jjUlDGNNc0tzyTLt8EH0/zLHvhP8UvW2MRmIWUklmE3t/dFHsX+IPupQjoJogcoMkheEcbbMotb7c/3GI5gTDn0fG3fRVFXaFY9scRceZhzxjNieh7eFpDoCeYy3gsSrjM/U0icv1ONhAheYMwuxBjEW0/7P896A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VOU8rx0p; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VOU8rx0p"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8279604464so4215417a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 13:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779135270; x=1779740070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jIvDa6R2A7wsys4eYRpNSxeCX+FUGyPjK07HiyyCJek=;
        b=VOU8rx0p1W2UchTS9c5/kap4WnxjKbOfNNy2U6vy8d/hpuzSFr2XGnA1TuGqvp/VLE
         ihDxKZeCsUab2wMesJFUWVAAGLflYqcYi528EfyDoVFcYg3Ncr3vGaB0zErNZXIIZoUM
         i9tdVD5UMHYCpkiZKAxgs079caOX+A3bh+saDw4/canCaWawIRuqAYYMMWoMDA5PaFJ9
         1z5nHHCO1Pb5VwIwDKqEOVyIred/fbaWm2qao26yGVq414WD9z47JEfnlYMkUkKdOG5x
         5zMUwJbbNBtzmhhjtx1cZZAUkpAyjTuJH0Q4R5ov31OdKP5P7YERROulbNJ+lXYrnzWD
         cMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135270; x=1779740070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIvDa6R2A7wsys4eYRpNSxeCX+FUGyPjK07HiyyCJek=;
        b=PdiCbEJ4MuxIsGvgwMWpsY0uaS8rXaLAtvgEDOEvZLyaT3SIpRPhp1l/e0FvN3Uu/k
         RxQnKguBVKdz699N2loOH42RIvcB35K2OksMacfzEW2+tThl2a3Cnv8g17+DnT3W/+c3
         2elr8EPUy82bfrG/5pKsGUZgc+y+mkXbZdirU9gp+SSSXK0u73YUh1CvFuAXJyAWZcuD
         LgB2dJfWXshgngvxMbOVubAQ8t60CvQcEcBke4mL75/0rkeTCjtZnibcZWPUWjdctaCt
         GqkA4cRl59LiRcjSTCfTYp8O+0sZ2kZTNWjAZFxL6F1TyMYNHz5U+7mjuAtGY4cLcX5w
         Gy5Q==
X-Forwarded-Encrypted: i=1; AFNElJ8JNNLcVXlTc3VqQ1uVxH2aeaAksisTzA8vrQ2cyWXuziUy7ISrmXG/nVkZULLkbCXD/6SoRfOPQzjX5oplbbK4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu3NdbP04P6I0pi/Tko4gGLkNG3BpxDNSqfWChpIfxo1Jop2wQ
	nQHpbSoRrq8BVn5D0JRqTZ5XtPN92J5KFQfhWB7vRAqVnHIXOc03y+xVDjAFg6CpnxsvR3cO6Yk
	ig8jB5g40Xw==
X-Received: from pgbdo6.prod.google.com ([2002:a05:6a02:e86:b0:c76:669e:8145])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a120:b0:3a1:d516:36f0
 with SMTP id adf61e73a8af0-3b22ec3f5afmr17593031637.36.1779135269832; Mon, 18
 May 2026 13:14:29 -0700 (PDT)
Date: Mon, 18 May 2026 13:14:12 -0700
In-Reply-To: <20260518183920.2894502-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518183920.2894502-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518201419.2943132-1-irogers@google.com>
Subject: [PATCH v2 0/2] perf tool_pmu: Support enable/disable for tool PMU events
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

Ian Rogers (2):
  perf tool_pmu: Make tool PMU events respect enable/disable
  perf tests: Add test for stat delay option with duration_time

 tools/perf/tests/shell/stat.sh |  48 +++++++
 tools/perf/util/evsel.c        | 190 +++++++++++++++++++------
 tools/perf/util/evsel.h        |  10 +-
 tools/perf/util/tool_pmu.c     | 244 ++++++++++++++++++++++++++-------
 tools/perf/util/tool_pmu.h     |   4 +
 5 files changed, 399 insertions(+), 97 deletions(-)

-- 
2.54.0.631.ge1b05301d1-goog

