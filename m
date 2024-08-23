Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE80187FEB;
	Fri, 23 Aug 2024 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412820; cv=none; b=Crfu8yf65O9l1YPtmVy+rUwVlMPvYcWNdU5jsfmTjMLGcETPJsmYmXpa2FkTnSEzqJtO5BAFpSZ+RIxBMZUz27j5GNFTpExBhBbK3zud/x1YlLJ0eso+G4+ozo1d5LWefXAg1q0Vp6PxgzMXkuBxMmvbIoRxySV5rfnI/Y8hODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412820; c=relaxed/simple;
	bh=qC9uy8eM5i7tGdIPdUHWZAxuBI3GpsqejXPmdbCToUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4+XEdsYzqOFwtgzI+G9b9jj+7+hxGZw0EjanDnkmD5MMCdphokulx+dmi5wRwvNfETS7UIf3i+Tp/bx3wkAH7A8uCpAE4ZXxXX6JxNAIO1c2/tJcK6MW3YlGILgzRVPyFmN8W2hlaFjLoWv0y69LykvB7X1+151wpleMDejdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C31FE1688;
	Fri, 23 Aug 2024 04:33:59 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 509D43F58B;
	Fri, 23 Aug 2024 04:33:31 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v6 2/8] perf auxtrace: Use evsel__is_aux_event() for checking AUX event
Date: Fri, 23 Aug 2024 12:33:00 +0100
Message-Id: <20240823113306.2310957-3-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823113306.2310957-1-leo.yan@arm.com>
References: <20240823113306.2310957-1-leo.yan@arm.com>
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

