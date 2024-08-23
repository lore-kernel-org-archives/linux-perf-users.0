Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F9C18893A;
	Fri, 23 Aug 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412826; cv=none; b=U+rUxUq51LuVvYTXZoqELTt4N3gMtsNzIuGjQ/Jb/x/oRzGr25ljYwA0KmxKMowsfq0WzOZ+Xkz6oZbUjWK/llXRY/9GmHcOwa5sJ7amAEwKIFKwcjW28Y63SnY1M2lBGFvkSDlrjCUbvVa54w2LOd8aPFDXS4Wmi8ynksuOvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412826; c=relaxed/simple;
	bh=NutnnobzY1pqk5yfZrczr9W27ytQvNp5oF4OsYwZfIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzU9MmqOpVeSC1LU38bAgYVzayZcxd/5FxkX0Na9tuEEsPYnXmKgn8FYb98UYi/EsYb5RITKG2+hwNlt2I3C7njo6sfJUddlYBjBIA/4pLUkTiiHvVcohUW8VJ7Z3WknQhVtzZh8fdgeUWQI9hucJgtvHB1M4rwqOQgM1k2j1rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F4E81688;
	Fri, 23 Aug 2024 04:34:10 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90D5D3F58B;
	Fri, 23 Aug 2024 04:33:41 -0700 (PDT)
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
Subject: [PATCH v6 6/8] perf auxtrace: Bails out after finding the event for the map index
Date: Fri, 23 Aug 2024 12:33:04 +0100
Message-Id: <20240823113306.2310957-7-leo.yan@arm.com>
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

