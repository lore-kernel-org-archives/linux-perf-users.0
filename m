Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8D1494DE;
	Fri, 10 May 2024 02:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715309270; cv=none; b=lRuJiMbT2qPhiod6V4399JZTjXSuVCvJU+knvrwthlLmnJ6HzFngiUGowDd72OKam0NJfknxHGHBdsUzPfrBNYNcLfSelwtv1OWz41JvQRCjof15y9stHRZsriwEACWmIOZv/9dXpXpjZAkBxfZeeAJA7etDNRY3bZCokulgPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715309270; c=relaxed/simple;
	bh=8jGhS89nWXCilLoGQg+wuKKsd2UcXNDCHKExELmDRFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SkLRBIfJJzzVvYROS65ZMNxCnIY68gyYDk9AzMkXMzyFsZgG4dASPSPc0J4NpzNVgTIl46wbcqTI7ja3ynawp4ugLIOwd6vYBWEKNKxQTriA4yPFXaofYzmx3cAwh09vCLwabGw5Ww10kQblPpfY5QnzOX+dNBzOPwzAwNlFtuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B227212FC;
	Thu,  9 May 2024 19:48:12 -0700 (PDT)
Received: from entos-yitian-01.shanghai.arm.com (entos-yitian-01.shanghai.arm.com [10.169.206.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8E0A23F762;
	Thu,  9 May 2024 19:47:43 -0700 (PDT)
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
Subject: [PATCH 1/2] perf pmu: Allow finishing loading json events when !events_table
Date: Fri, 10 May 2024 02:47:28 +0000
Message-Id: <20240510024729.1075732-2-justin.he@arm.com>
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

Otherwise, cpu_aliases_added is never set to true on an Arm v8a
Neoverse N2 server.

Signed-off-by: Jia He <justin.he@arm.com>
---
 tools/perf/util/pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f39cbbc1a7ec..a1eef7b2e389 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -915,13 +915,11 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu, const struct pmu_events_tab
 
 static void pmu_add_cpu_aliases(struct perf_pmu *pmu)
 {
-	if (!pmu->events_table)
-		return;
-
 	if (pmu->cpu_aliases_added)
 		return;
 
-	pmu_add_cpu_aliases_table(pmu, pmu->events_table);
+	if (pmu->events_table)
+		pmu_add_cpu_aliases_table(pmu, pmu->events_table);
 	pmu->cpu_aliases_added = true;
 }
 
-- 
2.34.1

