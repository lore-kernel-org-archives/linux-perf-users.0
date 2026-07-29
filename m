Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9F04C9542;
	Wed, 29 Jul 2026 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336968; cv=none; b=qehHFFBTm/34Z4FdV1bhgxLFr6YE9AZ77VyZlYXqpJ/7a5ezIvCG4ruJXVp9Qa0ssaKqlvcRdL0zgpThQr+/0QKfKNrd6HeFysTm4ozE2t6h4zA8k7jLv5MaZo1wx2i6IXkOnEQ/0+blEmStqUdoVG6pfse1Tgr+3+9961OauZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336968; c=relaxed/simple;
	bh=IpIvvmnXwnTBsawSUljp4PEE26Dr+IDl0Ajyi895HZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhLJN8KrqB8hMOeNhRoIaISM2pCn9AvQUva13ItZ6u0cPQq0kKSEYh6DrQ55VxfpuPe26kat6P/TwoVn0lJBsRlnYVP9Nru7MIIWGxP0ouNQRPma9QUHcxloGXeB/ivDajt1lbPC5FGmS4EX5xOb4OC5C0b8z8aLGpv22Jg/Mcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4401F00A3A;
	Wed, 29 Jul 2026 14:56:07 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH v2 7/9] perf/cxl: Validate the hardware-reported counter width
Date: Wed, 29 Jul 2026 07:55:53 -0700
Message-ID: <20260729145555.3919550-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729145555.3919550-1-dave.jiang@intel.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
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
index 52e78a6e0960..2e817a52ff1e 100644
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

