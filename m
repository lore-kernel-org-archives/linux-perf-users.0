Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8574562AF;
	Tue, 11 Aug 2026 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468332; cv=none; b=gHqDnAeBSnJGYO95nEuzH9j3Bg1mD11jyPcBNFrVFmVbnaHKgZSsqO5i34JRSMu+i9GKSKEs9b/XJyqBwnutc0s7UZ8Sbhl+4X6F6nOvQFXUmrPiH824OOvE+sChXMIrilvxQn0WoFB5AlJ1MOIkQf2maD3dSAQ0e3U2bEE0XjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468332; c=relaxed/simple;
	bh=gOupKlz0y8Z/13T+u2mLQhXCYwIbAa3SnggMxBFffCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdkPnzm1E17TFTgRPaDtDz3ebhSYR2N/KrLsoJPsBfnys/pB1HNZYDANf4pN7I24S8JbISaDOoJrpXpIRpTIi1jYen9YU9+aiCZPusGbQLkvtTK6dI2S47tQ1bTKrNeaoIq7vUylc7aBNuYI3DUegTZ2eDfhPvVTu9NwkjmiOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV7/wAzY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV7/wAzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2031F000E9;
	Tue, 11 Aug 2026 17:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786468331;
	bh=D8fgb1Z9cXzmLF/QL6FOmUFab+vJ5ypwETPBMl/d1zM=;
	h=From:To:Cc:Subject:Date;
	b=TV7/wAzYsoGwsx5iNBb/EDTYf8V4L9Fledh0PvG7XXxtS+5ANTJlPvMMlpOEWk+3t
	 iQWhZx90KHnxRFJ4LRK8ih5H5GDRLVJU4XPhMKzu+bgzkimCLLdcPpK5kQjKTaMzox
	 a/w0dhulS0IwiLhHsp/ws22UUniCADO44kEhkFSYVZHrzxB+jmQDt3krZkvy3Np9v+
	 w25zHv4feDDjL4ildGPL/HEpUBTUbVhotE+9UavL8tOYABpN+I0q4PQ5y/J45269EW
	 emN8jdF75DYprEkKk4KwBTEGYod4uWuAEf4suXuMZezxaYanuDRNfgiYR7oO4K7KFO
	 gZQn59thw9v/A==
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
Subject: [PATCHES v2 0/5] perf DSO hardening series
Date: Tue, 11 Aug 2026 14:11:55 -0300
Message-ID: <20260811171200.30096-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

  - file_read() reads the stale global errno after try_to_open_dso()
    fails, when by then errno has been through mutex_lock(),
    nsinfo__mountns_enter() and several open() attempts;

  - dso_cache__memcpy() underflows when cache->size is smaller than the
    RB tree offset (short pread), computing a huge memcpy length;

  - dso__read_symbol() asserts on an input-dependent condition instead
    of doing a runtime check, keeping the BPF metadata safe from crafted
    input.

Best regards,

- Arnaldo

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
  perf dso: Guard against cache underflow on short reads in
    dso_cache__memcpy()
  perf dso: Replace assert with runtime check in dso__read_symbol()

 tools/perf/util/dso.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

base-commit: bf10e6ee2ac3034c9068e03eed418fd16961984e
v1-head: f6cb9e46c7b8949b
