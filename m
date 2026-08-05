Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811D3D3318;
	Wed,  5 Aug 2026 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965237; cv=none; b=LV86gSZJUpbBGv5uV1pA8eLziXLLAfNHdfRRD0tRwLwN2NhNMRHFiEX4DyK03podipiWroNSReqo/qHKi1fI7DB8yIHfHz/CSOK5ODV53/gBKn1goYwO+Hmvp0HSJLszZtmkcnsrVIXZf4C+pMp9B19BPh5O4yabr1K35YFRrPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965237; c=relaxed/simple;
	bh=skAOxY7Jd/GzYrdR6ZgYlpAJKDoW87aPRFJAoUbh7Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XG+Z1WmzY7RmxbZRFFGmnE9sfcdbf5UIRB1I8ocy/VjG2c3pqTS2AnU2ghkE9qGgTltSNAsf4RcgeNqD4LZ8z0rDn3xXiGJ42nl+e7bTGFp8cg2UobBXasc8TW6hPYk6m3+f5BiZ3gk1Y20Jjy9+qB65mogowGRvL+DbD3exMCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeP8sHAE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeP8sHAE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84541F000E9;
	Wed,  5 Aug 2026 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785965233;
	bh=5eYRW/q+KKm6xONOkSi/mKD1kUg6rfH/PCCuPQyHXmA=;
	h=From:To:Cc:Subject:Date;
	b=YeP8sHAEDqWLvfc3Yxn/0/wE5DMHfRTUh3wmmyFSIgIlW2ViuEsfRMolwjwl9viM+
	 jqpcJFo2LXgLtVuqHVq+o42SfwMkCcMonPsJFC/CsbAE24Tp6vPZ/VthYQoFZvFnb2
	 QiDYjydYM2ukYg/COhJghFNxybslmCprE9UetxrA3tLlaG4S2mrLVgO5Wy9vwaMTKw
	 0iWYWm50fZVtaoYJ2soCSEdl06qttJk35ffSCDoPj2szuc7EHtG+kzsdfFREzxmGI6
	 DttvB0youXvfFagB9Uh82zbuq4Qmw/KOGGtI3+BB2TnoBT/G3BFvXciH3jFa/mOBVq
	 hBxTzSYS3gI8g==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Stefano Sanfilippo <ssanfilippo@chromium.org>
Subject: [PATCHES v2 0/12] perf jitdump: Input validation hardening
Date: Wed,  5 Aug 2026 18:26:50 -0300
Message-ID: <20260805212704.267779-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

	Please consider merging,

This series addresses twelve classes of input validation and resource
handling bugs in the jitdump file format parser that could cause OOB
memory access or memory leaks when processing maliciously crafted or
corrupted jitdump files.

All issues were discovered by sashiko-bot during automated review of the
jitdump code path.  The bugs affect both the native-endian and byte-swap
code paths, with some checks previously only enforced during
byte-swapping.

Critical fix:
  code_size validation was bypassable via int truncation.  A record with
  code_size in [2^31, record_size - 56] passed the existing bounds check
  in jit_repipe_code_load() but truncated to a negative int when sent to
  jit_process_code_load(), so the code pointer landed ~2GiB past the
  record buffer, defeating the memchr() NUL scan and corrupting the
  injected ELF.

  Before: code_size = 0x80000010 passes the range check, then truncates
          to a negative offset
  After:  code_size > INT_MAX is rejected up front; all subsequent code
          size arithmetic stays within the record buffer

Best regards,

- Arnaldo

Changes since v1 (20260805133013.235016-1-acme@kernel.org):

  - Rebased onto the current perf-tools-next head (fe3ab00d55aa56b4).

  - All 12 patches now carry a Reviewed-by: Ian Rogers <irogers@google.com>.

  - Applied the code-convention suggestions from Ian's review of v1:
    - Patch "perf jitdump: Check snprintf return before computing header
      size": the clamp now uses sizeof(event->mmap2.filename) instead of
      PATH_MAX in both jit_repipe_code_load() and
      jit_repipe_code_move(), tying the bound to the actual destination
      buffer.
    - Patch "perf jitdump: Use dirname() return value in jit_open()":
      the strlcpy() bound uses sizeof(jd->dir) instead of PATH_MAX.
    - A cosmetics-only remark about the include order of <limits.h> was
      deliberately not applied.

Issues fixed:

  Validation and bounds checks:
  - Validate code_size against both the record size and INT_MAX in
    jit_repipe_code_load()
  - Prevent integer underflow in the debug info size calculation
  - Bounds-check the debug entry byte-swap loop
  - Validate debug entries on the native (non-swap) path, matching the
    existing byte-swap path checks
  - Validate sym string NUL-termination in code load, bounding the
    strlen() scan to the code blob
  - Validate unwinding sizes against the record payload before allocating
  - Check the snprintf() return before computing the header size, and
    clamp against the actual buffer size

  Stream and record handling:
  - Fix the extended header read that always failed, causing records to
    be misparsed
  - Use dirname()'s return value in jit_open(), fixing ENOTDIR failures
  - Fix funlockfile() being called on an unlocked stream in the jit_open()
    error path

  Resource management:
  - Free the event in jit_repipe_code_move()
  - Fix debug_data and unwinding_data leaks when records are overwritten

Each patch includes a Fixes: tag pointing to the offending commit, dating
back to jitdump mmap injection support (9b07e27f88b9cd78), source line
info support (598b7c6919c7bbcc), and unwinding support
(0284fecd13b6db3e), all from the original 2016 jitdump work.

Testing: Built and tested on x86_64.  No existing tests cover jitdump
parsing with malformed input; test suite expansion is left for future
work.  The final series was re-reviewed after the fixes and the v1
review (build-checked, Fixes: tags verified); no regressions found.

AI assistance: This series was developed with assistance from Claude
(claude-opus-4.6) and Opencode (deepseek-v4-flash-free) for code
analysis, patch generation, and commit message composition.


Arnaldo Carvalho de Melo (12):
  perf jitdump: Fix extended header read that always fails
  perf jitdump: Validate code_size against total_size in code load
  perf jitdump: Prevent integer underflow in debug info size calculation
  perf jitdump: Bounds-check debug entry byte-swap loop
  perf jitdump: Check snprintf return before computing header size
  perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path
  perf jitdump: Free event in jit_repipe_code_move()
  perf jitdump: Fix debug_data and unwinding_data leaks
  perf jitdump: Use dirname() return value in jit_open()
  perf jitdump: Validate debug entries on native (non-swap) path
  perf jitdump: Validate sym string NUL-termination in code load
  perf jitdump: Validate unwinding sizes against record payload

 tools/perf/util/jitdump.c | 126 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 108 insertions(+), 18 deletions(-)

base-commit: fe3ab00d55aa56b4d55cbc1150448f0aadd6732c

Arnaldo Carvalho de Melo (12):
  perf jitdump: Fix extended header read that always fails
  perf jitdump: Validate code_size against total_size in code load
  perf jitdump: Prevent integer underflow in debug info size calculation
  perf jitdump: Bounds-check debug entry byte-swap loop
  perf jitdump: Check snprintf return before computing header size
  perf jitdump: Fix funlockfile on unlocked stream in jit_open() error
    path
  perf jitdump: Free event in jit_repipe_code_move()
  perf jitdump: Fix debug_data and unwinding_data leaks
  perf jitdump: Use dirname() return value in jit_open()
  perf jitdump: Validate debug entries on native (non-swap) path
  perf jitdump: Validate sym string NUL-termination in code load
  perf jitdump: Validate unwinding sizes against record payload

 tools/perf/util/jitdump.c | 126 ++++++++++++++++++++++++++++++++------
 1 file changed, 108 insertions(+), 18 deletions(-)

-- 
2.55.0

