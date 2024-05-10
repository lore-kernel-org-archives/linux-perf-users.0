Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D02148859;
	Fri, 10 May 2024 02:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715309274; cv=none; b=fGEBhbD+lic734zRQSURND3o2VHWQ1K+VFDJ16OSOnbwG1PV0rLX+O71eBDpbtOnA6h1xGtFdsBT48H6mHeG7gEo4DpKbGox80WXKh4SBfiwi/zt4t+xQQPZhXE8JzedjXSNZHaUrkowVDSxp8Fh4d5sCiDF0rhiW5TSHD9u1Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715309274; c=relaxed/simple;
	bh=6C2HEBWVQBGHjUQwLwVFPEGO4xWWxUD2vEMMiGXlKm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVcjKq/NaN7ljBdncOugmNVBKyIEAeNF1N2nUbs3e7XgdrI0CRTRIJbogH1ukTqokxwqNxp2dYQZ8tk4hUk1nhlGoToT7kzXveBTClcOkt9M+lJzNGkD47U1TrNrclM7cqx8lJZVh5ZmEQOaoXXA9aow0y5K5Y8UQuOjhArW2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C02D143D;
	Thu,  9 May 2024 19:48:17 -0700 (PDT)
Received: from entos-yitian-01.shanghai.arm.com (entos-yitian-01.shanghai.arm.com [10.169.206.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 179813F762;
	Thu,  9 May 2024 19:47:47 -0700 (PDT)
From: Jia He <justin.he@arm.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia He <justin.he@arm.com>
Subject: [PATCH 2/2] perf pmu: Fix num_events calculation
Date: Fri, 10 May 2024 02:47:29 +0000
Message-Id: <20240510024729.1075732-3-justin.he@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510024729.1075732-1-justin.he@arm.com>
References: <20240510024729.1075732-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pe is NULL in the function perf_pmu__new_alias(), the total number
of events is added to loaded_json_aliases. However, if pmu->events_table
is NULL and cpu_aliases_added is false, the calculation for the events
number in perf_pmu__num_events() is incorrect.

Then cause the error report after "perf list":
Unexpected event smmuv3_pmcg_3f062/smmuv3_pmcg_3f062/transaction//

Fix it by adding loaded_json_aliases in the calculation under the
mentioned conditions.

Test it also with "perf bench internals pmu-scan" and there is no
regression.

Fixes: e6ff1eed3584 ("perf pmu: Lazily add JSON events")
Signed-off-by: Jia He <justin.he@arm.com>
---
 tools/perf/util/pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index a1eef7b2e389..a53224e2ce7e 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1639,6 +1639,8 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 		 nr += pmu->loaded_json_aliases;
 	else if (pmu->events_table)
 		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->loaded_json_aliases;
+	else
+		nr += pmu->loaded_json_aliases;
 
 	return pmu->selectable ? nr + 1 : nr;
 }
-- 
2.34.1

