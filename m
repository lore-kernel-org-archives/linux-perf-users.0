Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DE75474F;
	Fri, 12 Jun 2026 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224492; cv=none; b=kyn/gucTy8ikaUdbSdQbnK20CjW45n7il3Z7QW3WADrwTPT/h0eZe5Kggl9zbfbMZCxzeX/+TLHqfWab//3bkyBHi8g+bZCjnSZp/1f5J4wcnYCU4EtC7bGc7dLMBDEdZgCabcmkRlqWIpFUYeXP4EpHZIiml7SjSHGQOdjCkkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224492; c=relaxed/simple;
	bh=aW2Hp5WDjMfbk7BCnkxkZ2udUQlf0TPvNVvxHfge8FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SLBr0WDM8WJNA1cy67PUA/iikjKDZzhCVc0fjSdnHmS74pznWTIiKNNYh/vZm/ui807XIt99bav6gSn13tg2g1cbvlgwwqYmQzTCUa9V0iMkKYe71RwsG/B+SjBIHT9EUXLsID9Xih7hXzfkmGUmh9yEL0m/qY8tqcqTcit5dkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhN2iNQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhN2iNQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9141F000E9;
	Fri, 12 Jun 2026 00:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224490;
	bh=982+NCBERiNBaFehSJWjNItC+BBYmRin2RcXpKIfPn4=;
	h=From:To:Cc:Subject:Date;
	b=ZhN2iNQErhgmpPQpmZISmfGQ1VXNKcnhCAXOVF0muafjZlsS8A4upxF1Cfb/eyClK
	 cK4V+MaV+M5qCOcQKO0OVclYYvNUTVYbAs12JTqoOMwUBN8l/3VJRZJPf8AXA4Z+8Q
	 YGhgR7mYklQ+R6KLPyyMtd+/9ZNPYw/Q6vKPPKsyesfPvk2RhIO5kM8DJ5wtZv4g+K
	 nyPe7jtni7jWAgoxMT5EFzLXApwZBSbFeZ/6yGacv3rxUOcALOxbLTuom1AfTSoGfN
	 Wksa//sKl6lIpzTIu6ZNjBYGEJRhpYQez+Mz7/yU4V6MJ4iYk85Bk+p+3GH2WOaNpS
	 Oa87YKP95jwrg==
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
Subject: [PATCHES v1 00/15] perf tools: Fix pre-existing bugs in symbols, dso, bpf, sched, c2c, hwmon, and cs-etm
Date: Thu, 11 Jun 2026 21:34:28 -0300
Message-ID: <20260612003444.50723-1-acme@kernel.org>
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

Fifteen more pre-existing bugs found by sashiko-bot during AI-assisted
code review.  All are independent of the perf-data-validation hardening
series -- they are latent bugs in surrounding code exposed during review.

The fixes are grouped by subsystem:

ELF/build-id parsing in the no-libelf path (patches 1-3):
  symbol-minimal.c carries a copy-paste typo that byte-swaps p_offset
  instead of p_filesz for 32-bit ELF.  The ssize_t p_filesz value is
  used without checking for negative, and sysfs__read_build_id() trusts
  fstat() on sysfs pseudo-files that report incorrect sizes.  Replaced
  with a fixed stack buffer and single read(), matching symbol-elf.c.

ELF note iteration (patch 4):
  sysfs__read_build_id() in the libelf path can loop forever when a
  note section contains zero-filled entries (namesz + descsz == 0).
  Break when no progress can be made.

DSO decompression and open (patches 5-6):
  dso__get_filename() copies a decompressed path with strcpy() into a
  potentially shorter heap buffer.  filename__decompress() fails to set
  the error code on the uncompressed fallback path, leaving callers
  with a stale errno.

Buffer overflow in root_dir path construction (patch 7):
  machine.c and symbol.c use sprintf() to build paths with root_dir,
  which can overflow the fixed-size buffer.  Switch to snprintf().

hwmon fd check (patch 8):
  hwmon_pmu__describe_items() tests fd > 0, rejecting the valid fd 0.

Undefined behavior in perf sched (patch 9):
  map__findnew_thread() uses (void*)1 as a sentinel for colored threads.
  This value gets dereferenced as a struct pointer and passed to free()
  on cleanup.  Replace with a proper allocation and a boolean color flag.

BPF metadata validation (patches 10-12):
  synthesize_bpf_prog_name() trusts func_info_rec_size and sub_id from
  perf.data without validation.  bpf_metadata_alloc() stores the event
  size in a __u16 without overflow checking.  bpil_offs_to_addr()
  converts untrusted offsets to heap pointers without bounds checking.

Memory leak in c2c (patch 13):
  c2c hist entries register format list entries but never unregister
  them on free, leaking the list nodes.

O_NONBLOCK for untrusted paths (patch 14):
  open() calls that process paths from perf.data events can hang on
  FIFOs or device nodes planted by a crafted file.  Add O_NONBLOCK as
  defense-in-depth on these foreign file opens.

CoreSight ETM CPU ID validation (patch 15):
  cs_etm__process_auxtrace_info_full() compares an unsigned CPU ID
  from perf.data metadata against a signed int without range checking.
  A large unsigned value wraps negative, bypassing the bounds check.

Build-tested with gcc and clang.  Passes perf test on x86_64.

Arnaldo Carvalho de Melo (15):
  perf symbols: Fix bswap copy-paste error for 32-bit ELF p_filesz
  perf symbols: Validate p_filesz before use in filename__read_build_id()
  perf symbols: Use fixed buffer in sysfs__read_build_id() for no-libelf build
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
  perf symbols: Add O_NONBLOCK to DSO open() calls for untrusted paths
  perf cs-etm: Reject CPU IDs that would overflow signed comparison

 tools/perf/builtin-c2c.c         |  1 +
 tools/perf/builtin-sched.c       | 23 ++++++++++++-----
 tools/perf/util/bpf-event.c      | 13 +++++++++-
 tools/perf/util/bpf-utils.c      | 14 +++++++++++
 tools/perf/util/cs-etm.c         |  9 ++++++-
 tools/perf/util/dso.c            | 18 +++++++++++---
 tools/perf/util/hwmon_pmu.c      |  2 +-
 tools/perf/util/machine.c        |  2 +-
 tools/perf/util/symbol-elf.c     | 10 +++++---
 tools/perf/util/symbol-minimal.c | 54 ++++++++++++++++++++++++----------------
 tools/perf/util/symbol.c         |  2 +-
 11 files changed, 108 insertions(+), 40 deletions(-)

Developed with AI assistance (Claude/sashiko), tagged in commits.

Thanks,

- Arnaldo
