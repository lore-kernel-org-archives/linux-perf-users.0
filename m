Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F713AD3F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737605994; cv=none; b=t/+SyF8r9NAdLo25+eWuyLn5th+3GWWDfbUYZ+ta0CeBU07AY0Q+Jg0+/+1WXHF5PC9y2ZWNxZ7YZfA1cGZ0JPoBtrwVi7PuzMDBVZ5sOxkg5fecCDcd9xtDH7p0TOVXPVVm+7ZBJl4apqiQhlhmlcUcNU825xEbypozV+8RYIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737605994; c=relaxed/simple;
	bh=sU2zceit82BkL6W3a8LC3UYg5h23YrZLnJeaoynkC5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsGDLlqn3LpJSo3q+u3syNJ2ik4yTGXG5JWSbdUamwK+hCr28rw5toio73fD/2Nc7/5Yn24dGkYtswKuN79cpzJG3/UR+PMLVkluZ0k0qw+sdMxxF+wyx0ittyQ8AQJAukYeF/VO2jcMqp4o/nH/3pnE28uTwcgH89S+dOh3Tkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFfYzn/+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFfYzn/+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737605993; x=1769141993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sU2zceit82BkL6W3a8LC3UYg5h23YrZLnJeaoynkC5k=;
  b=kFfYzn/+wESjWekaLNOVJCroPW/mxAnxuam4RxHyHMQuXFyqJA5kigoO
   tAmzPZCoorwhbgjzm0TtXgwUBppbPQDW3Z/mpaTrZGoRZH1ny1AyIN52m
   P/PO81/TgFDh0/Sr+jzxPq3Oa9K8rAgp51wZbIUeRO7DGs97/PHFYR3Bf
   BJf6vZEe6PDwN5zqnBDtWFgeQvs8fPi7ARgCS+0Rh3rNuZOg8VnXxn+gB
   jOS2fE33JyUdhqRjo78HOkEK/boQpujl6uuMdDqKjBuN5X42RgQNCZr/V
   xRmr3JZiZKkZulh+cXenCtKVgGkLMO3BDmqhEWr0aN4fT5ZC7lmGkYk9/
   Q==;
X-CSE-ConnectionGUID: 6XFnonIKRqqbOdI0bqrveg==
X-CSE-MsgGUID: AR81uSRZT7q4U2WSm8ZEoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="37971644"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="37971644"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 20:19:48 -0800
X-CSE-ConnectionGUID: oQ7493TiSVOMxlqZiH6gSg==
X-CSE-MsgGUID: acXVC5u3Q+OYV4MnwGZUbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107202058"
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
Subject: [PATCH v15 2/6] drm/xe/pmu: Assert max gt
Date: Wed, 22 Jan 2025 20:19:19 -0800
Message-ID: <20250123041923.1892837-3-lucas.demarchi@intel.com>
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

XE_PMU_MAX_GT needs to be used due to a circular dependency, but we
should make sure it doesn't go out of sync with XE_PMU_MAX_GT. Add a
compile check for that.

Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pmu.c b/drivers/gpu/drm/xe/xe_pmu.c
index b3da3863928af..df93ba96bdc1e 100644
--- a/drivers/gpu/drm/xe/xe_pmu.c
+++ b/drivers/gpu/drm/xe/xe_pmu.c
@@ -249,6 +249,8 @@ int xe_pmu_register(struct xe_pmu *pmu)
 	int ret = -ENOMEM;
 	char *name;
 
+	BUILD_BUG_ON(XE_MAX_GT_PER_TILE != XE_PMU_MAX_GT);
+
 	if (IS_SRIOV_VF(xe))
 		return 0;
 
-- 
2.48.0

