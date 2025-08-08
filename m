Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D52737EC;
	Fri,  8 Aug 2025 22:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754692011; cv=none; b=hfxTiDzYhooydvu1URxsQFUMou4t07JdqyFBinyf6qmrCLJDuy1cC43tmQx1k/sUf7Lc6Lxlwawtsdzw5v2gl3pEkT08zsbsr/2Ko2UuvY1dRfBU3Myq28bIeH77vDaWSDg7bKub4UMyUUTZsiFVdmdptAyNcY+/QkR/J/fclzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754692011; c=relaxed/simple;
	bh=8jOtYSekpGKCtuwHs8H1eicYgX+qzp+Q6nK4pB61IZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ug2Ddc5YC7PrsKRHTQf0ro85QuohwnS59KGVdariT4Y8JnSqsU/pxw5OBdRSL3aqPzgI94bKO71fH5FaO0BGw1JXm/UcsiJrkuLqH/TBkBXKdfYWHkOLzCp0wVw3/JKHzmtO/WmTynRNi04GoFdbtgXjo4NB0fzDDiIWrVPeIIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6+9vQ2G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6+9vQ2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E889CC4CEF1;
	Fri,  8 Aug 2025 22:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754692011;
	bh=8jOtYSekpGKCtuwHs8H1eicYgX+qzp+Q6nK4pB61IZg=;
	h=From:To:Cc:Subject:Date:From;
	b=P6+9vQ2G//qKyRSQA+sKPGV8hHTOByswKe10PK1TQ5IM1P85CP/TF9v+ViFh8SCrK
	 ho+hF6E0BZeodCKp1B/idgGUeZ/F4OKP8gRyVh2s+DGm23U8kygTumtj+Jwi1vJEIU
	 FcI0IM95JGiLDPYk6ci+elJAZRbfRhm8bksdUIxSxubxwuA+mzJj7DsX45g6bDaLUb
	 jBvLRZGF9L/H31lfW5cTtY3SsWv04TVQmCzOTiITFmp06XDn1rB+tWo77LRY5TGXIh
	 2AStZrDB4npejgXONVhvYl1neCSIoVSWWbmK/fEGaAW7iboWocqf77DH7aIdKUTctZ
	 ekVKYDNpsyHYg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	David Binderman <dcb314@hotmail.com>
Subject: [PATCH] perf tools: Remove a pointless check
Date: Fri,  8 Aug 2025 15:26:50 -0700
Message-ID: <20250808222650.2218658-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyser cppcheck says:

  linux-6.16/tools/perf/util/tool_pmu.c:242:15: warning:
      Opposite inner 'if' condition leads to a dead code block. [oppositeInnerCondition]

Source code is

        for (thread = 0; thread < nthreads; thread++) {
            if (thread >= nthreads)
                break;

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/tool_pmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index d99e699e646dd651..f075098488baddd9 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -239,9 +239,6 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 	nthreads = perf_thread_map__nr(threads);
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
 		for (thread = 0; thread < nthreads; thread++) {
-			if (thread >= nthreads)
-				break;
-
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
-- 
2.51.0.rc0.155.g4a0f42376b-goog

