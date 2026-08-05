Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC5388377
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945318; cv=none; b=ZMxPowoHSTQ00thuIMhW5hOFt8L4l1PYKtHu0cyEqaWqXBZjwTpc4iX9TWbhVUkaAhk/7u8JyQ02EtpiVI4yCFM0b5qKmE1PfDkAgQHKIxiBGCuprlIv2tvKTfkdFPW2vKCvwq/p5BBGRtzDlg2hT/N+pqEPVwZKoItESDVcAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945318; c=relaxed/simple;
	bh=zabtP119DXiF4b+kW/WzYg/ztpIthQuDA8n9E0in1+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCIVepm2bg4qCKjQLradXKoc/oadfmCtCCuciFReCDDGXAY3KXMDi5etAF+axWvKHSSCzr8WbMY2eG+JA1e02jxAWId9ZOxnwxRiKjSaboJA0QUqSTIuZmwBIPMe2ICLPk6ZYiEAJqaQfCLctD0hZJbe/syxn9N6x+ZdeF+LdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F210F1F00A3A;
	Wed,  5 Aug 2026 15:55:16 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: inux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v4 09/11] perf/cxl: Validate the hardware-reported counter width
Date: Wed,  5 Aug 2026 08:54:59 -0700
Message-ID: <20260805155501.1294472-10-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805155501.1294472-1-dave.jiang@intel.com>
References: <20260805155501.1294472-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_pmu_parse_caps() takes the Counter Width straight from the CPMU
Capability register without a bounds check. The Counter Data register is 64
bits wide, so a device reporting 0 or more than 64 is reporting nonsense,
and GENMASK_ULL(width - 1, 0) in the read path then shifts out of range.
That is undefined behaviour, and a UBSAN splat where it is enabled.

Reject a counter width outside 1..64 at probe.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index a081fcba6991..84ebc7da181d 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -142,6 +142,15 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
 
 	info->num_counters = FIELD_GET(CXL_PMU_CAP_NUM_COUNTERS_MSK, val) + 1;
 	info->counter_width = FIELD_GET(CXL_PMU_CAP_COUNTER_WIDTH_MSK, val);
+	/*
+	 * The Counter Data register is 64 bits wide, so a Counter Width of 0 or
+	 * >64 is invalid. Reject it rather than let GENMASK_ULL(width - 1, 0) in
+	 * the read path shift out of range.
+	 */
+	if (info->counter_width == 0 || info->counter_width > 64) {
+		dev_err(dev, "Invalid counter width %d\n", info->counter_width);
+		return -ENODEV;
+	}
 	info->num_event_capabilities = FIELD_GET(CXL_PMU_CAP_NUM_EVN_CAP_REG_SUP_MSK, val) + 1;
 
 	info->filter_hdm = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) & CXL_PMU_FILTER_HDM;
-- 
2.54.0

