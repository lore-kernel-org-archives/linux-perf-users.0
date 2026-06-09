Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291E2F1FF4;
	Tue,  9 Jun 2026 01:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967137; cv=none; b=PNB1Iy+ArB5X3m4YDeCIbxkb/SYyBC0J8/YFrMFztdUYzre7tjTbZ+uCu9mV8gzffKM8uZrc9L3of0u5Z/Vdw2OpWC44RPTrCIJv8+qS2G7pvw5EALgb2WKxzBxnxbNvv6dcLEDYEdZh0zYsdeknVGMuHo93pfD09FZGRHOjg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967137; c=relaxed/simple;
	bh=nEe+/5R9Rx/HXjmeD6GExb7CwH6cMi3TiZmgVfC/+0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AUzuORUOA0gDx52s7uV5L966vzOoI4w1FfSoD+BNbMDsgAmGEly5B4i6O4UnFZMKDPYoCKsrJDZKdSBb+MY2y3UiWSUx1AudtJkqkNmxJfCNhSrpya6WgkUoyPAE5IP7Fsr3eK8GJMMmDuueD1Q6+SMkmAW2HkDCZvDy+iEDUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJW0LuJ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJW0LuJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D681F00893;
	Tue,  9 Jun 2026 01:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780967133;
	bh=AT1bfK3jVU+OAi4QeQyF8IskjbqBQXbi2CdLnzep2+4=;
	h=From:To:Cc:Subject:Date;
	b=oJW0LuJ8AiE7ccptQubXI78O2039SOqurJHAIUn7U8NO7/vp+iBHshkJ/vqAklaGy
	 i7dQHTS0iqMn9XHcR/JdC0yLuc+/ajPhlLNtWehPAqt2hanJ4Hi+p8qhj0NqVph0ZX
	 aLqiyr/KGWVoVPYI3cRnvEvOulXQgxQm9BR9cRtv9cwvJMvmJYf0FHJDcaoC4DDewh
	 bU5FMaQk5jq1EHLvev/N+pCEYfY0y+c7VJSqpGcW1u3UbaHFVwC5b6sNuXlbXZ8sqO
	 Ticb8Le7ELADt5I+1pZE/x1j0DOoscFQMNmp2nLFvuqlRuloab7z4eEsAZby8GP1er
	 VzNDkOpZk3a/Q==
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
Subject: [PATCHES v4 00/11] perf tools: Assorted fixes
Date: Mon,  8 Jun 2026 22:05:14 -0300
Message-ID: <20260609010526.1998472-1-acme@kernel.org>
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
 tools/perf/util/build-id.c   |  4 ++--
 tools/perf/util/cpumap.c     | 24 +++++++++++++++---------
 tools/perf/util/dso.c        |  4 ++--
 tools/perf/util/event.c      | 15 +++++++++++++--
 tools/perf/util/hist.c       |  7 ++++---
 tools/perf/util/hwmon_pmu.c  | 12 ++++++------
 tools/perf/util/mmap.c       |  1 +
 tools/perf/util/symbol-elf.c | 20 ++++++++++----------
 12 files changed, 73 insertions(+), 41 deletions(-)

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
