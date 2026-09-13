Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69523769EB;
	Sun, 13 Sep 2026 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789266909; cv=none; b=IRMNRRUSM8NIFr2oXMNf292cEhEHuWCW8mQkVxD0kuVWIeUagxVaEqyGgMXzpqpfNA2sSPwwG6U/H+3tnhj4K2d/pxosm6DflfPGfVxJWG3fI5kwQIPBcUU9XkPy1NqBcpL/05uRJ7YIZvlQ/U+87no+GN5CSrgRk4dA/gnUddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789266909; c=relaxed/simple;
	bh=O1aM3BWkaiUhfXkHZPWe6tF0aakG1I8ZC7KgPsZwzPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnDMXNgYI7T1O/2iO9Q230WBSFB0oCQ5nQMP5TFONgubx5ZNT95SGEE2wk0l80rdMndJGrcocXm5t/Ig1+uS4XQDv93xaqaMWQwheZBNmxEkiwbGF6ZPTGauwp+r3xxCqMu/w+2RF5D0ATaIAujEHb4z4y5yTOYIfwSbD47uAj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQuSfeMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQuSfeMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AFB1F000FF;
	Sun, 13 Sep 2026 02:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789266906;
	bh=mPp/Bd35ZfLs8HKviYnCI5F9AuJWDKjg8s8Wu1BeuvQ=;
	h=From:To:Cc:Subject:Date;
	b=QQuSfeMntu4D5hAoIGjZ/4XMZabRIzKEr4CzbAdMZTz5CtYnNwdyCiiftwsHSUFdm
	 DqQ7LO6MyACAM+DCJrVK3W3MNWds3kTQhRBZL9ncUyAVSQySUd/m8c8+di/2OBv2YT
	 di+CQuhBcnLDfqhWWeolZH//JuWad66VszGeC48f8c+/4cdvBG9pKJfTGEwynMRSBp
	 mf8VttWlI92xvoS5CSyc+9UrrQlDgs5DT9HniYTP3b1Xv4awG3+Nz4DJrTEkfxXFzb
	 hOE/JhGY9DWRX/GN20GfuwrBnM2nBXJdIdesWsxDDa31HK0HgBMCccLNhEEr6cprEj
	 uRyMCvNn7Yvwg==
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
Subject: [PATCH v1 0/8] perf tools: Annotate fixes, stdio progress indication, debuginfo-client in more places
Date: Sat, 12 Sep 2026 23:34:51 -0300
Message-ID: <20260913023459.112654-1-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This came out of work on data type profiling, but none of them depends on that
work and nothing in this series needs anything from it, so sending them
separately.

The fixes:

  - 'perf report -s type' spins forever, burning all of a CPU with no
    output, on the dwz compressed debug info of zlib-ng (libz.so.1):
    die_collect_vars() saves the dwarf_dieoffset() of the type DIE,
    which is relative to the file that DIE lives in, the dwz common
    file for the types shared by more than one CU, and resolving one of
    those offsets in the main debug file does not fail, it parses
    whatever is at that offset there, in this case a typedef whose
    DW_AT_type refers to itself, which is what makes the "follow the
    typedefs and qualifiers until a pointer or an array type" loop in
    die_get_pointer_type() spin.  The offset is now resolved in the file
    it was recorded as coming from, which the CU of the collected DIE
    tells exactly rather than having to be inferred from what is at the
    offset, and the type chases and the struct/union member nesting are
    bounded, so a debug info file broken in some other way makes perf
    give up on a type with a pr_debug instead of looking like it hung
    (patch 7);

  - the data type browser prints, in its samples view (-n,
    annotate.show_nr_samples), a local variable initialized to zero and
    never updated, so every member shows up as having no samples while
    the period and percent columns for the same entry are filled in
    (patch 4);

  - the 'perf data type profiling' shell test turns "this PMU cannot
    record these events" into a test failure: the script runs under
    'set -e', so the bare 'perf mem record' aborts it through the EXIT
    trap, which reports a signal that never happened, instead of
    reaching the code right below meant to report the failure (patch 1).

The features:

  - 'perf report --progress' prints the phase it is in and how far
    along it is to stderr: the TUI shows that with a progress bar, but
    in the stdio case the ui_progress updates that are already there are
    dropped on the floor.  It is what makes a slow run tell itself apart
    from a stuck one (patch 5);

  - the debuginfo for a DSO, and the kernel symbols, can now be fetched
    keyed by the build ID recorded in the perf.data file, using the
    debuginfod client, for the cases where they are not available
    locally under the name the DSO was opened with: a vmlinux for a
    kernel that since got upgraded, or a profile recorded on another
    machine.  Both are off with --no-debuginfod, with
    core.debuginfod=false, and when the build-id cache is turned off
    (patches 2 and 3);

  - 'perf mem record' asks for PERF_SAMPLE_CPU by default, as without
    it the cpu field is the (u32)-1 "no CPU info" sentinel and
    per-sample analysis cannot tell accesses from different cores apart
    from same-CPU traffic (patch 8).

Which file a saved type DIE offset belongs to is settled with
dwarf_cu_getdwarf(), new in elfutils 0.160, so the libdw feature test
now probes for it and the message in Makefile.config says 0.160 where it
said 0.157: 0.157 to 0.159 is from 2014 and has no such symbol, and
those versions now lose dwarf support with that message instead of
failing to link util/dwarf-aux.c.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (8):
  perf test: Skip data_type_profiling when the PMU cannot record memory
    events
  perf debuginfo: Fetch debuginfo keyed by build ID using debuginfod
  perf symbol: Fall back to fetching the vmlinux by build ID
  perf annotate-data: Show the sample count in the data-type browser
  perf report: Add --progress option
  perf scripts: Add perf-stuck, to tell where a running perf is stuck
  perf annotate-data: Resolve type DIEs in the debug file they came from
  perf mem record: Request PERF_SAMPLE_CPU by default

 tools/build/feature/test-libdw.c              |  15 +-
 tools/perf/Documentation/perf-annotate.txt    |  10 +
 tools/perf/Documentation/perf-config.txt      |  19 +
 tools/perf/Documentation/perf-mem.txt         |   4 +
 tools/perf/Documentation/perf-report.txt      |  28 ++
 tools/perf/Documentation/perf-top.txt         |  14 +
 tools/perf/Makefile.config                    |   2 +-
 tools/perf/builtin-annotate.c                 |   2 +
 tools/perf/builtin-mem.c                      |   9 +
 tools/perf/builtin-report.c                   |  17 +
 tools/perf/builtin-top.c                      |   6 +
 tools/perf/scripts/perf-stuck.gdb             | 104 +++++
 tools/perf/scripts/perf-stuck.sh              | 165 ++++++++
 tools/perf/tests/shell/data_type_profiling.sh |  46 ++-
 tools/perf/ui/Build                           |   1 +
 tools/perf/ui/browsers/annotate-data.c        |   2 +-
 tools/perf/ui/progress.h                      |   2 +
 tools/perf/ui/stdio/progress.c                | 162 ++++++++
 tools/perf/util/annotate-data.c               |  55 ++-
 tools/perf/util/annotate-data.h               |   3 +
 tools/perf/util/config.c                      |   3 +
 tools/perf/util/debuginfo.c                   | 372 ++++++++++++++++++
 tools/perf/util/debuginfo.h                   |  36 ++
 tools/perf/util/dso.c                         |  19 +
 tools/perf/util/dwarf-aux.c                   | 161 +++++++-
 tools/perf/util/dwarf-aux.h                   |  33 ++
 tools/perf/util/ordered-events.c              |  17 +-
 tools/perf/util/session.c                     |  12 +-
 tools/perf/util/symbol.c                      |  40 +-
 tools/perf/util/symbol_conf.h                 |   1 +
 30 files changed, 1307 insertions(+), 53 deletions(-)

base-commit: aa18964dd64511305de0711fed912054da6f5d18
