Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3A2BDC32;
	Thu, 21 May 2026 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325843; cv=none; b=GMIKH3+eheZsgGS4ie62cU5BeYrXEtRKKD7LpYQHIIEY+HT+V/7JN7YvLOFrRM/20MLl2IaRsyv256d8/ngkTA4lNSvGxbzQKQNxiT0qVPKpGW0WHiT6o3UoVX7Ebf6Q1Tcnl+WoSpYOkmoaZCDOfqZRWpsuJzyTcPWroT5PmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325843; c=relaxed/simple;
	bh=B7130ohT+73rUrRSCIaUHHA0Z3hPVe+wR1sRbweLRZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DNlp3f18h/oV6HuqECTt6mJS26K/a8a2l/5a6Er3V/BCsIR21IiAttpns+K3x/JK9vtW9dm3+R266N21g1F7s/HMhzg+Dld1QuZUvcKAFrY3ygpCekxUrXAgXv8wrTJBl5CZONlQsPAcDgsLpiaMrbRgsZJCxaET6xxvMsqXz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k96KxDCr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k96KxDCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3D81F000E9;
	Thu, 21 May 2026 01:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325841;
	bh=p4IoqGwwr1OOSLVL4TnS6A3gBOz+VohkWjQTjZI9O8A=;
	h=From:To:Cc:Subject:Date;
	b=k96KxDCrdZcoQ9iz9g/MYm7fn5yIZzy+dIxrRtax11fBrqO4PYt9UE/66CsmUI6Al
	 8Ya28CVe5sWt4WlDia7DmRj9ICaSebYoVoODsch4fXHZEs0pPKML5THI9lbyIPCE82
	 Iiy7Q8wc4QdMosNjGoGGIzQTBfkLNx9SXm3l0x4iYa5ghWVquMWj3yaGLhbpOzP5n+
	 kl4yuZDv2JGW7XqfrO0KT8Eo4VXacksSB0OR0Hz5fIoVVG12kzKDPrJtsw/rgjl3NI
	 H12kd7P7TZdjfnuiotHqIH6njF7FhjWSnEWIu5B0GRjRjgrzGKpfzKrVip6+SaQ1pE
	 N5gDWtn2o7e+w==
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
Subject: [PATCHES 00/27] perf.data validation and hardening
Date: Wed, 20 May 2026 22:09:45 -0300
Message-ID: <20260521011027.622268-1-acme@kernel.org>
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

A crafted or corrupted perf.data file can cause out-of-bounds
reads/writes, infinite loops, heap overflows, and segfaults in perf
report, perf script, perf inject, perf timechart, and perf kwork.
This series adds defense-in-depth validation for file parsing:

- Per-event-type minimum size table, enforced before swap and
  processing on both native and cross-endian paths.
- Swap handler return values (void -> int) so handlers can propagate
  errors instead of silently corrupting adjacent memory.
- Bounds checking for string fields (null-termination), array counts
  (nr vs payload size), feature section sizes (vs file size), and
  CPU indices (vs nr_cpus_avail / array allocation).
- ABI0 handling for perf_event_attr.size == 0 across all code paths
  (swap, native, synthesize, read_event_desc), with consistent
  behavior regardless of file endianness.
- Sanitizer-aware shell test: the truncated perf.data test captures
  stderr and checks for ASAN/MSAN/TSAN/UBSAN markers, since sanitizer
  exits use code 1 which otherwise looks like a clean error exit.

Pre-existing bugs fixed along the way:

- event_contains() macro off-by-one (checked start, not full extent)
- zstd_decompress_stream multi-iteration output.pos bug
- zstd_compress_stream_to_records: broken memcpy fallback -> return -1
  + ZSTD context reset + dst_size underflow guard
- PERF_RECORD_SWITCH sample_id_all offset wrong for non-CPU_WIDE
- cpu_map__from_range any_cpu used as count instead of boolean
- cpu_map__from_mask double-fetch heap overflow (j >= weight guard)
- kwork cpus_runtime BUG_ON with signed comparison
- perf_header__getbuffer64 EOF without errno (silent success)
- read_event_desc ABI0 sentinel (attr.size=0 -> free_event_desc early stop)
- EVENT_UPDATE MASK: missing offsetof underflow guard + pr_warning on
  mask32/mask64 validation paths

Additional pre-existing issues were noticed during review and will be
addressed in follow-up series.

Testing
-------

- perf test at baseline and at patches 1, 7, 10, 16, 20, 25, 27
  with 300s timeout -- no regressions detected.
- Build with both gcc and clang at every patch.
- checkpatch.pl on all 27 patches.

Developed with AI assistance in a local loop involving Claude Code and
Sashiko/Gemini, tagged in commits.

Best regards,

- Arnaldo
