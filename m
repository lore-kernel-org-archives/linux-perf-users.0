Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C103CF74;
	Mon, 22 Jul 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682426; cv=none; b=LGxxq2z96fj5fSBLsoGD/w22o+9BMoAHd21MD2GgkIqZeuuB4FYG/V1dE8srEPsRFLFZyqHOGn414Lj/DCamFB1PuZTOs9mwiPpmV2mcqNREdy+BBbq2iEO/eHCRLAURflOTmXWFCxoqeTIMO5yYsUP+tie6ydCr7CEg5Xrwmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682426; c=relaxed/simple;
	bh=nCWirGS4RNaVcvVR02+jAYuMtNUcmS9KoGdmjQU7cuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XI6PWDx9/gbWoJUKqX+kpGnWhDuPNTbLsLV1MWuZB0iZ+jyDkQ9OlWlCKMiOXtzdL0mRoKghdcaeI//4e3JaaT79hWptpAs03d+fa6VTX4Yk/Fv5ZklKDCRhj0bP8dQQjgZ1NopKlAw817unlC4z0rjEnhlXBFp0gi1TQw4SBiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JE/8Y2Ta; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JE/8Y2Ta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721682425; x=1753218425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nCWirGS4RNaVcvVR02+jAYuMtNUcmS9KoGdmjQU7cuo=;
  b=JE/8Y2TaX55RbQr67XWHERmYv3aC9GhitZGGr1n6IsDTIzgR7WUZx1ij
   TswTYr+8R8zJQ8+yW8VtFLXySOgqEyUyUpSugPaSc3+8UqX5WghkUiEEX
   fW0UYGbW1ocANdYhj/bh3UtqJv9E43V/SwAek7/xDOz09kSAFbs43eDLy
   dQQJfeMqAoPqWLj3xSF+lZDgdIOqfe6eYw8ymm6ueehmyx+d1B7ayBO9t
   zhxaMcPZJ7Zi1I3WFeNRX+xl4hysZyKVn4kOKzT08+eX9XqKXDg1gqUbg
   LAI9+CYZiSndB6CR/B15Ms2bxuvbepEC39uKdSBrBDUAh1arSJjsPUxQn
   w==;
X-CSE-ConnectionGUID: DlVdG2wjSjGeEk6Wi5mdMw==
X-CSE-MsgGUID: 738kvOXWQPqUcm7Zkn+ryw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="30428307"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="30428307"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:02 -0700
X-CSE-ConnectionGUID: krU/uHwVR3O9O5JSh/ylmA==
X-CSE-MsgGUID: DMCosN1SRa24cuA9dxzvYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="51653296"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 14:07:01 -0700
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
Subject: [PATCH 4/7] drm/i915/pmu: Drop is_igp()
Date: Mon, 22 Jul 2024 14:06:45 -0700
Message-ID: <20240722210648.80892-5-lucas.demarchi@intel.com>
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

There's no reason to hardcode checking for integrated graphics on a
specific pci slot. That information is already available per platform an
can be checked with IS_DGFX().

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/i915/i915_pmu.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 3a8bd11b87e7..b5d14dd318e4 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -1235,17 +1235,6 @@ static void i915_pmu_unregister_cpuhp_state(struct i915_pmu *pmu)
 	cpuhp_state_remove_instance(cpuhp_slot, &pmu->cpuhp.node);
 }
 
-static bool is_igp(struct drm_i915_private *i915)
-{
-	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
-
-	/* IGP is 0000:00:02.0 */
-	return pci_domain_nr(pdev->bus) == 0 &&
-	       pdev->bus->number == 0 &&
-	       PCI_SLOT(pdev->devfn) == 2 &&
-	       PCI_FUNC(pdev->devfn) == 0;
-}
-
 void i915_pmu_register(struct drm_i915_private *i915)
 {
 	struct i915_pmu *pmu = &i915->pmu;
@@ -1269,7 +1258,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	pmu->cpuhp.cpu = -1;
 	init_rc6(pmu);
 
-	if (!is_igp(i915)) {
+	if (IS_DGFX(i915)) {
 		pmu->name = kasprintf(GFP_KERNEL,
 				      "i915_%s",
 				      dev_name(i915->drm.dev));
@@ -1323,7 +1312,7 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	pmu->base.event_init = NULL;
 	free_event_attributes(pmu);
 err_name:
-	if (!is_igp(i915))
+	if (IS_DGFX(i915))
 		kfree(pmu->name);
 err:
 	drm_notice(&i915->drm, "Failed to register PMU!\n");
@@ -1351,7 +1340,7 @@ void i915_pmu_unregister(struct drm_i915_private *i915)
 	perf_pmu_unregister(&pmu->base);
 	pmu->base.event_init = NULL;
 	kfree(pmu->base.attr_groups);
-	if (!is_igp(i915))
+	if (IS_DGFX(i915))
 		kfree(pmu->name);
 	free_event_attributes(pmu);
 }
-- 
2.43.0

