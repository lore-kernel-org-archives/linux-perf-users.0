Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A920194136;
	Fri,  9 Aug 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205704; cv=none; b=QpvbOuU2pdSdAw1ltIRV1LPWLjSnYF+d2V6pAaCAaCWsH0tsj+H1Xwy9aIti7L90ZM/fPQszW+fSZcu7rhNaXiKa0YrtJuyE/qVj5b7LqQ7qWne0F9VPYJ7IIlS4RewK65PSuNWFFjoVEThxnUHsRNvyrhmHjHVwxJbzPvQrGeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205704; c=relaxed/simple;
	bh=m6d5jmjhQ+tN9cJsLCW5oWcfmoz1ZK5x4hk3sT5vyqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Llrz7KJmoZF2Z9KavNJCiPkirZGVO+drtX+6wNmo7I5/RcbVYU7K3bR1gEXROjw0DKC5J64gOROfmhp4B86R6VNqEy8BFJHI2PqQ+BaTOMn/5ZTvGj8cm7D2d98XVslfcTpjk1h86xwoHhpkxYnaD9Sx4hjFZwMxbl/m0AjqVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6527E1688;
	Fri,  9 Aug 2024 05:15:27 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBAFA3F6A8;
	Fri,  9 Aug 2024 05:14:59 -0700 (PDT)
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
Subject: [PATCH v4 2/8] perf auxtrace: Use evsel__is_aux_event() for checking AUX event
Date: Fri,  9 Aug 2024 13:14:41 +0100
Message-Id: <20240809121447.2078084-3-leo.yan@arm.com>
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

Use evsel__is_aux_event() to decide if an event is a AUX event, this is
a refactoring to replace comparing the PMU type.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e2f317063eec..c3f0ef4349fc 100644
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

