Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D7E2D63E5;
	Wed, 29 Jul 2026 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336960; cv=none; b=YemknWDZqa1oXH/xVxUdGg/Vlpa41WfE7fvp+dXht3Ky+UUSbMugIwVY2ZN3buPZ2DbgekcG8Q6piDd5fuhPl6Bl4CD0xmIkhIWcKXJK+ruPZtvNw2ul+D74mr3whRVXHNIIKSoOv4C6g702+EylPp8AIbrghGMJOGQnOidhHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336960; c=relaxed/simple;
	bh=S/5DW2hjkaM7cYmmydyZZqcFKUAE06w0OdAuq926P4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb+QiJ7dR+4wjAE1v13lWjmYNpbJ5EYD1b+bIf99sljL7UodXgcwlds8tlJ9ha6KNpZKjL15rYKkJPJE4w+BSI31+IFF2xbePij6KEyKnF4jDPUWWXxfc7WPkJlxYOf+37HocKyg2JFIYGTFDUMwiuSdbvx7HKb6r50b6FtMnmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025A01F000E9;
	Wed, 29 Jul 2026 14:55:58 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com,
	dave@stgolabs.net,
	sashiko-bot@kernel.org
Subject: [PATCH v2 1/9] perf/cxl: Program the requested event group on configurable counters
Date: Wed, 29 Jul 2026 07:55:47 -0700
Message-ID: <20260729145555.3919550-2-dave.jiang@intel.com>
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

