Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C268E1B85D0;
	Thu,  3 Oct 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981628; cv=none; b=UF1lD4wbsv0Fn5UqKAnLf8xOE/ccN0O/H6P956M2Ti/ixUFwN9dwadg71y1tduAf3Ox+5beiFhDkbqAwRthUvF4teX7XxNrt3ZJNaeuwqSAFnj6N8LiVIAg5rRGI22Xjruzz5doNQ/wm8pGYyt9GJeF3ivUqpmeK3uQaflW54pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981628; c=relaxed/simple;
	bh=uKnz5kd7YKacNv+wpKZkgJqTFb4cESY+HRNpg921fPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WYsUQeYiWYaztS5at9El4aW6sbPm56622Lu4VR5EVAXZYopk/LOlUq3I0nNGSlt4wEPL9gy97HbSwKNd1tqj5FZHHYzf9+acOIyPAlrwznV0khUIokM95Hz9dIRk2l12mvaxKd3BbzjcMVhbELpkSghMXewtPTFK9FrJrjxiPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C581B339;
	Thu,  3 Oct 2024 11:54:15 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3DC273F640;
	Thu,  3 Oct 2024 11:53:44 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 5/7] perf arm-spe: Remove the unused 'midr' field
Date: Thu,  3 Oct 2024 19:53:20 +0100
Message-Id: <20241003185322.192357-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003185322.192357-1-leo.yan@arm.com>
References: <20241003185322.192357-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'midr' field is replaced by the MIDR values stored in metadata (per
CPU wise). Remove the 'midr' field as it is no longer used.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 9221b2f66bbe..485f60c32309 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -46,7 +46,6 @@ struct arm_spe {
 	struct perf_session		*session;
 	struct machine			*machine;
 	u32				pmu_type;
-	u64				midr;
 
 	struct perf_tsc_conversion	tc;
 
@@ -1466,8 +1465,6 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	size_t min_sz = ARM_SPE_AUXTRACE_V1_PRIV_SIZE;
 	struct perf_record_time_conv *tc = &session->time_conv;
-	const char *cpuid = perf_env__cpuid(session->evlist->env);
-	u64 midr = strtol(cpuid, NULL, 16);
 	struct arm_spe *spe;
 	u64 **metadata = NULL;
 	u64 metadata_ver;
@@ -1501,7 +1498,6 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 	else
 		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE_V2];
-	spe->midr = midr;
 	spe->metadata = metadata;
 	spe->metadata_ver = metadata_ver;
 	spe->metadata_nr_cpu = nr_cpu;
-- 
2.34.1

