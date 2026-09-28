Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63F4E2F2B;
	Mon, 28 Sep 2026 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612579; cv=none; b=E1rzxHPDhhpoPw8Pj8RdUB+CyI541eP4QXsmMN61zL4MBJu//vBWgNzb5WSMOYrNFX5u9y2DGE/2Ctjx5jZRo2z1Iet0PUMK4+NKHX0WAYOeAlhzKtyRwlLE6UHKJ2ZC37bZZH5uzeVzhVRNLTchxhi+8p5xBlmpzDfCEoRFByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612579; c=relaxed/simple;
	bh=KxN6Q1vV5UdrZpGl+MfXUI6bNX/ZKYmoEYI9T90YuVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CslNRMxmHFs5YxluqgAVuEiJ9Qa2xfjPaVDcmITRhYmGFhqDBDFNFGPhVL7CScQOcH/RLR2EnXxr22zmIdmB8riMoGmb0qXLeJDBnG98W0vyqmxf97fe6fm5rdE8jOsrL8lRE5nLiJ+qyzPJs3I9gPajLPjvea/RmvVUEZpXr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeFxsNsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeFxsNsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5051F00898;
	Mon, 28 Sep 2026 16:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612577;
	bh=GLJWPR3aBhSFwMqtwCGVT1yMKv0qBbK0mLQzOD4EGyI=;
	h=From:To:Cc:Subject:Date;
	b=YeFxsNsdfTwVeHvx3hT7rkNJbskmdO7T1EuAgGac6ncDXZkaviWjlTGhn75g9rOVr
	 VUjC8WMkIj7GoUPp5mZPfoqvQBY/XcWTUKDUzKc1OixeJu63ImAgJeFnhkkLzTnI8X
	 d3YHnlJ4S21YNGp45RaN0G7AsetREFsmh/rqa+pLAKQI4BXHf8yLv0Wpm9fE4ZbNfV
	 g6js25JSSpmjF7/bue94G+csclAggq82ExC+sR4s+0K7xM2bgTJzC0+2Kl+5cpLsJU
	 HzfFEqsCXB8ECLVJEzMCRIVWR5izktVybihfkPmo2liF5zqvvY33Saq1q9Bcdg3n3v
	 mfjasWwWxYhAg==
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
Subject: [PATCH 0/4 v1] perf tools: Add progress diagnostics and a false-sharing workload
Date: Mon, 28 Sep 2026 18:22:46 +0200
Message-ID: <20260928162250.2413383-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds progress and stuck-process diagnostics to perf, and a
workload that makes false sharing visible to data type profiling.

The changes are:

  - move perf_config__set_variable() to util/config.c and serialize config
    parser and read-modify-write state, so non-builtin perf code can persist
    configuration changes safely;

  - add 'perf report --progress' for stdio users, showing the current phase,
    percentage, and counts while a session is processed;

  - add the prototype tools/perf/scripts/perf-stuck.sh helper, which samples
    a running perf process and can invoke the accompanying GDB commands when
    progress stops;

  - add 'perf test -w false_sharing', a synthetic TCP-shaped workload with
    identity and packet counters sharing a cacheline, and include it in the
    data type profiling shell test.

The progress backend handles nested phases and completes them on error paths
as well as successful paths. The false-sharing workload uses a shared
volatile instance so the data type profiler can resolve direct accesses to
the individual members.

The perf-stuck helper is intentionally a prototype and requires the usual
/proc access; its optional GDB mode additionally requires gdb and suitable
debug information. When only one CPU is available, the false-sharing
workload warns that it cannot produce cross-CPU traffic but still runs.

Best regards,

- Arnaldo

 tools/perf/Documentation/perf-report.txt      |  13 ++
 tools/perf/builtin-config.c                   |  70 +-------
 tools/perf/builtin-report.c                   |  10 ++
 tools/perf/scripts/perf-stuck.gdb             | 106 ++++++++++++
 tools/perf/scripts/perf-stuck.sh              | 181 ++++++++++++++++++++
 tools/perf/tests/builtin-test.c               |   1 +
 tools/perf/tests/shell/data_type_profiling.sh |   9 +-
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/tests/workloads/Build              |   2 +
 tools/perf/tests/workloads/false_sharing.c    | 236 ++++++++++++++++++++++++++
 tools/perf/ui/Build                           |   1 +
 tools/perf/ui/progress.h                      |   2 +
 tools/perf/ui/stdio/progress.c                | 162 ++++++++++++++++++
 tools/perf/util/config.c                      | 124 +++++++++++++-
 tools/perf/util/config.h                      |   2 +
 tools/perf/util/ordered-events.c              |  16 +-
 tools/perf/util/session.c                     |  12 +-
 17 files changed, 865 insertions(+), 83 deletions(-)

base-commit: 0ae6fc78c5ce0dfd
--
Assisted-by: OpenCode: GPT-5.6 Luna
