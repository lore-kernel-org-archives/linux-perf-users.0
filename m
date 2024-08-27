Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC019D074;
	Tue, 27 Aug 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777078; cv=none; b=S7ANmoR8hP/J4v/XnwF1ttlJinL/5HD4WCHBtHcQEkbRKQzenl3Y3sBSKXmzNwovoh0LKC6BRNG09XgMojS23BJImEl1OUBGKAQYiLhU34ktXKLmxgOi30ZQdqnPT+qYaVntGTTx02ckfWrtHTVb5FL3zl4974BqIKBDbG75a6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777078; c=relaxed/simple;
	bh=pAZKt0NQx38DBQ/JAdEOV6YeNTGVr3iOfC59HNAd2sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlH2VmVwmTl8Nvs4e6x5NYFtI+8v3q7AUzxPtaV+CYHlBLPDClki+F5fa33UJFu8Otv9DbbTOKT/au4+6W9NMniWxwM20hyxuMVAe7EmObB/qUmNv1MLqJOE0vboGxXxXGk4vfMXip6oVGGkN1KO7j0K3HrjlbakHQ4nEzQ9Iso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E3E11FB;
	Tue, 27 Aug 2024 09:45:01 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8B8163F762;
	Tue, 27 Aug 2024 09:44:33 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 1/9] perf: arm_spe: Introduce 'lds' capacity
Date: Tue, 27 Aug 2024 17:44:09 +0100
Message-Id: <20240827164417.3309560-2-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827164417.3309560-1-leo.yan@arm.com>
References: <20240827164417.3309560-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a new entry 'lds' in the capacity folder. 'lds' stands
for "loaded data source". When its value is 1, it indicates the data
source implemented, and data source packets will be recorded in the
trace data.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 9100d82bfabc..81c1e7627721 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -110,6 +110,7 @@ enum arm_spe_pmu_buf_fault_action {
 /* This sysfs gunk was really good fun to write. */
 enum arm_spe_pmu_capabilities {
 	SPE_PMU_CAP_ARCH_INST = 0,
+	SPE_PMU_CAP_LDS,
 	SPE_PMU_CAP_ERND,
 	SPE_PMU_CAP_FEAT_MAX,
 	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
@@ -118,6 +119,7 @@ enum arm_spe_pmu_capabilities {
 
 static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
 	[SPE_PMU_CAP_ARCH_INST]	= SPE_PMU_FEAT_ARCH_INST,
+	[SPE_PMU_CAP_LDS]	= SPE_PMU_FEAT_LDS,
 	[SPE_PMU_CAP_ERND]	= SPE_PMU_FEAT_ERND,
 };
 
@@ -160,6 +162,7 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
 
 static struct attribute *arm_spe_pmu_cap_attr[] = {
 	SPE_CAP_EXT_ATTR_ENTRY(arch_inst, SPE_PMU_CAP_ARCH_INST),
+	SPE_CAP_EXT_ATTR_ENTRY(lds, SPE_PMU_CAP_LDS),
 	SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
 	SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
 	SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
-- 
2.34.1

