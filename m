Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76D25A35A;
	Thu,  3 Jul 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561823; cv=none; b=D84Ck2xLgXiQ5C964Pq7nIAMNDPZFg8B6jSqa1zXd6iXvd9OwmC62CKdFolPpZPY/rLHHcY4NBCVfMbgfd6FPyjLRrbgpSCOldy0F/prZVN/S48lGbqokmHSwdtPk+yCUaHwi4+5Im3HfJPmmWBK0N8f51NeUoeEFLoseS2rUUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561823; c=relaxed/simple;
	bh=pOUkHTeSo9LMNRHv1Rw3zA1/OZeSTDnWdy8XZfiuXyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MShTdoWgWz5Lr5/nhsCLqwhyNuEiMi4GXtgb90+175KBHEBkPh9+1L9IEtkC4lmwOYpscolhvq+cV+17eJP7G2jWHNUOv9XBuDZdoL0GpDXzJ10dir3kxhGFtvOccDw7evz9SCrVMALULq4+T1QKiIoxMDbAvOnP/1OLJ7OZc6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OvFiMj41; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OvFiMj41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751561822; x=1783097822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pOUkHTeSo9LMNRHv1Rw3zA1/OZeSTDnWdy8XZfiuXyg=;
  b=OvFiMj419M2sJ/Xw0nEO5bVtykVcjxB9tBEPdfnoDpBx4QhJywjNgt3j
   9G5BVpZJJS85PqoYMPzQRZ+5FGh3RWTpQAvBejoIV5AnywRMLRa8FyHBA
   kE4LS3sO2eR5gBhXK40cyo68FL2ZUJ/LyIKUuktIyhTP2J0jfHZJord8b
   e/lSswl3qniY6AfKcINjhbfeX7b3shBQ/KYZf7D5qgyC/GRaL4RuzIcIG
   kduq3derLUzBC9PVGYbT/qY/tNo7nJ8+jTH6UI1qgE6UuPALnxz82W0Hf
   8o/RhLs/hyyMa5WVQiYiejHvR1eMTjVCnjsSBA4u8M2FYbaUIq4BL1IOG
   Q==;
X-CSE-ConnectionGUID: 5tlyAtjnQySjmdKpJXOd2g==
X-CSE-MsgGUID: QcvumkLASoeylKMER2HmHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53992528"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53992528"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 09:56:54 -0700
X-CSE-ConnectionGUID: jgZ1Ay3rSjSPCNSenZGIwg==
X-CSE-MsgGUID: fiICh+k+T2i3M4eE289VHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154554264"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 03 Jul 2025 09:56:54 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 4/4] perf/x86/intel/uncore: Add iMC freerunning for Panther Lake
Date: Thu,  3 Jul 2025 09:56:14 -0700
Message-Id: <20250703165614.606446-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250703165614.606446-1-kan.liang@linux.intel.com>
References: <20250703165614.606446-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

PTL uncore imc freerunning counters are the same as the previous HW.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 817dddc1454d..a8c4afc9cdff 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -1905,9 +1905,17 @@ static struct intel_uncore_type *ptl_uncores[UNCORE_PTL_MAX_NUM_UNCORE_TYPES] =
 	[UNCORE_PTL_TYPE_HBO] = &ptl_uncore_hbo,
 };
 
+#define UNCORE_PTL_MMIO_EXTRA_UNCORES		1
+
+static struct intel_uncore_type *ptl_mmio_extra_uncores[UNCORE_PTL_MMIO_EXTRA_UNCORES] = {
+	&adl_uncore_imc_free_running,
+};
+
 void ptl_uncore_mmio_init(void)
 {
-	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
+	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO,
+						 UNCORE_PTL_MMIO_EXTRA_UNCORES,
+						 ptl_mmio_extra_uncores,
 						 UNCORE_PTL_MAX_NUM_UNCORE_TYPES,
 						 ptl_uncores);
 }
-- 
2.38.1

