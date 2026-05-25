Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0FA1FDE31;
	Mon, 25 May 2026 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671164; cv=none; b=u/zMipodHuY2BEtFgNeRg0bLglDsHxXdVu79oib6t1FwnQwIscEZDfWiONT8aA4PkFQ+CXofKqHMC75aBSOkFxa4wm4Plhp49JhkssNND8Eb6OyJAvk3WC1LRLdBfVCQMWhM/B1+yDqyDuspU3r4x8PDgjR7fLAN4QZvJen8l0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671164; c=relaxed/simple;
	bh=QGVXFP++Ax/ufme2d0VcqoyrLARDZfCNGLx0TgQpTVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gg7M3PFgR6G8GyB8DFgY8XNbU3zNl+POZFd3srJ75m5yaEwXnSUv8EPlBfTPihLARpJrlR+OVxf+NJBZdCEj8b++Rwtsi4zUK2rtMVGV4YT0kHk1qQk7EBipPds7nwhDvqQCYPEUvaACmed2LOGPlEKSYHp9mVLzPmpj1acw8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AffzA9gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AffzA9gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9978B1F00ADB;
	Mon, 25 May 2026 01:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671163;
	bh=6wiaEyt5TzVoHfS4XfjjsRs1QN80OV7WbyEYRBtd20U=;
	h=From:To:Cc:Subject:Date;
	b=AffzA9gboIAJvZpS6X/9b01DjGrJuNWEM9QlCTzezOfkaM7vjPFahsASMe2i+fbZN
	 zwxeGduSC4eZfo8fpizRoY9HofUfqIUWaBbMy9PZq3k5E98+6oIBk/okAiM2hVVCLs
	 OvYtzJpXoqIlY5obq1xVClQrnJWq655m1Pj6RQsKQ1QbC4VGDgmVCIMuJr5R3W2l/n
	 TebH+evK28WnVXvjQgV7wobjq5Cfs0R7z2ePIyUoRMrVVT1pXIFOck+yhXU0D6zlcZ
	 chu1HbFbaE1p1EmyWnLqLzJYLklgBuKimYskdAqh+Pymo5sOcV4S0TANbQ3yKCxsnz
	 Fc+Kg/ntpOfVQ==
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
Subject: [PATCHES v3 00/29] perf: Harden perf.data parsing against crafted/corrupted files
Date: Sun, 24 May 2026 22:05:20 -0300
Message-ID: <20260525010550.1100375-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

perf.data validation and hardening (29 patches)

A crafted or corrupted perf.data file can cause out-of-bounds
reads/writes, infinite loops, heap overflows, and segfaults in perf
report, perf script, perf inject, perf timechart, and perf kwork.
This series adds defense-in-depth validation for file parsing:

- Per-event-type minimum size table, enforced before swap and
  processing on both native and cross-endian paths.

- Bounds-checking the one_mmap fast path in peek_event against the
  mapped region size, preventing OOB reads from crafted file_offset.

- Swap handler return values (void -> int) so handlers can propagate
  errors instead of silently corrupting adjacent memory.

- Bounds checking for string fields (null-termination), array counts
  (nr vs payload size), feature section sizes (vs file size), and
  CPU indices (vs nr_cpus_avail / array allocation).

- ABI0 handling for perf_event_attr.size == 0 across all code paths
  (swap, native, synthesize, read_event_desc), with consistent
  behavior regardless of file endianness.

- READ_ONCE() snapshot of event->header.size in process_user_event()
  to prevent compiler rematerialization from MAP_SHARED memory.

- Sanitizer-aware shell test: the truncated perf.data test captures
  stderr and checks for ASAN/MSAN/TSAN/UBSAN markers, since sanitizer
  exits use code 1 which otherwise looks like a clean error exit.

Pre-existing bugs fixed along the way:

- event_contains() macro off-by-one (checked start, not full extent)

- zstd_decompress_stream multi-iteration output.pos bug
 
- zstd_compress_stream_to_records: broken memcpy fallback -> return -1
  + ZSTD context reset + dst_size underflow guard
 
- PERF_RECORD_SWITCH sample_id_all offset wrong for non-CPU_WIDE
 
- cpu_map__from_range any_cpu used as count instead of boolean
 
- cpu_map__from_mask double-fetch heap overflow (j >= weight guard)
 
- kwork cpus_runtime BUG_ON with signed comparison
 
- perf_header__getbuffer64 EOF without errno (silent success)
 
- read_event_desc ABI0 sentinel (attr.size=0 -> free_event_desc early stop)
 
- EVENT_UPDATE MASK: missing offsetof underflow guard + pr_warning on
  mask32/mask64 validation paths

Additional pre-existing issues were noticed during review and will be
addressed in follow-up series.

Testing
-------

- perf test at baseline and at patches 1, 8, 11, 17, 21, 26, 29
  with 300s timeout -- no regressions detected.
- Build with both gcc and clang at every patch.
- checkpatch.pl on all 29 patches.
- Full root perf test on x86_64 (x1, i7-1260P) and aarch64
  (Raspberry Pi 4, Cortex-A72, Debian trixie).

Developed with AI assistance (Claude/sashiko), tagged in commits.

Changes in v2
-------------

- Patch 8: strnlen with 'end - data' limit instead of open-ended strlen
- Patch 10: ABI0 attr.size==0 handling for native-endian path
- Patch 13: READ_ONCE snapshot for mask32_data.nr, long_size validation
- Patch 17: attr_size bounds check for all PRINT_ATTRn macros

Changes in v3
-------------

- Patch 10: fix perf_event__repipe_attr() in builtin-inject.c to
  handle ABI0 attr.size==0 — was using the raw size for memcpy and
  the perf_record_header_attr_id() macro, which both break when
  attr.size is 0.
- Patch 12: add sample_id_all handling to perf_event__build_id_swap()
  — perf_event__synthesize_build_id() appends id_sample data, so
  cross-endian pipe mode must swap those trailing fields.
- Patch 24: remove comp_mmap_len upper-bound cap that rejected valid
  perf record -m 2G recordings (mmap_len exceeds 2GB - 4096).  The
  downstream decompression path already checks against SIZE_MAX.

Cheers,

- Arnaldo
