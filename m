Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90F13E41D;
	Sat, 14 Sep 2024 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726351774; cv=none; b=e/6xhxPwZoMVV+gXdmD+henBZXFWCnF4tMMbuG5h6NLjRhigBCbt6jkkIPKvJm6pqDPyoW3mSuyK+IlvXC5eG/v2EPqoXp2C9E83ArZYYAn3tfVhRcjd0mO3FOPhzE3ybGXouIcXoF/45p9CSpy18ts7KBiXh/OfaNahRN5kn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726351774; c=relaxed/simple;
	bh=d8rR32wbqytuhQb1NJe3j1aYlGXVPbIpeqJxFOZ75mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2uQOAwmCsARY86NlPzPJvfoe7CdlLaDBnGqyvnnysFd6Y1/GIYq/O/+JmT9M2Q0S7McxHMZJnuaHAfaM/FUf8u7WegG7/Cctal8ZvSgtlhRYixfErk5/kZ+PrrTas40pRt7rAMEAJrB4mUZhbSkLWk9rkdKuQVhqi9yx69HWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD5B111FB;
	Sat, 14 Sep 2024 15:10:00 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8A7BC3F66E;
	Sat, 14 Sep 2024 15:09:29 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 5/7] perf arm-spe: Remove the unused 'midr' field
Date: Sat, 14 Sep 2024 23:08:59 +0100
Message-Id: <20240914220901.756177-6-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240914220901.756177-1-leo.yan@arm.com>
References: <20240914220901.756177-1-leo.yan@arm.com>
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
index e263df079c14..cb0d40b7e3fa 100644
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
@@ -1499,7 +1496,6 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
 		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
 	else
 		spe->pmu_type = auxtrace_info->priv[ARM_SPE_SHARED_PMU_TYPE];
-	spe->midr = midr;
 	spe->metadata = metadata;
 	spe->metadata_ver = metadata_ver;
 	spe->metadata_nr_cpu = nr_cpu;
-- 
2.34.1

