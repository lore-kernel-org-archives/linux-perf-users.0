Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138022D4F1;
	Wed,  5 Feb 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738757782; cv=none; b=TC4siY5h3Umx6JWZsi+NFaMHN46nrtUZ34s5UByehCTFSuFmU9NLJI6rbiBRnMIG7mcPTvtIOtNS2wFL/bF3hcA3cDPzFfE+wWxVxupa9m8A+CSELnXAmWpL2jxUlKOstUd/kIKkNy1JuhM5agJGhOfoQZPx4f7NbK/XvP7Wbx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738757782; c=relaxed/simple;
	bh=VmHHQFgO+JH2z8YV5WZUtOPKjZ9wyFVcbyEP7Ez3FTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lVdipbDqrEKuWSOGgWK8tKv/bpiTnBgl/xg3KAw0fcqI3uIk7fbrgWwcsmT05HEcmh3Cgs5VTNST5gxvKvvWuGKtzwhi5SN+cU4akH1y71pSGaujnSotLFoXOEEmQ1AErnigOfrlDfN9DRKaWc72/wGGobTxfrVhGSqaebEr+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABADB11FB;
	Wed,  5 Feb 2025 04:16:44 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A40FA3F63F;
	Wed,  5 Feb 2025 04:16:18 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Graham Woodward <graham.woodward@arm.com>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 04/11] perf script: Add not taken event for branches
Date: Wed,  5 Feb 2025 12:15:48 +0000
Message-Id: <20250205121555.180606-5-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205121555.180606-1-leo.yan@arm.com>
References: <20250205121555.180606-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some hardware (e.g., Arm SPE) can trace the not taken event for
branches.  Add a flag for this event and support printing it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/event.h                 | 6 ++++--
 tools/perf/util/trace-event-scripting.c | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 962fbc1714cf..c7f4b4b841ca 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -67,9 +67,10 @@ enum {
 	PERF_IP_FLAG_INTR_DISABLE	= 1ULL << 13,
 	PERF_IP_FLAG_INTR_TOGGLE	= 1ULL << 14,
 	PERF_IP_FLAG_BRANCH_MISS	= 1ULL << 15,
+	PERF_IP_FLAG_NOT_TAKEN		= 1ULL << 16,
 };
 
-#define PERF_IP_FLAG_CHARS "bcrosyiABExghDtm"
+#define PERF_IP_FLAG_CHARS "bcrosyiABExghDtmn"
 
 #define PERF_ADDITIONAL_STATE_MASK	\
 	(PERF_IP_FLAG_IN_TX |		\
@@ -91,7 +92,8 @@ enum {
 	PERF_IP_FLAG_VMEXIT)
 
 #define PERF_IP_FLAG_BRACH_EVENT_MASK	\
-	PERF_IP_FLAG_BRANCH_MISS
+	(PERF_IP_FLAG_BRANCH_MISS |	\
+	 PERF_IP_FLAG_NOT_TAKEN)
 
 #define PERF_MEM_DATA_SRC_NONE \
 	(PERF_MEM_S(OP, NA) |\
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
index 55d7e4e612d5..29cc467be14a 100644
--- a/tools/perf/util/trace-event-scripting.c
+++ b/tools/perf/util/trace-event-scripting.c
@@ -317,6 +317,7 @@ static const struct {
 	const char *name;
 } branch_events[] = {
 	{PERF_IP_FLAG_BRANCH_MISS, "miss"},
+	{PERF_IP_FLAG_NOT_TAKEN, "not_taken"},
 	{0, NULL}
 };
 
-- 
2.34.1

