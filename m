Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463C016C6B4;
	Wed, 12 Jun 2024 07:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179162; cv=none; b=oWKHRDT2+xKmM7ZEZ9tm87wlpVaEqqHakwdiFq3JACEyWy7iHrLZGK9g5fvKdrYNoqxSKFCbsNmBleetE+uT1sPtnmJSu35Z4BPt3CpR8hpIDH5rug9xjBz0RCD61InChWaysUwvxZzV1N9qeGStlo03QuoHVi4Kb4sKec2lZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179162; c=relaxed/simple;
	bh=7mTgNg2ikwIKft8i7UAtYj8u3wE6XKrlCmTmjGuHvTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGtD+78+s38fEheRu2M97+XvwDMaaRLcnKnSzXPEnHW0YNOHWIgDggMcQX5gMkH3LU5TEoCy8M6zYjFetS3aRouMCnJEsjPuT4gFQV4RaXugNZYL+1Nmkf78nxgyENiCW2zPsf/QfhkUR5lxGANvnY586fYSwBLeKqn/JoI1V/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnbv1Ed3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnbv1Ed3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718179162; x=1749715162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mTgNg2ikwIKft8i7UAtYj8u3wE6XKrlCmTmjGuHvTY=;
  b=hnbv1Ed3Frzy/NGL6TTNKqdNzpwQH9I6n9rfrzqOKmksSL9dydSrzDbu
   r80W/cEEum3g4wWS3xCnNq31hbm3ZxgA2uBJH71T+uzfkxYq3hZvtAaAY
   rhuM2BT8Ya+4LKog3JGiZHGl+K9pDQdVoBwhQzYSyyUwSbSiIl4bfeJKd
   1Hp5pp4KWpNn9X9IrgZEDvu3ctoQyW+nnQIzFvAhUZnFzVb336kvVLR7A
   uMtuYbGmDQyZgtMlmDWFmOY83U5yC15IN0IbZGiiuc16l8Mr6UxEncHrd
   fiJEUpOGejiNtmCv6B9WZXv1yv20ezoYsOzdU+r2RXuU/qhOrk/Zb5DBp
   Q==;
X-CSE-ConnectionGUID: VOCIsYWeRE6kPuRGFEPBsQ==
X-CSE-MsgGUID: CgSWh2oYTKycgpG6+h+jLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14768825"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="14768825"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 00:59:21 -0700
X-CSE-ConnectionGUID: 5bFV976PRICls1WKE1o/UQ==
X-CSE-MsgGUID: TVfmcDRRRV6XTDc3W17Fsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39597596"
Received: from zwan2-desk1.sh.intel.com ([10.239.160.154])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 00:59:18 -0700
From: Zhenyu Wang <zhenyuw@linux.intel.com>
To: peterz@infradead.org
Cc: kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	Rui Zhang <rui.zhang@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>,
	Wendy Wang <wendy.wang@intel.com>
Subject: [PATCH RESEND AGAIN] perf/x86/intel/cstate: Add pkg C2 residency counter for Sierra Forest
Date: Wed, 12 Jun 2024 16:08:35 +0800
Message-ID: <20240612080835.306254-1-zhenyuw@linux.intel.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240515032158.12845-1-zhenyuw@linux.intel.com>
References: <20240515032158.12845-1-zhenyuw@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Package C2 residency counter is also available on Sierra Forest.
So add it support in srf_cstates.

Cc: Rui Zhang <rui.zhang@intel.com>
Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
Cc: Wendy Wang <wendy.wang@intel.com>
Tested-by: Wendy Wang <wendy.wang@intel.com>
Fixes: 3877d55a0db2 ("perf/x86/intel/cstate: Add Sierra Forest support")
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9d6e8f13d13a..b1a822af25d0 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -64,7 +64,7 @@
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL
+ *						RPL,SPR,MTL,SRF
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -684,7 +684,8 @@ static const struct cstate_model srf_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
 
-	.pkg_events		= BIT(PERF_CSTATE_PKG_C6_RES),
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES),
 
 	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
 };
-- 
2.45.1

