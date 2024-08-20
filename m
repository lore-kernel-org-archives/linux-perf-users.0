Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC8D1547F8;
	Tue, 20 Aug 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179675; cv=none; b=QSq696ANjf7XGP1H5tYN5GhW/OyAzw336bZF4I5e+Rfce01ZSycMhZfRKpw8G9/ZD30l/jssXPhn2gdoUUaBjAkMFY4VdjXHV7fIWCi1T69Oj6yV0+9x1bmIrbAoVgxYi9e6vJxpI37PPp5/nvIg2rHmJXzEygVNMSS3YF5lx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179675; c=relaxed/simple;
	bh=qC9uy8eM5i7tGdIPdUHWZAxuBI3GpsqejXPmdbCToUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZhBj2YvxnCd+p3h3zwQFG3hjMFawA5PCpxy3dxzpPO2MnBMTwaHx92Tnz6QDPXE7vogVOWRHxksL0eELgj7O/q5JbrtiuFolkpWOXTNPhUx2hC0QkNNSDLMU9U6RUc/hoqskQwA5Xca8MLpZumFnOI1DqoMub8vETin4QUzK5Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CC9D1480;
	Tue, 20 Aug 2024 11:48:18 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BFD1B3F58B;
	Tue, 20 Aug 2024 11:47:49 -0700 (PDT)
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
Subject: [PATCH v5 2/8] perf auxtrace: Use evsel__is_aux_event() for checking AUX event
Date: Tue, 20 Aug 2024 19:47:25 +0100
Message-Id: <20240820184731.2937551-3-leo.yan@arm.com>
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

Use evsel__is_aux_event() to decide if an event is a AUX event, this is
a refactoring to replace comparing the PMU type.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index cbb773ed6f1a..ca8682966fae 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -671,11 +671,11 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 {
 	struct evsel *evsel;
 
-	if (!itr->evlist || !itr->pmu)
+	if (!itr->evlist)
 		return -EINVAL;
 
 	evlist__for_each_entry(itr->evlist, evsel) {
-		if (evsel->core.attr.type == itr->pmu->type) {
+		if (evsel__is_aux_event(evsel)) {
 			if (evsel->disabled)
 				return 0;
 			return evlist__enable_event_idx(itr->evlist, evsel, idx);
-- 
2.34.1

