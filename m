Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226E1C01
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605990; cv=none; b=Ntvs+ID4GWFkyMZNFPPTOPHSG0vzwc/3iE6ozCzh+QejBBmzUyFbHFtgOrxwQQ0HQV+95/NrMA/of0gGq2xxN7Qjhgdqf9ACnagqnSDIY2wefeedH9zmP4UR2094tBqluQxcMxiGSUKTg5MisS45nc50uy4iaGfV05bvzl1wKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605990; c=relaxed/simple;
	bh=pSpleNY7DL8U/OvROpulDz21v4xEzXDi0VGn1SlGWvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q51h3LAoLhu5Mb1RyxXj/0jCCkhEpYxH5CzORY+jaLIKuPJRnIeaRFhzWNWW+QgHvd9YlhE+4gQk8BmjVvhXKAFvRQs0+wIPUqOnTA/b6eMEm5FpMEh/noXFZf90kupZKmrs4O4cCte6WWtdrBHqNYHjLhZl9jxvcWKBTOtfavM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7qk3Hk2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7qk3Hk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737605989; x=1769141989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSpleNY7DL8U/OvROpulDz21v4xEzXDi0VGn1SlGWvA=;
  b=l7qk3Hk2kGdM71e+uDhVfzko/SYbJHj7sr9ojnFhWR3JVCtIaC1ZKAPg
   MHM3bc83qdhFPPpxFDI3GSRPAvKHy+YhvHE3TBAYm9sOojYFru4KJs8UW
   vW2ARucA/NW2lpn+6QI3FhSBR5LoxslHEoYffzgNDmsnOm6OerdOHetbY
   RE1ZaatSl9hs7xW042r7eJhQ8w5p+79waDLMlMh5Xqc94A6T5nHv4Q1Ce
   aJ4RcQcTcOe6CQXLWxuVV60wK2SAkKD26aKB+S47ufrevWJfdw5tI/qLX
   O7oY1P83rcCdrUGX7FNdQjEZQIcS+bFRORvubl5sv9YjXp58I8+ETCosk
   g==;
X-CSE-ConnectionGUID: snVpjD98SWO91DBbH86aBg==
X-CSE-MsgGUID: w0JqJOo1SkuvP/60Cxv0Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37971641"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37971641"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:19:48 -0800
X-CSE-ConnectionGUID: 4jYRYycOT7Kq4nEsRQRxlw==
X-CSE-MsgGUID: E1vynHyoQ4WcdCVAIAl1WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107202061"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:19:47 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v15 3/6] drm/xe/pmu: Extract xe_pmu_event_update()
Date: Wed, 22 Jan 2025 20:19:20 -0800
Message-ID: <20250123041923.1892837-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250123041923.1892837-1-lucas.demarchi@intel.com>
References: <20250123041923.1892837-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other pmu drivers, keep the update separate from the read so it can
be called from other methods (like stop()) without side effects.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pmu.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index df93ba96bdc1e..33598272db6aa 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -117,18 +117,11 @@ static u64 __xe_pmu_event_read(struct perf_event *event)
 	return val;
 }
 
-static void xe_pmu_event_read(struct perf_event *event)
+static void xe_pmu_event_update(struct perf_event *event)
 {
-	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
 	struct hw_perf_event *hwc = &event->hw;
-	struct xe_pmu *pmu = &xe->pmu;
 	u64 prev, new;
 
-	if (!pmu->registered) {
-		event->hw.state = PERF_HES_STOPPED;
-		return;
-	}
-
 	prev = local64_read(&hwc->prev_count);
 	do {
 		new = __xe_pmu_event_read(event);
@@ -137,6 +130,19 @@ static void xe_pmu_event_read(struct perf_event *event)
 	local64_add(new - prev, &event->count);
 }
 
+static void xe_pmu_event_read(struct perf_event *event)
+{
+	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
+	struct xe_pmu *pmu = &xe->pmu;
+
+	if (!pmu->registered) {
+		event->hw.state = PERF_HES_STOPPED;
+		return;
+	}
+
+	xe_pmu_event_update(event);
+}
+
 static void xe_pmu_enable(struct perf_event *event)
 {
 	/*
@@ -166,7 +172,7 @@ static void xe_pmu_event_stop(struct perf_event *event, int flags)
 
 	if (pmu->registered)
 		if (flags & PERF_EF_UPDATE)
-			xe_pmu_event_read(event);
+			xe_pmu_event_update(event);
 
 	event->hw.state = PERF_HES_STOPPED;
 }
-- 
2.48.0

