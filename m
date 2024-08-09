Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FA4195808;
	Fri,  9 Aug 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205713; cv=none; b=r/nvnmisJ4T6k+JQZ0w21Dke5izDr7oOuzI5n3CsQc7HVTfWRbFlkiPY5r/rCZLd2G9Aqd76Avi0aS+567xJwa1nfIrFzY8GEcgiptB1n+CqX8Zb95+x33t9vDMHGIq5XlRie74F02zzEBJkaB3y4+ouY8FXRJiMPlYDVSnfITs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205713; c=relaxed/simple;
	bh=WcpFbyWNJb4YXSyjeH4OKmg5NTLwGzetomwVXL7t8HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EkzY5mnSpg1Dm6sSzMSiBIWUwRo3YJtc2ab17v5AWBFCqosOL6JTojNmKmPCeHKkyBiaD5i+Mio9GWQj38vZC8C0Ja32XtFBUe4G+LfZScoQdtki6eZIrhAhPVELMQrK1qGpx+mHvKcw34ePfsDCtC2Om8HNZr/hKr4QLeY5hxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86F2D1713;
	Fri,  9 Aug 2024 05:15:37 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6F1A3F6A8;
	Fri,  9 Aug 2024 05:15:09 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v4 7/8] perf auxtrace: Iterate all AUX events when finish reading
Date: Fri,  9 Aug 2024 13:14:46 +0100
Message-Id: <20240809121447.2078084-8-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809121447.2078084-1-leo.yan@arm.com>
References: <20240809121447.2078084-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When finished to read AUX trace data from mmaped buffer, based on the
AUX buffer index the core layer needs to search the corresponding PMU
event and re-enable it to continue tracing.

However, current code only searches the first AUX event. It misses to
search other enabled AUX events, thus, it returns failure if the buffer
index does not belong to the first AUX event.

This patch changes to continue searching every enabled AUX events for
covering the mmaped buffer indexes.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/auxtrace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index ac6e2e428a66..9056bc7bcfce 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -690,9 +690,13 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 
 			cpu_map_idx = evlist__find_cpu_map_idx(itr->evlist,
 							       evsel, idx);
-			/* No map is found in per CPU mmap */
+			/*
+			 * No map is found in per CPU mmap. Multiple AUX events
+			 * might be opened in a session, continue to check if
+			 * the next AUX event can cover the mmaped buffer 'idx'.
+			 */
 			if (cpu_map_idx == -ENOENT)
-				return cpu_map_idx;
+				continue;
 
 			if (evsel->disabled)
 				return 0;
-- 
2.34.1

