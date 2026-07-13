Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0935E943;
	Mon, 13 Jul 2026 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975632; cv=none; b=btSAzf5jOiq+ha6kjw/BT6LC6W6a53lj73ahURjdVz3bG3AZ3J5/BfAKSWqbWuCy3x3Yle73Bk6BFICEvM653QF3GVXLBjBd0NS1Db2cv+uQ+g7CDQOeepx9vrwnmTOXcwICvhEW1f8E6NpECLG4u2CTWnccxopU5V5EGyDUIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975632; c=relaxed/simple;
	bh=iX10xCXvTVYSvAK4fNXKPtNHYDpcy2C9JDe/msMRak8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYSrWIbRO5862zME/WfM9ZEnzifoDp5JZcI823wAMBOxDU7ytvdJL4XbQ2NR5nJm+tC1NsZekslYnvN9/XHRR6lJT/b4L4RYgybD7CIiroEe1IPTb4hJXfBb5t8vqe7pX9TLgwAHAj1RhQVm69I4osNecMAFIQpMHYSD8TPdQg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFYStltq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFYStltq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04AB1F00A3A;
	Mon, 13 Jul 2026 20:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975631;
	bh=9A2GYX4cI5AM9Ioug65j3qaUtdj7Sv4dWjf78qKuINg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TFYStltqazKXWdDENoM8vCsvJ8OJF4pQTH1kw4BwiOtqfL4QW9x8rR2k7gU232xzz
	 srIXOPHG+6AjcNMPjjUiUIppHaq5nauyIphbjjKDNjVB+oD3qdJ70u/iuDDlJwalrp
	 bhYFl3a2qf+0nwNFH90LREYz89hMg13w5F+YjCeW5tNvn1FmdVd+DnctRKQ4v8VMZP
	 23/6TSH5L/Il8K20SM2xhgApNHyIV07TY1021wpofbRMtQQpEH04dFowkFytPC7+Jd
	 j1LVypH88XYEErmEQs/Hyl26GKT4+2E6lVyaKjk7DjVpgIPU2ymVBw7knGOqvv82tA
	 neJVdSGPmqkKg==
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
Subject: [PATCH v1 3/3] perf sched: Free subcommand string after perf sched stats
Date: Mon, 13 Jul 2026 13:47:07 -0700
Message-ID: <20260713204707.2181098-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260713204707.2181098-1-namhyung@kernel.org>
References: <20260713204707.2181098-1-namhyung@kernel.org>
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
index 439e50d9a936f6c1..cc5b61cb9291fa02 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -5260,19 +5260,20 @@ int cmd_sched(int argc, const char **argv)
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

