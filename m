Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877F1F427C;
	Tue, 26 May 2026 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830299; cv=none; b=XU9MXcRp76VD8C0g979Q1gqP6f/KSO6K11ysOuYwjxPOiMdkifbkV1VDcHxMVh/9YL/7XCT7LkQpyv1pcWxRIfksKmNGtwAI4kflaTQLrabvCJG2ygwLs/7ypu5A5KWqHDXIawZHauTxtTTVb/gXcHiImlE8EbBdaH/NbUnwCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830299; c=relaxed/simple;
	bh=x1GH7+1uWoBSTfLLdsHB+fleHXFZSpik1V6o/dx71YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cwGMIEel2FeZ2DjokCXAM1JWy+pBk1kIE0MpsVt8aSiS9jnYZoOt9PSAhJOMOc0yhPHFS5nqodkI3i19MBuZu+K0OEVRXXAJcAfFEDwtvCj8uiu9vKPuRlAk8WrEhFxyr6hmw/MR/3wwGcD1tkfOHiPRSfAARNejfYSPhKvSEJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZDUFu+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZDUFu+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6571F00A3C;
	Tue, 26 May 2026 21:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830297;
	bh=fweuWgZhbQ8k3MAwae3dAhRX3rYNyPlqlYzdX3RJ9cI=;
	h=From:To:Cc:Subject:Date;
	b=ZZDUFu+q1PKj8eeHZyyUCtBWXMo6oTPBRXk+szXvaEDeEbey1bv/xMuY6+q3txyH3
	 7Agg58KZNRJ4GK8oSXQKy32k9DKfQQ70/2d+wIZuQsPGcfoinQ+FSHZg4LfC+8kXwE
	 ZtaRsE9oJSpG4SOKMGZwsTS/0Sv9OeUL6oz2oF0R+PZQ/whjFYZ2Kh9a56/G2RadsX
	 EHTD0HAdcjUFrzqSLuGR69XSdHKzr4+BDfyClnr0bfk7pjolOOaAmiyuO8PLuUIfYj
	 K7zpImkql6ClzaFh5ZZHA0gUIqiFsv9GdWbvnu3xN62d9LNxeOeamDyYh+sgHF6lQY
	 5WAuViqUiF0IQ==
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
Subject: [PATCHES v4 00/29] perf: Harden perf.data parsing against crafted/corrupted files
Date: Tue, 26 May 2026 18:17:36 -0300
Message-ID: <20260526211806.1193848-1-acme@kernel.org>
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

It is available at:

  https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-data-validation

  https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-data-validation

I think this is the last one, followup series will deal with the
pre-existing issues found while working on this series, its all in
several TODO files.

Best regards,

- Arnaldo

Changes in v4
-------------

- Patch 22: fix comment in process_mem_topology() — per-node fields
  are node_id + mem_size + bitmap_nr_bits, not version + bitmap_size.
- Patch 29: add mktemp failure guards (exit 2 = skip) so empty
  variables don't cause 'rm -f .old' in cleanup.  Use dd bs=$cut_at
  count=1 instead of bs=1 count=$cut_at to avoid one syscall per byte.

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

Changes in v2
-------------

- Patch 8: strnlen with 'end - data' limit instead of open-ended strlen
- Patch 10: ABI0 attr.size==0 handling for native-endian path
- Patch 13: READ_ONCE snapshot for mask32_data.nr, long_size validation
- Patch 17: attr_size bounds check for all PRINT_ATTRn macros

Arnaldo Carvalho de Melo (29):
  perf session: Add minimum event size and alignment validation
  perf session: Bounds-check one_mmap event pointer in peek_event
  perf tools: Fix event_contains() macro to verify full field extent
  perf zstd: Fix compression error path in zstd_compress_stream_to_records()
  perf zstd: Fix multi-iteration decompression and error handling
  perf session: Fix PERF_RECORD_READ swap and dump for variable-length events
  perf session: Fix swap_sample_id_all() crash on crafted events
  perf session: Add validated swap infrastructure with null-termination checks
  perf session: Use bounded copy for PERF_RECORD_TIME_CONV
  perf session: Validate HEADER_ATTR attr.size before swapping
  perf session: Validate nr fields against event size on both swap and common paths
  perf header: Byte-swap build ID event pid and bounds check section entries
  perf cpumap: Reject RANGE_CPUS with start_cpu > end_cpu
  perf auxtrace: Harden auxtrace_error event handling
  perf session: Add byte-swap and bounds check for PERF_RECORD_BPF_METADATA events
  perf header: Validate null-termination in PERF_RECORD_EVENT_UPDATE string fields
  perf tools: Bounds check perf_event_attr fields against attr.size before printing
  perf header: Propagate feature section processing errors
  perf header: Validate f_attr.ids section before use in perf_session__read_header()
  perf header: Validate feature section size and add read path bounds checking
  perf header: Sanity check HEADER_EVENT_DESC attr.size before swap
  perf header: Validate bitmap size before allocating in do_read_bitmap()
  perf session: Add byte-swap handler for PERF_RECORD_COMPRESSED2
  perf tools: Harden compressed event processing
  perf session: Check for decompression buffer size overflow
  perf session: Bound nr_cpus_avail and validate sample CPU
  perf kwork: Bounds check work->cpu before indexing cpus_runtime[]
  perf session: Snapshot event->header.size in process_user_event()
  perf test: Add truncated perf.data robustness test

 tools/lib/perf/include/perf/event.h           |    9 +-
 tools/perf/builtin-inject.c                   |   23 +-
 tools/perf/builtin-kwork.c                    |   45 +-
 tools/perf/builtin-record.c                   |    6 +-
 tools/perf/tests/parse-no-sample-id-all.c     |    6 +
 tools/perf/tests/shell/data_validation.sh     |   85 ++
 tools/perf/trace/beauty/perf_event_open.c     |   23 +-
 tools/perf/util/arm-spe.c                     |    2 +-
 tools/perf/util/auxtrace.c                    |   24 +-
 tools/perf/util/cpumap.c                      |   62 +-
 tools/perf/util/cs-etm.c                      |    2 +-
 tools/perf/util/header.c                      |  625 +++++++-
 tools/perf/util/jitdump.c                     |    2 +-
 tools/perf/util/kwork.h                       |    1 +
 tools/perf/util/perf_event_attr_fprintf.c     |  141 +-
 .../scripting-engines/trace-event-python.c    |   28 +-
 tools/perf/util/session.c                     | 1355 +++++++++++++++--
 tools/perf/util/session.h                     |    2 +
 tools/perf/util/synthetic-events.c            |   25 +-
 tools/perf/util/tool.c                        |   51 +-
 tools/perf/util/tsc.c                         |    2 +-
 tools/perf/util/zstd.c                        |   47 +-
 22 files changed, 2272 insertions(+), 294 deletions(-)
 create mode 100755 tools/perf/tests/shell/data_validation.sh

-- 
2.54.0

