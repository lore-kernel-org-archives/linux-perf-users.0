Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567882;
	b=GdNhG35EGIGxgxA7cNG4ML69XF9c5B3bBva9YQ8w11e4SfS8sbKWgADSBugp7m7R9hgz
	 oOwQpc1EcCexZebroOseuNgtPOodosaCYcRHfYFHUGkKvHEfM9r5A4gZfgyMHPD/BPzLe
	 HhQXpn1FRLI2LLgEo6keugV/zxwC0bFrr3BSsvzBWHghO1hZAGevmbBEWqWu5X3YyvSP2
	 G4keuPYZbR2ICpss9akk/C4yNGJ1i1WtjgyKTWHB/IksUWpxEkMuEGST4UG3Ofu8bWBJr
	 V9/BW5Q8gjW/ji1ivnkxmSN3HeWFUQ/FAKgTZ3mmeBV4nbd2SRZ7wTQPoWvX8C38buA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=xn05DNXJx3ZrmbBdEnb3GxLRVxQ7tTbOGpqpdS+/kMM=;
	b=QPm/maG05zS6wz1Zz8UxU3spOPNMBDUlR2UF7xMPHCMP2YF+7I3DssMUPLGJpvdczWVW
	 7wBl4FWUpPBPsxdWvv9maK3zYeWEmBLdC6ISwfm3dYlT7QkVamRPBu+l8fX6XdRbYBIl2
	 guMZ1emSuAVBrFGaXCklKzO5KTcKwWhpKt3vMTkKIvsWQSN/lr6jANxkbVdUwYAbWEx7d
	 2aat/Zum8hCL0JOIGAJY1Zbf8p/s9olYEYoq9WeqsBOT6RUM4eIzgK3/xFf5Tc9rX+UMi
	 SVj9vfBpLTDiew8z6/qX7tAP1Ukecji0bQ3LDFnNA7UQGT9h+cGlDGrg25H3hYmnFeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IeVgVvsE;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6225606A323
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 00:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6225606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IeVgVvsE
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-386b8624cf7so5839059eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 16:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567881; x=1796172681; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xn05DNXJx3ZrmbBdEnb3GxLRVxQ7tTbOGpqpdS+/kMM=;
        b=IeVgVvsE8XPiJVP51wPpsrsuuT+h3agsYQgtQlAcUQvwYFBfWzKe53xNQjsIL+wfLC
         GYe/5hhlz8jax9H5tKG3B4jBo8Ng7vpvGISlwgwLFDh03AKC6/0Pp3ueLCjtQg+GoX0m
         IYBB9mDnkDhei9MkzhcBdUdAHPQxJUXe/rBDvUGBzdEL5QULW1EA4Xuvxicl2hnsG7QM
         xh9A8iJIJD54+2ELaH/M7h7RY11uYFqeXYdeKZzA8/OKISGFAIdD0AN52etsZ+jF5Xc1
         pQ7R36/quP9/HYmvmy4fMuBcTmif44p+o40GBmnOIoZd1iIgWUV7pfeLmOycmxYIo210
         NmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567881; x=1796172681;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xn05DNXJx3ZrmbBdEnb3GxLRVxQ7tTbOGpqpdS+/kMM=;
        b=H2kQEOczbDPm55IDo8vEsmC8NTX6IW7BSoG+Q9E7FVkJ04eZxBiY3VBVk8B9i4rEGo
         9XiqvW7abv0MNTmqqIRHD0Q0o2jQTCxIxqQr4XSAZwXSkeGMAysuSjKLmU6nqi0BaVIp
         A+DlpTF3Qhg3A5REcCOv6Zx/C0vmJIKmTPXQQlRMWjr74aHV5J9RCTa7mxbE3tOBdtTW
         MkFDvCYr5iih0dXcogsAasGezM8YYeB//xHVbp0C9ujBVthG/XvI0HDdoOCE3uM2pFxb
         Hpwez/wie0mMUDRX0M9P32YXJ0dTcfbukh8Jlpm05zXEjVyLRJQIi6KBKfB2QsTJrcZh
         aHqQ==
X-Forwarded-Encrypted: i=1; AL+hErEGZtsi0lgFQA2ZZla2anUI+FaZLaw+7XqkoERKi7OtKgjCngolQb4eTws4Wyk/0IuV++OB8SDLgNfO/8aerQFV@vger.kernel.org
X-Gm-Message-State: APuU4Z9l2zqDj33D3OjlIFLSqvtOO29/Mx6+P7JVAdUhEA6x3hknLMDQ
	cVoYFJps2Cfo1cwsq7t2/Aq6uZA0spoQa5XdT3/cUbXUXzXmwwBMi5SPxbShZ4cXZhwafAiN6+b
	u+7wWqJJG7w==
X-Received: from dyaw26-n1.prod.google.com ([2002:a05:693c:415a:10b0:359:a8c8:38e2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8859:b0:386:b826:3f9
 with SMTP id 5a478bee46e88-386b82605b9mr5947474eec.7.1795567880388; Tue, 24
 Nov 2026 16:51:20 -0800 (PST)
Date: Tue, 24 Nov 2026 16:50:49 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125005108.1020003-1-irogers@google.com>
Subject: [PATCH v4 00/19] perf/core, perf/tools: Add PERF_SAMPLE_BUILD_ID_OFFSET
 support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Athira Rajeev <atrajeev@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Dmitry Vyukov <dvyukov@google.com>, 
	"Steinar H . Gunderson" <sesse@google.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series introduces PERF_SAMPLE_BUILD_ID_OFFSET and
PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET to the perf_event UAPI and
implements full support across both the kernel and perf tools. It
builds on earlier work making build IDs the default and improving build
ID handling in perf [1].

Based on linux-next (next-20261123) merged with perf-tools-next
(964e8b1c9c79), which combines the tip, bpf-next, and perf-tools-next
trees including the prerequisite deferred-output perf/core fixes [4]
and standalone perf tool fixes.

Background & Motivation:

In order for perf to translate virtual addresses of samples into
symbols a file and offset within the file are needed. During event
synthesis perf will create mmap events to facilitate the translation
of a virtual address to a file and offset by modelling the address
space of a process. By directly recording in a sample the Build ID of
a file and the offset within it, no synthesis is necessary. The Build
ID and offset as a pair are larger than a virtual address, so there is
a trade-off between synthesis cost and extra size for samples. These
changes facilitate Build ID and offset as a choice for perf samples so
the user can choose to use it when they believe it is advantageous.

In practice perf still needs to map a build ID to a file, so by
default this change keeps synthesis to allow this. It is expected a
user that knows their build IDs, say through debuginfod, will disable
this option with --synth=no.

For callchains (PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET and
PERF_RECORD_CALLCHAIN_DEFERRED with PERF_RECORD_MISC_MMAP_BUILD_ID),
unique build IDs are deduplicated into a compact variable-length table
(up to 254 unique build IDs per record) and referenced by a 1-based
index in the top byte alongside a 56-bit file offset for user frames,
while non-user callchain addresses and context markers are preserved
unmodified across architectures.

The kernel support uses the existing build ID and offset support used
by BPF stack traces (stack_map_get_build_id_offset()). When
attr.defer_callchain is enabled (the default for `perf record
--buildid-offset`), user-space build ID and offset resolution is
deferred to a task_work callback where page faults are permitted, with
resolved entries emitted via PERF_RECORD_CALLCHAIN_DEFERRED.

The Build ID and offset samples inherently don't leak ASLR
information. As with the ASLR remapping work in perf inject, support
is added to migrate virtual addresses to Build ID and offset (`perf
inject --sample-buildids`) for testing and conversion without kernel
support.

Series Organization:
- Patch 1: Pre-existing kernel perf/core fix for per-CPU callchain
  buffer protection across bpf_overflow_handler().
- Patches 2-6: Kernel UAPI, BPF helper export, and perf/core synchronous
  and deferred BUILD_ID_OFFSET / CALLCHAIN_BUILD_ID_OFFSET support.
- Patches 7-9: Pre-existing perf tool fixes uncovered during
  development and review.
- Patches 10-19: Tool UAPI header sync, perf parsing/synthesis/symbol
  resolution, `perf inject --sample-buildids`, `perf record
  --buildid-offset`, man page updates, and C/shell test coverage.

v4:
- Rebased onto linux-next (next-20261123) + perf-tools-next
  (964e8b1c9c79), adapting to the new `perf maps` Clang thread-safety /
  context-analysis annotations, and addressed review feedback from
  Namhyung Kim and Athira Rajeev on v3 [5] (with AI coding assistant
  help refactoring and verifying fixes against kernel/perf builds,
  checkpatch.pl, and `perf test`):
  - Moved PERF_SAMPLE_BUILD_ID_OFFSET and
    PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET before PERF_SAMPLE_AUX in the
    PERF_RECORD_SAMPLE UAPI layout, kernel perf_prepare_sample() /
    perf_output_sample(), and perf tools parsing, synthesis, and `perf
    inject --sample-buildids` so PERF_SAMPLE_AUX remains the last entry
    consuming the remaining sample space (Namhyung).
  - Clarified the PERF_SAMPLE_BUILD_ID_OFFSET UAPI layout comment for
    resolved user IPs, non-user/unresolved user IPs (bid.size == 0 and
    offset holding the raw IP/virtual address), and attr.defer_callchain
    deferred user IPs, as well as valid build_ids[] table entry sizes
    (1 <= size <= 20; zero-padded to 20 bytes by the kernel via
    bpf_stack_build_id while user-space tools such as `perf inject` may
    emit the exact unpadded length) (Athira).
  - Added PERF_SAMPLE_CALLCHAIN_TYPE alongside PERF_SAMPLE_WEIGHT_TYPE
    in UAPI and used it across kernel and perf tool callchain checks
    (Athira).
  - Allocated the per-CPU build-ID callchain scratch buffers
    on demand only while at least one
    PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET event is active, avoiding any
    extra memory overhead for plain PERF_SAMPLE_CALLCHAIN events, and
    documented the per-CPU memory cost in Patch 5's commit message
    (Athira).

v3:
- Rebased onto linux-next (next-20261113) + perf-tools-next, dropping
  the prerequisite perf/core [4] and perf tool fixes that were merged
  upstream, and addressed review feedback on v2 [3] as well as findings
  from Sashiko AI review (with AI coding assistant help refactoring and
  verifying fixes against kernel/perf builds, checkpatch.pl, and
  `perf test`):
  - Split larger kernel and tool patches into smaller logical commits
    and separated pre-existing kernel and perf tool bug fixes into
    standalone commits with Fixes: tags at the start of the kernel and
    tool sections.
  - Changed PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET and build-ID
    PERF_RECORD_CALLCHAIN_DEFERRED to deduplicate build IDs into a
    compact packed table + 8-bit index / 56-bit file offset array,
    keeping non-user addresses lossless across all architectures.
  - Preserved source-level API compatibility in libperf's
    `struct perf_record_mmap2` union by retaining `build_id_size` and
    `build_id[]` alongside `struct perf_build_id bid`.
  - Fixed per-CPU callchain buffer protection across
    bpf_overflow_handler(), deferred output build-ID accounting and
    single-IP clamping, and deferred callchain u16 header.size clamping.
  - Isolated user vs kernel DSO/map build-ID lookups, handled vDSO and
    kcore names when synthesizing build IDs in `perf inject
    --sample-buildids`, aligned sample payload walking with
    __evsel__parse_sample(), and fixed cross-endian deferred sample
    re-parsing and Python event copying.
  - Documented `--sample-buildids` in perf-inject.txt and
    `--buildid-offset` in perf-record.txt.

v2:
- Addressed review feedback from Namhyung Kim and Sashiko AI on v1 [2]:
  - Extended the deferred callchain unwind infrastructure
    (attr.defer_callchain / PERF_RECORD_CALLCHAIN_DEFERRED) to support
    deferred user-space build ID and offset resolution in task_work
    context where page faults are allowed, avoiding NMI-time page fault
    limitations and per-CPU irq_work contention.
  - Batched in-place user callchain resolution into a single
    stack_map_get_build_id_offset() call and skipped kernel frames.
  - Defined struct perf_build_id and struct perf_sample_build_id_offset
    consistently across UAPI and libperf headers, with a fallback for
    __DECLARE_FLEX_ARRAY.
  - Added reference-counted tracking (nr_build_id_offset_events and
    nr_callchain_build_id_offset_events) and clamped callchain frame
    counts in perf_prepare_sample() and perf_callchain_deferred_output()
    to prevent u16 header.size overflows.
  - Added cross-endian byte-swapping support for
    PERF_SAMPLE_BUILD_ID_OFFSET, PERF_SAMPLE_CALLCHAIN_BUILD_ID_OFFSET,
    and PERF_RECORD_CALLCHAIN_DEFERRED.
  - Fixed perf_record_mmap2 union field preservation when build ID
    synthesis fails, callchain context marker tracking in perf inject,
    and per-event callgraph configuration in `perf record
    --buildid-offset`.

[1] https://lore.kernel.org/lkml/20250424061943.1321025-1-irogers@google.com/
[2] https://lore.kernel.org/lkml/20260807071818.718751-1-irogers@google.com/
[3] https://lore.kernel.org/linux-perf-users/20261002173848.3228217-1-irogers@google.com/
[4] https://lore.kernel.org/lkml/20261025215508.1237480-1-irogers@google.com/
[5] https://lore.kernel.org/all/20261116074414.3174737-1-irogers@google.com/

Ian Rogers (19):
  perf/core: Protect per-CPU callchain buffer across
    bpf_overflow_handler()
  perf/uapi: Factor perf_build_id out into its own top-level struct
  perf/uapi: Add BUILD_ID_OFFSET sample types to UAPI
  bpf: Export stack_map_get_build_id_offset() for perf events
  perf/core: Implement BUILD_ID_OFFSET and CALLCHAIN_BUILD_ID_OFFSET
    sample types
  perf/core: Support deferred unwinding for BUILD_ID_OFFSET sample types
  perf inject: Set ordered_events and ordering_requires_timestamps for
    --aslr
  perf session: Avoid double byte-swapping re-parsed deferred samples
  perf inject: Fix PERF_SAMPLE_READ layout and bounds checks in
    aslr_tool__process_sample()
  tools headers UAPI: Sync linux/perf_event.h for struct perf_build_id
  tools headers UAPI: Sync linux/perf_event.h for BUILD_ID_OFFSET
  perf: Refactor thread map and symbol APIs to take perf_sample
  perf maps: Add dsos__find_by_build_id() and maps__find_by_build_id()
  perf evsel: Parse, synthesize, and dump BUILD_ID_OFFSET sample types
  perf symbol: Resolve symbols and callchains using build ID and offset
  perf inject: Add --sample-buildids to convert samples to build ID +
    offset
  perf record: Add --buildid-offset option
  perf test: Add BUILD_ID_OFFSET C unit tests
  perf test: Add inject --sample-buildids and record --buildid-offset
    shell tests

 arch/powerpc/perf/core-book3s.c               |  10 +-
 arch/s390/kernel/perf_cpum_sf.c               |   6 +-
 include/linux/bpf.h                           |  14 +
 include/linux/perf_event.h                    |  45 +-
 include/uapi/linux/perf_event.h               |  90 +-
 kernel/bpf/stackmap.c                         |   8 +-
 kernel/events/callchain.c                     | 308 +++++-
 kernel/events/core.c                          | 315 ++++++-
 tools/include/uapi/linux/perf_event.h         |  90 +-
 tools/lib/perf/include/perf/event.h           |  43 +-
 tools/perf/Documentation/perf-inject.txt      |   8 +
 tools/perf/Documentation/perf-record.txt      |   6 +
 .../arch/powerpc/util/skip-callchain-idx.c    |   4 +-
 tools/perf/builtin-inject.c                   |  80 +-
 tools/perf/builtin-record.c                   |  22 +-
 tools/perf/builtin-report.c                   |   4 +-
 tools/perf/builtin-script.c                   |  76 +-
 tools/perf/builtin-timechart.c                |   5 +-
 tools/perf/builtin-trace.c                    |  10 +-
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/bid-offset.c                 |  61 ++
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/code-reading.c               |   6 +-
 tools/perf/tests/mmap-thread-lookup.c         |  58 +-
 tools/perf/tests/sample-parsing.c             |  60 +-
 tools/perf/tests/shell/inject_bid_offset.sh   | 179 ++++
 tools/perf/tests/shell/record.sh              |  74 ++
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate-data.c               |   5 +-
 tools/perf/util/aslr.c                        | 142 ++-
 tools/perf/util/build-id.c                    |   2 +-
 tools/perf/util/callchain.c                   | 153 ++-
 tools/perf/util/capstone.c                    |   4 +-
 tools/perf/util/cs-etm.c                      |  10 +-
 tools/perf/util/data-convert-json.c           |   4 +-
 tools/perf/util/debug.c                       |   6 +-
 tools/perf/util/dlfilter.c                    |   8 +-
 tools/perf/util/dsos.c                        |  68 ++
 tools/perf/util/dsos.h                        |   6 +
 tools/perf/util/event.c                       |  89 +-
 tools/perf/util/evlist.c                      |  38 +-
 tools/perf/util/evlist.h                      |   2 +
 tools/perf/util/evsel.c                       | 180 +++-
 tools/perf/util/evsel.h                       |   2 +-
 tools/perf/util/evsel_fprintf.c               |   9 +-
 tools/perf/util/inject_bid_offset.c           | 882 ++++++++++++++++++
 tools/perf/util/inject_bid_offset.h           |  15 +
 tools/perf/util/intel-pt.c                    |  24 +-
 tools/perf/util/machine.c                     | 194 +++-
 tools/perf/util/maps.c                        |  73 ++
 tools/perf/util/maps.h                        |   2 +
 tools/perf/util/perf_event_attr_fprintf.c     |   3 +-
 tools/perf/util/python.c                      |  43 +-
 tools/perf/util/record.c                      |  22 +
 tools/perf/util/record.h                      |   1 +
 tools/perf/util/sample.c                      |  84 ++
 tools/perf/util/sample.h                      |  39 +
 tools/perf/util/session.c                     | 140 ++-
 tools/perf/util/synthetic-events.c            |  77 +-
 tools/perf/util/thread.c                      |  11 +-
 tools/perf/util/thread.h                      |  14 +-
 tools/perf/util/unwind-libdw.c                |   7 +-
 tools/perf/util/unwind-libunwind.c            |   8 +-
 64 files changed, 3564 insertions(+), 389 deletions(-)
 create mode 100644 tools/perf/tests/bid-offset.c
 create mode 100755 tools/perf/tests/shell/inject_bid_offset.sh
 create mode 100644 tools/perf/util/inject_bid_offset.c
 create mode 100644 tools/perf/util/inject_bid_offset.h

base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
-- 
2.56.1.831.g720f3f5937-goog

