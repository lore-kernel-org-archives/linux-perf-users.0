Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986B302753;
	Sun,  7 Jun 2026 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780874978; cv=none; b=C0378VvAGW++OCHwt+IzMZxQbTIUfShQhxtq9oKd/P/80BFI3u0HXnEF0SHRQ5DV5rE4FD/yVBS+eRlk00mi33fpY+FrJLPQtk8k06YMrxrUm4n0ioXgF4jLx2YxAunR45DIt2FDaQNXO4z3/IILphxr1Gk5Q5ZvjZO20JHJML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780874978; c=relaxed/simple;
	bh=9be0EDEKWL6dtix87jdEAZtyodk1xQnt7BhfVLYMTJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZC/rErrFSULyeKF9ntrSpWS2KxIHEJWgoDhLbgpjS6Ca+dVKU3X2jD5L3HBkDBWGTlc9AX+dSc4xVHW2CIYowPJDBP2Nf2LhOWQwxkqtPV9dIV93foKcb7pnrbc+y6qeF2bTxsJ+9yiQ96DIzn7zzZeJyN8OkjMhsZEaPxqsX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRDAKUdM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRDAKUdM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AC01F00893;
	Sun,  7 Jun 2026 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780874977;
	bh=MtoKIKs7l6FUCqlIEV3EX2H49Ud5P/C2nevoLQKZIv4=;
	h=From:To:Cc:Subject:Date;
	b=IRDAKUdMWOpfPmFV1kxSifN+cJ97ZBTE6RZFu+xcScCzhZHOZxkI6FnaJk7GfcFt9
	 9Ha/ujUimt2KiwRa8Y1919v04IK9FSOVU0nivVAb4S8Z268DDlm24hEV6/RPgYlSjl
	 yzz8MW5VQyoMRlHKIcabSJdKXcEKYp+Mqy05fwbjSSeFfSzyU0zBeGzZbtxwrlxM8j
	 aDHFEn345QjNHIHUeqA1+bQ4yYXYFxnYsOIqTl+VT/k9WmElajFsBNZM1hxzZxlo2d
	 brB1RtA0L/7ujX1wyEMDZ+b97GYd5a6Mrbly6vJyK5YETeEa6ulTubzYkDNzmLxxng
	 7tFR1/Z4SdFJA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCHES v1 00/11] perf tools: Assorted fixes
Date: Sun,  7 Jun 2026 20:29:13 -0300
Message-ID: <20260607232925.1935819-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Sixth batch of pre-existing bug fixes found by sashiko-bot AI review
during the perf-data-validation hardening series.  All bugs are latent
in existing code — none were introduced by the hardening patches.

Three broad categories:

1. snprintf() accumulation overflows (patches 2, 9, 10, 11):

   Several functions accumulate formatted output via ret += snprintf().
   snprintf() returns the would-have-been-written count, so on truncation
   ret overshoots the buffer size and the next 'size - ret' underflows
   to a huge unsigned value, disabling bounds checking.  Switched to
   scnprintf() which returns actual bytes written.

   Affected: cpu_map__snprint(), snprintf_hex(),
   synthesize_bpf_prog_name(), hists__scnprintf_title(),
   build_id__snprintf(), hwmon_pmu__describe_items().

2. Missing safety checks on untrusted data (patches 1, 3, 6, 7):

   - get_max_num(): size_t underflow on empty sysfs file causes heap
     over-read.
   - machine__resolve(): unguarded env->cpu[] access with untrusted
     CPU index — switched to perf_env__get_cpu_topology() accessor.
   - timehist: test_bit(prio, ...) without bounds check on untrusted
     tracepoint priority.
   - idle-hist: rb_first_cached() on a tree populated with plain
     rb_insert_color() — rb_leftmost never set, callchains silently
     dropped.

3. Resource hygiene (patches 4, 5, 8):

   - mbind() bitmap allocation one bit short of what kernel reads.
   - bitmap_free() without NULLing the pointer (3 call sites).
   - O_CLOEXEC missing from open() calls in DSO and ELF code
     (12 call sites across 2 files).

Also expanded the libperf ABI TODO (tools/lib/perf/TODO) to emphasize
the code simplification argument for widening struct perf_cpu.cpu from
int16_t to int — the narrow type forces defensive truncation checks at
every boundary where wider CPU indices are narrowed.

 tools/lib/perf/TODO          |  7 +++++++
 tools/perf/builtin-record.c  |  1 +
 tools/perf/builtin-sched.c   |  7 +++++--
 tools/perf/util/bpf-event.c  | 11 ++++++-----
 tools/perf/util/build-id.c   |  2 +-
 tools/perf/util/cpumap.c     | 24 +++++++++++++++---------
 tools/perf/util/dso.c        |  4 ++--
 tools/perf/util/event.c      |  9 +++++++--
 tools/perf/util/header.c     |  4 +++-
 tools/perf/util/hist.c       |  7 ++++---
 tools/perf/util/hwmon_pmu.c  | 12 ++++++------
 tools/perf/util/mmap.c       |  4 +++-
 tools/perf/util/symbol-elf.c | 20 ++++++++++----------
 13 files changed, 70 insertions(+), 42 deletions(-)

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks,

- Arnaldo


