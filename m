Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197526;
	b=YvFMgOtbW6bbdHv4K5/Hp2GBQADQZIbSCv+Ycw3lZQ0xKJEgvZ7T/LdQYW43MJ6PkMsP
	 xJFlvLGGUf5V1BHU/gbz0EZwhB+7ZOJQivZSrQg3GdGC8A/7qCSoLTnYkkz5TTHkeV2Bl
	 d0QuKIPUPy19WHdSvE8vdiRUAk53biinh6uTyFneD64OxrxK3Ogx3So0frSj1YANavdrK
	 IAvU4kV7FP0OEtludZ2Pwfobwt3v4KffVrSGAM70U8wH5K1mYGhz9iRkUQ749uNm5il0i
	 KNN8bAJ2WFOwnfTsESAOIj6k/eYZef0ya/3EWoCbyda0v/tGX4VOoRwCth6rSjQpGAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=T30OloEed+5ksnOk+6k3bS3hGIzHHhaTnjHcUwk/mxY=;
	b=IVf6ul2kXZNEp1WGg/xCJNJQOcQp5rjSuC11yny9Hbih5Sr+SCqih2DciBCXB5kveDF+
	 beD5YHAVemGy03TgKGwhVR+pZl/e4ItApNOODu0urbYTfXxjSU63EpAO0jGvUW93YugMM
	 jmtGUma3YvTxi27vJYNjKhwVgQvLfS09OQ240gtZ8zJ14LcF2wrCWTUf6wvpWSeiV87uw
	 atYJ/mxdUUaHKZ9g0mmsJKs8G/i/vGkoughnXw0jybzN++ERjmVOPyqFMj7JJOaKAc8ql
	 6sGglaqtPeIqpDWv0FU+0qbGuW5+WgkU88znafcNFWuYMg0dvk2hhr6gmx7TnrET+iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6u2fa1l;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF88606A338
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 17:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FF88606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F6u2fa1l
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so1406055c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795197524; x=1795802324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T30OloEed+5ksnOk+6k3bS3hGIzHHhaTnjHcUwk/mxY=;
        b=F6u2fa1lyX9Lc7JQd3SjTC4E0Jyzu6C8Ybwf/0KzsAf50nLmj1A32kaiCOdyEKjNO+
         vl8KEhw7bmKTvKk7o2fJ0qphLf6Cw2MNccrIlc9CPXQPxrskn3R+N76kmjO9KMFPJw2P
         L6whiXA3C7LMYbN7mfyAGsDFQO3Bi//KQWn4ZcLK91hFjq0j4Vxx0G8MKCkPzoxsNs9r
         qnh47Tvdv2tpqvIqoF5r9SxbvKdxdPHTemkQLhpMyUpgZuRxsd0CrNMyy3ZRctBrDGMa
         CxHYUBgjnYnhyFQXVWw1/D9pVQ0ApQBAjcj88SrhBmJRJhjm4Csh/Qk5aDM9BYmh6PR3
         OQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795197524; x=1795802324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T30OloEed+5ksnOk+6k3bS3hGIzHHhaTnjHcUwk/mxY=;
        b=SA+pwZqoQ8jT3mWM5oHrXW8cKyQ+CjbA+f7vuFNjTySFhTJJoi1xmZXBcv2IR6Y4uj
         83jebKO5mCGtNj1cQHoR5VgkGPaOO+I5lrceRJGQdnlmIeh5ETlPUPuKeSUbWGiCJjHn
         WeDLlRnZ9qu+du+4plFC0F1xCtx1Lm2JL8fj8JO84Z06ORgfumuWcYFSFAF3FqzrS54B
         bi0VmFf08DkNBAyvQFUTKIDkeAISw4cE1NO9h54XIW8WahpHWoGoTeSMzxElzAv6kDMk
         sxmVaCl9gkqCU903Y2QOzq8z882i7CSP3ApYMPc+oJU5LWPFAk4tmKp/FIuls78wcudQ
         Wmzw==
X-Gm-Message-State: APuU4Z9FaKOTG6TFYBsu0sI8PQ6SM8erzDn4fCEZHJ9hIEdw4KTBxZOd
	iOpGYRG7BQVOo8Pn2Iem/OV7TZO/xVsSbBvAKiCHpWqG8kizvYSQ3UhlN9UjQa6T
X-Gm-Gg: AYBFou2NmzEZpHEgEz7DSxuozINtYGY9ac2LLgE73NGkVFuHb4FJ0dPRjsYDMT00euz
	EDlSluH9GXLgz5e4a7upgGhhplTuEGCI4y0IHKBgXvx5Kcwd0BU3BJYv94Cys9LDgsCkbK9xGPc
	OPgeJBDd7I0Ms4J8VMxZhCGpBw6TXRQf5ZALA2g7iUfD8Ixtsag8WR0k8mUXWcdiUBBGQtjKSd1
	rZAlV/F5sTNfVSulO+Cj5D2vATVZ5jJse8Vbo84AkPRp5nvLs694L6YbgubJHZRb3y4ej+fh022
	dZOHAeMZJ+v26PrJb684eixWZvvtAbuf3BRco8OGmo+ltOClAf1tlWHdPFA0JdONWqsfvpcVff6
	Ars4DLqHc0MSoMKnfNEwBQLkyMLmS38JTFn5GZma7ceaIihIiaYociLnAqFIdiuZv9g3y8M6Uma
	brUDZerXytqaofYnBwEC7AkaG9A6t0tOEyZJpL+Rs9Feg9ikJ3e7Lriuhjh0isaCMTP3VA1zxfA
	sDQIb5JxWKpF+g0p1tjuyIjvo0xWVqwHpeXK0JK4yoWOy87iyM2y7Jinw+qL6jUIDBxgikqDtf9
	H9Il+MpktGZKy0MkMaGXc+H5x4yTk3/urPks/Z06TA==
X-Received: by 2002:a05:7022:b909:b0:1b4:f3af:355e with SMTP id a92af1059eb24-1b5568a660emr3282155c88.13.1795197524183;
        Fri, 20 Nov 2026 09:58:44 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm681084c88.5.2026.11.20.09.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:58:43 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH 0/3] perf vendor events: Fix misspellings in event and metric descriptions
Date: Fri, 20 Nov 2026 17:58:37 +0000
Message-ID: <20261120175840.1274637-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PMU event descriptions shipped in the JSON tables under
tools/perf/pmu-events/arch/ are printed by `perf list` (BriefDescription)
and `perf list -v` (PublicDescription) as they are written, and the metric
descriptions in the metrics JSON files are printed by `perf list metric`.
A number of them carry misspelled words, so the misspellings reach the
user.  This series fixes the first batch of them, which a spell-check pass
over the power8, power9 and power10 tables and over the Intel and AMD
tables turned up.

The three patches are split by vendor because that is the convention for
the subject prefix in this tree.  Of the 989 commits that touch
tools/perf/pmu-events/arch/ as of 65e4fd942f72, `perf vendor events
intel:` has 391, `amd:` 37, `powerpc:` 8, `arm64:` 83, `s390:` 18 and
`riscv:` 13.  No commit with a vendor prefix touches another vendor's
tables.

The arm64 tables have misspellings of the same kind ("misprediciton" in
the ampere tables, "executed.This" in the cortex-a55 tables); the s390
and riscv tables contain none of the words fixed here.  More remain in the
tables this series swept and in others -- "conjection" and "banwidth" in
the Intel uncore tables, "pumpfor" in power8, to name a few -- and those
are left for follow-up patches.

Each patch touches description strings only, and each was checked by
regenerating the tables with

  jevents.py <arch> all tools/perf/pmu-events/arch out.c out-str.c

and diffing the result against the one generated from the parent commit:
every event name and event code is unchanged, and the misspellings are
gone from the generated string table.  out-str.c shrinks or stays the same
size, because some corrected descriptions become identical to descriptions
already stored for other models, and the amd fix swaps a word for another
of the same length:

  powerpc  13 files, 55 lines changed   out-str.c -393 bytes
  intel     5 files,  5 lines changed   out-str.c -477 bytes
  amd       1 file,   1 line changed    out-str.c size unchanged

65 PublicDescription values in power8/other.json end in "42"; the trailing
"42" is not a misspelling, so it is left alone.  The word "ibufffully"
in that file is left unchanged as well: the BriefDescription of the same
event ends with "ibuff", so the boundary is clear, but whether a space or
a full stop belongs after it is not.

Written with Hermes Agent, an LLM assistant: it found the words and wrote
these changelogs and this cover note; the author reviewed every change and
ran the generator as described above.

Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

TAKANO Mitsuhiro (3):
  perf vendor events powerpc: Fix misspellings in the power tables
  perf vendor events intel: Fix misspellings in the Intel model tables
  perf vendor events amd: Fix a misspelling in the amdzen3 table

 .../arch/powerpc/power10/metrics.json         |  8 ++--
 .../pmu-events/arch/powerpc/power8/cache.json |  2 +-
 .../arch/powerpc/power8/memory.json           |  2 +-
 .../arch/powerpc/power8/metrics.json          |  8 ++--
 .../pmu-events/arch/powerpc/power8/other.json | 38 +++++++++----------
 .../arch/powerpc/power8/pipeline.json         |  4 +-
 .../pmu-events/arch/powerpc/power8/pmc.json   |  4 +-
 .../pmu-events/arch/powerpc/power9/cache.json |  2 +-
 .../arch/powerpc/power9/frontend.json         |  2 +-
 .../arch/powerpc/power9/marked.json           |  4 +-
 .../arch/powerpc/power9/metrics.json          |  6 +--
 .../pmu-events/arch/powerpc/power9/other.json | 28 +++++++-------
 .../arch/powerpc/power9/translation.json      |  2 +-
 .../pmu-events/arch/x86/amdzen3/branch.json   |  2 +-
 .../arch/x86/nehalemep/pipeline.json          |  2 +-
 .../arch/x86/nehalemex/pipeline.json          |  2 +-
 .../arch/x86/sierraforest/srf-metrics.json    |  2 +-
 .../arch/x86/westmereep-dp/pipeline.json      |  2 +-
 .../arch/x86/westmereep-sp/pipeline.json      |  2 +-
 19 files changed, 61 insertions(+), 61 deletions(-)


base-commit: 65e4fd942f72a9dba0e4e257290c4fa1aa756854
-- 
2.53.0

