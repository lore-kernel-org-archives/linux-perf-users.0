Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BFB3A2576;
	Wed,  8 Jul 2026 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541049; cv=none; b=p9D4+itcNECJKFHpog45T4DOOL/Z1zkT+WTmmpKmEL6x/IBbt3z7YH7Oe4fNPUGBdJJcq6U1aEUKvFsHfqVO7oUwvYmzHTABQQ1I1XPO7c6UvEanG2QXWMcMDYEPm53zwzwelJ54DpDsvtVnq415XHJY4grpEk9zuftbcU/nEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541049; c=relaxed/simple;
	bh=Es/hOEe2eha3oLo/j4ZG3FR5SzzwXwIWb//KDz1MAFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j73y/rTPoAoV0Vq9gKQOhGdz6L76hA5KFWvh93SEvhX5SBNiUQnWByN5dned0OmXG81pn68bs36FFQdpQ8X/HnfLc97L7pSGHfah6KnkaE2Uarx10V8x1BXQ6EARLxpyxNUS6Hy/ZSjOHBc5F5Toa9UvsA3ooMqOrkvbWrSY++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onbRef2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onbRef2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425801F000E9;
	Wed,  8 Jul 2026 20:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783541048;
	bh=ZGqSq4qLXg5b8NNaWFCVf8IMNDeie67LZTqKvF/FjeQ=;
	h=From:To:Cc:Subject:Date;
	b=onbRef2pkJmpUd7g6erRQmezU3aB0rwr9Tpd+oU5XkUx2XqMw7AV01PveLN17iFDb
	 COFD9UcKcFBP6YBxAGrAdi0RfKZGvrPHO+GS7i65ghyGSN80oyAjxn2Kd/w2NovP/I
	 6hufd5C1nUIquda3VDro0t0rKsksXGiUcz6qf+ePbOs0fg8FjvURB8/eeLj/AlpHOV
	 ME23IIk8n4qjcSzfHI9WzVZJHsr6ar4rOA0nLbmJv80nWDRlKiliO4pLulnw7y/WIJ
	 mhHbIqg1hWJPhoOUJdXeA/zeJF26YW6HSnhzYXSMbJ84bPCxaOMimU1GPa6EJlkj64
	 7XssBudxgzPdg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf stat: Do not open cgroups for BPF counters
Date: Wed,  8 Jul 2026 13:04:07 -0700
Message-ID: <20260708200407.1240640-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --bpf-counters and --for-each-cgroup options use a set of shared
events among the given cgroups rather than adding events for each cgroup
respectively.  It only uses cgroup-ID to compare and calculate the
result.  So no need to open and keep FDs for cgroups in BPF mode.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 92cdb2df7285befb..49e523058185b753 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2888,7 +2888,8 @@ int cmd_stat(int argc, const char **argv)
 			goto out;
 		}
 
-		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list, true) < 0) {
+		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
+					  !target.use_bpf) < 0) {
 			parse_options_usage(stat_usage, stat_options,
 					    "for-each-cgroup", 0);
 			goto out;
-- 
2.55.0.795.g602f6c329a-goog

