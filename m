Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FBFDDC5;
	Sun, 10 May 2026 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384076; cv=none; b=H/Cys69mcBk3gyUHDlThsefbVhOQbactvKc+D6Q7ZxWDITwM1+ni7ihfsykXuQ+1ZCRQWt+0hLI8XEWl2S8i4nIfank5CL3IDFU6X8uUXdb7Z7FVnZ7M5VLllLcDNWVakHSE87Msk96O/FzNf66mzj3eXol/OvCjHBDby+Mz8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384076; c=relaxed/simple;
	bh=WFNp3pxU3RCNQoUh6GluexJyz6Qxfi/ONRuISnTTMP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pj8BJb4b0gLUFd6+SbDG7SZyGTwMRLDnR1XPM7Obme3xKypESzQwZGjcqYhDjk4EIR0o8bD8nV4fI/lP+D8wi2/R2t3WDfIjJhmgJy8dAXRVKY99Zs+2zRKshQhJRPefIhEz1kXqZhoekDCfduZM6ry/AdvOTcdAdWNoeD48QPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFyZhqXE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFyZhqXE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65769C2BCB8;
	Sun, 10 May 2026 03:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384076;
	bh=WFNp3pxU3RCNQoUh6GluexJyz6Qxfi/ONRuISnTTMP0=;
	h=From:To:Cc:Subject:Date:From;
	b=gFyZhqXErndNF4iHMyAB6MxMnGk4zGeFpWXTcof1xYI+kwJEYSbpfTRqXLcZD9unV
	 yXkR2fmTnn4/QLH/OSkjxrG5n4TFXJXeHWBydkaQ6iXGUlWgoa/U3A6ZI8a6dOioPT
	 Tm8HvpbXwR7vGZ17kpfsG/LMch7Ky2BSoB8pEFt8tnI0O4WFX1staI/iFvPhSCcIIW
	 yNXeTUHGV/LZFBOmTCpMXEXEQK9NZ6ZREenfbSXO1JE6yBbI+8iAf6X/Rr9jMZU8Jw
	 1pTLfSZOwPxr2MpFu/wnzWp23e0aVrapOK+LgiZidqOBbDuDPXOOI9rZNazrgnZ/nX
	 ecU+OawTxrFAA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 00/28] perf: Harden perf.data parsing against crafted/corrupted files
Date: Sun, 10 May 2026 00:33:51 -0300
Message-ID: <20260510033424.255812-1-acme@kernel.org>
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

	Here is a series experimenting with AI assistance, I did several
experiments that resulted in improvements to sashiko: a response cache,
support for IPv6, ways to better communicate agents, etc.

	Please take a look, I took more time than I expected to submit
this, and I'm not sure it is in the right shape, but at some point we
need to just submit to get things going.

- Arnaldo

AI-assisted development notice
==============================

This series was developed with AI assistance (Claude, tagged with
Assisted-by) and reviewed iteratively by sashiko, an AI code reviewer
(tagged with Reported-by for issues it found).  This is a first
attempt at using AI tools to help improve the perf tools from a
maintainer's perspective, and the workflow is still being refined.

The human (Arnaldo) read every diff, verified every fix, ran perf
test at multiple points in the series, and built with both gcc and
clang.  Every design decision, architectural choice, and commit
message was reviewed and approved by the maintainer.  The AI helped
with exploration, code generation, and iterative review analysis,
but the Signed-off-by represents the maintainer's judgment that
the code is correct and appropriate for upstream.

That said, this is new territory.  The series may have issues that
a more traditional development process would have caught differently,
or patterns that experienced reviewers find unusual.  Constructive
feedback on both the code and the process is welcome.

What this series does
=====================

Defense-in-depth validation for perf.data file parsing.  A crafted or
corrupted perf.data file can currently cause out-of-bounds reads/writes,
infinite loops, heap overflows, and segfaults in perf report, perf
script, perf inject, perf timechart, and perf kwork.

The series adds:

- A per-event-type minimum size table, enforced before swap and
  processing on both native and cross-endian paths.
- Swap handler return values (void → int) so handlers can propagate
  errors instead of silently corrupting adjacent memory.
- Bounds checking for string fields (null-termination), array counts
  (nr vs payload size), feature section sizes (vs file size), and
  CPU indices (vs nr_cpus_avail / array allocation).
- ABI0 handling for perf_event_attr.size == 0 across all code paths
  (swap, native, synthesize, read_event_desc), with consistent
  behavior regardless of file endianness.
- Backtrace ownership transfer in timechart (const char ** pattern)
  to fix a pre-existing memory leak.
- A shell test that truncates perf.data at various offsets and
  verifies perf report doesn't crash.

Design decisions reviewers may question
=======================================

1. Why not copy events to local buffers?

   Native-endian files are MAP_SHARED+PROT_READ.  Copying each event
   would eliminate TOCTOU but adds overhead for the common case.
   Instead, we validate once and accept the theoretical TOCTOU risk.
   A follow-up could switch to MAP_PRIVATE for both paths — zero
   overhead when no writes occur (COW is lazy).

2. Why warn+clamp instead of abort on invalid CPU?

   Synthesized events (MMAP, COMM) lack sample_id_all data, so
   evsel__parse_sample reads garbage from the event payload.
   Aborting would kill perf report on perfectly normal perf.data
   files.  Clamping to 0 protects downstream array indexing.
   The (u32)-1 sentinel is preserved for perf script and perf inject.

3. Why per-handler nr validation AND a central min_size table?

   The min_size table catches undersized events before the swap
   handler runs.  But variable-length events (namespaces, thread_map,
   cpu_map, stat_config) have array counts that must be validated
   against the payload — that's per-handler because each layout
   differs.

4. Why not validate on the native path by clamping in place?

   Native-endian events are on a read-only mmap.  Writing to them
   would SIGSEGV.  The swap path uses MAP_PRIVATE and can clamp in
   place.  The native path must skip or reject instead.

5. Why read attr.size into a local variable?

   The event may be on a shared mmap.  Re-reading could yield a
   different value if another process modifies the file.  Reading
   once eliminates this class of concern.

FIXME items left for follow-up
==============================

- perf.data should record the recording system's page size.
  Currently comp_mmap_len validation assumes 4K alignment.

- Block device input should be rejected or handled explicitly.
  All file-size validation is skipped for non-regular files.

- MAP_PRIVATE for both native and swap paths would eliminate
  ABI0 write-back workarounds and reduce TOCTOU surface.

Pre-existing bugs fixed opportunistically
==========================================

- event_contains() macro off-by-one (checked start, not full extent)
- zstd_decompress_stream multi-iteration output.pos bug
- zstd_compress_stream_to_records: broken memcpy fallback
- PERF_RECORD_SWITCH sample_id_all offset wrong for non-CPU_WIDE
- cpu_map__from_range any_cpu used as count instead of boolean
- cpu_map__from_mask double-fetch heap overflow
- kwork cpus_runtime BUG_ON with signed comparison
- perf_header__getbuffer64 EOF without errno
- timechart backtrace memory leak
- read_event_desc ABI0 sentinel corruption

Testing
=======

- perf test at baseline and at patches 1, 7, 10, 16, 20, 25, 27
  with 300s timeout — no regressions detected.
- Build with both gcc and clang at every patch.
- checkpatch.pl on all 28 patches.
- 34 sashiko review rounds, all genuine findings addressed.
- Patch 28 adds a truncated perf.data test that exercises the
  hardening code.

Arnaldo Carvalho de Melo (28):
  perf session: Add minimum event size validation table
  perf tools: Fix event_contains() macro to verify full field extent
  perf zstd: Fix compression error path in
    zstd_compress_stream_to_records()
  perf zstd: Fix multi-iteration decompression and error handling
  perf session: Fix PERF_RECORD_READ swap and dump for variable-length
    events
  perf session: Align auxtrace_info priv size before byte-swapping
  perf session: Add validated swap infrastructure with null-termination
    checks
  perf session: Use bounded copy for PERF_RECORD_TIME_CONV
  perf session: Validate HEADER_ATTR alignment and attr.size before
    swapping
  perf session: Validate nr fields against event size on both swap and
    common paths
  perf header: Byte-swap build ID event pid and bounds check section
    entries
  perf cpumap: Reject RANGE_CPUS with start_cpu > end_cpu
  perf auxtrace: Harden auxtrace_error event handling
  perf session: Add byte-swap and bounds check for
    PERF_RECORD_BPF_METADATA events
  perf header: Validate null-termination in PERF_RECORD_EVENT_UPDATE
    string fields
  perf tools: Bounds check perf_event_attr fields against attr.size
    before printing
  perf header: Propagate feature section processing errors
  perf header: Validate f_attr.ids section before use in
    perf_session__read_header()
  perf header: Validate feature section size and add read path bounds
    checking
  perf header: Sanity check HEADER_EVENT_DESC attr.size before swap
  perf header: Validate bitmap size before allocating in
    do_read_bitmap()
  perf session: Add byte-swap for PERF_RECORD_COMPRESSED2 events
  perf tools: Harden compressed event processing
  perf session: Check for decompression buffer size overflow
  perf session: Bound nr_cpus_avail and validate sample CPU
  perf timechart: Bounds check cpu_id and fix topology_map allocation
  perf kwork: Bounds check work->cpu before indexing cpus_runtime[]
  perf test: Add truncated perf.data robustness test

 tools/lib/perf/include/perf/event.h           |    4 +-
 tools/perf/builtin-kwork.c                    |   49 +-
 tools/perf/builtin-timechart.c                |  117 +-
 tools/perf/tests/parse-no-sample-id-all.c     |    6 +
 tools/perf/tests/shell/data_validation.sh     |   59 +
 tools/perf/trace/beauty/perf_event_open.c     |   19 +-
 tools/perf/util/arm-spe.c                     |    2 +-
 tools/perf/util/auxtrace.c                    |   24 +-
 tools/perf/util/cpumap.c                      |   22 +-
 tools/perf/util/cs-etm.c                      |    2 +-
 tools/perf/util/header.c                      |  601 ++++++++-
 tools/perf/util/jitdump.c                     |    2 +-
 tools/perf/util/kwork.h                       |    1 +
 tools/perf/util/perf_event_attr_fprintf.c     |  140 +-
 .../scripting-engines/trace-event-python.c    |   28 +-
 tools/perf/util/session.c                     | 1154 +++++++++++++++--
 tools/perf/util/svghelper.c                   |    6 +-
 tools/perf/util/synthetic-events.c            |   25 +-
 tools/perf/util/tool.c                        |   51 +-
 tools/perf/util/tsc.c                         |    2 +-
 tools/perf/util/zstd.c                        |   35 +-
 21 files changed, 2088 insertions(+), 261 deletions(-)
 create mode 100755 tools/perf/tests/shell/data_validation.sh

-- 
2.54.0

