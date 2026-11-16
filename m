Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815109;
	b=0Gn5O9bcbgVO+vVzpVINgDnrYOg8rwsDGSgAaWq6rPQ57M9i7fn+DHxDW2c5DHhNAxaG
	 HbuKfoq9xeTEQIh6+0IgShTb7guijCK9sexWbMexgcQlOyGpTh5876oHBjMd6Sg/Fy3DY
	 FdmOB1R4jqZIA3034RtI2prB22ATEGB3aiFnn/KguJcQj2Nm9GuqFVo34Ffey9/Bmz5xD
	 w3przRRC7e3FVuWlhDiflDOYpCeROE+fmcFhT+ms3c+Z+HWKHJ0s+hg0XmcoZP+Jr+XZA
	 NYnC9gWUvzj8BOdPI1NNb7rJunPsSge5ffciGgE22aJS+99/GoPLTYEenIofus6ZMqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=DSWbALBN9X1ERI94dNFzo1xQvgHy2y5vVAIh9Cg6Zn0=;
	b=MNrTP5dgp1qd7ndBaS2u/KrsnNcDUkJO2ftE24IP0Yzl8rk4vvq35CB+8ci4QLpkgTln
	 WwLGmfvaO+DdVgK/0hNiZZQn1qEZ/tbQHc3EXdnTXz/NS1LZfujEw7uF+hKdBRrxHatC9
	 cE1lEShf5a1sr8pCqwOmYjZVXnIE9mWv5j81hNMEVVepvCDjla1hQAu4rqGjBX/Hsh8RS
	 7TTktZpx9/l7A+CLRaKRa/Th+Gs7U4D+AtU0QAEvf40y0z55MGCG9tHo2okRfWR8zvxba
	 iF4/48RP4p+ox3nRXcTDUUzQw0wazJtYQELKYKNgerIF0F0Jcw6IP0WUJU7TYt74fow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZPetj+yV;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF5606A32A
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59FF5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZPetj+yV
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36ecd5db581so3147195eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794815107; x=1795419907; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DSWbALBN9X1ERI94dNFzo1xQvgHy2y5vVAIh9Cg6Zn0=;
        b=ZPetj+yVUJzFZ1BwOYntRBdsF2kpkXp+6P6FCoZRBUZk8RpQUKrXY2GjXxpyQWPbRo
         dUcu2TXLnkzh4Ex2MdWVZWYsbxL7BJ6zC8ZMS8YWW474J5UQMOxUcqLUcfXR0xbTc/OW
         +C8G74s716k/rDb+5xPacsUjXvCUDTIayj3yR+JFE7pz4HihEeVeL1uwIevqQYtHf1Wm
         uqlfX1UFxs3CIkcIJUihA4z1nt68Jpq6OGT3zV5N98GnnRY7mgeadLjaJMmf0z23CNet
         O01fCFIWYRZDr7KklKavHEtf227g/7W5b95gMbKIXY9urcBRJyjZcQUZbB3yxUN9bVqI
         e/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815107; x=1795419907;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DSWbALBN9X1ERI94dNFzo1xQvgHy2y5vVAIh9Cg6Zn0=;
        b=TzBKAMhioXME+ZsLo0lR7TPwGQERp/3UgsRyC/kRajT3Yeevonv+uJfuJj5CaMbihT
         RKWxSK1uyYktOIn0M9qvgQoRP3K6v+iNNvlkSvPFJDXT9pBzcWc+M99cUJIczkCQrnQG
         JGzCoClzZzMWYbv69kltY7ueRk7E+ESioo0gXWS0kKQr1qdVr7a1HIDcMtgX8yThlBcU
         mXQnDoB4E6bZUMksy1fs64Y7nQwR5Ivk1bML80zkRUjxAIXtCHtlhVPWYS+a8jR5U14j
         cDXlnWr8WSlibDsTZPj7UigELPSDKFnYstzkgKAk0uiTQbWLo3BgcNybvJcDIryONqck
         LEXg==
X-Forwarded-Encrypted: i=1; AL+hErE/vFM3JnnF5J5+Vk9FTKNIKlrzZhP2xLo8C8P9KWpFwf7C4JEC2ZsOeMMID60kywulzi29mtSW+7bIQM91MrC1@vger.kernel.org
X-Gm-Message-State: APuU4Z9SlpDhAkH4dOgTgzRgeEwwgkaS32L8ONFARgiEo8AwTgkoO6wi
	ABl9maj5dBAaYhIJrT7owNin34bk7PN7B3lCuzZUvuHDuwR3+InpP0BhxIwN0GDoxAXWxEZaQWu
	i98Dohbp5qA==
X-Received: from dycoi1.prod.google.com ([2002:a05:7301:da81:b0:36f:6ecc:5239])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:bf9c:b0:375:370e:f1ff
 with SMTP id 5a478bee46e88-379671238f1mr9548432eec.35.1794815106830; Sun, 15
 Nov 2026 23:45:06 -0800 (PST)
Date: Sun, 15 Nov 2026 23:43:55 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116074414.3174737-1-irogers@google.com>
Subject: [PATCH v3 00/19] perf/core, perf/tools: Add PERF_SAMPLE_BUILD_ID_OFFSET
 support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
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

Based on linux-next (next-20261113) merged with perf-tools-next
(b7ff10b9ddec), which combines the tip, bpf-next, and perf-tools-next
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
 arch/s390/kernel/perf_cpum_sf.c               |   7 +-
 include/linux/bpf.h                           |  14 +
 include/linux/perf_event.h                    |  43 +-
 include/uapi/linux/perf_event.h               |  72 +-
 kernel/bpf/stackmap.c                         |  10 +-
 kernel/events/callchain.c                     | 206 +++-
 kernel/events/core.c                          | 310 +++++-
 tools/include/uapi/linux/perf_event.h         |  72 +-
 tools/lib/perf/include/perf/event.h           |  43 +-
 tools/perf/Documentation/perf-inject.txt      |   8 +
 tools/perf/Documentation/perf-record.txt      |   6 +
 .../arch/powerpc/util/skip-callchain-idx.c    |   4 +-
 tools/perf/builtin-inject.c                   |  80 +-
 tools/perf/builtin-record.c                   |  22 +-
 tools/perf/builtin-report.c                   |   6 +-
 tools/perf/builtin-script.c                   |  75 +-
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
 tools/perf/util/evsel.h                       |   3 +-
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
 64 files changed, 3433 insertions(+), 380 deletions(-)
 create mode 100644 tools/perf/tests/bid-offset.c
 create mode 100755 tools/perf/tests/shell/inject_bid_offset.sh
 create mode 100644 tools/perf/util/inject_bid_offset.c
 create mode 100644 tools/perf/util/inject_bid_offset.h

-- 
2.56.1.703.gf848ed807c-goog

