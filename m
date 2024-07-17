Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9693FC2;
	Wed, 17 Jul 2024 03:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721185555; cv=none; b=n0hmbUYXXVjqx1DftvYpccmea+K3cYulT2L9xsZnzOYmoz/qpovImcT6CSybU6glsYlZUloGRanvBH+4neH8SPBCLXn+6lh4TGcpwlbFy/fG0W50GXkWe/ikwBSJelB7U64tNlw++9FNSKTWKXj1iMaRJZQlPGH0RmMz24yd6+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721185555; c=relaxed/simple;
	bh=9NoW33mh+d8YaC8dEoxI4Vym0hFzmHwnGm1KaKrF700=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGYe+tW0uk1nod/4urtcOTUjQ78kmfTHKzfCY9ROz9M8oaHttL/JYvxtJ7Avvbz/ybstcnWGO/92NkOQ8KWmYC1wzF32CCm/kC9zUPtPGDkZIabg9RSoMQiIzkhMa8/RNOVzHoalYzHguxSmfm1R6NbeYPrBTZeTJ6mlc7Fz6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7Zo21CV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7Zo21CV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721185552; x=1752721552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NoW33mh+d8YaC8dEoxI4Vym0hFzmHwnGm1KaKrF700=;
  b=c7Zo21CVxyhPPNOfhIAxQ8RZOS6KGVQhtfelaYs9O32uY/sJZ6nNjfko
   Sk/dzqmpTwQmaXB7Zgp5dMyVSZGs4PREn5lJXiHWTeJMWgyu4ozXjsm0B
   Kc8k24SuDwG008ifoNUSplaKXsTkbLtr4I5kPM52KZiEkKuHMPKccmXg/
   Jxe8wZbtrd8L0v+8oJKZj9Y4Y2huLuC5uD/RXb1LaKRLFH+oY/C66xG+b
   EVgViBECeJJWDWfgkFxlWyPAlZ4kNJdRvl33vEmdG41CQGCv7+vttgGLL
   fiQLGRahoDhgNQcGw+XcEz5dYY1ZfkxmjhrbHAYie71APZ82+Cgo6k/ED
   w==;
X-CSE-ConnectionGUID: QojCVdjjRHKsccbaEw0cbQ==
X-CSE-MsgGUID: lspDJ41PT5mW1Npm8wcdQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18799487"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="18799487"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 20:05:51 -0700
X-CSE-ConnectionGUID: aFLDhRiAT52TgN5JrHPEaQ==
X-CSE-MsgGUID: I09aUZLrTsCRcks5sjldHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; 
   d="scan'208";a="81279698"
Received: from zwan2-desk1.sh.intel.com ([10.239.160.154])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 20:05:51 -0700
From: Zhenyu Wang <zhenyuw@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	Rui Zhang <rui.zhang@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>,
	Wendy Wang <wendy.wang@intel.com>
Subject: [PATCH tip rebase] perf/x86/intel/cstate: Add pkg C2 residency counter for Sierra Forest
Date: Wed, 17 Jul 2024 11:16:09 +0800
Message-ID: <20240717031609.74513-1-zhenyuw@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612080835.306254-1-zhenyuw@linux.intel.com>
References: <20240612080835.306254-1-zhenyuw@linux.intel.com>
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

Hi, Peter

This refresh resolved conflicts in comment against current tip tree.
Please help to apply.

Thanks!

 arch/x86/events/intel/cstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index be58cfb012dd..9f116dfc4728 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -64,7 +64,7 @@
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
  *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
- *						RPL,SPR,MTL,ARL,LNL
+ *						RPL,SPR,MTL,ARL,LNL,SRF
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
@@ -693,7 +693,8 @@ static const struct cstate_model srf_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
 
-	.pkg_events		= BIT(PERF_CSTATE_PKG_C6_RES),
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES),
 
 	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
 };
-- 
2.45.2

