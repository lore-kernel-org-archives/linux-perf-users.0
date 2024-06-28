Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F41CD11;
	Fri, 28 Jun 2024 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544703; cv=none; b=fgA01AX3RdI+8Gd2NqZIDTOl2WX9HhPY1sucu5f9jiL0qCq4z9fShboc+mt5Y/OAL9+pB+oAuW9P269bVnrqe/8Dxch1ZvvO+ChKJO5CjabDt67fJ7HHAk6Hn4phYy3uQW/8gfFbVc9DSA+LoADTxA6UoyZoVPvkTLLa8gDVkq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544703; c=relaxed/simple;
	bh=w/35ep+uVTTsn93FuGXEI3lZsG/uynj1UY/vr6O40/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bf9p5dfBwFWreRFgWEj0X9mhd0XAgsxcdzKGus/aP4PngW3EUtOupjbWlXcrBnReAjiCnhsmGwFqzd4W1HMYulHF+AnT2Ziss5MRb3oMYTxgW52ldluGMT37P0X0Hf4haZAgyAmb/xBlFFQguROXddsQG99JVgaXBZpKtc9aYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eal1MDRV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eal1MDRV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719544702; x=1751080702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w/35ep+uVTTsn93FuGXEI3lZsG/uynj1UY/vr6O40/M=;
  b=Eal1MDRVRotWlp+tShKfO8FTAVAFq+nU7YhQ9GkLT9HH3APGr2mnjylX
   a/fBVemFbUohnBaM9HgJFcEDwwI1cDLOHWDbQlcG6e7qZMmwbiZc/1n5T
   lYB6KMnm4mNQnjm6kmrrXmmtTgLuq5GTCEJePqR4OQC7EGWwcq54cX+yN
   gvTghxYmKy6bHWK3VbpdkAPGfos0unVhbK8KaJr5uJNsd37os5lNBJ562
   XeOcwCeWBB59itmmvC/1TH7CN814me4RadD5OxWVDIb2WZLohUJODpjMw
   /qxudnV3na69kUNpt4lmgZYRpJcB1Vf3IVjz0on5XMJEEbR2xl3rnq/Ih
   A==;
X-CSE-ConnectionGUID: 0aWqQ3C+RsC2ieeJkB2rAA==
X-CSE-MsgGUID: VJW+RBtLTniyy5NwWN13sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16669267"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16669267"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 20:18:20 -0700
X-CSE-ConnectionGUID: sorra+kLTmyWo10e98wi9w==
X-CSE-MsgGUID: Rz6KZnXNTCSUQAYGWt+6lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44657095"
Received: from lizhipe3-mobl1.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.171.174])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 20:18:12 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ak@linux.intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH V2 1/3] perf/x86/intel/cstate: Fix Alderlake/Raptorlake/Meteorlake
Date: Fri, 28 Jun 2024 11:17:56 +0800
Message-Id: <20240628031758.43103-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628031758.43103-1-rui.zhang@intel.com>
References: <20240628031758.43103-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For Alderlake, the spec changes after the patch submitted and PC7/PC9
are removed.

Raptorlake and Meteorlake, which copy the Alderlake cstate PMU, also
don't have PC7/PC9.

Remove PC7/PC9 support for Alderlake/Raptorlake/Meteorlake.

Fixes: d0ca946bcf84 ("perf/x86/cstate: Add Alder Lake CPU support")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9d6e8f13d13a..dd1832055891 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -81,7 +81,7 @@
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML,ICL,TGL,RKL,ADL,RPL,MTL
+ *						KBL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
@@ -90,8 +90,7 @@
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL,RPL,MTL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
@@ -637,9 +636,7 @@ static const struct cstate_model adl_cstates __initconst = {
 	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
 				  BIT(PERF_CSTATE_PKG_C3_RES) |
 				  BIT(PERF_CSTATE_PKG_C6_RES) |
-				  BIT(PERF_CSTATE_PKG_C7_RES) |
 				  BIT(PERF_CSTATE_PKG_C8_RES) |
-				  BIT(PERF_CSTATE_PKG_C9_RES) |
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
-- 
2.34.1

