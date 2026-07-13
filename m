Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD9B3B777F;
	Mon, 13 Jul 2026 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783986340; cv=none; b=O0UuOavPl19BhfOQOMwpdDuu2PrRSbtUKhf4w+qeIWVTDOBh6ThruicvZCzg9R15QV9mPnjKpQW1HnvYJ75wp5FrzCenMWFNjuMRfKcKweaC19ErA2x3cW3MYiSIYfU2DXiFeRl9nzFcp7FaQTzBOsIEAVp9jt65FNIUAdTX0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783986340; c=relaxed/simple;
	bh=YyuVHjU+ZbX4pENj1g+R8y/nX/Ac9Y+0iLI74ws35dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvOuE7vnVrTx/j16JuifYcwOh35+LzwMtm52apAL3cD8auEjIqE8AzMGapB/KB3xdiq0cwQmDi5+rWFqPnPv454xn1KriV7oCOb3MDhjhzKE1wh+42sKl61SJAbLGLuEqA+049so5SOgWSt6oWSpfn6g/4EDxHlTdjO0DIkBPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeQx/zf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeQx/zf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2283B1F00AC4;
	Mon, 13 Jul 2026 23:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783986339;
	bh=wOkavhZ3KX+8cIlmdeCXNUzWYbrnkJ4x9IfdA9Wxy0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WeQx/zf1vzlXOzD4OHiMbv62UD9XLzU/00k7fhPK81JEZYJdxnqCe/F1cYBWqW5aA
	 NheJccsilevhi/otfq24dEcjeVyf8sH1aAsYo7IZqI8sxNpiCcIDRFfTy77Gpqnnr3
	 NtUNLQgOCXX3WXC1tX5/FYz4XCxy7ViQnQ980akuERwpsX3LDy0EVJJetamjiFO5GS
	 /H+PHNa76P/LtGWt4BNeziz8L7L58AEtE685RDYAGuVezs/3uhGEbTeivv1Rj1m7ts
	 ll59UwH5wDw1xMslUyFXeWV+d1SQkRrEqPZ1kcOcVW6H4jthG1asLJ6e/793nOYEjM
	 F9OWxdpfgRjVQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH v2 3/3] perf sched: Free subcommand string after perf sched stats
Date: Mon, 13 Jul 2026 16:45:36 -0700
Message-ID: <20260713234536.2280374-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260713234536.2280374-1-namhyung@kernel.org>
References: <20260713234536.2280374-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first entry of the sched_usage is dynamically allocated in
parse_options_subcommand() so it should be released at the end.
Do not return from a subcommand directly.

Fixes: 064790a3d4a8 ("perf sched stats: Add support for diff subcommand")
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-sched.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index ab9590c4d838eff3..acc8d81a20d3b9d1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -5259,19 +5259,20 @@ int cmd_sched(int argc, const char **argv)
 			if (argc)
 				argc = parse_options(argc, argv, stats_options,
 						     stats_usage, 0);
-			return perf_sched__schedstat_record(&sched, argc, argv);
+			ret = perf_sched__schedstat_record(&sched, argc, argv);
 		} else if (argv[0] && !strcmp(argv[0], "report")) {
 			if (argc)
 				argc = parse_options(argc, argv, stats_options,
 						     stats_usage, 0);
-			return perf_sched__schedstat_report(&sched);
+			ret = perf_sched__schedstat_report(&sched);
 		} else if (argv[0] && !strcmp(argv[0], "diff")) {
 			if (argc)
 				argc = parse_options(argc, argv, stats_options,
 						     stats_usage, 0);
-			return perf_sched__schedstat_diff(&sched, argc, argv);
+			ret = perf_sched__schedstat_diff(&sched, argc, argv);
+		} else {
+			ret = perf_sched__schedstat_live(&sched, argc, argv);
 		}
-		return perf_sched__schedstat_live(&sched, argc, argv);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
-- 
2.55.0.795.g602f6c329a-goog

