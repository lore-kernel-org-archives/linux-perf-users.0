Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159F52BEFE6
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803913; cv=none; b=OjCoFGhtd/XxkVfqkjVNFDMSHtnRa4pjlgQlL3JauwXyLIpHNEuzOvK8HEttW8H5NTjb7bMrcgkACFAH8OBRtSvh0SOPpMt5dWw+0dOeAVUPdepMA5GRbwxiKUHvQ/r3YBB2WBMFk5Kmfx87feo78dZ85U3eqdJwr55l+KNVIx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803913; c=relaxed/simple;
	bh=m1PySxqsDOqefluVrtxObPdnQw6hlfRvIjoJpdUa7Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyryWjlbl1LuNBp1ZUyQn068duhE1VG+mJzX11gCR2WPxhT6ZiUwslyuVH1fnjWhGRtB4WjAD5YOjT5bAluzunazipohhDZ4XiEnklOBtS1sJ8Cymd1kzN4j7R76MgSF0zK7S8QZhmlEsLnr0BeIgt6JO4GOaQK0UEj/+W90xQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BFF0165C;
	Mon, 15 Dec 2025 05:05:04 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DBFB3F73B;
	Mon, 15 Dec 2025 05:05:10 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf/arm_dsu: Allow standard cycles events
Date: Mon, 15 Dec 2025 13:05:00 +0000
Message-Id: <1a7d3708fec84fd292d6e8414e65984b020f99ad.1765802897.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1765802897.git.robin.murphy@arm.com>
References: <cover.1765802897.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we do not use the divide-by-64 option, there should be no
significant difference between the dedicated cycle counter and the
standard cycles event. Since using the latter on DSU-120 now has
the side-effect of allowing multiple cycles events to be scheduled
simultaneously (beneficial for multiple cycle-based metrics), there
seems little reason not to allow the same on older DSUs as well.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_dsu_pmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 56c592f0dae3..32b0dd7c693b 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -284,9 +284,8 @@ static int dsu_pmu_get_event_idx(struct dsu_hw_events *hw_events,
 	unsigned long *used_mask = hw_events->used_mask;
 
 	if (evtype == DSU_PMU_EVT_CYCLES && dsu_pmu->has_pmccntr) {
-		if (test_and_set_bit(DSU_PMU_IDX_CYCLE_COUNTER, used_mask))
-			return -EAGAIN;
-		return DSU_PMU_IDX_CYCLE_COUNTER;
+		if (!test_and_set_bit(DSU_PMU_IDX_CYCLE_COUNTER, used_mask))
+			return DSU_PMU_IDX_CYCLE_COUNTER;
 	}
 
 	idx = find_first_zero_bit(used_mask, dsu_pmu->num_counters);
-- 
2.39.2.101.g768bb238c484.dirty

