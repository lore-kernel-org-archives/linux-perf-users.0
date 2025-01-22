Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174C1BC9FB
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527058; cv=none; b=g3RDjbfC5CU/K6B69NVIQFas9yX2KBNAp9WW5/0MAgvjfeYSKf9Tg44BEnaNYxhl8ggudb7EXldBdFi3hnDfKJNM1tmBycnG/zWaTLoq9sUE3rzbhpduNR8ZM7N1tYYPb9BBp49ayVvIYkkiYNRxR/XSZX+RYMQ6Jr3wa6jmHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527058; c=relaxed/simple;
	bh=6nBis5hDK8emyZJlnksqrmdUFgEf8w3W/ae5Tt+wyp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8FgjhNB7OHUEwE30edZM5hqwxdoLGwhTs8Tv299LX8OY1077m1TVTYhzgVzLmQRgjNenjZGPYzD+5DEj6S77F4aSC17DR1h1nNkyCwwOBL2QWKw8GBTf99O8+ptIjihRVO4mFEMXNUJ3U9WITqW+fqjaU+9xb1l7B0Slzp39Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IcVQhD3C; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IcVQhD3C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737527057; x=1769063057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6nBis5hDK8emyZJlnksqrmdUFgEf8w3W/ae5Tt+wyp4=;
  b=IcVQhD3CQ4pNGR/bSvVu9maLgBLxvGeOHdT4Djgld8Tkqui12fapTgm2
   xSf9oB4FYgEl2QtztIfwqEnKaU0bLQ3V8CtFOYNiaYST5qjhaTB09B4I4
   aaCx1fxPzXKmQh8jIkjYN+dC/JbNkQvr5yL21ayzPcGDcJsaLmJuRSSNZ
   ReaoX/CjGWl79WgorLM+ODRWdh5tagf3QqFctt76YK7eZbFV9+qAqmRIB
   d78ISNcdll8lRY0qlFbc6MWQWku6hGbvX0Zdewh4cGFydeJlOvyj/AWPV
   G/IWX4ch0CyUaEbqxu278fP2okO2WCyDKjCuPMUQwwjv61J16G1mhdVBM
   g==;
X-CSE-ConnectionGUID: qt06BFP2QCyMLab5f0o26Q==
X-CSE-MsgGUID: L/qFBxMsQhOtlv1PA8/1lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41643297"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="41643297"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:12 -0800
X-CSE-ConnectionGUID: J1r8tzPuQwyzYASWuf08GA==
X-CSE-MsgGUID: WKbxcoYcQEqnjW9C3DvJMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112015664"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:12 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Riana Tauro <riana.tauro@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v14 4/7] drm/xe/pmu: Extract xe_pmu_event_update()
Date: Tue, 21 Jan 2025 22:23:38 -0800
Message-ID: <20250122062341.1100173-5-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250122062341.1100173-1-lucas.demarchi@intel.com>
References: <20250122062341.1100173-1-lucas.demarchi@intel.com>
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
index bd2d709453257..5a93634f17a2b 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -125,18 +125,11 @@ static u64 __xe_pmu_event_read(struct perf_event *event)
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
@@ -145,6 +138,19 @@ static void xe_pmu_event_read(struct perf_event *event)
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
@@ -174,7 +180,7 @@ static void xe_pmu_event_stop(struct perf_event *event, int flags)
 
 	if (pmu->registered)
 		if (flags & PERF_EF_UPDATE)
-			xe_pmu_event_read(event);
+			xe_pmu_event_update(event);
 
 	event->hw.state = PERF_HES_STOPPED;
 }
-- 
2.48.0

