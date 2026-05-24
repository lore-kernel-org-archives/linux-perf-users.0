Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352923ED6A;
	Sun, 24 May 2026 03:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593247; cv=none; b=WZEk4n0JFBOAClGmKZJzGlmXcieKegnaI4jUf4jrCreuWK8GXtcTEWMS2atF2cvc3OkF64xDAiaNtEGWC2bBorNbyyRFmk0xTFkOgMnx98nHdDk8a3rpy0QA0rGY1M495IRzChb4NA0F97S/mJQt1/23hdkkGei8C7nspqSo/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593247; c=relaxed/simple;
	bh=z7ETmyiT/FWhTm0HJs9HersiNJZQe53BOoGb+4scy44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fT2JDOy24nNv4hRKL/bFDbc4WmF8n8ZpE7xN+O0GSWnszQGRCJmaUcNJsOLOrQPNvMIJGsKheObkeQ/ge1jmFwPeM4ChD6MxlRug6vt7ywXjI8jRjTK+hvcjpkoExDXRRtMmNu74nrqCF8PIFqVNho35XjeJYHazsAO8iuafwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv/LBHBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv/LBHBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D701F000E9;
	Sun, 24 May 2026 03:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593246;
	bh=EK0r3YNMRgnfhP72jdeR9LfTmtG+4qY1BBAGiap/WHI=;
	h=From:To:Cc:Subject:Date;
	b=dv/LBHBI4XZxw2I1bwl3px4QTdLKVPmDtWxXtiAtClAIZ2erXAz5uqyvW46VG2a9U
	 hCesV1a+0c+9lm8uihsBo69zqQfZPHVd2oCEe0+ej9qpa3kl9Kim1/JTBdDYHGT2OM
	 FSatpLpscYRk/YYgk5GGaCmS9qXbXA5sSiul6qLzmzvFeWR/MFd30w8YxMmSCtdBcY
	 ZL3+zpcy48Qms2MqCXbYV2x6uPODEIMiBFYL5oEHegb1x3zgSHjQbJfB06KKYWXUpJ
	 OmSRZE3at8z0uUOdrZBfLg8DE0zGnpe3lMs42O4pCvkmh/YjMK99GDrFs24Qlt/6vF
	 LSe9ml+FJH/Tw==
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
Subject: [PATCHES v2 00/29] perf: Harden perf.data parsing against crafted/corrupted files
Date: Sun, 24 May 2026 00:26:34 -0300
Message-ID: <20260524032709.1080771-1-acme@kernel.org>
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

- perf test at baseline and after the series with 300s timeout -- no
  regressions detected.
- Build with both gcc and clang at every patch.
- checkpatch.pl on all 29 patches.
- perf test on aarch64 (Raspberry PI 4).

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks,

- Arnaldo
