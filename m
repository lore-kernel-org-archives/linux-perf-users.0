Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203FA3C2F;
	Wed, 15 May 2024 03:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715742798; cv=none; b=Qy8zTuxSThhuTfwLeFiVVKB9Aj+7K/Wl6YsxN0+C9wamiAeArdxgM/2d/DOTxGvk7faE/hNvOXAr+ISKgpMjeokg0rlq6Cr/j9/t/z0CbD5JCkbQjuLAyJAZExuaZfpSbnZbMkNgjpUyPqbgjNBrsB5Tn21mx9EcdTlYCtE+gcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715742798; c=relaxed/simple;
	bh=uB9Hl02KjTkQ8kSDlHRuvYVYzS140KUlSV2TwxcCTHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2cZIbdvQiuGmrMY3cahiJ4mDV395E70yWn207ZQxI9IfkzXkF7imQDCyUt8gN++Dih9Lzj5DvrSssyw9xLAitf+JXtrwR/PF9dQGuLfeY+jdBYozSQXgFxOBc7Pa22qSbSzITTcGzy3WQ/9FEaaApvgr2UqmqzrancpznYYQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fL/D/gND; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fL/D/gND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715742797; x=1747278797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uB9Hl02KjTkQ8kSDlHRuvYVYzS140KUlSV2TwxcCTHM=;
  b=fL/D/gNDmASB7QBYhTWvp9841ovn9ijEB751AO6DbExI0yScAIHm4dcd
   jXkN7a0EnKLqShNcV0KylRJys6LYVey6kDW+5fv8qOdRojklbWGpZmcrm
   jkKKj6ifPnD1T8cn4Mg3P7ZIQPZO0fFqkXrJn6G3sk8APagRoz7JUa9Nf
   rHvlfVAOuR73On2y0SH4x+d5e0yHTpT7UGRirX9CUEmECiweb76F6ZCSb
   9g1vRcabXQb8cbKIfE4YPLH53BSl2BMMOQwOaTFUinCT8G5hNu4iDE05r
   OPR6/2bG8qYWZMMAxGZVpEH9NPqHNSf4IPNTMh8GSmhbrxz4cua3cTssH
   g==;
X-CSE-ConnectionGUID: DqM7hr9FSeKAgVS/0zmFlA==
X-CSE-MsgGUID: jElZ4QA2R/a41a+ggQAEkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="14713386"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="14713386"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 20:13:16 -0700
X-CSE-ConnectionGUID: 1Vaphy8DTH2zttEv04+Nig==
X-CSE-MsgGUID: b75J+r8tT2qY1V7p85kAqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="35434310"
Received: from zwan2-desk1.sh.intel.com ([10.239.160.154])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 20:13:14 -0700
From: Zhenyu Wang <zhenyuw@linux.intel.com>
To: peterz@infradead.org
Cc: kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	Rui Zhang <rui.zhang@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>,
	Wendy Wang <wendy.wang@intel.com>
Subject: [PATCH RESEND] perf/x86/intel/cstate: Add pkg C2 residency counter for Sierra Forest
Date: Wed, 15 May 2024 11:21:58 +0800
Message-ID: <20240515032158.12845-1-zhenyuw@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506084806.495816-1-zhenyuw@linux.intel.com>
References: <20240506084806.495816-1-zhenyuw@linux.intel.com>
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
Fixes: 3877d55a0db2 ("perf/x86/intel/cstate: Add Sierra Forest support")
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index e64eaa8dda5a..4cd36848cfff 100644
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
@@ -683,7 +683,8 @@ static const struct cstate_model srf_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
 
-	.pkg_events		= BIT(PERF_CSTATE_PKG_C6_RES),
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES),
 
 	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
 };
-- 
2.43.0

