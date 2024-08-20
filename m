Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727141AD9D9;
	Tue, 20 Aug 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179687; cv=none; b=aPwGooKiUYZlXpRGPagJn1cZ/lwSIssdUKVXjkoSOygRmZm/Skwqkb6My4IKoFJOJw4Dn8YvtFgE0IaUwkVO9Id3JySCRzr82ANJ3bpmEzZ4PTtW0rmtIkxfO1K7f3n/SPTVOJLqAmph/BPwF9PVjTYebpIyzYi+6Lx+gMxevMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179687; c=relaxed/simple;
	bh=NutnnobzY1pqk5yfZrczr9W27ytQvNp5oF4OsYwZfIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jy3HkYgrYw9RKgDVEcrE463gU2Fna2InFf+8DVf2DffrAzqicRYQ1cesGG9BSdnQJW5jTYNRhAI0CzAGbV/WXR8NIL4vdpVz97cEJRmRL5wI05A4WUAlA6NIASSi8A2n0Q48j8cJjDIXk/om8QyXs329rj3hJN1wfszm5VAcURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE545DA7;
	Tue, 20 Aug 2024 11:48:30 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9CBF3F58B;
	Tue, 20 Aug 2024 11:48:01 -0700 (PDT)
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
Subject: [PATCH v5 6/8] perf auxtrace: Bails out after finding the event for the map index
Date: Tue, 20 Aug 2024 19:47:29 +0100
Message-Id: <20240820184731.2937551-7-leo.yan@arm.com>
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

After finding the corresponding event for the passed buffer index, it is
safe to say the found event has been used. Then, the tool can check the
event status and bails out if it has been disabled.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/auxtrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index e7b582d92811..2acf63efab1d 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -688,15 +688,15 @@ int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
 		if (evsel__is_aux_event(evsel)) {
 			int cpu_map_idx;
 
-			if (evsel->disabled)
-				return 0;
-
 			cpu_map_idx = evlist__find_cpu_map_idx(itr->evlist,
 							       evsel, idx);
 			/* No map is found in per CPU mmap */
 			if (cpu_map_idx == -ENOENT)
 				return cpu_map_idx;
 
+			if (evsel->disabled)
+				return 0;
+
 			if (cpu_map_idx >= 0)
 				return evlist__enable_event_idx(evsel, 1, cpu_map_idx);
 			else
-- 
2.34.1

