Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953E5320CD1;
	Thu, 13 Aug 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633915; cv=none; b=jAty6e1Yn/BKBCzlKQQn9tK7nbZ0fRhOfa5K82U0a6O91NwQAiQke0cOmKF8N1fMAaSb+eWIlvw/OGL7djSWckcwruGBh6LBUslmO1JTaacnBxRkYVw9iR9mrzU5IdjU3Y1NjXcFdd3mtbmKdQTeQFr6z/RycKw7J2nFDJexdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633915; c=relaxed/simple;
	bh=jQ8YktkY5zNRJxfk9+Grzx3ZSKFytA/m/HuOk1aYUo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ee7zi9xA37ohC8tH3Vw1n+xx2vyTr7DNF5/gsl9AQbzH7dJ41MavRYAgjsjOgXTc6v5wQoHJi1YCaTFzxBX9tI9Og7VwFGaBIL9aBNu4mWDkFALn9qKeaGrufWpkfvhpm+qxu1Qhtf8qiP1sywhj+PnMDnt777yc8ijCAoc3rro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEFVjJK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEFVjJK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7507B1F00A3A;
	Thu, 13 Aug 2026 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633914;
	bh=gNcZHIKN/IEQlini10YBe8Fxy1gNh75xXuVSYjAv+VU=;
	h=From:To:Cc:Subject:Date;
	b=CEFVjJK71Zbk/OQ1lpGFvkIxU/883H+GhsUbz/V7ZP08lBN8dEH4biuXlyn3evLpH
	 sRfkVJRngfuqHweVf8BDXS/6nV9aCGgjCTAE0qzJqG2bfCbSjsO2ZQqQ73zvaOynon
	 4FqC2UgwAmB53sT/lvnBiJdAV4Hdh8d+jgEYPGvgap2F7KBkN4dCNbH9mZMLnCXZvy
	 T8QeG0mhPmpMkrc76OqyECyC38fpSaJBLotiHGzOCiIMZJZxKipaOoo8TIuu9raOR5
	 XyBoxBRwlNi6B41RnxWJcAzpw12YzQ/P0+wLgpsSSgT/MwXXrIj/cq9qAh4kI7Y6vs
	 3QCTTFLzKxwSg==
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
	Song Liu <song@kernel.org>
Subject: [PATCHES v5 0/5] perf DSO hardening series
Date: Thu, 13 Aug 2026 12:11:41 -0300
Message-ID: <20260813151148.23169-1-acme@kernel.org>
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

Five hardening fixes for the perf DSO data handling code path, all found
by the sashiko-bot AI reviewer:

  - __open_dso() can return a file descriptor of 0 (stdin) when
    dso__get_filename() fails without setting errno, so fd = -errno = 0
    looked like a successfully opened DSO;

  - dso__decompress_kmodule_path() calls close(fd) with fd = -1 when
    decompression fails or the DSO is not compressed, clobbering errno
    with EBADF on the error path;

  - file_read() and file_size() read the stale global errno after
    try_to_open_dso() fails, when by then errno has been through
    mutex_lock(), nsinfo__mountns_enter() and several open() attempts;

  - dso_cache__memcpy() underflows when cache->size is smaller than the
    RB tree offset (short pread), computing a huge memcpy length;

  - dso__read_symbol() asserts on an input-dependent condition instead
    of doing a runtime check, keeping the BPF metadata safe from crafted
    input.

Best regards,

- Arnaldo

What changed from v4 (6b06155e7794e6af):

  PATCH 1/5:
  - Kept errno = ENOENT for the callers that check it after a negative
    fd, but dso__get_filename()'s chroot fallback now re-stats() and
    only takes the chroot path when stat() actually failed with ENOENT:
    a successful stat() on a non-regular file (e.g. a directory) leaves
    a stale errno, which the try_to_open_dso() fallback loop could
    inherit from the forced ENOENT and wrongly send down the chroot
    path [sashiko-bot review of PATCH 1/5].

  PATCH 3/5:
  - Dropped the assert(ret < 0) calls and the "fd is always negative"
    comments added in v3: the enclosing if (dso__data(dso)->fd < 0)
    already guarantees ret < 0, so they — and the <assert.h> include
    the asserts required — are gone [Namhyung Kim review].

  - All 5 patches: moved Reviewed-by: Ian Rogers above the
    Assisted-by/Signed-off-by trailers with no blank line, fixing the
    trailer layout issue seen on the last submission.

What changed from v3 (41ed39bf2dac1d80):

  PATCH 3/5:
  - Added assert(ret < 0) after ret = dso__data(dso)->fd in both
    file_read() and file_size() to verify the comment that fd is always
    negative, never 0 [Ian Rogers review nit].

  - All 5 patches carry Reviewed-by: Ian Rogers.

What changed from v2 (2f944ea022b6429f):

  PATCH 3/5:
  - file_size() now also uses the stored fd error instead of the stale
    global errno on open failure; the commit was retitled to cover both
    file_read() and file_size() [sashiko-bot review of PATCH 3/5].
  - Comment corrected: on failure dso__data(dso)->fd is always
    negative — -errno from __open_dso() or -1 from do_open() — never 0.

  PATCH 4/5:
  - Clarified that returning 0 for an offset past a short-read chunk
    is EOF semantics — for a regular file a short pread only happens at
    end-of-file, so 0 is what a direct pread() at that offset would
    return — not a cache-miss that triggers a re-read; comment and
    commit message updated [sashiko-bot review of PATCH 4/5].

  - The lockless dso cache RB tree lookup vs. concurrent insert
    question raised in the same review is pre-existing; it is recorded
    in tools/perf/TODO.hardening (item 175) for follow-up work, with
    no change to this series.

What changed from v1 (20260802142022.154219-1-acme@kernel.org):

  PATCH 1/5:
  - __open_dso() now sets errno = ENOENT directly when
    dso__get_filename() fails with errno == 0, instead of only computing
    fd = -ENOENT.  Callers that check errno after a negative fd (e.g.
    file_read() returning -errno) no longer get 0/EOF for an open
    failure [sashiko-bot review of PATCH 1/5].

  - Rebased onto the current perf-tools-next head (bf10e6ee2ac3034c).

This series was developed with assistance from Claude (claude-opus-4.6)
and Opencode (deepseek-v4-flash-free) for code analysis, patch
generation, and commit message composition.  All changes were validated
by the maintainer.

Arnaldo Carvalho de Melo (5):
  perf dso: Guard against errno==0 when dso__get_filename() returns NULL
  perf dso: Guard close() against invalid fd in
    dso__decompress_kmodule_path()
  perf dso: Use stored fd error instead of stale errno in file_read()
    and file_size()
  perf dso: Guard against cache underflow on short reads in
    dso_cache__memcpy()
  perf dso: Replace assert with runtime check in dso__read_symbol()

 tools/perf/util/dso.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

base-commit: bf10e6ee2ac3034c9068e03eed418fd16961984e
v4-head: 6b06155e7794e6af7d2f0901d75a8d8a8607f030
v3-head: 41ed39bf2dac1d80
v2-head: 2f944ea022b6429f
v1-head: f6cb9e46c7b8949b
