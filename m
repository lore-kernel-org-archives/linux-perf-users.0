Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FEE3CC9F2;
	Tue,  2 Jun 2026 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444641; cv=none; b=GWc28noAQOkVhMdXRuaPNU5bnOf0LI60l6vtQ9nr2dvV4l+7/r/a/Zqrr7dYD2tpT1wYHaeKbV1DM71Zjtky2KHi3QADRVL/9+nYCmQR2ggltbSTnOKHsjBewfRcVItH0Ah0RYVwVkUM2VWpWugnUb1z6v4SKuHHk7i92aMHrLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444641; c=relaxed/simple;
	bh=G+q8nCytOV6+6L0iMP8DmVgcHzWDk/j2vilzhhMEPzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rOhcn1lg/lizz0dmkD9GCjyH9LKDVxfOMHpRKUBBnpESmixB3QHbNsDTM2lpHD5vbQ3Jo5+jnQr6VMV5O88oi5jM0wsyjiEkvQM196say7+NhLr7gZUd8q+LMlQjFz/44Zq0+xI7NJiNYwt9z1sq02/OAw4iEm4wl5JV143ZUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7UGbSkZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7UGbSkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10931F00893;
	Tue,  2 Jun 2026 23:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780444639;
	bh=e4vK6TXVAFwwKCHCpWSRBPwy0k/wktN+9SczqzMDezM=;
	h=From:To:Cc:Subject:Date;
	b=E7UGbSkZel3XHUHgQjH14dqFe4GL3iDnh5f4A7TAauzJ7RyDcqpzEH/5qZlGadoyl
	 F0ED4uKCkyZSIxiKmQ9oq6ygJIZnrItEtsM/MOkSJjNuRUP8nYYh4DY2X3JVrl/23J
	 eDPTzr/P+/kTikltHrQW7T8ZrE0Gl9sZVn9UFnX91M8DDuh8f6RVZuDyLkofdoM2Mj
	 78GzYfgq7JYgPHEGGPQ+TcYaz9Xc09g7TCTpa3Zu4vR/BdNANiX1e4ikGNNMQ+NWaE
	 GcOXchk4lb5L5GSTeMtkj2aNlntYRxrcY47JwXb6xGraPyUiuNtTDsJC9GbU8TIL3v
	 S1m0ThkxENOYQ==
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
Subject: [PATCHES 0/8] perf tools: Diagnostic offsets in skip messages + two hardening fixes
Date: Tue,  2 Jun 2026 20:56:59 -0300
Message-ID: <20260602235709.1541603-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When perf report, perf sched, or perf timechart skip a malformed or
unprocessable event, the warning message doesn't say where in the
perf.data file the problem occurred.  This makes it hard to
cross-reference with 'perf report -D' output or to locate the
corrupted region with a hex editor.

This series adds a file_offset field to struct perf_sample, set in the
event delivery path (including the deferred callchain path), and
retrofits all skip/stop/error messages to include:

  - The file offset where the event was found
  - The event type name via perf_event__name() with the numeric
    type value in parentheses

For example, instead of:

  problem processing 10 event, skipping it.

a user now sees:

  WARNING: at offset 0x1a3f0: MMAP2 (10) event size 24 too small (min 64), skipping

The peek_event() path, which validates events during initial file
scanning, also gains file offsets in its three warning messages
(misaligned size, unsupported type, undersized event).

Two pre-existing bugs found by sashiko-bot are fixed:

  - builtin-timechart.c cat_backtrace(): use-after-free and
    double-free when an invalid callchain context triggers zfree()
    before fclose() on an open_memstream buffer.  The open_memstream
    contract requires fclose() before the buffer can be freed — see
    open_memstream(3).

  - builtin-sched.c: three BUG_ON(cpu >= MAX_CPUS || cpu < 0)
    that abort perf sched when PERF_SAMPLE_CPU is absent from the
    sample type and the CPU sentinel (u32)-1 is cast to signed -1.
    perf.data is untrusted input — a corrupted or truncated file
    should produce a warning, not an abort.

Arnaldo Carvalho de Melo (8):
  perf sample: Add file_offset field to struct perf_sample
  perf session: Include file offset in event skip/stop messages
  perf sched: Include file offset in event skip messages
  perf timechart: Include file offset in CPU bounds check messages
  perf tools: Include file offset and event type name in skip messages
  perf timechart: Fix cat_backtrace() use-after-free on corrupted callchain
  perf sched: Replace BUG_ON on invalid CPU with graceful skip
  perf test: Add file offset diagnostic test for corrupted perf.data

 15 files changed, 261 insertions(+), 101 deletions(-)

Developed with AI assistance (Claude/sashiko), tagged in commits.

Best regards,

- Arnaldo
