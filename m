Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E842BE7AC;
	Wed, 10 Jun 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110336; cv=none; b=RjJBLfizW5TGJPLZelpWOo+7m3kr5ZYtb8SI3ighpJTcCX6giOdRCRGew5NBFLHospyK6Jbb1EwIs6Zbp8R2Vd8HxDLujIO0E7xG61BH3t07HBHRebcnEAFVrkSqnM9u6H5i3bRbEJT2q/wbg5AV5qYJHhyiCK/RfyxtBw4Fx64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110336; c=relaxed/simple;
	bh=tH+AbyE7ilbJ/HwnoYOtnQn5mI1xlUPG7g88kkDPKzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bLzg+ga3WS17/h5pwLufNgXMApE+6blzjqehXo8ksj6ugc/5Ik+rKbiovapvRr6W+K9znQXiPyBaLTjy1m9homyNicKrYvPtAs5jV0qWxCO+YFQq7mS0bdFL7PepVyiW/xSm1t7H3I+0w4vV0z02tyM/9SAQTQ3BJxeA5OxlkkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzTIkTBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzTIkTBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44991F00893;
	Wed, 10 Jun 2026 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110334;
	bh=KzOKiOWKqTJpez6hfwzf9+0eYervIj7L8QyddjPBvNw=;
	h=From:To:Cc:Subject:Date;
	b=MzTIkTBU7UzXneoN87eRJ4wHt1IXKonDkWDG9c2QTWdQVrRHmPGbqyam+dyO+solN
	 Oi+epMaKB0v6L/LcHFefv8i+rFwTyOq98dQO/6kyrERgR23XJ5KL9Bg/QA7lGIBXBw
	 XtupTe1L6ggFUppCmbahBjg74W/A47sEdOh47ZK8/jb/PoGeb6FY35by0tlLDRpsGJ
	 iGX86PLAwYWHXVN12QRuHafAgfGwYSLTTsBiy+JsXH6JxmbVZ53owDm9fQftF/VE+c
	 DCbFxEoDVxwiiQDpgiBuxi/L47wDHyi1uITBbE8kR3akHh1pN22gOyq61p1veMMm9W
	 qnx7T+Arnx06Q==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCHES v5 00/11] perf tools: Assorted fixes
Date: Wed, 10 Jun 2026 13:51:54 -0300
Message-ID: <20260610165207.2077258-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

Sixth batch of pre-existing bug fixes found by sashiko-bot AI review
during the perf-data-validation hardening series.  All bugs are latent
in existing code — none were introduced by the hardening patches.

Three broad categories:

1. snprintf() accumulation overflows (patches 2, 8, 9, 10):

   Several functions accumulate formatted output via ret += snprintf().
   snprintf() returns the would-have-been-written count, so on truncation
   ret overshoots the buffer size and the next 'size - ret' underflows
   to a huge unsigned value, disabling bounds checking.  Switched to
   scnprintf() which returns actual bytes written.

   Affected: cpu_map__snprint(), snprintf_hex(),
   synthesize_bpf_prog_name(), hists__scnprintf_title(),
   build_id__snprintf(), hwmon_pmu__describe_items().

2. Missing safety checks on untrusted data (patches 1, 3, 5, 6):

   - get_max_num(): size_t underflow on empty sysfs file causes heap
     over-read.
   - machine__resolve(): unguarded env->cpu[] access with untrusted
     CPU index — switched to perf_env__get_cpu_topology() accessor,
     added bounds check before int16_t truncation.
   - timehist: test_bit(prio, ...) without bounds check on untrusted
     tracepoint priority.
   - idle-hist: rb_first_cached() on a tree populated with plain
     rb_insert_color() — rb_leftmost never set, callchains silently
     dropped.

3. Resource hygiene (patches 4, 7):

   - bitmap_free() without NULLing the pointer (2 call sites).
   - O_CLOEXEC missing from open() calls in DSO and ELF code
     (12 call sites across 2 files).

Patch 11 expands the libperf ABI TODO with the code simplification
argument for widening struct perf_cpu.cpu — the int16_t forces
truncation checks at every boundary where wider CPU indices are
narrowed.

Arnaldo Carvalho de Melo (11):
  perf tools: Fix get_max_num() size_t underflow on empty sysfs file
  perf tools: Use scnprintf() in cpu_map__snprint() to prevent overflow
  perf tools: Use perf_env__get_cpu_topology() in machine__resolve()
  perf tools: NULL bitmap pointers after bitmap_free()
  perf sched: Bounds-check prio before test_bit() in timehist
  perf sched: Fix idle-hist callchain display using wrong rb_first variant
  perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code
  perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()
  perf hists: Fix snprintf() in hists__scnprintf_title() UID filter path
  perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()
  libperf: Document code simplification case for widening struct perf_cpu

 tools/lib/perf/TODO          |  8 ++++++++
 tools/perf/builtin-record.c  |  1 +
 tools/perf/builtin-sched.c   |  7 +++++--
 tools/perf/util/bpf-event.c  | 11 ++++++-----
 tools/perf/util/build-id.c   |  7 +++++--
 tools/perf/util/cpumap.c     | 24 +++++++++++++++---------
 tools/perf/util/dso.c        |  4 ++--
 tools/perf/util/event.c      | 15 +++++++++++++--
 tools/perf/util/hist.c       |  7 ++++---
 tools/perf/util/hwmon_pmu.c  | 12 ++++++------
 tools/perf/util/mmap.c       |  2 ++
 tools/perf/util/symbol-elf.c | 20 ++++++++++----------
 12 files changed, 77 insertions(+), 41 deletions(-)

Changes since v4:
  - Patch 4 (bitmap_free): also reset nbits to 0 in mmap__munmap()
    — without this, a reused struct mmap retains the old positive
    nbits while bits is NULL, and bitmap_scnprintf() dereferences
    the NULL pointer when perf runs with -vv.
    (Found by sashiko-bot lore review)
  - Patch 10 (build_id__snprintf): null-terminate bf before the loop
    — when bf_size == 1, the offs + 1 < bf_size guard skips the loop
    entirely, leaving bf[0] uninitialized.
    (Found by sashiko-bot lore review)
  - Collected Reviewed-by tags from Ian Rogers' v3 reviews
    (patches 1, 2, 4, 5, 7, 8, 9).
  - Reordered Reviewed-by tags before Cc lines in commit trailers.

Changes since v3:
  - Patch 3 (machine__resolve): expanded comment explaining why the
    outer al->cpu < nr_cpus_avail check is needed — the int16_t cast
    to struct perf_cpu silently truncates e.g. 65536 to 0, bypassing
    the accessor's internal bounds check.
    (Ian Rogers review)
  - Patch 10 (build_id__snprintf): fixed loop termination — after
    switching to scnprintf(), offs never reaches bf_size, so the
    loop spun doing zero-byte writes.  Changed condition to
    offs + 1 < bf_size.
    (Found by sashiko-bot, confirmed by Ian Rogers)
  - Patch 11 (TODO wording): fixed "wrap to small positive numbers"
    to "wrap to negative numbers (two's complement)".
    (Found by sashiko-bot, confirmed by Ian Rogers)

Changes since v2:
  - Dropped mbind patch (was v2 patch 4): the original code was
    correct — get_nodes() does --maxnode before computing
    BITS_TO_LONGS, so bitmap_zalloc(node_index + 1) with
    maxnode = node_index + 2 already match.  The commit message
    misstated the kernel-side semantics.
  - Split libperf ABI TODO hunk out of prio patch into standalone
    patch 11.
  - Patch 3 (machine__resolve): bounds-check al->cpu against
    env->nr_cpus_avail before truncating to int16_t struct perf_cpu.
    (Found by sashiko-bot lore review)
  - Patch 4 (was v2 patch 5, bitmap_free): reworded from "Three
    call sites" to "Two call sites" — removed dead store from
    memory_node__delete_nodes() where NULLing a pointer right
    before freeing the containing struct was useless.
    (Found by sashiko-bot lore review)

Changes since v1:
  - Patch 5 (was v1 patch 6): fix prio bounds-check logic — the
    v1 condition (prio < 0 || prio >= MAX_PRIO || !test_bit(...))
    incorrectly skipped events with unknown priority (prio == -1).
    Changed to (prio >= 0 && (prio >= MAX_PRIO || !test_bit(...)))
    to preserve the original pass-through for events without
    priority info.
    (Found by sashiko-bot lore review)

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks,

- Arnaldo
