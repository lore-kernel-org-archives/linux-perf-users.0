Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DE36BCFB;
	Mon,  8 Jun 2026 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949881; cv=none; b=rdm91GndKBCBMTEK1ppNdc8A+aUeTg1U55vX367Vw8wdAzaVlMT2Kj94Am1AB1wOphSJUQWsRpQB+PF08c97yXBTUED/gOBEjHd+0WIrNm5ypQVGwKvmwSpabKQjGAuiNmdatG4nlhZNz1+X5xpEny2346sqUwPWPJZGnspSFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949881; c=relaxed/simple;
	bh=VyzGLONFxlf7PCQ6J+2A6EjFMbShzJpd175PyL9mrso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kMBLvPltY20ZshM5Igu+2Ev3fNFLO9E1nalLBmoZQUXEqNTcokAz+cHlPe+ThDK/8UJ0kqQo5Mt1EkLklig9R9sf7d7uQaTVLkW+BBCa3iBRhC/bwn9XVA7g9wtygikR6fph09w+LlwAi2sUCQBZwicu1tSRc+ZsDTwI5quSU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKP/vdmS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKP/vdmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788341F00898;
	Mon,  8 Jun 2026 20:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949880;
	bh=2Qg3lKBfuXvn3GB1zVMvmbx3PwctQEgRWxO0JtjLyGY=;
	h=From:To:Cc:Subject:Date;
	b=DKP/vdmSie3udXsCABdvVNER2t0OiQnOXUuwtxt9ZqjJlOuxgftBYlfE8k5+qnVf9
	 R8khOJACP9+3KsOlRwOcJjPMFlJB4mmyVcDztXWit5Vsi69USNMYX3y+gbuHVTcgLe
	 i+tdIN1+MO1wMe5SoQqCKGAIi61l+Nru12PavYr8+eHOQJYkdn+Q5jlSv2tGL8N1Oc
	 g9wE6PVUk4jRcZGn1cR3XWH5weox+I6HBm79iDcDR2165+Y4Mqlp8qP20ByJEE1GGl
	 yw+u0z2mJNkQEMaBZtAmvJEQF/0ugOOVA/RJB4BZAfSkoT1NRa8yS9HAehbZo9ZJVj
	 zgyveEXr9M9OQ==
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
Subject: [PATCHES v3 00/11] perf tools: Assorted fixes
Date: Mon,  8 Jun 2026 17:17:40 -0300
Message-ID: <20260608201753.1979464-1-acme@kernel.org>
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

Also expanded the libperf ABI TODO (tools/lib/perf/TODO) to emphasize
the code simplification argument for widening struct perf_cpu.cpu from
int16_t to int — the narrow type forces defensive truncation checks at
every boundary where wider CPU indices are narrowed.

Arnaldo Carvalho de Melo (10):
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

 tools/lib/perf/TODO          |  7 +++++++
 tools/perf/builtin-record.c  |  1 +
 tools/perf/builtin-sched.c   |  7 +++++--
 tools/perf/util/bpf-event.c  | 11 ++++++-----
 tools/perf/util/build-id.c   |  2 +-
 tools/perf/util/cpumap.c     | 24 +++++++++++++++---------
 tools/perf/util/dso.c        |  4 ++--
 tools/perf/util/event.c      | 11 +++++++++--
 tools/perf/util/hist.c       |  7 ++++---
 tools/perf/util/hwmon_pmu.c  | 12 ++++++------
 tools/perf/util/mmap.c       |  1 +
 tools/perf/util/symbol-elf.c | 20 ++++++++++----------
 12 files changed, 67 insertions(+), 40 deletions(-)

Changes since v2:
  - Dropped mbind patch (was v2 patch 4): the original code was
    correct — get_nodes() does --maxnode before computing
    BITS_TO_LONGS, so bitmap_zalloc(node_index + 1) with
    maxnode = node_index + 2 already match.  The commit message
    misstated the kernel-side semantics.
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
