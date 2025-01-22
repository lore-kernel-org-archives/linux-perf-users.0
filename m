Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C91BD032
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 06:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737527059; cv=none; b=QghP5G26x9DNsoJPK0TtnXzegBUiRBsQHCuFh17H+SNKCqMbWbnyHyuVyWDijWn+zPjSS6v3y5fnZ4CU4TIBb1sr3YWGIEHRqJBA0S3RSESPQWpx/LA41GMOazX0G/8h137EC4WTIkZI+SlyhXV2+eYF7UYwIdHQHypQP4f/4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737527059; c=relaxed/simple;
	bh=APLxJX1II8MNQN4qAv3ScOoDkE5OxD+XykO+oIUFz4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoJ1DM6Z9a95SMaYPcxwnJ3JOUc7VBecPcajW6PyW+KnPujPJ/UcsxQ6jh91hyydCvHEr7/xsNsH5MMYlPnzXafYJRrYzjA7AsPv6QzhXjhXIXT1dXkeTWUAevqIThWVOPfdFsavbcr5d67KCY1edPOwTTuG87IrigU3cBsTuJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/Kj+zOy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/Kj+zOy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737527057; x=1769063057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=APLxJX1II8MNQN4qAv3ScOoDkE5OxD+XykO+oIUFz4Y=;
  b=P/Kj+zOygg2GuIAcg0V7L/0O4NfL876aU8aSiaN/uVMkukUXst37Lgys
   5yThmNmSp5Cg8g9PocJehJb3fjt48I8jbp6GVgSgCHbGsRcRV9tWKqSX5
   sPG0iQwKGrT2DPYRNfJNZix/qt2OAMl4e8O/VsldICGvozMVt9B/uyWDQ
   trZLzRAaXEeM4D9lJSqcj0yC+a3D4OlAv0U9/YxPKKTraXGbIV//XfqjX
   nwuSk+WXnmjmtgYknsCdYX9FXKRXE+kaUgGH2/98xr4WVaRTKfoE6Jig2
   U2lfT5/vKNsQ+ZcpvH6Qu3Py4/3QXVTmI1sm1rag8ulYh8LYjQgxodWEn
   w==;
X-CSE-ConnectionGUID: fYe2N1ufTTOzSNJrtLq3Fg==
X-CSE-MsgGUID: y+4jlP+nRKS8JVoi2em1fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="41643308"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="41643308"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 22:24:12 -0800
X-CSE-ConnectionGUID: /L/a37S0TsO9P+wZ7Ber0Q==
X-CSE-MsgGUID: SsTqBLhyTHi1xeeQuAaSKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112015673"
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
Subject: [PATCH v14 6/7] drm/xe/pmu: Get/put runtime pm on event init
Date: Tue, 21 Jan 2025 22:23:40 -0800
Message-ID: <20250122062341.1100173-7-lucas.demarchi@intel.com>
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

When the event is created, make sure runtime pm is taken and later put:
in order to read an event counter the GPU needs to remain accessible and
doing a get/put during perf's read is not possible it's holding a
raw_spinlock.

Suggested-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index 68ebec1746a53..8d938d67c1f2c 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -79,6 +79,7 @@ static void xe_pmu_event_destroy(struct perf_event *event)
 	struct xe_device *xe = container_of(event->pmu, typeof(*xe), pmu.base);
 
 	drm_WARN_ON(&xe->drm, event->parent);
+	xe_pm_runtime_put(xe);
 	drm_dev_put(&xe->drm);
 }
 
@@ -111,6 +112,7 @@ static int xe_pmu_event_init(struct perf_event *event)
 
 	if (!event->parent) {
 		drm_dev_get(&xe->drm);
+		xe_pm_runtime_get(xe);
 		event->destroy = xe_pmu_event_destroy;
 	}
 
-- 
2.48.0

