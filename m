Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79FE41A80
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890001; cv=none; b=pbt4VtrZFQiriBnTYD0c7iuFyBGl2Y4utfQHX1Ztrb/fUAvG7MlMG+RU3U1JX07Ju8aWnPzfR0Hh/fecWT/KS/NK1xuUVoeeIKiZspPCG3hi0KrNU/FY55Jjvc1sgr2wE24M64gLOnShpQ0oh2SSgolqZ7nc6s8hQeO3NgZHtIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890001; c=relaxed/simple;
	bh=XjfD6SFHOm+/sYKS5rzeeSPUyoe6M3xxvUJdA6bSxCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VW2y0318iGVrLMx6qm1UY7QvwudTDLRRfnciLP0Sen7zK/a7D7cihVHPbanr71lgUswuXVMwfRw86qkKeHmqmYU0qzJy4MBbgUfIdLA06EQtJkpcrbhkIfbE8qCJO9NKKzw4P2OsP2HzvV/js5rTd5H6vDvENHrj/Nw8v6cQs54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A37FD1476;
	Wed, 24 Jul 2024 23:47:04 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FE3D3F73F;
	Wed, 24 Jul 2024 23:46:37 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 1/4] perf auxtrace: Iterate all AUX events when finish reading
Date: Thu, 25 Jul 2024 07:46:17 +0100
Message-Id: <20240725064620.1651819-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725064620.1651819-1-leo.yan@arm.com>
References: <20240725064620.1651819-1-leo.yan@arm.com>
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

This patch extends the auxtrace_record__read_finish() function to
search for every enabled AUX events, so all the mmaped buffer indexes
can be covered.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/auxtrace.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index b99e72f7da88..61835a6a9ea3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -670,18 +670,33 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
 int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 {
 	struct evsel *evsel;
+	int ret = -EINVAL;
 
-	if (!itr->evlist || !itr->pmu)
+	if (!itr->evlist)
 		return -EINVAL;
 
 	evlist__for_each_entry(itr->evlist, evsel) {
-		if (evsel->core.attr.type == itr->pmu->type) {
+		if (evsel__is_aux_event(evsel)) {
 			if (evsel->disabled)
-				return 0;
-			return evlist__enable_event_idx(itr->evlist, evsel, idx);
+				continue;
+			/*
+			 * Multiple AUX events might be opened in a session.
+			 * Bail out for success case as the AUX event has been
+			 * found and enabled, otherwise, continue to check if
+			 * the next AUX event can cover the mmaped buffer with
+			 * 'idx'.
+			 */
+			ret = evlist__enable_event_idx(itr->evlist, evsel, idx);
+			if (ret >= 0)
+				return ret;
 		}
 	}
-	return -EINVAL;
+
+	/* Failed to find an event for the buffer 'idx' */
+	if (ret < 0)
+		pr_err("Failed to enable event (idx=%d): %d\n", idx, ret);
+
+	return ret;
 }
 
 /*
-- 
2.34.1

