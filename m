Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76CE17E8E2;
	Tue,  4 Mar 2025 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055319; cv=none; b=e7MmMHT0ZwU3HqX4kEExwf5vLXyFA2wZPpR1NPUMavQLTvylE4Aj0OkybvFkZJ/dIXalBtF21a9iiMPaPhgrsqwNJa0rTLpB7OpzxBYgsUdGej9WZ90wUGTEKiRm7T3BGci899BP2NQ9H9IW9jisPnyruIDAetM2tQCzDZVbl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055319; c=relaxed/simple;
	bh=rwCfUW7C4HY0wbpATaOXx9/rv2Bnood6YgX7DTIdI4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLm1qZ1F3WtDjEH1PbeCzriNWEcCymLAX0qUH1yulBlUgka0lSCMKbnlFl4gzDXWu2sbx38oVkesotLnCEyiInhrByEZ8C6lchG22WzUYM4O7G7hadmwYvee3GHZmDq1Qhabb8h8nm3nJwlPb2+7v33hPO4t56BaSZ/KUa5snHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqc56+vm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqc56+vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF4CC4CEE4;
	Tue,  4 Mar 2025 02:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741055318;
	bh=rwCfUW7C4HY0wbpATaOXx9/rv2Bnood6YgX7DTIdI4U=;
	h=From:To:Cc:Subject:Date:From;
	b=Iqc56+vmPbMmJuES27Kxh8lTq/HhlmzJl17Jzgzx8Bmo3mZo/l2vgmV+AoAkGOkch
	 TmNluSpckRkBHuRbwXsq+7gNHkUwe30jhn508DXXp77ivicUvOPIg8T21MTHm2dqmS
	 nHvZoZT0m+kVGuFJUOhvR/Er+nKStCViwX38Z9SMOQKTxIkizEamNCUruwQf0rHGFZ
	 mfCCUcwk66sn96MxWUoXQzo93mJSqyptjRT1RlUGwqsFOdV4N8dDllXHbbsKuElTnr
	 FKuhxtDGYO/ckG29Mb4dFpuPGuPtk6hO/SCic/4XwLITaXgRt8hXYfdFOTuCV2AfMo
	 yGlFDP3gZFP1Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/6] perf test: Small improvements
Date: Mon,  3 Mar 2025 18:28:31 -0800
Message-ID: <20250304022837.1877845-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is an assorted list of changes in the perf test.

I've added perf stat --metric-only test and perf trace record and replay.
And other changes to skip privileged tests for non-root and simplify
data symbol test.

v2 changes)
* fix shellcheck errors
* simplify datasym test with timeout

Thanks,
Namhyung


Namhyung Kim (6):
  perf test: Add --metric-only to perf stat output tests
  perf test: Skip perf probe tests when running as non-root
  perf test: Skip perf trace tests when running as non-root
  perf test: Add trace record and replay test
  perf test: Add timeout to datasym workload
  perf test: Simplify data symbol test

 .../tests/shell/lib/perf_json_output_lint.py  |  7 ++++++
 tools/perf/tests/shell/lib/stat_output.sh     |  8 +++++++
 .../tests/shell/perftool-testsuite_probe.sh   |  1 +
 tools/perf/tests/shell/probe_vfs_getname.sh   |  1 +
 .../shell/record+probe_libc_inet_pton.sh      |  1 +
 .../shell/record+script_probe_vfs_getname.sh  |  1 +
 tools/perf/tests/shell/stat+csv_output.sh     |  2 ++
 tools/perf/tests/shell/stat+json_output.sh    |  9 ++++++++
 tools/perf/tests/shell/stat+std_output.sh     |  8 +++++++
 tools/perf/tests/shell/test_data_symbol.sh    | 15 ++----------
 .../shell/test_uprobe_from_different_cu.sh    | 11 ++++-----
 .../tests/shell/trace+probe_vfs_getname.sh    |  1 +
 tools/perf/tests/shell/trace_btf_enum.sh      |  1 +
 tools/perf/tests/shell/trace_btf_general.sh   |  1 +
 tools/perf/tests/shell/trace_exit_race.sh     |  1 +
 tools/perf/tests/shell/trace_record_replay.sh | 21 +++++++++++++++++
 tools/perf/tests/workloads/datasym.c          | 23 +++++++++++++++++--
 17 files changed, 91 insertions(+), 21 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_record_replay.sh

-- 
2.48.1.711.g2feabab25a-goog

