Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600B013A895;
	Sat,  6 Jul 2024 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720279275; cv=none; b=M4cQPNQbU3gFDdGmA4qaFUbPvFJYNE89CEA9+fWtEfciArWPP4maiy4H+D+5ZetNZb4EHdVbvvBAkimRfJJF0pT4aOsJLioanqKGKr0dfuZS9apj3FtRtxCLX79ajg/jPbpswKnxHTbb9n1/Hr8taW1oiAcisepkgCHgsH5PZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720279275; c=relaxed/simple;
	bh=RTbf8OjTW1PHD5c8Ez3Vw/XWgfh3ubVm4i2VEAfelek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8smS9PXb13tsIfaD4fmpeAmgQNLPTqkMFCEBS7A+FAIbcAqUc+TbdAvF3uuZCRZW5YsL5R4jNPRoAGE8+O29TnhTln8NgNNGWOJJr3WNm8J6zyOTFF5bRJXFqtCGTNmcGRsIZZ6oSRv4Z3PPkOOcG11sazsniAtwZ2enbaL5MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19A881477;
	Sat,  6 Jul 2024 08:21:31 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF8AA3F762;
	Sat,  6 Jul 2024 08:21:03 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@arm.com>
Subject: [PATCH v2 1/2] perf arm-spe: Support multiple Arm SPE PMUs
Date: Sat,  6 Jul 2024 16:20:34 +0100
Message-Id: <20240706152035.86983-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240706152035.86983-1-leo.yan@arm.com>
References: <20240706152035.86983-1-leo.yan@arm.com>
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
support to multiple Arm SPE PMUs by detecting the substring 'arm_spe_'.

Signed-off-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index 8b7cb68ba1a8..b762f6395d16 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -27,7 +27,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 		pmu->selectable = true;
 		pmu->is_uncore = false;
 		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
-		if (!strcmp(pmu->name, "arm_spe_0"))
+		if (strstarts(pmu->name, "arm_spe_"))
 			pmu->mem_events = perf_mem_events_arm;
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
 		pmu->selectable = true;
-- 
2.34.1

