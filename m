Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA4D42052;
	Mon,  6 May 2024 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984825; cv=none; b=WS/Z/9oP7w56K5uM0XGhlHXuMm8zqv7Fj8KbHqcVPJmcdtisIxC2jKDEKQNigIZr8EMJ6xHfxjnAYWLzAAUuKkN4wELFKDQ52ItR/Fb36aK6LukrrlEABYPytLbg8a/OCSVltNHN62CqlgqkLG/1TKBOvpkokkA6qvQbCBG6NTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984825; c=relaxed/simple;
	bh=IJfokw2N7A5py7k8ePC8gToDa+6No8AkVv40u96rl0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WtPMYClhr1GB3titST2PluY4nVUV19mhGgq6uVU11oYFVfpYLZxGDCG9HtgRKR0zkzDACoiOVYnupxm4/pkxezXrUjWrUocNz+3WQZ8vLPjAaTTcmuEwfYvva+Ps56aFQiIR+nOuMYik+W0HCOoAtq2bx4hgSGdnsgxKjVTDuk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K04aJ6ld; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K04aJ6ld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714984824; x=1746520824;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IJfokw2N7A5py7k8ePC8gToDa+6No8AkVv40u96rl0U=;
  b=K04aJ6ld41uVsmR3Esi0y6TqzM7C6JfAuiKaHSnk5f8xyWBZtPjdY+nR
   UIybn3btWd6KvtkYQG6oNx9Ysgi5gGAbleXtCOWIPmphR9RooTwMLEI76
   10E/bwmQR02Q7+WgBpiiunIyiJAJIx2i394zOvk7LQ2MY4KnkWmFtg3Pl
   xpN1Jjc+KfrWnqp68VnTy/7FS6d0VntLPEx62wEKky6kkgr/349bSxTrA
   smMbZSN+yGMtLujoAs8YG8GykYgslPzZ13Jcsj/VobE761JwicMrMu94t
   aXFUN7D7EOBfUVaO3Wsi0vkpLQu4npPVrTBPc6LUOi49lixfQISjiJrRj
   A==;
X-CSE-ConnectionGUID: 6ZfepsbERpir6OrjInoF6w==
X-CSE-MsgGUID: pfU8bws0TfifXgWD2VIfig==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10562711"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10562711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:40:23 -0700
X-CSE-ConnectionGUID: bBKWrYWJRkaIUPF8fPgWdA==
X-CSE-MsgGUID: 6R2UT/2ARYKIXMmUR2xudg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32604461"
Received: from zwan2-desk1.sh.intel.com ([10.239.160.154])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:40:21 -0700
From: Zhenyu Wang <zhenyuw@linux.intel.com>
To: peterz@infradead.org
Cc: kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Rui Zhang <rui.zhang@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@intel.com>,
	Wendy Wang <wendy.wang@intel.com>
Subject: [PATCH] perf/x86/intel/cstate: Add pkg C2 residency counter for Sierra Forest
Date: Mon,  6 May 2024 16:48:06 +0800
Message-ID: <20240506084806.495816-1-zhenyuw@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
index 08bba679678c..cdf44500783e 100644
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
@@ -689,7 +689,8 @@ static const struct cstate_model srf_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
 
-	.pkg_events		= BIT(PERF_CSTATE_PKG_C6_RES),
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES),
 
 	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
 };
-- 
2.43.0

