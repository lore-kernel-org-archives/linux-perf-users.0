Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC530F534;
	Fri, 12 Jun 2026 22:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303061; cv=none; b=su+YtBVyDWT/zu0QiCSN01j8KWjABDoQRuJhG2+v6iF2aQxNRbbkxIW6GvKKKEpq+DkVheTLWxKpzwg3QjZjuoNtRjbKfvk4C72bOJvPWCGzW8Oq5h3hYNKB7Bfsg4CmBUoRAZW5vvV1zhvs4j57cSKZPR01tEqwQXz0Bz4f8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303061; c=relaxed/simple;
	bh=ajBNFsVXe0RP34YcRYN+7stLV5FMgdzDfGnFFF+AcGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t4Q6ggH7YBxvd0WMIU1jeE6dssrs9gFSXmWLv9/rpbfgecInkxPivR2h0/gwfxzHCpzoCUBGGCyJN1o0NDZMio/4M2LQ8/ze9Hxqf017RoxaYr/wVTipI23NoWcA6tbxZwjclz0uROjDn0hFdRtCi6+3mPaX5xRB+q8F8P+sulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGGRusPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGGRusPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757FB1F000E9;
	Fri, 12 Jun 2026 22:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303060;
	bh=NADQLPYHQGyrpqGVXeJlsPptNrGXcGIkvPAL6a+dlcI=;
	h=From:To:Cc:Subject:Date;
	b=AGGRusPlwVHe4gfIfs4F+asfYVuX3u4I7IdfTtO7yS4eAm7H4Es9f7W2YjZ7DbYMl
	 AESkpBbWbrjGHvgsHd91opNnFeGdUyPQyf7o5qxkdpEcBQJJL2JXZIUQdlwlVGP9C1
	 epuDtlhdn8MUEw/F/lkqM8GnMz7D8Ni7MWf3FhECnBSltdqa+lg8UoSn+eUGwM5vlh
	 iIbcZ0N2NWC+oLBTk+0h0Ie7VhigRxupL8bGTx1JayM8yCq2VS3fU3J2xzm5/t/nkI
	 QIEd989Fe09/mgZAWe9fXKuITRHz40sbWKZEKZRmDk/tKAjQmR777jSQxbKHZBK8uu
	 rCcJD3cziijGA==
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
Subject: [PATCHES v2 00/13] perf tools: Fix pre-existing bugs in symbols, dso, bpf, sched, c2c, hwmon, and cs-etm
Date: Fri, 12 Jun 2026 19:23:59 -0300
Message-ID: <20260612222413.40791-1-acme@kernel.org>
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

Thirteen more pre-existing bugs found by sashiko-bot during AI-assisted
code review.  All are independent of the perf-data-validation hardening
series -- they are latent bugs in surrounding code exposed during review.

The fixes are grouped by subsystem:

ELF/build-id parsing (patches 1-2):
  symbol-minimal.c carries a copy-paste typo that byte-swaps p_offset
  instead of p_filesz for 32-bit ELF.  The ssize_t p_filesz value is
  used without checking for negative.

ELF note iteration (patch 3):
  sysfs__read_build_id() in the libelf path can loop forever when a
  note section contains zero-filled entries (namesz + descsz == 0).
  Break when no progress can be made.

DSO decompression and open (patches 4-5):
  dso__get_filename() copies a decompressed path with strcpy() into a
  potentially shorter heap buffer.  filename__decompress() fails to set
  the error code on the uncompressed fallback path, leaving callers
  with a stale errno.

Buffer overflow in root_dir path construction (patch 6):
  machine.c and symbol.c use sprintf() to build paths with root_dir,
  which can overflow the fixed-size buffer.  Switch to snprintf().

hwmon fd check (patch 7):
  hwmon_pmu__describe_items() tests fd > 0, rejecting the valid fd 0.

Undefined behavior in perf sched (patch 8):
  map__findnew_thread() uses (void*)1 as a sentinel for colored threads.
  This value gets dereferenced as a struct pointer and passed to free()
  on cleanup.  Replace with a proper allocation and a boolean color flag.

BPF metadata validation (patches 9-11):
  synthesize_bpf_prog_name() trusts func_info_rec_size and sub_id from
  perf.data without validation.  bpf_metadata_alloc() stores the event
  size in a __u16 without overflow checking.  bpil_offs_to_addr()
  converts untrusted offsets to heap pointers without bounds checking.

Memory leak in c2c (patch 12):
  c2c hist entries register format list entries but never unregister
  them on free, leaking the list nodes.

CoreSight ETM CPU ID validation (patch 13):
  cs_etm__process_auxtrace_info_full() compares an unsigned CPU ID
  from perf.data metadata against a signed int without range checking.
  A large unsigned value wraps negative, bypassing the bounds check.

Build-tested with gcc and clang.  Passes perf test on x86_64.

Arnaldo Carvalho de Melo (13):
  perf symbols: Fix bswap copy-paste error for 32-bit ELF p_filesz
  perf symbols: Validate p_filesz before use in filename__read_build_id()
  perf symbols: Break infinite loop on zero-filled notes in sysfs__read_build_id()
  perf dso: Fix heap overflow in dso__get_filename() on decompressed path
  perf dso: Set error code when open() fails on uncompressed fallback path
  perf tools: Use snprintf() for root_dir path construction
  perf hwmon: Fix fd check to accept fd 0 in hwmon_pmu__describe_items()
  perf sched: Replace (void*)1 sentinel with proper runtime allocation
  perf bpf: Validate func_info_rec_size and sub_id in synthesize_bpf_prog_name()
  perf bpf: Reject oversized BPF metadata events that truncate header.size
  perf bpf: Bounds-check array offsets in bpil_offs_to_addr()
  perf c2c: Free format list entries when releasing c2c hist entries
  perf cs-etm: Reject CPU IDs that would overflow signed comparison

 tools/perf/builtin-c2c.c         |  1 +
 tools/perf/builtin-sched.c       | 23 +++++++++++++++++------
 tools/perf/util/bpf-event.c      | 13 ++++++++++++-
 tools/perf/util/bpf-utils.c      | 16 ++++++++++++++++
 tools/perf/util/cs-etm.c         |  9 ++++++++-
 tools/perf/util/dso.c            | 14 ++++++++++++--
 tools/perf/util/hwmon_pmu.c      |  2 +-
 tools/perf/util/machine.c        |  2 +-
 tools/perf/util/symbol-elf.c     |  3 +++
 tools/perf/util/symbol-minimal.c |  5 ++++-
 tools/perf/util/symbol.c         |  2 +-
 11 files changed, 76 insertions(+), 14 deletions(-)

Changes since v1:
- Dropped O_NONBLOCK patch per Ian Rogers' review: without
  TEMP_FAILURE_RETRY, O_NONBLOCK causes slow file systems to fail; the
  is_regular_file() checks are the correct mitigation.
- Dropped fixed-buffer rewrite of sysfs__read_build_id() for the
  no-libelf path (type-punning fix); needs more consideration.
- Patch 11 (bpil bounds check): clear the array bit when zeroing invalid
  offsets, so bpil_addr_to_offs() won't leak the heap address into
  output perf.data.
- Patch 13 (cs-etm): change > INT_MAX to >= INT_MAX, preventing
  max_cpu + 1 signed integer overflow in auxtrace_queues__init_nr().

Developed with AI assistance (Claude/sashiko), tagged in commits.
