Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049D33556D;
	Tue, 11 Aug 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470711; cv=none; b=CjZb8OBAV1AUDYbE+Zn5Ey5LnZ8OWb12LpcYlssjNa1W9PgizSZYpxXfPyhD6//H3n4sL91sR+CKKPgI8+G/3hCC9RoFML7AZG/aN0OYOdCGrYuWMqD/N/XHU1uv480TuqX/qD2TgzcUoqPRtrXHuFr1EgKvkjXwdVBM/Sdn/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470711; c=relaxed/simple;
	bh=A6vYKkUvq1CjxstdkMxQhe3Gx14ufzTvsv/4FqfnQYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LMsC54b/RoE6gkBlj+LezqaehWYdbFd9dgN9cZ2GIn4aFJ5r35hAhJU/3SIBBLGc6k64q2Xnesp/POvgAgoa9MUhWRCZ/whC8oZtd//ZsjfB5a0FfgH7ZLulS8j/RECWU/J5LlQWPZ8wc6EUDE7Iy+zzzxHiYTJDUmxa9doIzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9QUHdhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9QUHdhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100711F000E9;
	Tue, 11 Aug 2026 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786470710;
	bh=YGifN89FBE1oe1ywRIiVhfBrHGzzLvFRzPtl3+pEb18=;
	h=From:To:Cc:Subject:Date;
	b=H9QUHdhy1+2YAX0SbY8w0k2Bl7MvFch7F0x7EISPtr+gjU/ORRgsOG3OpkVpDbOCw
	 X2LVSuFQwksqlgI6FX+KwnoN61Xx9ow4rpwWkUh7oHq4qVfAq75NiWmyds7u4e+dk0
	 yrsWpF6G/4CA0yD4N3wqT4UeaS9WYCSDBwh7/mT+3z9Yq1lNSJzAxpn/qDsVyhuJHL
	 O5a+E6Iu5vwu/D+AqIKGvz3QVLf4v9I8Xje8e7Qd/qSOPuZCeN1EofdIo6w9zLMzR8
	 Zv9FDRN1ywgZIQWiXpv9VrUPUQDL39zMJOiDp4djUF/K7VK8/FMS+8iRaytZRwfrik
	 kRksInKagPNqA==
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
Subject: [PATCHES v3 0/5] perf DSO hardening series
Date: Tue, 11 Aug 2026 14:51:29 -0300
Message-ID: <20260811175140.7235-1-acme@kernel.org>
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

 tools/perf/util/dso.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

base-commit: bf10e6ee2ac3034c9068e03eed418fd16961984e
v2-head: 2f944ea022b6429f
v1-head: f6cb9e46c7b8949b
