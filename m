Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3B3749FE;
	Wed, 10 Jun 2026 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121128; cv=none; b=gCzWhsNNpzT3PZP30zVjT6t2D9t+v9hjwyqp1OwXfiA8WVp8PTwuoTmIaIWrxav1adCI5BBmKBexQmGAA389ZnXHBSz9qqbH8EnonOw9s5pNeTZoQUEaBt1dh/N2Q1ltaFDCCn1YLwoTEGZN49nwaVW+eK6SKcdZ4uDSHqtMzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121128; c=relaxed/simple;
	bh=frOOi5lMjwYRm40pxzE3FqdwTcV9xR6HGxtS6tSk5VY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cndoVj/DrZcvzBeH7NjQMt3DwJ3EjH+/kR1NC4LB7SJwVckD7ShYLJEA6I2GFvgZmdRjBoXZSwGQgkKEg7fV4s1jff0uwJLCh9ocrSnX4LvD5+T9HbQPBblwgxuQOIcxbpxfnpZLFK8yVdCrkRVi1Tr5aEd73BjXEj4iOJCycQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMN6T1BT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMN6T1BT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692FF1F00893;
	Wed, 10 Jun 2026 19:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121126;
	bh=AeRpk0CvEc9etrlSwhQeI4grgXMi8nlFV1azqmU+6To=;
	h=From:To:Cc:Subject:Date;
	b=BMN6T1BTlNX/JzZ0FYcaxkvtV5M4itqif9L+Lv3T1h9ZuY5+pip8e40IcM3M+s/A3
	 eGFXwlEOT5rR1ZVVxlBWU/CHfpvx//Cpp2paCZOruXeMq27kiDPOZWd6VY5Ln6Az4g
	 QDVq41459/mYRGR0rClDeGzIjBKn1atwLMwsbktqdApwsu6KKI6Y68y5o10dHmamji
	 tDTZ65fBf8ZNUmSGYq71jSGBjsjpXQvlaJW05MYdvGgZvO/stuZV014r+fFCf5FJ88
	 NEy9j/LiShNRNKWJ6a8msW9kY+3ASunubwWjn3l9rWtYUK22vgLqbcdid1Wv8ErJc9
	 V+60YeNfYTyxg==
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
Subject: [PATCHES v1 00/23] perf tools: Fix OOB accesses, leaks, and missing bounds checks across pmu/symbols/bpf/hwmon
Date: Wed, 10 Jun 2026 16:51:33 -0300
Message-ID: <20260610195157.2091137-1-acme@kernel.org>
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

Twenty-three more pre-existing bugs found by sashiko-bot during
AI-assisted review of the perf-data-validation hardening series.
All are independent of that series -- they are latent bugs in
surrounding code exposed during review.

The fixes fall into several recurring patterns:

Empty/short sysfs file reads (patches 1, 2, 3, 8, 9, 14, 17):
  Multiple functions that read sysfs files assume a non-empty result.
  When the file is empty or the read returns zero bytes,
  str[len - 1] = '\0' underwrites the heap (pmu_id), scale[-1]
  accesses out of bounds (parse_scale), atoi/strtoull read
  uninitialized stack bytes (filename__read_int/ull), and
  thread__set_comm_from_proc passes an unterminated heap buffer
  to strlen() via thread__set_comm().

snprintf accumulation bugs (patches 7, 10, 15):
  snprintf returns the would-have-written count on truncation.
  Code that accumulates into a fixed buffer using snprintf return
  values overshoots the buffer size, causing size_t underflow on
  subsequent sizeof(buf) - buf_used calculations.  Switch to
  scnprintf which returns actual bytes written.

ELF/build-id parsing (patches 4, 5, 12, 22, 23):
  sysfs__read_build_id() has signed integer overflow when summing
  namesz + descsz.  filename__read_debuglink() copies section data
  without checking d_size.  The GNU build-id fallback path lacks
  descsz validation.  elf_read_build_id() iterates note sections
  without bounds-checking the note header or name/desc sizes against
  the section data buffer.  The no-libelf build path (symbol-minimal.c)
  has the same note iteration vulnerability.

fd leak prevention (patch 6):
  mkstemp() creates file descriptors without O_CLOEXEC, leaking
  them to child processes.  Replace with mkostemp(., O_CLOEXEC).

Uninitialized pathname on uncompressed fallback (patch 13):
  filename__decompress() left pathname uninitialized when the file
  was not compressed, causing four callers to treat stale stack
  contents as a temp file path and potentially unlink real files.

Buffer overflows (patches 11, 16, 18):
  parse_hwmon_filename() passes sizeof(buf) + 1 to strlcpy.
  dso__read_running_kernel_build_id() uses sprintf without bounds.
  mount_overload() passes name_len instead of sizeof(upper_name)
  to snprintf, and mem_toupper scans past the actual string.

BPF metadata bugs (patches 19, 20, 21):
  synthesize_bpf_prog_name() dereferences btf__type_by_id() without
  NULL check.  bpf_metadata_create() leaks partially built map data
  on allocation failure.  perf_env__add_bpf_info() leaks metadata
  when inserting a duplicate info node.

Most require unusual sysfs contents, crafted ELF files, or specific
allocation failure timing to trigger.  Verified with gcc and clang
builds, checkpatch, and perf test.

Arnaldo Carvalho de Melo (23):
  perf pmu: Fix pmu_id() heap underwrite on empty identifier file
  perf pmu: Fix perf_pmu__parse_scale/unit() OOB access on empty sysfs file
  tools lib api: Fix missing null termination in filename__read_int/ull()
  perf symbols: Fix signed overflow in sysfs__read_build_id() size check
  perf symbols: Bounds-check .gnu_debuglink section data
  perf tools: Use mkostemp() for O_CLOEXEC on temporary files
  perf intel-pt: Fix snprintf size tracking bug in insn decoder
  perf tools: Fix thread__set_comm_from_proc() on empty comm file
  perf hwmon: Fix off-by-one null termination on sysfs reads
  perf hwmon: Use scnprintf() in hwmon_pmu__for_each_event()
  perf hwmon: Fix parse_hwmon_filename() strlcpy buffer overflow
  perf symbols: Bounds-check descsz in sysfs__read_build_id() GNU fallback
  perf tools: Fix uninitialized pathname on uncompressed fallback in filename__decompress()
  perf hwmon: Guard label read against empty or failed reads
  perf pmu: Use scnprintf() in format_alias()
  perf tools: Use snprintf() in dso__read_running_kernel_build_id()
  tools lib api: Fix filename__write_int() writing uninitialized stack data
  tools lib api: Fix mount_overload() snprintf truncation and toupper range
  perf bpf: Add NULL check for btf__type_by_id() in synthesize_bpf_prog_name()
  perf bpf: Fix map data leak in bpf_metadata_create() on alloc failure
  perf bpf: Fix metadata leak in perf_env__add_bpf_info() on duplicate insert
  perf symbols: Add bounds checks to elf_read_build_id() note iteration
  perf symbols: Add bounds checks to read_build_id() note iteration in minimal build

 tools/lib/api/fs/fs.c                              | 19 ++++---
 tools/perf/tests/code-reading.c                    |  7 ++-
 tools/perf/util/bpf-event.c                        |  8 ++-
 tools/perf/util/disasm.c                           |  7 ++-
 tools/perf/util/dso.c                              | 16 ++++--
 tools/perf/util/hwmon_pmu.c                        | 22 ++++----
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  | 11 ++--
 tools/perf/util/pmu.c                              | 14 ++++--
 tools/perf/util/symbol-elf.c                       | 58 +++++++++++++++++-----
 tools/perf/util/symbol-minimal.c                   | 11 +++-
 tools/perf/util/thread.c                           |  5 ++
 11 files changed, 126 insertions(+), 52 deletions(-)

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks,

- Arnaldo
