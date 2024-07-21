Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB14C16C453;
	Sun, 21 Jul 2024 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721593303; cv=none; b=X3ewyd+FfpDuQut4SFhwBH/d1rVYsXMXQt0Fknffq5SBOmWyGpoTKH9Ahzl2Jx+JVSJZ5WCGHzt0AkOuj1kMMAq5jc8HhVsRQij+NDA33OiMaenCkHjgaBL8lyujiKNsWee2lfa2t3NI8qTAinBPr/swU33n1SsnDf/ThyxMzDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721593303; c=relaxed/simple;
	bh=QHcyERAEk4KSVs8CSJ8iH2Ygn7dc/Vx86OXOlKz5+zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C57vczKltDIeftjgG8GaIUEhnsZ/1j7hZEzb4PQY2AA3Tt9YAwQ54SOsa7PtQLetxUr9fcI8mcLN8/CehT4GcxsGtM8HiPzhSe6pdqIkCivQ8sd4rDoGd3/Cc5RTHSr8PRl0ShnNQ7BP4Cw/4yEmZWH9NiVvoU+X8yLsxlK83w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A51D6FEC;
	Sun, 21 Jul 2024 13:22:06 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B51033F73F;
	Sun, 21 Jul 2024 13:21:38 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 4/6] perf auxtrace: Iterate all AUX events when finish reading
Date: Sun, 21 Jul 2024 21:21:11 +0100
Message-Id: <20240721202113.380750-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721202113.380750-1-leo.yan@arm.com>
References: <20240721202113.380750-1-leo.yan@arm.com>
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
 tools/perf/util/auxtrace.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e2f317063eec..95be330d7e10 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -670,18 +670,25 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
 int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 {
 	struct evsel *evsel;
+	int ret = -EINVAL;
 
 	if (!itr->evlist || !itr->pmu)
 		return -EINVAL;
 
 	evlist__for_each_entry(itr->evlist, evsel) {
-		if (evsel->core.attr.type == itr->pmu->type) {
+		if (evsel__is_aux_event(evsel)) {
 			if (evsel->disabled)
-				return 0;
-			return evlist__enable_event_idx(itr->evlist, evsel, idx);
+				continue;
+			ret = evlist__enable_event_idx(itr->evlist, evsel, idx);
+			if (ret >= 0)
+				return ret;
 		}
 	}
-	return -EINVAL;
+
+	if (ret < 0)
+		pr_err("Failed to event enable event (idx=%d): %d\n", idx, ret);
+
+	return ret;
 }
 
 /*
-- 
2.34.1

