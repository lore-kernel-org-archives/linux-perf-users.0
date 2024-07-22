Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DE482CA;
	Mon, 22 Jul 2024 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682428; cv=none; b=tJr19YSioKAoswE7uBLoR//NUlgPcOKxikILWGLeZso9dJ4cefjdQkrY65ekGDDbOnE/RLeNYYJRAN6dMFbHjunA8O9HnvoH2pSoAgCkk6TQyDGdMzsIWdI6PO7m0JOOvicy4YcSbUpz6MYkZp1g3s5uMC04CroCj7UhT5D3QXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682428; c=relaxed/simple;
	bh=o4lTucE/YybaswT34FevEnarms9wVB2T0SXwubW+jOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDgvHYsALYclaKQQ2dsJpO6eNhuJ4y+z6y8VwdAb23BYDtCiDGIMMf+uinm3hDnHnhDTOMXyHa6b8Iqj0mEQY8g2D2T3WyM9npCSmrpwObwHriNWCSSuo5qYUbfjEMmRT5S4CtJ8I2YnHxrTB2G4u4+XTvxHAlYBNm0x6MIJ9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrT12hic; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrT12hic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721682427; x=1753218427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o4lTucE/YybaswT34FevEnarms9wVB2T0SXwubW+jOY=;
  b=mrT12hicbc4LJ4CkEArGq7+RjcSjSEQpGyOUlyCn/qQYGPcvGG+xV4qz
   YTakBmtQy8X5KcfiKukWCBBo0Zc7S6+9xJk46R0fiC/SGT+bqDYPaLvOm
   MCmhHiH4U3YNViufSlTPQe+EIOPI0DSZtTbQhN+JtUv8Y4JoFRDjeHpVj
   U1XQ0oPANs92cW9oqx1AFxkRMDWEyiI9hcAEqcRyHR+ZSroOszQjBj3Vl
   4HFsJObGRwsaValbiODHsyMOe5MCBic59ytfU3dB0dN4yeUNtqdYHFi+B
   sU5ujvJJdh+wNGMdVhaFyBAE9G2RTS2Q7AF67yv9KPbq8soaMSIY4pY2K
   Q==;
X-CSE-ConnectionGUID: eJscQsTRSNGvd4FJa0s7Yg==
X-CSE-MsgGUID: nixPIWkUR3yqVZlHsmJ2PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30428327"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30428327"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:03 -0700
X-CSE-ConnectionGUID: 2LXmSF7dQTaMagER66M4bw==
X-CSE-MsgGUID: WLvDDELxSzq0X9+MrTcTRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51653313"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:03 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: intel-gfx@lists.freedesktop.org,
	linux-perf-users@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 7/7] drm/i915/pmu: Do not set event_init to NULL
Date: Mon, 22 Jul 2024 14:06:48 -0700
Message-ID: <20240722210648.80892-8-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240722210648.80892-1-lucas.demarchi@intel.com>
References: <20240722210648.80892-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

event_init is not an optional function pointer from perf events. Now
that pmu unregister happens only when freeing i915, setting it to NULL
only protects other functions in i915. Replace that by checking
pmu->closed.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index df53a8fe53ec..c5738035bc2f 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -303,7 +303,7 @@ void i915_pmu_gt_parked(struct intel_gt *gt)
 {
 	struct i915_pmu *pmu = &gt->i915->pmu;
 
-	if (!pmu->base.event_init)
+	if (pmu->closed)
 		return;
 
 	spin_lock_irq(&pmu->lock);
@@ -325,7 +325,7 @@ void i915_pmu_gt_unparked(struct intel_gt *gt)
 {
 	struct i915_pmu *pmu = &gt->i915->pmu;
 
-	if (!pmu->base.event_init)
+	if (pmu->closed)
 		return;
 
 	spin_lock_irq(&pmu->lock);
@@ -1325,12 +1325,12 @@ void i915_pmu_register(struct drm_i915_private *i915)
 err_groups:
 	kfree(pmu->base.attr_groups);
 err_attr:
-	pmu->base.event_init = NULL;
 	free_event_attributes(pmu);
 err_name:
 	if (IS_DGFX(i915))
 		kfree(pmu->name);
 err:
+	pmu->closed = true;
 	drm_notice(&i915->drm, "Failed to register PMU!\n");
 }
 
@@ -1346,6 +1346,4 @@ void i915_pmu_unregister(struct drm_i915_private *i915)
 
 	hrtimer_cancel(&pmu->timer);
 	i915_pmu_unregister_cpuhp_state(pmu);
-
-	pmu->base.event_init = NULL;
 }
-- 
2.43.0

