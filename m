Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562A1195381;
	Fri,  9 Aug 2024 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205711; cv=none; b=iuznIHDqnKYEiyvuAxGkK619BdgQjIo0VjX/laD7O/ojVdi7v1zyLOjEiTqngxupCHDyoKdmDT53xrbMUjwE3ljszFaZL29CZw7CM/t/dh/tIKEv2PM1+GdahgXip7qMEOI0h9MMZovel1nu9xI88zqIeckp47cfFR8ogfp0I9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205711; c=relaxed/simple;
	bh=YwarIFJ+JcZ8lK+zwj37i04m09xApkcJiPW64Kq0v2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o322tVj06YuwGURrUTBQDkGgUUeHzYBRz/0uXsSPQCjupLwwgRX1a1y8BWe1l+937+QdUlNkEYW8u5u4JpxDHzhAxQWuM4raWWYXzTGkihAn/dyKOPQr9zlhd1jW/ZicUQULrcPrTiayHkmOoKg/4NfMOU9zARAVvz+BxHpqj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8253516F8;
	Fri,  9 Aug 2024 05:15:35 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8D383F6A8;
	Fri,  9 Aug 2024 05:15:07 -0700 (PDT)
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
Subject: [PATCH v4 6/8] perf auxtrace: Bails out after finding the event for the map index
Date: Fri,  9 Aug 2024 13:14:45 +0100
Message-Id: <20240809121447.2078084-7-leo.yan@arm.com>
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

After finding the corresponding event for the passed buffer index, it is
safe to say the found event has been used. Then, the tool can check the
event status and bails out if it has been disabled.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/auxtrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c970024f16db..ac6e2e428a66 100644
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

