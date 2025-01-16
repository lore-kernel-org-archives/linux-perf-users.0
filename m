Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48922FAC3
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068867; cv=none; b=VTjxcfJBN4+mPSJ+WX8VhrCCwBLF+F05ToNSyCltbWVkXQPUhx6bnvoPQOnNna6UfrmYznpxnAxxTjixI1cEdFjHE8qWRNH2a/sjFHjBMBXw1cFmZ+6u1tl+iBD7J418g++/bntSNOkbd+ip7poqCtmD4LupPt0J1d/d48mKK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068867; c=relaxed/simple;
	bh=KMlFTOCCKKq/OcWv88L2wKpmeMNWJHHHg52d4VIMOsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhguTzyBX037k2FMpn8eeysVfE4lKqtp587dXNmb8XhjwqVg88KLM9jU3xH4mpQ0w5eWohCkEYTLok2L1YVugO/lSm94nSWmYY1yZOX3TcXEzHI9iXUGepqUlFevNvbDuOQadWHowM2+MgcQr2WrJC6qrAmfq6TumvUSy2knCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+pknLcd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+pknLcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737068867; x=1768604867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KMlFTOCCKKq/OcWv88L2wKpmeMNWJHHHg52d4VIMOsA=;
  b=I+pknLcdV5ElgYXjLqZWT4rg0JvJ6iRuKHBWfmVDlVrUzaJzPw1IqRQ7
   Rhm0ZvqjvG8l3b+yU6XfF6S+9bQKd6Qu5bN5CPuHJkMsNOjvmtMOHpfEg
   8z0cQQLbiXj2+lMyGgfJi2U8K8LltH4tUBt+eWDBaWTRy+y8deLegkO1Y
   y6s3/vPgQmNPfK9OwuVZztWn9qXl22WbWBKdTEg6qrm6pxVOJ01kyXxAP
   EMkPsFoj1FCmb5HaLx3lBYyf+7G0SmrauSZejI1EROj+rb/eR9vjdUGDH
   Ww5FbS7n2GOo0OW0cUB6Me8k+hCvrGuIUB5D20IZwxQ7NIlgFzGurTGU4
   g==;
X-CSE-ConnectionGUID: +l8Ir1aOTg+I6jtEYN7BpQ==
X-CSE-MsgGUID: lWogalguTA2vd+C1NeNgxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37364123"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="37364123"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:41 -0800
X-CSE-ConnectionGUID: aFis0aKoSJOEhC8iTdLAtg==
X-CSE-MsgGUID: Rdg4wfaeQo+AZBagD4rsAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="136474357"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 15:07:41 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v13 5/7] drm/xe/pmu: Extract xe_pmu_event_update()
Date: Thu, 16 Jan 2025 15:07:16 -0800
Message-ID: <20250116230718.82460-6-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116230718.82460-1-lucas.demarchi@intel.com>
References: <20250116230718.82460-1-lucas.demarchi@intel.com>
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
index ce53cfb846470..f8154bcad891a 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -126,18 +126,11 @@ static u64 __xe_pmu_event_read(struct perf_event *event)
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
@@ -146,6 +139,19 @@ static void xe_pmu_event_read(struct perf_event *event)
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
@@ -175,7 +181,7 @@ static void xe_pmu_event_stop(struct perf_event *event, int flags)
 
 	if (pmu->registered)
 		if (flags & PERF_EF_UPDATE)
-			xe_pmu_event_read(event);
+			xe_pmu_event_update(event);
 
 	event->hw.state = PERF_HES_STOPPED;
 }
-- 
2.48.0

