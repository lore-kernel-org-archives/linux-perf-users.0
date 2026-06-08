Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0231F2BAD;
	Mon,  8 Jun 2026 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882270; cv=none; b=jQKA9481oodVl5RFZR/np/X+maC9Hp5rn7ZHNVpHOuWSp871gcN7mC989dqOyRGdaGeRcDFHHocI5/WnLQfNsDU84VaURFojPVADUC6yBKbO0g+6DlzV7cXr0isRL5LNUqUhDmBx1vYNYiYod3GGF4jl4mSjMy5zRNkVwEUGR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882270; c=relaxed/simple;
	bh=9yHckdodkz8Z1QRaOGdiVK+5ipKyXQZhH8UnpCbgyH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VhlGZjNkqcnpIUes95fqF8Je9L5RpJ8m+DS/eXRVSDBJ+B5S546tmGBVYAzfhDDu+iZybqU2PVZhIJBxzfrxoUNDuyOU0J1C/Zat3GI0gfY3+Vw4K8qsFNhPzHK3kl6cgD8G8G+0jHoPsCH97TK+whplEkgX4o1xAOaykzT+N1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMYf63fP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMYf63fP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12131F00893;
	Mon,  8 Jun 2026 01:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882269;
	bh=vU8lRGqWv83ZvKEDgBzwUEbEnqrm58Ed6Ew/eA84gPY=;
	h=From:To:Cc:Subject:Date;
	b=HMYf63fPQ70vIV4inIh4G7sGsnwm29SW+W78HdSIy7pquXhd2BAc81U3hOq5s8czE
	 KFc8TVR/yuuXkJdaDHZvKhKxIA+HlaEYrEAPhlZGWXC8s5dRDXk4gmuL9UNCkqy69t
	 ef0ZuSZ+LYv7wP4ci9Z8PmF6QD5mp72lmoa36Q3fWimHLCeVOSyspPmL3QtnN+5V0P
	 bIWzLG0Ub+xMxlWmFNpPn/p1f9/x+hLP7VcErdsyTT0EDcItzJwGEFvka5gI+dLHOx
	 6w1qhJqKaNmIza4CBCyaHVyTMbr4h7abRjdpgYheC8eEgcmAAY5EWCZ2uQAcZBYWbi
	 EUzjJp7B6ZYew==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES v2 00/11] perf tools: Assorted fixes
Date: Sun,  7 Jun 2026 22:30:44 -0300
Message-ID: <20260608013057.1942953-1-acme@kernel.org>
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

Changes since v1:
  - Patch 6: fix prio bounds-check logic — the v1 condition
    (prio < 0 || prio >= MAX_PRIO || !test_bit(...)) incorrectly
    skipped events with unknown priority (prio == -1).  Changed to
    (prio >= 0 && (prio >= MAX_PRIO || !test_bit(...))) to preserve
    the original pass-through for events without priority info.
    (Found by sashiko-bot lore review)


Thanks,

- Arnaldo
