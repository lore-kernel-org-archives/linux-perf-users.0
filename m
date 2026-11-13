Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604116;
	b=0OCVGeoyJ9SS0fiEoyCwKIkldS6Pr7UX19Huttbnoy7kHtM7AUM4HTTcLaflf4FHefGc
	 OrwtLPEIYgyY13xEWxZkf9veNSMqTbUv06Iw59sTMbEf9hSYnbfRKqnUd+EN+9wKacPwH
	 oWwPh2w0DyH2F9MnWJPmHLP2KUlgiGap/o334b4eJD/TACJsKXl+6SS/nVt0jQFj1K2w3
	 ToFRNgQuRqCJ/ODCL+t9ALLWJXC9vWaIgm5mzh+qlV4NF81s3VJN2QgGq8bdT8G7hLpXA
	 oNiu7SHtcVPzZh9fAot2f16+9nfszVpOm+XTIEFimg4+6nrXS7zGIeWaNfJ5WyAJlSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=lMtcuVS2Lr0ebu7RDUJZZXSvMpZ4q3ZWjn8clXjumSk=;
	b=CQS59Fg6hNm/U9Ol3DEmr84ueyqX+gdmqgWhMnK2cSj9SU2hKb7LHdI1CWty4W7ylF3W
	 64aZhusTUJDDpk7Zqo6XisFDsm/nK0gB2AyGKgSWGPXX/lWzHPmQ+uHq8j/nnTnNTsdv+
	 RxW8UwDKu8CAp7VQPk+0pqoDLsaDtx+jqbOAtgTUYmmdO0M4MBir0DQD5U3bva4o6Cav6
	 gUUHGR3AC8kREuNWJQNM4SeZRduvulQQ3v2tyYMghNXhsU5bL2O+1L1EeQU1/vCwu3Vw2
	 CH32g5NlbwpRv9qNRMadPSVMhy0VKSwYw847HrKdMDXuhAX/TuUhbGoNsnxtyQqMF9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XLSA43if;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04392606A33F
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04392606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XLSA43if
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1804740eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604114; x=1795208914; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMtcuVS2Lr0ebu7RDUJZZXSvMpZ4q3ZWjn8clXjumSk=;
        b=XLSA43ifBpJMwqdFTXSCPoLiCa5C7VQwLIIKh/s5nAe+8RwL4hoqjGpholFeml7Xtf
         B+NZRDj+NMWkKSdeAEIVpICAhIWsYBU/EBNA6NVBKbNOmxyzmfaj8JAHt2YR4AnDTskw
         PIp2pXfp7W3jXfVJqs6vuNBq6rhc5kDa/C5v12RDanPPQZT6pyp6UJJgXXHUm0K7n46b
         oDISPumYbcan2xOp++LSgACnJVENV91F+UaMY937dKd1L69jveIv/vVgGksX3OACCxDS
         SZmlRE5LrYo+u1qUBpMjHwILBUUMbsg0cCPbN43vN2crGfJPRVNw0ZrdTLV/OxY7+TvB
         tf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604114; x=1795208914;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lMtcuVS2Lr0ebu7RDUJZZXSvMpZ4q3ZWjn8clXjumSk=;
        b=GCAhmU2w44pvSv2prO6Fx75IIqpfcor8Y8F6rTjTxEnlDMcXwFgoDlJpEBLxYhnDWX
         wirLA5wCK521cZXYsu9fT/M7AorZs2AX2gkqqw2IZK0eeQXwIjz37xCOKW0+9Dm/SMD0
         V9sn4rxGBdBcpkpQ0m639Y1HCI8xJPyvQnNR/5aNDVF4GcloKtYezKgAaoFhRVUxnXxY
         IIfAb0yCamHireidL0UrUfHhRlj9/KVLP1fcI+IqoYtjwzbpewo2vRIxL8FgOjGHr8Xc
         nY1Z7yUuYsCh0PuL98+ZoIv6Rt3q8YS7L6S2m+M2ayuteiKFviVoBpLyCN23CSBCw6/U
         kKaw==
X-Forwarded-Encrypted: i=1; AL+hErGVxW1DEI+BiuAk39kuzmZWpsaEtDuxGvn8nP72wLHwkoLA5+dW/svrg6Q5Jhjk4XiwuKQC3iUUBOGnpLt0p8/B@vger.kernel.org
X-Gm-Message-State: APuU4Z95qL/J+l7kzG2lGLDxNhrxvMYhdTxAZeZRNcnq/DZm4TK0QYQh
	wnVZutvmxnyAqDJ/wc0ip6odMplCs7qgLpwyu5ap0pe043HLnjter3G+UboJVsDjNw0ME/bDRA2
	0+XWP3yVxXg==
X-Received: from dyab1.prod.google.com ([2002:a05:693c:8301:b0:36e:f67b:23ab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:b06:b0:36a:1089:9836
 with SMTP id 5a478bee46e88-3796628ce32mr2632208eec.15.1794604113673; Fri, 13
 Nov 2026 13:08:33 -0800 (PST)
Date: Fri, 13 Nov 2026 13:08:12 -0800
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
Message-ID: <20261113210822.3112700-1-irogers@google.com>
Subject: [PATCH 00/10] perf jevents: Block-indexed string compression and
 default JEVENTS_ARCH=all
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Compiled-in PMU event and metric tables (pmu-events-in.o) currently
store ~6.9 MiB of uncompressed string data in .rodata on x86 alone,
causing JEVENTS_ARCH to default to $(SRCARCH) rather than all and
preventing out-of-the-box cross-architecture perf.data event/metric
resolution unless explicitly built with JEVENTS_ARCH=all.

Compressing big_c_string as a single whole-table stream would force perf
to allocate and decompress megabytes of unused CPU models' strings on
startup just to resolve a single event, whereas compressing individual
short strings suffers from poor compression ratios and per-string
framing overhead.

Instead, this series introduces "block-indexed string compression":
sorted, suffix-folded event and metric byte records are packed into
~8 KiB blocks without splitting records across block boundaries, each
block is compressed independently (sharing a single preset or trained
dictionary across blocks so ~8 KiB blocks retain high compression
ratios), and every uint32_t string offset is encoded as
(block_id << 16) | sub_offset. An ~8 KiB target block size sits at the
knee of the compression vs. random-access curve (smaller 1-4 KiB blocks
pay 22-128% more .rodata for per-block entropy headers and index
entries, while larger 16-64 KiB blocks yield <15% extra savings at 2-8x
higher decompression and page-fault cost per binary-search probe). At
runtime, pmu_events__get_string() uses a lock-free atomic block pointer
cache to decompress only the touched ~8 KiB blocks on demand, leaving
untouched CPU models' and non-host architectures' blocks compressed in
.rodata at zero runtime CPU or heap cost.

The series starts with a standalone BigCString raw-byte fix for
describe_metricgroup() binary-search ordering, prepares the string and
PMU table layout, adds the zlib, lzma, and zstd block compression
backends, and switches the default JEVENTS_ARCH to all:

- Bug fix, string layout, and hot-path isolation (Patches 1-4):
  - Patch 1 stores raw NUL-delimited UTF-8 bytes in BigCString instead
    of C-escaped strings, fixing suffix folding and describe_metricgroup()
    binary-search ordering on prefix-overlapping names (such as "Bad" vs
    "BadSpec"; Fixes: 66c6e0c10027) without changing empty-pmu-events.c
    so it can be cherry-picked standalone.
  - Patch 2 partitions non-folded BigCString event strings before metric
    strings and sorts entries lexicographically by their raw UTF-8 byte
    sequence within each partition so identically prefixed event names,
    encodings, descriptions, and metric expressions cluster into
    adjacent ~8 KiB blocks, improving block compression ratios by
    ~20-23%.
  - Patch 3 stores PMU names directly as const char *pmu_name string
    literals in struct pmu_table_entry (only 68 unique PMU names / 536 B
    across ~443 rows across all architectures, already in .data.rel.ro)
    so the compiler/linker merge them in .rodata.str1.1 and hot PMU
    wildcard scans never touch big_c_string or trigger block
    decompression.
  - Patch 4 encapsulates big_c_string offset lookups behind
    pmu_events__get_string(uint32_t offset) across pmu-events.c and
    pmu-events-string.c.
- On-demand block decompression backends (Patches 5-8):
  - Patch 5 packs big_c_string into ~8 KiB record-aligned blocks indexed
    by (block_id << 16) | sub_offset, adds lock-free thread-safe atomic
    per-block decompression on demand, and adds --compress=zlib using
    raw Deflate with a <= 32 KiB preset dictionary.
  - Patch 6 adds --compress=lzma using raw LZMA2 per block with a 64 KiB
    dictionary window.
  - Patch 7 adds --compress=zstd using ZSTD_decompress_usingDDict() per
    block with a once-digested shared 64 KiB ZSTD_DDict (~26% smaller
    .rodata than dictionary-free ~8 KiB zstd blocks).
  - Patch 8 wires JEVENTS_COMPRESS into Makefile.perf and
    pmu-events/Build, preferring zstd, then zlib, then lzma, and falling
    back to none.
- Testing and JEVENTS_ARCH=all default (Patches 9-10):
  - Patch 9 adds prefix-overlapping metricgroups.json test coverage and
    an 8-thread concurrent event/metric/metricgroup stress test in
    perf test pmu-events.
  - Patch 10 switches the default JEVENTS_ARCH to all. Bundling all
    architectures (x86, arm64, powerpc, riscv, s390, nds32) with zstd
    shrinks pmu-events-in.o from 7.16 MiB (x86 + none) to 1.11 MiB
    (all + zstd, -84.5%) and cuts the stripped perf binary from
    13.32 MiB to 7.28 MiB (-45.4%), with ~3 ms median wall-clock
    overhead on 'perf stat true'.

AI Assistance Disclosure (per Documentation/process/coding-assistants.rst
and Documentation/process/generated-content.rst):
- Tools used: Antigravity coding assistant and Sashiko automated patch
  review.
- Summary of prompts and assistance: Interactive design and
  implementation of the BigCString raw-byte fix and alphabetical
  sorting, struct pmu_table_entry PMU name string literals, lock-free
  8 KiB block-indexed decompression across zlib, lzma, and zstd,
  Makefile.config/Build integration, multithreaded unit tests,
  size/latency benchmarking, and Sashiko review fixes.
- Testing performed: Built and tested JEVENTS_COMPRESS={none,zlib,lzma,zstd}
  and NO_JEVENTS=1, JEVENTS_ARCH={x86,all}, AddressSanitizer +
  LeakSanitizer, perf test (pmu-events, make, metric parsing), and
  scripts/checkpatch.pl.

Ian Rogers (10):
  perf jevents: Store raw bytes in BigCString instead of C-escaped
    strings
  perf jevents: Sort BigCString entries alphabetically
  perf jevents: Store PMU names as string literals in struct
    pmu_table_entry
  perf jevents: Encapsulate big_c_string lookups behind
    pmu_events__get_string()
  perf jevents: Add block-indexed string packing and --compress=zlib
  perf jevents: Add --compress=lzma block compression backend
  perf jevents: Add --compress=zstd block compression backend
  perf build: Enable jevents string compression when available
  perf tests pmu-events: Test metricgroup descriptions and concurrent
    lookups
  perf build: Default JEVENTS_ARCH to all

 tools/perf/.gitignore                         |    1 +
 tools/perf/Makefile.config                    |    9 +-
 tools/perf/Makefile.perf                      |   13 +-
 tools/perf/pmu-events/Build                   |   49 +-
 .../arch/test/test_soc/cpu/metricgroups.json  |    4 +
 tools/perf/pmu-events/empty-pmu-events.c      | 7804 +++++++++--------
 tools/perf/pmu-events/jevents.py              |  967 +-
 tools/perf/tests/make                         |    5 +-
 tools/perf/tests/pmu-events.c                 |  209 +-
 9 files changed, 5015 insertions(+), 4046 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metricgroups.json


base-commit: 4af65363b11fc4fe65fcb497f68bbe4f3e3a4d2c
-- 
2.56.1.703.gf848ed807c-goog
