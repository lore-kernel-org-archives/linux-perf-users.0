Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758A4F0537;
	Mon, 28 Sep 2026 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615571; cv=none; b=bReLvS29Py+sNyTRiEzyufIwJyq23YARAGOdAeZzmkrulO0GNhdjbE2b87B3v1JZpvNkf9kFBEBypI74Fi8v4WVHOSPFGzLEGUSjuxdWf5DQd777yNitemuF2iV96Gf07ZRqrhX3NM4mO6PHreGUsk3d6UknrsJIXPe/gva9nbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615571; c=relaxed/simple;
	bh=DszjBhIvPBrLUaoRZqVa2YNnNfG9LUxLWZ71SacIXOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOhSgltz7HOaaZX1p3mYCIzJmK+hJrhAG25Aej3MBxgbxrrymRFD4bT6DmLA5VMT1LXwUJRB1a+S1EM0vdTbQ+JzcX/LJbtOwmNX7xFsoFU6Yhh0tcStfcs7Rbe3owY468ZDjY95qyH3L6YpqdFxSjXe/NyfZTnex7zBWw0Bzso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWC4/mzW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWC4/mzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2426B1F000FF;
	Mon, 28 Sep 2026 17:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615569;
	bh=98vMqiHnCqnxVm88CFrbF0T6hUCxlg8mp7GTURFeIQM=;
	h=From:To:Cc:Subject:Date;
	b=CWC4/mzWJOhuQKxiK3/y1HKWRlHSInpwb7dagdAJE0M9HQaOLBt/Zgz3s6m+a0x6s
	 cUM24v0/uvQzMkC20gXEzEKmmTkEi1DfJTTDPp27Wa2TOomkCGcsAJUniWzuVOXtSl
	 H1I942k+0/yPnG/Vd1LuJZJzpX+fsSPtcdRnbmfPw8JKY3g1QroDKLVn3JohhWYBUP
	 yrtQtwpSqS1DXJ3mK/nJRSf43QssevT8LMLm7CSq8N2jVU97zmb2iAGUvJ7M74BBH2
	 MZG1SloWzMjaMVrEVxvozNDvUBULPFbDBh1bJnOgtIDn4DwWMuelLOzBp+grwq3O+R
	 JB3dKUr5WXsRA==
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
Subject: [PATCH v2 0/4] perf tools: Add progress diagnostics and a false-sharing workload
Date: Mon, 28 Sep 2026 19:12:40 +0200
Message-ID: <20260928171244.2437283-1-acme@kernel.org>
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

What changed from v1:

  - avoid calling CPU_SET() with -1 when false_sharing runs with only one
    CPU available in its affinity mask. Reported by Sashiko on v1.

  tools/perf/Documentation/perf-report.txt      |  13 ++
  tools/perf/builtin-config.c                   |  70 +-------
  tools/perf/builtin-report.c                   |  10 ++
  tools/perf/scripts/perf-stuck.gdb             | 106 ++++++++++++
  tools/perf/scripts/perf-stuck.sh              | 181 ++++++++++++++++++++
  tools/perf/tests/builtin-test.c               |   1 +
  tools/perf/tests/shell/data_type_profiling.sh |   9 +-
  tools/perf/tests/tests.h                      |   1 +
  tools/perf/tests/workloads/Build              |   2 +
  tools/perf/tests/workloads/false_sharing.c    | 240 ++++++++++++++++++++++++++
  tools/perf/ui/Build                           |   1 +
  tools/perf/ui/progress.h                      |   2 +
  tools/perf/ui/stdio/progress.c                | 162 ++++++++++++++++++
  tools/perf/util/config.c                      | 124 +++++++++++++-
  tools/perf/util/config.h                      |   2 +
  tools/perf/util/ordered-events.c              |  16 +-
  tools/perf/util/session.c                     |  12 +-
 17 files changed, 869 insertions(+), 83 deletions(-)

base-commit: 0ae6fc78c5ce0dfd
v1-head: 45d7917f7e05e8a29828ed5f0bbdc94fc938f79f
--
Assisted-by: OpenCode: GPT-5.6 Luna
