Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E3181B96;
	Sun, 23 Jun 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719149703; cv=none; b=QD84Lqn/lw6gzUYl0WzFTA7gqHFivPEXpn6CIbr+s3hyKzCCr2WxFWYjZnEzBpuyo1bj2uMhxoQQegJ98dn5ya+Hn1VLwI3hY37bAbko6mb3zxC4HwkM2+ckYt4ZH8xAQDAS74YJ8B5/8KvtGMZsGAIurmdzRPvrF6DhdoWoeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719149703; c=relaxed/simple;
	bh=qyqBA4nAmJd8XITMyxqAL9q0T8AwJp01B2uqQrhwkEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LB51Xs1dQxirXMxr8TlMQu1V35GBJZOy1eX87teoQUbFPKdVjqjKFfZ/2SXBgupAkaycNNk/FGCl4N57E0dL6CRN987rv6z5sScqxq5h1biY/bfhv5yrPplgebwbLmkk2Plii0C/JxVJGCbuQ67gHcOcp+qPdfKuChCmr0wBLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49315FEC;
	Sun, 23 Jun 2024 06:35:20 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 847F63F64C;
	Sun, 23 Jun 2024 06:34:52 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 1/2] perf arm-spe: Support multiple Arm SPE PMUs
Date: Sun, 23 Jun 2024 14:34:36 +0100
Message-Id: <20240623133437.222736-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623133437.222736-1-leo.yan@arm.com>
References: <20240623133437.222736-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A platform can have more than one Arm SPE PMU. For example, a system
with multiple clusters may have each cluster enabled with its own Arm
SPE instance. In such case, the PMU devices will be named 'arm_spe_0',
'arm_spe_1', and so on.

Currently, the tool only supports 'arm_spe_0'. This commit extends
support to multiple Arm SPE PMUs by detecting the substring 'arm_spe'.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 8b7cb68ba1a8..29cfa1e427ed 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -27,7 +27,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 		pmu->selectable = true;
 		pmu->is_uncore = false;
 		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
-		if (!strcmp(pmu->name, "arm_spe_0"))
+		if (strstr(pmu->name, "arm_spe"))
 			pmu->mem_events = perf_mem_events_arm;
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
 		pmu->selectable = true;
-- 
2.34.1

