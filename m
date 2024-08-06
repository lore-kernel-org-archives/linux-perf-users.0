Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC915B54A;
	Tue,  6 Aug 2024 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977319; cv=none; b=s/5n1uzRVltrpDqgXVlDPLQbsL/np9WBzo1gQQx0q/5Uc5jTdvb0OiBuBwrcy5U+g9ZlJoPgynPjuQAqJELkf+01+4JQTodSeSy0YJssHIJmKzq6BTmkqr7k+gs6FLKj8DatUrN64S85W+4pDCuZmStNJQ0AgXuypNRqLfZnPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977319; c=relaxed/simple;
	bh=hILpmmbB6lCghG5HkIDN63Hpl7Ykf76XCdWW9HkrVas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TgNETaM3Lj5KGLFdOiIkzyG/bZuJHM9JsctdDzQcbrg4XSmYHvARFAOVBsC7JZqAUHi/9lwmxYVnJzaDvrEYMl+xo0Z0gbXukYPB+6HOHjiXXf99P6JrjIecnor8XqmcejG9wW6Y7n1IfcI+njxUBGE8XmiFVhkDf9rgxWUXCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F31CCFEC;
	Tue,  6 Aug 2024 13:49:03 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C2613F766;
	Tue,  6 Aug 2024 13:48:36 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 5/5] perf auxtrace: Iterate all AUX events when finish reading
Date: Tue,  6 Aug 2024 21:48:13 +0100
Message-Id: <20240806204813.722372-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806204813.722372-1-leo.yan@arm.com>
References: <20240806204813.722372-1-leo.yan@arm.com>
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
index 7c998f95d2ff..926eb3fe6015 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -690,9 +690,13 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 		if (evsel__is_aux_event(evsel)) {
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

