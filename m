Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147D3B961A;
	Tue, 28 Jul 2026 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272768; cv=none; b=sIRWPPR9aDNwX6bG/hN+JIU2I9sKKuMgp3lCiYnn28pTuskO0GA/metP7VBQexRcW3KStgzDagRfUFh+Mhc7lk32GwOfKyQ8XjKDk0RAb6q5+F1qWy5WJckwni+riaEYQjj8d2xB5scwnwr2d4jFakx97cqyghQh7mzajGWVM+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272768; c=relaxed/simple;
	bh=ZSA+ycefNY4UfHs+iO9vcDapnbJgyS/fwanbpGCT1No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGDQ4h3PCIc3RsLPNH3wW4tRCRG3cZWjs3cl7Fusmwd7QxwsY35f88w1CMvmadDruovwD0bjS9qxizTWggmWzUOBTj6Fj1oDcOvHa21oAK0bdoizdE1N1NFGdfT0lVFmq5qdRTQlFgTo4PiMOMKcw9W5zVFYbP8fqxVQkqQpidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D971F000E9;
	Tue, 28 Jul 2026 21:06:05 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH 7/9] perf/cxl: Validate the hardware-reported counter width
Date: Tue, 28 Jul 2026 14:05:49 -0700
Message-ID: <20260728210551.2449093-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728210551.2449093-1-dave.jiang@intel.com>
References: <20260728210551.2449093-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_pmu_parse_caps() takes the Counter Width straight from the CPMU
Capability register with no bounds check. The Counter Data register is
64 bits, so a device reporting width 0 (or > 64) is invalid, and the
read path's GENMASK_ULL(counter_width - 1, 0) would shift out of range
(undefined behavior, e.g. a UBSAN splat) on a value of 0.

Reject a counter width outside 1..64 at probe.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index e13811cf0c81..d1fa97f77e25 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -139,6 +139,15 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
 
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
2.55.0

