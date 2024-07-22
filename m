Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9F3EA69;
	Mon, 22 Jul 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682427; cv=none; b=lTbNnQXgBzqYa6yPP/9swwFYlrK/gmH+bB4CrcT7SdyH56FF8G7pS/yV2GFJca5Ie9YaUJ92kuJtCK4Sxy6WHRMjwRe/5NF+kEVBdtkNpefvy9oAvHk1QFRD6xmBmVSeP1GL9qHiJnor9+kOX8ehHfuPgW1BrixtXfWIbeUeeYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682427; c=relaxed/simple;
	bh=s/KEULd10DAnPOptOFmXVIG1knuSR32VEkwPLEise+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLsgu3GgCXRVjkUXykgL81EadMZMXEZukfDucgIzl7G3SjGG1uyDz1CMx8YMAfWoBqhxPDSsNt+2xoEovh65MZ65NGTHbg2Zsm0mQqi8Ckza8pq4yewMPtP0FwWM2WpnVW5VHz8Psdn6ehAmNAbe3IkTz4VzqPK0PmlzWohiCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdWnxbrY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdWnxbrY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721682425; x=1753218425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s/KEULd10DAnPOptOFmXVIG1knuSR32VEkwPLEise+Y=;
  b=LdWnxbrYMV8dmnFPNv5VaoBXNbRv1Z7kSxoTebZEuvYva3MTNZLKvYtO
   VoTMfi4YFYXXBF8VjBx/JlhXluGXJqN1oy+ovOnEBi4BKyC4OksZ8ISvB
   2Ipw0QmsubaRj+YmD9KPMShRxp2JWvqpqr549kP049Ff2bZf5JUMD+uuC
   uSjN/NjRuB45TMQQxkBlVAqvRU9OBLxbKIZwZRGui2mULTb6BM4gAPECX
   1GsoLlaLSKtwaTqPrDkmD0cs2yWOyZFOwD5/c2mwfntKC3mBrwVyr7HyJ
   I3hL8aXPGLh6C/DGqjc7MRM08P75ms6qykih/bgjMRdpb2s9EBZATyMLI
   A==;
X-CSE-ConnectionGUID: /fGLW44oTC68YBZgToW55w==
X-CSE-MsgGUID: WfQWsH9+SRa4pgnSuoNN6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30428315"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30428315"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:02 -0700
X-CSE-ConnectionGUID: oco+0Mr7Qq21jwMdRCTvSg==
X-CSE-MsgGUID: YFa/qX3XQcKBR01IvlORGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51653301"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:02 -0700
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
Subject: [PATCH 5/7] drm/i915/pmu: Let resource survive unbind
Date: Mon, 22 Jul 2024 14:06:46 -0700
Message-ID: <20240722210648.80892-6-lucas.demarchi@intel.com>
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

There's no need to free the resources during unbind. Since perf events
may still access them due to open events, it's safer to free them when
dropping the last i915 reference.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index b5d14dd318e4..8708f905f4f4 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/pm_runtime.h>
+#include <drm/drm_managed.h>
 
 #include "gt/intel_engine.h"
 #include "gt/intel_engine_pm.h"
@@ -1152,6 +1153,17 @@ static void free_event_attributes(struct i915_pmu *pmu)
 	pmu->pmu_attr = NULL;
 }
 
+static void free_pmu(struct drm_device *dev, void *res)
+{
+	struct i915_pmu *pmu = res;
+	struct drm_i915_private *i915 = pmu_to_i915(pmu);
+
+	free_event_attributes(pmu);
+	kfree(pmu->base.attr_groups);
+	if (IS_DGFX(i915))
+		kfree(pmu->name);
+}
+
 static int i915_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
 {
 	struct i915_pmu *pmu = hlist_entry_safe(node, typeof(*pmu), cpuhp.node);
@@ -1302,6 +1314,9 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	if (ret)
 		goto err_unreg;
 
+	if (drmm_add_action_or_reset(&i915->drm, free_pmu, pmu))
+		goto err_unreg;
+
 	return;
 
 err_unreg:
@@ -1336,11 +1351,7 @@ void i915_pmu_unregister(struct drm_i915_private *i915)
 	hrtimer_cancel(&pmu->timer);
 
 	i915_pmu_unregister_cpuhp_state(pmu);
-
 	perf_pmu_unregister(&pmu->base);
+
 	pmu->base.event_init = NULL;
-	kfree(pmu->base.attr_groups);
-	if (IS_DGFX(i915))
-		kfree(pmu->name);
-	free_event_attributes(pmu);
 }
-- 
2.43.0

