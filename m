Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0950428CF59;
	Wed,  7 May 2025 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746655181; cv=none; b=rLaH8iwYafd9jrZnGnwIxu8WMVpVTI/iVUh/wln4IcyLih18s84w6WpCHFCrtnr9ZxUAmF08o3FwrgOcaC0oAcCz/rcP+E9AT8qYwb08Y+FRs2XCPiuCJvYicwqkf9zcdGZrRS4PvIv0huBamYd2LYdJHeLAoR+AK+nRjK5X5AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746655181; c=relaxed/simple;
	bh=TT+ZhlfU17P7rtGMqpc/JbcqHghTj5R4sNFzYpzUxJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3vy+wsKMdyg9vZoRzuakOxEPSAj7G7Gf8CeN5/vt+YGVCx5iBYY5ZFHWB26HVxP4CbglR85zcgLvBZRggqCTWZvQTOOUyn15ZL0aLlZiJ0xxWLbwOxbAgWS+Q3PAkKEaV/9JC1T73bdC6k72sZm4nVDw9a6kht0j4kGq13oeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8n96NQk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8n96NQk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F8EC4CEE2;
	Wed,  7 May 2025 21:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746655180;
	bh=TT+ZhlfU17P7rtGMqpc/JbcqHghTj5R4sNFzYpzUxJ4=;
	h=From:To:Cc:Subject:Date:From;
	b=r8n96NQkUiRI3LGb/gIPV4wQm61WsdAnrOvwvUdFZS+KqnUYhlZr0tTuQZ1pmWVLd
	 uPswdv+rGVFfKMr3beKywCm9eZJRK4iKg5PjLZ42hBGmNgm3ybzpHToQS/BtEZoDK7
	 Ts/qUMX5RRemF9HNfKDeK2OaS3M7cGsUeO8Ddf3VTplyKpmHMJratmsExejCneNo0W
	 kAjhgIzL/VrCeKs2scSNKKkfjLqpXLF18ikCFV+Nq69dslFuf+AJP9sjSvV5jgwhmk
	 WDsOClkppvXNgsprWadMdu8clNAwICf49+FTvEqTApZbOZMXpSOEZ6tI39IaeSt8t4
	 wbasAVIlODQEQ==
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
Subject: [PATCH v2] perf pmu: Use available core PMU for raw events
Date: Wed,  7 May 2025 14:59:39 -0700
Message-ID: <20250507215939.54399-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.987.g0cc8ee98dc-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When it finds a matching pmu for a legacy event, it should look for
core pmus.  The raw events also refers to core events so it should be
handled similarly.

On x86, PERF_TYPE_RAW should match with the existing cpu PMU.  But on
ARM, there's no PMU with the matching type so it'll pick the first core
PMU for it.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/pmus.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index b99292de76693dbb..3bbd26fec78a10e2 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -727,14 +727,21 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 	legacy_core_type =
 		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
 		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
-	if (!pmu && legacy_core_type) {
-		if (perf_pmus__supports_extended_type()) {
-			u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+	if (!pmu && legacy_core_type && perf_pmus__supports_extended_type()) {
+		u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
 
-			pmu = perf_pmus__find_by_type(type);
-		} else {
-			pmu = perf_pmus__find_core_pmu();
-		}
+		pmu = perf_pmus__find_by_type(type);
+	}
+	if (!pmu && (legacy_core_type || evsel->core.attr.type == PERF_TYPE_RAW)) {
+		/*
+		 * For legacy events, if there was no extended type info then
+		 * assume the PMU is the first core PMU.
+		 *
+		 * On architectures like ARM there is no sysfs PMU with type
+		 * PERF_TYPE_RAW, assume the RAW events are going to be handled
+		 * by the first core PMU.
+		 */
+		pmu = perf_pmus__find_core_pmu();
 	}
 	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
-- 
2.49.0.987.g0cc8ee98dc-goog

