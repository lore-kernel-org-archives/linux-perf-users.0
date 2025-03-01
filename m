Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB815624B;
	Sat,  1 Mar 2025 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740801774; cv=none; b=ST9k9Bs2G9AH9anQuneWxYRBLlvuZG9uGX9cu6tapB4mbwdTEXFORpWvw73URlUgQ2QcY2qIvH2pNuSQqoZt/tcnyOIShQdyvdclXYBE5mPWRDDyM1WBGzh0wWuGvxo8gezWEnEVoaliOKlbBL+wGASwpozuaBvsedW98V+rGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740801774; c=relaxed/simple;
	bh=Dd8r+xgDiDwAIFehg90/G7azbwedq+a8rXeu/+rmTqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kb81vR17ZReoCgzhhEXY/XcpXT5UxwbIfd2JnSs1URqvReI6JUXIxGtFnhY6vDWaajhCuSsPt4iPieISPNYVBbJCjiD2WQNnt03uVAy6Dq51Bb9WxPtDJPuUSuNFmbhcZupc0VkZIbt6c3WzEoJ1Z2deYJHcChmkmfe/Wfi97yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP9vnDIp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP9vnDIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6039AC4CEDD;
	Sat,  1 Mar 2025 04:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740801773;
	bh=Dd8r+xgDiDwAIFehg90/G7azbwedq+a8rXeu/+rmTqs=;
	h=From:To:Cc:Subject:Date:From;
	b=jP9vnDIphiO+ZBqGtZqju5PxH+yH/9YmpFM8DfanlIwKjLW/yx1pO4DAGhS2Ux8NA
	 PD10VjyAMFfgfmdqYzI/sZ7BrYMyHyNQE5P/7ZVzf0p0LULAq2XkFyqd4SzudnA3ef
	 rAsClnykPc6oKcs4l8Ydm/469x7+XMFNMxWteeMh0a0UPZ6FaJP2wf+l7JuT0R90cJ
	 WWGeJTFFzOLIuXPBSuEOipiat5wBXDdo5pUT+NNQpC2FrYL03fvF6xstdmPKw3Lp8N
	 bltoz8KX6fDuzB74fg1hCfp1bOZs6oywR29WoqlrnKlwYGR+/tbRwGAXEA6YyI5EaT
	 mfN1jzOQ+GKng==
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
Subject: [PATCH 0/4] perf test: Assorted fixes and updates
Date: Fri, 28 Feb 2025 20:02:48 -0800
Message-ID: <20250301040252.1586750-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is a list of random fixes and updates in perf test.  I've added a
new test case for perf trace and updated perf stat output test to
check the --metric-only option.  Also make perf probe and trace tests
for non-root users as they need priviledged operations.

Maybe we need to fix perf stat --metric-only output not to include
bogus metrics like GHz, but let's keep it for later. :)

Thanks,
Namhyung


Namhyung Kim (4):
  perf test: Add --metric-only to perf stat output tests
  perf test: Skip perf probe tests when running as non-root
  perf test: Skip perf trace tests when running as non-root
  perf test: Add trace record and replay test

 .../tests/shell/lib/perf_json_output_lint.py  |  7 +++++++
 tools/perf/tests/shell/lib/stat_output.sh     |  8 +++++++
 .../tests/shell/perftool-testsuite_probe.sh   |  1 +
 tools/perf/tests/shell/probe_vfs_getname.sh   |  1 +
 .../shell/record+probe_libc_inet_pton.sh      |  1 +
 .../shell/record+script_probe_vfs_getname.sh  |  1 +
 tools/perf/tests/shell/stat+csv_output.sh     |  2 ++
 tools/perf/tests/shell/stat+json_output.sh    |  9 ++++++++
 tools/perf/tests/shell/stat+std_output.sh     |  8 +++++++
 .../shell/test_uprobe_from_different_cu.sh    | 11 +++++-----
 .../tests/shell/trace+probe_vfs_getname.sh    |  1 +
 tools/perf/tests/shell/trace_btf_enum.sh      |  1 +
 tools/perf/tests/shell/trace_btf_general.sh   |  1 +
 tools/perf/tests/shell/trace_exit_race.sh     |  1 +
 tools/perf/tests/shell/trace_record_replay.sh | 21 +++++++++++++++++++
 15 files changed, 68 insertions(+), 6 deletions(-)
 create mode 100755 tools/perf/tests/shell/trace_record_replay.sh

-- 
2.48.1.711.g2feabab25a-goog

