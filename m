Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092763FB055;
	Tue, 28 Jul 2026 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272758; cv=none; b=rd9TnhFWUVbtySoauwZJ0dZWTeaOHi1Igkz1A7yLPE5G0hEBir1XZPE0WQanmGpAJ3j/vCsq8qfE+Ye26EzSTYTTYttH7MIZcZEDOomfniTaRIvwfYRn2jc+WINl5I+kXW6rMsRkcRknDehrx8ZCz+irqSzcufyLwYNKl8k25Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272758; c=relaxed/simple;
	bh=S/5DW2hjkaM7cYmmydyZZqcFKUAE06w0OdAuq926P4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmCIKhdhH2oXqrg27n42+E/z0FAkIwGxTruLZjilUhzIcxXNmfT+cWKJo9eWUgoY/XKdl5AcB2fWT0A7YepOEZ1dmhB+RALQzA0+KEwON6e8rGtklIoubJjYZlxr8ukVw9kZ2qAOq6LllBYe81pCUah3s8hw/jTDoAkKMya4Vjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942151F000E9;
	Tue, 28 Jul 2026 21:05:56 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH 1/9] perf/cxl: Program the requested event group on configurable counters
Date: Tue, 28 Jul 2026 14:05:43 -0700
Message-ID: <20260728210551.2449093-2-dave.jiang@intel.com>
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

cxl_pmu_get_event_idx() sets *counter_idx for a configurable counter but
never sets *event_idx, so hwc->event_base stays 0 and cxl_pmu_event_start()
programs event group 0 regardless of the group the user requested.

Return the matched capability's event_idx.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/perf/cxl_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 68a54d97d2a8..e77c0650a7eb 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -552,6 +552,8 @@ static int cxl_pmu_get_event_idx(struct perf_event *event, int *counter_idx,
 			return -EINVAL;
 
 		*counter_idx = i;
+		if (event_idx)
+			*event_idx = pmu_ev->event_idx;
 		return 0;
 	}
 
-- 
2.55.0

