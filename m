Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAA47D469;
	Wed,  5 Aug 2026 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945563; cv=none; b=FOmk4M13z7lPSCKNtDum3UEZenRHfnsiBe3sOd8eLrHuni7AfkO81JLOfi/uePKRreetYiWqrZGrZYdbAssu5STF9ZAnYHh1Vzrq8BtKo62nCLRqlznzSvR8u6/RjhbhqJROfnXKuXwXO8abjLP8KY9Qi6Hno9ZyH/nLZlrsaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945563; c=relaxed/simple;
	bh=q441MUOhZ7Ojonm8hBwvqFu19FqcWi7I8dDB9XAfOmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgsotDKqztxhX5asviBSqodS6/fe//DcPYhUW8nTXYd5ZPSfCafHtqDnL+n771LzQO7c+15Yhmc9a2P7n3K9Ee2YSWr4df8s7C7meH5JsuFbAWUiD8yMUA6tQ/t9Oasl/Sjvz6pf+yG+p0A1uVPClI715mXyf6tPFCT4kZfE5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C671F00A3A;
	Wed,  5 Aug 2026 15:59:14 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	robin.murphy@arm.com,
	icheng@nvidia.com,
	sashiko-bot@kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [RESEND PATCH v4 01/11] perf/cxl: Program the requested event group on configurable counters
Date: Wed,  5 Aug 2026 08:59:01 -0700
Message-ID: <20260805155911.1304807-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805155911.1304807-1-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_pmu_get_event_idx() sets *counter_idx for a configurable counter but
never *event_idx. hwc->event_base stays 0, so cxl_pmu_event_start()
programs event group 0 no matter which group the user asked for.

Return the matched capability's event_idx.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 68a54d97d2a8..ff01b658e1b4 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -513,7 +513,10 @@ static const struct attribute_group *cxl_pmu_attr_groups[] = {
 	NULL
 };
 
-/* If counter_idx == NULL, don't try to allocate a counter. */
+/*
+ * If counter_idx == NULL, don't try to allocate a counter. Callers that
+ * allocate pass both counter_idx and event_idx.
+ */
 static int cxl_pmu_get_event_idx(struct perf_event *event, int *counter_idx,
 				 int *event_idx)
 {
@@ -541,7 +544,7 @@ static int cxl_pmu_get_event_idx(struct perf_event *event, int *counter_idx,
 
 	pmu_ev = cxl_pmu_find_config_counter_ev_cap(info, vid, gid, mask);
 	if (!IS_ERR(pmu_ev)) {
-		if (!counter_idx)
+		if (!counter_idx || !event_idx)
 			return 0;
 
 		bitmap_andnot(configurable_and_free, info->conf_counter_bm,
@@ -552,6 +555,7 @@ static int cxl_pmu_get_event_idx(struct perf_event *event, int *counter_idx,
 			return -EINVAL;
 
 		*counter_idx = i;
+		*event_idx = pmu_ev->event_idx;
 		return 0;
 	}
 
-- 
2.54.0

