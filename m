Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C22D470E80;
	Wed,  5 Aug 2026 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936675; cv=none; b=iWWA+0KI9N3is9R4WueCQwhUIbfEnwfse6YkZysrSFPLwkx3iZpTOFguAnvwMLzxlO3x/ZXASjLd5ryXxlDAHm+gDCUUjEilB1JPHKbspvFWb/7cZKwCEiKkI1O6/1dS4kyKOzXcQDMYvgr+2WZ44/Eg3QPserRiBJYlhYiBNlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936675; c=relaxed/simple;
	bh=AaiQocPWzjvGAnonGxzCXCx+QTDR/DOgASAoEnpJeJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GH80zWYV+ParHTDGqAzY1QLvGMDozEUQeRUI5nJ4LCbP6vgVodkXXrVlsmMBWq1I3iClPNNwt2prZCVQw//fpp7On+hdgU6OFi/qYuHXr5TSVtpIsLDWLLcymZ2/Al7sKR00rCr0SrY1Ir3/mGnqL5kjz0zLxWPqAaBE48EEUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjFuNxhl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjFuNxhl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7FD1F000E9;
	Wed,  5 Aug 2026 13:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785936674;
	bh=80D+nvxSeTZ+CGgImaTN20pak6QduXw6XFmzHitXiLY=;
	h=From:To:Cc:Subject:Date;
	b=HjFuNxhlk8y0DbCvVNymyLyEi9ONVg3+gQpA1gP+p8te1nyeNglExM3KKqIDs0ztl
	 lvix3Z0GcEU9Ea6Itz0FLoLJImaNJ3fnYgFA+iNsN4kDc6Q0E1IzwqWleTW8zBfDQp
	 LE5i5XOOw0gFTcBvOWrM/4PjZPS46zrPkVoFf6H/9BsXugrJMQ92xWGD/jcfwJ4EEX
	 WkRkJsoRVGIvdikjLBba/uVKiZwr6xY1jm+Yd0kjyzkHnelH705Noi255RZHT2MbTJ
	 LSWCBapsUU/MTOhpbaZuaeE7S99u+t3OIdgr5MIechow24oYKsQMmdueqQoa03+UTY
	 tt555zE8sTbug==
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
Subject: [PATCHES v1 0/12] perf jitdump: Input validation hardening
Date: Wed,  5 Aug 2026 10:29:59 -0300
Message-ID: <20260805133013.235016-1-acme@kernel.org>
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
  - Check the snprintf() return before computing the header size

  Stream and record handling:

  - Fix the extended header read that always failed, causing records to
    be misparsed
  - Use dirname()'s return value in jit_open(), fixing ENOTDIR failures
  - Fix funlockfile() being called on an unlocked stream in the
    jit_open() error path

  Resource management:

  - Free the event in jit_repipe_code_move()
  - Fix debug_data and unwinding_data leaks when records are overwritten

Each patch includes a Fixes: tag pointing to the offending commit,
dating back to jitdump mmap injection support (9b07e27f88b9cd78), source
line info support (598b7c6919c7bbcc), and unwinding support
(0284fecd13b6db3e), all from the original 2016 jitdump work.

Testing: Built and tested on x86_64.  No existing tests cover jitdump
parsing with malformed input; test suite expansion is left for future
work.  The final series was re-reviewed after the fixes (build-checked,
Fixes: tags verified); no regressions found.

AI assistance: This series was developed with assistance from Claude
(claude-opus-4.6) and Opencode (mimo-v2.5-free) for code analysis, patch
generation, and commit message composition.

Best regards,

- Arnaldo

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

 tools/perf/util/jitdump.c | 126 ++++++++++++++++++++++++++++++++------
 1 file changed, 108 insertions(+), 18 deletions(-)

-- 
2.55.0

