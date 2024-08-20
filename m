Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2752D1BD512;
	Tue, 20 Aug 2024 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179689; cv=none; b=rMBA9+4gV/d9K/s13qYlsCa/FBT+zJhbTbs9N08u3O6FkEXQ8g3dXSH7DhuoNAD6aRvBktKvhjvUgbNz9Ra87eHLR2jcYgDM5JOVMIQvwLgrCruvEX/YfL3HyxJa32bNEq7f4Dp426+VGRdrR/ZBYJqyGudvwvd1kSNiPbda61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179689; c=relaxed/simple;
	bh=Gp4VwjnMboKK/ZjgCFtsQFxNA2MCi84eMCBEeV59tGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpo++2sCTrVRatj9LG8cFEbu19EkoGGwggAg5MwhIafOisfUDY8RUW2V3aPRQgiaVPr8qumKTOVGOQ5J6/HpEQtMvR/ojaHC4BNsnFmyyxZtRO7a/QqnliJdnAoId6ICQMV/jqAT5Qv34vpLxv63BDrX2n/q8v+Q0Kn8h07gtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDC621480;
	Tue, 20 Aug 2024 11:48:33 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06F713F7A6;
	Tue, 20 Aug 2024 11:48:04 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v5 7/8] perf auxtrace: Iterate all AUX events when finish reading
Date: Tue, 20 Aug 2024 19:47:30 +0100
Message-Id: <20240820184731.2937551-8-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820184731.2937551-1-leo.yan@arm.com>
References: <20240820184731.2937551-1-leo.yan@arm.com>
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
index 2acf63efab1d..864ed20794ab 100644
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

